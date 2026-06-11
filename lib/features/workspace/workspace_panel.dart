import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import '../graph/graph_card.dart';
import '../graph/graph_models.dart';
import '../graph/graph_style.dart';
import '../solution/solution_step_models.dart';
import '../solution/solution_steps_panel.dart';
import '../mathlive/mathlive_main_editor_surface.dart';
import '../mathlive/mathlive_state_adapter.dart';
import '../camera/gauss_camera_capture_shell.dart';
import 'result_view.dart';
import 'template_tray.dart';
import 'workspace_editor_actions.dart';
import 'workspace_expression_context_menu.dart';
import 'workspace_math_action.dart';
import 'workspace_math_action_state.dart';
import 'workspace_frame_isolation_q382r30.dart';

class _WorkspaceMotion {
  const _WorkspaceMotion._();

  static const Duration cardResize = Duration(milliseconds: 220);
  static const Duration iconFeedback = Duration(milliseconds: 140);
  static const Curve enterCurve = Curves.easeOutCubic;
}

class _SolutionPanelExpansionMetrics {
  const _SolutionPanelExpansionMetrics._();

  static double targetRatio({
    required SolutionStepsPanelState state,
    required double workspaceHeight,
    required bool templateTrayOpen,
    required bool graphVisible,
  }) {
    if (!state.isOpen) return 0;

    final baseRatio = state.isExpanded
        ? workspaceHeight >= 560
            ? 0.56
            : workspaceHeight >= 420
                ? 0.52
                : 0.46
        : workspaceHeight >= 420
            ? 0.36
            : 0.32;

    final contextPenalty = (graphVisible ? 0.04 : 0.0) + (templateTrayOpen ? 0.025 : 0.0);
    final ratio = baseRatio - contextPenalty;
    final lowerBound = state.isExpanded ? 0.45 : 0.23;
    final upperBound = state.isExpanded ? 0.60 : 0.32;
    return ratio.clamp(lowerBound, upperBound).toDouble();
  }

  static double reservedCardHeight({
    required double workspaceHeight,
    required bool expanded,
  }) {
    if (workspaceHeight < 150) return 72;
    if (expanded) {
      if (workspaceHeight >= 420) return 150;
      if (workspaceHeight >= 300) return 138;
      return 124;
    }
    if (workspaceHeight >= 420) return 132;
    if (workspaceHeight >= 300) return 124;
    return 112;
  }

  static double minimumPanelHeight({
    required double workspaceHeight,
    required bool expanded,
  }) {
    if (workspaceHeight < 250) return 104;
    if (expanded) {
      if (workspaceHeight >= 420) return 174;
      return 148;
    }
    if (workspaceHeight >= 420) return 168;
    if (workspaceHeight >= 320) return 150;
    return 132;
  }
}

class WorkspacePanel extends StatelessWidget {
  const WorkspacePanel({
    super.key,
    required this.activeTab,
    required this.expressionText,
    required this.resultText,
    this.q382r30HotFrameListenable,
    required this.templateTrayOpen,
    this.mathLiveController,
    this.onMathLiveStateChanged,
    this.onMathLiveEvaluateRequested,
    required this.solutionPanelState,
    required this.solutionStepsSnapshot,
    this.statusText,
    this.onTemplateSelected,
    this.onGraphPressed,
    this.onSolutionStepsPressed,
    this.onSolutionStepsClose,
    this.onSolutionStepsExpandToggle,
    this.onHistoryPressed,
    this.onHistoryDragOpen,
    this.onApprovedOcrWorkspaceImport,
    this.graphExpression,
    this.onCloseGraph,
    this.onFullscreenGraph,
    this.onGraphSettings,
    this.onGraphTraceToggle,
    this.onGraphReset,
    this.onGraphZoomIn,
    this.onGraphZoomOut,
    this.graphRenderMode = GraphRenderMode.twoD,
    this.onGraphRenderModeChanged,
    this.selectedWorkspaceMathAction,
    this.allExpressionSelectedFromContextMenu = false,
    this.onWorkspaceMathActionSelected,
    this.onWorkspaceMathActionCleared,
    this.onWorkspaceEditorAction,
  });

