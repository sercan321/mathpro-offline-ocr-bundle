/// V172-Q94 — Real Device MathLive Cursor Court.
///
/// This policy intentionally cannot be satisfied by static tests alone. The
/// package can list scenarios and validate a provided evidence summary, but it
/// must not claim cursor PASS without real phone-side results.
class MathLiveRealDeviceCursorCourtPolicy {
  const MathLiveRealDeviceCursorCourtPolicy._();

  static const String phase = 'V172-Q94';
  static const int requiredScenarioCount = 12;
  static const int minimumPassingScenarioCount = 12;
  static const int maximumBlockingFailures = 0;
  static const bool staticPackageMayClaimPass = false;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool realDeviceRunRequired = true;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool physicalLegacyDeletionAllowed = false;
  static const bool mainPathRetirementAllowedWithoutCourt = false;

  static const List<String> requiredScenarios = <String>[
    'empty-placeholder-tap-leading-caret',
    'fraction-numerator-denominator-routing',
    'sqrt-radicand-routing',
    'power-exponent-routing',
    'subscript-routing',
    'sin-300-continuous-argument-entry',
    'tan-long-expression-navigation',
    'log-base-and-body-separation',
    'integral-lower-upper-body-differential-routing',
    'backspace-delete-structural-editing',
    'long-expression-horizontal-scroll-and-tap',
    'focus-loss-restore-and-keyboard-latency',
  ];

  static MathLiveRealDeviceCursorCourtVerdict evaluate({
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool realDeviceRunPassed,
    required bool q93BehindFlagPathAvailable,
    required bool protectedSurfacesUnchanged,
    required Map<String, bool> scenarioResults,
    required int blockingFailureCount,
  }) {
    final issues = <String>[];
    if (!flutterAnalyzePassed) issues.add('flutter analyze PASS log is missing');
    if (!flutterTestPassed) issues.add('flutter test PASS log is missing');
    if (!realDeviceRunPassed) issues.add('real-device MathLive main-editor run evidence is missing');
    if (!q93BehindFlagPathAvailable) issues.add('Q93 behind-flag MathLive path is not available');
    if (!protectedSurfacesUnchanged) issues.add('protected UI surfaces changed');
    final missing = requiredScenarios.where((scenario) => !scenarioResults.containsKey(scenario)).toList(growable: false);
    if (missing.isNotEmpty) issues.add('missing cursor court scenarios: ${missing.join(', ')}');
    final passCount = requiredScenarios.where((scenario) => scenarioResults[scenario] == true).length;
    if (passCount < minimumPassingScenarioCount) {
      issues.add('only $passCount/$requiredScenarioCount real-device scenarios passed');
    }
    if (blockingFailureCount > maximumBlockingFailures) {
      issues.add('$blockingFailureCount blocking cursor failures recorded');
    }

    final passed = issues.isEmpty;
    return MathLiveRealDeviceCursorCourtVerdict(
      status: passed ? 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_PASS' : 'BLOCKED_MATHLIVE_REAL_DEVICE_CURSOR_COURT',
      issues: issues,
      passCount: passCount,
      requiredCount: requiredScenarioCount,
      mayClaimMathLiveCursorPass: passed,
      mayRetireLegacyMainPath: passed,
      mayDeleteLegacyCursorPhysically: false,
    );
  }
}

class MathLiveRealDeviceCursorCourtVerdict {
  const MathLiveRealDeviceCursorCourtVerdict({
    required this.status,
    required this.issues,
    required this.passCount,
    required this.requiredCount,
    required this.mayClaimMathLiveCursorPass,
    required this.mayRetireLegacyMainPath,
    required this.mayDeleteLegacyCursorPhysically,
  });

  final String status;
  final List<String> issues;
  final int passCount;
  final int requiredCount;
  final bool mayClaimMathLiveCursorPass;
  final bool mayRetireLegacyMainPath;
  final bool mayDeleteLegacyCursorPhysically;

  bool get isBlocked => !mayClaimMathLiveCursorPass;
}
