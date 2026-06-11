import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_smoke_evidence_closure_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q101 Lab smoke evidence closure', () {
    test('Q101 blocks closure when runtime bundle or canonical evidence is missing', () {
      final verdict = MathLiveLabSmokeEvidenceClosurePolicy.evaluate(
        q100OfficialRuntimeBundleClosed: false,
        q90r6EvidenceAuthored: false,
        q90r5EvidenceVerified: false,
        canonicalEvidenceFilePresent: false,
        canonicalEvidenceJsonValid: false,
        evidencePhaseIsQ90R5: false,
        runtimeSmokePhaseIsQ90R2: false,
        installVerified: false,
        officialRuntimeScriptLoaded: false,
        mathfieldElementDefined: false,
        mathfieldInstanceMounted: false,
        labRuntimeSmokePassed: false,
        smokeCommandPasses: 0,
        smokeCommandTotal: 0,
        bridgeCanInsertLatex: false,
        bridgeCanDeleteBackward: false,
        bridgeCanExportLatex: false,
        stateAdapterAcceptedExport: false,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        noCursorPassClaim: true,
        noPhotomathWolframClaim: true,
        packageHygieneClean: true,
      );

      expect(MathLiveLabSmokeEvidenceClosurePolicy.phase, 'V172-Q101');
      expect(MathLiveLabSmokeEvidenceClosurePolicy.labSmokeEvidenceClosureGateProvided, isTrue);
      expect(MathLiveLabSmokeEvidenceClosurePolicy.createsFakeSmokeEvidence, isFalse);
      expect(MathLiveLabSmokeEvidenceClosurePolicy.writesCanonicalEvidenceDuringClosureVerification, isFalse);
      expect(MathLiveLabSmokeEvidenceClosurePolicy.requiresQ100OfficialRuntimeBundleClosure, isTrue);
      expect(MathLiveLabSmokeEvidenceClosurePolicy.requiresQ90R6EvidenceAuthoringReport, isTrue);
      expect(MathLiveLabSmokeEvidenceClosurePolicy.requiresQ90R5SmokeEvidenceVerification, isTrue);
      expect(MathLiveLabSmokeEvidenceClosurePolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceClosurePolicy.legacyCursorDeletionAllowed, isFalse);
      expect(verdict.status, 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE');
      expect(verdict.labSmokeEvidenceClosed, isFalse);
      expect(verdict.mayRunQ87CursorCourt, isFalse);
      expect(verdict.mayClaimCursorPass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayMountMainEditor, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
      expect(verdict.blockers, contains('Q100 official runtime bundle closure has not passed'));
      expect(verdict.blockers, contains('canonical Q90R5 smoke evidence file is missing'));
    });

    test('Q101 closure only unlocks Q87 court, not cursor PASS, main editor switch, or legacy deletion', () {
      final verdict = MathLiveLabSmokeEvidenceClosurePolicy.evaluate(
        q100OfficialRuntimeBundleClosed: true,
        q90r6EvidenceAuthored: true,
        q90r5EvidenceVerified: true,
        canonicalEvidenceFilePresent: true,
        canonicalEvidenceJsonValid: true,
        evidencePhaseIsQ90R5: true,
        runtimeSmokePhaseIsQ90R2: true,
        installVerified: true,
        officialRuntimeScriptLoaded: true,
        mathfieldElementDefined: true,
        mathfieldInstanceMounted: true,
        labRuntimeSmokePassed: true,
        smokeCommandPasses: 6,
        smokeCommandTotal: 6,
        bridgeCanInsertLatex: true,
        bridgeCanDeleteBackward: true,
        bridgeCanExportLatex: true,
        stateAdapterAcceptedExport: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        noCursorPassClaim: true,
        noPhotomathWolframClaim: true,
        packageHygieneClean: true,
      );

      expect(verdict.status, 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT');
      expect(verdict.labSmokeEvidenceClosed, isTrue);
      expect(verdict.mayRunQ87CursorCourt, isTrue);
      expect(verdict.mayClaimCursorPass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayMountMainEditor, isFalse);
      expect(verdict.mayEnableMathLiveByDefault, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
    });

    test('Q101 tool, metadata and audit files are present and keep protected surfaces locked', () {
      final tool = File('tool/verify_mathlive_lab_smoke_evidence_closure.mjs').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final audit = File('docs/audit/V172_Q101_LAB_SMOKE_EVIDENCE_CLOSURE_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q101_CHANGED_FILES_MANIFEST.md').readAsStringSync();

      expect(MathProPackageContract.readmeTitle, contains('V172-Q101 Lab Smoke Evidence Closure'));
      expect(MathProPackageContract.q101LabSmokeEvidenceClosureRule, contains('V172-Q101'));
      expect(tool, contains('V172-Q101'));
      expect(tool, contains('BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE'));
      expect(tool, contains('MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT'));
      expect(tool, contains('maySwitchMainEditor: false'));
      expect(tool, contains('mayDeleteLegacyCursor: false'));
      expect(manifest, contains('"q101LabSmokeEvidenceClosurePhase": "V172-Q101"'));
      expect(manifest, contains('"q101MayClaimCursorPass": false'));
      expect(manifest, contains('"q101MaySwitchMainEditor": false'));
      expect(manifest, contains('"q101MayDeleteLegacyCursor": false'));
      expect(manifest, contains('"q101ProtectedUiSurfaceMutationAllowed": false'));
      expect(readme, contains('V172-Q101 Lab Smoke Evidence Closure'));
      expect(audit, contains('No fake canonical smoke evidence'));
      expect(changed, contains('Protected files intentionally untouched'));
    });
  });
}