  final String activeTab;
  final String expressionText;
  final String resultText;
  final ValueListenable<WorkspaceFrameHotSnapshotQ382R30>? q382r30HotFrameListenable;
  final bool templateTrayOpen;
  final MathLiveMainEditorRuntimeController? mathLiveController;
  final ValueChanged<MathLiveEditorStateSnapshot>? onMathLiveStateChanged;
  final VoidCallback? onMathLiveEvaluateRequested;
  final String? statusText;
  final ValueChanged<String>? onTemplateSelected;
  final VoidCallback? onGraphPressed;
  final VoidCallback? onSolutionStepsPressed;
  final VoidCallback? onSolutionStepsClose;
  final VoidCallback? onSolutionStepsExpandToggle;
  final VoidCallback? onHistoryPressed;
  final VoidCallback? onHistoryDragOpen;
  final Future<void> Function(String approvedLatex)? onApprovedOcrWorkspaceImport;
  final GraphExpression? graphExpression;
  final VoidCallback? onCloseGraph;
  final VoidCallback? onFullscreenGraph;
  final VoidCallback? onGraphSettings;
  final VoidCallback? onGraphTraceToggle;
  final VoidCallback? onGraphReset;
  final VoidCallback? onGraphZoomIn;
  final VoidCallback? onGraphZoomOut;
  final GraphRenderMode graphRenderMode;
  final ValueChanged<GraphRenderMode>? onGraphRenderModeChanged;
  final WorkspaceSelectedMathAction? selectedWorkspaceMathAction;
  final bool allExpressionSelectedFromContextMenu;
  final void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution)? onWorkspaceMathActionSelected;
  final VoidCallback? onWorkspaceMathActionCleared;
  final Future<void> Function(WorkspaceEditorActionType action)? onWorkspaceEditorAction;
  final SolutionStepsPanelState solutionPanelState;
  final SolutionStepsSnapshot solutionStepsSnapshot;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight.isFinite ? constraints.maxHeight : 360.0;
        // V57: reserve a sub-pixel rounding guard for nested animated panels.
        // Real devices and widget tests can differ by 1-2px after SafeArea, dock,
        // graph and steps computations. All child height math uses this guarded
        // budget while the outer SizedBox keeps the full available height.
        final layoutHeight = math.max(0.0, maxHeight - 1.5);
        final panelWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
        final compact = layoutHeight < 300;
        final stepsOpen = solutionPanelState.isOpen && !templateTrayOpen;
        final resultStatusMessage = statusText?.trim() ?? '';
        final minimumCardHeight = stepsOpen
            ? _SolutionPanelExpansionMetrics.reservedCardHeight(
                workspaceHeight: layoutHeight,
                expanded: solutionPanelState.isExpanded,
              )
            : layoutHeight < 150
                ? 72.0
                : 96.0;
        final requestedTrayHeight = templateTrayOpen ? (compact ? 92.0 : 116.0) : 0.0;
        final trayGap = templateTrayOpen ? (compact ? 3.0 : 4.0) : 0.0;
        // Q225: graph preview must read as a canvas-dominant premium card.
        // The requested height is allowed to grow on normal/tall workspaces, while
        // remaining responsive through the existing graphAvailable clamp below.
        final graphRequestedHeight = graphExpression == null
            ? 0.0
            : layoutHeight >= 420
                ? 226.0
                : layoutHeight >= 360
                    ? 212.0
                    : layoutHeight >= 300
                        ? 176.0
                        : 148.0;
        final graphGap = graphExpression == null ? 0.0 : (compact ? 5.0 : 8.0);
        final solutionRatio = _SolutionPanelExpansionMetrics.targetRatio(
          state: solutionPanelState,
          workspaceHeight: layoutHeight,
          templateTrayOpen: templateTrayOpen,
          graphVisible: graphExpression != null,
        );
        final solutionRequestedHeight = stepsOpen ? layoutHeight * solutionRatio : 0.0;
        final solutionMinHeight = stepsOpen
            ? _SolutionPanelExpansionMetrics.minimumPanelHeight(
                workspaceHeight: layoutHeight,
                expanded: solutionPanelState.isExpanded,
              )
            : 0.0;
        final solutionGap = stepsOpen ? (compact ? 4.0 : 5.0) : 0.0;

        final availableBeforeTray = layoutHeight -
            minimumCardHeight -
            trayGap -
            graphRequestedHeight -
            graphGap -
            solutionMinHeight -
            solutionGap;
        final trayHeight = templateTrayOpen ? math.min(requestedTrayHeight, math.max(0.0, availableBeforeTray)) : 0.0;
        final showTray = templateTrayOpen && trayHeight >= 64.0;
        final effectiveTrayHeight = showTray ? trayHeight : 0.0;
        final effectiveTrayGap = showTray ? trayGap : 0.0;
        final graphAvailable = layoutHeight -
            minimumCardHeight -
            effectiveTrayHeight -
            effectiveTrayGap -
            graphGap -
            solutionMinHeight -
            solutionGap;
        final showGraph = graphExpression != null && graphAvailable >= 108.0;
        final effectiveGraphHeight = showGraph ? math.min(graphRequestedHeight, math.max(108.0, graphAvailable)) : 0.0;
        final effectiveGraphGap = showGraph ? graphGap : 0.0;
        final remainingAfterFixed = layoutHeight -
            effectiveTrayHeight -
            effectiveTrayGap -
            effectiveGraphHeight -
            effectiveGraphGap;
        final solutionMaxAvailable = math.max(0.0, remainingAfterFixed - minimumCardHeight - solutionGap);
        final solutionUpperBound = math.max(0.0, remainingAfterFixed - minimumCardHeight);
        final canFitSolutionPanel = stepsOpen && solutionMaxAvailable >= solutionMinHeight;
        final effectiveSolutionHeight = canFitSolutionPanel
            ? solutionRequestedHeight.clamp(solutionMinHeight, solutionUpperBound).toDouble()
            : 0.0;
        final showSolutionPanel = canFitSolutionPanel && effectiveSolutionHeight >= solutionMinHeight;
        final effectiveSolutionGap = showSolutionPanel ? solutionGap : 0.0;
        final cardSlotHeight = math.max(
          0.0,
          remainingAfterFixed - (showSolutionPanel ? effectiveSolutionHeight + effectiveSolutionGap : 0.0),
        );
        // Q229: reclaim only the idle workspace dead gap. Context panels keep
        // their existing shrink behavior, but the normal screen now lets the
        // expression/result card consume the available vertical slot instead
        // of capping itself and leaving a black band above the keyboard.
        final idleExpansion = graphExpression == null && !templateTrayOpen && !showSolutionPanel;

        return ClipRect(
          child: SizedBox(
            width: panelWidth,
            height: maxHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (showTray) ...<Widget>[
                  SizedBox(
                    height: effectiveTrayHeight,
                    child: RepaintBoundary(
                      child: TemplateTray(
                        activeTab: activeTab,
                        onTemplateSelected: onTemplateSelected ?? (_) {},
                      ),
                    ),
                  ),
                  SizedBox(height: effectiveTrayGap),
                ],
                if (showGraph) ...<Widget>[
                  SizedBox(
                    height: effectiveGraphHeight,
                    width: panelWidth,
                    child: RepaintBoundary(
                      child: GraphCard(
                        expression: graphExpression!,
                        onClose: onCloseGraph ?? () {},
                        onFullscreen: onFullscreenGraph ?? () {},
                        onSettings: onGraphSettings ?? () {},
                        onTraceToggle: onGraphTraceToggle,
                        onReset: onGraphReset,
                        onZoomIn: onGraphZoomIn,
                        onZoomOut: onGraphZoomOut,
                        renderMode: graphRenderMode,
                        onRenderModeChanged: onGraphRenderModeChanged,
                      ),
                    ),
                  ),
                  SizedBox(height: effectiveGraphGap),
                ],
                SizedBox(
                  key: const ValueKey('mathpro-question-answer-card-slot'),
                  height: cardSlotHeight,
                  width: panelWidth,
                  child: RepaintBoundary(
                    child: _PremiumQuestionAnswerCard(
                      activeTab: activeTab,
                      expressionText: expressionText,
                      resultText: resultText,
                      resultStatusMessage: resultStatusMessage,
                      q382r30HotFrameListenable: q382r30HotFrameListenable,
                      stepsPanelOpen: showSolutionPanel,
                      templateTrayOpen: templateTrayOpen,
                      idleExpansion: idleExpansion,
                      mathLiveController: mathLiveController,
                      onMathLiveStateChanged: onMathLiveStateChanged,
                      onMathLiveEvaluateRequested: onMathLiveEvaluateRequested,
                      onGraphPressed: onGraphPressed,
                      onSolutionStepsPressed: onSolutionStepsPressed,
                      onHistoryPressed: onHistoryPressed,
                      onHistoryDragOpen: onHistoryDragOpen,
                      onApprovedOcrWorkspaceImport: onApprovedOcrWorkspaceImport,
                      selectedWorkspaceMathAction: selectedWorkspaceMathAction,
                      allExpressionSelectedFromContextMenu: allExpressionSelectedFromContextMenu,
                      onWorkspaceMathActionSelected: onWorkspaceMathActionSelected,
                      onWorkspaceMathActionCleared: onWorkspaceMathActionCleared,
                      onWorkspaceEditorAction: onWorkspaceEditorAction,
                    ),
                  ),
                ),
                if (showSolutionPanel) ...<Widget>[
                  SizedBox(height: effectiveSolutionGap),
                  SizedBox(
                    key: const ValueKey('mathpro-solution-panel-mounted'),
                    height: effectiveSolutionHeight,
                    width: panelWidth,
                    child: RepaintBoundary(
                      child: SolutionStepsPanel(
                        snapshot: solutionStepsSnapshot,
                        panelState: solutionPanelState,
                        onClose: onSolutionStepsClose ?? () {},
                        onToggleExpanded: onSolutionStepsExpandToggle ?? () {},
                      ),
                    ),
                  ),
                ] else
                  const SizedBox(key: ValueKey('mathpro-solution-panel-closed'), height: 0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PremiumQuestionAnswerCard extends StatelessWidget {
  const _PremiumQuestionAnswerCard({
    required this.activeTab,
    required this.expressionText,
    required this.resultText,
    required this.resultStatusMessage,
    this.q382r30HotFrameListenable,
    this.mathLiveController,
    this.onMathLiveStateChanged,
    this.onMathLiveEvaluateRequested,
    required this.stepsPanelOpen,
    required this.templateTrayOpen,
    required this.idleExpansion,
    this.onGraphPressed,
    this.onSolutionStepsPressed,
    this.onHistoryPressed,
    this.onHistoryDragOpen,
    this.onApprovedOcrWorkspaceImport,
    this.selectedWorkspaceMathAction,
    this.allExpressionSelectedFromContextMenu = false,
    this.onWorkspaceMathActionSelected,
    this.onWorkspaceMathActionCleared,
    this.onWorkspaceEditorAction,
  });

  final String activeTab;
  final String expressionText;
  final String resultText;
  final String resultStatusMessage;
  final ValueListenable<WorkspaceFrameHotSnapshotQ382R30>? q382r30HotFrameListenable;
  final MathLiveMainEditorRuntimeController? mathLiveController;
  final ValueChanged<MathLiveEditorStateSnapshot>? onMathLiveStateChanged;
  final VoidCallback? onMathLiveEvaluateRequested;
  final bool stepsPanelOpen;
  final bool templateTrayOpen;
  final bool idleExpansion;
  final VoidCallback? onGraphPressed;
  final VoidCallback? onSolutionStepsPressed;
  final VoidCallback? onHistoryPressed;
  final VoidCallback? onHistoryDragOpen;
  final Future<void> Function(String approvedLatex)? onApprovedOcrWorkspaceImport;
  final WorkspaceSelectedMathAction? selectedWorkspaceMathAction;
  final bool allExpressionSelectedFromContextMenu;
  final void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution)? onWorkspaceMathActionSelected;
  final VoidCallback? onWorkspaceMathActionCleared;
  final Future<void> Function(WorkspaceEditorActionType action)? onWorkspaceEditorAction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite ? constraints.maxHeight : 220.0;
        final margins = _PremiumCardMetrics.margins(
          height: availableHeight,
          stepsPanelOpen: stepsPanelOpen,
          templateTrayOpen: templateTrayOpen,
          idleExpansion: idleExpansion,
        );
        final padding = _PremiumCardMetrics.padding(
          height: availableHeight,
          stepsPanelOpen: stepsPanelOpen,
          templateTrayOpen: templateTrayOpen,
          idleExpansion: idleExpansion,
        );
        final separatorMargin = _PremiumCardMetrics.separatorMargin(height: availableHeight);
        final radius = _PremiumCardMetrics.radius(height: availableHeight);

        final safeVerticalMargins = margins.vertical < availableHeight
            ? margins
            : EdgeInsets.fromLTRB(
                margins.left,
                math.min(margins.top, availableHeight * 0.18),
                margins.right,
                math.min(margins.bottom, availableHeight * 0.08),
              );
        final usableHeight = math.max(0.0, availableHeight - safeVerticalMargins.vertical);
        final cardVisualHeight = _PremiumCardMetrics.cardHeight(
          availableHeight: usableHeight,
          stepsPanelOpen: stepsPanelOpen,
          templateTrayOpen: templateTrayOpen,
          idleExpansion: idleExpansion,
        );
        final effectivePadding = cardVisualHeight >= 118
            ? padding
            : cardVisualHeight >= 80
                ? const EdgeInsets.all(4)
                : EdgeInsets.zero;
        final effectiveSeparatorMargin = cardVisualHeight >= 118
            ? separatorMargin
            : cardVisualHeight >= 80
                ? 1.0
                : 0.0;
        final showHeader = cardVisualHeight >= 96;
        final resultFlex = !stepsPanelOpen && cardVisualHeight >= 260 ? 3 : 2;

        return GestureDetector(
          onVerticalDragEnd: (details) {
            if ((details.primaryVelocity ?? 0) > 260) {
              onHistoryDragOpen?.call();
            }
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: safeVerticalMargins,
              child: AnimatedContainer(
                key: const ValueKey('mathpro-question-answer-card'),
                duration: _WorkspaceMotion.cardResize,
                curve: _WorkspaceMotion.enterCurve,
                height: cardVisualHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF20262A),
                      Color(0xFF11161A),
                      Color(0xFF07090B),
                    ],
                    stops: [0.0, 0.48, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: stepsPanelOpen ? GraphStyle.accent.withValues(alpha: 0.38) : MathProColors.border,
                    width: stepsPanelOpen ? 1.05 : 0.85,
                  ),
                  boxShadow: availableHeight >= 132
                      ? <BoxShadow>[
                          ...MathProShadows.card,
                          if (stepsPanelOpen)
                            const BoxShadow(
                              blurRadius: 24,
                              spreadRadius: -18,
                              color: Color.fromRGBO(116, 190, 180, 0.32),
                              offset: Offset(0, 0),
                            ),
                        ]
                      : const <BoxShadow>[],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: Padding(
                    padding: effectivePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        if (showHeader) ...<Widget>[
                          _CardTopBar(
                            activeTab: activeTab,
                            onGraphPressed: onGraphPressed,
                            onSolutionStepsPressed: onSolutionStepsPressed,
                            onHistoryPressed: onHistoryPressed,
                            onApprovedOcrWorkspaceImport: onApprovedOcrWorkspaceImport,
                            stepsPanelOpen: stepsPanelOpen,
                          ),
                          SizedBox(height: cardVisualHeight >= 180 ? 8 : 4),
                        ],
                        Expanded(
                          flex: 8,
                          child: _Q382R30ExpressionFrameSection(
                            hotFrameListenable: q382r30HotFrameListenable,
                            fallbackFrame: WorkspaceFrameHotSnapshotQ382R30(
                              expressionText: expressionText,
                              resultText: resultText,
                              statusText: resultStatusMessage,
                            ),
                            showLabel: cardVisualHeight >= 186,
                            selectedAction: selectedWorkspaceMathAction,
                            allExpressionSelected: allExpressionSelectedFromContextMenu,
                            onActionCleared: onWorkspaceMathActionCleared,
                            onMathActionSelected: onWorkspaceMathActionSelected,
                            onEditorAction: onWorkspaceEditorAction,
                            mathLiveController: mathLiveController!,
                            onMathLiveStateChanged: onMathLiveStateChanged ?? (_) {},
                            onMathLiveEvaluateRequested: onMathLiveEvaluateRequested ?? () {},
                          ),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: effectiveSeparatorMargin),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withValues(alpha: 0.12),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: resultFlex,
                          child: _Q382R30ResultFrameSection(
                            hotFrameListenable: q382r30HotFrameListenable,
                            fallbackFrame: WorkspaceFrameHotSnapshotQ382R30(
                              expressionText: expressionText,
                              resultText: resultText,
                              statusText: resultStatusMessage,
                            ),
                            showLabelBase: cardVisualHeight >= 206,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




class _CardTopBar extends StatelessWidget {
  const _CardTopBar({
    required this.activeTab,
    required this.onGraphPressed,
    required this.onSolutionStepsPressed,
    required this.onHistoryPressed,
    required this.onApprovedOcrWorkspaceImport,
    required this.stepsPanelOpen,
  });

  final String activeTab;
  final VoidCallback? onGraphPressed;
  final VoidCallback? onSolutionStepsPressed;
  final VoidCallback? onHistoryPressed;
  final Future<void> Function(String approvedLatex)? onApprovedOcrWorkspaceImport;
  final bool stepsPanelOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _ModePill(activeTab: activeTab),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MathProColors.accent.withValues(alpha: 0.22),
                  Colors.white.withValues(alpha: 0.045),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _CardActions(
          onGraphPressed: onGraphPressed,
          onSolutionStepsPressed: onSolutionStepsPressed,
          onHistoryPressed: onHistoryPressed,
          onApprovedOcrWorkspaceImport: onApprovedOcrWorkspaceImport,
          stepsPanelOpen: stepsPanelOpen,
        ),
      ],
    );
  }
}

class _ModePill extends StatelessWidget {
  const _ModePill({required this.activeTab});

  final String activeTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 116),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(116, 190, 180, 0.18),
            Color.fromRGBO(15, 26, 25, 0.78),
          ],
        ),
        borderRadius: BorderRadius.circular(MathProRadius.pill),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.28), width: 0.85),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: MathProColors.accent.withValues(alpha: 0.84),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              activeTab.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.text,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _Q382R30ExpressionFrameSection extends StatelessWidget {
  const _Q382R30ExpressionFrameSection({
    required this.hotFrameListenable,
    required this.fallbackFrame,
    required this.showLabel,
    required this.selectedAction,
    required this.allExpressionSelected,
    required this.onActionCleared,
    required this.onMathActionSelected,
    required this.onEditorAction,
    required this.mathLiveController,
    required this.onMathLiveStateChanged,
    required this.onMathLiveEvaluateRequested,
  });

  final ValueListenable<WorkspaceFrameHotSnapshotQ382R30>? hotFrameListenable;
  final WorkspaceFrameHotSnapshotQ382R30 fallbackFrame;
  final bool showLabel;
  final WorkspaceSelectedMathAction? selectedAction;
  final bool allExpressionSelected;
  final VoidCallback? onActionCleared;
  final void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution)? onMathActionSelected;
  final Future<void> Function(WorkspaceEditorActionType action)? onEditorAction;
  final MathLiveMainEditorRuntimeController mathLiveController;
  final ValueChanged<MathLiveEditorStateSnapshot> onMathLiveStateChanged;
  final VoidCallback onMathLiveEvaluateRequested;

  @override
  Widget build(BuildContext context) {
    final listenable = hotFrameListenable;
    if (listenable == null) return _buildFrame(fallbackFrame);
    return ValueListenableBuilder<WorkspaceFrameHotSnapshotQ382R30>(
      valueListenable: listenable,
      builder: (context, frame, _) => _buildFrame(frame),
    );
  }

  Widget _buildFrame(WorkspaceFrameHotSnapshotQ382R30 frame) {
    return _WorkspaceBodySection(
      label: 'İFADE',
      showLabel: showLabel,
      overlay: _ExpressionContextActionOverlay(
        expressionText: frame.expressionText,
        selectedAction: selectedAction,
        allExpressionSelected: allExpressionSelected,
        onActionCleared: onActionCleared,
        onMathActionSelected: onMathActionSelected,
        onEditorAction: onEditorAction,
      ),
      child: RepaintBoundary(
        child: MathLiveProductionEditorSurface(
          controller: mathLiveController,
          expressionText: frame.expressionText,
          lastAnswer: frame.resultText,
          onStateChanged: onMathLiveStateChanged,
          onEvaluateRequested: onMathLiveEvaluateRequested,
        ),
      ),
    );
  }
}

