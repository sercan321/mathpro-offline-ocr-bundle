import 'dart:async';

import 'package:flutter/material.dart';

import '../debug/latency/mathpro_all_key_latency_court_q382r25.dart';
import '../debug/latency/mathpro_latency_overlay_q382r23.dart';
import '../debug/latency/mathpro_latency_probe_q382r23.dart';
import '../features/graph/graph_eligibility.dart';
import '../features/graph/graph_fullscreen_page.dart';
import '../features/graph/graph_models.dart';
import '../features/graph/graph_settings_sheet.dart';
import '../features/history/history_controller.dart';
import '../features/history/history_models.dart';
import '../features/history/history_panel.dart';
import '../features/keyboard/bottom_dock.dart';
import '../features/keyboard/key_config.dart';
import '../features/keyboard/keyboard_latency_closure_q382r24_policy.dart';
import '../features/mathlive/mathlive_main_editor_state_authority_policy.dart';
import '../features/mathlive/mathlive_main_editor_surface.dart';
import '../features/mathlive/mathlive_production_graph_history_solution_state_finalization_policy.dart';
import '../features/mathlive/mathlive_safe_optimistic_linear_echo_q382r27_policy.dart';
import '../features/mathlive/mathlive_state_adapter.dart';
import '../features/mathlive/mathlive_key_ordering_regression_q382r33r3_policy.dart';
import '../features/solution/solution_step_models.dart';
import '../features/solution/result_solution_idle_pipeline_q382r31.dart';
import '../features/workspace/workspace_editor_actions.dart';
import '../features/workspace/workspace_math_action.dart';
import '../features/workspace/workspace_math_action_state.dart';
import '../features/workspace/workspace_panel.dart';
import '../features/workspace/workspace_frame_isolation_q382r30.dart';
import '../state/calculator_controller.dart';
import '../state/calculator_state.dart';
import '../theme/mathpro_tokens.dart';

class _WorkspaceStructuralKeyQ382R30 {
  const _WorkspaceStructuralKeyQ382R30({
    required this.activeTab,
    required this.templateTrayOpen,
    required this.graphPreviewVisible,
    required this.graphHash,
    required this.graphHistoryEntryId,
    required this.graphRenderMode,
    required this.solutionPanelState,
    required this.selectedActionId,
    required this.selectedActionLabel,
    required this.selectedExpressionKind,
    required this.selectedActionRequiresSolverHandler,
    required this.selectedActionSupportedByCurrentEngine,
    required this.allExpressionSelectedFromContextMenu,
    required this.solutionExpression,
    required this.solutionResult,
    required this.solutionUnsupportedReason,
  });

  final String activeTab;
  final bool templateTrayOpen;
  final bool graphPreviewVisible;
  final int? graphHash;
  final String? graphHistoryEntryId;
  final GraphRenderMode graphRenderMode;
  final SolutionStepsPanelState solutionPanelState;
  final String? selectedActionId;
  final String? selectedActionLabel;
  final String? selectedExpressionKind;
  final bool? selectedActionRequiresSolverHandler;
  final bool? selectedActionSupportedByCurrentEngine;
  final bool allExpressionSelectedFromContextMenu;
  final String? solutionExpression;
  final String? solutionResult;
  final String? solutionUnsupportedReason;

  @override
  bool operator ==(Object other) {
    return other is _WorkspaceStructuralKeyQ382R30 &&
        other.activeTab == activeTab &&
        other.templateTrayOpen == templateTrayOpen &&
        other.graphPreviewVisible == graphPreviewVisible &&
        other.graphHash == graphHash &&
        other.graphHistoryEntryId == graphHistoryEntryId &&
        other.graphRenderMode == graphRenderMode &&
        other.solutionPanelState == solutionPanelState &&
        other.selectedActionId == selectedActionId &&
        other.selectedActionLabel == selectedActionLabel &&
        other.selectedExpressionKind == selectedExpressionKind &&
        other.selectedActionRequiresSolverHandler == selectedActionRequiresSolverHandler &&
        other.selectedActionSupportedByCurrentEngine == selectedActionSupportedByCurrentEngine &&
        other.allExpressionSelectedFromContextMenu == allExpressionSelectedFromContextMenu &&
        other.solutionExpression == solutionExpression &&
        other.solutionResult == solutionResult &&
        other.solutionUnsupportedReason == solutionUnsupportedReason;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        activeTab,
        templateTrayOpen,
        graphPreviewVisible,
        graphHash,
        graphHistoryEntryId,
        graphRenderMode,
        solutionPanelState,
        selectedActionId,
        selectedActionLabel,
        selectedExpressionKind,
        selectedActionRequiresSolverHandler,
        selectedActionSupportedByCurrentEngine,
        allExpressionSelectedFromContextMenu,
        solutionExpression,
        solutionResult,
        solutionUnsupportedReason,
      ]);
}

class _AppShellMotion {
  const _AppShellMotion._();

  static const Duration workspaceSwitch = Duration(milliseconds: 220);
  static const Duration dockSwitch = Duration(milliseconds: 200);
  static const Duration fullscreenPush = Duration(milliseconds: 260);
  static const Duration fullscreenPop = Duration(milliseconds: 200);
}

class MathProAppShell extends StatefulWidget {
  const MathProAppShell({super.key});

  @override
  State<MathProAppShell> createState() => _MathProAppShellState();
}

