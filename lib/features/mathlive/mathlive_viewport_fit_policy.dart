/// V172-Q148 — MathLive Viewport Fit / Caret Follow policy.
///
/// This policy documents the package-side rules for keeping long MathLive
/// structural templates visible on the phone-sized main editor card without
/// reviving the failed legacy Flutter cursor overlay.
class MathLiveViewportFitPolicy {
  const MathLiveViewportFitPolicy._();

  static const String phase = 'V172-Q148';
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedLongPressMutationAllowed = false;
  static const bool protectedGraphHistorySolutionMutationAllowed = false;
  static const bool legacyFlutterCursorOverlayMayReturn = false;
  static const bool viewportFitRunsAfterRuntimeMount = true;
  static const bool viewportFitRunsAfterKeyboardCommand = true;
  static const bool viewportFitRunsAfterExternalSync = true;
  static const bool caretFollowUsesMathLiveSurface = true;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const List<String> fitClasses = <String>[
    'mathpro-fit-normal',
    'mathpro-fit-compact',
    'mathpro-fit-dense',
    'mathpro-fit-micro',
  ];

  static bool isKnownFitClass(String value) => fitClasses.contains(value);

  static String classForComplexityScore(int score) {
    if (score >= 260) return 'mathpro-fit-micro';
    if (score >= 190) return 'mathpro-fit-dense';
    if (score >= 125) return 'mathpro-fit-compact';
    return 'mathpro-fit-normal';
  }
}
