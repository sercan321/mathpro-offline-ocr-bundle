import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_artifact_load_real_smoke.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_artifact_load_real_smoke_policy.dart';

void main() {
  group('V172-Q281 private artifact load real smoke gate', () {
    const validSha = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
    const safeInput = GaussPrivateArtifactLoadRealSmokeInput(
      q280NativeRuntimeBridgePresent: true,
      q279DependencyTrialPresent: true,
      q278EvidenceLockPresent: true,
      privateAppStoragePathVerified: true,
      verifiedPrivateArtifactRequired: true,
      expectedSha256: validSha,
      actualSha256: validSha,
      checksumBeforeLoadRequired: true,
      checksumMatchBeforeReadyRequired: true,
      atomicMoveCompletedEvidenceRequired: true,
      modelFormatProbePlanRequired: true,
      dummyInputOnlySmokeRequired: true,
      timeoutCancellationPolicyRequired: true,
      memoryPressurePolicyRequired: true,
      reviewOnlyModeRequired: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      directSolveGraphSolutionHistoryBlocked: true,
      noRealPrivateArtifactFileLoadedInQ281: true,
      noModelFormatProbeExecutedInQ281: true,
      noNativeRuntimeBridgeInvokedInQ281: true,
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
      privateArtifactLoadPassClaimed: false,
      runtimeSmokePassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      evidenceLabel: 'q281-private-artifact-load-smoke-envelope',
    );

    test('advances only to Q282 gate readiness without real model load or inference', () {
      final result = GaussPrivateArtifactLoadRealSmoke.evaluate(safeInput);

      expect(result.phase, GaussPrivateArtifactLoadRealSmokePolicy.phase);
      expect(result.sourcePhase, GaussPrivateArtifactLoadRealSmokePolicy.sourcePhase);
      expect(result.privateArtifactLoadSmokeStaticReady, isTrue);
      expect(result.readyForQ282FirstRuntimeSmokeGateOnly, isTrue);
      expect(result.privateArtifactLoadSmokeEnvelopeAdded, isTrue);
      expect(result.realPrivateArtifactFileLoadedInQ281, isFalse);
      expect(result.modelFormatProbeExecutedInQ281, isFalse);
      expect(result.nativeRuntimeBridgeInvokedInQ281, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.canLoadRealPrivateArtifactInQ281, isFalse);
      expect(result.canExecuteModelFormatProbeInQ281, isFalse);
      expect(result.canInvokeNativeRuntimeBridgeInQ281, isFalse);
      expect(result.canImportCameraOutputWithoutReview, isFalse);
      expect(result.canClaimPrivateArtifactLoadPassInQ281, isFalse);
      expect(result.canClaimOcrPassInQ281, isFalse);
      expect(result.requiredPrivateArtifactLoadSmokeGates, contains('q280NativeRuntimeBridgePresent'));
      expect(result.requiredPrivateArtifactLoadSmokeGates, contains('checksumMatchBeforeReadyRequired'));
      expect(result.forbiddenActions, contains('runImageToLatexInferenceInQ281'));
    });

    test('blocks SHA mismatch and missing private artifact evidence', () {
      final mismatch = GaussPrivateArtifactLoadRealSmoke.evaluate(
        const GaussPrivateArtifactLoadRealSmokeInput(
          q280NativeRuntimeBridgePresent: true,
          q279DependencyTrialPresent: true,
          q278EvidenceLockPresent: true,
          privateAppStoragePathVerified: true,
          verifiedPrivateArtifactRequired: true,
          expectedSha256: validSha,
          actualSha256: 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
          checksumBeforeLoadRequired: true,
          checksumMatchBeforeReadyRequired: true,
          atomicMoveCompletedEvidenceRequired: true,
          modelFormatProbePlanRequired: true,
          dummyInputOnlySmokeRequired: true,
          timeoutCancellationPolicyRequired: true,
          memoryPressurePolicyRequired: true,
          reviewOnlyModeRequired: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noRealPrivateArtifactFileLoadedInQ281: true,
          noModelFormatProbeExecutedInQ281: true,
          noNativeRuntimeBridgeInvokedInQ281: true,
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
          privateArtifactLoadPassClaimed: false,
          runtimeSmokePassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'sha-mismatch',
        ),
      );

      expect(mismatch.decision, GaussPrivateArtifactLoadRealSmokeDecision.blockedShaMismatch);
      expect(mismatch.privateArtifactLoadSmokeStaticReady, isFalse);
      expect(mismatch.canLoadRealPrivateArtifactInQ281, isFalse);

      final missingStorage = GaussPrivateArtifactLoadRealSmoke.evaluate(
        const GaussPrivateArtifactLoadRealSmokeInput(
          q280NativeRuntimeBridgePresent: true,
          q279DependencyTrialPresent: true,
          q278EvidenceLockPresent: true,
          privateAppStoragePathVerified: false,
          verifiedPrivateArtifactRequired: true,
          expectedSha256: validSha,
          actualSha256: validSha,
          checksumBeforeLoadRequired: true,
          checksumMatchBeforeReadyRequired: true,
          atomicMoveCompletedEvidenceRequired: true,
          modelFormatProbePlanRequired: true,
          dummyInputOnlySmokeRequired: true,
          timeoutCancellationPolicyRequired: true,
          memoryPressurePolicyRequired: true,
          reviewOnlyModeRequired: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noRealPrivateArtifactFileLoadedInQ281: true,
          noModelFormatProbeExecutedInQ281: true,
          noNativeRuntimeBridgeInvokedInQ281: true,
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
          privateArtifactLoadPassClaimed: false,
          runtimeSmokePassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'missing-private-storage',
        ),
      );

      expect(missingStorage.decision, GaussPrivateArtifactLoadRealSmokeDecision.blockedMissingPrivateArtifactEvidence);
      expect(missingStorage.readyForQ282FirstRuntimeSmokeGateOnly, isFalse);
    });

    test('guarded load smoke never imports, solves, graphs, writes history, or claims a real load', () {
      const flagOffRequest = GaussPrivateArtifactLoadRequestEnvelope(
        requestId: 'q281-flag-off',
        privateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/model.pdmodel',
        expectedSha256: validSha,
        actualSha256: validSha,
        artifactSizeBytes: 1024,
        androidAbi: 'arm64-v8a',
        timeoutMs: GaussPrivateArtifactLoadRealSmokePolicy.loadTimeoutBudgetMs,
        runtimeFeatureFlagEnabled: false,
        privateStoragePathVerified: true,
      );

      final flagOff = GaussPrivateArtifactLoadRealSmoke.guardedLoadSmoke(flagOffRequest);
      expect(flagOff.status, 'blocked');
      expect(flagOff.errorCode, 'runtimeFeatureFlagOff');
      expect(flagOff.realFileLoadExecuted, isFalse);
      expect(flagOff.runtimeBridgeInvoked, isFalse);
      expect(flagOff.canProceedToRuntimeSmoke, isFalse);
      expect(flagOff.canImportToWorkspace, isFalse);
      expect(flagOff.canEvaluate, isFalse);
      expect(flagOff.canGraph, isFalse);
      expect(flagOff.canWriteSolutionOrHistory, isFalse);

      const validEnvelopeButNoRealLoader = GaussPrivateArtifactLoadRequestEnvelope(
        requestId: 'q281-envelope-only',
        privateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s/model.pdmodel',
        expectedSha256: validSha,
        actualSha256: validSha,
        artifactSizeBytes: 1024,
        androidAbi: 'arm64-v8a',
        timeoutMs: GaussPrivateArtifactLoadRealSmokePolicy.loadTimeoutBudgetMs,
        runtimeFeatureFlagEnabled: true,
        privateStoragePathVerified: true,
      );

      final blockedNoLoader = GaussPrivateArtifactLoadRealSmoke.guardedLoadSmoke(validEnvelopeButNoRealLoader);
      expect(validEnvelopeButNoRealLoader.shaMatches, isTrue);
      expect(validEnvelopeButNoRealLoader.isDummySmokeOnlySafe, isTrue);
      expect(blockedNoLoader.errorCode, 'noRealArtifactLoadExecutedInQ281');
      expect(blockedNoLoader.artifactPathAccepted, isTrue);
      expect(blockedNoLoader.shaMatch, isTrue);
      expect(blockedNoLoader.modelFormatProbePlanned, isTrue);
      expect(blockedNoLoader.realFileLoadExecuted, isFalse);
      expect(blockedNoLoader.runtimeBridgeInvoked, isFalse);
      expect(blockedNoLoader.canProceedToRuntimeSmoke, isFalse);
    });
  });
}
