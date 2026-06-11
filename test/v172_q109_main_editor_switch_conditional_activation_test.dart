import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q109 Main Editor Switch Conditional Activation', () {
    test('records conditional activation gate without switching default editor or deleting legacy cursor', () {
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.phase, 'V172-Q109');
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.conditionalActivationGateImplemented, isTrue);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.actualMainEditorSwitchImplementedInThisPackage, isFalse);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.mainWorkspaceMountImplementedInThisPackage, isFalse);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.mathLiveEnabledByDefault, isFalse);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.defaultEngine, 'legacyFlutterSlotEditor');
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.candidateEngine, 'mathlive');
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.rollbackEngine, 'legacyFlutterSlotEditor');
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.q100OfficialRuntimeBundleClosureRequired, isTrue);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.q101LabSmokeEvidenceClosureRequired, isTrue);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.q108RealDeviceCursorCourtExecutionRequired, isTrue);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.explicitInternalFlagRequired, isTrue);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.explicitActivationReviewRequired, isTrue);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.legacyCursorRetirementAllowedInThisPackage, isFalse);
      expect(MathLiveMainEditorSwitchConditionalActivationPolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathProPackageContract.q109MainEditorSwitchConditionalActivationRule, contains('V172-Q109'));
    });

    test('blocks conditional activation until runtime, smoke, Flutter, device, flag, and approval evidence are real', () {
      final readiness = MathLiveMainEditorSwitchConditionalActivationPolicy.evaluateReadiness(
        q100OfficialRuntimeBundleClosed: false,
        q101LabSmokeEvidenceClosed: false,
        q103GraphEligibilityAdapterReady: true,
        q104HistoryAdapterReady: true,
        q105SolutionEvaluatorAdapterReady: true,
        q106MountFlagPackageReady: true,
        q107MainKeyboardBridgePackageReady: true,
        q108RealDeviceCursorCourtEvidenceComplete: false,
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

      expect(readiness.status, 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED');
      expect(readiness.packageSideGateReady, isTrue);
      expect(readiness.activationEvidenceComplete, isFalse);
      expect(readiness.selectedDefaultEngine, 'legacyFlutterSlotEditor');
      expect(readiness.candidateEngine, 'mathlive');
      expect(readiness.mayActivateBehindInternalFlagForReview, isFalse);
      expect(readiness.actualMainEditorSwitchImplementedInThisPackage, isFalse);
      expect(readiness.mathLiveEnabledByDefault, isFalse);
      expect(readiness.maySwitchDefaultEditorNow, isFalse);
      expect(readiness.mayRetireLegacyMainPathNow, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.blockers, contains('Q100 official runtime bundle closure has not passed'));
      expect(readiness.blockers, contains('Q108 real-device cursor court evidence is not complete'));
      expect(readiness.blockers, contains('explicit activation review approval is missing'));
    });

    test('even complete evidence only makes the switch ready for review, not default or destructive', () {
      final readiness = MathLiveMainEditorSwitchConditionalActivationPolicy.evaluateReadiness(
        q100OfficialRuntimeBundleClosed: true,
        q101LabSmokeEvidenceClosed: true,
        q103GraphEligibilityAdapterReady: true,
        q104HistoryAdapterReady: true,
        q105SolutionEvaluatorAdapterReady: true,
        q106MountFlagPackageReady: true,
        q107MainKeyboardBridgePackageReady: true,
        q108RealDeviceCursorCourtEvidenceComplete: true,
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

      expect(readiness.status, 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_READY_FOR_REVIEW');
      expect(readiness.activationEvidenceComplete, isTrue);
      expect(readiness.mayActivateBehindInternalFlagForReview, isTrue);
      expect(readiness.selectedDefaultEngine, 'legacyFlutterSlotEditor');
      expect(readiness.maySwitchDefaultEditorNow, isFalse);
      expect(readiness.mayRetireLegacyMainPathNow, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
    });

    test('metadata and verifier contain Q109 markers without protected file markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_main_editor_switch_conditional_activation.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q109_MAIN_EDITOR_SWITCH_CONDITIONAL_ACTIVATION_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q109_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q109MainEditorSwitchConditionalActivationPhase": "V172-Q109"'));
      expect(manifest, contains('"q109ConditionalActivationGateImplemented": true'));
      expect(manifest, contains('"q109ActualMainEditorSwitchImplementedInThisPackage": false'));
      expect(manifest, contains('"q109MaySwitchDefaultEditorNow": false'));
      expect(readme, contains('V172-Q109 Main Editor Switch Conditional Activation'));
      expect(verifier, contains('MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q109 adds the conditional main-editor activation gate'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(keyConfig, isNot(contains('V172-Q109')));
      expect(appShell, isNot(contains('V172-Q109')));
      expect(graphCard, isNot(contains('V172-Q109')));
      expect(historyPanel, isNot(contains('V172-Q109')));
      expect(solutionPanel, isNot(contains('V172-Q109')));
    });
  });
}
