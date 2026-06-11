import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_dummy_input_real_runtime_call_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_dummy_input_real_runtime_call_gate_policy.dart';

void main() {
  test('q309-dummy-input-runtime-call-gate-is-static-default-off', () {
    final result = GaussDummyInputRealRuntimeCallGate.evaluate(
      GaussDummyInputRealRuntimeCallGateInput.q309Default(),
    );

    expect(result.phase, GaussDummyInputRealRuntimeCallGatePolicy.phase);
    expect(result.sourcePhase, GaussDummyInputRealRuntimeCallGatePolicy.sourcePhase);
    expect(result.contractStaticReady, isTrue);
    expect(result.dummyInputRuntimeCallGateDefined, isTrue);
    expect(result.dummyInputRuntimeCallDefaultOff, isTrue);
    expect(result.q308RuntimeStartupSmokeGatePresent, isTrue);
    expect(result.q308RealRuntimeStartupEvidencePresent, isFalse);
    expect(result.realDummyInputRuntimeCallExecuted, isFalse);
    expect(result.methodChannelRuntimeBoundInsidePackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
  });

  test('q309-must-not-accept-complete-dummy-call-evidence-inside-static-package', () {
    final result = GaussDummyInputRealRuntimeCallGate.evaluate(
      const GaussDummyInputRealRuntimeCallGateInput(
        q308RuntimeStartupSmokeGatePresent: true,
        q308RealRuntimeStartupEvidencePresent: true,
        q308RuntimeStartupSucceeded: true,
        nativeRuntimeMethodChannelBound: true,
        nativeHandlerImplemented: true,
        dummyInputFixtureDefined: true,
        dummyInputPayloadSha256Recorded: true,
        realAndroidDeviceDummyCallLogRequired: true,
        runtimeCallTimeoutPolicyPresent: true,
        runtimeCallCancellationPolicyPresent: true,
        runtimeMemoryPressurePolicyPresent: true,
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
        methodChannelRuntimeBoundInsidePackage: false,
        jniNativeHandlerImplementedInsidePackage: false,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: false,
        realDummyInputRuntimeCallExecuted: false,
        dummyRuntimeResponseParsed: false,
        cameraImageSentToRuntime: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        dummyRuntimeCallPassClaimed: false,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'complete-dummy-call-evidence-must-remain-external',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(
      result.rejectionReasons,
      contains('q309-must-not-accept-complete-dummy-call-evidence-inside-static-package'),
    );
  });

  test('q309-blocks-runtime-call-mutation-and-fake-pass-claims', () {
    final result = GaussDummyInputRealRuntimeCallGate.evaluate(
      const GaussDummyInputRealRuntimeCallGateInput(
        q308RuntimeStartupSmokeGatePresent: true,
        q308RealRuntimeStartupEvidencePresent: false,
        q308RuntimeStartupSucceeded: false,
        nativeRuntimeMethodChannelBound: false,
        nativeHandlerImplemented: false,
        dummyInputFixtureDefined: true,
        dummyInputPayloadSha256Recorded: true,
        realAndroidDeviceDummyCallLogRequired: true,
        runtimeCallTimeoutPolicyPresent: true,
        runtimeCallCancellationPolicyPresent: true,
        runtimeMemoryPressurePolicyPresent: true,
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
        methodChannelRuntimeBoundInsidePackage: true,
        jniNativeHandlerImplementedInsidePackage: true,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: true,
        realDummyInputRuntimeCallExecuted: true,
        dummyRuntimeResponseParsed: true,
        cameraImageSentToRuntime: false,
        realImageToLatexInferenceExecuted: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        dummyRuntimeCallPassClaimed: true,
        runtimeIntegrationPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'forbidden-dummy-runtime-call-mutation',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(result.rejectionReasons, contains('dummy-runtime-call-or-runtime-mutation-forbidden-in-q309'));
    expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
  });
}
