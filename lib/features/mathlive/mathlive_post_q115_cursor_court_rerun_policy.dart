import '../formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart';
import 'mathlive_real_device_cursor_court_execution_policy.dart';

/// V172-Q116 — Post-Q115 real-device cursor court rerun gate.
///
/// Q116 is deliberately not a new editor switch and not a legacy cleanup phase.
/// It exists to make the post-Q115 phone retest auditable: the 12 Q108 cursor
/// scenarios must be rerun after the structural caret anchor geometry repair,
/// the capture must explicitly name Q115 as the repair under test, and stale
/// pre-Q115 captures must not be accepted as cursor-court closure.
class MathLivePostQ115CursorCourtRerunPolicy {
  const MathLivePostQ115CursorCourtRerunPolicy._();

  static const String phase = 'V172-Q116';
  static const String repairPhaseUnderTest = 'V172-Q115';
  static const String sourceRepairPolicyVersion =
      MathLiveStructuralCaretAnchorGeometryRepairPolicy.version;
  static const String sourceCourtExecutionPhase =
      MathLiveRealDeviceCursorCourtExecutionPolicy.phase;
  static const String verifierScript =
      'tool/verify_mathlive_post_q115_cursor_court_rerun.mjs';
  static const String captureJson =
      'tool/reports/mathlive_post_q115_cursor_court_rerun_capture.json';
  static const String reportJson =
      'tool/reports/mathlive_post_q115_cursor_court_rerun_report.json';
  static const String reportMarkdown =
      'tool/reports/mathlive_post_q115_cursor_court_rerun_report.md';

  static const bool rerunGateOnly = true;
  static const bool q115StructuralRepairRequired = true;
  static const bool q108ScenarioSetRequired = true;
  static const bool postQ115CaptureRequired = true;
  static const bool stalePreQ115CaptureAllowed = false;
  static const bool q101LabSmokeEvidenceClosureRequired = true;
  static const bool officialRuntimeVerificationRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool labDeviceRunRequired = true;
  static const bool mainDeviceRunRequired = true;
  static const bool allTwelveQ108ScenariosRequired = true;
  static const int requiredScenarioCount = 12;
  static const int maximumBlockingFailures = 0;

  static const bool mayClaimCursorPass = false;
  static const bool maySwitchMainEditor = false;
  static const bool mayEnableMathLiveByDefault = false;
  static const bool mayRetireLegacyMainPath = false;
  static const bool mayDeleteLegacyCursor = false;
  static const bool mayMutateKeyboard = false;
  static const bool mayMutateAppShell = false;
  static const bool mayMutateGraphHistorySolutionUi = false;
  static const bool mayCreateFakeRuntimeEvidence = false;
  static const bool mayCreateFakeSmokeEvidence = false;
  static const bool mayCreateFakeDeviceEvidence = false;

