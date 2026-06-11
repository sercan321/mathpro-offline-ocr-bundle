import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_activation_dry_run_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q118 main editor activation dry-run gate', () {
    test('declares a dry-run gate without switch, default enablement, or legacy deletion', () {
      expect(MathLiveMainEditorActivationDryRunGatePolicy.phase, 'V172-Q118');
      expect(
        MathLiveMainEditorActivationDryRunGatePolicy.prerequisitePreflightPhase,
        MathLiveMainEditorSwitchPreflightGatePolicy.phase,
      );
      expect(MathLiveMainEditorActivationDryRunGatePolicy.dryRunGateOnly, isTrue);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.actualMainEditorSwitchImplementedInThisPackage, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.mainWorkspaceMountImplementedInThisPackage, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.mathLiveEnabledByDefault, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.legacyFlutterSlotEditorRemainsDefault, isTrue);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.q117PreflightEvidenceRequired, isTrue);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.q117HumanReviewRequired, isTrue);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.legacyCursorRetirementAllowedInThisPackage, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.cursorPassClaimAllowedInThisPackage, isFalse);
      expect(MathLiveMainEditorActivationDryRunGatePolicy.fakeDeviceEvidenceAllowed, isFalse);
      expect(MathProPackageContract.q118MainEditorActivationDryRunGateRule, contains('V172-Q118'));
    });

    test('blocks activation when Q117 preflight evidence is absent', () {
      final readiness = MathLiveMainEditorActivationDryRunGatePolicy.evaluateReadiness(
        q117PreflightPackageReady: true,
        q117PreflightEvidenceComplete: false,
        q117HumanReviewApproved: false,
        explicitRuntimeFlagEnabled: false,
        explicitActivationApproval: false,
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        labDeviceRunCaptured: false,
        mainDeviceRunCaptured: false,
        graphRuntimeVerified: false,
        historyRuntimeVerified: false,
        solutionRuntimeVerified: false,
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

      expect(readiness.status, 'Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE_READY_BUT_PREFLIGHT_EVIDENCE_BLOCKED');
      expect(readiness.packageSideGateReady, isTrue);
      expect(readiness.activationEvidenceComplete, isFalse);
      expect(readiness.mayProceedToRuntimeActivationReview, isFalse);
      expect(readiness.maySwitchDefaultEditorNow, isFalse);
      expect(readiness.mayRetireLegacyMainPathNow, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.blockers, contains('Q117 preflight evidence is not complete'));
      expect(readiness.blockers, contains('Q117 human review approval is missing'));
    });

    test('complete dry-run only enables human review, never automatic default switch', () {
      final readiness = MathLiveMainEditorActivationDryRunGatePolicy.evaluateReadiness(
        q117PreflightPackageReady: true,
        q117PreflightEvidenceComplete: true,
        q117HumanReviewApproved: true,
        explicitRuntimeFlagEnabled: true,
        explicitActivationApproval: true,
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        labDeviceRunCaptured: true,
        mainDeviceRunCaptured: true,
        graphRuntimeVerified: true,
        historyRuntimeVerified: true,
        solutionRuntimeVerified: true,
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

      expect(readiness.status, 'Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_READY_FOR_HUMAN_REVIEW');
      expect(readiness.activationEvidenceComplete, isTrue);
      expect(readiness.mayProceedToRuntimeActivationReview, isTrue);
      expect(readiness.actualMainEditorSwitchImplementedInThisPackage, isFalse);
      expect(readiness.mathLiveEnabledByDefault, isFalse);
      expect(readiness.maySwitchDefaultEditorNow, isFalse);
      expect(readiness.mayRetireLegacyMainPathNow, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
    });

    test('metadata and verifier contain Q118 markers without protected-surface markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q118MainEditorActivationDryRunPhase": "V172-Q118"'));
      expect(manifest, contains('"q118RequiresQ117PreflightEvidence": true'));
      expect(manifest, contains('"q118ActualMainEditorSwitchImplemented": false'));
      expect(manifest, contains('"q118MaySwitchDefaultEditorNow": false'));
      expect(manifest, contains('"q118MayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q118 — Main Editor Activation Dry-Run Gate'));
      expect(verifier, contains('Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE_READY_BUT_PREFLIGHT_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q118 is a dry-run gate, not a runtime activation'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(keyConfig, isNot(contains('V172-Q118')));
      expect(appShell, isNot(contains('V172-Q118')));
      expect(graphCard, isNot(contains('V172-Q118')));
      expect(historyPanel, isNot(contains('V172-Q118')));
      expect(solutionPanel, isNot(contains('V172-Q118')));
    });
  });
}