class _MathProAppShellState extends State<MathProAppShell> {
  late final CalculatorController _calculator;
  late final HistoryController _history;
  String _activeTab = KeyConfig.tabs.first;
  GraphExpression? _activeGraph;
  String? _activeGraphHistoryEntryId;
  GraphRenderMode _graphRenderMode = GraphRenderMode.twoD;
  bool _graphPreviewVisible = false;
  bool _historyVisible = false;
  SolutionStepsPanelState _stepsPanelState = SolutionStepsPanelState.closed;
  String? _lastHistorySignature;
  final MathLiveMainEditorRuntimeController _mathLiveMainEditor = MathLiveMainEditorRuntimeController();
  bool _syncingMathLiveExpression = false;
  MathLiveProductionGraphHistorySolutionStateEnvelope? _lastMathLiveProductionStateEnvelope;
  WorkspaceSelectedMathAction? _selectedWorkspaceMathAction;
  bool _workspaceExpressionAllSelectedFromContextMenu = false;
  _SolutionStepsMemoKey? _cachedSolutionStepsMemoKey;
  SolutionStepsSnapshot? _cachedSolutionStepsSnapshot;
  Timer? _q382r24MathLiveDownstreamSyncDebounce;
  MathLiveEditorStateSnapshot? _q382r24PendingMathLiveSnapshot;
  MathLiveCaretContextSnapshot _q382r27LastCaretContext = const MathLiveCaretContextSnapshot.unknown();
  String? _q382r27OptimisticExpression;
  bool _q382r27OptimisticChainActive = false;
  late final ValueNotifier<WorkspaceFrameHotSnapshotQ382R30> _q382r30WorkspaceHotFrame;
  _WorkspaceStructuralKeyQ382R30? _q382r30CachedWorkspaceKey;
  Widget? _q382r30CachedWorkspace;
  Timer? _q382r31ResultSolutionIdleTimer;
  CalculatorState? _q382r31PendingResultSolutionState;
  late CalculatorState _q382r31ResultSolutionIdleState;
  int _q382r33r3LastAppliedMathLiveCommandSequence = 0;

