/// V172-Q196 — Official MathLive Font Bundle Ingestion policy.
///
/// Q196 is the code/static closure for premium MathLive font assets. The
/// official MathLive 0.109.2 npm package fonts are bundled under
/// assets/mathlive/vendor/mathlive/fonts and are embedded into production CSS
/// as data URLs before WebView load. This is required because the production
/// editor is loaded with loadHtmlString, where relative url(fonts/*.woff2)
/// references are not a reliable Android asset transport.
class MathLiveOfficialFontBundleIngestionPolicy {
  const MathLiveOfficialFontBundleIngestionPolicy._();

  static const String phase = 'V172-Q196';
  static const String baseline = 'V172-Q195_FINAL_STATIC_RELEASE_FREEZE';
  static const String closureName = 'official-mathlive-font-bundle-ingestion';

  static const bool officialFontFilesBundled = true;
  static const bool officialFontSha256ManifestRequired = true;
  static const bool productionInlineCssEmbedsOfficialFontDataUrls = true;
  static const bool productionMayReferenceMissingFontFiles = false;
  static const bool q190r8MissingFontReferenceSanitizerKeptAsFallbackOnly = true;
  static const bool q193BlockedFontTruthResolvedByOfficialFiles = true;
  static const bool fakeFontBundleClosureAllowed = false;
  static const bool premiumSymbolVisualPassClaimed = false;

  static const int requiredOfficialFontCount = 20;
  static const int bundledOfficialFontCount = 20;

  static const List<String> requiredOfficialFontFiles = <String>[
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_AMS-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Caligraphic-Bold.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Caligraphic-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Fraktur-Bold.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Fraktur-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Main-Bold.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Main-BoldItalic.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Main-Italic.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Main-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Math-BoldItalic.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Math-Italic.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_SansSerif-Bold.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_SansSerif-Italic.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_SansSerif-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Script-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Size1-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Size2-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Size3-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Size4-Regular.woff2',
    'assets/mathlive/vendor/mathlive/fonts/KaTeX_Typewriter-Regular.woff2',
  ];

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
  static const bool finalReleasePassClaimed = false;
}
