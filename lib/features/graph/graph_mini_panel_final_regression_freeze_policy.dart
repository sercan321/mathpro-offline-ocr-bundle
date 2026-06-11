/// V172-Q224 — Graph mini panel final regression / package freeze.
///
/// This is a guard-only freeze phase for the redesigned small graph panel. It
/// locks the Q221-Q223 premium mini-panel contract so the old dense debug-like
/// control rail cannot return without an explicit phase. It does not change
/// graph evaluation, fullscreen behavior, keyboard, MathLive, History,
/// Solution, splash/startup, launcher icon, solver, or cursor logic.
class GraphMiniPanelFinalRegressionFreezePolicy {
  const GraphMiniPanelFinalRegressionFreezePolicy._();

  static const String phase = 'V172-Q224';
  static const String fullPhase = 'V172-Q224-GRAPH-MINI-PANEL-FINAL-REGRESSION-PACKAGE-FREEZE';
  static const String baseline = 'V172-Q223-GRAPH-CANVAS-PREMIUM-POLISH-RESPONSIVE-QA';

  static const bool finalRegressionFreezeAdded = true;
  static const bool oldTextActionRailMustRemainAbsent = true;
  static const bool largeDomainRangePillsMustRemainAbsent = true;
  static const bool miniPanelMustRemainCanvasFirst = true;
  static const bool settingsBottomSheetMustRemainSeparated = true;
  static const bool floatingZoomControlsMustRemainInsideCanvas = true;
  static const bool compactInfoRowMustRemainPresent = true;
  static const bool graphPreviewMustScaleInsteadOfCroppingWhenTight = true;
  static const bool premiumCanvasPolishMustRemainPresent = true;
  static const bool noFakeThreeDPassClaimAllowed = true;

  static const bool graphRuntimeEvaluatorMutationAllowed = false;
  static const bool graphEligibilityMutationAllowed = false;
  static const bool graphFullscreenMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool splashStartupMutationAllowed = false;
  static const bool launcherIconMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool cursorMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
  static const bool premiumVisualPassClaimedByAssistant = false;
  static const bool threeDGraphPassClaimedByAssistant = false;
}
