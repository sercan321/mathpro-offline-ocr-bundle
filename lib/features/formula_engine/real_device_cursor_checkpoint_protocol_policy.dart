/// V172-Q65 real-device cursor checkpoint protocol.
///
/// This is an evidence gate, not a visible UI feature. It intentionally does
/// not mutate keyboard, MORE, long-press, app shell, MathLabel, template tray,
/// Solution, Graph, or History. Q65 reduces the need for device testing after
/// every small phase by defining one focused phone checkpoint over the Q54-Q64
/// cursor courts. It also prevents accidental +95 PASS claims without logs and
/// screenshots/video evidence.
class RealDeviceCursorCheckpointProtocolPolicy {
  const RealDeviceCursorCheckpointProtocolPolicy._();

  static const String version =
      'mathpro-v172-q65-real-device-cursor-checkpoint-protocol-p6-locked-v1';

  static const bool checkpointProtocolAvailable = true;
  static const bool flutterAnalyzeEvidenceRequired = true;
  static const bool flutterTestEvidenceRequired = true;
  static const bool flutterRunDeviceEvidenceRequired = true;
  static const bool phoneScreenshotOrVideoEvidenceRequired = true;
  static const bool cursorPlus95ClaimAllowedWithoutEvidence = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;

  static const int attemptsPerScenario = 20;
  static const int requiredCorrectPerScenario = 19;
  static const double requiredSuccessRate = 0.95;

  static const List<String> requiredCheckpointScenarios = <String>[
    'integralUpperLimitLeadingRail',
    'integralLowerLimitLeadingRail',
    'integralBodyLeadingRail',
    'integralDifferentialDLeadingRail',
    'fractionNumeratorLeadingRail',
    'fractionDenominatorLeadingRail',
    'functionArgumentLeadingRail',
    'rootRadicandLeadingRail',
    'logBaseLeadingRail',
    'logArgumentLeadingRail',
    'longExpressionPanDoesNotJumpCaret',
    'nestedExpressionStructuralSlotSelection',
  ];

  static const List<String> minimalPhoneEvidencePrompts = <String>[
    'flutter analyze output must show no errors',
    'flutter test output must show all tests passed',
    'flutter run -d 23106RN0DA must launch the app',
    'integral slots must show |□ and d|□ without left-empty-space drift',
    'fraction/function/root/log empty slots must keep |□ leading rail',
    'long expression pan must not move the cursor unless it is a tap intent',
  ];

  static CheckpointScenarioVerdict evaluateScenario({
    required String scenario,
    required Iterable<bool> attempts,
  }) {
    final vector = List<bool>.unmodifiable(attempts);
    final correct = vector.where((value) => value).length;
    final successRate = vector.isEmpty ? 0.0 : correct / vector.length;
    final scenarioKnown = requiredCheckpointScenarios.contains(scenario);
    final passed = scenarioKnown &&
        vector.length >= attemptsPerScenario &&
        correct >= requiredCorrectPerScenario &&
        successRate >= requiredSuccessRate;
    return CheckpointScenarioVerdict(
      scenario: scenario,
      attempts: vector.length,
      correct: correct,
      successRate: successRate,
      passed: passed,
    );
  }

  static bool evidenceBundleCanClaimCandidatePlus95({
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool flutterRunOnDeviceProvided,
    required bool phoneVisualEvidenceProvided,
    required Iterable<CheckpointScenarioVerdict> scenarioVerdicts,
  }) {
    final verdicts = List<CheckpointScenarioVerdict>.unmodifiable(scenarioVerdicts);
    if (!flutterAnalyzePassed || !flutterTestPassed || !flutterRunOnDeviceProvided || !phoneVisualEvidenceProvided) {
      return false;
    }
    if (verdicts.length < requiredCheckpointScenarios.length) return false;
    final byScenario = <String, CheckpointScenarioVerdict>{
      for (final verdict in verdicts) verdict.scenario: verdict,
    };
    for (final scenario in requiredCheckpointScenarios) {
      final verdict = byScenario[scenario];
      if (verdict == null || !verdict.passed) return false;
    }
    return true;
  }

  static bool maySkipPerPhaseDeviceTesting({
    required bool goldenGeometryCourtPresent,
    required bool syntheticTapMatrixPresent,
    required bool transactionStressCourtPresent,
    required bool longExpressionStabilityCourtPresent,
  }) {
    return goldenGeometryCourtPresent &&
        syntheticTapMatrixPresent &&
        transactionStressCourtPresent &&
        longExpressionStabilityCourtPresent;
  }

  static List<bool> syntheticPassingAttemptVector() {
    return List<bool>.generate(
      attemptsPerScenario,
      (index) => index < requiredCorrectPerScenario,
      growable: false,
    );
  }
}

class CheckpointScenarioVerdict {
  const CheckpointScenarioVerdict({
    required this.scenario,
    required this.attempts,
    required this.correct,
    required this.successRate,
    required this.passed,
  });

  final String scenario;
  final int attempts;
  final int correct;
  final double successRate;
  final bool passed;

  String get summary => passed
      ? 'PASS $scenario $correct/$attempts ${(successRate * 100).toStringAsFixed(1)}%'
      : 'FAIL $scenario $correct/$attempts ${(successRate * 100).toStringAsFixed(1)}%';
}
