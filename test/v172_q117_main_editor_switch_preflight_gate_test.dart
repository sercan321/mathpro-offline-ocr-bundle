import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q117 main editor switch preflight gate', () {
    test('declares preflight gate without editor switch, default enablement, or legacy deletion', () {
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.phase, 'V172-Q117');
      expect(
        MathLiveMainEditorSwitchPreflightGatePolicy.prerequisitePostQ115CourtPhase,
        MathLivePostQ115CursorCourtRerunPolicy.phase,
      );
      expect(
        MathLiveMainEditorSwitchPreflightGatePolicy.prerequisiteConditionalActivationPhase,
        MathLiveMainEditorSwitchConditionalActivationPolicy.phase,
      );
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.preflightGateOnly, isTrue);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.actualMainEditorSwitchImplementedInThisPackage, isFalse);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.mathLiveEnabledByDefault, isFalse);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.legacyFlutterSlotEditorRemainsDefault, isTrue);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.q116PostQ115CursorCourtRerunRequired, isTrue);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.q116HumanReviewRequired, isTrue);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.legacyCursorRetirementAllowedInThisPackage, isFalse);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.cursorPassClaimAllowedInThisPackage, isFalse);
      expect(MathLiveMainEditorSwitchPreflightGatePolicy.fakeDeviceEvidenceAllowed, isFalse);
      expect(MathProPackageContract.q117MainEditorSwitchPreflightGateRule, contains('V172-Q117'));
    });

    test('blocks switch review when Q116 post-Q115 evidence is absent', () {
      final readiness = MathLiveMainEditorSwitchPreflightGatePolicy.evaluateReadiness(
        q116PostQ115EvidenceComplete: false,
        q116HumanReviewApproved: false,
        q109ConditionalActivationPackageReady: true,
        q100OfficialRuntimeBundleClosed: false,
        q101LabSmokeEvidenceClosed: false,
        q103GraphEligibilityAdapterReady: true,
        q104HistoryAdapterReady: true,
        q105SolutionEvaluatorAdapterReady: true,
        q106MountFlagPackageReady: true,
        q107MainKeyboardBridgePackageReady: true,
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        explicitInternalFlagEnabled: false,
        explicitActivationReviewApproved: false,
        protectedSurfacesUnchanged: true,
        keyboardUntouched: true,
        moreUntouched: true,
        longPressUntouched: true,
        appShellUntouched: true,
        graphHistorySolutionUiUntouched: true,
        legacyRollbackAvailable: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        noFakeEvidence: true,
        noActualSwitchInThisPackage: true,
        noLegacyRetirementOrDeletion: true,
      );

      expect(readiness.status, 'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE_READY_BUT_EVIDENCE_BLOCKED');
      expect(readiness.packageSideGateReady, isTrue);
      expect(readiness.preflightEvidenceComplete, isFalse);
      expect(readiness.mayProceedToMainEditorActivationReview, isFalse);
      expect(readiness.maySwitchDefaultEditorNow, isFalse);
      expect(readiness.mayRetireLegacyMainPathNow, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.blockers, contains('Q116 post-Q115 real-device cursor court rerun evidence is not complete'));
      expect(readiness.blockers, contains('Q116 post-Q115 cursor court human review approval is missing'));
    });

    test('complete preflight only enables later human review, never an automatic switch', () {
      final readiness = MathLiveMainEditorSwitchPreflightGatePolicy.evaluateReadiness(
        q116PostQ115EvidenceComplete: true,
        q116HumanReviewApproved: true,
        q109ConditionalActivationPackageReady: true,
        q100OfficialRuntimeBundleClosed: true,
        q101LabSmokeEvidenceClosed: true,
        q103GraphEligibilityAdapterReady: true,
        q104HistoryAdapterReady: true,
        q105SolutionEvaluatorAdapterReady: true,
        q106MountFlagPackageReady: true,
        q107MainKeyboardBridgePackageReady: true,
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        explicitInternalFlagEnabled: true,
        explicitActivationReviewApproved: true,
        protectedSurfacesUnchanged: true,
        keyboardUntouched: true,
        moreUntouched: true,
        longPressUntouched: true,
        appShellUntouched: true,
        graphHistorySolutionUiUntouched: true,
        legacyRollbackAvailable: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        noFakeEvidence: true,
        noActualSwitchInThisPackage: true,
        noLegacyRetirementOrDeletion: true,
      );

      expect(readiness.status, 'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_READY_FOR_HUMAN_REVIEW');
      expect(readiness.preflightEvidenceComplete, isTrue);
      expect(readiness.mayProceedToMainEditorActivationReview, isTrue);
      expect(readiness.actualMainEditorSwitchImplementedInThisPackage, isFalse);
      expect(readiness.mathLiveEnabledByDefault, isFalse);
      expect(readiness.maySwitchDefaultEditorNow, isFalse);
      expect(readiness.mayRetireLegacyMainPathNow, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
    });

    test('metadata and verifier contain Q117 markers without protected-surface markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_main_editor_switch_preflight_gate.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q117MainEditorSwitchPreflightPhase": "V172-Q117"'));
      expect(manifest, contains('"q117RequiresQ116PostQ115Evidence": true'));
      expect(manifest, contains('"q117ActualMainEditorSwitchImplemented": false'));
      expect(manifest, contains('"q117MaySwitchDefaultEditorNow": false'));
      expect(manifest, contains('"q117MayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q117 — Main Editor Switch Preflight Gate'));
      expect(verifier, contains('Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q117 is a preflight gate, not a main-editor switch'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(keyConfig, isNot(contains('V172-Q117')));
      expect(appShell, isNot(contains('V172-Q117')));
      expect(graphCard, isNot(contains('V172-Q117')));
      expect(historyPanel, isNot(contains('V172-Q117')));
      expect(solutionPanel, isNot(contains('V172-Q117')));
    });
  });
}