class _Q382R30ResultFrameSection extends StatelessWidget {
  const _Q382R30ResultFrameSection({
    required this.hotFrameListenable,
    required this.fallbackFrame,
    required this.showLabelBase,
  });

  final ValueListenable<WorkspaceFrameHotSnapshotQ382R30>? hotFrameListenable;
  final WorkspaceFrameHotSnapshotQ382R30 fallbackFrame;
  final bool showLabelBase;

  @override
  Widget build(BuildContext context) {
    final listenable = hotFrameListenable;
    if (listenable == null) return _buildFrame(fallbackFrame);
    return ValueListenableBuilder<WorkspaceFrameHotSnapshotQ382R30>(
      valueListenable: listenable,
      builder: (context, frame, _) => _buildFrame(frame),
    );
  }

  Widget _buildFrame(WorkspaceFrameHotSnapshotQ382R30 frame) {
    final resultStatusMessage = frame.statusText.trim();
    final resultText = frame.resultText;
    return _WorkspaceBodySection(
      label: 'SONUÇ',
      showLabel: showLabelBase && ((resultText.trim().isNotEmpty && resultText.trim() != '—') || resultStatusMessage.isNotEmpty),
      compact: true,
      child: RepaintBoundary(
        child: ResultView(
          value: resultText,
          resultStatusMessage: resultStatusMessage,
        ),
      ),
    );
  }
}

