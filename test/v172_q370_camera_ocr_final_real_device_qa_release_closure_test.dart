import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_final_real_device_qa_release_closure_q370.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_final_real_device_qa_release_closure_q370_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q370 prepares final camera OCR QA and release closure without claiming pass', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q370 = manifest['v172Q370CameraOcrFinalRealDeviceQaReleaseClosure'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['cameraOcrFinalRealDeviceQaReleaseClosureLatestPhase'], GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.phase);
    expect(q370['phase'], GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.phase);
    expect(q370['sourcePhase'], GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.sourcePhase);
    expect(q370['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q370['status'], GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.status);
    expect(q370['finalClosureEnvelopeVersion'], GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.finalClosureEnvelopeVersion);
    expect(q370['expectedOnnxArtifactSha256'], GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.expectedOnnxArtifactSha256);
    expect(q370['expectedOnnxArtifactSizeBytes'], GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.expectedOnnxArtifactSizeBytes);

    for (final key in <String>[
      'finalRealDeviceQaClosurePrepared',
      'requiresFlutterAnalyzePass',
      'requiresFlutterTestPass',
      'requiresFlutterRunPass',
      'requiresQ364PrivateStorageEvidence',
      'requiresQ365ModelLoadSmokeEvidence',
      'requiresQ366DummyRuntimeCallEvidence',
      'requiresQ367ImageToLatexEvidence',
      'requiresQ368EditableReviewEvidence',
      'requiresQ369ApprovedImportEvidence',
      'requiresNoDirectOcrToWorkspaceImport',
      'requiresNoDirectOcrToSolveGraphSolutionHistory',
      'requiresStorePrivacyDataSafetyReview',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q370[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'modelPrivateStoragePassClaimed',
      'modelLoadPassClaimed',
      'dummyRuntimeCallPassClaimed',
      'imageToLatexPassClaimed',
      'ocrReviewPassClaimed',
      'workspaceImportPassClaimed',
      'ocrPassClaimed',
      'androidPassClaimed',
      'storeReadyPassClaimed',
      'releaseReadyPassClaimed',
      'workspaceImportAutoExecuted',
      'solveGraphSolutionHistoryTouched',
      'pubspecChanged',
      'gradleChanged',
      'androidManifestChanged',
      'mainActivityChanged',
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
      expect(q370[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370.evaluate();
    expect(result.phase, GaussCameraOcrFinalRealDeviceQaReleaseClosureQ370Policy.phase);
    expect(result.finalRealDeviceQaClosurePrepared, isTrue);
    expect(result.requiresQ364PrivateStorageEvidence, isTrue);
    expect(result.requiresQ369ApprovedImportEvidence, isTrue);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.storeReadyPassClaimed, isFalse);
    expect(result.releaseReadyPassClaimed, isFalse);
  });
}
