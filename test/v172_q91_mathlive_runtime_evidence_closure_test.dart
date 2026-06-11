import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_evidence_closure_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q91 MathLive Runtime Evidence Closure', () {
    test('records Q91 as evidence closure only, not main-editor activation', () {
      expect(MathProPackageContract.q91MathLiveRuntimeEvidenceClosureRule, contains('V172-Q91'));
      expect(MathProPackageContract.q91MathLiveRuntimeEvidenceClosureRule, contains('canonical Q90R5'));
      expect(MathProPackageContract.nextPhase, contains('V172-Q92'));
      expect(MathProPackageContract.nextPhase, contains('Graph / History / Solution Adapter Hardening'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.nextPhase, contains('Native SlotBox Painter'));

      expect(MathLiveRuntimeEvidenceClosurePolicy.phase, 'V172-Q91');
      expect(MathLiveRuntimeEvidenceClosurePolicy.labOnly, isTrue);
      expect(MathLiveRuntimeEvidenceClosurePolicy.userRealDeviceReportMayBeRecorded, isTrue);
      expect(MathLiveRuntimeEvidenceClosurePolicy.userRealDeviceReportAloneClosesEvidence, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.officialRuntimeVerificationRequired, isTrue);
      expect(MathLiveRuntimeEvidenceClosurePolicy.canonicalSmokeEvidenceRequired, isTrue);
      expect(MathLiveRuntimeEvidenceClosurePolicy.canonicalSmokeEvidenceMayBeFaked, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.graphHistorySolutionAdapterWorkAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.legacyEditorRemainsDefault, isTrue);
      expect(MathLiveRuntimeEvidenceClosurePolicy.legacyEditorRemainsRollback, isTrue);
      expect(MathLiveRuntimeEvidenceClosurePolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.cursorPassClaimAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.photomathLevelClaimAllowed, isFalse);
      expect(MathLiveRuntimeEvidenceClosurePolicy.wolframLevelClaimAllowed, isFalse);
    });

    test('does not close evidence from user report alone', () {
      final verdict = MathLiveRuntimeEvidenceClosurePolicy.evaluate(
        userReportedLabWorksOnRealDevice: true,
        officialRuntimeInstallVerified: false,
        canonicalSmokeEvidencePresent: false,
        canonicalSmokeEvidenceVerified: false,
        remoteScriptsDisabled: true,
        virtualKeyboardDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
      );

      expect(verdict.status, 'BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_CLOSURE');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.evidenceClosureReady, isFalse);
      expect(verdict.q92AdapterHardeningMayBegin, isFalse);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.physicalLegacyDeletionAllowed, isFalse);
      expect(verdict.issues, contains('Q90R4 official runtime install verification has not passed'));
      expect(verdict.issues, contains('canonical Q90R5 Lab smoke evidence file is missing'));
      expect(verdict.issues, contains('canonical Q90R5 Lab smoke evidence has not verified'));
    });

    test('permits only Q92 readiness after verified runtime and verified canonical evidence', () {
      final verdict = MathLiveRuntimeEvidenceClosurePolicy.evaluate(
        userReportedLabWorksOnRealDevice: true,
        officialRuntimeInstallVerified: true,
        canonicalSmokeEvidencePresent: true,
        canonicalSmokeEvidenceVerified: true,
        remoteScriptsDisabled: true,
        virtualKeyboardDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
      );

      expect(verdict.status, 'MATHLIVE_RUNTIME_EVIDENCE_CLOSURE_READY_FOR_Q92');
      expect(verdict.evidenceClosureReady, isTrue);
      expect(verdict.q92AdapterHardeningMayBegin, isTrue);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.physicalLegacyDeletionAllowed, isFalse);
      expect(verdict.issues, isEmpty);
    });

    test('ships Q91 manifest/audit/test markers without runtime evidence fabrication', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final policy = File('lib/features/mathlive/mathlive_runtime_evidence_closure_policy.dart').readAsStringSync();
      final audit = File('docs/audit/V172_Q91_MATHLIVE_RUNTIME_EVIDENCE_CLOSURE_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q91_CHANGED_FILES_MANIFEST.md').readAsStringSync();

      expect(manifest, contains('"runtimeEvidenceClosurePhase": "V172-Q91"'));
      expect(manifest, contains('"userRealDeviceReportAloneClosesEvidence": false'));
      expect(manifest, contains('"q91MaySwitchMainEditor": false'));
      expect(manifest, contains('"q91MayDeleteLegacyCursor": false'));
      expect(manifest, contains('"q91MayClaimCursorPass": false'));
      expect(manifest, contains('"nextPhaseAfterQ91": "V172-Q92"'));
      expect(readme, contains('V172-Q91 MathLive Runtime Evidence Closure'));
      expect(policy, contains('canonicalSmokeEvidenceMayBeFaked = false'));
      expect(audit, contains('No fake PASS'));
      expect(changed, contains('Protected files intentionally untouched'));
    });
  });
}
