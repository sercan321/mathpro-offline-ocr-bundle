import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_private_artifact_load_prototype.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_private_artifact_load_prototype_policy.dart';

void main() {
  group('V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE', () {
    const acceptedSha = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
    const approvedInput = GaussPpFormulaNetSPrivateArtifactLoadPrototypeInput(
      q270NativeRuntimeBridgeSkeletonPresent: true,
      q270StillNoNativeRuntimeNoInference: true,
      privateArtifactPathDocumented: true,
      privateArtifactPathInsideAppStorage: true,
      artifactSha256: acceptedSha,
      artifactShaPreviouslyAcceptedByCourt: true,
      artifactNotBundledInBaseApk: true,
      artifactNotLoadedFromAssets: true,
      modelFormatProbeDocumented: true,
      runtimePathCandidateDocumented: true,
      bridgeProtocolCandidateDocumented: true,
      artifactAccessEnvelopeDocumented: true,
      loadDryRunContractDocumented: true,
      timeoutCancellationPolicyDocumented: true,
      memoryPressurePolicyDocumented: true,
      latencyBudgetMs: 1800,
      peakMemoryBudgetMb: 192,
      failureRetryPlanDocumented: true,
      fallbackPlanDocumented: true,
      featureFlagDefaultOffDocumented: true,
      noDefaultRuntimeEnablement: true,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directSolveBlocked: true,
      directGraphSolutionHistoryBlocked: true,
      noPaddleRuntimeAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      artifactLoadPrototypePassClaimed: false,
      ocrPassClaimed: false,
      artifactLoadLabel: 'Q271 ready for future private artifact load smoke only',
    );

    test('gates private artifact load without model load or inference in Q271', () {
      final result = GaussPpFormulaNetSPrivateArtifactLoadPrototype.evaluate(approvedInput);

      expect(result.decision, GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.readyForFuturePrivateArtifactLoadSmokeOnly);
      expect(result.privateArtifactLoadPrototypeStaticReady, isTrue);
      expect(result.readyForFuturePrivateArtifactLoadSmokeOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.artifactLoadMode, 'private-artifact-load-prototype-gate-only-no-runtime-no-inference');
      expect(result.requiredArtifactLoadGates, contains('privateArtifactPathInsideAppStorage'));
      expect(result.requiredArtifactLoadGates, contains('artifactSha256Is64Hex'));
      expect(result.requiredArtifactLoadGates, contains('modelFormatProbeDocumented'));
      expect(result.requiredArtifactLoadGates, contains('noProductionInferenceInQ271'));
      expect(result.artifactAccessEnvelopeFields, contains('privateArtifactPath'));
      expect(result.artifactAccessEnvelopeFields, contains('artifactSha256'));
      expect(result.modelFormatProbeFields, contains('noInferenceExecuted'));
      expect(result.artifactLoadFailureCodes, contains('artifactShaMalformed'));
      expect(result.artifactLoadStrategies, contains('privateStorageOnlyArtifactAccess'));
      expect(result.forbiddenActions, contains('runPpFormulaNetSInferenceInQ271'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeImplementationAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeFeatureFlagDefaultOff, isTrue);
      expect(result.privateStorageOnly, isTrue);
      expect(result.artifactLoadPrototypePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canLoadPrivateArtifactInQ271, isFalse);
      expect(result.canProbeModelFormatInQ271, isFalse);
      expect(result.canRunInferenceInQ271, isFalse);
      expect(result.canClaimArtifactLoadPassInQ271, isFalse);
      expect(result.canClaimOcrPassInQ271, isFalse);
      expect(result.canEnableRuntimeByDefaultInQ271, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('rejects malformed or unaccepted artifact SHA before any private load smoke', () {
      final malformed = GaussPpFormulaNetSPrivateArtifactLoadPrototype.evaluate(
        const GaussPpFormulaNetSPrivateArtifactLoadPrototypeInput(
          q270NativeRuntimeBridgeSkeletonPresent: true,
          q270StillNoNativeRuntimeNoInference: true,
          privateArtifactPathDocumented: true,
          privateArtifactPathInsideAppStorage: true,
          artifactSha256: 'bad-sha',
          artifactShaPreviouslyAcceptedByCourt: true,
          artifactNotBundledInBaseApk: true,
          artifactNotLoadedFromAssets: true,
          modelFormatProbeDocumented: true,
          runtimePathCandidateDocumented: true,
          bridgeProtocolCandidateDocumented: true,
          artifactAccessEnvelopeDocumented: true,
          loadDryRunContractDocumented: true,
          timeoutCancellationPolicyDocumented: true,
          memoryPressurePolicyDocumented: true,
          latencyBudgetMs: 1800,
          peakMemoryBudgetMb: 192,
          failureRetryPlanDocumented: true,
          fallbackPlanDocumented: true,
          featureFlagDefaultOffDocumented: true,
          noDefaultRuntimeEnablement: true,
          editableMathLiveReviewRequired: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          directSolveBlocked: true,
          directGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noRealNetworkDownloadWorkerImplemented: true,
          productionDownloadEnabled: false,
          noProductionInferenceAllowed: true,
          artifactLoadPrototypePassClaimed: false,
          ocrPassClaimed: false,
          artifactLoadLabel: 'malformed',
        ),
      );
      expect(malformed.decision, GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMalformedSha256);
      expect(malformed.canLoadPrivateArtifactInQ271, isFalse);

      final notAccepted = GaussPpFormulaNetSPrivateArtifactLoadPrototype.evaluate(
        const GaussPpFormulaNetSPrivateArtifactLoadPrototypeInput(
          q270NativeRuntimeBridgeSkeletonPresent: true,
          q270StillNoNativeRuntimeNoInference: true,
          privateArtifactPathDocumented: true,
          privateArtifactPathInsideAppStorage: true,
          artifactSha256: acceptedSha,
          artifactShaPreviouslyAcceptedByCourt: false,
          artifactNotBundledInBaseApk: true,
          artifactNotLoadedFromAssets: true,
          modelFormatProbeDocumented: true,
          runtimePathCandidateDocumented: true,
          bridgeProtocolCandidateDocumented: true,
          artifactAccessEnvelopeDocumented: true,
          loadDryRunContractDocumented: true,
          timeoutCancellationPolicyDocumented: true,
          memoryPressurePolicyDocumented: true,
          latencyBudgetMs: 1800,
          peakMemoryBudgetMb: 192,
          failureRetryPlanDocumented: true,
          fallbackPlanDocumented: true,
          featureFlagDefaultOffDocumented: true,
          noDefaultRuntimeEnablement: true,
          editableMathLiveReviewRequired: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          directSolveBlocked: true,
          directGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noRealNetworkDownloadWorkerImplemented: true,
          productionDownloadEnabled: false,
          noProductionInferenceAllowed: true,
          artifactLoadPrototypePassClaimed: false,
          ocrPassClaimed: false,
          artifactLoadLabel: 'not accepted',
        ),
      );
      expect(notAccepted.decision, GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingVerifiedSha256);
      expect(notAccepted.canProbeModelFormatInQ271, isFalse);
    });

    test('keeps runtime dependencies absent from pubspec during Q271', () {
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'paddleocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'tesseract',
        'pix2text',
        'flutter_downloader',
        'background_downloader',
        'dio',
      ]) {
        expect(pubspec, isNot(contains(forbidden)));
      }
    });
  });
}
