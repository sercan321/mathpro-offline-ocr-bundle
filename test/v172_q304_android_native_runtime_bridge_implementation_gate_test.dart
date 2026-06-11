import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_android_native_runtime_bridge_implementation_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_android_native_runtime_bridge_implementation_gate_policy.dart';

void main() {
  group('V172-Q304 Android Native Runtime Bridge Implementation Gate', () {
    test('defines native bridge implementation gate while keeping MainActivity and runtime untouched', () {
      final result = GaussAndroidNativeRuntimeBridgeImplementationGate.evaluate(
        GaussAndroidNativeRuntimeBridgeImplementationGateInput.q304Default(),
      );

      expect(result.phase, GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.phase);
      expect(result.sourcePhase, GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.methodChannelName, 'com.mathpro.gauss/pp_formulanet_s_runtime');
      expect(result.nativeHandlerName, 'GaussPpFormulaNetSRuntimeHandler');
      expect(result.bridgeFeatureFlag, 'gauss.ppFormulaNetS.androidNativeRuntimeBridge.defaultOff');
      expect(result.bridgeImplementationMode, 'implementation-gate-default-off-no-mainactivity-binding');
      expect(result.decision, GaussAndroidNativeRuntimeBridgeImplementationGateDecision.androidNativeBridgeImplementationGateDefinedDefaultOff);
      expect(result.contractStaticReady, isTrue);
      expect(result.rejectionReasons, isEmpty);
      expect(result.requiredBeforeBridgeImplementation, contains('q302-expected-actual-sha256-match'));
      expect(result.requiredBeforeBridgeImplementation, contains('q303-real-runtime-dependency-version-source'));
      expect(result.requiredBeforeBridgeImplementation, contains('mainactivity-binding-diff-review'));
      expect(result.requestEnvelopeFields, contains('croppedImagePrivatePath'));
      expect(result.requestEnvelopeFields, contains('reviewOnlyMode'));
      expect(result.responseEnvelopeFields, contains('directWorkspaceMutationAttempted'));
      expect(result.bridgeErrorCodes, contains('nativeBridgeNotImplemented'));
      expect(result.protectedSurfaceMarkers, contains('android-manifest-mainactivity-preserved'));
      expect(result.forbiddenActions, contains('modifyMainActivityInQ304'));
      expect(result.forbiddenActions, contains('bindMethodChannelRuntimeWithoutQ302Q303Evidence'));
      expect(result.androidNativeRuntimeBridgeGateDefined, isTrue);
      expect(result.androidNativeRuntimeBridgeDefaultOff, isTrue);
      expect(result.androidNativeRuntimeBridgeActuallyImplemented, isFalse);
      expect(result.methodChannelNameReserved, isTrue);
      expect(result.nativeHandlerNameReserved, isTrue);
      expect(result.mainActivityChanged, isFalse);
      expect(result.androidManifestChanged, isFalse);
      expect(result.pubspecChanged, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.nativeRuntimeHandlerImplemented, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realRuntimeStartupExecuted, isFalse);
      expect(result.realDummyInputRuntimeCallExecuted, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.reviewBeforeImportRequired, isTrue);
      expect(result.explicitUserApprovalRequired, isTrue);
      expect(result.directWorkspaceImportBlocked, isTrue);
      expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
      expect(result.nativeBridgeImplementationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('blocks bridge implementation when Q302/Q303 runtime evidence is prematurely accepted', () {
      const input = GaussAndroidNativeRuntimeBridgeImplementationGateInput(
        q303RuntimeDependencyTrialPresent: true,
        q302ExpectedSha256Verified: true,
        q302ActualSha256Computed: true,
        artifactAcceptedForRuntime: true,
        runtimeDependencyActuallyAdded: true,
        runtimeDependencyBuildEvidencePresent: true,
        licenseCompatibilityReviewed: true,
        androidAbiMatrixPresent: true,
        methodChannelContractReviewed: true,
        mainActivityBindingDiffReviewed: true,
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
        mainActivityChanged: false,
        androidManifestChanged: false,
        pubspecChanged: false,
        paddleRuntimeAdded: false,
        paddleOcrDependencyAdded: false,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: false,
        nativeRuntimeHandlerImplemented: false,
        gradleNativeRuntimeDependencyAdded: false,
        modelBinaryBundledInBaseApp: false,
        productionDownloadEnabled: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: false,
        realDummyInputRuntimeCallExecuted: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        nativeBridgeImplementationPassClaimed: false,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'premature-bridge-evidence-acceptance',
      );

      final result = GaussAndroidNativeRuntimeBridgeImplementationGate.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.decision, GaussAndroidNativeRuntimeBridgeImplementationGateDecision.blockedMissingQ302ShaOrQ303DependencyEvidence);
      expect(result.rejectionReasons, contains('q302-q303-real-bridge-evidence-not-complete-for-q304'));
    });

    test('blocks MainActivity/MethodChannel mutation and fake PASS claims', () {
      const input = GaussAndroidNativeRuntimeBridgeImplementationGateInput(
        q303RuntimeDependencyTrialPresent: true,
        q302ExpectedSha256Verified: false,
        q302ActualSha256Computed: false,
        artifactAcceptedForRuntime: false,
        runtimeDependencyActuallyAdded: false,
        runtimeDependencyBuildEvidencePresent: false,
        licenseCompatibilityReviewed: false,
        androidAbiMatrixPresent: false,
        methodChannelContractReviewed: true,
        mainActivityBindingDiffReviewed: false,
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
        mainActivityChanged: true,
        androidManifestChanged: true,
        pubspecChanged: true,
        paddleRuntimeAdded: true,
        paddleOcrDependencyAdded: true,
        jniBindingAdded: true,
        methodChannelRuntimeBindingAdded: true,
        nativeRuntimeHandlerImplemented: true,
        gradleNativeRuntimeDependencyAdded: true,
        modelBinaryBundledInBaseApp: true,
        productionDownloadEnabled: true,
        realPrivateArtifactLoaded: true,
        realRuntimeStartupExecuted: true,
        realDummyInputRuntimeCallExecuted: true,
        realImageToLatexInferenceExecuted: true,
        realEditableMathLiveReviewOpened: true,
        realWorkspaceImportExecuted: true,
        nativeBridgeImplementationPassClaimed: true,
        runtimeIntegrationPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: true,
        storeReadyPassClaimed: false,
        releasePassClaimed: true,
        trialLabel: 'forbidden-bridge-mutation',
      );

      final result = GaussAndroidNativeRuntimeBridgeImplementationGate.evaluate(input);
      expect(result.contractStaticReady, isFalse);
      expect(result.rejectionReasons, contains('native-runtime-bridge-or-runtime-mutation-forbidden-in-q304'));
      expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
    });
  });
}
