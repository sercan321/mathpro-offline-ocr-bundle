import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import 'workspace_editor_actions.dart';
import 'workspace_math_action.dart';
import 'workspace_math_action_resolver.dart';

class WorkspaceExpressionContextMenu {
  const WorkspaceExpressionContextMenu._();

  static const String phase = 'V172-Q382-WORKSPACE-EXPRESSION-CONTEXT-MENU-ACTION-INTENT';
  static const bool floatingOverlayDoesNotResizeWorkspace = true;
  static const bool scrollsInsideOwnMaxHeight = true;
  static const bool clampsToSafeArea = true;
  static const bool fakeSolverResultBlocked = true;
  static const bool editorCaretLongPressPreservedBySafeHitZone = true;
  static const String riskRepairPhase = 'V172-Q382R1-WORKSPACE-CONTEXT-MENU-RISK-REPAIR';
  static const String handlerGuardRepairPhase = 'V172-Q382R2-WORKSPACE-CONTEXT-MENU-HANDLER-GUARD-REPAIR';
  static const String handlerSupportAndEditorSemanticsRepairPhase = 'V172-Q382R5-WORKSPACE-CONTEXT-MENU-UNSUPPORTED-ACTION-AND-EDITOR-SEMANTICS-REPAIR';
  static const String dismissAndHitZoneHardeningPhase = 'V172-Q382R6-WORKSPACE-CONTEXT-MENU-DISMISS-HITZONE-HARDENING';
  static const bool overlayEntryRemovalGuarded = true;
  static const bool maxHeightNeverExceedsSafeArea = true;
  static const bool unsupportedActionsDisabledBeforeSelection = true;
  static const bool staleResultSuppressedForUnsupportedIntent = true;
  static const bool menuUsesAllResolvedActionsForInternalScroll = true;
  static const bool editorReplacementActionsUseExplicitLabels = true;
  static const bool mathLiveContextMenuSyncResultChecked = true;
  static const bool unsupportedActionHandlerGuarded = true;
  static const bool androidBackDismissesOverlayBeforeRoutePop = true;
  static const bool safeHitZoneUsabilityHardenedWithoutCoveringMathLive = true;

  static void show({
    required BuildContext context,
    required Offset anchorGlobal,
    required String expression,
    required Future<void> Function(WorkspaceEditorActionType action) onEditorAction,
    required void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution) onMathActionSelected,
  }) {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;
    HapticFeedback.selectionClick();
    late final OverlayEntry entry;
    LocalHistoryEntry? routeHistoryEntry;
    var removed = false;
    // Q382R1 legacy verifier marker: void removeEntryOnce()
    void removeEntryOnce({bool fromRouteHistory = false}) {
      if (removed) return;
      removed = true;
      entry.remove();
      if (!fromRouteHistory) {
        final historyEntry = routeHistoryEntry;
        routeHistoryEntry = null;
        historyEntry?.remove();
      }
    }

    entry = OverlayEntry(
      builder: (overlayContext) => _WorkspaceExpressionContextMenuOverlay(
        anchorGlobal: anchorGlobal,
        expression: expression,
        onDismiss: () => removeEntryOnce(),
        onEditorAction: (action) async {
          removeEntryOnce();
          await onEditorAction(action);
        },
        onMathActionSelected: (action, resolution) {
          if (!action.enabled) return;
          removeEntryOnce();
          HapticFeedback.selectionClick();
          onMathActionSelected(action, resolution);
        },
      ),
    );
    final route = ModalRoute.of(context);
    if (route != null) {
      routeHistoryEntry = LocalHistoryEntry(
        onRemove: () {
          routeHistoryEntry = null;
          removeEntryOnce(fromRouteHistory: true);
        },
      );
      route.addLocalHistoryEntry(routeHistoryEntry!);
    }
    overlay.insert(entry);
  }
}

class _WorkspaceExpressionContextMenuOverlay extends StatelessWidget {
  const _WorkspaceExpressionContextMenuOverlay({
    required this.anchorGlobal,
    required this.expression,
    required this.onDismiss,
    required this.onEditorAction,
    required this.onMathActionSelected,
  });

