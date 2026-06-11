import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_artifact_load_real_device_smoke_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_artifact_load_real_device_smoke_gate_policy.dart';

void main() {
  group('V172-Q307 Private Artifact Load Real Device Smoke Gate', () {
    test('defines default-off private artifact load smoke gate without loading an artifact', () {
      final result = GaussPrivateArtifactLoadRealDeviceSmokeGate.evaluate(
        GaussPrivateArtifactLoadRealDeviceSmokeGateInput.q307Default(),
      );

      expect(result.phase, GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.phase);
      expect(result.sourcePhase, GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.loadSmokeFeatureFlag, 'gauss.ppFormulaNetS.privateArtifactLoadRealDeviceSmoke.defaultOff');
      expect(result.loadSmokeMode, 'private-artifact-load-real-device-smoke-gate-default-off-no-file-load');
      expect(result.decision, GaussPrivateArtifactLoadRealDeviceSmokeGateDecision.privateArtifactLoadSmokeGateDefinedDefaultOff);
      expect(result.contractStaticReady, isTrue);
      expect(result.rejectionReasons, contains('q306-verified-private-artifact-evidence-not-complete-for-q307'));
      expect(result.requiredBeforePrivateArtifactLoadSmoke, contains('q306-verified-private-artifact-path-recorded'));
      expect(result.requiredBeforePrivateArtifactLoadSmoke, contains('real-android-device-load-log-required'));
      expect(result.loadSmokeEnvelopeFields, contains('verifiedPrivatePath'));
      expect(result.loadSmokeEnvelopeFields, contains('modelFormatProbeState'));
      expect(result.loadSmokeStates, contains('formatProbeSucceeded'));
      expect(result.loadSmokeStates, contains('loadSmokeSucceeded'));
      expect(result.errorCodes, contains('verifiedArtifactMissing'));
      expect(result.errorCodes, contains('nativeRuntimeNotBound'));
      expect(result.protectedSurfaceMarkers, contains('mathlive-production-route-preserved'));
      expect(result.forbiddenActions, contains('openModelFileInsideQ307Package'));
      expect(result.forbiddenActions, contains('probeModelFormatInsideQ307Package'));
      expect(result.privateArtifactLoadSmokeGateDefined, isTrue);
      expect(result.privateArtifactLoadSmokeDefaultOff, isTrue);
      expect(result.q306ShaAtomicMoveGatePresent, isTrue);
      expect(result.q306VerifiedPrivateArtifactPathRecorded, isFalse);
      expect(result.q306ExpectedActualSha256Match, isFalse);
      expect(result.q306AtomicMoveSucceeded, isFalse);
      expect(result.privateArtifactPathReviewed, isTrue);
      expect(result.artifactByteLengthReviewed, isTrue);
      expect(result.modelFormatProbePlanReviewed, isTrue);
      expect(result.realAndroidDeviceLoadLogRequired, isTrue);
      expect(result.pubspecChanged, isFalse);
      expect(result.androidManifestChanged, isFalse);
      expect(result.mainActivityChanged, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realPrivateArtifactLoaded, isFalse);
      expect(result.modelFormatProbeExecuted, isFalse);
      expect(result.realRuntimeStartupExecuted, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.reviewBeforeImportRequired, isTrue);
      expect(result.explicitUserApprovalRequired, isTrue);
      expect(result.directWorkspaceImportBlocked, isTrue);
      expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
      expect(result.privateArtifactLoadPassClaimed, isFalse);
      expect(result.modelFormatProbePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('blocks complete private artifact evidence acceptance inside the static Q307 package', () {
      final result = GaussPrivateArtifactLoadRealDeviceSmokeGate.evaluate(
        const GaussPrivateArtifactLoadRealDeviceSmokeGateInput(
          q306ShaAtomicMoveGatePresent: true,
          q306VerifiedPrivateArtifactPathRecorded: true,
          q306ExpectedActualSha256Match: true,
          q306AtomicMoveSucceeded: true,
          privateArtifactPathReviewed: true,
          artifactByteLengthReviewed: true,
          modelFormatProbePlanReviewed: true,
          realAndroidDeviceLoadLogRequired: true,
          loadTimeoutPolicyReviewed: true,
          memoryPressurePolicyReviewed: true,
          rollbackPlanPresent: true,
          defaultOffFeatureFlagPresent: true,
          keyboardLayoutProtected: true,
          moreTemplateTrayProtected: true,
          longPressListsProtected: true,
          mathLiveProductionRouteProtected: true,
          mathLiveBridgeProtected: true,
          graphSolutionHistoryProtected: true,
          appShellWorkspaceProtected: true,
          androidManifestMainActivityProtected: true,
          cameraShellRuntimeProtected: true,
          splashIconProtected: true,
          pubspecChanged: false,
          androidManifestChanged: false,
          mainActivityChanged: false,
          productionDownloadEnabled: false,
          modelBinaryBundledInBaseApp: false,
          realModelDownloadExecuted: false,
          realShaVerificationExecuted: false,
          realAtomicMoveExecuted: false,
          artifactAcceptedForRuntime: false,
          realPrivateArtifactLoaded: false,
          modelFormatProbeExecuted: false,
          realRuntimeStartupExecuted: false,
          realDummyInputRuntimeCallExecuted: false,
          realImageToLatexInferenceExecuted: false,
          realEditableMathLiveReviewOpened: false,
          realWorkspaceImportExecuted: false,
          privateArtifactLoadPassClaimed: false,
          modelFormatProbePassClaimed: false,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          cameraOcrRuntimePassClaimed: false,
          storeReadyPassClaimed: false,
          releasePassClaimed: false,
          trialLabel: 'premature-q306-complete-artifact-evidence',
        ),
      );

      expect(result.contractStaticReady, isFalse);
      expect(result.decision, GaussPrivateArtifactLoadRealDeviceSmokeGateDecision.blockedMissingVerifiedPrivateArtifactEvidence);
      expect(result.rejectionReasons, contains('q307-must-not-accept-complete-private-artifact-load-evidence-inside-static-package'));
    });

    test('blocks artifact loading/runtime mutations and fake PASS claims', () {
      final result = GaussPrivateArtifactLoadRealDeviceSmokeGate.evaluate(
        const GaussPrivateArtifactLoadRealDeviceSmokeGateInput(
          q306ShaAtomicMoveGatePresent: true,
          q306VerifiedPrivateArtifactPathRecorded: false,
          q306ExpectedActualSha256Match: false,
          q306AtomicMoveSucceeded: false,
          privateArtifactPathReviewed: true,
          artifactByteLengthReviewed: true,
          modelFormatProbePlanReviewed: true,
          realAndroidDeviceLoadLogRequired: true,
          loadTimeoutPolicyReviewed: true,
          memoryPressurePolicyReviewed: true,
          rollbackPlanPresent: true,
          defaultOffFeatureFlagPresent: true,
          keyboardLayoutProtected: true,
          moreTemplateTrayProtected: true,
          longPressListsProtected: true,
          mathLiveProductionRouteProtected: true,
          mathLiveBridgeProtected: true,
          graphSolutionHistoryProtected: true,
          appShellWorkspaceProtected: true,
          androidManifestMainActivityProtected: true,
          cameraShellRuntimeProtected: true,
          splashIconProtected: true,
          pubspecChanged: true,
          androidManifestChanged: true,
          mainActivityChanged: true,
          productionDownloadEnabled: true,
          modelBinaryBundledInBaseApp: true,
          realModelDownloadExecuted: true,
          realShaVerificationExecuted: true,
          realAtomicMoveExecuted: true,
          artifactAcceptedForRuntime: true,
          realPrivateArtifactLoaded: true,
          modelFormatProbeExecuted: true,
          realRuntimeStartupExecuted: true,
          realDummyInputRuntimeCallExecuted: true,
          realImageToLatexInferenceExecuted: true,
          realEditableMathLiveReviewOpened: true,
          realWorkspaceImportExecuted: true,
          privateArtifactLoadPassClaimed: true,
          modelFormatProbePassClaimed: true,
          runtimeIntegrationPassClaimed: true,
          ocrPassClaimed: true,
          cameraOcrRuntimePassClaimed: true,
          storeReadyPassClaimed: true,
          releasePassClaimed: true,
          trialLabel: 'forbidden-artifact-load-and-fake-pass',
        ),
      );

      expect(result.contractStaticReady, isFalse);
      expect(result.rejectionReasons, contains('private-artifact-load-or-runtime-mutation-forbidden-in-q307'));
      expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
    });
  });
}