  static const List<String> requiredCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'node tool/install_mathlive_runtime.mjs',
    'node tool/verify_mathlive_runtime.mjs',
    'node tool/verify_mathlive_official_runtime_bundle.mjs',
    'node tool/verify_mathlive_lab_smoke_evidence_closure.mjs',
    'node tool/verify_mathlive_structural_caret_anchor_geometry_repair.mjs',
    'node tool/verify_mathlive_real_device_cursor_court_execution.mjs',
    'node tool/verify_mathlive_post_q115_cursor_court_rerun.mjs',
    'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
    'flutter run -d 23106RN0DA',
  ];

  static List<String> get requiredScenarioIds =>
      MathLiveRealDeviceCursorCourtExecutionPolicy.executionScenarios
          .map((scenario) => scenario.id)
          .toList(growable: false);

  static bool get scenarioSetMatchesQ108 =>
      requiredScenarioIds.length == requiredScenarioCount;

  static MathLivePostQ115CursorCourtRerunReadiness evaluateReadiness({
    required bool q115StructuralRepairPackageReady,
    required bool q108ExecutionPackageReady,
    required bool q101LabSmokeEvidenceClosed,
    required bool officialRuntimeVerified,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool postQ115CaptureProvided,
    required bool captureReferencesQ115Repair,
    required bool structuralCaretMisalignmentAbsent,
    required Map<String, bool> scenarioResults,
    required int blockingFailureCount,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool noFakeEvidence,
  }) {
    final blockers = <String>[];
    if (!q115StructuralRepairPackageReady) {
      blockers.add('Q115 structural caret anchor repair package readiness is missing');
    }
    if (!q108ExecutionPackageReady) {
      blockers.add('Q108 real-device cursor court execution package readiness is missing');
    }
    if (!q101LabSmokeEvidenceClosed) {
      blockers.add('Q101 Lab smoke evidence closure has not passed');
    }
    if (!officialRuntimeVerified) {
      blockers.add('official MathLive runtime bundle is not verified');
    }
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('post-Q115 real-device MathLive Lab run capture is missing');
    if (!mainDeviceRunCaptured) blockers.add('post-Q115 real-device main app run capture is missing');
    if (!postQ115CaptureProvided) blockers.add('post-Q115 Q108 scenario capture JSON is missing');
    if (!captureReferencesQ115Repair) {
      blockers.add('capture does not explicitly reference V172-Q115 as the repair under test');
    }
    if (!structuralCaretMisalignmentAbsent) {
      blockers.add('structural caret anchor/geometry misalignment is still recorded or not explicitly cleared');
    }
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed during Q116 rerun');
    if (!keyboardUntouched) blockers.add('keyboard/MORE/long-press source changed during Q116 rerun');
    if (!appShellUntouched) blockers.add('app_shell.dart changed during Q116 rerun');
    if (!graphHistorySolutionUiUntouched) {
      blockers.add('Graph/History/Solution UI changed during Q116 rerun');
    }
    if (!noFakeEvidence) blockers.add('runtime, smoke, Flutter, or device evidence was faked');
    if (!scenarioSetMatchesQ108) blockers.add('Q116 scenario set drifted from the Q108 court');

    final missingScenarios = <String>[];
    var passedScenarios = 0;
    for (final scenarioId in requiredScenarioIds) {
      if (!scenarioResults.containsKey(scenarioId)) {
        missingScenarios.add(scenarioId);
      }
      if (scenarioResults[scenarioId] == true) passedScenarios += 1;
    }
    if (missingScenarios.isNotEmpty) {
      blockers.add('missing post-Q115 scenario evidence: ${missingScenarios.join(', ')}');
    }
    if (passedScenarios < requiredScenarioCount) {
      blockers.add('only $passedScenarios/$requiredScenarioCount post-Q115 cursor scenarios passed');
    }
    if (blockingFailureCount > maximumBlockingFailures) {
      blockers.add('$blockingFailureCount blocking post-Q115 cursor/focus failures recorded');
    }

    final packageReady = q115StructuralRepairPackageReady &&
        q108ExecutionPackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        noFakeEvidence &&
        scenarioSetMatchesQ108;

    final evidenceComplete = packageReady &&
        q101LabSmokeEvidenceClosed &&
        officialRuntimeVerified &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        postQ115CaptureProvided &&
        captureReferencesQ115Repair &&
        structuralCaretMisalignmentAbsent &&
        passedScenarios == requiredScenarioCount &&
        blockingFailureCount == maximumBlockingFailures;

    return MathLivePostQ115CursorCourtRerunReadiness(
      status: evidenceComplete
          ? 'Q116_POST_Q115_CURSOR_COURT_RERUN_READY_FOR_HUMAN_REVIEW'
          : packageReady
              ? 'Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
              : 'BLOCKED_Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE',
      blockers: blockers,
      packageReady: packageReady,
      postQ115EvidenceComplete: evidenceComplete,
      passedScenarioCount: passedScenarios,
      requiredScenarioCount: requiredScenarioCount,
      mayClaimCursorPass: false,
      maySwitchMainEditor: false,
      mayRetireLegacyMainPath: false,
      mayDeleteLegacyCursor: false,
    );
  }
}

class MathLivePostQ115CursorCourtRerunReadiness {
  const MathLivePostQ115CursorCourtRerunReadiness({
    required this.status,
    required this.blockers,
    required this.packageReady,
    required this.postQ115EvidenceComplete,
    required this.passedScenarioCount,
    required this.requiredScenarioCount,
    required this.mayClaimCursorPass,
    required this.maySwitchMainEditor,
    required this.mayRetireLegacyMainPath,
    required this.mayDeleteLegacyCursor,
  });

  final String status;
  final List<String> blockers;
  final bool packageReady;
  final bool postQ115EvidenceComplete;
  final int passedScenarioCount;
  final int requiredScenarioCount;
  final bool mayClaimCursorPass;
  final bool maySwitchMainEditor;
  final bool mayRetireLegacyMainPath;
  final bool mayDeleteLegacyCursor;

  bool get isBlocked => !postQ115EvidenceComplete;
}
