/// V172-Q221 — Graph mini panel layout simplification.
///
/// This is a graph-preview UI phase only. It removes the dense text-action rail
/// from the small graph card and makes the canvas the visual authority while
/// preserving Graph runtime, keyboard, MathLive, History, Solution, splash and
/// launcher-icon behavior.
class GraphMiniPanelLayoutSimplificationPolicy {
  const GraphMiniPanelLayoutSimplificationPolicy._();

  static const String phase = 'V172-Q221';
  static const String fullPhase = 'V172-Q221-GRAPH-MINI-PANEL-LAYOUT-SIMPLIFICATION';
  static const String baseline = 'V172-Q219-GAUSS-BOOT-VISIBILITY-BLACK-SCREEN-ROOT-CAUSE-REPAIR';

  static const bool graphMiniPanelSimplified = true;
  static const bool graphCanvasIsPrimaryVisualFocus = true;
  static const bool largeDomainRangePillsRemovedFromMiniPanel = true;
  static const bool textTraceResetZoomButtonsRemovedFromMiniPanel = true;
  static const bool floatingZoomControlsAddedInsideCanvas = true;
  static const bool compactBottomInfoRowAdded = true;
  static const bool graphPreviewScalesInsteadOfCroppingWhenTight = true;
  static const bool settingsSheetDeferredToNextPhase = true;

  static const bool graphRuntimeBehaviorMutationAllowed = false;
  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool solutionMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool splashMutationAllowed = false;
  static const bool launcherIconMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
  static const bool premiumVisualPassClaimedByAssistant = false;
}
