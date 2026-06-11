import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_runtime_evidence_capture_q371.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_runtime_evidence_capture_q371_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q371 prepares controlled OCR activation evidence capture without auto import or solve', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q371 = manifest['v172Q371ControlledOcrActivationRuntimeEvidenceCapture'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['controlledOcrActivationRuntimeEvidenceCaptureLatestPhase'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.phase);
    expect(q371['phase'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.phase);
    expect(q371['sourcePhase'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.sourcePhase);
    expect(q371['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q371['status'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.status);
    expect(q371['bridgeChannel'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.bridgeChannel);
    expect(q371['bridgeMethod'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.bridgeMethod);
    expect(q371['evidenceEnvelopeVersion'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.evidenceEnvelopeVersion);
    expect(q371['expectedOnnxModelFileName'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.expectedOnnxModelFileName);
    expect(q371['expectedOnnxModelSizeBytes'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.expectedOnnxModelSizeBytes);
    expect(q371['expectedOnnxModelSha256'], GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.expectedOnnxModelSha256);

    for (final key in <String>[
      'controlledOcrActivationRuntimeEvidenceCapturePrepared',
      'explicitBridgeInvocationRequired',
      'requiresQ364PrivateStorageActivation',
      'requiresQ365ModelLoadSmoke',
      'requiresQ366DummyRuntimeCall',
      'requiresQ367ImageToLatexInference',
      'requiresQ368EditableMathLiveReview',
      'requiresQ369ApprovedWorkspaceImport',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'startupAutoExecutionBlocked',
      'cameraAutoExecutionBlocked',
      'workspaceAutoExecutionBlocked',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q371[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'workspaceImportExecuted',
      'approvedWorkspaceImportExecuted',
      'solveGraphSolutionHistoryTouched',
      'ocrPassClaimed',
      'modelPrivateStoragePassClaimedByPackage',
      'modelLoadPassClaimedByPackage',
      'dummyRuntimeCallPassClaimedByPackage',
      'imageToLatexPassClaimedByPackage',
      'ocrReviewPassClaimedByPackage',
      'workspaceImportPassClaimedByPackage',
      'androidPassClaimed',
      'storeReadyPassClaimed',
      'releaseReadyPassClaimed',
      'pubspecChanged',
      'gradleChanged',
      'androidManifestChanged',
      'keyboardChanged',
      'moreTemplateTrayChanged',
      'longPressChanged',
      'mathLiveProductionBridgeChanged',
      'workspaceChanged',
      'graphChanged',
      'solutionChanged',
      'historyChanged',
      'splashChanged',
      'iconChanged',
    ]) {
      expect(q371[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussControlledOcrActivationRuntimeEvidenceCaptureQ371.evaluate();
    expect(result.phase, GaussControlledOcrActivationRuntimeEvidenceCaptureQ371Policy.phase);
    expect(result.controlledOcrActivationRuntimeEvidenceCapturePrepared, isTrue);
    expect(result.requiresQ364PrivateStorageActivation, isTrue);
    expect(result.requiresQ369ApprovedWorkspaceImport, isTrue);
    expect(result.directOcrToWorkspaceImportBlocked, isTrue);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