  @override
  void initState() {
    super.initState();
    _calculator = CalculatorController();
    _history = HistoryController();
    _q382r31ResultSolutionIdleState = _calculator.state;
    _q382r30WorkspaceHotFrame = ValueNotifier<WorkspaceFrameHotSnapshotQ382R30>(
      WorkspaceFrameHotSnapshotQ382R30(
        expressionText: _calculator.state.expressionText,
        resultText: _q382r31ResultSolutionIdleState.result,
        statusText: _q382r31ResultSolutionIdleState.lastUnsupportedReason ?? '',
      ),
    );
    _calculator.addListener(_handleQ382R30CalculatorFrameChanged);
    assert(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        unawaited(
          MathProAllKeyLatencyCourtQ382R25.instance.maybeRunDirectBridgeCourt(
            dispatch: _dispatchQ382R25LatencyCourtLabel,
          ),
        );
      });
      return true;
    }());
  }

  @override
  void dispose() {
    _q382r24MathLiveDownstreamSyncDebounce?.cancel();
    _q382r31ResultSolutionIdleTimer?.cancel();
    _calculator.removeListener(_handleQ382R30CalculatorFrameChanged);
    _q382r30WorkspaceHotFrame.dispose();
    _history.dispose();
    _calculator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // V172-Q382R21: keep the keyboard dock out of CalculatorController's hot
    // keystroke rebuild path.  The workspace still listens to calculator
    // snapshots, but BottomDock/History stay outside that AnimatedBuilder so
    // rapid MathLive input does not rebuild the whole shell.
    return Scaffold(
      backgroundColor: MathProColors.bg,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final media = MediaQuery.of(context);
                final availableHeight = constraints.maxHeight.isFinite ? constraints.maxHeight : media.size.height;
                final dockHeight = _historyVisible
                    ? 0.0
                    : KeyboardDockMetrics.targetTotalHeight(
                        media,
                        availableHeight: availableHeight,
                      );

                return Column(
                  children: <Widget>[
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: _AppShellMotion.workspaceSwitch,
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder: _historyAwareTransition,
                        child: _historyVisible
                            ? HistoryPanel(
                                key: const ValueKey('mathpro-history-visible-panel'),
                                controller: _history,
                                onClose: _closeHistory,
                                onEntrySelected: _restoreHistoryEntry,
                                onGraphSelected: _openGraphFromHistory,
                                onResultSelected: _useHistoryResult,
                              )
                            : _buildCalculatorWorkspace(),
                      ),
                    ),
                    _historyVisible
                        ? const SizedBox(key: ValueKey('mathpro-keyboard-dock-hidden'), height: 0)
                        : AnimatedSwitcher(
                            duration: _AppShellMotion.dockSwitch,
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: _keyboardDockTransition,
                            child: SizedBox(
                              key: const ValueKey('mathpro-keyboard-dock-visible'),
                              height: dockHeight,
                              child: RepaintBoundary(
                                child: BottomDock(
                                  activeTab: _activeTab,
                                  onTabChanged: (tab) => setState(() => _activeTab = tab),
                                  onKeyPressed: _handleKeyPressed,
                                ),
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
          const MathProLatencyOverlayQ382R23(),
        ],
      ),
    );
  }

  Widget _buildCalculatorWorkspace() {
    return KeyedSubtree(
      key: const ValueKey('mathpro-normal-workspace'),
      child: AnimatedBuilder(
        animation: _calculator,
        builder: (context, _) {
          final calculatorState = _calculator.state;
          // V172-Q382R31: expression/caret state remains immediate, but result/status
          // and SolutionSteps composition read an idle snapshot so solver/solution
          // work does not ride every MathLive key frame.
          final solutionCalculatorState = ResultSolutionIdlePipelineQ382R31Policy.solutionComposerUsesIdleSnapshot
              ? _q382r31ResultSolutionIdleState
              : calculatorState;

          final selectedActionForSnapshot = _selectedWorkspaceMathAction?.isStillValidFor(calculatorState.expressionText) == true
              ? _selectedWorkspaceMathAction
              : null;
          final selectedActionHasUnsupportedHandler = selectedActionForSnapshot?.hasUnsupportedSolverHandler == true;
          final structuralKey = _WorkspaceStructuralKeyQ382R30(
            activeTab: _activeTab,
            templateTrayOpen: calculatorState.templateTrayOpen,
            graphPreviewVisible: _graphPreviewVisible,
            graphHash: _activeGraph?.hashCode,
            graphHistoryEntryId: _activeGraphHistoryEntryId,
            graphRenderMode: _graphRenderMode,
            solutionPanelState: _stepsPanelState,
            selectedActionId: selectedActionForSnapshot?.id,
            selectedActionLabel: selectedActionForSnapshot?.label,
            selectedExpressionKind: selectedActionForSnapshot?.expressionKind.name,
            selectedActionRequiresSolverHandler: selectedActionForSnapshot?.requiresSolverHandler,
            selectedActionSupportedByCurrentEngine: selectedActionForSnapshot?.supportedByCurrentEngine,
            allExpressionSelectedFromContextMenu: _workspaceExpressionAllSelectedFromContextMenu,
            solutionExpression: _stepsPanelState.isOpen
                ? (selectedActionForSnapshot != null
                    ? solutionCalculatorState.expressionText
                    : solutionCalculatorState.lastEvaluatedExpression ?? solutionCalculatorState.expressionText)
                : null,
            solutionResult: _stepsPanelState.isOpen ? solutionCalculatorState.result : null,
            solutionUnsupportedReason: _stepsPanelState.isOpen
                ? (selectedActionHasUnsupportedHandler
                    ? 'Bu işlem henüz desteklenmiyor; sahte sonuç gösterilmiyor.'
                    : solutionCalculatorState.lastUnsupportedReason)
                : null,
          );

          final cached = _q382r30CachedWorkspace;
          if (WorkspaceFrameIsolationQ382R30Policy.cacheStructuralWorkspaceShell &&
              cached != null &&
              structuralKey == _q382r30CachedWorkspaceKey) {
            return cached;
          }

          final solutionStepsSnapshot = _solutionStepsSnapshotFor(
            panelOpen: _stepsPanelState.isOpen,
            expression: selectedActionForSnapshot != null
                ? solutionCalculatorState.expressionText
                : solutionCalculatorState.lastEvaluatedExpression ?? solutionCalculatorState.expressionText,
            result: selectedActionHasUnsupportedHandler ? '—' : solutionCalculatorState.result,
            unsupportedReason: selectedActionHasUnsupportedHandler
                ? 'Bu işlem henüz desteklenmiyor; sahte sonuç gösterilmiyor.'
                : solutionCalculatorState.lastUnsupportedReason,
            selectedActionId: selectedActionForSnapshot?.id,
            selectedActionLabel: selectedActionForSnapshot?.label,
            selectedExpressionKind: selectedActionForSnapshot?.expressionKind.name,
            selectedActionRequiresSolverHandler: selectedActionForSnapshot?.requiresSolverHandler,
            selectedActionSupportedByCurrentEngine: selectedActionForSnapshot?.supportedByCurrentEngine,
          );
          final frame = _q382r30WorkspaceHotFrame.value;
          final workspace = Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              MathProSpacing.md,
              MathProSpacing.sm,
              MathProSpacing.md,
              MathProSpacing.xxs,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: RepaintBoundary(
                    child: WorkspacePanel(
                      activeTab: _activeTab,
                      expressionText: frame.expressionText,
                      resultText: frame.resultText,
                      q382r30HotFrameListenable: _q382r30WorkspaceHotFrame,
                      templateTrayOpen: calculatorState.templateTrayOpen,
                      statusText: frame.statusText,
                      graphExpression: _graphPreviewVisible ? _activeGraph : null,
                      onCloseGraph: _closeGraphPreview,
                      onFullscreenGraph: () => _openFullscreenGraph(),
                      onGraphSettings: _openGraphSettings,
                      onGraphTraceToggle: _toggleGraphTrace,
                      onGraphReset: _resetGraphViewport,
                      onGraphZoomIn: () => _zoomGraph(0.72),
                      onGraphZoomOut: () => _zoomGraph(1.28),
                      graphRenderMode: _graphRenderMode,
                      onGraphRenderModeChanged: _setGraphRenderMode,
                      solutionPanelState: _stepsPanelState,
                      solutionStepsSnapshot: solutionStepsSnapshot,
                      onGraphPressed: _handleGraphPressed,
                      onSolutionStepsPressed: _toggleSolutionStepsPanel,
                      onSolutionStepsClose: _closeSolutionStepsPanel,
                      onSolutionStepsExpandToggle: _toggleSolutionStepsExpanded,
                      onHistoryPressed: _openHistory,
                      onHistoryDragOpen: _openHistory,
                      mathLiveController: _mathLiveMainEditor,
                      onMathLiveStateChanged: _handleMathLiveStateChanged,
                      onMathLiveEvaluateRequested: _evaluateMathLiveExpression,
                      onTemplateSelected: _handleKeyPressed,
                      onApprovedOcrWorkspaceImport: _handleApprovedOcrWorkspaceImport,
                      selectedWorkspaceMathAction: selectedActionForSnapshot,
                      allExpressionSelectedFromContextMenu: _workspaceExpressionAllSelectedFromContextMenu,
                      onWorkspaceMathActionSelected: _handleWorkspaceMathActionSelected,
                      onWorkspaceMathActionCleared: _clearWorkspaceMathActionFromChip,
                      onWorkspaceEditorAction: _handleWorkspaceEditorAction,
                    ),
                  ),
                ),
                // V119: the floating selection action card has been removed from
                // the user-facing workspace. Slot state remains internal for
                // cursor/editing, but no "Seçim" card is painted between
                // workspace and keyboard.
                const SizedBox.shrink(),
              ],
            ),
          );
          _q382r30CachedWorkspaceKey = structuralKey;
          _q382r30CachedWorkspace = workspace;
          return workspace;
        },
      ),
    );
  }

  void _handleQ382R30CalculatorFrameChanged() {
    final state = _calculator.state;
    _scheduleQ382R31ResultSolutionIdlePipeline(state);
    _updateQ382R30WorkspaceHotFrame(
      expressionState: state,
      resultState: _q382r31ResultSolutionIdleState,
    );
  }

  void _scheduleQ382R31ResultSolutionIdlePipeline(CalculatorState state) {
    if (!ResultSolutionIdlePipelineQ382R31Policy.resultAndStatusFrameIdleDebounced) {
      _q382r31ResultSolutionIdleState = state;
      return;
    }
    _q382r31PendingResultSolutionState = state;
    _q382r31ResultSolutionIdleTimer?.cancel();
    _q382r31ResultSolutionIdleTimer = Timer(
      ResultSolutionIdlePipelineQ382R31Policy.idleDelay,
      _flushQ382R31ResultSolutionIdlePipeline,
    );
  }

  void _flushQ382R31ResultSolutionIdlePipeline() {
    final state = _q382r31PendingResultSolutionState ?? _calculator.state;
    _q382r31PendingResultSolutionState = null;
    _q382r31ResultSolutionIdleTimer?.cancel();
    _q382r31ResultSolutionIdleTimer = null;
    _q382r31ResultSolutionIdleState = state;
    _updateQ382R30WorkspaceHotFrame(
      expressionState: _calculator.state,
      resultState: state,
    );
    if (mounted && _stepsPanelState.isOpen) {
      setState(() {});
    }
  }

  void _flushQ382R31ResultSolutionIdlePipelineForExplicitAction() {
    if (!ResultSolutionIdlePipelineQ382R31Policy.evaluateFlushesIdlePipelineImmediately) return;
    _q382r31PendingResultSolutionState = _calculator.state;
    _flushQ382R31ResultSolutionIdlePipeline();
  }

  void _updateQ382R30WorkspaceHotFrame({
    required CalculatorState expressionState,
    required CalculatorState resultState,
  }) {
    final next = WorkspaceFrameHotSnapshotQ382R30(
      expressionText: expressionState.expressionText,
      resultText: resultState.result,
      statusText: resultState.lastUnsupportedReason ?? '',
    );
    if (next == _q382r30WorkspaceHotFrame.value) return;
    _q382r30WorkspaceHotFrame.value = next;
  }


  SolutionStepsSnapshot _solutionStepsSnapshotFor({
    required bool panelOpen,
    required String expression,
    required String result,
    String? unsupportedReason,
    String? selectedActionId,
    String? selectedActionLabel,
    String? selectedExpressionKind,
    bool? selectedActionRequiresSolverHandler,
    bool? selectedActionSupportedByCurrentEngine,
  }) {
    final memoKey = _SolutionStepsMemoKey(
      expression: expression,
      result: result,
      unsupportedReason: unsupportedReason,
      selectedActionId: selectedActionId,
      selectedActionLabel: selectedActionLabel,
      selectedExpressionKind: selectedExpressionKind,
      selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
      selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
    );

    final cached = _cachedSolutionStepsSnapshot;
    if (_cachedSolutionStepsMemoKey == memoKey && cached != null) {
      return cached;
    }

    if (!panelOpen) {
      // V172-Q382R18: keep keyboard input/rebuilds hot while the Solution Steps
      // panel is closed.  The closed workspace never paints the steps list, so
      // it must not pay EvaluatorBridge.analyzeSemantic/SolutionStepsComposer
      // cost on every MathLive keystroke.  Opening the panel recomputes the
      // authoritative snapshot through SolutionStepsComposer below.
      return SolutionStepsSnapshot(
        expression: expression.trim(),
        result: result.trim().isEmpty ? '0' : result.trim(),
        steps: const <SolutionStep>[],
        statusText: unsupportedReason?.trim().isEmpty == true ? null : unsupportedReason?.trim(),
        selectedActionId: selectedActionId,
        selectedActionLabel: selectedActionLabel,
        selectedExpressionKind: selectedExpressionKind,
        selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
        selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
      );
    }

    final snapshot = SolutionStepsComposer.compose(
      expression: expression,
      result: result,
      unsupportedReason: unsupportedReason,
      selectedActionId: selectedActionId,
      selectedActionLabel: selectedActionLabel,
      selectedExpressionKind: selectedExpressionKind,
      selectedActionRequiresSolverHandler: selectedActionRequiresSolverHandler,
      selectedActionSupportedByCurrentEngine: selectedActionSupportedByCurrentEngine,
    );
    _cachedSolutionStepsMemoKey = memoKey;
    _cachedSolutionStepsSnapshot = snapshot;
    return snapshot;
  }


  Widget _historyAwareTransition(Widget child, Animation<double> animation) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
    final isHistory = child.key == const ValueKey('mathpro-history-visible-panel');
    if (isHistory) {
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -0.075), end: Offset.zero).animate(curved),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.975, end: 1).animate(curved),
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
      );
    }
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.035), end: Offset.zero).animate(curved),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.992, end: 1).animate(curved),
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      ),
    );
  }

  Widget _keyboardDockTransition(Widget child, Animation<double> animation) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(curved),
        child: SizeTransition(
          sizeFactor: curved,
          axisAlignment: -1,
          child: child,
        ),
      ),
    );
  }


  Future<void> _handleApprovedOcrWorkspaceImport(String approvedLatex) async {
    _q382r24MathLiveDownstreamSyncDebounce?.cancel();
    _q382r24PendingMathLiveSnapshot = null;
    _resetQ382R27OptimisticLinearEcho();
    _q382r33r3LastAppliedMathLiveCommandSequence = 0;
    final trimmed = approvedLatex.trim();
    if (trimmed.isEmpty) return;
    _syncingMathLiveExpression = true;
    _calculator.syncExternalEditorExpression(
      expression: trimmed,
      source: 'q378-approved-ocr-workspace-import',
    );
    _syncingMathLiveExpression = false;
    _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();
    await _mathLiveMainEditor.setLatexFromApprovedOcrImport(trimmed);
    if (!mounted) return;
    setState(() {
      _historyVisible = false;
      _stepsPanelState = SolutionStepsPanelState.closed;
      _graphPreviewVisible = false;
      _activeGraphHistoryEntryId = null;
      _selectedWorkspaceMathAction = null;
      _workspaceExpressionAllSelectedFromContextMenu = false;
    });
  }

  Future<bool> _dispatchQ382R25LatencyCourtLabel(String label) async {
    // Q382R25: debug-only direct bridge court.  This is inert unless the app is
    // launched with --dart-define=MATHPRO_LATENCY_COURT=true.  It does not alter
    // production keyboard behavior; it only lets one device run sweep coverage
    // without the user manually tapping every keyboard/MORE/long-press label.
    MathProLatencyProbeQ382R23.instance.recordPremiumKeyTapDown(label);
    MathProLatencyProbeQ382R23.instance.recordPremiumKeyTap(label);
    _mathLiveMainEditor.markKeyboardTap(label);
    final sent = _mathLiveMainEditor.sendKeyFast(label, lastAnswer: _calculator.state.lastAnswer);
    _mathLiveMainEditor.markBridgeSendResult(label, sent: sent);
    return sent;
  }

  void _handleKeyPressed(String label) {
    MathProLatencyProbeQ382R23.instance.recordPremiumKeyTap(label);
    final wasTemplateTrayOpen = _calculator.state.templateTrayOpen;
    final workspaceSelectionActive = _selectedWorkspaceMathAction != null || _workspaceExpressionAllSelectedFromContextMenu;

    if (label != 'MORE' && label != '↵') {
      _clearWorkspaceContextStateForExpressionEdit();
    }

    if (label != 'MORE') {
      if (label == '↵') {
        _resetQ382R27OptimisticLinearEcho();
        _evaluateMathLiveExpression();
        return;
      }

      _mathLiveMainEditor.markKeyboardTap(label);
      if (label == 'C') {
        _q382r33r3LastAppliedMathLiveCommandSequence = 0;
        _resetQ382R27OptimisticLinearEcho();
        _calculator.syncExternalEditorExpression(
          expression: '',
          source: MathLiveMainEditorStateAuthorityPolicy.clearSource,
        );
        _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();
      } else if (!_tryApplyQ382R27OptimisticLinearEcho(
        label,
        workspaceSelectionActive: workspaceSelectionActive,
      )) {
        _resetQ382R27OptimisticLinearEchoIfNonLinear(label);
      }
      final sent = _mathLiveMainEditor.sendKeyFast(label, lastAnswer: _calculator.state.lastAnswer);
      _mathLiveMainEditor.markBridgeSendResult(label, sent: sent);
      return;
    }

    _resetQ382R27OptimisticLinearEcho();
    _calculator.handleKey(label);
    final templateTrayOpened = label == 'MORE' && !wasTemplateTrayOpen && _calculator.state.templateTrayOpen;
    if (templateTrayOpened) {
      setState(() {
        _historyVisible = false;
        _stepsPanelState = SolutionStepsPanelState.closed;
        _graphPreviewVisible = false;
        _activeGraphHistoryEntryId = null;
      });
    }
  }

  void _handleMathLiveStateChanged(MathLiveEditorStateSnapshot snapshot) {
    MathProLatencyProbeQ382R23.instance.recordAppShellStateHandled(
      label: snapshot.lastCommandLabel,
    );
    _reconcileQ382R27OptimisticLinearEcho(snapshot);
    if (_syncingMathLiveExpression) return;

    if (KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel(snapshot.lastCommandLabel)) {
      _q382r24PendingMathLiveSnapshot = snapshot;
      _q382r24MathLiveDownstreamSyncDebounce?.cancel();
      // Q382R24 compatibility marker: KeyboardLatencyClosureQ382R24Policy.controllerSyncDebounce
      // is superseded by the Q382R29 category-aware duration below.
      _q382r24MathLiveDownstreamSyncDebounce = Timer(
        KeyboardLatencyClosureQ382R24Policy.controllerSyncDebounceForLabel(snapshot.lastCommandLabel),
        _flushQ382R24PendingMathLiveSnapshot,
      );
      return;
    }

    _applyMathLiveSnapshotToDownstreamState(snapshot);
  }

  void _flushQ382R24PendingMathLiveSnapshot() {
    final snapshot = _q382r24PendingMathLiveSnapshot;
    _q382r24PendingMathLiveSnapshot = null;
    _q382r24MathLiveDownstreamSyncDebounce?.cancel();
    _q382r24MathLiveDownstreamSyncDebounce = null;
    if (snapshot == null) return;
    _applyMathLiveSnapshotToDownstreamState(snapshot);
  }

  bool _tryApplyQ382R27OptimisticLinearEcho(
    String label, {
    required bool workspaceSelectionActive,
  }) {
    final canApply = MathLiveSafeOptimisticLinearEchoQ382R27Policy.canApply(
      label: label,
      caretContext: _q382r27LastCaretContext,
      continuingOptimisticChain: _q382r27OptimisticChainActive,
      workspaceSelectionActive: workspaceSelectionActive,
    );
    if (!canApply) return false;

    final baseExpression = _q382r27OptimisticExpression ?? _calculator.state.expressionText;
    final nextExpression = MathLiveSafeOptimisticLinearEchoQ382R27Policy.appendLabel(
      expression: baseExpression,
      label: label,
    );
    if (nextExpression == baseExpression) return false;

    _q382r27OptimisticExpression = nextExpression;
    _q382r27OptimisticChainActive = true;
    _mathLiveMainEditor.suppressNextExternalExpressionSyncForOptimisticEcho();
    _calculator.syncExternalEditorExpression(
      expression: nextExpression,
      source: MathLiveSafeOptimisticLinearEchoQ382R27Policy.optimisticSource,
    );
    return true;
  }

  void _reconcileQ382R27OptimisticLinearEcho(MathLiveEditorStateSnapshot snapshot) {
    _q382r27LastCaretContext = snapshot.caretContext;
    final canonical = snapshot.normalizedLatex.trim().isEmpty
        ? snapshot.latex.trim()
        : snapshot.normalizedLatex.trim();
    final optimistic = _q382r27OptimisticExpression;
    if (optimistic == null) {
      if (!snapshot.mayAllowOptimisticLinearAppend) _q382r27OptimisticChainActive = false;
      return;
    }
    if (canonical == optimistic) {
      _q382r27OptimisticExpression = null;
      _q382r27OptimisticChainActive = false;
      return;
    }
    if (canonical.isNotEmpty && !optimistic.startsWith(canonical)) {
      _resetQ382R27OptimisticLinearEcho();
    }
  }

  void _resetQ382R27OptimisticLinearEchoIfNonLinear(String label) {
    if (!MathLiveSafeOptimisticLinearEchoQ382R27Policy.isOptimisticLinearLabel(label)) {
      _resetQ382R27OptimisticLinearEcho();
    }
  }

  void _resetQ382R27OptimisticLinearEcho() {
    _q382r27OptimisticExpression = null;
    _q382r27OptimisticChainActive = false;
    _q382r27LastCaretContext = const MathLiveCaretContextSnapshot.unknown();
  }

  bool _shouldDiscardQ382R33R3StaleMathLiveSnapshot(MathLiveEditorStateSnapshot snapshot) {
    if (!MathLiveKeyOrderingRegressionQ382R33R3Policy.staleFlutterSnapshotGuardEnabled) return false;
    final sequence = snapshot.lastCommandSequence;
    if (sequence <= 0) return false;
    return sequence < _q382r33r3LastAppliedMathLiveCommandSequence;
  }

  void _applyMathLiveSnapshotToDownstreamState(MathLiveEditorStateSnapshot snapshot) {
    if (_syncingMathLiveExpression) return;
    if (_shouldDiscardQ382R33R3StaleMathLiveSnapshot(snapshot)) {
      // V172-Q382R33R3: a late canonical state from an older key sequence must
      // never overwrite a newer rapid typing chain (e.g. 88888 then 7777).
      return;
    }
    final envelope = MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.buildFinalizedProductionEnvelope(snapshot);
    _lastMathLiveProductionStateEnvelope = envelope;
    final expression = MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForController(envelope);
    // Q144 compatibility marker: MathLiveMainEditorStateAuthorityPolicy.snapshotSource is superseded by Q188 production adapter snapshotSource for active MathLive state writes.
    // V172-Q188/Q202 still owns Graph/History/Solution truth.  Q382R24 changes
    // only timing: ordinary keyboard states are batched so EvaluatorBridge/Graph/
    // History/Solution envelope work does not run on every key frame.
    if (snapshot.lastCommandSequence > _q382r33r3LastAppliedMathLiveCommandSequence) {
      _q382r33r3LastAppliedMathLiveCommandSequence = snapshot.lastCommandSequence;
    }
    if (expression == _calculator.state.expressionText) return;
    _clearWorkspaceContextStateForExpressionEdit();
    _syncingMathLiveExpression = true;
    _calculator.syncExternalEditorExpression(
      expression: expression,
      source: MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.snapshotSource,
    );
    _syncingMathLiveExpression = false;
  }

  void _evaluateMathLiveExpression() {
    _flushQ382R24PendingMathLiveSnapshot();
    final envelope = _lastMathLiveProductionStateEnvelope;
    if (envelope == null) return;
    final expression = MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForEvaluation(envelope);
    if (expression.isNotEmpty && expression != _calculator.state.expressionText) {
      _calculator.syncExternalEditorExpression(
        expression: expression,
        source: MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.evaluationSource,
      );
    }
    _calculator.handleKey('↵');
    _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();
    _recordEvaluationIfNeeded();
  }

  void _recordEvaluationIfNeeded() {
    final state = _calculator.state;
    final envelope = _lastMathLiveProductionStateEnvelope;
    if (envelope == null) return;
    final expression = MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForHistory(envelope);
    if (expression.trim().isEmpty) return;
    final errorState = state.lastUnsupportedReason ?? envelope.evaluatorUnsupportedReason;
    final signature = '$expression|${state.result}|$errorState';
    if (signature == _lastHistorySignature) return;
    _lastHistorySignature = signature;
    _history.addCalculation(
      expression: expression,
      result: state.result,
      tabName: _activeTab,
      errorState: errorState,
    );
  }


  void _handleWorkspaceMathActionSelected(WorkspaceMathAction action, WorkspaceMathActionResolution resolution) {
    if (!action.enabled) {
      _showWorkspaceContextMessage(action.disabledReason ?? 'Bu işlem henüz desteklenmiyor.');
      return;
    }
    final expression = resolution.expression.trim();
    if (expression.isEmpty) return;
    setState(() {
      _selectedWorkspaceMathAction = WorkspaceSelectedMathAction.fromAction(
        action: action,
        expressionKind: resolution.expressionKind,
        expression: expression,
        variable: resolution.variable,
      );
      _workspaceExpressionAllSelectedFromContextMenu = false;
    });
    _showWorkspaceContextMessage(
      action.requiresSolverHandler && !action.supportedByCurrentEngine
          ? 'İşlem niyeti seçildi; gerçek handler yoksa sahte sonuç gösterilmeyecek.'
          : 'İşlem: ${action.shortLabel}',
    );
  }

  Future<void> _handleWorkspaceEditorAction(WorkspaceEditorActionType action) async {
    final expression = _calculator.state.expressionText;
    final WorkspaceEditorActionResult result = switch (action) {
      WorkspaceEditorActionType.copy => await WorkspaceEditorActions.copyAll(expression),
      WorkspaceEditorActionType.paste => await WorkspaceEditorActions.pasteFromClipboard(),
      WorkspaceEditorActionType.cut => await WorkspaceEditorActions.cutAll(expression),
      WorkspaceEditorActionType.selectAll => WorkspaceEditorActions.selectAllContext(expression),
      WorkspaceEditorActionType.clear => WorkspaceEditorActions.clearAll(expression),
    };
    if (action == WorkspaceEditorActionType.selectAll && result.success) {
      _workspaceExpressionAllSelectedFromContextMenu = true;
    }

    final replacement = result.replacementExpression;
    var userMessage = result.message;
    if (replacement != null) {
      _resetQ382R27OptimisticLinearEcho();
      _q382r33r3LastAppliedMathLiveCommandSequence = 0;
      _clearWorkspaceMathActionSilently();
      _calculator.syncExternalEditorExpression(
        expression: replacement,
        source: 'q382-workspace-expression-context-menu-${action.name}',
      );
      final synced = await _mathLiveMainEditor.setLatexFromWorkspaceContextMenu(replacement);
      if (!synced) {
        userMessage = 'İfade güncellendi; editor eşitlemesi bekleniyor.';
      }
      if (mounted) setState(() {});
    } else if (action == WorkspaceEditorActionType.selectAll && result.success && mounted) {
      setState(() {});
    }
    _showWorkspaceContextMessage(userMessage);
  }

  void _clearWorkspaceMathActionFromChip() {
    if (_selectedWorkspaceMathAction == null && !_workspaceExpressionAllSelectedFromContextMenu) return;
    setState(() {
      _selectedWorkspaceMathAction = null;
      _workspaceExpressionAllSelectedFromContextMenu = false;
    });
  }

  void _clearWorkspaceMathActionSilently() {
    _selectedWorkspaceMathAction = null;
    _workspaceExpressionAllSelectedFromContextMenu = false;
  }

  void _clearWorkspaceContextStateForExpressionEdit() {
    if (_selectedWorkspaceMathAction == null && !_workspaceExpressionAllSelectedFromContextMenu) return;
    if (!mounted) {
      _clearWorkspaceMathActionSilently();
      return;
    }
    setState(() {
      _selectedWorkspaceMathAction = null;
      _workspaceExpressionAllSelectedFromContextMenu = false;
    });
  }

  void _showWorkspaceContextMessage(String message) {
    if (!mounted || message.trim().isEmpty) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1400),
      ),
    );
  }

  void _handleGraphPressed() {
    _flushQ382R24PendingMathLiveSnapshot();
    if (ResultSolutionIdlePipelineQ382R31Policy.graphHistoryExplicitActionsFlushIdlePipeline) {
      _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();
    }
    final envelope = _lastMathLiveProductionStateEnvelope;
      if (envelope == null) {
        _showGraphMessage('MathLive production state henüz hazır değil.');
        return;
      }
      final graphExpression = MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForGraph(envelope);
      if (graphExpression.isEmpty) {
        _showGraphMessage(envelope.hasOpenSlots
            ? 'Açık slotlar doldurulmadan grafik üretilmedi.'
            : 'Graph için geçerli MathLive production state bulunamadı.');
        return;
      }
      final state = _calculator.state;
      final eligibility = GraphEligibility.classify(
        expression: graphExpression,
        result: state.result,
      );
      if (MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.canOpenGraphDirectly(envelope)) {
        _openGraph(GraphEligibility.expressionFromEligibility(
          originalExpression: graphExpression,
          result: eligibility,
        ));
        return;
      }
      if (envelope.asksForConstantGraph || eligibility.kind == GraphEligibilityKind.constantSuggestion) {
        _showConstantGraphSuggestion(eligibility);
        return;
      }
      if (envelope.graphImplicitPending || envelope.graphNotGraphable) {
        _showGraphMessage(envelope.graphEligibilityMessage.isEmpty ? eligibility.message : envelope.graphEligibilityMessage);
        return;
      }
      return;
  }

  void _showConstantGraphSuggestion(GraphEligibilityResult eligibility) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final value = eligibility.normalizedExpression ?? '0';
        return SafeArea(
          top: false,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF111418),
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Sabit Fonksiyon', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(
                  'Bu ifade değişken içermiyor. İstersen sonucu sabit fonksiyon olarak çizebilirim.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.70), fontSize: 14, height: 1.35, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _openGraph(GraphEligibility.expressionFromEligibility(
                            originalExpression: _calculator.state.expressionText,
                            result: eligibility,
                          ));
                        },
                        child: Text('y = $value olarak çiz'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('İptal')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setGraphRenderMode(GraphRenderMode mode) {
    if (_graphRenderMode == mode) return;
    setState(() => _graphRenderMode = mode);
  }

  void _openGraph(GraphExpression expression) {
    _flushQ382R24PendingMathLiveSnapshot();
    _closeTemplateTrayIfOpen();
    final linkedEntry = _history.addGraph(graphExpression: expression, result: _calculator.state.result, tabName: _activeTab);
    final openedGraph = linkedEntry.graphExpression ?? expression;
    setState(() {
      _historyVisible = false;
      _stepsPanelState = SolutionStepsPanelState.closed;
      _activeGraph = openedGraph;
      _activeGraphHistoryEntryId = linkedEntry.id;
      _graphRenderMode = openedGraph.preferredRenderMode;
      _graphPreviewVisible = true;
    });
  }

  void _openGraphFromHistory(HistoryEntry entry) {
    final graph = entry.graphExpression;
    if (graph == null) return;
    setState(() {
      _stepsPanelState = SolutionStepsPanelState.closed;
      _activeGraph = graph;
      _activeGraphHistoryEntryId = entry.id;
      _graphRenderMode = graph.preferredRenderMode;
      _graphPreviewVisible = true;
      _historyVisible = false;
    });
  }

  void _restoreHistoryEntry(HistoryEntry entry) {
    _resetQ382R27OptimisticLinearEcho();
    _q382r33r3LastAppliedMathLiveCommandSequence = 0;
    _calculator.restoreExpression(expression: entry.expression.replaceFirst(RegExp(r'^y\s*=\s*'), ''), result: entry.result, source: 'history-entry');
    setState(() {
      _historyVisible = false;
      _graphPreviewVisible = false;
      _activeGraphHistoryEntryId = null;
      _graphRenderMode = GraphRenderMode.twoD;
      _selectedWorkspaceMathAction = null;
      _workspaceExpressionAllSelectedFromContextMenu = false;
    });
  }

  void _useHistoryResult(HistoryEntry entry) {
    if (!entry.canUseResult) return;
    _resetQ382R27OptimisticLinearEcho();
    _q382r33r3LastAppliedMathLiveCommandSequence = 0;
    _calculator.restoreExpression(expression: entry.result, result: entry.result, source: 'history-result');
    setState(() {
      _historyVisible = false;
      _graphPreviewVisible = false;
      _activeGraphHistoryEntryId = null;
      _selectedWorkspaceMathAction = null;
      _workspaceExpressionAllSelectedFromContextMenu = false;
    });
  }

  void _closeGraphPreview() {
    setState(() {
      _graphPreviewVisible = false;
      _activeGraphHistoryEntryId = null;
    });
  }

  Future<void> _openFullscreenGraph() async {
    final graph = _activeGraph;
    if (graph == null) return;
    _closeTemplateTrayIfOpen();
    if (_historyVisible || _stepsPanelState.isOpen) {
      setState(() {
        _historyVisible = false;
        _stepsPanelState = SolutionStepsPanelState.closed;
      });
    }
    final updated = await Navigator.of(context).push<GraphFullscreenResult>(
      PageRouteBuilder<GraphFullscreenResult>(
        transitionDuration: _AppShellMotion.fullscreenPush,
        reverseTransitionDuration: _AppShellMotion.fullscreenPop,
        pageBuilder: (_, __, ___) => GraphFullscreenPage(expression: graph, initialRenderMode: _graphRenderMode),
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
          final reverseFade = Tween<double>(begin: 1, end: 0.92).animate(secondaryAnimation);
          return FadeTransition(
            opacity: reverseFade,
            child: FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.035), end: Offset.zero).animate(curved),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.985, end: 1).animate(curved),
                  child: child,
                ),
              ),
            ),
          );
        },
      ),
    );
    if (updated != null && mounted) {
      _applyGraphUpdate(updated.expression, renderMode: updated.renderMode);
    }
  }

  void _openGraphSettings() {
    final graph = _activeGraph;
    if (graph == null) return;
    showModalBottomSheet<GraphExpression>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => GraphSettingsSheet(
        expression: graph,
        renderMode: _graphRenderMode,
        onRenderModeChanged: _setGraphRenderMode,
        onApply: (updated) => _applyGraphUpdate(GraphViewportPolicy.sanitize(updated), renderMode: _graphRenderMode),
      ),
    );
  }

  void _toggleGraphTrace() {
    final graph = _activeGraph;
    if (graph == null) return;
    _applyGraphUpdate(graph.copyWith(traceEnabled: !graph.traceEnabled), renderMode: _graphRenderMode);
  }

  void _resetGraphViewport() {
    final graph = _activeGraph;
    if (graph == null) return;
    _applyGraphUpdate(graph.resetViewport(), renderMode: _graphRenderMode);
  }

  void _zoomGraph(double factor) {
    final graph = _activeGraph;
    if (graph == null) return;
    final xCenter = (graph.xMin + graph.xMax) / 2;
    final yCenter = (graph.yMin + graph.yMax) / 2;
    final halfX = (graph.xMax - graph.xMin) * factor / 2;
    final halfY = (graph.yMax - graph.yMin) * factor / 2;
    _applyGraphUpdate(
      GraphViewportPolicy.sanitize(
        graph.copyWith(
          xMin: xCenter - halfX,
          xMax: xCenter + halfX,
          yMin: yCenter - halfY,
          yMax: yCenter + halfY,
        ),
      ),
      renderMode: _graphRenderMode,
    );
  }

  void _applyGraphUpdate(GraphExpression updated, {GraphRenderMode? renderMode}) {
    final sanitized = GraphViewportPolicy.sanitize(updated);
    HistoryEntry? linkedEntry;
    final linkedId = _activeGraphHistoryEntryId;
    if (linkedId != null) {
      linkedEntry = _history.updateGraphEntry(
        id: linkedId,
        graphExpression: sanitized,
      );
    }
    final effectiveEntry = linkedEntry ?? _history.addGraph(graphExpression: sanitized, result: _calculator.state.result, tabName: _activeTab);
    final effectiveGraph = effectiveEntry.graphExpression ?? sanitized;
    setState(() {
      _activeGraph = effectiveGraph;
      _activeGraphHistoryEntryId = effectiveEntry.id;
      _graphRenderMode = renderMode ?? effectiveGraph.preferredRenderMode;
      _graphPreviewVisible = true;
    });
  }

  void _toggleSolutionStepsPanel() {
    _closeTemplateTrayIfOpen();
    final willOpen = !_stepsPanelState.isOpen;
    final selectedAction = _selectedWorkspaceMathAction;
    if (willOpen && selectedAction?.hasUnsupportedSolverHandler == true) {
      _showWorkspaceContextMessage('Bu işlem henüz desteklenmiyor; sahte sonuç gösterilmiyor.');
    }
    if (willOpen) {
      _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();
    }
    setState(() {
      _historyVisible = false;
      _graphPreviewVisible = false;
      _stepsPanelState = _stepsPanelState.isOpen
          ? SolutionStepsPanelState.closed
          : SolutionStepsPanelState.medium;
    });
  }

  void _toggleSolutionStepsExpanded() {
    setState(() {
      _stepsPanelState = _stepsPanelState.isExpanded
          ? SolutionStepsPanelState.medium
          : SolutionStepsPanelState.expanded;
    });
  }

  void _closeSolutionStepsPanel() {
    setState(() => _stepsPanelState = SolutionStepsPanelState.closed);
  }

  void _openHistory() {
    _closeTemplateTrayIfOpen();
    setState(() {
      _stepsPanelState = SolutionStepsPanelState.closed;
      _graphPreviewVisible = false;
      _activeGraphHistoryEntryId = null;
      _historyVisible = true;
    });
  }

  void _closeHistory() {
    setState(() => _historyVisible = false);
  }

  void _closeTemplateTrayIfOpen() {
    if (_calculator.state.templateTrayOpen) {
      _calculator.handleKey('MORE');
    }
  }

  void _showGraphMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

