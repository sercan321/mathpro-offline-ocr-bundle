import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_smoke_evidence_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R5 MathLive Lab Runtime Smoke Evidence Harness', () {
    test('records a lab-only evidence gate without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90r5MathLiveLabSmokeEvidenceRule, contains('MathLive Lab Runtime Smoke Evidence Harness'));
      expect(MathLiveLabSmokeEvidencePolicy.phase, 'V172-Q90R5');
      expect(MathLiveLabSmokeEvidencePolicy.verifierScript, 'tool/verify_mathlive_lab_smoke_evidence.mjs');
      expect(MathLiveLabSmokeEvidencePolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveLabSmokeEvidencePolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveLabSmokeEvidencePolicy.legacyEngineRemainsDefault, isTrue);
      expect(MathLiveLabSmokeEvidencePolicy.legacyEngineRemainsRollback, isTrue);
      expect(MathLiveLabSmokeEvidencePolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(MathLiveLabSmokeEvidencePolicy.cursorPassClaimAllowedFromSmokeEvidence, isFalse);
      expect(MathLiveLabSmokeEvidencePolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveLabSmokeEvidencePolicy.mathLiveVirtualKeyboardMustStayDisabled, isTrue);
    });

    test('blocks evidence when runtime smoke report is incomplete', () {
      final verdict = MathLiveLabSmokeEvidencePolicy.evaluate(
        installVerified: false,
        evidenceFilePresent: false,
        evidencePhaseIsQ90R5: false,
        runtimeSmokePhaseIsQ90R2: false,
        officialRuntimeScriptLoaded: false,
        mathfieldElementDefined: false,
        mathfieldInstanceMounted: false,
        labRuntimeSmokePassed: false,
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
      );
      expect(verdict.status, 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.evidenceVerified, isFalse);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.physicalLegacyDeletionAllowed, isFalse);
      expect(verdict.issues, contains('runtime smoke evidence file is missing'));
    });

    test('allows only Q87 cursor-court readiness when full lab smoke evidence exists', () {
      final verdict = MathLiveLabSmokeEvidencePolicy.evaluate(
        installVerified: true,
        evidenceFilePresent: true,
        evidencePhaseIsQ90R5: true,
        runtimeSmokePhaseIsQ90R2: true,
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
      );
      expect(verdict.status, 'MATHLIVE_LAB_SMOKE_EVIDENCE_READY_FOR_Q87_CURSOR_COURT');
      expect(verdict.evidenceVerified, isTrue);
      expect(verdict.q87CursorCourtMayRun, isTrue);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.mainEditorMountAllowed, isFalse);
      expect(verdict.legacyEngineRemainsRollback, isTrue);
      expect(verdict.issues, isEmpty);
    });

    test('ships verifier, template, bridge evidence hook, and manifest markers', () {
      final verifier = File(MathLiveLabSmokeEvidencePolicy.verifierScript).readAsStringSync();
      final template = File(MathLiveLabSmokeEvidencePolicy.evidenceTemplate).readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      expect(verifier, contains("phase = 'V172-Q90R5'"));
      expect(verifier, contains('BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE'));
      expect(verifier, contains('MATHLIVE_LAB_SMOKE_EVIDENCE_READY_FOR_Q87_CURSOR_COURT'));
      expect(template, contains('"evidencePhase": "V172-Q90R5"'));
      expect(template, contains('"mainEditorSwitchAllowed": false'));
      expect(bridge, contains('getRuntimeSmokeEvidenceReport'));
      expect(bridge, contains("evidencePhase: 'V172-Q90R5'"));
      expect(manifest, contains('"runtimeSmokeEvidencePhase": "V172-Q90R5"'));
      expect(manifest, contains('"runtimeSmokeEvidenceVerified": false'));
      expect(verifier, isNot(contains('http://')));
      expect(verifier, isNot(contains('https://')));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
