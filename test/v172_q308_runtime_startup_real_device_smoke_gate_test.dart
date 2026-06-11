import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_startup_real_device_smoke_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_startup_real_device_smoke_gate_policy.dart';

void main() {
  test('q308-runtime-startup-smoke-gate-is-static-default-off', () {
    final result = GaussRuntimeStartupRealDeviceSmokeGate.evaluate(
      GaussRuntimeStartupRealDeviceSmokeGateInput.q308Default(),
    );

    expect(result.phase, GaussRuntimeStartupRealDeviceSmokeGatePolicy.phase);
    expect(result.sourcePhase, GaussRuntimeStartupRealDeviceSmokeGatePolicy.sourcePhase);
    expect(result.contractStaticReady, isTrue);
    expect(result.runtimeStartupSmokeGateDefined, isTrue);
    expect(result.runtimeStartupSmokeDefaultOff, isTrue);
    expect(result.realRuntimeStartupExecuted, isFalse);
    expect(result.methodChannelRuntimeBound, isFalse);
    expect(result.nativeRuntimeDependencyAdded, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
  });

  test('q308-must-not-accept-complete-runtime-startup-evidence-inside-static-package', () {
    final result = GaussRuntimeStartupRealDeviceSmokeGate.evaluate(
      const GaussRuntimeStartupRealDeviceSmokeGateInput(
        q307PrivateArtifactLoadSmokeGatePresent: true,
        q306VerifiedPrivateArtifactPathRecorded: true,
        q306ExpectedActualSha256Match: true,
        q306AtomicMoveSucceeded: true,
        q307RealPrivateArtifactLoadEvidencePresent: true,
        q307ModelFormatProbeEvidencePresent: true,
        nativeRuntimePackageSelected: true,
        androidAbiMatrixReviewed: true,
        runtimeStartupTimeoutPolicyPresent: true,
        runtimeMemoryPressurePolicyPresent: true,
        realAndroidDeviceStartupLogRequired: true,
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
        nativeRuntimeDependencyAdded: false,
        methodChannelRuntimeBound: false,
        jniNativeHandlerImplemented: false,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realPrivateArtifactLoaded: false,
        modelFormatProbeExecuted: false,
        realRuntimeStartupExecuted: false,
        realRuntimeWarmupExecuted: false,
        realDummyInputRuntimeCallExecuted: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        runtimeStartupPassClaimed: false,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'complete-evidence-must-remain-external',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(
      result.rejectionReasons,
      contains('q308-must-not-accept-complete-runtime-startup-evidence-inside-static-package'),
    );
  });

  test('q308-blocks-runtime-mutation-and-fake-pass-claims', () {
    final result = GaussRuntimeStartupRealDeviceSmokeGate.evaluate(
      const GaussRuntimeStartupRealDeviceSmokeGateInput(
        q307PrivateArtifactLoadSmokeGatePresent: true,
        q306VerifiedPrivateArtifactPathRecorded: false,
        q306ExpectedActualSha256Match: false,
        q306AtomicMoveSucceeded: false,
        q307RealPrivateArtifactLoadEvidencePresent: false,
        q307ModelFormatProbeEvidencePresent: false,
        nativeRuntimePackageSelected: false,
        androidAbiMatrixReviewed: true,
        runtimeStartupTimeoutPolicyPresent: true,
        runtimeMemoryPressurePolicyPresent: true,
        realAndroidDeviceStartupLogRequired: true,
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
        androidManifestChanged: false,
        mainActivityChanged: false,
        nativeRuntimeDependencyAdded: true,
        methodChannelRuntimeBound: true,
        jniNativeHandlerImplemented: true,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realPrivateArtifactLoaded: false,
        modelFormatProbeExecuted: false,
        realRuntimeStartupExecuted: true,
        realRuntimeWarmupExecuted: false,
        realDummyInputRuntimeCallExecuted: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        runtimeStartupPassClaimed: true,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'forbidden-runtime-startup-mutation',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(result.rejectionReasons, contains('runtime-startup-or-runtime-mutation-forbidden-in-q308'));
    expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
  });
}
