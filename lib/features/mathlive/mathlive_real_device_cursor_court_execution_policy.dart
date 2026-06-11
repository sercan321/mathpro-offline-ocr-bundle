import 'mathlive_main_keyboard_bridge_policy.dart';
import 'mathlive_main_workspace_mount_flag_policy.dart';
import 'mathlive_real_device_cursor_court_policy.dart';

/// V172-Q108 — Real Device MathLive Cursor Court Execution Package.
///
/// Q108 does not claim that the MathLive cursor court passed. It turns the Q94
/// real-device court protocol into a repeatable execution/capture package so the
/// phone-side test burden can be run once, recorded once, and audited without
/// touching keyboard, AppShell, Graph, History, Solution, or legacy cursor files.
class MathLiveRealDeviceCursorCourtExecutionPolicy {
  const MathLiveRealDeviceCursorCourtExecutionPolicy._();

  static const String phase = 'V172-Q108';
  static const String verifierScript = 'tool/verify_mathlive_real_device_cursor_court_execution.mjs';
  static const String reportJson = 'tool/reports/mathlive_real_device_cursor_court_execution_report.json';
  static const String reportMarkdown = 'tool/reports/mathlive_real_device_cursor_court_execution_report.md';
  static const String captureJson = 'tool/reports/mathlive_real_device_cursor_court_execution_capture.json';
  static const String flutterEvidenceJson = 'tool/reports/mathlive_real_device_cursor_court_flutter_evidence.json';
  static const String sourceCourtPhase = MathLiveRealDeviceCursorCourtPolicy.phase;
  static const String mountFlagPhase = MathLiveMainWorkspaceMountFlagPolicy.phase;
  static const String mainKeyboardBridgePhase = MathLiveMainKeyboardBridgePolicy.phase;

  static const bool executionPackageOnly = true;
  static const bool q94CourtProtocolRequired = true;
  static const bool q106MountFlagRequired = true;
  static const bool q107MainKeyboardBridgeRequired = true;
  static const bool q101LabSmokeEvidenceClosureRequired = true;
  static const bool officialRuntimeVerificationRequired = true;
  static const bool flutterAnalyzeRequired = true;
  static const bool flutterTestRequired = true;
  static const bool realDeviceLabRunRequired = true;
  static const bool realDeviceMainRunRequired = true;
  static const bool scenarioCaptureRequired = true;
  static const bool packageMayClaimDevicePass = false;
  static const bool packageMayClaimCursorPass = false;
  static const bool packageMaySwitchMainEditor = false;
  static const bool packageMayEnableMathLiveByDefault = false;
  static const bool packageMayRetireLegacyMainPath = false;
  static const bool packageMayDeleteLegacyCursor = false;
  static const bool keyboardMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool fakeSmokeEvidenceAllowed = false;
  static const bool fakeDeviceEvidenceAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool remoteScriptLoadingAllowed = false;

