/// V172-Q225 — Graph mini panel visual parity repair / canvas dominance pass.
///
/// This phase is a narrow visual-parity repair after Q224. It increases the
/// small graph card's canvas dominance, makes trace off by default for new
/// preview graphs, and binds the 3D mini surface to the same compact/tight fit
/// state as the 2D canvas. It does not change graph evaluation, fullscreen
/// runtime behavior, keyboard, MathLive, History, Solution, splash/startup,
/// launcher icon, solver, or cursor logic.
class GraphMiniPanelVisualParityRepairPolicy {
  const GraphMiniPanelVisualParityRepairPolicy._();

  static const String phase = 'V172-Q225';
  static const String fullPhase = 'V172-Q225-GRAPH-MINI-PANEL-VISUAL-PARITY-CANVAS-DOMINANCE';
  static const String baseline = 'V172-Q224-GRAPH-MINI-PANEL-FINAL-REGRESSION-PACKAGE-FREEZE';

  static const bool canvasDominanceRepairAdded = true;
  static const bool normalGraphCardHeightRaised = true;
  static const bool compactGraphCardHeightRaised = true;
  static const bool headerChromeThinnedForCanvasDominance = true;
  static const bool infoRowChromeThinnedForCanvasDominance = true;
  static const bool graphPreviewMustRemainUncroppedWhenTight = true;
  static const bool traceDefaultCleanStateAdded = true;
  static const bool miniPanelTraceOverlayDefaultOff = true;
  static const bool traceStillControlledFromSettingsSheet = true;
  static const bool threeDMiniSurfaceCompactBindingAdded = true;
  static const bool threeDCompactTextClutterSuppressed = true;
  static const bool noFakeThreeDPassClaimAllowed = true;

  static const bool graphRuntimeEvaluatorMutationAllowed = false;
  static const bool graphEligibilityMutationAllowed = false;
  static const bool graphFullscreenRuntimeMutationAllowed = false;
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
