import 'package:flutter/material.dart';

import '../../formula_engine/drag_to_move_cursor_stability_policy.dart';
import '../../formula_engine/editor_gesture_router_policy.dart';
import '../../formula_engine/existing_cursor_engine_reconciliation_policy.dart';
import '../../formula_engine/fraction_function_root_log_cursor_specialization_policy.dart';
import '../../formula_engine/integral_cursor_specialization_policy.dart';
import '../../formula_engine/native_slotbox_hit_test_policy.dart';
import '../../formula_engine/native_slotbox_input_surface_integration_policy.dart';
import '../../formula_engine/structural_intent_resolver_policy.dart';
import '../../formula_engine/slot_hit_testing.dart';
import '../../formula_engine/structural_cursor_release_hardening_policy.dart';
import '../../formula_engine/viewport_coordinate_transform.dart';
import '../../formula_engine/template_slot_navigation_policy.dart';
import '../../formula_engine/visible_renderer_policy.dart';
import '../editor_commands.dart';
import '../selection_controller.dart';
import '../slot_registry.dart';
import '../../../theme/mathpro_tokens.dart';
import 'editor_controller.dart';

enum EditorInteractionCoordinateSpace { canvasLocal, viewportLocal }

enum EditorTapSelectionTiming { tapDown, tapUp }

class EditorSlotSelection {
  const EditorSlotSelection({required this.slotId, required this.slotRole, required this.caretIndex, required this.source});

  final String slotId;
  final String slotRole;
  final int caretIndex;
  final String source;
}

class EditorInteractionLayer extends StatefulWidget {
  const EditorInteractionLayer({
    super.key,
    required this.snapshot,
    required this.onSlotSelected,
    this.expressionText = '',
    this.onTextCaretSelected,
    this.shouldSuppressTap,
    this.coordinateSpace = EditorInteractionCoordinateSpace.canvasLocal,
    this.canvasToViewportTransform,
    this.allowDragCaretUpdates = true,
    this.selectOnTapDown = true,
    this.selectOnTapUp = false,
    this.paintVisibleSlotOverlay = false,
  });

  final EditorSnapshot snapshot;
  final ValueChanged<EditorSlotSelection> onSlotSelected;
  final String expressionText;
  final ValueChanged<int>? onTextCaretSelected;
  final bool Function()? shouldSuppressTap;
  final EditorInteractionCoordinateSpace coordinateSpace;
  final Matrix4? canvasToViewportTransform;
  final bool allowDragCaretUpdates;

  /// V172-K: short expressions keep instant tap-down placement; long
  /// expressions use tap-up so an intended horizontal pan does not first
  /// jump the math cursor. No editor magnifier or long-press menu is introduced.
  final bool selectOnTapDown;
  final bool selectOnTapUp;

  /// V121: MathJax is the only visible editor math surface. This layer may
  /// still perform slot/caret hit testing, but it must not paint legacy focus
  /// rectangles or blinking carets over the WebView/SVG output unless a future
  /// renderer explicitly opts in with MathJax coordinate mapping.
  final bool paintVisibleSlotOverlay;

  @override
  State<EditorInteractionLayer> createState() => _EditorInteractionLayerState();
}

class _EditorInteractionLayerState extends State<EditorInteractionLayer> {
  EditorSlotSelection? _lastDragSlotSelection;
  Offset? _lastDragCanvasPoint;
  Rect? _lastDragSlotRect;
  int? _lastLinearDragCaretIndex;
  Offset? _lastLinearDragCanvasPoint;

  void _resetDragStabilityIfNeeded(String source) {
    if (!DragToMoveCursorStabilityPolicy.shouldResetForSource(source)) return;
    _lastDragSlotSelection = null;
    _lastDragCanvasPoint = null;
    _lastDragSlotRect = null;
    _lastLinearDragCaretIndex = null;
    _lastLinearDragCanvasPoint = null;
  }

  void _recordSlotDragState(EditorSlotSelection selection, Offset canvasPoint, Rect visualRect) {
    if (!DragToMoveCursorStabilityPolicy.isDragSource(selection.source)) return;
    _lastDragSlotSelection = selection;
    _lastDragCanvasPoint = canvasPoint;
    _lastDragSlotRect = visualRect;
  }

  void _recordLinearDragState(String source, int caretIndex, Offset canvasPoint) {
    if (!DragToMoveCursorStabilityPolicy.isDragSource(source)) return;
    _lastLinearDragCaretIndex = caretIndex;
    _lastLinearDragCanvasPoint = canvasPoint;
  }

