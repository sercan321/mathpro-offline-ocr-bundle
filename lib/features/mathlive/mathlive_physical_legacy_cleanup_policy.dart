/// V172-Q194 — Physical Legacy Cleanup policy.
///
/// This phase removes the diagnostic-heavy legacy `_MathLiveMainEditorSurfaceState`
/// implementation and the Flutter visible fallback overlay from the production
/// package. The public `MathLiveMainEditorSurface` symbol remains only as a
/// compatibility shim that forwards to `MathLiveProductionEditorSurface`, so a
/// stale call site cannot revive the old Q169/court/fallback rendering path.
class MathLivePhysicalLegacyCleanupPolicy {
  const MathLivePhysicalLegacyCleanupPolicy._();

  static const String phase = 'V172-Q194';
  static const String baseline = 'V172-Q193_REAL_MATHLIVE_FONT_BUNDLE_CLOSURE';
  static const String cleanupName = 'physical-legacy-cleanup';

  static const bool newFeatureAllowed = false;
  static const bool legacyMainEditorStatePhysicallyRemoved = true;
  static const bool visibleFallbackOverlayPhysicallyRemoved = true;
  static const bool diagnosticOverlayPhysicallyRemoved = true;
  static const bool publicCompatibilityShimKept = true;
  static const bool compatibilityShimForwardsToProductionSurface = true;
  static const bool productionSurfaceRemainsActive = true;
  static const bool staleLegacyCallSiteMayReviveQ169Surface = false;
  static const bool fallbackMirrorMayOwnVisibleEditor = false;

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
}
