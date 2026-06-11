import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_court_policy.dart';

void main() {
  const croppedSha = 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';

  GaussFirstRealImageToLatexInferenceCourtInput safeInput() {
    return const GaussFirstRealImageToLatexInferenceCourtInput(
      q282FirstRealRuntimeSmokeOnDevicePresent: true,
      q281PrivateArtifactLoadSmokePresent: true,
      q280NativeRuntimeBridgePresent: true,
      q279DependencyTrialPresent: true,
      q278EvidenceLockPresent: true,
      acceptedQ282RuntimeSmokeEvidence: true,
      croppedImageEvidenceRequired: true,
      preprocessMetadataRequired: true,
      runtimeCandidateEnvelopeRequired: true,
      primaryLatexCandidateFieldRequired: true,
      alternativeLatexCandidatesFieldAllowed: true,
      confidenceWarningsEngineMetadataRequired: true,
      latencyMeasurementRequired: true,
      peakMemoryMeasurementRequired: true,
      timeoutCancellationEvidenceRequired: true,
      memoryPressureEvidenceRequired: true,
      runtimeFeatureFlagDefaultOffUntilEvidence: true,
      reviewOnlyModeRequired: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      directSolveGraphSolutionHistoryBlocked: true,
      noRealImageToLatexInferenceExecutedInQ283: true,
      noRealRuntimeInvocationExecutedInQ283: true,
      noNativeRuntimeBridgeInvokedInQ283: true,
      noNativeHandlerImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noPaddleRuntimeAdded: true,
      noPaddleOcrDependencyAdded: true,
      noRuntimeDependencyAddedToPubspec: true,
      noGradleNativeRuntimeDependencyAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noProductionDownloadEnabled: true,
      noRealNetworkDownloadWorkerImplemented: true,
      imageToLatexPassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      evidenceLabel: 'q283-image-to-latex-court',
    );
  }

  test('V172-Q283 image-to-LaTeX court stays gate-only, review-first, and blocks direct side effects', () {
    final result = GaussFirstRealImageToLatexInferenceCourt.evaluate(safeInput());

    expect(result.decision, GaussFirstRealImageToLatexInferenceCourtDecision.readyForQ284RealMathLiveReviewRuntimeBindingOnly);
    expect(result.imageToLatexCourtStaticReady, isTrue);
    expect(result.readyForQ284RealMathLiveReviewRuntimeBindingOnly, isTrue);
    expect(result.canRunRealImageToLatexInQ283, isFalse);
    expect(result.canImportCameraOutputWithoutReview, isFalse);
    expect(result.canEvaluate, isFalse);
    expect(result.canGraph, isFalse);
    expect(result.canWriteSolutionOrHistory, isFalse);
    expect(result.canClaimImageToLatexPassInQ283, isFalse);
    expect(result.canClaimOcrPassInQ283, isFalse);

    expect(result.phase, GaussFirstRealImageToLatexInferenceCourtPolicy.phase);
    expect(result.sourcePhase, GaussFirstRealImageToLatexInferenceCourtPolicy.sourcePhase);
    expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
    expect(result.courtMode, contains('no-real-inference'));
    expect(result.imageToLatexCourtEnvelopeAdded, isTrue);
    expect(result.realImageToLatexInferenceExecutedInQ283, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.requiredImageToLatexCourtGates, contains('directSolveGraphSolutionHistoryBlocked'));
    expect(result.blockedUntilRealEvidence, contains('realRuntimeCandidateResponseEvidence'));
    expect(result.forbiddenActions, contains('claimImageToLatexPassWithoutRealEvidence'));
  });

  test('V172-Q283 blocks missing Q282 runtime smoke evidence', () {
    final input = safeInput();
    final result = GaussFirstRealImageToLatexInferenceCourt.evaluate(
      GaussFirstRealImageToLatexInferenceCourtInput(
        q282FirstRealRuntimeSmokeOnDevicePresent: true,
        q281PrivateArtifactLoadSmokePresent: input.q281PrivateArtifactLoadSmokePresent,
        q280NativeRuntimeBridgePresent: input.q280NativeRuntimeBridgePresent,
        q279DependencyTrialPresent: input.q279DependencyTrialPresent,
        q278EvidenceLockPresent: input.q278EvidenceLockPresent,
        acceptedQ282RuntimeSmokeEvidence: false,
        croppedImageEvidenceRequired: input.croppedImageEvidenceRequired,
        preprocessMetadataRequired: input.preprocessMetadataRequired,
        runtimeCandidateEnvelopeRequired: input.runtimeCandidateEnvelopeRequired,
        primaryLatexCandidateFieldRequired: input.primaryLatexCandidateFieldRequired,
        alternativeLatexCandidatesFieldAllowed: input.alternativeLatexCandidatesFieldAllowed,
        confidenceWarningsEngineMetadataRequired: input.confidenceWarningsEngineMetadataRequired,
        latencyMeasurementRequired: input.latencyMeasurementRequired,
        peakMemoryMeasurementRequired: input.peakMemoryMeasurementRequired,
        timeoutCancellationEvidenceRequired: input.timeoutCancellationEvidenceRequired,
        memoryPressureEvidenceRequired: input.memoryPressureEvidenceRequired,
        runtimeFeatureFlagDefaultOffUntilEvidence: input.runtimeFeatureFlagDefaultOffUntilEvidence,
        reviewOnlyModeRequired: input.reviewOnlyModeRequired,
        editableMathLiveReviewRequired: input.editableMathLiveReviewRequired,
        explicitUserApprovalRequiredBeforeWorkspaceImport: input.explicitUserApprovalRequiredBeforeWorkspaceImport,
        directSolveGraphSolutionHistoryBlocked: input.directSolveGraphSolutionHistoryBlocked,
        noRealImageToLatexInferenceExecutedInQ283: input.noRealImageToLatexInferenceExecutedInQ283,
        noRealRuntimeInvocationExecutedInQ283: input.noRealRuntimeInvocationExecutedInQ283,
        noNativeRuntimeBridgeInvokedInQ283: input.noNativeRuntimeBridgeInvokedInQ283,
        noNativeHandlerImplementationAdded: input.noNativeHandlerImplementationAdded,
        noJniBindingAdded: input.noJniBindingAdded,
        noMethodChannelRuntimeBindingAdded: input.noMethodChannelRuntimeBindingAdded,
        noPaddleRuntimeAdded: input.noPaddleRuntimeAdded,
        noPaddleOcrDependencyAdded: input.noPaddleOcrDependencyAdded,
        noRuntimeDependencyAddedToPubspec: input.noRuntimeDependencyAddedToPubspec,
        noGradleNativeRuntimeDependencyAdded: input.noGradleNativeRuntimeDependencyAdded,
        noModelBinaryBundledInBaseApp: input.noModelBinaryBundledInBaseApp,
        noProductionModelUrlBound: input.noProductionModelUrlBound,
        noProductionDownloadEnabled: input.noProductionDownloadEnabled,
        noRealNetworkDownloadWorkerImplemented: input.noRealNetworkDownloadWorkerImplemented,
        imageToLatexPassClaimed: input.imageToLatexPassClaimed,
        ocrPassClaimed: input.ocrPassClaimed,
        releasePassClaimed: input.releasePassClaimed,
        evidenceLabel: input.evidenceLabel,
      ),
    );

    expect(result.decision, GaussFirstRealImageToLatexInferenceCourtDecision.blockedMissingQ282RuntimeSmokeEvidence);
    expect(result.imageToLatexCourtStaticReady, isFalse);
    expect(result.canRunRealImageToLatexInQ283, isFalse);
  });

  test('V172-Q283 cropped image request envelope blocks flag-off and no-real-inference paths', () {
    const request = GaussImageToLatexCourtRequestEnvelope(
      requestId: 'q283-img-001',
      captureId: 'capture-001',
      croppedImagePath: '/data/user/0/com.mathpro.flutter/cache/crops/capture-001.png',
      croppedImageSha256: croppedSha,
      croppedImageBytes: 524288,
      cropBounds: GaussImageToLatexCropBounds(left: 0.08, top: 0.18, width: 0.84, height: 0.42),
      rotationDegrees: 0,
      orientationLabel: 'portrait',
      lightingHint: 'normal',
      focusHint: 'sharp',
      preprocessProfile: 'q283-formula-crop-v1',
      runtimeFeatureFlagEnabled: false,
    );

    expect(request.isSafeCourtEnvelope, isTrue);

    final flagOff = GaussFirstRealImageToLatexInferenceCourt.guardedImageToLatexCourt(request);
    expect(flagOff.errorCode, 'imageToLatexFeatureFlagOff');
    expect(flagOff.canOpenMathLiveReview, isTrue);
    expect(flagOff.canImportToWorkspace, isFalse);
    expect(flagOff.canEvaluate, isFalse);
    expect(flagOff.canGraph, isFalse);
    expect(flagOff.canWriteSolutionOrHistory, isFalse);
    expect(flagOff.directWorkspaceMutationAttempted, isFalse);
    expect(flagOff.directSolveGraphSolutionHistoryAttempted, isFalse);
  });

  test('V172-Q283 policy forbids runtime/model/inference additions and fake PASS claims', () {
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.realOcrRuntimeAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.paddleRuntimeAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.paddleOcrDependencyAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.nativeHandlerImplementationAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.jniBindingAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.methodChannelRuntimeBindingAdded, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.modelBinaryBundledInBaseApp, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.productionModelUrlBound, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.productionDownloadEnabled, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.realImageToLatexInferenceExecutedInQ283, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.imageToLatexPassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.ocrPassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.cameraOcrRuntimePassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.releasePassClaimed, isFalse);
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.forbiddenActions, contains('runRealImageToLatexInferenceInQ283'));
    expect(GaussFirstRealImageToLatexInferenceCourtPolicy.requiresUserSideRetest, contains('flutter test'));
  });
}
