import 'gauss_android_native_runtime_bridge_implementation_gate_policy.dart';

/// V172-Q304 — Android Native Runtime Bridge Implementation Gate.
///
/// Evaluates whether the package may actually bind PP-FormulaNet-S to Android's
/// native runtime bridge. In this package the answer remains blocked: Q302 SHA
/// evidence and Q303 dependency evidence are still incomplete, so no MainActivity
/// MethodChannel or native handler implementation is added.
enum GaussAndroidNativeRuntimeBridgeImplementationGateDecision {
  androidNativeBridgeImplementationGateDefinedDefaultOff,
  blockedMissingQ302ShaOrQ303DependencyEvidence,
  blockedProtectedSurfaceRegression,
  blockedRuntimeBridgeMutationAttempt,
  blockedFakePassClaim,
}

class GaussAndroidNativeRuntimeBridgeImplementationGateInput {
  const GaussAndroidNativeRuntimeBridgeImplementationGateInput({
    required this.q303RuntimeDependencyTrialPresent,
    required this.q302ExpectedSha256Verified,
    required this.q302ActualSha256Computed,
    required this.artifactAcceptedForRuntime,
    required this.runtimeDependencyActuallyAdded,
    required this.runtimeDependencyBuildEvidencePresent,
    required this.licenseCompatibilityReviewed,
    required this.androidAbiMatrixPresent,
    required this.methodChannelContractReviewed,
    required this.mainActivityBindingDiffReviewed,
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
    required this.mainActivityChanged,
    required this.androidManifestChanged,
    required this.pubspecChanged,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeHandlerImplemented,
    required this.gradleNativeRuntimeDependencyAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.nativeBridgeImplementationPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussAndroidNativeRuntimeBridgeImplementationGateInput.q304Default({
    String trialLabel = 'q304-android-native-runtime-bridge-implementation-gate',
  }) {
    return GaussAndroidNativeRuntimeBridgeImplementationGateInput(
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
      trialLabel: trialLabel,
    );
  }

  final bool q303RuntimeDependencyTrialPresent;
  final bool q302ExpectedSha256Verified;
  final bool q302ActualSha256Computed;
  final bool artifactAcceptedForRuntime;
  final bool runtimeDependencyActuallyAdded;
  final bool runtimeDependencyBuildEvidencePresent;
  final bool licenseCompatibilityReviewed;
  final bool androidAbiMatrixPresent;
  final bool methodChannelContractReviewed;
  final bool mainActivityBindingDiffReviewed;
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
  final bool mainActivityChanged;
  final bool androidManifestChanged;
  final bool pubspecChanged;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeHandlerImplemented;
  final bool gradleNativeRuntimeDependencyAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool nativeBridgeImplementationPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussAndroidNativeRuntimeBridgeImplementationGateResult {
  const GaussAndroidNativeRuntimeBridgeImplementationGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.methodChannelName,
    required this.nativeHandlerName,
    required this.bridgeFeatureFlag,
    required this.bridgeImplementationMode,
    required this.readinessState,
    required this.implementationDecision,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeBridgeImplementation,
    required this.requestEnvelopeFields,
    required this.responseEnvelopeFields,
    required this.bridgeErrorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.androidNativeRuntimeBridgeGateDefined,
    required this.androidNativeRuntimeBridgeDefaultOff,
    required this.androidNativeRuntimeBridgeActuallyImplemented,
    required this.methodChannelNameReserved,
    required this.nativeHandlerNameReserved,
    required this.mainActivityChanged,
    required this.androidManifestChanged,
    required this.pubspecChanged,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeHandlerImplemented,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.nativeBridgeImplementationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String methodChannelName;
  final String nativeHandlerName;
  final String bridgeFeatureFlag;
  final String bridgeImplementationMode;
  final String readinessState;
  final String implementationDecision;
  final GaussAndroidNativeRuntimeBridgeImplementationGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeBridgeImplementation;
  final List<String> requestEnvelopeFields;
  final List<String> responseEnvelopeFields;
  final List<String> bridgeErrorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool androidNativeRuntimeBridgeGateDefined;
  final bool androidNativeRuntimeBridgeDefaultOff;
  final bool androidNativeRuntimeBridgeActuallyImplemented;
  final bool methodChannelNameReserved;
  final bool nativeHandlerNameReserved;
  final bool mainActivityChanged;
  final bool androidManifestChanged;
  final bool pubspecChanged;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeHandlerImplemented;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool nativeBridgeImplementationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussAndroidNativeRuntimeBridgeImplementationGate {
  const GaussAndroidNativeRuntimeBridgeImplementationGate._();

  static GaussAndroidNativeRuntimeBridgeImplementationGateResult evaluate(
    GaussAndroidNativeRuntimeBridgeImplementationGateInput input,
  ) {
    final rejectionReasons = <String>[];

    if (!input.q303RuntimeDependencyTrialPresent) {
      rejectionReasons.add('q303-runtime-dependency-trial-required');
    }
    if (input.q302ExpectedSha256Verified ||
        input.q302ActualSha256Computed ||
        input.artifactAcceptedForRuntime ||
        input.runtimeDependencyActuallyAdded ||
        input.runtimeDependencyBuildEvidencePresent ||
        input.licenseCompatibilityReviewed ||
        input.androidAbiMatrixPresent ||
        input.mainActivityBindingDiffReviewed) {
      rejectionReasons.add('q302-q303-real-bridge-evidence-not-complete-for-q304');
    }
    if (!input.methodChannelContractReviewed || !input.rollbackPlanPresent || !input.defaultOffFeatureFlagPresent) {
      rejectionReasons.add('method-channel-contract-rollback-default-off-required');
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
      rejectionReasons.add('protected-surface-regression-detected');
    }
    if (input.mainActivityChanged ||
        input.androidManifestChanged ||
        input.pubspecChanged ||
        input.paddleRuntimeAdded ||
        input.paddleOcrDependencyAdded ||
        input.jniBindingAdded ||
        input.methodChannelRuntimeBindingAdded ||
        input.nativeRuntimeHandlerImplemented ||
        input.gradleNativeRuntimeDependencyAdded ||
        input.modelBinaryBundledInBaseApp ||
        input.productionDownloadEnabled ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted) {
      rejectionReasons.add('native-runtime-bridge-or-runtime-mutation-forbidden-in-q304');
    }
    if (input.nativeBridgeImplementationPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    return GaussAndroidNativeRuntimeBridgeImplementationGateResult(
      phase: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.phase,
      sourcePhase: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.sourcePhase,
      selectedEngineLabel: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.selectedEngineLabel,
      methodChannelName: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.methodChannelName,
      nativeHandlerName: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.nativeHandlerName,
      bridgeFeatureFlag: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.bridgeFeatureFlag,
      bridgeImplementationMode: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.bridgeImplementationMode,
      readinessState: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.readinessState,
      implementationDecision: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.implementationDecision,
      decision: _decisionFor(rejectionReasons),
      contractStaticReady: rejectionReasons.isEmpty,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      requiredBeforeBridgeImplementation: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.requiredBeforeBridgeImplementation,
      requestEnvelopeFields: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.requestEnvelopeFields,
      responseEnvelopeFields: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.responseEnvelopeFields,
      bridgeErrorCodes: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.bridgeErrorCodes,
      protectedSurfaceMarkers: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.forbiddenActions,
      androidNativeRuntimeBridgeGateDefined: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.androidNativeRuntimeBridgeGateDefined,
      androidNativeRuntimeBridgeDefaultOff: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.androidNativeRuntimeBridgeDefaultOff,
      androidNativeRuntimeBridgeActuallyImplemented: input.methodChannelRuntimeBindingAdded || input.nativeRuntimeHandlerImplemented,
      methodChannelNameReserved: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.methodChannelNameReserved,
      nativeHandlerNameReserved: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.nativeHandlerNameReserved,
      mainActivityChanged: input.mainActivityChanged,
      androidManifestChanged: input.androidManifestChanged,
      pubspecChanged: input.pubspecChanged,
      paddleRuntimeAdded: input.paddleRuntimeAdded,
      paddleOcrDependencyAdded: input.paddleOcrDependencyAdded,
      methodChannelRuntimeBindingAdded: input.methodChannelRuntimeBindingAdded,
      nativeRuntimeHandlerImplemented: input.nativeRuntimeHandlerImplemented,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: input.productionDownloadEnabled,
      realRuntimeStartupExecuted: input.realRuntimeStartupExecuted,
      realDummyInputRuntimeCallExecuted: input.realDummyInputRuntimeCallExecuted,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      reviewBeforeImportRequired: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.reviewBeforeImportRequired,
      explicitUserApprovalRequired: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.explicitUserApprovalRequired,
      directWorkspaceImportBlocked: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.directWorkspaceImportBlocked,
      directSolveGraphSolutionHistoryBlocked: GaussAndroidNativeRuntimeBridgeImplementationGatePolicy.directSolveGraphSolutionHistoryBlocked,
      nativeBridgeImplementationPassClaimed: input.nativeBridgeImplementationPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      releasePassClaimed: input.releasePassClaimed,
      trialLabel: input.trialLabel,
    );
  }

  static GaussAndroidNativeRuntimeBridgeImplementationGateDecision _decisionFor(List<String> rejectionReasons) {
    if (rejectionReasons.isEmpty) {
      return GaussAndroidNativeRuntimeBridgeImplementationGateDecision.androidNativeBridgeImplementationGateDefinedDefaultOff;
    }
    if (rejectionReasons.contains('q302-q303-real-bridge-evidence-not-complete-for-q304') ||
        rejectionReasons.contains('q303-runtime-dependency-trial-required') ||
        rejectionReasons.contains('method-channel-contract-rollback-default-off-required')) {
      return GaussAndroidNativeRuntimeBridgeImplementationGateDecision.blockedMissingQ302ShaOrQ303DependencyEvidence;
    }
    if (rejectionReasons.contains('protected-surface-regression-detected')) {
      return GaussAndroidNativeRuntimeBridgeImplementationGateDecision.blockedProtectedSurfaceRegression;
    }
    if (rejectionReasons.contains('fake-pass-claim-forbidden')) {
      return GaussAndroidNativeRuntimeBridgeImplementationGateDecision.blockedFakePassClaim;
    }
    return GaussAndroidNativeRuntimeBridgeImplementationGateDecision.blockedRuntimeBridgeMutationAttempt;
  }
}
