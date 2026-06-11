/// V172-Q190R8 — Production Static Asset Truth Closure.
///
/// This is not a visual PASS claim. It closes the code-level contradiction where
/// production HTML inlined CSS that referenced MathLive font files that are not
/// physically bundled in the package. Q190R8 keeps MathLive static CSS in the
/// production route, strips missing @font-face url(fonts/*.woff2) rules before
/// WebView load, and records the font bundle truth explicitly.
class MathLiveProductionStaticAssetTruthPolicy {
  static const String phase = 'V172-Q190R8';
  static const String baseline = 'V172-Q190R7_PRODUCTION_LEGACY_FALLBACK_ISOLATION';
  static const String repairScope = 'production-static-font-asset-truth-closure';

  static const bool newFeatureAllowed = false;
  static const bool productionRouteUsesMathLiveStaticCss = true;
  static const bool localMathLiveFontFilesBundled = false;
  static const bool stripMissingFontFaceRulesFromProductionInlineCss = true;
  static const bool productionInlineCssMayReferenceMissingFontFiles = false;
  static const bool productionManifestMustExposeFontTruth = true;

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
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
  static const bool legacySurfacePhysicalCleanupCompleted = false;
}