  static const List<String> requiredExecutionCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'node tool/verify_mathlive_official_runtime_bundle.mjs',
    'node tool/verify_mathlive_lab_smoke_evidence_closure.mjs',
    'node tool/verify_mathlive_main_workspace_mount_flag.mjs',
    'node tool/verify_mathlive_main_keyboard_bridge.mjs',
    'node tool/verify_mathlive_real_device_cursor_court_execution.mjs',
    'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
    'flutter run -d 23106RN0DA',
  ];

  static const List<MathLiveRealDeviceCourtExecutionScenario> executionScenarios = <MathLiveRealDeviceCourtExecutionScenario>[
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'empty-placeholder-tap-leading-caret',
      label: 'Empty placeholder tap places caret inside/at the leading math slot',
      expectedEvidence: 'screen recording or capture showing visible MathLive caret in the empty slot',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'fraction-numerator-denominator-routing',
      label: 'Fraction numerator and denominator can be targeted independently',
      expectedEvidence: 'capture with successful numerator entry, denominator entry, backspace and re-entry',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'sqrt-radicand-routing',
      label: 'Square-root radicand tap/focus/input remains inside the root body',
      expectedEvidence: 'capture showing root body cursor and stable LaTeX export',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'power-exponent-routing',
      label: 'Power exponent tap/focus/input remains in the superscript lane',
      expectedEvidence: 'capture showing exponent cursor and no stray base text insertion',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'subscript-routing',
      label: 'Subscript tap/focus/input remains in the lower-index lane',
      expectedEvidence: 'capture showing subscript cursor, deletion, and re-entry',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'sin-300-continuous-argument-entry',
      label: 'Function argument supports continuous entry such as sin(300)',
      expectedEvidence: 'capture showing no auto-exit after the first digit',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'tan-long-expression-navigation',
      label: 'Long function input such as tan(88555855) remains navigable',
      expectedEvidence: 'capture showing tap/scroll/caret remains stable in a long argument',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'log-base-and-body-separation',
      label: 'Log base and argument/body are targeted separately',
      expectedEvidence: 'capture showing independent base/body cursor placement and export',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'integral-lower-upper-body-differential-routing',
      label: 'Integral lower, upper, body, and differential lanes remain distinct',
      expectedEvidence: 'capture showing each integral lane can be focused and edited',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'backspace-delete-structural-editing',
      label: 'Backspace/delete edits structures without orphan tokens or cursor jumps',
      expectedEvidence: 'capture showing deletion inside fraction/function/root/script structures',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'long-expression-horizontal-scroll-and-tap',
      label: 'Long expression horizontal scroll and tap targeting stay stable',
      expectedEvidence: 'capture showing scroll, tap-after-scroll, and synchronized LaTeX export',
    ),
    MathLiveRealDeviceCourtExecutionScenario(
      id: 'focus-loss-restore-and-keyboard-latency',
      label: 'Focus restore and MathPro keyboard command latency remain acceptable',
      expectedEvidence: 'capture showing Android focus restore and low-latency key insertion',
    ),
  ];

  static bool get scenarioListMatchesQ94 {
    const q94 = MathLiveRealDeviceCursorCourtPolicy.requiredScenarios;
    if (q94.length != executionScenarios.length) return false;
    for (var i = 0; i < q94.length; i += 1) {
      if (q94[i] != executionScenarios[i].id) return false;
    }
    return true;
  }

  static Map<String, bool> emptyScenarioEvidenceMap() {
    return <String, bool>{for (final scenario in executionScenarios) scenario.id: false};
  }

  static List<String> buildExecutionChecklist() {
    return <String>[
      ...requiredExecutionCommands,
      for (final scenario in executionScenarios) 'manual scenario: ${scenario.id} — ${scenario.expectedEvidence}',
    ];
  }

  static MathLiveRealDeviceCourtExecutionReadiness evaluateReadiness({
    required bool q94CourtProtocolPresent,
    required bool q106MountFlagPackageReady,
    required bool q107MainKeyboardBridgePackageReady,
    required bool q101LabSmokeEvidenceClosed,
    required bool officialRuntimeVerified,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool labDeviceRunCaptured,
    required bool mainDeviceRunCaptured,
    required bool scenarioCaptureProvided,
    required Map<String, bool> scenarioResults,
    required int blockingFailureCount,
    required bool protectedSurfacesUnchanged,
    required bool keyboardUntouched,
    required bool appShellUntouched,
    required bool graphHistorySolutionUiUntouched,
    required bool virtualKeyboardDisabled,
    required bool remoteScriptsDisabled,
    required bool noFakeEvidence,
  }) {
    final blockers = <String>[];
    if (!q94CourtProtocolPresent) blockers.add('Q94 real-device cursor court protocol is missing');
    if (!q106MountFlagPackageReady) blockers.add('Q106 main-workspace mount flag package readiness is missing');
    if (!q107MainKeyboardBridgePackageReady) blockers.add('Q107 main keyboard bridge package readiness is missing');
    if (!q101LabSmokeEvidenceClosed) blockers.add('Q101 Lab smoke evidence closure has not passed');
    if (!officialRuntimeVerified) blockers.add('official MathLive runtime bundle is not verified');
    if (!flutterAnalyzePassed) blockers.add('flutter analyze PASS evidence is missing');
    if (!flutterTestPassed) blockers.add('flutter test PASS evidence is missing');
    if (!labDeviceRunCaptured) blockers.add('real-device MathLive Lab run capture is missing');
    if (!mainDeviceRunCaptured) blockers.add('real-device main app run capture is missing');
    if (!scenarioCaptureProvided) blockers.add('Q108 cursor scenario capture JSON is missing');
    if (!protectedSurfacesUnchanged) blockers.add('protected UI surfaces changed');
    if (!keyboardUntouched) blockers.add('keyboard/MORE/long-press source changed during Q108');
    if (!appShellUntouched) blockers.add('app_shell.dart changed during Q108');
    if (!graphHistorySolutionUiUntouched) blockers.add('Graph/History/Solution UI changed during Q108');
    if (!virtualKeyboardDisabled) blockers.add('MathLive virtual keyboard is not disabled');
    if (!remoteScriptsDisabled) blockers.add('remote/CDN scripts are not disabled');
    if (!noFakeEvidence) blockers.add('runtime, smoke, Flutter, or device evidence was faked');
    if (!scenarioListMatchesQ94) blockers.add('Q108 scenario list drifted from Q94 protocol');

    final missingScenarios = executionScenarios.where((scenario) => !scenarioResults.containsKey(scenario.id)).toList(growable: false);
    if (missingScenarios.isNotEmpty) {
      blockers.add('missing Q108 scenario evidence: ${missingScenarios.map((s) => s.id).join(', ')}');
    }
    final passedScenarios = executionScenarios.where((scenario) => scenarioResults[scenario.id] == true).length;
    if (passedScenarios < executionScenarios.length) {
      blockers.add('only $passedScenarios/${executionScenarios.length} Q108 cursor scenarios passed');
    }
    if (blockingFailureCount > MathLiveRealDeviceCursorCourtPolicy.maximumBlockingFailures) {
      blockers.add('$blockingFailureCount blocking real-device cursor/focus failures recorded');
    }

    final packageReady = q94CourtProtocolPresent &&
        q106MountFlagPackageReady &&
        q107MainKeyboardBridgePackageReady &&
        protectedSurfacesUnchanged &&
        keyboardUntouched &&
        appShellUntouched &&
        graphHistorySolutionUiUntouched &&
        virtualKeyboardDisabled &&
        remoteScriptsDisabled &&
        noFakeEvidence &&
        scenarioListMatchesQ94;

    final deviceCourtPassed = packageReady &&
        q101LabSmokeEvidenceClosed &&
        officialRuntimeVerified &&
        flutterAnalyzePassed &&
        flutterTestPassed &&
        labDeviceRunCaptured &&
        mainDeviceRunCaptured &&
        scenarioCaptureProvided &&
        passedScenarios == executionScenarios.length &&
        blockingFailureCount == 0;

    return MathLiveRealDeviceCourtExecutionReadiness(
      status: deviceCourtPassed
          ? 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_READY_FOR_REVIEW'
          : packageReady
              ? 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED'
              : 'BLOCKED_MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE',
      blockers: blockers,
      packageSideExecutionReady: packageReady,
      realDeviceCourtEvidenceComplete: deviceCourtPassed,
      passedScenarioCount: passedScenarios,
      requiredScenarioCount: executionScenarios.length,
      mayClaimCursorPass: false,
      maySwitchMainEditor: false,
      mayRetireLegacyMainPath: false,
      mayDeleteLegacyCursor: false,
      mayMutateKeyboard: false,
      mayMutateAppShell: false,
      mayMutateGraphHistorySolutionUi: false,
    );
  }
}

