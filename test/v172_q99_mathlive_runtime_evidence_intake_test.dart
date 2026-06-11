import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_evidence_intake_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q99 MathLive runtime evidence intake', () {
    test('Q99 blocks runtime intake readiness when official runtime or smoke evidence is missing', () {
      final verdict = MathLiveRuntimeEvidenceIntakePolicy.evaluate(
        officialRuntimeVendorFilesPresent: false,
        runtimeVerifierPassed: false,
        canonicalSmokeEvidencePresent: false,
        smokeEvidenceVerifierPassed: false,
        q98CourtReportPresent: true,
        protectedSurfacesUnchanged: true,
        noMainEditorSwitchAttempted: true,
        noLegacyDeletionAttempted: true,
        packageHygieneClean: true,
      );

      expect(MathLiveRuntimeEvidenceIntakePolicy.phase, 'V172-Q99');
      expect(MathLiveRuntimeEvidenceIntakePolicy.runtimeAndSmokeEvidenceIntakeProvided, isTrue);
      expect(MathLiveRuntimeEvidenceIntakePolicy.createsFakeRuntimeEvidence, isFalse);
      expect(MathLiveRuntimeEvidenceIntakePolicy.createsFakeSmokeEvidence, isFalse);
      expect(MathLiveRuntimeEvidenceIntakePolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceIntakePolicy.legacyCursorDeletionAllowed, isFalse);
      expect(verdict.status, 'BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_INTAKE');
      expect(verdict.runtimeEvidenceIntakeReady, isFalse);
      expect(verdict.mayStartQ92AdapterReview, isFalse);
      expect(verdict.mayClaimCursorPass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
      expect(verdict.blockers, contains('official MathLive runtime vendor files are missing'));
      expect(verdict.blockers, contains('canonical Q90R5 smoke evidence is missing'));
    });

    test('Q99 intake readiness still does not authorize cursor PASS, main editor switch, or deletion', () {
      final verdict = MathLiveRuntimeEvidenceIntakePolicy.evaluate(
        officialRuntimeVendorFilesPresent: true,
        runtimeVerifierPassed: true,
        canonicalSmokeEvidencePresent: true,
        smokeEvidenceVerifierPassed: true,
        q98CourtReportPresent: true,
        protectedSurfacesUnchanged: true,
        noMainEditorSwitchAttempted: true,
        noLegacyDeletionAttempted: true,
        packageHygieneClean: true,
      );

      expect(verdict.status, 'MATHLIVE_RUNTIME_EVIDENCE_INTAKE_READY_FOR_Q92_REVIEW');
      expect(verdict.runtimeEvidenceIntakeReady, isTrue);
      expect(verdict.mayStartQ92AdapterReview, isTrue);
      expect(verdict.mayClaimCursorPass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayEnableMathLiveByDefault, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
    });

    test('Q99 tool, metadata and audit files are present and keep protected surfaces locked', () {
      final tool = File('tool/verify_mathlive_runtime_evidence_intake.mjs').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final audit = File('docs/audit/V172_Q99_MATHLIVE_RUNTIME_EVIDENCE_INTAKE_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q99_CHANGED_FILES_MANIFEST.md').readAsStringSync();

      expect(MathProPackageContract.readmeTitle, contains('V172-Q99 MathLive Runtime Evidence Intake'));
      expect(MathProPackageContract.q99MathLiveRuntimeEvidenceIntakeRule, contains('V172-Q99'));
      expect(tool, contains('V172-Q99'));
      expect(tool, contains('BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_INTAKE'));
      expect(tool, contains('maySwitchMainEditor: false'));
      expect(tool, contains('mayDeleteLegacyCursor: false'));
      expect(manifest, contains('"q99MathLiveRuntimeEvidenceIntakePhase": "V172-Q99"'));
      expect(manifest, contains('"q99MaySwitchMainEditor": false'));
      expect(manifest, contains('"q99MayDeleteLegacyCursor": false'));
      expect(manifest, contains('"q99ProtectedUiSurfaceMutationAllowed": false'));
      expect(readme, contains('V172-Q99 MathLive Runtime Evidence Intake'));
      expect(audit, contains('No fake runtime or smoke PASS'));
      expect(changed, contains('Protected files intentionally untouched'));
    });
  });
}
