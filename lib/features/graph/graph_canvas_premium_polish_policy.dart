/// V172-Q223 — Graph canvas premium polish and responsive QA.
///
/// This is a graph-preview visual polish phase only. It improves the mini
/// graph canvas surface, grid/axis/curve balance, floating zoom sizing, and
/// tight-height fit behavior without changing graph evaluation, keyboard,
/// MathLive, History, Solution, splash/startup, launcher icon, or solver logic.
class GraphCanvasPremiumPolishPolicy {
  const GraphCanvasPremiumPolishPolicy._();

  static const String phase = 'V172-Q223';
  static const String fullPhase = 'V172-Q223-GRAPH-CANVAS-PREMIUM-POLISH-RESPONSIVE-QA';
  static const String baseline = 'V172-Q222-GRAPH-SETTINGS-BOTTOM-SHEET-CONTROL-MIGRATION';

  static const bool graphCanvasPremiumPolished = true;
  static const bool premiumSurfaceGradientAdded = true;
  static const bool pixelTightCanvasFitGuardAdded = true;
  static const bool graphPreviewScalesInsteadOfCroppingWhenTight = true;
  static const bool floatingZoomControlsScaleDownWhenTight = true;
  static const bool gridAxisCurveVisualBalancePolished = true;
  static const bool axisLabelsSuppressedWhenTooTight = true;
  static const bool miniPanelRemainsCanvasFirst = true;
  static const bool settingsSheetPreserved = true;

  static const bool graphRuntimeEvaluatorMutationAllowed = false;
  static const bool graphEligibilityMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool splashStartupMutationAllowed = false;
  static const bool launcherIconMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
  static const bool premiumVisualPassClaimedByAssistant = false;
}
