import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_cursor_court_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q108 Real Device MathLive Cursor Court Execution Package', () {
    test('records execution-package contract without cursor PASS, editor switch, or protected mutation', () {
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.phase, 'V172-Q108');
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.sourceCourtPhase, 'V172-Q94');
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.mountFlagPhase, 'V172-Q106');
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.mainKeyboardBridgePhase, 'V172-Q107');
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.executionPackageOnly, isTrue);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.q94CourtProtocolRequired, isTrue);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.q106MountFlagRequired, isTrue);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.q107MainKeyboardBridgeRequired, isTrue);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.q101LabSmokeEvidenceClosureRequired, isTrue);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.officialRuntimeVerificationRequired, isTrue);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.packageMayClaimCursorPass, isFalse);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.packageMaySwitchMainEditor, isFalse);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.packageMayRetireLegacyMainPath, isFalse);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.packageMayDeleteLegacyCursor, isFalse);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.fakeDeviceEvidenceAllowed, isFalse);
      expect(MathProPackageContract.q108RealDeviceCursorCourtExecutionRule, contains('V172-Q108'));
    });

    test('keeps Q108 execution scenarios aligned with Q94 protocol', () {
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.scenarioListMatchesQ94, isTrue);
      expect(
        MathLiveRealDeviceCursorCourtExecutionPolicy.executionScenarios.length,
        MathLiveRealDeviceCursorCourtPolicy.requiredScenarios.length,
      );
      expect(
        MathLiveRealDeviceCursorCourtExecutionPolicy.executionScenarios.map((s) => s.id),
        MathLiveRealDeviceCursorCourtPolicy.requiredScenarios,
      );
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.requiredExecutionCommands, contains('flutter analyze'));
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.requiredExecutionCommands, contains('flutter test'));
      expect(
        MathLiveRealDeviceCursorCourtExecutionPolicy.requiredExecutionCommands,
        contains('flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA'),
      );
      expect(MathLiveRealDeviceCursorCourtExecutionPolicy.buildExecutionChecklist().length, greaterThan(20));
    });

    test('blocks real-device court pass until Flutter, runtime, smoke, and scenario evidence are real', () {
      final readiness = MathLiveRealDeviceCursorCourtExecutionPolicy.evaluateReadiness(
        q94CourtProtocolPresent: true,
        q106MountFlagPackageReady: true,
        q107MainKeyboardBridgePackageReady: true,
        q101LabSmokeEvidenceClosed: false,
        officialRuntimeVerified: false,
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        labDeviceRunCaptured: false,
        mainDeviceRunCaptured: false,
        scenarioCaptureProvided: false,
        scenarioResults: MathLiveRealDeviceCursorCourtExecutionPolicy.emptyScenarioEvidenceMap(),
        blockingFailureCount: 0,
        protectedSurfacesUnchanged: true,
        keyboardUntouched: true,
        appShellUntouched: true,
        graphHistorySolutionUiUntouched: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        noFakeEvidence: true,
      );

      expect(readiness.status, 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED');
      expect(readiness.packageSideExecutionReady, isTrue);
      expect(readiness.realDeviceCourtEvidenceComplete, isFalse);
      expect(readiness.passedScenarioCount, 0);
      expect(readiness.requiredScenarioCount, 12);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayRetireLegacyMainPath, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.blockers, contains('Q101 Lab smoke evidence closure has not passed'));
      expect(readiness.blockers, contains('flutter analyze PASS evidence is missing'));
      expect(readiness.blockers, contains('real-device main app run capture is missing'));
    });

    test('even complete captured evidence is review-gated and does not itself switch editor or delete legacy cursor', () {
      final passingScenarioMap = <String, bool>{
        for (final scenario in MathLiveRealDeviceCursorCourtExecutionPolicy.executionScenarios) scenario.id: true,
      };
      final readiness = MathLiveRealDeviceCursorCourtExecutionPolicy.evaluateReadiness(
        q94CourtProtocolPresent: true,
        q106MountFlagPackageReady: true,
        q107MainKeyboardBridgePackageReady: true,
        q101LabSmokeEvidenceClosed: true,
        officialRuntimeVerified: true,
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        labDeviceRunCaptured: true,
        mainDeviceRunCaptured: true,
        scenarioCaptureProvided: true,
        scenarioResults: passingScenarioMap,
        blockingFailureCount: 0,
        protectedSurfacesUnchanged: true,
        keyboardUntouched: true,
        appShellUntouched: true,
        graphHistorySolutionUiUntouched: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        noFakeEvidence: true,
      );

      expect(readiness.status, 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_READY_FOR_REVIEW');
      expect(readiness.realDeviceCourtEvidenceComplete, isTrue);
      expect(readiness.passedScenarioCount, 12);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayRetireLegacyMainPath, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
    });

    test('metadata and verifier contain Q108 markers without protected file markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_real_device_cursor_court_execution.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q108_REAL_DEVICE_CURSOR_COURT_EXECUTION_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q108_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q108RealDeviceCursorCourtExecutionPhase": "V172-Q108"'));
      expect(manifest, contains('"q108ExecutionPackageOnly": true'));
      expect(manifest, contains('"q108MayClaimCursorPass": false'));
      expect(manifest, contains('"q108MaySwitchMainEditor": false'));
      expect(manifest, contains('"q108MayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q108 Real Device MathLive Cursor Court Execution Package'));
      expect(verifier, contains('MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q108 turns the Q94 real-device MathLive cursor court into an execution/capture package'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(keyConfig, isNot(contains('V172-Q108')));
      expect(appShell, isNot(contains('V172-Q108')));
      expect(graphCard, isNot(contains('V172-Q108')));
      expect(historyPanel, isNot(contains('V172-Q108')));
      expect(solutionPanel, isNot(contains('V172-Q108')));
    });
  });
}
