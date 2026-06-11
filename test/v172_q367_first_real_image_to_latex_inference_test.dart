import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_q367.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_q367_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q367 prepares explicit first real image-to-LaTeX inference bridge without auto OCR or import', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q367 = manifest['v172Q367FirstRealImageToLatexInference'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['firstRealImageToLatexInferenceLatestPhase'], GaussFirstRealImageToLatexInferenceQ367Policy.phase);
    expect(q367['phase'], GaussFirstRealImageToLatexInferenceQ367Policy.phase);
    expect(q367['sourcePhase'], GaussFirstRealImageToLatexInferenceQ367Policy.sourcePhase);
    expect(q367['status'], GaussFirstRealImageToLatexInferenceQ367Policy.status);
    expect(q367['bridgeChannel'], GaussFirstRealImageToLatexInferenceQ367Policy.bridgeChannel);
    expect(q367['bridgeMethod'], GaussFirstRealImageToLatexInferenceQ367Policy.bridgeMethod);
    expect(q367['selectedDependencyCoordinate'], GaussFirstRealImageToLatexInferenceQ367Policy.selectedDependencyCoordinate);
    expect(q367['expectedOnnxArtifactSha256'], GaussFirstRealImageToLatexInferenceQ367Policy.expectedOnnxArtifactSha256);
    expect(q367['expectedOnnxArtifactSizeBytes'], GaussFirstRealImageToLatexInferenceQ367Policy.expectedOnnxArtifactSizeBytes);
    expect(q367['expectedPrivateStorageRelativePath'], GaussFirstRealImageToLatexInferenceQ367Policy.expectedPrivateStorageRelativePath);
    expect(q367['candidateEnvelopeVersion'], GaussFirstRealImageToLatexInferenceQ367Policy.candidateEnvelopeVersion);

    for (final key in <String>[
      'firstRealImageToLatexBridgePrepared',
      'explicitBridgeInvocationRequired',
      'requiresQ366DummyRuntimeCallExecution',
      'privateStorageModelRequired',
      'sourceImagePathRequired',
      'sizeVerificationRequiredBeforeInference',
      'sha256VerificationRequiredBeforeInference',
      'dependencyClassProbeRequired',
      'imageDecodeRequired',
      'imageTensorPreprocessPrepared',
      'candidateEnvelopePrepared',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q367[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'onnxModelBundledIntoFlutterProject',
      'onnxModelAutoCopiedAtStartup',
      'imageToLatexInferenceAutoExecuted',
      'imageToLatexInferenceAttemptedByPackage',
      'imageToLatexPassClaimedByPackage',
      'outputDecodingImplemented',
      'editableMathLiveReviewOpened',
      'workspaceImportExecuted',
      'solveGraphSolutionHistoryTouched',
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
      expect(q367[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussFirstRealImageToLatexInferenceQ367.evaluate();
    expect(result.phase, GaussFirstRealImageToLatexInferenceQ367Policy.phase);
    expect(result.firstRealImageToLatexBridgePrepared, isTrue);
    expect(result.explicitBridgeInvocationRequired, isTrue);
    expect(result.requiresQ366DummyRuntimeCallExecution, isTrue);
    expect(result.imageToLatexInferenceAutoExecuted, isFalse);
    expect(result.imageToLatexInferenceAttemptedByPackage, isFalse);
    expect(result.imageToLatexPassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
