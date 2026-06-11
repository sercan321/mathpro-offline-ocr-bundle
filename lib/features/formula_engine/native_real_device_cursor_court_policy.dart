/// V172-Q80 — Real Device Cursor Court.
///
/// This policy is deliberately not a fake device pass. It is a runtime/static
/// evidence gate for the Q71-Q79 native SlotBox cursor pipeline. It records the
/// exact court scenarios that must be run on a real phone before any +95 cursor
/// wording is allowed. The assistant environment cannot run Flutter/Dart or a
/// physical device, so every constant here keeps real-device PASS claims false
/// until user-side logs and manual evidence are provided.
class NativeRealDeviceCursorCourtPolicy {
  const NativeRealDeviceCursorCourtPolicy._();

  static const String version =
      'mathpro-v172q80-native-real-device-cursor-court-v1';

  static const bool nativeRealDeviceCursorCourtAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool solutionPanelMutationAllowed = false;

  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const bool photomathLevelClaimAllowedWithoutEvidence = false;

  static const int minimumManualScenarioCount = 20;
  static const int minimumCorrectScenarioCountForCandidate = 19;
  static const int minimumRequiredFlutterCommandCount = 4;

  static const List<String> requiredFlutterCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];

  static const List<String> requiredManualScenarios = <String>[
    'empty-basic-slot tap -> |□',
    'fraction numerator empty tap -> |□ numerator',
    'fraction denominator empty tap -> |□ denominator',
    'fraction numerator filled character tap -> measured glyph caret',
    'fraction denominator filled character tap -> measured glyph caret',
    'sin argument empty tap -> sin(|□)',
    'sin filled argument tap -> character-level caret inside argument',
    'ln nested argument tap -> deepest measured ln slot',
    'log base empty tap -> log_|□(□)',
    'log argument empty tap -> log_□(|□)',
    'sqrt body empty tap -> √|□',
    'nth-root index tap -> |□ index',
    'nth-root body tap -> root body |□',
    'power exponent tap -> x^|□',
    'subscript tap -> x_|□',
    'integral lower tap -> lower |□',
    'integral upper tap -> upper |□',
    'integral body tap -> body |□',
    'integral differential tap -> d|□',
    'long nested expression pan then tap -> same measured SlotBox frame',
  ];

  static const List<String> forbiddenFailureModes = <String>[
    'nearest structural fallback selects an untapped slot',
    'detached linear caret appears while SlotGeometryBundle exists',
    'empty placeholder renders □| instead of |□',
    'caret appears inside the placeholder box',
    'tap on log base edits log argument',
    'tap on fraction denominator edits numerator',
    'tap on integral differential is swallowed by integral body',
    'pan gesture changes selected structural slot',
    'old geometry is reused after viewport transform changes',
    'green debug overlay appears in production UI',
  ];

  static bool hasRequiredFlutterCommandEvidence(Iterable<String> logLines) {
    final joined = logLines.join('\n').toLowerCase();
    return joined.contains('flutter pub get') &&
        joined.contains('flutter analyze') &&
        joined.contains('flutter test') &&
        joined.contains('flutter run -d 23106rn0da');
  }

  static bool hasBlockingFailureMode(Iterable<String> observedFailures) {
    final normalized = observedFailures.map((entry) => entry.toLowerCase()).join('\n');
    return forbiddenFailureModes.any(
      (failure) => normalized.contains(failure.toLowerCase()),
    );
  }

  static int countCorrectManualScenarios(Map<String, bool> scenarioResults) {
    var count = 0;
    for (final scenario in requiredManualScenarios) {
      if (scenarioResults[scenario] == true) count += 1;
    }
    return count;
  }

  static bool qualifiesForCandidatePlus95Review({
    required Map<String, bool> scenarioResults,
    required Iterable<String> flutterCommandLogLines,
    required Iterable<String> observedFailures,
  }) {
    if (!hasRequiredFlutterCommandEvidence(flutterCommandLogLines)) return false;
    if (hasBlockingFailureMode(observedFailures)) return false;
    return countCorrectManualScenarios(scenarioResults) >=
        minimumCorrectScenarioCountForCandidate;
  }

  static String courtVerdict({
    required Map<String, bool> scenarioResults,
    required Iterable<String> flutterCommandLogLines,
    required Iterable<String> observedFailures,
  }) {
    if (!hasRequiredFlutterCommandEvidence(flutterCommandLogLines)) {
      return 'REJECT: missing real flutter pub get/analyze/test/run device evidence';
    }
    if (hasBlockingFailureMode(observedFailures)) {
      return 'REJECT: blocking cursor failure mode observed on real device';
    }
    final correct = countCorrectManualScenarios(scenarioResults);
    if (correct < minimumCorrectScenarioCountForCandidate) {
      return 'REJECT: only $correct/$minimumManualScenarioCount cursor court scenarios passed';
    }
    return 'CANDIDATE: $correct/$minimumManualScenarioCount scenarios passed; manual evidence may be reviewed, but this static package still does not claim +95 PASS by itself';
  }
}