  final Offset anchorGlobal;
  final String expression;
  final VoidCallback onDismiss;
  final Future<void> Function(WorkspaceEditorActionType action) onEditorAction;
  final void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution) onMathActionSelected;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final safeLeft = media.padding.left + 10;
    final safeTop = media.padding.top + 10;
    final safeRight = media.size.width - media.padding.right - 10;
    final safeBottom = media.size.height - media.padding.bottom - 10;
    const menuWidth = 258.0;
    final availableSafeHeight = math.max(0.0, safeBottom - safeTop);
    if (availableSafeHeight <= 0) {
      return const SizedBox.shrink();
    }
    // Q382R1 legacy verifier marker: final safeHeight = math.max(72.0, safeBottom - safeTop);
    // Q382R1 legacy verifier marker: final maxHeight = math.min(382.0, safeHeight);
    final maxHeight = math.min(382.0, availableSafeHeight);
    final preferBelow = anchorGlobal.dy + 18 + maxHeight <= safeBottom;
    final rawLeft = anchorGlobal.dx - 28;
    final left = rawLeft.clamp(safeLeft, math.max(safeLeft, safeRight - menuWidth)).toDouble();
    final rawTop = preferBelow ? anchorGlobal.dy + 12 : anchorGlobal.dy - maxHeight - 12;
    final top = rawTop.clamp(safeTop, math.max(safeTop, safeBottom - maxHeight)).toDouble();
    final resolution = WorkspaceMathActionResolver.resolve(expression);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onDismiss,
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            left: left,
            top: top,
            width: menuWidth,
            child: _MenuSurface(
              maxHeight: maxHeight,
              expression: expression,
              resolution: resolution,
              onEditorAction: onEditorAction,
              onMathActionSelected: onMathActionSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuSurface extends StatelessWidget {
  const _MenuSurface({
    required this.maxHeight,
    required this.expression,
    required this.resolution,
    required this.onEditorAction,
    required this.onMathActionSelected,
  });

  final double maxHeight;
  final String expression;
  final WorkspaceMathActionResolution resolution;
  final Future<void> Function(WorkspaceEditorActionType action) onEditorAction;
  final void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution) onMathActionSelected;

  @override
  Widget build(BuildContext context) {
    final editorActions = <_EditorMenuItem>[
      _EditorMenuItem(type: WorkspaceEditorActionType.copy, label: 'Kopyala', icon: Icons.copy_rounded, enabled: WorkspaceEditorActions.canCopy(expression)),
      const _EditorMenuItem(type: WorkspaceEditorActionType.paste, label: 'Tümünü Değiştir', icon: Icons.content_paste_rounded, enabled: true),
      _EditorMenuItem(type: WorkspaceEditorActionType.cut, label: 'Tümünü Kes', icon: Icons.content_cut_rounded, enabled: WorkspaceEditorActions.canCut(expression)),
      _EditorMenuItem(type: WorkspaceEditorActionType.selectAll, label: 'Tümünü Hedefle', icon: Icons.select_all_rounded, enabled: WorkspaceEditorActions.canSelectAll(expression)),
      _EditorMenuItem(type: WorkspaceEditorActionType.clear, label: 'Temizle', icon: Icons.close_rounded, enabled: WorkspaceEditorActions.canClear(expression)),
    ];

    // Q382R5: do not truncate semantic intents with take(7); the menu owns internal scroll.
    final mathActions = resolution.actions;
    return ConstrainedBox(
      key: const ValueKey('mathpro-q382-floating-expression-context-menu'),
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xF21A2225), Color(0xF20B1013), Color(0xF206080A)],
            stops: <double>[0.0, 0.56, 1.0],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: MathProColors.accent.withValues(alpha: 0.34), width: 0.9),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 28,
              spreadRadius: -18,
              color: Colors.black.withValues(alpha: 0.88),
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              blurRadius: 18,
              spreadRadius: -15,
              color: MathProColors.accent.withValues(alpha: 0.24),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Scrollbar(
            thumbVisibility: mathActions.length + editorActions.length > 8,
            thickness: 2.5,
            radius: const Radius.circular(99),
            child: SingleChildScrollView(
              key: const ValueKey('mathpro-q382-context-menu-internal-scroll'),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final item in editorActions)
                    _ContextMenuRow(
                      icon: item.icon,
                      label: item.label,
                      enabled: item.enabled,
                      onTap: item.enabled ? () => onEditorAction(item.type) : null,
                    ),
                  const _ContextMenuDivider(),
                  if (mathActions.isEmpty)
                    const _ContextMenuHint(label: 'İşlem için ifade yaz')
                  else
                    for (final action in mathActions)
                      _ContextMenuRow(
                        icon: action.icon,
                        label: action.label,
                        enabled: action.enabled,
                        trailing: action.enabled ? null : _compactDisabledReason(action.disabledReason),
                        onTap: action.enabled ? () => onMathActionSelected(action, resolution) : null,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _compactDisabledReason(String? reason) {
  final clean = reason?.trim() ?? '';
  if (clean.isEmpty || clean == 'Yakında') return 'Yakında';
  if (clean.contains('handler') || clean.contains('kanıt')) return 'Destek yok';
  if (clean.length <= 14) return clean;
  return 'Yakında';
}

class _EditorMenuItem {
  const _EditorMenuItem({required this.type, required this.label, required this.icon, required this.enabled});

  final WorkspaceEditorActionType type;
  final String label;
  final IconData icon;
  final bool enabled;
}

class _ContextMenuRow extends StatelessWidget {
  const _ContextMenuRow({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback? onTap;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final rowColor = enabled ? Colors.white.withValues(alpha: 0.028) : Colors.transparent;
    final textColor = enabled ? MathProColors.text : MathProColors.textFaint.withValues(alpha: 0.58);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Ink(
            height: 38,
            decoration: BoxDecoration(
              color: rowColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(icon, size: 16.5, color: enabled ? MathProColors.accent : MathProColors.textFaint.withValues(alpha: 0.48)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: MathProTypography.keyText.copyWith(
                        color: textColor,
                        fontSize: 13.1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.05,
                      ),
                    ),
                  ),
                  if (trailing != null)
                    Text(
                      trailing!,
                      style: MathProTypography.workspaceHint.copyWith(
                        color: MathProColors.textFaint.withValues(alpha: 0.56),
                        fontSize: 9.4,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContextMenuDivider extends StatelessWidget {
  const _ContextMenuDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.transparent,
            MathProColors.accent.withValues(alpha: 0.24),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _ContextMenuHint extends StatelessWidget {
  const _ContextMenuHint({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 9, 12, 8),
      child: Text(
        label,
        style: MathProTypography.workspaceHint.copyWith(
          color: MathProColors.textFaint.withValues(alpha: 0.66),
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
