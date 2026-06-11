import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_runtime_smoke_on_device.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_runtime_smoke_on_device_policy.dart';

void main() {
  const acceptedSha = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';

  GaussFirstRealRuntimeSmokeOnDeviceInput safeInput() {
    return const GaussFirstRealRuntimeSmokeOnDeviceInput(
      q281PrivateArtifactLoadSmokePresent: true,
      q280NativeRuntimeBridgePresent: true,
      q279DependencyTrialPresent: true,
      q278EvidenceLockPresent: true,
      verifiedPrivateArtifactEvidenceAccepted: true,
      acceptedArtifactSha256: acceptedSha,
      privateAppStoragePathVerified: true,
      modelFormatProbeEvidenceRequired: true,
      runtimeStartupEvidenceRequired: true,
      dummyInputOnlyBridgeEvidenceRequired: true,
      timeoutCancellationEvidenceRequired: true,
      memoryPressureEvidenceRequired: true,
      latencyMeasurementEvidenceRequired: true,
      realDeviceFlutterRunEvidenceRequired: true,
      runtimeFeatureFlagDefaultOffUntilEvidence: true,
      reviewOnlyModeRequired: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      directSolveGraphSolutionHistoryBlocked: true,
      noRealRuntimeStartedInQ282: true,
      noRealDummyInputBridgeExecutedInQ282: true,
      noRealModelFormatProbeExecutedInQ282: true,
      noNativeRuntimeBridgeInvokedInQ282: true,
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
      noImageToLatexInferenceExecuted: true,
      runtimeSmokePassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      evidenceLabel: 'q282-device-smoke-court',
    );
  }

  test('V172-Q282 first real runtime smoke gate stays static, dummy-input only, and review-first', () {
    final result = GaussFirstRealRuntimeSmokeOnDevice.evaluate(safeInput());

    expect(result.decision, GaussFirstRealRuntimeSmokeOnDeviceDecision.readyForQ283ImageToLatexInferenceCourtOnly);
    expect(result.runtimeSmokeStaticReady, isTrue);
    expect(result.readyForQ283ImageToLatexInferenceCourtOnly, isTrue);
    expect(result.canStartRealRuntimeInQ282, isFalse);
    expect(result.canRunDummyInputBridgeInQ282, isFalse);
    expect(result.canRunImageToLatexInQ282, isFalse);
    expect(result.canImportCameraOutputWithoutReview, isFalse);
    expect(result.canClaimRuntimeSmokePassInQ282, isFalse);
    expect(result.canClaimOcrPassInQ282, isFalse);

    expect(result.phase, GaussFirstRealRuntimeSmokeOnDevicePolicy.phase);
    expect(result.sourcePhase, GaussFirstRealRuntimeSmokeOnDevicePolicy.sourcePhase);
    expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
    expect(result.smokeMode, contains('dummy-input'));
    expect(result.runtimeSmokeEnvelopeAdded, isTrue);
    expect(result.realRuntimeStartedInQ282, isFalse);
    expect(result.imageToLatexInferenceExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.requiredRuntimeSmokeGates, contains('directSolveGraphSolutionHistoryBlocked'));
    expect(result.blockedUntilRealEvidence, contains('realRuntimeStartupLog'));
    expect(result.forbiddenActions, contains('runImageToLatexInferenceInQ282'));
  });

  test('V172-Q282 blocks missing Q281 artifact load smoke evidence', () {
    final input = safeInput();
    final result = GaussFirstRealRuntimeSmokeOnDevice.evaluate(
      GaussFirstRealRuntimeSmokeOnDeviceInput(
        q281PrivateArtifactLoadSmokePresent: false,
        q280NativeRuntimeBridgePresent: input.q280NativeRuntimeBridgePresent,
        q279DependencyTrialPresent: input.q279DependencyTrialPresent,
        q278EvidenceLockPresent: input.q278EvidenceLockPresent,
        verifiedPrivateArtifactEvidenceAccepted: input.verifiedPrivateArtifactEvidenceAccepted,
        acceptedArtifactSha256: input.acceptedArtifactSha256,
        privateAppStoragePathVerified: input.privateAppStoragePathVerified,
        modelFormatProbeEvidenceRequired: input.modelFormatProbeEvidenceRequired,
        runtimeStartupEvidenceRequired: input.runtimeStartupEvidenceRequired,
        dummyInputOnlyBridgeEvidenceRequired: input.dummyInputOnlyBridgeEvidenceRequired,
        timeoutCancellationEvidenceRequired: input.timeoutCancellationEvidenceRequired,
        memoryPressureEvidenceRequired: input.memoryPressureEvidenceRequired,
        latencyMeasurementEvidenceRequired: input.latencyMeasurementEvidenceRequired,
        realDeviceFlutterRunEvidenceRequired: input.realDeviceFlutterRunEvidenceRequired,
        runtimeFeatureFlagDefaultOffUntilEvidence: input.runtimeFeatureFlagDefaultOffUntilEvidence,
        reviewOnlyModeRequired: input.reviewOnlyModeRequired,
        editableMathLiveReviewRequired: input.editableMathLiveReviewRequired,
        explicitUserApprovalRequiredBeforeWorkspaceImport: input.explicitUserApprovalRequiredBeforeWorkspaceImport,
        directSolveGraphSolutionHistoryBlocked: input.directSolveGraphSolutionHistoryBlocked,
        noRealRuntimeStartedInQ282: input.noRealRuntimeStartedInQ282,
        noRealDummyInputBridgeExecutedInQ282: input.noRealDummyInputBridgeExecutedInQ282,
        noRealModelFormatProbeExecutedInQ282: input.noRealModelFormatProbeExecutedInQ282,
        noNativeRuntimeBridgeInvokedInQ282: input.noNativeRuntimeBridgeInvokedInQ282,
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
        noImageToLatexInferenceExecuted: input.noImageToLatexInferenceExecuted,
        runtimeSmokePassClaimed: input.runtimeSmokePassClaimed,
        ocrPassClaimed: input.ocrPassClaimed,
        releasePassClaimed: input.releasePassClaimed,
        evidenceLabel: input.evidenceLabel,
      ),
    );

    expect(result.decision, GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedMissingQ281PrivateArtifactLoadSmoke);
    expect(result.runtimeSmokeStaticReady, isFalse);
    expect(result.canStartRealRuntimeInQ282, isFalse);
  });

  test('V172-Q282 runtime smoke envelope blocks flag-off and real execution in this package', () {
    const request = GaussFirstRuntimeSmokeRequestEnvelope(
      requestId: 'q282-smoke-001',
      privateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/model.pdmodel',
      acceptedArtifactSha256: acceptedSha,
      androidAbi: 'arm64-v8a',
      deviceModel: '23106RN0DA',
      androidApiLevel: 34,
      runtimeFeatureFlagEnabled: false,
      dummyInputPayloadHash: acceptedSha,
      dummyInputPayloadBytes: 512,
      startupTimeoutMs: 2500,
      dummyInputTimeoutMs: 900,
    );

    expect(request.isSafeDummySmokeEnvelope, isTrue);

    final flagOff = GaussFirstRealRuntimeSmokeOnDevice.guardedRuntimeSmoke(request);
    expect(flagOff.errorCode, 'runtimeFeatureFlagOff');
    expect(flagOff.runtimeStartupAttempted, isFalse);
    expect(flagOff.dummyInputBridgeAttempted, isFalse);
    expect(flagOff.imageToLatexInferenceAttempted, isFalse);
    expect(flagOff.reviewRequired, isTrue);
    expect(flagOff.directWorkspaceMutationAttempted, isFalse);
    expect(flagOff.canProceedToImageToLatexCourt, isFalse);
    expect(flagOff.canEvaluate, isFalse);
    expect(flagOff.canGraph, isFalse);
    expect(flagOff.canWriteSolutionOrHistory, isFalse);
  });

  test('V172-Q282 policy forbids dependency/runtime/model/inference additions and fake PASS claims', () {
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.realOcrRuntimeAdded, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.paddleRuntimeAdded, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.paddleOcrDependencyAdded, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.nativeHandlerImplementationAdded, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.jniBindingAdded, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.methodChannelRuntimeBindingAdded, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.modelBinaryBundledInBaseApp, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.productionModelUrlBound, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.productionDownloadEnabled, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.imageToLatexInferenceExecuted, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.runtimeSmokePassClaimed, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.ocrPassClaimed, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.cameraOcrRuntimePassClaimed, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.releasePassClaimed, isFalse);
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.forbiddenActions, contains('claimRuntimeSmokePassWithoutRealDeviceEvidence'));
    expect(GaussFirstRealRuntimeSmokeOnDevicePolicy.requiresUserSideRetest, contains('flutter test'));
  });
}