class _WorkspaceBodySection extends StatelessWidget {
  const _WorkspaceBodySection({
    required this.label,
    required this.showLabel,
    required this.child,
    this.compact = false,
    this.overlay,
  });

  final String label;
  final bool showLabel;
  final Widget child;
  final bool compact;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    final radius = compact ? MathProRadius.md : MathProRadius.lg;
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: compact ? 0.08 : 0.11),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.038), width: 0.7),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: child),
          if (showLabel)
            Positioned(
              left: 12,
              top: compact ? 7 : 9,
              child: _SectionCaption(label: label),
            ),
          if (overlay != null) Positioned.fill(child: overlay!),
        ],
      ),
    );
  }
}

class _SectionCaption extends StatelessWidget {
  const _SectionCaption({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: MathProTypography.workspaceHint.copyWith(
        color: MathProColors.textFaint.withValues(alpha: 0.82),
        fontSize: 9,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.15,
      ),
    );
  }
}


class _ExpressionContextActionOverlay extends StatelessWidget {
  const _ExpressionContextActionOverlay({
    required this.expressionText,
    required this.selectedAction,
    required this.allExpressionSelected,
    required this.onActionCleared,
    required this.onMathActionSelected,
    required this.onEditorAction,
  });

  final String expressionText;
  final WorkspaceSelectedMathAction? selectedAction;
  final bool allExpressionSelected;
  final VoidCallback? onActionCleared;
  final void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution)? onMathActionSelected;
  final Future<void> Function(WorkspaceEditorActionType action)? onEditorAction;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            right: 6,
            child: _ExpressionContextMenuTrigger(
              expressionText: expressionText,
              onMathActionSelected: onMathActionSelected,
              onEditorAction: onEditorAction,
            ),
          ),
          if (selectedAction != null || allExpressionSelected)
            Positioned(
              left: 10,
              right: 10,
              bottom: 8,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: selectedAction != null
                    ? _SelectedWorkspaceActionChip(
                        action: selectedAction!,
                        onClear: onActionCleared,
                      )
                    : _SelectedAllExpressionTargetChip(onClear: onActionCleared),
              ),
            ),
        ],
      ),
    );
  }
}

