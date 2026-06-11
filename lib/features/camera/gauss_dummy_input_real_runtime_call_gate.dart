import 'gauss_dummy_input_real_runtime_call_gate_policy.dart';

/// V172-Q309 — Dummy Input Real Runtime Call Gate.
///
/// Static package-side gate only. It defines conditions for a future real
/// Android-device dummy runtime call, but does not bind MethodChannel, invoke
/// native runtime, parse a response, send camera image data, or run OCR in Q309.
enum GaussDummyInputRealRuntimeCallGateDecision {
  dummyInputRuntimeCallGateDefinedDefaultOff,
  blockedMissingQ308RuntimeStartupEvidence,
  blockedProtectedSurfaceRegression,
  blockedRuntimeCallMutationAttempt,
  blockedFakePassClaim,
}

class GaussDummyInputRealRuntimeCallGateInput {
  const GaussDummyInputRealRuntimeCallGateInput({
    required this.q308RuntimeStartupSmokeGatePresent,
    required this.q308RealRuntimeStartupEvidencePresent,
    required this.q308RuntimeStartupSucceeded,
    required this.nativeRuntimeMethodChannelBound,
    required this.nativeHandlerImplemented,
    required this.dummyInputFixtureDefined,
    required this.dummyInputPayloadSha256Recorded,
    required this.realAndroidDeviceDummyCallLogRequired,
    required this.runtimeCallTimeoutPolicyPresent,
    required this.runtimeCallCancellationPolicyPresent,
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
    required this.dummyRuntimeResponseParsed,
    required this.cameraImageSentToRuntime,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.dummyRuntimeCallPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussDummyInputRealRuntimeCallGateInput.q309Default({
    String trialLabel = 'q309-dummy-input-real-runtime-call-gate',
  }) {
    return GaussDummyInputRealRuntimeCallGateInput(
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
      trialLabel: trialLabel,
    );
  }

  final bool q308RuntimeStartupSmokeGatePresent;
  final bool q308RealRuntimeStartupEvidencePresent;
  final bool q308RuntimeStartupSucceeded;
  final bool nativeRuntimeMethodChannelBound;
  final bool nativeHandlerImplemented;
  final bool dummyInputFixtureDefined;
  final bool dummyInputPayloadSha256Recorded;
  final bool realAndroidDeviceDummyCallLogRequired;
  final bool runtimeCallTimeoutPolicyPresent;
  final bool runtimeCallCancellationPolicyPresent;
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
  final bool dummyRuntimeResponseParsed;
  final bool cameraImageSentToRuntime;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool dummyRuntimeCallPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussDummyInputRealRuntimeCallGateResult {
  const GaussDummyInputRealRuntimeCallGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.dummyInputRuntimeCallFeatureFlag,
    required this.dummyInputCallMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeDummyInputRuntimeCall,
    required this.dummyCallEnvelopeFields,
    required this.dummyCallStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.dummyInputRuntimeCallGateDefined,
    required this.dummyInputRuntimeCallDefaultOff,
    required this.q308RuntimeStartupSmokeGatePresent,
    required this.q308RealRuntimeStartupEvidencePresent,
    required this.q308RuntimeStartupSucceeded,
    required this.nativeRuntimeMethodChannelBound,
    required this.nativeHandlerImplemented,
    required this.dummyInputFixtureDefined,
    required this.dummyInputPayloadSha256Recorded,
    required this.realAndroidDeviceDummyCallLogRequired,
    required this.runtimeCallTimeoutPolicyPresent,
    required this.runtimeCallCancellationPolicyPresent,
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
    required this.dummyRuntimeResponseParsed,
    required this.cameraImageSentToRuntime,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.dummyRuntimeCallPassClaimed,
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
  final String dummyInputRuntimeCallFeatureFlag;
  final String dummyInputCallMode;
  final String readinessState;
  final GaussDummyInputRealRuntimeCallGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeDummyInputRuntimeCall;
  final List<String> dummyCallEnvelopeFields;
  final List<String> dummyCallStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool dummyInputRuntimeCallGateDefined;
  final bool dummyInputRuntimeCallDefaultOff;
  final bool q308RuntimeStartupSmokeGatePresent;
  final bool q308RealRuntimeStartupEvidencePresent;
  final bool q308RuntimeStartupSucceeded;
  final bool nativeRuntimeMethodChannelBound;
  final bool nativeHandlerImplemented;
  final bool dummyInputFixtureDefined;
  final bool dummyInputPayloadSha256Recorded;
  final bool realAndroidDeviceDummyCallLogRequired;
  final bool runtimeCallTimeoutPolicyPresent;
  final bool runtimeCallCancellationPolicyPresent;
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
  final bool dummyRuntimeResponseParsed;
  final bool cameraImageSentToRuntime;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool dummyRuntimeCallPassClaimed;
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

class GaussDummyInputRealRuntimeCallGate {
  const GaussDummyInputRealRuntimeCallGate._();

  static GaussDummyInputRealRuntimeCallGateResult evaluate(
    GaussDummyInputRealRuntimeCallGateInput input,
  ) {
    final rejectionReasons = <String>[];

    if (!input.q308RuntimeStartupSmokeGatePresent ||
        input.q308RealRuntimeStartupEvidencePresent ||
        input.q308RuntimeStartupSucceeded ||
        input.nativeRuntimeMethodChannelBound ||
        input.nativeHandlerImplemented) {
      rejectionReasons.add(
        'q309-must-not-accept-complete-dummy-call-evidence-inside-static-package',
      );
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
        input.dummyRuntimeResponseParsed ||
        input.cameraImageSentToRuntime ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted) {
      rejectionReasons.add('dummy-runtime-call-or-runtime-mutation-forbidden-in-q309');
    }

    if (input.productionDownloadEnabled || input.modelBinaryBundledInBaseApp) {
      rejectionReasons.add('model-download-or-binary-bundling-forbidden-in-q309');
    }

    if (input.dummyRuntimeCallPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    final decision = rejectionReasons.isEmpty
        ? GaussDummyInputRealRuntimeCallGateDecision.dummyInputRuntimeCallGateDefinedDefaultOff
        : rejectionReasons.contains('fake-pass-claim-forbidden')
            ? GaussDummyInputRealRuntimeCallGateDecision.blockedFakePassClaim
            : rejectionReasons.contains('dummy-runtime-call-or-runtime-mutation-forbidden-in-q309')
                ? GaussDummyInputRealRuntimeCallGateDecision.blockedRuntimeCallMutationAttempt
                : rejectionReasons.contains('protected-surface-regression-forbidden')
                    ? GaussDummyInputRealRuntimeCallGateDecision.blockedProtectedSurfaceRegression
                    : GaussDummyInputRealRuntimeCallGateDecision.blockedMissingQ308RuntimeStartupEvidence;

    return GaussDummyInputRealRuntimeCallGateResult(
      phase: GaussDummyInputRealRuntimeCallGatePolicy.phase,
      sourcePhase: GaussDummyInputRealRuntimeCallGatePolicy.sourcePhase,
      selectedEngineLabel: GaussDummyInputRealRuntimeCallGatePolicy.selectedEngineLabel,
      dummyInputRuntimeCallFeatureFlag:
          GaussDummyInputRealRuntimeCallGatePolicy.dummyInputRuntimeCallFeatureFlag,
      dummyInputCallMode: GaussDummyInputRealRuntimeCallGatePolicy.dummyInputCallMode,
      readinessState: GaussDummyInputRealRuntimeCallGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: rejectionReasons.isEmpty,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      requiredBeforeDummyInputRuntimeCall:
          GaussDummyInputRealRuntimeCallGatePolicy.requiredBeforeDummyInputRuntimeCall,
      dummyCallEnvelopeFields: GaussDummyInputRealRuntimeCallGatePolicy.dummyCallEnvelopeFields,
      dummyCallStates: GaussDummyInputRealRuntimeCallGatePolicy.dummyCallStates,
      errorCodes: GaussDummyInputRealRuntimeCallGatePolicy.errorCodes,
      protectedSurfaceMarkers: GaussDummyInputRealRuntimeCallGatePolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussDummyInputRealRuntimeCallGatePolicy.forbiddenActions,
      dummyInputRuntimeCallGateDefined: true,
      dummyInputRuntimeCallDefaultOff: input.defaultOffFeatureFlagPresent,
      q308RuntimeStartupSmokeGatePresent: input.q308RuntimeStartupSmokeGatePresent,
      q308RealRuntimeStartupEvidencePresent: input.q308RealRuntimeStartupEvidencePresent,
      q308RuntimeStartupSucceeded: input.q308RuntimeStartupSucceeded,
      nativeRuntimeMethodChannelBound: input.nativeRuntimeMethodChannelBound,
      nativeHandlerImplemented: input.nativeHandlerImplemented,
      dummyInputFixtureDefined: input.dummyInputFixtureDefined,
      dummyInputPayloadSha256Recorded: input.dummyInputPayloadSha256Recorded,
      realAndroidDeviceDummyCallLogRequired: input.realAndroidDeviceDummyCallLogRequired,
      runtimeCallTimeoutPolicyPresent: input.runtimeCallTimeoutPolicyPresent,
      runtimeCallCancellationPolicyPresent: input.runtimeCallCancellationPolicyPresent,
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
      dummyRuntimeResponseParsed: input.dummyRuntimeResponseParsed,
      cameraImageSentToRuntime: input.cameraImageSentToRuntime,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      realEditableMathLiveReviewOpened: input.realEditableMathLiveReviewOpened,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      reviewBeforeImportRequired: true,
      explicitUserApprovalRequired: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      dummyRuntimeCallPassClaimed: input.dummyRuntimeCallPassClaimed,
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
