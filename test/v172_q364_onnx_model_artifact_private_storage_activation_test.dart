import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_model_artifact_private_storage_activation_q364.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_model_artifact_private_storage_activation_q364_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q364 prepares explicit ONNX private-storage activation without OCR or UI mutation', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q364 = manifest['v172Q364OnnxModelArtifactPrivateStorageActivation'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['onnxModelArtifactPrivateStorageActivationLatestPhase'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.phase);
    expect(q364['phase'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.phase);
    expect(q364['sourcePhase'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.sourcePhase);
    expect(q364['runtimeBridgeSourcePhase'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.runtimeBridgeSourcePhase);
    expect(q364['status'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.status);
    expect(q364['bridgeChannel'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.bridgeChannel);
    expect(q364['bridgeMethod'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.bridgeMethod);
    expect(q364['selectedDependencyCoordinate'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.selectedDependencyCoordinate);
    expect(q364['expectedOnnxArtifactSha256'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.expectedOnnxArtifactSha256);
    expect(q364['expectedOnnxArtifactSizeBytes'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.expectedOnnxArtifactSizeBytes);
    expect(q364['expectedPrivateStorageRelativePath'], GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.expectedPrivateStorageRelativePath);

    for (final key in <String>[
      'privateStorageActivationBridgePrepared',
      'explicitBridgeInvocationRequired',
      'sourcePathRequiredForCopy',
      'sizeVerificationRequired',
      'sha256VerificationRequired',
      'atomicCopyPolicyPrepared',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
    ]) {
      expect(q364[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'onnxModelBundledIntoFlutterProject',
      'onnxModelAutoCopiedAtStartup',
      'cameraAutoExecutionEnabled',
      'modelLoadAutoExecuted',
      'modelLoadAttemptedByPackage',
      'dummyRuntimeCallExecuted',
      'imageToLatexInferenceExecuted',
      'editableMathLiveReviewOpened',
      'workspaceImportExecuted',
      'solveGraphSolutionHistoryTouched',
      'modelPrivateStoragePassClaimedByPackage',
      'modelLoadPassClaimedByPackage',
      'ocrPassClaimed',
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
      expect(q364[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussOnnxModelArtifactPrivateStorageActivationQ364.evaluate();
    expect(result.phase, GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.phase);
    expect(result.privateStorageActivationBridgePrepared, isTrue);
    expect(result.explicitBridgeInvocationRequired, isTrue);
    expect(result.modelBundledIntoProjectZip, isFalse);
    expect(result.modelLoadAttemptedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