@immutable
class _SolutionStepsMemoKey {
  const _SolutionStepsMemoKey({
    required this.expression,
    required this.result,
    this.unsupportedReason,
    this.selectedActionId,
    this.selectedActionLabel,
    this.selectedExpressionKind,
    this.selectedActionRequiresSolverHandler,
    this.selectedActionSupportedByCurrentEngine,
  });

  final String expression;
  final String result;
  final String? unsupportedReason;
  final String? selectedActionId;
  final String? selectedActionLabel;
  final String? selectedExpressionKind;
  final bool? selectedActionRequiresSolverHandler;
  final bool? selectedActionSupportedByCurrentEngine;

  @override
  bool operator ==(Object other) {
    return other is _SolutionStepsMemoKey &&
        other.expression == expression &&
        other.result == result &&
        other.unsupportedReason == unsupportedReason &&
        other.selectedActionId == selectedActionId &&
        other.selectedActionLabel == selectedActionLabel &&
        other.selectedExpressionKind == selectedExpressionKind &&
        other.selectedActionRequiresSolverHandler == selectedActionRequiresSolverHandler &&
        other.selectedActionSupportedByCurrentEngine == selectedActionSupportedByCurrentEngine;
  }

  @override
  int get hashCode => Object.hash(
        expression,
        result,
        unsupportedReason,
        selectedActionId,
        selectedActionLabel,
        selectedExpressionKind,
        selectedActionRequiresSolverHandler,
        selectedActionSupportedByCurrentEngine,
      );
}

