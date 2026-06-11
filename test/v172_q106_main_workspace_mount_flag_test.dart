import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_smoke_evidence_closure_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q106 Main Workspace MathLive Mount Behind Internal Flag', () {
    test('records mount-readiness contract without AppShell, keyboard, UI mutation, or default switch', () {
      expect(MathLiveMainWorkspaceMountFlagPolicy.phase, 'V172-Q106');
      expect(MathLiveMainWorkspaceMountFlagPolicy.mountReadinessContractImplemented, isTrue);
      expect(MathLiveMainWorkspaceMountFlagPolicy.mainWorkspaceMountImplementedInThisPackage, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.q93FlagContractRequired, isTrue);
      expect(MathLiveMainWorkspaceMountFlagPolicy.q101LabSmokeEvidenceClosureRequired, isTrue);
      expect(MathLiveMainWorkspaceMountFlagPolicy.q105SolutionEvaluatorCandidateAdapterRequired, isTrue);
      expect(MathLiveMainWorkspaceMountFlagPolicy.explicitInternalFlagRequired, isTrue);
      expect(MathLiveMainWorkspaceMountFlagPolicy.legacyRollbackRequired, isTrue);
      expect(MathLiveMainWorkspaceMountFlagPolicy.mathLiveEnabledByDefault, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.moreLongPressMutationAllowed, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.cursorPassClaimAllowed, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.runtimeMountAllowedWithoutQ101, isFalse);
      expect(MathLiveMainWorkspaceMountFlagPolicy.defaultEditorSwitchAllowed, isFalse);
      expect(MathProPackageContract.q106MainWorkspaceMathLiveMountFlagRule, contains('V172-Q106'));
    });

    test('keeps MathLive mount blocked when Q101 evidence/runtime and internal flag are missing', () {
      final readiness = MathLiveMainWorkspaceMountFlagPolicy.evaluateReadiness(
        q93FlagContractPresent: true,
        q101LabSmokeEvidenceClosed: false,
        q105SolutionEvaluatorAdapterPackageReady: true,
        explicitInternalFlagEnabled: false,
        officialRuntimeVerified: false,
        protectedSurfacesUnchanged: true,
        appShellUntouched: true,
        keyboardUntouched: true,
        graphHistorySolutionUiUntouched: true,
        legacyRollbackAvailable: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        noFakeEvidence: true,
        mainWorkspaceMountCodeNotMutated: true,
      );

      expect(readiness.status, 'MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED');
      expect(readiness.packageSideMountFlagReady, isTrue);
      expect(readiness.mayMountBehindInternalFlagAtRuntime, isFalse);
      expect(readiness.mathLiveEnabledByDefault, isFalse);
      expect(readiness.selectedDefaultEngine, 'legacyFlutterSlotEditor');
      expect(readiness.rollbackEngine, 'legacyFlutterSlotEditor');
      expect(readiness.maySwitchDefaultEditor, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.blockers, contains('Q101 Lab smoke evidence closure has not passed; Q106 runtime mount must remain blocked'));
    });

    test('builds mount plan that falls back to legacy until evidence and flag are real', () {
      const q101 = MathLiveLabSmokeEvidenceClosureVerdict(
        status: 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE',
        blockers: <String>['missing evidence'],
        labSmokeEvidenceClosed: false,
        mayRunQ87CursorCourt: false,
        mayClaimCursorPass: false,
        maySwitchMainEditor: false,
        mayMountMainEditor: false,
        mayEnableMathLiveByDefault: false,
        mayDeleteLegacyCursor: false,
      );
      const q105 = MathLiveSolutionEvaluatorAdapterReadiness(
        status: 'MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED',
        blockers: <String>['Q101 blocked'],
        packageSideSolutionEvaluatorReady: true,
        mayProceedToRuntimeSolutionBinding: false,
        mayWriteSolutionAtRuntime: false,
        maySwitchMainEditor: false,
        mayMountMainEditor: false,
        mayDeleteLegacyCursor: false,
        mayClaimCursorPass: false,
        mayMutateSolutionStepsPanel: false,
      );

      final plan = MathLiveMainWorkspaceMountFlagPolicy.buildMountPlan(
        requestedEngine: 'mathlive',
        explicitInternalFlagEnabled: false,
        q101Verdict: q101,
        q105Readiness: q105,
        officialRuntimeVerified: false,
        protectedSurfacesUnchanged: true,
        appShellUntouched: true,
        keyboardUntouched: true,
        graphHistorySolutionUiUntouched: true,
        legacyRollbackAvailable: true,
      );

      expect(plan.phase, 'V172-Q106');
      expect(plan.requestedEngine, 'mathlive');
      expect(plan.selectedEngine, 'legacyFlutterSlotEditor');
      expect(plan.internalFlagName, 'mathpro.internal.editorEngine.mathlive');
      expect(plan.packageSideMountFlagReady, isTrue);
      expect(plan.mayMountBehindInternalFlagAtRuntime, isFalse);
      expect(plan.runtimeMountAllowed, isFalse);
      expect(plan.mathLiveEnabledByDefault, isFalse);
      expect(plan.defaultEditorSwitchAllowed, isFalse);
      expect(plan.legacyRollbackAvailable, isTrue);
      expect(plan.appShellMutationAllowed, isFalse);
      expect(plan.keyboardMutationAllowed, isFalse);
      expect(plan.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(plan.legacyCursorDeletionAllowed, isFalse);
      expect(plan.cursorPassClaimAllowed, isFalse);
    });

    test('metadata and verifier contain Q106 hard guard markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_main_workspace_mount_flag.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q106_MAIN_WORKSPACE_MOUNT_FLAG_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q106_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final historyController = File('lib/features/history/history_controller.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q106MainWorkspaceMountFlagPhase": "V172-Q106"'));
      expect(manifest, contains('"q106MainWorkspaceMountImplementedInThisPackage": false'));
      expect(manifest, contains('"q106RequiresExplicitInternalFlag": true'));
      expect(manifest, contains('"q106RequiresQ101LabSmokeEvidenceClosure": true'));
      expect(manifest, contains('"q106MayMutateAppShell": false'));
      expect(manifest, contains('"q106MaySwitchDefaultEditor": false'));
      expect(manifest, contains('"q106MayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q106 Main Workspace MathLive Mount Behind Internal Flag'));
      expect(verifier, contains('MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q106 adds MathLive main-workspace mount readiness behind an explicit internal flag'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(appShell, isNot(contains('V172-Q106')));
      expect(keyConfig, isNot(contains('V172-Q106')));
      expect(graphCard, isNot(contains('V172-Q106')));
      expect(historyController, isNot(contains('V172-Q106')));
      expect(solutionPanel, isNot(contains('V172-Q106')));
      expect(verifier, isNot(contains('"q106MaySwitchDefaultEditor": true')));
      expect(verifier, isNot(contains('"q106MayDeleteLegacyCursor": true')));
    });
  });
}
