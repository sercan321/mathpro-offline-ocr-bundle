/// V172-Q190R9 — Static Pre-Analyze Hygiene Closure.
///
/// This phase does not claim Flutter analyze/test/run PASS. It closes the
/// code-level pre-analyze hygiene contract that can be verified from the ZIP
/// without a Dart SDK: local/package imports must resolve, Q190 production
/// helper methods must stay inside the production state class, the active
/// production route must not reintroduce returning-result WebView reads, and
/// protected UI files must remain untouched.
class MathLiveStaticPreAnalyzeHygienePolicy {
  const MathLiveStaticPreAnalyzeHygienePolicy._();

  static const String phase = 'V172-Q190R9';
  static const String baseline = 'V172-Q190R8_PRODUCTION_STATIC_ASSET_TRUTH_CLOSURE';
  static const String repairScope = 'static-pre-analyze-hygiene-closure';

  static const bool newFeatureAllowed = false;
  static const bool finalReleaseClaimAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;

  static const bool localDartImportsMustResolve = true;
  static const bool packageDartImportsMustResolveToLib = true;
  static const bool productionHelpersMayExistOnlyInProductionState = true;
  static const bool productionClassMayUseRunJavaScriptReturningResult = false;
  static const bool legacyClassMayContainQ190ProductionHelpers = false;
  static const bool protectedFilesMayContainQ190R9Markers = false;
  static const bool zipHygieneRequired = true;

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool legacySurfacePhysicalCleanupCompleted = false;
}
