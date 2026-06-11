import 'gauss_first_real_image_to_latex_inference_gate_policy.dart';

/// V172-Q310 — First Real Image-to-LaTeX Inference Gate.
///
/// Static package-side gate only. It defines conditions for a future real
/// Android-device image-to-LaTeX inference, but does not bind MethodChannel,
/// invoke native runtime, send camera image data, parse LaTeX response, open
/// MathLive review, or mutate the workspace in Q310.
enum GaussFirstRealImageToLatexInferenceGateDecision {
  imageToLatexInferenceGateDefinedDefaultOff,
  blockedMissingQ309DummyRuntimeCallEvidence,
  blockedProtectedSurfaceRegression,
  blockedInferenceMutationAttempt,
  blockedFakePassClaim,
}

class GaussFirstRealImageToLatexInferenceGateInput {
  const GaussFirstRealImageToLatexInferenceGateInput({
    required this.q309DummyInputRuntimeCallGatePresent,
    required this.q309RealDummyRuntimeCallEvidencePresent,
    required this.q309DummyRuntimeCallSucceeded,
    required this.nativeRuntimeMethodChannelBound,
    required this.nativeHandlerImplemented,
    required this.verifiedPrivateArtifactPathPresent,
    required this.croppedImageFixtureDefined,
    required this.croppedImageSha256Recorded,
    required this.cropPreprocessMetadataRecorded,
    required this.realAndroidDeviceInferenceLogRequired,
    required this.inferenceTimeoutPolicyPresent,
    required this.inferenceCancellationPolicyPresent,
    required this.runtimeMemoryPressurePolicyPresent,
    required this.rollbackPlanPresent,
    required this.defaultOffFeatureFlagPresent,
    required this.keyboardLayoutProtected,
    required this.moreTemplateTrayProtected,
    required this.longPressListsProtected,
    required this.mathLiveProductionRouteProtected,
    required this.mathLiveBridgeProtected,
    required this.graphSolutionHistoryProtected,
    required this.appShellWorkspaceProtected,
    required this.androidManifestMainActivityProtected,
    required this.cameraShellRuntimeProtected,
    required this.splashIconProtected,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.nativeRuntimeDependencyAdded,
    required this.methodChannelRuntimeBoundInsidePackage,
    required this.jniNativeHandlerImplementedInsidePackage,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.cameraImageSentToRuntime,
    required this.realImageToLatexInferenceExecuted,
    required this.runtimeLatexResponseParsed,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.imageToLatexPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussFirstRealImageToLatexInferenceGateInput.q310Default({
    String trialLabel = 'q310-first-real-image-to-latex-inference-gate',
  }) {
    return GaussFirstRealImageToLatexInferenceGateInput(
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
      trialLabel: trialLabel,
    );
  }

  final bool q309DummyInputRuntimeCallGatePresent;
  final bool q309RealDummyRuntimeCallEvidencePresent;
  final bool q309DummyRuntimeCallSucceeded;
  final bool nativeRuntimeMethodChannelBound;
  final bool nativeHandlerImplemented;
  final bool verifiedPrivateArtifactPathPresent;
  final bool croppedImageFixtureDefined;
  final bool croppedImageSha256Recorded;
  final bool cropPreprocessMetadataRecorded;
  final bool realAndroidDeviceInferenceLogRequired;
  final bool inferenceTimeoutPolicyPresent;
  final bool inferenceCancellationPolicyPresent;
  final bool runtimeMemoryPressurePolicyPresent;
  final bool rollbackPlanPresent;
  final bool defaultOffFeatureFlagPresent;
  final bool keyboardLayoutProtected;
  final bool moreTemplateTrayProtected;
  final bool longPressListsProtected;
  final bool mathLiveProductionRouteProtected;
  final bool mathLiveBridgeProtected;
  final bool graphSolutionHistoryProtected;
  final bool appShellWorkspaceProtected;
  final bool androidManifestMainActivityProtected;
  final bool cameraShellRuntimeProtected;
  final bool splashIconProtected;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool nativeRuntimeDependencyAdded;
  final bool methodChannelRuntimeBoundInsidePackage;
  final bool jniNativeHandlerImplementedInsidePackage;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool cameraImageSentToRuntime;
  final bool realImageToLatexInferenceExecuted;
  final bool runtimeLatexResponseParsed;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool imageToLatexPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussFirstRealImageToLatexInferenceGateResult {
  const GaussFirstRealImageToLatexInferenceGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.imageToLatexInferenceFeatureFlag,
    required this.inferenceMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeImageToLatexInference,
    required this.imageToLatexEnvelopeFields,
    required this.inferenceStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.imageToLatexInferenceGateDefined,
    required this.imageToLatexInferenceDefaultOff,
    required this.q309DummyInputRuntimeCallGatePresent,
    required this.q309RealDummyRuntimeCallEvidencePresent,
    required this.q309DummyRuntimeCallSucceeded,
    required this.nativeRuntimeMethodChannelBound,
    required this.nativeHandlerImplemented,
    required this.verifiedPrivateArtifactPathPresent,
    required this.croppedImageFixtureDefined,
    required this.croppedImageSha256Recorded,
    required this.cropPreprocessMetadataRecorded,
    required this.realAndroidDeviceInferenceLogRequired,
    required this.inferenceTimeoutPolicyPresent,
    required this.inferenceCancellationPolicyPresent,
    required this.runtimeMemoryPressurePolicyPresent,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.nativeRuntimeDependencyAdded,
    required this.methodChannelRuntimeBoundInsidePackage,
    required this.jniNativeHandlerImplementedInsidePackage,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.cameraImageSentToRuntime,
    required this.realImageToLatexInferenceExecuted,
    required this.runtimeLatexResponseParsed,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.imageToLatexPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.changesRuntimeBehavior,
    required this.keyboardLayoutChanged,
    required this.moreTemplateTrayChanged,
    required this.longPressListsChanged,
    required this.graphSolutionHistoryChanged,
    required this.mathLiveProductionRouteChanged,
    required this.mathLiveBridgeChanged,
    required this.cameraShellRuntimeChanged,
    required this.workspaceRuntimeChanged,
    required this.solverEvaluatorChanged,
    required this.splashIconChanged,
    required this.cameraDependencyChanged,
    required this.androidToolchainChanged,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String imageToLatexInferenceFeatureFlag;
  final String inferenceMode;
  final String readinessState;
  final GaussFirstRealImageToLatexInferenceGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeImageToLatexInference;
  final List<String> imageToLatexEnvelopeFields;
  final List<String> inferenceStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool imageToLatexInferenceGateDefined;
  final bool imageToLatexInferenceDefaultOff;
  final bool q309DummyInputRuntimeCallGatePresent;
  final bool q309RealDummyRuntimeCallEvidencePresent;
  final bool q309DummyRuntimeCallSucceeded;
  final bool nativeRuntimeMethodChannelBound;
  final bool nativeHandlerImplemented;
  final bool verifiedPrivateArtifactPathPresent;
  final bool croppedImageFixtureDefined;
  final bool croppedImageSha256Recorded;
  final bool cropPreprocessMetadataRecorded;
  final bool realAndroidDeviceInferenceLogRequired;
  final bool inferenceTimeoutPolicyPresent;
  final bool inferenceCancellationPolicyPresent;
  final bool runtimeMemoryPressurePolicyPresent;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool nativeRuntimeDependencyAdded;
  final bool methodChannelRuntimeBoundInsidePackage;
  final bool jniNativeHandlerImplementedInsidePackage;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool cameraImageSentToRuntime;
  final bool realImageToLatexInferenceExecuted;
  final bool runtimeLatexResponseParsed;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool imageToLatexPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool changesRuntimeBehavior;
  final bool keyboardLayoutChanged;
  final bool moreTemplateTrayChanged;
  final bool longPressListsChanged;
  final bool graphSolutionHistoryChanged;
  final bool mathLiveProductionRouteChanged;
  final bool mathLiveBridgeChanged;
  final bool cameraShellRuntimeChanged;
  final bool workspaceRuntimeChanged;
  final bool solverEvaluatorChanged;
  final bool splashIconChanged;
  final bool cameraDependencyChanged;
  final bool androidToolchainChanged;
}

class GaussFirstRealImageToLatexInferenceGate {
  const GaussFirstRealImageToLatexInferenceGate._();

  static GaussFirstRealImageToLatexInferenceGateResult evaluate(
    GaussFirstRealImageToLatexInferenceGateInput input,
  ) {
    final rejectionReasons = <String>[];

    if (!input.q309DummyInputRuntimeCallGatePresent ||
        input.q309RealDummyRuntimeCallEvidencePresent ||
        input.q309DummyRuntimeCallSucceeded ||
        input.nativeRuntimeMethodChannelBound ||
        input.nativeHandlerImplemented ||
        input.verifiedPrivateArtifactPathPresent) {
      rejectionReasons.add(
        'q310-must-not-accept-complete-image-to-latex-evidence-inside-static-package',
      );
    }

    if (!input.croppedImageFixtureDefined ||
        !input.croppedImageSha256Recorded ||
        !input.cropPreprocessMetadataRecorded ||
        !input.realAndroidDeviceInferenceLogRequired ||
        !input.inferenceTimeoutPolicyPresent ||
        !input.inferenceCancellationPolicyPresent ||
        !input.runtimeMemoryPressurePolicyPresent ||
        !input.rollbackPlanPresent ||
        !input.defaultOffFeatureFlagPresent) {
      rejectionReasons.add('q310-static-inference-gate-requirement-missing');
    }

    if (!input.keyboardLayoutProtected ||
        !input.moreTemplateTrayProtected ||
        !input.longPressListsProtected ||
        !input.mathLiveProductionRouteProtected ||
        !input.mathLiveBridgeProtected ||
        !input.graphSolutionHistoryProtected ||
        !input.appShellWorkspaceProtected ||
        !input.androidManifestMainActivityProtected ||
        !input.cameraShellRuntimeProtected ||
        !input.splashIconProtected) {
      rejectionReasons.add('protected-surface-regression-forbidden');
    }

    if (input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.nativeRuntimeDependencyAdded ||
        input.methodChannelRuntimeBoundInsidePackage ||
        input.jniNativeHandlerImplementedInsidePackage ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.cameraImageSentToRuntime ||
        input.realImageToLatexInferenceExecuted ||
        input.runtimeLatexResponseParsed ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted) {
      rejectionReasons.add('image-to-latex-inference-or-runtime-mutation-forbidden-in-q310');
    }

    if (input.productionDownloadEnabled || input.modelBinaryBundledInBaseApp) {
      rejectionReasons.add('model-download-or-binary-bundling-forbidden-in-q310');
    }

    if (input.imageToLatexPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    final decision = rejectionReasons.isEmpty
        ? GaussFirstRealImageToLatexInferenceGateDecision.imageToLatexInferenceGateDefinedDefaultOff
        : rejectionReasons.contains('fake-pass-claim-forbidden')
            ? GaussFirstRealImageToLatexInferenceGateDecision.blockedFakePassClaim
            : rejectionReasons.contains('image-to-latex-inference-or-runtime-mutation-forbidden-in-q310')
                ? GaussFirstRealImageToLatexInferenceGateDecision.blockedInferenceMutationAttempt
                : rejectionReasons.contains('protected-surface-regression-forbidden')
                    ? GaussFirstRealImageToLatexInferenceGateDecision.blockedProtectedSurfaceRegression
                    : GaussFirstRealImageToLatexInferenceGateDecision.blockedMissingQ309DummyRuntimeCallEvidence;

    return GaussFirstRealImageToLatexInferenceGateResult(
      phase: GaussFirstRealImageToLatexInferenceGatePolicy.phase,
      sourcePhase: GaussFirstRealImageToLatexInferenceGatePolicy.sourcePhase,
      selectedEngineLabel: GaussFirstRealImageToLatexInferenceGatePolicy.selectedEngineLabel,
      imageToLatexInferenceFeatureFlag:
          GaussFirstRealImageToLatexInferenceGatePolicy.imageToLatexInferenceFeatureFlag,
      inferenceMode: GaussFirstRealImageToLatexInferenceGatePolicy.inferenceMode,
      readinessState: GaussFirstRealImageToLatexInferenceGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: rejectionReasons.isEmpty,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      requiredBeforeImageToLatexInference:
          GaussFirstRealImageToLatexInferenceGatePolicy.requiredBeforeImageToLatexInference,
      imageToLatexEnvelopeFields:
          GaussFirstRealImageToLatexInferenceGatePolicy.imageToLatexEnvelopeFields,
      inferenceStates: GaussFirstRealImageToLatexInferenceGatePolicy.inferenceStates,
      errorCodes: GaussFirstRealImageToLatexInferenceGatePolicy.errorCodes,
      protectedSurfaceMarkers: GaussFirstRealImageToLatexInferenceGatePolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussFirstRealImageToLatexInferenceGatePolicy.forbiddenActions,
      imageToLatexInferenceGateDefined: true,
      imageToLatexInferenceDefaultOff: input.defaultOffFeatureFlagPresent,
      q309DummyInputRuntimeCallGatePresent: input.q309DummyInputRuntimeCallGatePresent,
      q309RealDummyRuntimeCallEvidencePresent: input.q309RealDummyRuntimeCallEvidencePresent,
      q309DummyRuntimeCallSucceeded: input.q309DummyRuntimeCallSucceeded,
      nativeRuntimeMethodChannelBound: input.nativeRuntimeMethodChannelBound,
      nativeHandlerImplemented: input.nativeHandlerImplemented,
      verifiedPrivateArtifactPathPresent: input.verifiedPrivateArtifactPathPresent,
      croppedImageFixtureDefined: input.croppedImageFixtureDefined,
      croppedImageSha256Recorded: input.croppedImageSha256Recorded,
      cropPreprocessMetadataRecorded: input.cropPreprocessMetadataRecorded,
      realAndroidDeviceInferenceLogRequired: input.realAndroidDeviceInferenceLogRequired,
      inferenceTimeoutPolicyPresent: input.inferenceTimeoutPolicyPresent,
      inferenceCancellationPolicyPresent: input.inferenceCancellationPolicyPresent,
      runtimeMemoryPressurePolicyPresent: input.runtimeMemoryPressurePolicyPresent,
      pubspecChanged: input.pubspecChanged,
      androidManifestChanged: input.androidManifestChanged,
      mainActivityChanged: input.mainActivityChanged,
      nativeRuntimeDependencyAdded: input.nativeRuntimeDependencyAdded,
      methodChannelRuntimeBoundInsidePackage: input.methodChannelRuntimeBoundInsidePackage,
      jniNativeHandlerImplementedInsidePackage: input.jniNativeHandlerImplementedInsidePackage,
      productionDownloadEnabled: input.productionDownloadEnabled,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      realPrivateArtifactLoaded: input.realPrivateArtifactLoaded,
      realRuntimeStartupExecuted: input.realRuntimeStartupExecuted,
      realDummyInputRuntimeCallExecuted: input.realDummyInputRuntimeCallExecuted,
      cameraImageSentToRuntime: input.cameraImageSentToRuntime,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      runtimeLatexResponseParsed: input.runtimeLatexResponseParsed,
      realEditableMathLiveReviewOpened: input.realEditableMathLiveReviewOpened,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      reviewBeforeImportRequired: true,
      explicitUserApprovalRequired: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      imageToLatexPassClaimed: input.imageToLatexPassClaimed,
      runtimeIntegrationPassClaimed: input.runtimeIntegrationPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      storeReadyPassClaimed: input.storeReadyPassClaimed,
      releasePassClaimed: input.releasePassClaimed,
      changesRuntimeBehavior: false,
      keyboardLayoutChanged: false,
      moreTemplateTrayChanged: false,
      longPressListsChanged: false,
      graphSolutionHistoryChanged: false,
      mathLiveProductionRouteChanged: false,
      mathLiveBridgeChanged: false,
      cameraShellRuntimeChanged: false,
      workspaceRuntimeChanged: false,
      solverEvaluatorChanged: false,
      splashIconChanged: false,
      cameraDependencyChanged: false,
      androidToolchainChanged: false,
    );
  }
}
