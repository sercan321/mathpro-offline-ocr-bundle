/// V172-Q190R7 — Production Legacy Fallback Isolation.
///
/// No new math feature is introduced in this phase. The active production
/// MathLive route is locked so AppShell/CalculatorController mirror text and
/// legacy Flutter fallback overlays cannot become the visible editor authority.
/// MathLive state must be produced by the production WebView bridge/state push.
class MathLiveProductionLegacyFallbackIsolationPolicy {
  const MathLiveProductionLegacyFallbackIsolationPolicy._();

  static const String phase = 'V172-Q190R7';
  static const String baseline = 'V172-Q190R6_NO_FREEZE_RUNTIME_INVARIANT';
  static const String repairScope = 'production-legacy-fallback-isolation';

  static const bool newFeatureAllowed = false;
  static const bool appShellVisibleFallbackFeedsSurface = false;
  static const bool singleCommandBusBlocksFlutterOverlay = true;
  static const bool productionSurfaceIgnoresVisibleLatexMirror = true;
  static const bool productionStateMustComeFromBridgePush = true;
  static const bool productionRouteUsesMainEditorProdHtml = true;
  static const bool productionRouteUsesProdBridge = true;
  static const bool legacySurfacePhysicalCleanupCompleted = false;

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;

  static const bool androidRealDevicePassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
}
