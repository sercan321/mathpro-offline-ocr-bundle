import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_runtime_bridge_implementation.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_native_runtime_bridge_implementation_policy.dart';

void main() {
  group('V172-Q280 native/runtime bridge implementation behind flag', () {
    const safeInput = GaussNativeRuntimeBridgeImplementationInput(
      q279DependencyTrialPresent: true,
      q278EvidenceLockPresent: true,
      defaultOffBridgeFeatureFlagRequired: true,
      bridgeFeatureFlagEnabledByDefault: false,
      runtimeInvocationBlockedWhenFlagOff: true,
      methodChannelEnvelopeDeclared: true,
      requestEnvelopeDocumented: true,
      responseEnvelopeDocumented: true,
      errorTaxonomyDocumented: true,
      timeoutCancellationPolicyDocumented: true,
      memoryPressurePolicyDocumented: true,
      reviewOnlyModeRequired: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      directSolveGraphSolutionHistoryBlocked: true,
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
      bridgeImplementationPassClaimed: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      evidenceLabel: 'q280-static-bridge-envelope',
    );

    test('keeps the bridge default-off and advances only to Q281 gate readiness', () {
      final result = GaussNativeRuntimeBridgeImplementation.evaluate(safeInput);

      expect(result.phase, GaussNativeRuntimeBridgeImplementationPolicy.phase);
      expect(result.sourcePhase, GaussNativeRuntimeBridgeImplementationPolicy.sourcePhase);
      expect(result.bridgeImplementationStaticReady, isTrue);
      expect(result.readyForQ281PrivateArtifactLoadSmokeGateOnly, isTrue);
      expect(result.canEnableBridgeFlagByDefaultInQ280, isFalse);
      expect(result.canInvokeNativeRuntimeInQ280, isFalse);
      expect(result.canRunImageToLatexInferenceInQ280, isFalse);
      expect(result.canImportCameraOutputWithoutReview, isFalse);
      expect(result.canClaimBridgeImplementationPassInQ280, isFalse);
      expect(result.canClaimOcrPassInQ280, isFalse);
      expect(result.dartBridgeFacadeAdded, isTrue);
      expect(result.nativeHandlerImplementationAdded, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.requiredBridgeImplementationGates, contains('defaultOffBridgeFeatureFlagRequired'));
      expect(result.requiredBridgeImplementationGates, contains('editableMathLiveReviewRequired'));
      expect(result.forbiddenActions, contains('runImageToLatexInferenceInQ280'));
    });

    test('blocks if the bridge flag is enabled by default', () {
      final result = GaussNativeRuntimeBridgeImplementation.evaluate(
        const GaussNativeRuntimeBridgeImplementationInput(
          q279DependencyTrialPresent: true,
          q278EvidenceLockPresent: true,
          defaultOffBridgeFeatureFlagRequired: true,
          bridgeFeatureFlagEnabledByDefault: true,
          runtimeInvocationBlockedWhenFlagOff: true,
          methodChannelEnvelopeDeclared: true,
          requestEnvelopeDocumented: true,
          responseEnvelopeDocumented: true,
          errorTaxonomyDocumented: true,
          timeoutCancellationPolicyDocumented: true,
          memoryPressurePolicyDocumented: true,
          reviewOnlyModeRequired: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
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
          bridgeImplementationPassClaimed: false,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'unsafe-default-on',
        ),
      );

      expect(result.decision, GaussNativeRuntimeBridgeImplementationDecision.blockedBridgeFlagEnabledByDefault);
      expect(result.bridgeImplementationStaticReady, isFalse);
      expect(result.canInvokeNativeRuntimeInQ280, isFalse);
    });

    test('guarded request does not invoke runtime while the bridge flag is off', () {
      const request = GaussNativeRuntimeBridgeRequestEnvelope(
        requestId: 'q280-flag-off',
        croppedImagePath: '/data/user/0/com.mathpro.flutter/cache/crop.png',
        privateArtifactPath: '/data/user/0/com.mathpro.flutter/files/models/pp_formulanet_s',
        artifactSha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        androidAbi: 'arm64-v8a',
        timeoutMs: GaussNativeRuntimeBridgeImplementationPolicy.bridgeTimeoutBudgetMs,
        runtimeFeatureFlagEnabled: false,
      );

      final response = GaussNativeRuntimeBridgeImplementation.guardedRequest(request);

      expect(request.hasValidSha256, isTrue);
      expect(request.isReviewOnlySafe, isTrue);
      expect(response.status, 'blocked');
      expect(response.errorCode, 'runtimeFeatureFlagOff');
      expect(response.reviewRequired, isTrue);
      expect(response.directWorkspaceMutationAttempted, isFalse);
      expect(response.canImportToWorkspace, isFalse);
      expect(response.canEvaluate, isFalse);
      expect(response.canGraph, isFalse);
      expect(response.canWriteSolutionOrHistory, isFalse);
    });
  });
}
