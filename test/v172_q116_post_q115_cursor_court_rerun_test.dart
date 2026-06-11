import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q116 post-Q115 cursor court rerun gate', () {
    test('declares post-Q115 rerun gate without cursor PASS, editor switch, or legacy deletion', () {
      expect(MathLivePostQ115CursorCourtRerunPolicy.phase, 'V172-Q116');
      expect(MathLivePostQ115CursorCourtRerunPolicy.repairPhaseUnderTest, 'V172-Q115');
      expect(
        MathLivePostQ115CursorCourtRerunPolicy.sourceRepairPolicyVersion,
        MathLiveStructuralCaretAnchorGeometryRepairPolicy.version,
      );
      expect(
        MathLivePostQ115CursorCourtRerunPolicy.sourceCourtExecutionPhase,
        MathLiveRealDeviceCursorCourtExecutionPolicy.phase,
      );
      expect(MathLivePostQ115CursorCourtRerunPolicy.rerunGateOnly, isTrue);
      expect(MathLivePostQ115CursorCourtRerunPolicy.q115StructuralRepairRequired, isTrue);
      expect(MathLivePostQ115CursorCourtRerunPolicy.stalePreQ115CaptureAllowed, isFalse);
      expect(MathLivePostQ115CursorCourtRerunPolicy.allTwelveQ108ScenariosRequired, isTrue);
      expect(MathLivePostQ115CursorCourtRerunPolicy.requiredScenarioCount, 12);
      expect(MathLivePostQ115CursorCourtRerunPolicy.maximumBlockingFailures, 0);
      expect(MathLivePostQ115CursorCourtRerunPolicy.mayClaimCursorPass, isFalse);
      expect(MathLivePostQ115CursorCourtRerunPolicy.maySwitchMainEditor, isFalse);
      expect(MathLivePostQ115CursorCourtRerunPolicy.mayRetireLegacyMainPath, isFalse);
      expect(MathLivePostQ115CursorCourtRerunPolicy.mayDeleteLegacyCursor, isFalse);
      expect(MathLivePostQ115CursorCourtRerunPolicy.mayMutateKeyboard, isFalse);
      expect(MathLivePostQ115CursorCourtRerunPolicy.mayCreateFakeDeviceEvidence, isFalse);
      expect(MathProPackageContract.q116PostQ115CursorCourtRerunRule, contains('V172-Q116'));
    });

    test('keeps the Q116 scenario set identical to Q108 execution scenarios', () {
      expect(MathLivePostQ115CursorCourtRerunPolicy.scenarioSetMatchesQ108, isTrue);
      expect(
        MathLivePostQ115CursorCourtRerunPolicy.requiredScenarioIds,
        MathLiveRealDeviceCursorCourtExecutionPolicy.executionScenarios.map((scenario) => scenario.id).toList(),
      );
      expect(
        MathLivePostQ115CursorCourtRerunPolicy.requiredCommands,
        contains('node tool/verify_mathlive_structural_caret_anchor_geometry_repair.mjs'),
      );
      expect(
        MathLivePostQ115CursorCourtRerunPolicy.requiredCommands,
        contains('node tool/verify_mathlive_post_q115_cursor_court_rerun.mjs'),
      );
    });

    test('blocks stale or incomplete post-Q115 evidence', () {
      final readiness = MathLivePostQ115CursorCourtRerunPolicy.evaluateReadiness(
        q115StructuralRepairPackageReady: true,
        q108ExecutionPackageReady: true,
        q101LabSmokeEvidenceClosed: false,
        officialRuntimeVerified: false,
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        labDeviceRunCaptured: false,
        mainDeviceRunCaptured: false,
        postQ115CaptureProvided: false,
        captureReferencesQ115Repair: false,
        structuralCaretMisalignmentAbsent: false,
        scenarioResults: const <String, bool>{},
        blockingFailureCount: 0,
        protectedSurfacesUnchanged: true,
        keyboardUntouched: true,
        appShellUntouched: true,
        graphHistorySolutionUiUntouched: true,
        noFakeEvidence: true,
      );

      expect(readiness.status, 'Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED');
      expect(readiness.packageReady, isTrue);
      expect(readiness.postQ115EvidenceComplete, isFalse);
      expect(readiness.passedScenarioCount, 0);
      expect(readiness.requiredScenarioCount, 12);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayRetireLegacyMainPath, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.blockers, contains('Q101 Lab smoke evidence closure has not passed'));
      expect(readiness.blockers, contains('capture does not explicitly reference V172-Q115 as the repair under test'));
      expect(readiness.blockers, contains('structural caret anchor/geometry misalignment is still recorded or not explicitly cleared'));
    });

    test('complete post-Q115 evidence only becomes human-review ready, not an automatic switch or deletion', () {
      final passingScenarioMap = <String, bool>{
        for (final scenario in MathLivePostQ115CursorCourtRerunPolicy.requiredScenarioIds) scenario: true,
      };
      final readiness = MathLivePostQ115CursorCourtRerunPolicy.evaluateReadiness(
        q115StructuralRepairPackageReady: true,
        q108ExecutionPackageReady: true,
        q101LabSmokeEvidenceClosed: true,
        officialRuntimeVerified: true,
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        labDeviceRunCaptured: true,
        mainDeviceRunCaptured: true,
        postQ115CaptureProvided: true,
        captureReferencesQ115Repair: true,
        structuralCaretMisalignmentAbsent: true,
        scenarioResults: passingScenarioMap,
        blockingFailureCount: 0,
        protectedSurfacesUnchanged: true,
        keyboardUntouched: true,
        appShellUntouched: true,
        graphHistorySolutionUiUntouched: true,
        noFakeEvidence: true,
      );

      expect(readiness.status, 'Q116_POST_Q115_CURSOR_COURT_RERUN_READY_FOR_HUMAN_REVIEW');
      expect(readiness.postQ115EvidenceComplete, isTrue);
      expect(readiness.passedScenarioCount, 12);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.maySwitchMainEditor, isFalse);
      expect(readiness.mayRetireLegacyMainPath, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
    });

    test('metadata and verifier contain Q116 markers without protected-surface markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_post_q115_cursor_court_rerun.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q116PostQ115CursorCourtRerunPhase": "V172-Q116"'));
      expect(manifest, contains('"q116RequiresQ115StructuralRepair": true'));
      expect(manifest, contains('"q116StalePreQ115CaptureAllowed": false'));
      expect(manifest, contains('"q116MayClaimCursorPass": false'));
      expect(readme, contains('V172-Q116 — Post-Q115 Real-Device Cursor Court Rerun Gate'));
      expect(verifier, contains('Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'));
      expect(audit, contains('Q116 is the stale-evidence shield after Q115'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(keyConfig, isNot(contains('V172-Q116')));
      expect(appShell, isNot(contains('V172-Q116')));
      expect(graphCard, isNot(contains('V172-Q116')));
      expect(historyPanel, isNot(contains('V172-Q116')));
      expect(solutionPanel, isNot(contains('V172-Q116')));
    });
  });
}