  Offset _canvasPointFor(Offset localPosition) {
    final transform = widget.canvasToViewportTransform;
    if (widget.coordinateSpace == EditorInteractionCoordinateSpace.viewportLocal && transform != null) {
      return MathViewportCoordinateTransform.viewportToCanvas(viewportPoint: localPosition, transform: transform);
    }
    return localPosition;
  }


  void _handlePointer(
    Offset localPosition, {
    required NativeSlotBoxInputSurfaceFrame inputSurface,
    required bool canMoveLinearCaret,
    String source = 'pointer',
  }) {
    assert(source.isNotEmpty);
    _resetDragStabilityIfNeeded(source);
    if (widget.shouldSuppressTap?.call() ?? false) return;
    final canvasPoint = _canvasPointFor(localPosition);
    final geometryBundles = inputSurface.geometryBundles;
    if (inputSurface.shouldSuppressPointerSourceForPan(source)) return;
    final effectiveSlotRects = inputSurface.authorityVisualRects;
    final canShowSlotOverlay = inputSurface.structuralInteractionEnabled;
    final nativeSlotBoxHit = inputSurface.hitTest(canvasPoint);
    final primaryHit = nativeSlotBoxHit ??
        (NativeSlotBoxHitTestPolicy.canUseLegacyVisualHitTest(
          structuralInteractionEnabled: canShowSlotOverlay,
          geometryBundleCount: geometryBundles.length,
        )
            ? SlotHitTesting.hitTest(canvasPoint, effectiveSlotRects)
            : null);
    final reconciledHit = ExistingCursorEngineReconciliationPolicy.reconcileStructuralHit(
      point: canvasPoint,
      visualRects: effectiveSlotRects,
      primaryHit: primaryHit,
      structuralInteractionEnabled: canShowSlotOverlay,
    );
    final hit = StructuralIntentResolverPolicy.resolveIntent(
      point: canvasPoint,
      bundles: geometryBundles,
      primaryHit: reconciledHit,
      structuralInteractionEnabled: canShowSlotOverlay,
    );
    if (hit != null) {
      final rawCaret = StructuralCursorReleaseHardeningPolicy.chooseStructuralCaretIndex(
        visualRect: hit.visualRect,
        point: canvasPoint,
        role: hit.entry.role,
        rawChildCount: _slotLocalCaretExtent(hit.entry),
      );
      final caret = ExistingCursorEngineReconciliationPolicy.reconciledStructuralCaretIndex(
        payload: EditorCommands.selectedSlotPayload(widget.expressionText, activeSlotId: hit.entry.id),
        role: hit.entry.role,
        requestedCaretIndex: rawCaret,
      );
      final selection = EditorSlotSelection(
        slotId: hit.entry.id,
        slotRole: hit.entry.role,
        caretIndex: caret,
        source: DragToMoveCursorStabilityPolicy.isDragSource(source) ? source : hit.source,
      );
      if (DragToMoveCursorStabilityPolicy.shouldSuppressSlotDrag(
        source: selection.source,
        currentPoint: canvasPoint,
        currentSlotId: selection.slotId,
        currentRole: selection.slotRole,
        currentCaretIndex: selection.caretIndex,
        currentVisualRect: hit.visualRect,
        previousSlotId: _lastDragSlotSelection?.slotId,
        previousRole: _lastDragSlotSelection?.slotRole,
        previousCaretIndex: _lastDragSlotSelection?.caretIndex,
        previousPoint: _lastDragCanvasPoint,
        previousVisualRect: _lastDragSlotRect,
      )) {
        return;
      }
      _recordSlotDragState(selection, canvasPoint, hit.visualRect);
      widget.onSlotSelected(selection);
      return;
    }

    final placeholderFallback = inputSurface.legacyPlaceholderFallbackAllowed
        ? _linearPlaceholderFallback(canvasPoint, inputSurface.canvasSize)
        : null;
    if (placeholderFallback != null) {
      widget.onSlotSelected(placeholderFallback);
      return;
    }

    if (canMoveLinearCaret &&
        !inputSurface.shouldBlockDetachedLinearFallbackAt(canvasPoint) &&
        !StructuralIntentResolverPolicy.shouldSuppressLinearFallbackForTemplateRegion(
          point: canvasPoint,
          bundles: geometryBundles,
          structuralInteractionEnabled: canShowSlotOverlay,
        ) &&
        !IntegralCursorSpecializationPolicy.shouldSuppressLinearFallbackForIntegralRegion(
          point: canvasPoint,
          integralHitRects: geometryBundles.values
              .where((bundle) => IntegralCursorSpecializationPolicy.isIntegralRole(bundle.role))
              .map((bundle) => bundle.hitRect),
        ) &&
        !FractionFunctionRootLogCursorSpecializationPolicy.shouldSuppressLinearFallbackForCoreRegion(
          point: canvasPoint,
          coreHitRects: geometryBundles.values
              .where((bundle) => FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole(bundle.role))
              .map((bundle) => bundle.hitRect),
        ) &&
        !ExistingCursorEngineReconciliationPolicy.shouldSuppressLinearFallback(
          point: canvasPoint,
          visualRects: effectiveSlotRects,
          structuralInteractionEnabled: canShowSlotOverlay,
        )) {
      final caretIndex = MathProCaretController.closestLinearCaretIndex(
        expression: widget.expressionText,
        canvasSize: inputSurface.canvasSize,
        point: canvasPoint,
      );
      if (DragToMoveCursorStabilityPolicy.shouldSuppressLinearDrag(
        source: source,
        currentPoint: canvasPoint,
        currentCaretIndex: caretIndex,
        previousCaretIndex: _lastLinearDragCaretIndex,
        previousPoint: _lastLinearDragCanvasPoint,
      )) {
        return;
      }
      _recordLinearDragState(source, caretIndex, canvasPoint);
      widget.onTextCaretSelected?.call(caretIndex);
    }
  }