class _ExpressionContextMenuTrigger extends StatelessWidget {
  const _ExpressionContextMenuTrigger({
    required this.expressionText,
    required this.onMathActionSelected,
    required this.onEditorAction,
  });

  final String expressionText;
  final void Function(WorkspaceMathAction action, WorkspaceMathActionResolution resolution)? onMathActionSelected;
  final Future<void> Function(WorkspaceEditorActionType action)? onEditorAction;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'İfade işlemleri',
      child: Semantics(
        button: true,
        label: 'İfade işlem menüsü',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onLongPressStart: (details) {
            final editorCallback = onEditorAction;
            final mathCallback = onMathActionSelected;
            if (editorCallback == null || mathCallback == null) return;
            WorkspaceExpressionContextMenu.show(
              context: context,
              anchorGlobal: details.globalPosition,
              expression: expressionText,
              onEditorAction: editorCallback,
              onMathActionSelected: mathCallback,
            );
          },
          child: Container(
            key: const ValueKey('mathpro-q382-expression-context-menu-safe-hit-zone'),
            width: 54,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // V172-Q382R6: keep the menu trigger in a safe non-MathLive hit-zone,
              // but make it usable enough for real-device long-press without
              // covering the editor caret/slot surface.
              color: Colors.black.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MathProColors.accent.withValues(alpha: 0.20), width: 0.75),
            ),
            child: Icon(Icons.more_horiz_rounded, color: MathProColors.accent.withValues(alpha: 0.76), size: 18),
          ),
        ),
      ),
    );
  }
}


