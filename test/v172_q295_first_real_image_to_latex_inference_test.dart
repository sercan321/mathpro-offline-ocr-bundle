import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_policy.dart';

void main() {
  const sha = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
  const cropSha = 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';

  test('V172-Q295 image-to-LaTeX inference contract remains real-inference blocked and review-first', () {
    final result = GaussFirstRealImageToLatexInference.evaluate();

    expect(result.phase, GaussFirstRealImageToLatexInferencePolicy.phase);
    expect(result.sourcePhase, GaussFirstRealImageToLatexInferencePolicy.sourcePhase);
    expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
    expect(result.inferenceFeatureFlag, 'gauss.ppFormulaNetS.firstRealImageToLatexInference.defaultOff');
    expect(result.inferenceReadinessState, 'BLOCKED_PENDING_Q294_REAL_DUMMY_INPUT_RUNTIME_CALL_AND_CAMERA_IMAGE_EVIDENCE');
    expect(result.decision, GaussFirstRealImageToLatexInferenceDecision.imageToLatexInferenceContractReadyRealInferenceBlocked);
    expect(result.inferenceFeatureFlagEnabledByDefault, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.realDummyInputRuntimeCallExecuted, isFalse);
    expect(result.nativeRuntimeStartupExecuted, isFalse);
    expect(result.nativeRuntimeHandlerImplemented, isFalse);
    expect(result.methodChannelRuntimeBindingAdded, isFalse);
    expect(result.cameraImageSentToNativeRuntime, isFalse);
    expect(result.latexCandidateReturnedByRuntime, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.firstRealImageToLatexInferencePreconditions, contains('q294-first-real-dummy-input-runtime-call-present'));
    expect(result.firstRealImageToLatexInferencePreconditions, contains('direct-solve-graph-solution-history-remain-blocked-for-camera-output'));
    expect(result.imageToLatexInferenceErrorCodes, contains('noRealImageToLatexInferenceExecutedInQ295'));
  });

  test('V172-Q295 request envelope validates private artifact, crop, SHA, ABI, preprocess, and timeout guards', () {
    const request = GaussImageToLatexInferenceRequestEnvelope(
      requestId: 'q295-img-001',
      engineLabel: 'PP-FormulaNet-S',
      runtimeSessionId: 'runtime-session-001',
      verifiedPrivateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/model.tar',
      expectedSha256: sha,
      actualSha256: sha,
      androidAbi: 'arm64-v8a',
      captureId: 'capture-001',
      croppedImagePath: '/data/user/0/com.mathpro.flutter/cache/crops/capture-001.png',
      croppedImageSha256: cropSha,
      croppedImageBytes: 524288,
      cropLeft: 0.08,
      cropTop: 0.16,
      cropWidth: 0.84,
      cropHeight: 0.48,
      rotationDegrees: 0,
      orientationLabel: 'portrait',
      lightingHint: 'normal',
      focusHint: 'sharp',
      preprocessProfile: 'q295-formula-crop-v1',
      timeoutMs: 2400,
      inferenceFeatureFlagEnabled: false,
      dummyInputRuntimeCallStatus: 'passed',
    );

    expect(request.shaMatches, isTrue);
    expect(request.hasCroppedImageSha, isTrue);
    expect(request.isPrivateStoragePath, isTrue);
    expect(request.isPrivateCropPath, isTrue);
    expect(request.supportedAbi, isTrue);
    expect(request.hasValidCropBounds, isTrue);
    expect(request.hasImageWithinBudget, isTrue);
    expect(request.hasPreprocessMetadata, isTrue);
    expect(request.withinTimeoutBudget, isTrue);

    final flagOff = GaussFirstRealImageToLatexInference.guardedImageToLatexInference(request);
    expect(flagOff.errorCode, 'imageToLatexFeatureFlagOff');
    expect(flagOff.canOpenMathLiveReview, isTrue);
    expect(flagOff.canImportToWorkspace, isFalse);
    expect(flagOff.canEvaluate, isFalse);
    expect(flagOff.canGraph, isFalse);
    expect(flagOff.canWriteSolutionOrHistory, isFalse);
    expect(flagOff.directWorkspaceMutationAttempted, isFalse);
  });

  test('V172-Q295 blocks even valid-looking enabled requests because no real inference is executed in this package', () {
    const request = GaussImageToLatexInferenceRequestEnvelope(
      requestId: 'q295-img-002',
      engineLabel: 'PP-FormulaNet-S',
      runtimeSessionId: 'runtime-session-002',
      verifiedPrivateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/model.tar',
      expectedSha256: sha,
      actualSha256: sha,
      androidAbi: 'arm64-v8a',
      captureId: 'capture-002',
      croppedImagePath: '/data/user/0/com.mathpro.flutter/cache/crops/capture-002.png',
      croppedImageSha256: cropSha,
      croppedImageBytes: 524288,
      cropLeft: 0.05,
      cropTop: 0.1,
      cropWidth: 0.9,
      cropHeight: 0.5,
      rotationDegrees: 0,
      orientationLabel: 'portrait',
      lightingHint: 'normal',
      focusHint: 'sharp',
      preprocessProfile: 'q295-formula-crop-v1',
      timeoutMs: 2400,
      inferenceFeatureFlagEnabled: true,
      dummyInputRuntimeCallStatus: 'passed',
    );

    final blocked = GaussFirstRealImageToLatexInference.guardedImageToLatexInference(request);
    expect(blocked.errorCode, 'noRealImageToLatexInferenceExecutedInQ295');
    expect(blocked.cameraImageSent, isFalse);
    expect(blocked.nativeRuntimeInvoked, isFalse);
    expect(blocked.latexCandidateReturned, isFalse);
    expect(blocked.primaryLatexCandidate, isEmpty);
    expect(blocked.canImportToWorkspace, isFalse);
  });

  test('V172-Q295 policy forbids runtime/model additions and fake OCR PASS claims', () {
    expect(GaussFirstRealImageToLatexInferencePolicy.realImageToLatexInferenceExecuted, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.realDummyInputRuntimeCallExecuted, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.paddleRuntimeAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.paddleOcrDependencyAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.nativeRuntimeHandlerImplemented, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.jniBindingAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.methodChannelRuntimeBindingAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.modelBinaryBundledInBaseApp, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.productionDownloadEnabled, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.directWorkspaceImportEnabled, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.directSolveGraphSolutionHistoryBlocked, isTrue);
    expect(GaussFirstRealImageToLatexInferencePolicy.imageToLatexPassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.ocrPassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.cameraOcrRuntimePassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.releasePassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferencePolicy.requiresUserSideRetest, contains('flutter test'));
  });
}
