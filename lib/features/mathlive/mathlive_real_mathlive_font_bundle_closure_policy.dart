/// V172-Q193 — Real MathLive Font Bundle Closure Gate policy.
///
/// This phase is a code/static truth closure, not a fake visual PASS claim.
/// The inspected package contains MathLive CSS that requires official KaTeX
/// font files, but the actual font files are not bundled. Q193 therefore
/// prevents a false "premium font bundle closed" claim, records the exact
/// required font inventory, and keeps the Q190R8 missing-font sanitizer active
/// until official font files are explicitly supplied in a later package.
class MathLiveRealMathLiveFontBundleClosurePolicy {
  const MathLiveRealMathLiveFontBundleClosurePolicy._();

  static const String phase = 'V172-Q193';
  static const String baseline = 'V172-Q192_CARET_FOCUS_SLOT_CONTRACT_CLOSURE';
  static const String closureName = 'real-mathlive-font-bundle-closure-gate';
  static const String closureStatus = 'BLOCKED_OFFICIAL_FONT_FILES_ABSENT';

  static const bool newFeatureAllowed = false;
  static const bool officialMathLiveCssPresent = true;
  static const bool officialMathLiveFontCssRequiresFontsDirectory = true;
  static const bool officialFontFilesBundled = false;
  static const bool fakeFontBundleClosureClaimAllowed = false;
  static const bool productionMayReferenceMissingFontFiles = false;
  static const bool q190r8MissingFontReferenceSanitizerMustRemainActive = true;
  static const bool premiumSymbolVisualPassClaimed = false;

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
  static const bool legacySurfacePhysicalCleanupCompleted = false;
}
