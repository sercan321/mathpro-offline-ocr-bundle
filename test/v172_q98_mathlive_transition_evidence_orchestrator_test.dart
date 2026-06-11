import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_transition_evidence_orchestrator_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q98 MathLive transition evidence orchestrator', () {
    test('Q98 policy blocks PASS claims when runtime/device evidence is missing', () {
      final verdict = MathLiveTransitionEvidenceOrchestratorPolicy.evaluate(
        contractVerifierPassed: true,
        runtimeVerifierPassed: false,
        smokeEvidenceVerifierPassed: false,
        flutterPubGetPassed: false,
        flutterAnalyzePassed: false,
        flutterTestPassed: false,
        mainAppRealDeviceRunEvidencePresent: false,
        mathLiveLabRealDeviceRunEvidencePresent: false,
        protectedSurfacesUnchanged: true,
        packageHygieneClean: true,
        noMainEditorSwitchAttempted: true,
        noLegacyDeletionAttempted: true,
      );

      expect(MathLiveTransitionEvidenceOrchestratorPolicy.phase, 'V172-Q98');
      expect(MathLiveTransitionEvidenceOrchestratorPolicy.singleCommandCourtOrchestratorProvided, isTrue);
      expect(MathLiveTransitionEvidenceOrchestratorPolicy.staticPackageMayClaimDevicePass, isFalse);
      expect(MathLiveTransitionEvidenceOrchestratorPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveTransitionEvidenceOrchestratorPolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveTransitionEvidenceOrchestratorPolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(verdict.status, 'BLOCKED_MATHLIVE_TRANSITION_EVIDENCE_ORCHESTRATOR');
      expect(verdict.evidenceLedgerComplete, isFalse);
      expect(verdict.mayClaimRealDevicePass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
      expect(verdict.blockers, contains('MathLive runtime verifier PASS is missing'));
      expect(verdict.blockers, contains('MathLive smoke evidence verifier PASS is missing'));
      expect(verdict.blockers, contains('main app real-device run evidence is missing'));
    });

    test('Q98 only marks ledger ready when all external evidence gates are true, but still does not unlock destructive actions', () {
      final verdict = MathLiveTransitionEvidenceOrchestratorPolicy.evaluate(
        contractVerifierPassed: true,
        runtimeVerifierPassed: true,
        smokeEvidenceVerifierPassed: true,
        flutterPubGetPassed: true,
        flutterAnalyzePassed: true,
        flutterTestPassed: true,
        mainAppRealDeviceRunEvidencePresent: true,
        mathLiveLabRealDeviceRunEvidencePresent: true,
        protectedSurfacesUnchanged: true,
        packageHygieneClean: true,
        noMainEditorSwitchAttempted: true,
        noLegacyDeletionAttempted: true,
      );

      expect(verdict.status, 'MATHLIVE_TRANSITION_EVIDENCE_LEDGER_READY_FOR_FINAL_REVIEW');
      expect(verdict.evidenceLedgerComplete, isTrue);
      expect(verdict.blockers, isEmpty);
      expect(verdict.mayClaimRealDevicePass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
    });

    test('Q98 tool, metadata, README and audit files are present without protected-surface mutation permission', () {
      final tool = File('tool/run_mathlive_transition_court.mjs').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final audit = File('docs/audit/V172_Q98_MATHLIVE_TRANSITION_EVIDENCE_ORCHESTRATOR_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q98_CHANGED_FILES_MANIFEST.md').readAsStringSync();

      expect(MathProPackageContract.readmeTitle, contains('V172-Q98 MathLive Evidence Orchestrator'));
      expect(MathProPackageContract.q98MathLiveTransitionEvidenceOrchestratorRule, contains('V172-Q98'));
      expect(tool, contains('V172-Q98'));
      expect(tool, contains('--run-flutter'));
      expect(tool, contains('--run-device'));
      expect(tool, contains('maySwitchMainEditor: false'));
      expect(tool, contains('mayDeleteLegacyCursor: false'));
      expect(manifest, contains('"q98MathLiveTransitionEvidenceOrchestratorPhase": "V172-Q98"'));
      expect(manifest, contains('"q98SingleCommandCourtOrchestratorProvided": true'));
      expect(manifest, contains('"q98MayClaimRealDevicePass": false'));
      expect(manifest, contains('"q98MaySwitchMainEditor": false'));
      expect(manifest, contains('"q98MayDeleteLegacyCursor": false'));
      expect(manifest, contains('"q98ProtectedUiSurfaceMutationAllowed": false'));
      expect(readme, contains('V172-Q98 MathLive Transition Evidence Orchestrator'));
      expect(audit, contains('No fake device PASS'));
      expect(changed, contains('Protected files intentionally untouched'));
    });
  });
}
