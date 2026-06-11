import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_pp_formulanet_s_artifact_url_sha_lock.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_pp_formulanet_s_artifact_url_sha_lock_policy.dart';

void main() {
  group('V172-Q302 Real PP-FormulaNet-S Artifact URL + SHA Lock', () {
    test('locks official source locators while keeping SHA pending and runtime blocked', () {
      final result = GaussRealPpFormulaNetSArtifactUrlShaLock.evaluate(
        GaussRealPpFormulaNetSArtifactUrlShaLockInput.q302Default(),
      );

      expect(result.phase, GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.phase);
      expect(result.sourcePhase, GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.artifactLockFeatureFlag, 'gauss.ppFormulaNetS.artifactUrlShaLock.defaultOff');
      expect(result.contractStaticReady, isTrue);
      expect(result.decision, GaussRealPpFormulaNetSArtifactUrlShaLockDecision.artifactSourceLockedShaPending);
      expect(result.rejectionReasons, isEmpty);
      expect(result.huggingFaceRepositoryLocator, 'hf://PaddlePaddle/PP-FormulaNet-S');
      expect(result.officialBosInferenceArtifactLocator, contains('PP-FormulaNet-S_infer.tar'));
      expect(result.recordedLicense, 'apache-2.0');
      expect(result.documentedModelStorageMb, 224);
      expect(result.expectedSha256, 'PENDING_CONTROLLED_DOWNLOAD_HASH_VERIFICATION');
      expect(result.actualSha256, 'NOT_DOWNLOADED_IN_Q302');
      expect(result.shaLockState, 'URL_LOCKED_SHA_PENDING_NO_ARTIFACT_ACCEPTED');
      expect(result.requiredFutureEvidence, contains('actual-sha256-of-downloaded-artifact'));
      expect(result.requiredFutureEvidence, contains('checksum-pass-before-atomic-move'));
      expect(result.protectedSurfaceMarkers, contains('keyboard-layout-preserved'));
      expect(result.protectedSurfaceMarkers, contains('mathlive-production-route-preserved'));
      expect(result.forbiddenActions, contains('inventSha256InQ302'));
      expect(result.forbiddenActions, contains('downloadModelArtifactInQ302'));
      expect(result.controlledDownloadPerformed, isFalse);
      expect(result.expectedSha256Verified, isFalse);
      expect(result.actualSha256Computed, isFalse);
      expect(result.artifactAcceptedForRuntime, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('blocks invented SHA or accepting an artifact without controlled download evidence', () {
      const input = GaussRealPpFormulaNetSArtifactUrlShaLockInput(
        q301ProductDevelopmentTrackActive: true,
        q301StoreTrackParked: true,
        huggingFaceRepositoryLocatorRecorded: true,
        officialBosInferenceLocatorRecorded: true,
        licenseRecorded: true,
        modelSizeRecorded: true,
        expectedSha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        actualSha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        controlledDownloadPerformed: false,
        expectedSha256Verified: true,
        actualSha256Computed: true,
        artifactAcceptedForRuntime: true,
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
        paddleRuntimeAdded: false,
        paddleOcrDependencyAdded: false,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: false,
        nativeRuntimeHandlerImplemented: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        lockLabel: 'bad-sha-claim',
      );

      final result = GaussRealPpFormulaNetSArtifactUrlShaLock.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.decision, GaussRealPpFormulaNetSArtifactUrlShaLockDecision.blockedShaInventedOrAcceptedWithoutDownload);
      expect(result.rejectionReasons, contains('sha-must-remain-pending-until-controlled-download'));
      expect(result.rejectionReasons, contains('artifact-cannot-be-downloaded-hashed-or-accepted-in-q302'));
    });

    test('blocks runtime mutation and fake OCR/runtime PASS claims', () {
      const input = GaussRealPpFormulaNetSArtifactUrlShaLockInput(
        q301ProductDevelopmentTrackActive: true,
        q301StoreTrackParked: true,
        huggingFaceRepositoryLocatorRecorded: true,
        officialBosInferenceLocatorRecorded: true,
        licenseRecorded: true,
        modelSizeRecorded: true,
        expectedSha256: 'PENDING_CONTROLLED_DOWNLOAD_HASH_VERIFICATION',
        actualSha256: 'NOT_DOWNLOADED_IN_Q302',
        controlledDownloadPerformed: false,
        expectedSha256Verified: false,
        actualSha256Computed: false,
        artifactAcceptedForRuntime: false,
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
        paddleRuntimeAdded: true,
        paddleOcrDependencyAdded: true,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: true,
        nativeRuntimeHandlerImplemented: true,
        modelBinaryBundledInBaseApp: true,
        productionDownloadEnabled: true,
        realPrivateArtifactLoaded: true,
        realRuntimeStartupExecuted: true,
        realImageToLatexInferenceExecuted: true,
        realEditableMathLiveReviewOpened: true,
        realWorkspaceImportExecuted: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: true,
        storeReadyPassClaimed: false,
        releasePassClaimed: true,
        lockLabel: 'runtime-mutation-forbidden',
      );

      final result = GaussRealPpFormulaNetSArtifactUrlShaLock.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.rejectionReasons, contains('runtime-download-model-or-workspace-mutation-forbidden-in-q302'));
      expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
    });
  });
}
