/// V172-Q226 — Result status message inside result panel / workspace gap cleanup.
///
/// This phase is a narrow UI/state routing repair. Evaluation/status messages
/// that explain why a result was not produced are rendered inside the SONUÇ
/// result panel through `resultStatusMessage`; the previous independent strip
/// between workspace and keyboard is removed from the layout budget. It does
/// not change keyboard layout, MORE, long-press, MathLive production editor,
/// Graph, History, Solution, splash/startup, solver, or cursor behavior.
class ResultStatusMessageInsideResultPanelPolicy {
  const ResultStatusMessageInsideResultPanelPolicy._();

  static const String phase = 'V172-Q226';
  static const String fullPhase = 'V172-Q226-RESULT-STATUS-MESSAGE-INSIDE-RESULT-PANEL-WORKSPACE-GAP-CLEANUP';
  static const String baseline = 'V172-Q225-GRAPH-MINI-PANEL-VISUAL-PARITY-CANVAS-DOMINANCE';

  static const bool resultStatusMessageStateAdded = true;
  static const bool resultStatusMessageRendersInsideResultPanel = true;
  static const bool resultValueHasPriorityOverStatusMessage = true;
  static const bool resultAndStatusNeverRenderTogether = true;
  static const bool independentWorkspaceKeyboardStatusStripRemoved = true;
  static const bool workspaceKeyboardGapBudgetReleased = true;
  static const bool statusMessageMaxTwoLinesWithEllipsis = true;
  static const bool statusMessageUsesMutedPremiumStyle = true;
  static const bool emptyResultStateDoesNotRenderLegacyBanner = true;

  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool graphMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool splashStartupMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool cursorMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
  static const bool premiumVisualPassClaimedByAssistant = false;
}
