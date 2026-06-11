import 'package:flutter/foundation.dart';

import '../../formula_engine/structural_renderer_bridge.dart';
import '../cursor_anchor.dart';
import '../interaction_context.dart';
import '../selection_controller.dart';
import '../slot_registry.dart';

@immutable
class EditorSnapshot {
  const EditorSnapshot({
    required this.expression,
    required this.structuralSnapshot,
    required this.interaction,
  });

  final String expression;
  final StructuralRendererSnapshot structuralSnapshot;
  final EditorInteractionContext interaction;

  SlotRegistry get registry => structuralSnapshot.registry;

  SlotEntry? get activeSlot => registry.byId(interaction.activeSlotId);

  bool get hasInteractiveSlots => registry.hasSlots;

  EditorSnapshot copyWithInteraction(EditorInteractionContext next) {
    return EditorSnapshot(expression: expression, structuralSnapshot: structuralSnapshot, interaction: next);
  }
}

class MathEditorController {
  const MathEditorController._();

  static int? _clampLinearCaret(int? index, int length) {
    if (index == null) return null;
    return index.clamp(0, length).toInt();
  }

  static EditorSnapshot buildSnapshot({
    required String expression,
    String? activeSlotId,
    String? activeSlotRole,
    int caretIndex = 0,
    int? linearCaretIndex,
    CursorAnchor? cursorAnchor,
    String lastHitSource = 'none',
  }) {
    final structural = StructuralRendererBridge.snapshotForExpression(expression);
    final normalizedSelection = MathProSelectionController.normalize(
      MathProSelectionState(
        activeSlotId: activeSlotId,
        activeSlotRole: activeSlotRole,
        caretIndex: caretIndex,
        lastHitSource: lastHitSource,
      ),
      structural.registry,
    );
    final safeLinearCaret = _clampLinearCaret(linearCaretIndex, expression.length);
    final incomingAnchor = cursorAnchor;
    CursorAnchor? resolvedAnchor;
    if (normalizedSelection.isActive) {
      resolvedAnchor = normalizedSelection.cursorAnchor;
    } else if (incomingAnchor != null && incomingAnchor.isLinear) {
      resolvedAnchor = CursorAnchor.linear(
        offset: incomingAnchor.offset,
        expressionLength: expression.length,
        source: incomingAnchor.source,
        affinity: incomingAnchor.affinity,
      );
    } else if (safeLinearCaret != null) {
      resolvedAnchor = CursorAnchor.linear(
        offset: safeLinearCaret,
        expressionLength: expression.length,
        source: lastHitSource,
      );
    }
    return EditorSnapshot(
      expression: expression,
      structuralSnapshot: structural,
      interaction: EditorInteractionContext(
        activeSlotId: normalizedSelection.activeSlotId,
        activeSlotRole: normalizedSelection.activeSlotRole,
        caretIndex: normalizedSelection.caretIndex,
        lastHitSource: normalizedSelection.lastHitSource,
        linearCaretIndex: normalizedSelection.isActive ? null : safeLinearCaret,
        cursorAnchor: resolvedAnchor,
      ),
    );
  }
}