class _SelectedAllExpressionTargetChip extends StatelessWidget {
  const _SelectedAllExpressionTargetChip({required this.onClear});

  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('mathpro-q382-selected-all-expression-target-chip'),
      constraints: const BoxConstraints(maxWidth: 210),
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color.fromRGBO(116, 190, 180, 0.14), Color.fromRGBO(12, 22, 22, 0.90)],
        ),
        borderRadius: BorderRadius.circular(MathProRadius.pill),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.34), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Text(
              'Hedef: Tüm ifade',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.text,
                fontSize: 10.3,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.03,
              ),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onClear,
            child: Icon(Icons.close_rounded, color: MathProColors.accent.withValues(alpha: 0.88), size: 15),
          ),
        ],
      ),
    );
  }
}

class _SelectedWorkspaceActionChip extends StatelessWidget {
  const _SelectedWorkspaceActionChip({required this.action, required this.onClear});

  final WorkspaceSelectedMathAction action;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('mathpro-q382-selected-workspace-action-chip'),
      constraints: const BoxConstraints(maxWidth: 230),
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color.fromRGBO(116, 190, 180, 0.18), Color.fromRGBO(12, 22, 22, 0.92)],
        ),
        borderRadius: BorderRadius.circular(MathProRadius.pill),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.42), width: 0.85),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 13,
            spreadRadius: -9,
            color: MathProColors.accent.withValues(alpha: 0.20),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Text(
              'İşlem: ${action.shortLabel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.text,
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.05,
              ),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onClear,
            child: Icon(Icons.close_rounded, color: MathProColors.accent.withValues(alpha: 0.92), size: 15),
          ),
        ],
      ),
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions({
    required this.onGraphPressed,
    required this.onSolutionStepsPressed,
    required this.onHistoryPressed,
    required this.onApprovedOcrWorkspaceImport,
    required this.stepsPanelOpen,
  });

  final VoidCallback? onGraphPressed;
  final VoidCallback? onSolutionStepsPressed;
  final VoidCallback? onHistoryPressed;
  final Future<void> Function(String approvedLatex)? onApprovedOcrWorkspaceImport;
  final bool stepsPanelOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _CardIconButton(
          key: const ValueKey('mathpro-graph-button'),
          icon: Icons.show_chart_rounded,
          tooltip: 'Grafik',
          onPressed: onGraphPressed,
        ),
        const SizedBox(width: 4),
        _CardIconButton(
          key: const ValueKey('mathpro-solution-steps-button'),
          icon: Icons.format_list_numbered_rounded,
          tooltip: 'Çözüm Adımları',
          active: stepsPanelOpen,
          onPressed: onSolutionStepsPressed,
        ),
        const SizedBox(width: 4),
        _CardIconButton(
          key: const ValueKey('mathpro-premium-history-button'),
          icon: Icons.history_rounded,
          tooltip: 'Geçmiş',
          onPressed: onHistoryPressed,
        ),
        const SizedBox(width: 4),
        _CardIconButton(
          key: const ValueKey('mathpro-workspace-camera-entry-button'),
          icon: Icons.photo_camera_outlined,
          tooltip: 'Kamera',
          semanticLabel: 'Kamera ile ifade tara',
          onPressed: () => _openCameraCaptureShell(
            context,
            onApprovedLatexImport: onApprovedOcrWorkspaceImport,
          ),
        ),
      ],
    );
  }
}

