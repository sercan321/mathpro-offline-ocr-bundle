import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_smoke_evidence_authoring_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R6 MathLive Lab Smoke Evidence Authoring Harness', () {
    test('records a lab-only authoring gate without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90r6MathLiveLabSmokeEvidenceAuthoringRule, contains('MathLive Lab Smoke Evidence Authoring Harness'));
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.phase, 'V172-Q90R6');
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.writerScript, 'tool/write_mathlive_lab_smoke_evidence.mjs');
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.defaultCaptureInput, 'tool/mathlive_lab_runtime_smoke_capture.json');
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.canonicalEvidenceOutput, 'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json');
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.legacyEngineRemainsDefault, isTrue);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.legacyEngineRemainsRollback, isTrue);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.cursorPassClaimAllowedFromAuthoredEvidence, isFalse);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.photomathLevelClaimAllowedFromAuthoredEvidence, isFalse);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceAuthoringPolicy.mathLiveVirtualKeyboardMustStayDisabled, isTrue);
    });

    test('blocks authoring when runtime verification or capture is missing', () {
      final verdict = MathLiveLabSmokeEvidenceAuthoringPolicy.evaluate(
        runtimeVerificationReportPresent: false,
        runtimeInstallVerified: false,
        captureInputPresent: false,
        capturePhaseAcceptable: false,
        captureRuntimeSmokePassed: false,
        captureOfficialRuntimeLoaded: false,
        captureMathfieldMounted: false,
        smokeCommandPasses: 0,
        smokeCommandTotal: 6,
        bridgeCanInsertLatex: false,
        bridgeCanDeleteBackward: false,
        bridgeCanExportLatex: false,
        stateAdapterAcceptedExport: false,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
        photomathClaimAbsent: true,
      );
      expect(verdict.status, 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORING');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.evidenceMayBeWritten, isFalse);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.issues, contains('Q90R4 runtime verification report is missing'));
      expect(verdict.issues, contains('MathLive Lab smoke capture input is missing'));
    });

    test('allows writing only the canonical Q90R5 evidence file, then requires Q90R5 verification', () {
      final verdict = MathLiveLabSmokeEvidenceAuthoringPolicy.evaluate(
        runtimeVerificationReportPresent: true,
        runtimeInstallVerified: true,
        captureInputPresent: true,
        capturePhaseAcceptable: true,
        captureRuntimeSmokePassed: true,
        captureOfficialRuntimeLoaded: true,
        captureMathfieldMounted: true,
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
        fakeCursorPassClaimAbsent: true,
        photomathClaimAbsent: true,
      );
      expect(verdict.status, 'MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORED_FOR_Q90R5_VERIFICATION');
      expect(verdict.evidenceMayBeWritten, isTrue);
      expect(verdict.q90r5VerifierMustRunAfterWriting, isTrue);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.physicalLegacyDeletionAllowed, isFalse);
      expect(verdict.issues, isEmpty);
    });

    test('ships authoring script, bridge capture hook, and manifest markers without remote scripts', () {
      final writer = File(MathLiveLabSmokeEvidenceAuthoringPolicy.writerScript).readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      expect(writer, contains("phase = 'V172-Q90R6'"));
      expect(writer, contains('BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORING'));
      expect(writer, contains('docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json'));
      expect(writer, contains('mainEditorSwitchAllowed: false'));
      expect(bridge, contains('runtimeSmokeEvidenceAuthoringPhase'));
      expect(bridge, contains('getRuntimeSmokeEvidenceCaptureForAuthoring'));
      expect(manifest, contains('"runtimeSmokeEvidenceAuthoringPhase": "V172-Q90R6"'));
      expect(readme, contains('V172-Q90R6'));
      expect(writer, isNot(contains('http://')));
      expect(writer, isNot(contains('https://')));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