  int _slotLocalCaretExtent(SlotEntry entry) {
    final payload = EditorCommands.selectedSlotPayload(widget.expressionText, activeSlotId: entry.id);
    if (payload == null) return 1;
    final clean = payload.trim();
    if (clean.isEmpty || clean == '□') return 1;
    // V172-D: count visible runes instead of UTF-16 code units so superscript
    // and subscript glyphs keep stable cursor stops on Android. This still
    // stays deliberately conservative; full renderer-derived glyph bounds are
    // a later phase.
    return clean.runes.length.clamp(1, 32).toInt();
  }

  EditorSlotSelection? _linearPlaceholderFallback(Offset canvasPoint, Size size) {
    final placeholderIndexes = MathProCaretController.placeholderCaretIndexes(widget.expressionText);
    if (placeholderIndexes.isEmpty || widget.snapshot.registry.entries.isEmpty) return null;

    final positions = MathProCaretController.linearCaretPositionsForExpression(
      expression: widget.expressionText,
      canvasSize: size,
    );
    if (positions.length < 2) return null;

    final slots = TemplateSlotNavigationPolicy.orderedSlots(widget.snapshot.registry.entries);
    final usableCount = placeholderIndexes.length < slots.length ? placeholderIndexes.length : slots.length;
    if (usableCount <= 0) return null;

    var bestSlot = slots.first;
    var bestDistance = double.infinity;
    var bestCaret = 0;
    for (var index = 0; index < usableCount; index += 1) {
      final placeholderIndex = placeholderIndexes[index].clamp(0, positions.length - 2).toInt();
      final left = positions[placeholderIndex];
      final right = positions[placeholderIndex + 1];
      final centerX = (left + right) / 2;
      final dx = (canvasPoint.dx - centerX).abs();
      final dy = (canvasPoint.dy - MathProCaretController.inlineExpressionCenterY(size)).abs();
      // V61.1: slot intent should be dominated by X-position. Tiny visible
      // boxes are hard to hit on phones, and users tap close to the visual box
      // horizontally more reliably than vertically.
      final weightedDistance = dx + dy * 0.04;
      if (weightedDistance < bestDistance) {
        bestDistance = weightedDistance;
        bestSlot = slots[index];
        bestCaret = canvasPoint.dx <= centerX ? 0 : 1;
      }
    }

    final acceptance = (size.width * 0.20).clamp(76.0, 132.0).toDouble();
    if (bestDistance > acceptance) return null;
    return EditorSlotSelection(
      slotId: bestSlot.id,
      slotRole: bestSlot.role,
      caretIndex: bestCaret,
      source: 'slot-hit-linear-placeholder-fallback',
    );
  }