class _CardIconButton extends StatelessWidget {
  const _CardIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.active = false,
    this.semanticLabel,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool active;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    const accent = MathProColors.accent;
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: semanticLabel ?? tooltip,
        child: Material(
          color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: onPressed,
          child: AnimatedScale(
            duration: _WorkspaceMotion.iconFeedback,
            curve: _WorkspaceMotion.enterCurve,
            scale: active ? 1.045 : 1.0,
            child: AnimatedContainer(
              duration: _WorkspaceMotion.iconFeedback,
              curve: _WorkspaceMotion.enterCurve,
              width: 32,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: active
                      ? const [Color.fromRGBO(116, 190, 180, 0.23), Color.fromRGBO(20, 37, 35, 0.94)]
                      : [
                          Colors.white.withValues(alpha: 0.040),
                          Colors.black.withValues(alpha: 0.045),
                        ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: active ? MathProColors.accent.withValues(alpha: 0.60) : MathProColors.accent.withValues(alpha: 0.27),
                  width: active ? 1.05 : 0.85,
                ),
                boxShadow: active
                    ? const <BoxShadow>[
                        BoxShadow(
                          blurRadius: 12,
                          spreadRadius: -10,
                          color: Color.fromRGBO(116, 190, 180, 0.26),
                          offset: Offset(0, 4),
                        ),
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: -8,
                          color: Color.fromRGBO(0, 0, 0, 0.70),
                          offset: Offset(0, 5),
                        ),
                      ]
                    : const <BoxShadow>[],
              ),
              child: Icon(icon, color: accent, size: 15.5),
            ),
          ),
        ),
        ),
      ),
    );
  }
}


void _openCameraCaptureShell(
  BuildContext context, {
  Future<void> Function(String approvedLatex)? onApprovedLatexImport,
}) {
  Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (_) => GaussCameraCaptureShell(
        onApprovedLatexImport: onApprovedLatexImport,
      ),
    ),
  );
}


class _PremiumCardMetrics {
  const _PremiumCardMetrics._();

