import 'gauss_runtime_startup_real_device_smoke_gate_policy.dart';

/// V172-Q308 — Runtime Startup Real Device Smoke Gate.
///
/// Static package-side gate only. It defines conditions for a future real
/// Android-device runtime startup smoke, but does not start runtime, call a
/// MethodChannel, load an artifact, warm up a model, or run OCR in Q308.
enum GaussRuntimeStartupRealDeviceSmokeGateDecision {
  runtimeStartupSmokeGateDefinedDefaultOff,
  blockedMissingQ307LoadEvidence,
  blockedProtectedSurfaceRegression,
  blockedRuntimeStartupMutationAttempt,
  blockedFakePassClaim,
}

class GaussRuntimeStartupRealDeviceSmokeGateInput {
  const GaussRuntimeStartupRealDeviceSmokeGateInput({
    required this.q307PrivateArtifactLoadSmokeGatePresent,
    required this.q306VerifiedPrivateArtifactPathRecorded,
    required this.q306ExpectedActualSha256Match,
    required this.q306AtomicMoveSucceeded,
    required this.q307RealPrivateArtifactLoadEvidencePresent,
    required this.q307ModelFormatProbeEvidencePresent,
    required this.nativeRuntimePackageSelected,
    required this.androidAbiMatrixReviewed,
    required this.runtimeStartupTimeoutPolicyPresent,
    required this.runtimeMemoryPressurePolicyPresent,
    required this.realAndroidDeviceStartupLogRequired,
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
    required this.methodChannelRuntimeBound,
    required this.jniNativeHandlerImplemented,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realPrivateArtifactLoaded,
    required this.modelFormatProbeExecuted,
    required this.realRuntimeStartupExecuted,
    required this.realRuntimeWarmupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.runtimeStartupPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussRuntimeStartupRealDeviceSmokeGateInput.q308Default({
    String trialLabel = 'q308-runtime-startup-real-device-smoke-gate',
  }) {
    return GaussRuntimeStartupRealDeviceSmokeGateInput(
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
      trialLabel: trialLabel,
    );
  }

  final bool q307PrivateArtifactLoadSmokeGatePresent;
  final bool q306VerifiedPrivateArtifactPathRecorded;
  final bool q306ExpectedActualSha256Match;
  final bool q306AtomicMoveSucceeded;
  final bool q307RealPrivateArtifactLoadEvidencePresent;
  final bool q307ModelFormatProbeEvidencePresent;
  final bool nativeRuntimePackageSelected;
  final bool androidAbiMatrixReviewed;
  final bool runtimeStartupTimeoutPolicyPresent;
  final bool runtimeMemoryPressurePolicyPresent;
  final bool realAndroidDeviceStartupLogRequired;
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
  final bool methodChannelRuntimeBound;
  final bool jniNativeHandlerImplemented;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realPrivateArtifactLoaded;
  final bool modelFormatProbeExecuted;
  final bool realRuntimeStartupExecuted;
  final bool realRuntimeWarmupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool runtimeStartupPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussRuntimeStartupRealDeviceSmokeGateResult {
  const GaussRuntimeStartupRealDeviceSmokeGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.runtimeStartupFeatureFlag,
    required this.startupSmokeMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeRuntimeStartupSmoke,
    required this.startupEnvelopeFields,
    required this.startupStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.runtimeStartupSmokeGateDefined,
    required this.runtimeStartupSmokeDefaultOff,
    required this.q307PrivateArtifactLoadSmokeGatePresent,
    required this.q306VerifiedPrivateArtifactPathRecorded,
    required this.q306ExpectedActualSha256Match,
    required this.q306AtomicMoveSucceeded,
    required this.q307RealPrivateArtifactLoadEvidencePresent,
    required this.q307ModelFormatProbeEvidencePresent,
    required this.nativeRuntimePackageSelected,
    required this.androidAbiMatrixReviewed,
    required this.runtimeStartupTimeoutPolicyPresent,
    required this.runtimeMemoryPressurePolicyPresent,
    required this.realAndroidDeviceStartupLogRequired,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.nativeRuntimeDependencyAdded,
    required this.methodChannelRuntimeBound,
    required this.jniNativeHandlerImplemented,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realPrivateArtifactLoaded,
    required this.modelFormatProbeExecuted,
    required this.realRuntimeStartupExecuted,
    required this.realRuntimeWarmupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.runtimeStartupPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String runtimeStartupFeatureFlag;
  final String startupSmokeMode;
  final String readinessState;
  final GaussRuntimeStartupRealDeviceSmokeGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeRuntimeStartupSmoke;
  final List<String> startupEnvelopeFields;
  final List<String> startupStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool runtimeStartupSmokeGateDefined;
  final bool runtimeStartupSmokeDefaultOff;
  final bool q307PrivateArtifactLoadSmokeGatePresent;
  final bool q306VerifiedPrivateArtifactPathRecorded;
  final bool q306ExpectedActualSha256Match;
  final bool q306AtomicMoveSucceeded;
  final bool q307RealPrivateArtifactLoadEvidencePresent;
  final bool q307ModelFormatProbeEvidencePresent;
  final bool nativeRuntimePackageSelected;
  final bool androidAbiMatrixReviewed;
  final bool runtimeStartupTimeoutPolicyPresent;
  final bool runtimeMemoryPressurePolicyPresent;
  final bool realAndroidDeviceStartupLogRequired;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool nativeRuntimeDependencyAdded;
  final bool methodChannelRuntimeBound;
  final bool jniNativeHandlerImplemented;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realPrivateArtifactLoaded;
  final bool modelFormatProbeExecuted;
  final bool realRuntimeStartupExecuted;
  final bool realRuntimeWarmupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool runtimeStartupPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
}

class GaussRuntimeStartupRealDeviceSmokeGate {
  const GaussRuntimeStartupRealDeviceSmokeGate._();

  static GaussRuntimeStartupRealDeviceSmokeGateResult evaluate(
    GaussRuntimeStartupRealDeviceSmokeGateInput input,
  ) {
    final rejectionReasons = <String>[];
    var decision = GaussRuntimeStartupRealDeviceSmokeGateDecision
        .runtimeStartupSmokeGateDefinedDefaultOff;

    final protectedSurfacesOk = input.keyboardLayoutProtected &&
        input.moreTemplateTrayProtected &&
        input.longPressListsProtected &&
        input.mathLiveProductionRouteProtected &&
        input.mathLiveBridgeProtected &&
        input.graphSolutionHistoryProtected &&
        input.appShellWorkspaceProtected &&
        input.androidManifestMainActivityProtected &&
        input.cameraShellRuntimeProtected &&
        input.splashIconProtected;

    if (!protectedSurfacesOk) {
      rejectionReasons.add('protected-surface-regression-forbidden');
      decision = GaussRuntimeStartupRealDeviceSmokeGateDecision
          .blockedProtectedSurfaceRegression;
    }

    final hasCompleteQ307Evidence = input.q306VerifiedPrivateArtifactPathRecorded &&
        input.q306ExpectedActualSha256Match &&
        input.q306AtomicMoveSucceeded &&
        input.q307RealPrivateArtifactLoadEvidencePresent &&
        input.q307ModelFormatProbeEvidencePresent &&
        input.nativeRuntimePackageSelected;
    if (hasCompleteQ307Evidence) {
      rejectionReasons.add(
        'q308-must-not-accept-complete-runtime-startup-evidence-inside-static-package',
      );
      decision = GaussRuntimeStartupRealDeviceSmokeGateDecision
          .blockedMissingQ307LoadEvidence;
    } else {
      rejectionReasons.add(
        'q307-private-artifact-load-and-runtime-startup-evidence-not-complete-for-q308',
      );
    }

    final runtimeStartupMutationAttempted = input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.nativeRuntimeDependencyAdded ||
        input.methodChannelRuntimeBound ||
        input.jniNativeHandlerImplemented ||
        input.productionDownloadEnabled ||
        input.modelBinaryBundledInBaseApp ||
        input.realPrivateArtifactLoaded ||
        input.modelFormatProbeExecuted ||
        input.realRuntimeStartupExecuted ||
        input.realRuntimeWarmupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted;
    if (runtimeStartupMutationAttempted) {
      rejectionReasons.add('runtime-startup-or-runtime-mutation-forbidden-in-q308');
      decision = GaussRuntimeStartupRealDeviceSmokeGateDecision
          .blockedRuntimeStartupMutationAttempt;
    }

    final fakePassClaimed = input.runtimeStartupPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed;
    if (fakePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
      decision = GaussRuntimeStartupRealDeviceSmokeGateDecision
          .blockedFakePassClaim;
    }

    final contractStaticReady = protectedSurfacesOk &&
        !hasCompleteQ307Evidence &&
        !runtimeStartupMutationAttempted &&
        !fakePassClaimed &&
        input.q307PrivateArtifactLoadSmokeGatePresent &&
        input.androidAbiMatrixReviewed &&
        input.runtimeStartupTimeoutPolicyPresent &&
        input.runtimeMemoryPressurePolicyPresent &&
        input.realAndroidDeviceStartupLogRequired &&
        input.rollbackPlanPresent &&
        input.defaultOffFeatureFlagPresent;

    return GaussRuntimeStartupRealDeviceSmokeGateResult(
      phase: GaussRuntimeStartupRealDeviceSmokeGatePolicy.phase,
      sourcePhase: GaussRuntimeStartupRealDeviceSmokeGatePolicy.sourcePhase,
      selectedEngineLabel:
          GaussRuntimeStartupRealDeviceSmokeGatePolicy.selectedEngineLabel,
      runtimeStartupFeatureFlag:
          GaussRuntimeStartupRealDeviceSmokeGatePolicy.runtimeStartupFeatureFlag,
      startupSmokeMode:
          GaussRuntimeStartupRealDeviceSmokeGatePolicy.startupSmokeMode,
      readinessState: GaussRuntimeStartupRealDeviceSmokeGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: contractStaticReady,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      requiredBeforeRuntimeStartupSmoke:
          GaussRuntimeStartupRealDeviceSmokeGatePolicy
              .requiredBeforeRuntimeStartupSmoke,
      startupEnvelopeFields:
          GaussRuntimeStartupRealDeviceSmokeGatePolicy.startupEnvelopeFields,
      startupStates: GaussRuntimeStartupRealDeviceSmokeGatePolicy.startupStates,
      errorCodes: GaussRuntimeStartupRealDeviceSmokeGatePolicy.errorCodes,
      protectedSurfaceMarkers:
          GaussRuntimeStartupRealDeviceSmokeGatePolicy.protectedSurfaceMarkers,
      forbiddenActions:
          GaussRuntimeStartupRealDeviceSmokeGatePolicy.forbiddenActions,
      runtimeStartupSmokeGateDefined: true,
      runtimeStartupSmokeDefaultOff: true,
      q307PrivateArtifactLoadSmokeGatePresent:
          input.q307PrivateArtifactLoadSmokeGatePresent,
      q306VerifiedPrivateArtifactPathRecorded:
          input.q306VerifiedPrivateArtifactPathRecorded,
      q306ExpectedActualSha256Match: input.q306ExpectedActualSha256Match,
      q306AtomicMoveSucceeded: input.q306AtomicMoveSucceeded,
      q307RealPrivateArtifactLoadEvidencePresent:
          input.q307RealPrivateArtifactLoadEvidencePresent,
      q307ModelFormatProbeEvidencePresent:
          input.q307ModelFormatProbeEvidencePresent,
      nativeRuntimePackageSelected: input.nativeRuntimePackageSelected,
      androidAbiMatrixReviewed: input.androidAbiMatrixReviewed,
      runtimeStartupTimeoutPolicyPresent:
          input.runtimeStartupTimeoutPolicyPresent,
      runtimeMemoryPressurePolicyPresent:
          input.runtimeMemoryPressurePolicyPresent,
      realAndroidDeviceStartupLogRequired:
          input.realAndroidDeviceStartupLogRequired,
      pubspecChanged: input.pubspecChanged,
      androidManifestChanged: input.androidManifestChanged,
      mainActivityChanged: input.mainActivityChanged,
      nativeRuntimeDependencyAdded: input.nativeRuntimeDependencyAdded,
      methodChannelRuntimeBound: input.methodChannelRuntimeBound,
      jniNativeHandlerImplemented: input.jniNativeHandlerImplemented,
      productionDownloadEnabled: input.productionDownloadEnabled,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      realPrivateArtifactLoaded: input.realPrivateArtifactLoaded,
      modelFormatProbeExecuted: input.modelFormatProbeExecuted,
      realRuntimeStartupExecuted: input.realRuntimeStartupExecuted,
      realRuntimeWarmupExecuted: input.realRuntimeWarmupExecuted,
      realDummyInputRuntimeCallExecuted: input.realDummyInputRuntimeCallExecuted,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      realEditableMathLiveReviewOpened: input.realEditableMathLiveReviewOpened,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      reviewBeforeImportRequired: true,
      explicitUserApprovalRequired: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      runtimeStartupPassClaimed: input.runtimeStartupPassClaimed,
      runtimeIntegrationPassClaimed: input.runtimeIntegrationPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      storeReadyPassClaimed: input.storeReadyPassClaimed,
      releasePassClaimed: input.releasePassClaimed,
    );
  }
}