  @override
  Widget build(BuildContext context) {
    final rendererPolicyAllowsSlots = FormulaVisibleRendererPolicy.shouldShowSlotOverlay(widget.snapshot.structuralSnapshot);
    final canInteractWithSlots = ExistingCursorEngineReconciliationPolicy.slotInteractionEnabled(
      rendererPolicyAllowsSlots: rendererPolicyAllowsSlots,
      registry: widget.snapshot.registry,
      expression: widget.expressionText,
    );
    final canMoveLinearCaret = widget.onTextCaretSelected != null && widget.expressionText.trim().isNotEmpty;
    final paintVisibleSlotOverlay = widget.paintVisibleSlotOverlay;
    if (!canInteractWithSlots && !canMoveLinearCaret) {
      return const SizedBox.expand();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final inputSurface = NativeSlotBoxInputSurfaceIntegrationPolicy.buildFrame(
          expression: widget.expressionText,
          canvasSize: size,
          registry: widget.snapshot.registry,
          structuralInteractionEnabled: canInteractWithSlots,
        );
        final authoritySlotRects = inputSurface.authorityVisualRects;
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: widget.selectOnTapDown
              ? (details) => _handlePointer(
                    details.localPosition,
                    inputSurface: inputSurface,
                    canMoveLinearCaret: canMoveLinearCaret,
                    // V98 compatibility lock: source: 'tap-down'
                    source: EditorGestureRouterPolicy.tapDownSelectionSource,
                  )
              : null,
          // Contract marker for V172-K source tests: onTapUp: selectOnTapUp
          onTapUp: widget.selectOnTapUp
              ? (details) => _handlePointer(
                    details.localPosition,
                    inputSurface: inputSurface,
                    canMoveLinearCaret: canMoveLinearCaret,
                    source: EditorGestureRouterPolicy.tapUpSelectionSource,
                  )
              : null,
          // V172-K: tap-down remains instant for short expressions. In long
          // expressions, tap-up is used so InteractiveViewer can reserve drag
          // gestures for panning without an unwanted cursor jump.
          onPanDown: widget.allowDragCaretUpdates
              ? (details) => _handlePointer(
                    details.localPosition,
                    inputSurface: inputSurface,
                    canMoveLinearCaret: canMoveLinearCaret,
                    source: 'pan-down',
                  )
              : null,
          onPanUpdate: widget.allowDragCaretUpdates
              ? (details) => _handlePointer(
                    details.localPosition,
                    inputSurface: inputSurface,
                    canMoveLinearCaret: canMoveLinearCaret,
                    source: 'pan-update',
                  )
              : null,
          child: Stack(
            children: [
              if (paintVisibleSlotOverlay && canInteractWithSlots)
                for (final item in authoritySlotRects.entries)
                  if (item.key.id == widget.snapshot.interaction.activeSlotId)
                    _SlotBox(
                      rect: item.value,
                      caretIndex: widget.snapshot.interaction.caretIndex,
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _SlotBox extends StatelessWidget {
  const _SlotBox({required this.rect, required this.caretIndex});

  final Rect rect;
  final int caretIndex;

  @override
  Widget build(BuildContext context) {
    final visibleSize = _visibleFocusSize(rect.size);
    final caretRect = _caretRectWithin(visibleSize, caretIndex: caretIndex);

    return Positioned.fromRect(
      rect: rect,
      child: IgnorePointer(
        child: Center(
          child: Semantics(
            label: 'Matematik alanı seçildi',
            child: AnimatedContainer(
              key: const ValueKey('mathpro-active-slot-highlight'),
              duration: const Duration(milliseconds: 96),
              curve: Curves.easeOutCubic,
              width: visibleSize.width,
              height: visibleSize.height,
              decoration: BoxDecoration(
                color: MathProColors.accentSoft.withValues(alpha: 0.065),
                borderRadius: BorderRadius.circular(MathProRadius.sm),
                border: Border.all(
                  color: MathProColors.accent.withValues(alpha: 0.88),
                  width: 1.15,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: MathProColors.accent.withValues(alpha: 0.12),
                    blurRadius: 6,
                    spreadRadius: -1,
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fromRect(
                    rect: caretRect,
                    child: const _BlinkingSlotCaret(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Size _visibleFocusSize(Size hitSize) {
    return Size(
      hitSize.width.clamp(18.0, 42.0).toDouble(),
      hitSize.height.clamp(16.0, 30.0).toDouble(),
    );
  }

  Rect _caretRectWithin(Size visibleSize, {required int caretIndex}) {
    const caretWidth = 2.0;
    final caretHeight = (visibleSize.height - 5).clamp(12.0, 25.0).toDouble();
    final x = caretIndex <= 0 ? 3.0 : visibleSize.width - caretWidth - 3.0;
    final y = (visibleSize.height - caretHeight) / 2;
    return Rect.fromLTWH(x, y, caretWidth, caretHeight);
  }
}

class _BlinkingSlotCaret extends StatefulWidget {
  const _BlinkingSlotCaret();

  @override
  State<_BlinkingSlotCaret> createState() => _BlinkingSlotCaretState();
}

class _BlinkingSlotCaretState extends State<_BlinkingSlotCaret> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 820))..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.24, end: 0.96).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        key: const ValueKey('mathpro-active-slot-caret'),
        decoration: BoxDecoration(
          color: MathProColors.accent,
          borderRadius: BorderRadius.circular(MathProRadius.pill),
        ),
      ),
    );
  }
}
