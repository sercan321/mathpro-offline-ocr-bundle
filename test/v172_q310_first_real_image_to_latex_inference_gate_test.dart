import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_gate_policy.dart';

void main() {
  test('q310-image-to-latex-inference-gate-is-static-default-off', () {
    final result = GaussFirstRealImageToLatexInferenceGate.evaluate(
      GaussFirstRealImageToLatexInferenceGateInput.q310Default(),
    );

    expect(result.phase, GaussFirstRealImageToLatexInferenceGatePolicy.phase);
    expect(result.sourcePhase, GaussFirstRealImageToLatexInferenceGatePolicy.sourcePhase);
    expect(result.contractStaticReady, isTrue);
    expect(result.imageToLatexInferenceGateDefined, isTrue);
    expect(result.imageToLatexInferenceDefaultOff, isTrue);
    expect(result.q309DummyInputRuntimeCallGatePresent, isTrue);
    expect(result.q309RealDummyRuntimeCallEvidencePresent, isFalse);
    expect(result.q309DummyRuntimeCallSucceeded, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.cameraImageSentToRuntime, isFalse);
    expect(result.realEditableMathLiveReviewOpened, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
  });

  test('q310-must-not-accept-complete-image-to-latex-evidence-inside-static-package', () {
    final result = GaussFirstRealImageToLatexInferenceGate.evaluate(
      const GaussFirstRealImageToLatexInferenceGateInput(
        q309DummyInputRuntimeCallGatePresent: true,
        q309RealDummyRuntimeCallEvidencePresent: true,
        q309DummyRuntimeCallSucceeded: true,
        nativeRuntimeMethodChannelBound: true,
        nativeHandlerImplemented: true,
        verifiedPrivateArtifactPathPresent: true,
        croppedImageFixtureDefined: true,
        croppedImageSha256Recorded: true,
        cropPreprocessMetadataRecorded: true,
        realAndroidDeviceInferenceLogRequired: true,
        inferenceTimeoutPolicyPresent: true,
        inferenceCancellationPolicyPresent: true,
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
        cameraImageSentToRuntime: false,
        realImageToLatexInferenceExecuted: false,
        runtimeLatexResponseParsed: false,
        realEditableMathLiveReviewOpened: false,
        realWorkspaceImportExecuted: false,
        imageToLatexPassClaimed: false,
        runtimeIntegrationPassClaimed: false,
        ocrPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'complete-image-to-latex-evidence-must-remain-external',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(
      result.rejectionReasons,
      contains('q310-must-not-accept-complete-image-to-latex-evidence-inside-static-package'),
    );
  });

  test('q310-blocks-inference-runtime-mutation-and-fake-pass-claims', () {
    final result = GaussFirstRealImageToLatexInferenceGate.evaluate(
      const GaussFirstRealImageToLatexInferenceGateInput(
        q309DummyInputRuntimeCallGatePresent: true,
        q309RealDummyRuntimeCallEvidencePresent: false,
        q309DummyRuntimeCallSucceeded: false,
        nativeRuntimeMethodChannelBound: false,
        nativeHandlerImplemented: false,
        verifiedPrivateArtifactPathPresent: false,
        croppedImageFixtureDefined: true,
        croppedImageSha256Recorded: true,
        cropPreprocessMetadataRecorded: true,
        realAndroidDeviceInferenceLogRequired: true,
        inferenceTimeoutPolicyPresent: true,
        inferenceCancellationPolicyPresent: true,
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
        cameraImageSentToRuntime: true,
        realImageToLatexInferenceExecuted: true,
        runtimeLatexResponseParsed: true,
        realEditableMathLiveReviewOpened: true,
        realWorkspaceImportExecuted: true,
        imageToLatexPassClaimed: true,
        runtimeIntegrationPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'forbidden-image-to-latex-runtime-mutation',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(result.rejectionReasons, contains('image-to-latex-inference-or-runtime-mutation-forbidden-in-q310'));
    expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
  });
}
