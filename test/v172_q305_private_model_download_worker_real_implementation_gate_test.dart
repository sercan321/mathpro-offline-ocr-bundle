import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_model_download_worker_real_implementation_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_private_model_download_worker_real_implementation_gate_policy.dart';

void main() {
  group('V172-Q305 Private Model Download Worker Real Implementation Gate', () {
    test('defines private model download worker gate while keeping production download disabled', () {
      final result = GaussPrivateModelDownloadWorkerRealImplementationGate.evaluate(
        GaussPrivateModelDownloadWorkerRealImplementationGateInput.q305Default(),
      );

      expect(result.phase, GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.phase);
      expect(result.sourcePhase, GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.downloadWorkerFeatureFlag, 'gauss.ppFormulaNetS.privateModelDownloadWorker.defaultOff');
      expect(result.workerImplementationMode, 'implementation-gate-default-off-no-production-download');
      expect(result.decision, GaussPrivateModelDownloadWorkerRealImplementationGateDecision.privateModelDownloadWorkerGateDefinedDefaultOff);
      expect(result.contractStaticReady, isTrue);
      expect(result.rejectionReasons, contains('q302-download-sha-evidence-not-complete-for-q305'));
      expect(result.requiredBeforeWorkerEnablement, contains('q302-expected-actual-sha256-match'));
      expect(result.requiredBeforeWorkerEnablement, contains('atomic-move-after-checksum-policy-reviewed'));
      expect(result.workerRequestEnvelopeFields, contains('expectedSha256'));
      expect(result.workerRequestEnvelopeFields, contains('temporaryPrivatePath'));
      expect(result.workerProgressEnvelopeFields, contains('actualSha256SoFar'));
      expect(result.workerErrorCodes, contains('checksumMismatch'));
      expect(result.protectedSurfaceMarkers, contains('mathlive-production-route-preserved'));
      expect(result.forbiddenActions, contains('enableProductionDownloadInQ305'));
      expect(result.forbiddenActions, contains('addNetworkDownloaderDependencyInQ305'));
      expect(result.privateModelDownloadWorkerGateDefined, isTrue);
      expect(result.privateModelDownloadWorkerDefaultOff, isTrue);
      expect(result.privateModelDownloadWorkerActuallyImplemented, isFalse);
      expect(result.q302ExpectedSha256Locked, isFalse);
      expect(result.q302ActualSha256Computed, isFalse);
      expect(result.q302ExpectedActualSha256Match, isFalse);
      expect(result.pubspecChanged, isFalse);
      expect(result.androidManifestChanged, isFalse);
      expect(result.mainActivityChanged, isFalse);
      expect(result.networkDownloaderDependencyAdded, isFalse);
      expect(result.backgroundWorkerDependencyAdded, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.realModelDownloadExecuted, isFalse);
      expect(result.actualSha256ComputedInPackage, isFalse);
      expect(result.artifactAcceptedForRuntime, isFalse);
      expect(result.realPrivateArtifactLoaded, isFalse);
      expect(result.realRuntimeStartupExecuted, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.reviewBeforeImportRequired, isTrue);
      expect(result.explicitUserApprovalRequired, isTrue);
      expect(result.directWorkspaceImportBlocked, isTrue);
      expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
      expect(result.downloadWorkerImplementationPassClaimed, isFalse);
      expect(result.modelDownloadPassClaimed, isFalse);
      expect(result.shaVerificationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('blocks complete SHA evidence acceptance inside the static Q305 package', () {
      const input = GaussPrivateModelDownloadWorkerRealImplementationGateInput(
        q304NativeBridgeGatePresent: true,
        q302ExpectedSha256Locked: true,
        q302ActualSha256Computed: true,
        q302ExpectedActualSha256Match: true,
        officialArtifactSourceReviewed: true,
        licenseCompatibilityReviewed: true,
        modelSizeBudgetReviewed: true,
        privateAppStoragePathReviewed: true,
        userConsentCopyReviewed: true,
        networkPolicyReviewed: true,
        atomicMovePolicyReviewed: true,
        partialDownloadCleanupPolicyReviewed: true,
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
        networkDownloaderDependencyAdded: false,
        backgroundWorkerDependencyAdded: false,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realModelDownloadExecuted: false,
        actualSha256ComputedInPackage: false,
        artifactAcceptedForRuntime: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: false,
        realDummyInputRuntimeCallExecuted: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        downloadWorkerImplementationPassClaimed: false,
        modelDownloadPassClaimed: false,
        shaVerificationPassClaimed: false,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'premature-sha-evidence-acceptance',
      );

      final result = GaussPrivateModelDownloadWorkerRealImplementationGate.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.decision, GaussPrivateModelDownloadWorkerRealImplementationGateDecision.blockedMissingQ302ShaOrDownloadEvidence);
      expect(result.rejectionReasons, contains('q305-must-not-accept-complete-download-evidence-inside-static-package'));
    });

    test('blocks downloader dependency, production download, runtime mutation, and fake PASS claims', () {
      const input = GaussPrivateModelDownloadWorkerRealImplementationGateInput(
        q304NativeBridgeGatePresent: true,
        q302ExpectedSha256Locked: false,
        q302ActualSha256Computed: false,
        q302ExpectedActualSha256Match: false,
        officialArtifactSourceReviewed: true,
        licenseCompatibilityReviewed: true,
        modelSizeBudgetReviewed: true,
        privateAppStoragePathReviewed: true,
        userConsentCopyReviewed: true,
        networkPolicyReviewed: true,
        atomicMovePolicyReviewed: true,
        partialDownloadCleanupPolicyReviewed: true,
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
        networkDownloaderDependencyAdded: true,
        backgroundWorkerDependencyAdded: true,
        productionDownloadEnabled: true,
        modelBinaryBundledInBaseApp: true,
        realModelDownloadExecuted: true,
        actualSha256ComputedInPackage: true,
        artifactAcceptedForRuntime: true,
        realPrivateArtifactLoaded: true,
        realRuntimeStartupExecuted: true,
        realDummyInputRuntimeCallExecuted: true,
        realImageToLatexInferenceExecuted: true,
        realEditableMathLiveReviewOpened: true,
        realWorkspaceImportExecuted: true,
        downloadWorkerImplementationPassClaimed: true,
        modelDownloadPassClaimed: true,
        shaVerificationPassClaimed: true,
        runtimeIntegrationPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: true,
        storeReadyPassClaimed: false,
        releasePassClaimed: true,
        trialLabel: 'forbidden-download-worker-mutation',
      );

      final result = GaussPrivateModelDownloadWorkerRealImplementationGate.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.rejectionReasons, contains('private-model-download-worker-or-runtime-mutation-forbidden-in-q305'));
      expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
    });
  });
}