class MathLiveRealDeviceCourtExecutionScenario {
  const MathLiveRealDeviceCourtExecutionScenario({
    required this.id,
    required this.label,
    required this.expectedEvidence,
  });

  final String id;
  final String label;
  final String expectedEvidence;
}

class MathLiveRealDeviceCourtExecutionReadiness {
  const MathLiveRealDeviceCourtExecutionReadiness({
    required this.status,
    required this.blockers,
    required this.packageSideExecutionReady,
    required this.realDeviceCourtEvidenceComplete,
    required this.passedScenarioCount,
    required this.requiredScenarioCount,
    required this.mayClaimCursorPass,
    required this.maySwitchMainEditor,
    required this.mayRetireLegacyMainPath,
    required this.mayDeleteLegacyCursor,
    required this.mayMutateKeyboard,
    required this.mayMutateAppShell,
    required this.mayMutateGraphHistorySolutionUi,
  });

  final String status;
  final List<String> blockers;
  final bool packageSideExecutionReady;
  final bool realDeviceCourtEvidenceComplete;
  final int passedScenarioCount;
  final int requiredScenarioCount;
  final bool mayClaimCursorPass;
  final bool maySwitchMainEditor;
  final bool mayRetireLegacyMainPath;
  final bool mayDeleteLegacyCursor;
  final bool mayMutateKeyboard;
  final bool mayMutateAppShell;
  final bool mayMutateGraphHistorySolutionUi;

  bool get isBlocked => !realDeviceCourtEvidenceComplete;
}
