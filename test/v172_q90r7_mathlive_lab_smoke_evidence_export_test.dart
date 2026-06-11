import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_smoke_evidence_export_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R7 MathLive Lab Smoke Evidence Export Guard', () {
    test('records a lab-only copy/export gate without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90r7MathLiveLabSmokeEvidenceExportRule, contains('MathLive Lab Smoke Evidence Export'));
      expect(MathLiveLabSmokeEvidenceExportPolicy.phase, 'V172-Q90R7');
      expect(MathLiveLabSmokeEvidenceExportPolicy.copyButtonKey, 'mathlive-lab-q90r7-copy-evidence');
      expect(MathLiveLabSmokeEvidenceExportPolicy.manualCaptureInput, 'tool/mathlive_lab_runtime_smoke_capture.json');
      expect(MathLiveLabSmokeEvidenceExportPolicy.writerScript, 'tool/write_mathlive_lab_smoke_evidence.mjs');
      expect(MathLiveLabSmokeEvidenceExportPolicy.labOnly, isTrue);
      expect(MathLiveLabSmokeEvidenceExportPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceExportPolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceExportPolicy.appMayWriteProjectEvidenceFile, isFalse);
      expect(MathLiveLabSmokeEvidenceExportPolicy.userMustPasteCaptureIntoToolFile, isTrue);
      expect(MathLiveLabSmokeEvidenceExportPolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceExportPolicy.cursorPassClaimAllowedFromExport, isFalse);
      expect(MathLiveLabSmokeEvidenceExportPolicy.photomathLevelClaimAllowedFromExport, isFalse);
      expect(MathLiveLabSmokeEvidenceExportPolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveLabSmokeEvidenceExportPolicy.mathLiveVirtualKeyboardMustStayDisabled, isTrue);
    });

    test('blocks copy/export when capture or red-line evidence is missing', () {
      final verdict = MathLiveLabSmokeEvidenceExportPolicy.evaluate(
        captureGenerated: false,
        captureContainsQ90R5EvidencePhase: false,
        captureContainsQ90R6AuthoringPhase: false,
        copyActionAvailable: false,
        appWritesProjectFile: false,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
        photomathClaimAbsent: true,
      );
      expect(verdict.status, 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_EXPORT');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.captureMayBeCopied, isFalse);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.issues, contains('Lab evidence capture has not been generated'));
      expect(verdict.issues, contains('copy/export action is not available in the isolated Lab'));
    });

    test('allows only clipboard/manual-file handoff before Q90R6 writer and Q90R5 verifier', () {
      final verdict = MathLiveLabSmokeEvidenceExportPolicy.evaluate(
        captureGenerated: true,
        captureContainsQ90R5EvidencePhase: true,
        captureContainsQ90R6AuthoringPhase: true,
        copyActionAvailable: true,
        appWritesProjectFile: false,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
        photomathClaimAbsent: true,
      );
      expect(verdict.status, 'MATHLIVE_LAB_SMOKE_EVIDENCE_CAPTURE_COPY_READY');
      expect(verdict.captureMayBeCopied, isTrue);
      expect(verdict.writerScriptMustRunAfterCopy, isTrue);
      expect(verdict.q90r5VerifierMustRunAfterWriting, isTrue);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.physicalLegacyDeletionAllowed, isFalse);
      expect(verdict.issues, isEmpty);
    });

    test('ships lab copy/export markers without remote scripts or protected UI mutation', () {
      final lab = File('lib/features/mathlive/mathlive_lab_screen.dart').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      expect(lab, contains('mathlive-lab-q90r7-copy-evidence'));
      expect(lab, contains('Clipboard.setData'));
      expect(lab, contains('tool/mathlive_lab_runtime_smoke_capture.json'));
      expect(bridge, contains('runtimeSmokeEvidenceExportPhase'));
      expect(bridge, contains('getRuntimeSmokeEvidenceCaptureClipboardText'));
      expect(manifest, contains('"runtimeSmokeEvidenceExportPhase": "V172-Q90R7"'));
      expect(manifest, contains('"runtimeSmokeEvidenceExportMaySwitchMainEditor": false'));
      expect(readme, contains('V172-Q90R7'));
      expect(lab, isNot(contains('http://')));
      expect(lab, isNot(contains('https://')));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
    });
  });
}
