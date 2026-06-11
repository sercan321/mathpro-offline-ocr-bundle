import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_full_camera_ocr_real_device_regression_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_full_camera_ocr_real_device_regression_gate_policy.dart';

void main() {
  test('q313-full-camera-ocr-regression-gate-is-static-default-off', () {
    final result = GaussFullCameraOcrRealDeviceRegressionGate.evaluate(
      GaussFullCameraOcrRealDeviceRegressionGateInput.q313Default(),
    );

    expect(result.phase, GaussFullCameraOcrRealDeviceRegressionGatePolicy.phase);
    expect(result.sourcePhase, GaussFullCameraOcrRealDeviceRegressionGatePolicy.sourcePhase);
    expect(result.contractStaticReady, isTrue);
    expect(result.fullRegressionGateDefined, isTrue);
    expect(result.fullRegressionDefaultOff, isTrue);
    expect(result.q302ArtifactUrlShaLockGatePresent, isTrue);
    expect(result.q303RuntimeDependencyTrialGatePresent, isTrue);
    expect(result.q304AndroidNativeBridgeGatePresent, isTrue);
    expect(result.q305PrivateModelDownloadWorkerGatePresent, isTrue);
    expect(result.q306ShaAtomicMoveGatePresent, isTrue);
    expect(result.q307PrivateArtifactLoadGatePresent, isTrue);
    expect(result.q308RuntimeStartupGatePresent, isTrue);
    expect(result.q309DummyInputRuntimeCallGatePresent, isTrue);
    expect(result.q310ImageToLatexInferenceGatePresent, isTrue);
    expect(result.q311EditableMathLiveReviewGatePresent, isTrue);
    expect(result.q312ApprovedWorkspaceImportGatePresent, isTrue);
    expect(result.editableMathLiveReviewRequired, isTrue);
    expect(result.explicitUserApprovalRequired, isTrue);
    expect(result.directWorkspaceImportBlockedBeforeApproval, isTrue);
    expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.realEditableMathLiveReviewOpened, isFalse);
    expect(result.realWorkspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.cameraOcrRuntimePassClaimed, isFalse);
  });

  test('q313-blocks-incomplete-q302-through-q312-chain', () {
    final result = GaussFullCameraOcrRealDeviceRegressionGate.evaluate(
      const GaussFullCameraOcrRealDeviceRegressionGateInput(
        q302ArtifactUrlShaLockGatePresent: true,
        q303RuntimeDependencyTrialGatePresent: true,
        q304AndroidNativeBridgeGatePresent: true,
        q305PrivateModelDownloadWorkerGatePresent: true,
        q306ShaAtomicMoveGatePresent: true,
        q307PrivateArtifactLoadGatePresent: true,
        q308RuntimeStartupGatePresent: true,
        q309DummyInputRuntimeCallGatePresent: true,
        q310ImageToLatexInferenceGatePresent: true,
        q311EditableMathLiveReviewGatePresent: true,
        q312ApprovedWorkspaceImportGatePresent: false,
        defaultOffFeatureFlagPresent: true,
        editableMathLiveReviewRequired: true,
        explicitUserApprovalRequired: true,
        directWorkspaceImportBlockedBeforeApproval: true,
        directEvaluateBlocked: true,
        directSolveGraphSolutionHistoryBlocked: true,
        realAndroidFullRegressionLogRequired: true,
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
        nativeRuntimeDependencyAdded: false,
        methodChannelRuntimeBoundInsidePackage: false,
        jniNativeHandlerImplementedInsidePackage: false,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realModelSha256Verified: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: false,
        realDummyInputRuntimeCallExecuted: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        autoEvaluateEnabled: false,
        autoSolveGraphSolutionHistoryEnabled: false,
        solutionHistoryWriteEnabled: false,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        workspaceImportPassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'missing-q312-chain-gate',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(result.rejectionReasons, contains('q302-through-q312-regression-chain-incomplete'));
  });

  test('q313-blocks-runtime-mutation-and-fake-pass-claims', () {
    final result = GaussFullCameraOcrRealDeviceRegressionGate.evaluate(
      const GaussFullCameraOcrRealDeviceRegressionGateInput(
        q302ArtifactUrlShaLockGatePresent: true,
        q303RuntimeDependencyTrialGatePresent: true,
        q304AndroidNativeBridgeGatePresent: true,
        q305PrivateModelDownloadWorkerGatePresent: true,
        q306ShaAtomicMoveGatePresent: true,
        q307PrivateArtifactLoadGatePresent: true,
        q308RuntimeStartupGatePresent: true,
        q309DummyInputRuntimeCallGatePresent: true,
        q310ImageToLatexInferenceGatePresent: true,
        q311EditableMathLiveReviewGatePresent: true,
        q312ApprovedWorkspaceImportGatePresent: true,
        defaultOffFeatureFlagPresent: true,
        editableMathLiveReviewRequired: true,
        explicitUserApprovalRequired: true,
        directWorkspaceImportBlockedBeforeApproval: true,
        directEvaluateBlocked: true,
        directSolveGraphSolutionHistoryBlocked: true,
        realAndroidFullRegressionLogRequired: true,
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
        nativeRuntimeDependencyAdded: true,
        methodChannelRuntimeBoundInsidePackage: true,
        jniNativeHandlerImplementedInsidePackage: true,
        productionDownloadEnabled: true,
        modelBinaryBundledInBaseApp: true,
        realModelSha256Verified: true,
        realPrivateArtifactLoaded: true,
        realRuntimeStartupExecuted: true,
        realDummyInputRuntimeCallExecuted: true,
        realImageToLatexInferenceExecuted: true,
        realEditableMathLiveReviewOpened: true,
        realWorkspaceImportExecuted: true,
        autoEvaluateEnabled: true,
        autoSolveGraphSolutionHistoryEnabled: true,
        solutionHistoryWriteEnabled: true,
        runtimeIntegrationPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: true,
        workspaceImportPassClaimed: true,
        storeReadyPassClaimed: true,
        releasePassClaimed: true,
        trialLabel: 'forbidden-runtime-mutation-and-fake-pass',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(result.rejectionReasons, contains('runtime-or-workspace-mutation-forbidden-in-q313-static-package'));
    expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
  });
}