  static EdgeInsets margins({
    required double height,
    required bool stepsPanelOpen,
    required bool templateTrayOpen,
    required bool idleExpansion,
  }) {
    // V68 width-lock: the question/workspace card must use the same outer
    // width budget as the SolutionStepsPanel. Earlier premium polish kept
    // 12-16dp horizontal card gutters, making the workspace visually narrower
    // than the steps panel even though both lived inside the same parent slot.
    // Keep all vertical rhythm rules intact, but remove only the horizontal
    // shrink so Workspace = Solution Steps at the outer shell level.
    if (templateTrayOpen) {
      if (height >= 360) return const EdgeInsets.fromLTRB(0.0, 12, 0.0, 8);
      if (height >= 300) return const EdgeInsets.fromLTRB(0.0, 10, 0.0, 7);
      if (height >= 230) return const EdgeInsets.fromLTRB(0.0, 7, 0.0, 6);
      if (height >= 170) return const EdgeInsets.fromLTRB(0.0, 5, 0.0, 4);
      return const EdgeInsets.fromLTRB(0.0, 3, 0.0, 3);
    }
    if (stepsPanelOpen) {
      if (height >= 360) return const EdgeInsets.fromLTRB(0.0, 12, 0.0, 7);
      if (height >= 300) return const EdgeInsets.fromLTRB(0.0, 10, 0.0, 6);
      if (height >= 230) return const EdgeInsets.fromLTRB(0.0, 7, 0.0, 5);
      if (height >= 170) return const EdgeInsets.fromLTRB(0.0, 5, 0.0, 4);
      return const EdgeInsets.fromLTRB(0.0, 3, 0.0, 3);
    }
    if (idleExpansion) {
      // Q229R2: mirror the compact MORE-open rhythm instead of leaving a
      // visible black band above the keyboard.  The card still breathes, but
      // the bottom optical gap now tracks the tray reference spacing family.
      if (height >= 420) return const EdgeInsets.fromLTRB(0.0, 8, 0.0, 5);
      if (height >= 360) return const EdgeInsets.fromLTRB(0.0, 7, 0.0, 5);
      if (height >= 300) return const EdgeInsets.fromLTRB(0.0, 7, 0.0, 5);
      if (height >= 230) return const EdgeInsets.fromLTRB(0.0, 6, 0.0, 5);
      if (height >= 170) return const EdgeInsets.fromLTRB(0.0, 5, 0.0, 4);
      return const EdgeInsets.fromLTRB(0.0, 3, 0.0, 3);
    }
    // Q229R4: the remaining non-idle route is the Graph-open workspace
    // slot.  Keep the same controlled breathing family as MORE/Solution so
    // Graph does not reintroduce a larger card-slot phantom gap.
    if (height >= 360) return const EdgeInsets.fromLTRB(0.0, 12, 0.0, 8);
    if (height >= 300) return const EdgeInsets.fromLTRB(0.0, 10, 0.0, 7);
    if (height >= 230) return const EdgeInsets.fromLTRB(0.0, 7, 0.0, 6);
    if (height >= 170) return const EdgeInsets.fromLTRB(0.0, 5, 0.0, 4);
    return const EdgeInsets.fromLTRB(0.0, 3, 0.0, 3);
  }

  static EdgeInsets padding({
    required double height,
    required bool stepsPanelOpen,
    required bool templateTrayOpen,
    required bool idleExpansion,
  }) {
    if (templateTrayOpen) {
      if (height >= 260) return const EdgeInsets.all(17);
      if (height >= 210) return const EdgeInsets.all(14);
      if (height >= 160) return const EdgeInsets.all(11);
      if (height >= 120) return const EdgeInsets.all(8);
      return const EdgeInsets.all(6);
    }
    if (stepsPanelOpen) {
      if (height >= 260) return const EdgeInsets.all(15);
      if (height >= 210) return const EdgeInsets.all(13);
      if (height >= 160) return const EdgeInsets.all(10);
      if (height >= 120) return const EdgeInsets.all(8);
      return const EdgeInsets.all(6);
    }
    if (idleExpansion) {
      if (height >= 340) return const EdgeInsets.fromLTRB(18, 18, 18, 16);
      if (height >= 260) return const EdgeInsets.fromLTRB(17, 17, 17, 15);
      if (height >= 210) return const EdgeInsets.all(15);
      if (height >= 160) return const EdgeInsets.all(12);
      if (height >= 120) return const EdgeInsets.all(8);
      return const EdgeInsets.all(6);
    }
    if (height >= 260) return const EdgeInsets.all(18);
    if (height >= 210) return const EdgeInsets.all(15);
    if (height >= 160) return const EdgeInsets.all(12);
    if (height >= 120) return const EdgeInsets.all(8);
    return const EdgeInsets.all(6);
  }

  static double separatorMargin({required double height}) {
    if (height >= 210) return 7;
    if (height >= 150) return 4;
    return 2;
  }

  static double cardHeight({
    required double availableHeight,
    required bool stepsPanelOpen,
    required bool templateTrayOpen,
    required bool idleExpansion,
  }) {
    if (availableHeight <= 0) return 0;
    // Q229R4 root fix: the parent already allocates the exact vertical slot
    // for the workspace card.  Older branches capped idle/MORE/Graph visuals
    // at 292/316/348px, so the card stayed top-aligned while the remaining
    // slot looked like a keyboard gap.  Use the usable slot height directly;
    // the small optical breathing room is handled only by margins above.
    if (templateTrayOpen || stepsPanelOpen || idleExpansion) {
      return availableHeight;
    }
    // The remaining non-idle route is the Graph-open workspace slot.  It also
    // fills its slot so Graph/MORE/Solution/Idle share one vertical rhythm.
    return availableHeight;
  }

  static double radius({required double height}) => height >= 150 ? 22 : 14;
}
