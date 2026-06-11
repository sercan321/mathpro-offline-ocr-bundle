import 'gauss_private_artifact_load_real_device_smoke_gate_policy.dart';

/// V172-Q307 — Private Artifact Load Real Device Smoke Gate.
///
/// Static package-side gate only. It defines the conditions for a future real
/// Android-device private artifact load smoke, but does not load an artifact,
/// probe a model, start runtime, or run OCR in Q307.
enum GaussPrivateArtifactLoadRealDeviceSmokeGateDecision {
  privateArtifactLoadSmokeGateDefinedDefaultOff,
  blockedMissingVerifiedPrivateArtifactEvidence,
  blockedProtectedSurfaceRegression,
  blockedLoadOrRuntimeMutationAttempt,
  blockedFakePassClaim,
}

class GaussPrivateArtifactLoadRealDeviceSmokeGateInput {
  const GaussPrivateArtifactLoadRealDeviceSmokeGateInput({
    required this.q306ShaAtomicMoveGatePresent,
    required this.q306VerifiedPrivateArtifactPathRecorded,
    required this.q306ExpectedActualSha256Match,
    required this.q306AtomicMoveSucceeded,
    required this.privateArtifactPathReviewed,
    required this.artifactByteLengthReviewed,
    required this.modelFormatProbePlanReviewed,
    required this.realAndroidDeviceLoadLogRequired,
    required this.loadTimeoutPolicyReviewed,
    required this.memoryPressurePolicyReviewed,
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
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realModelDownloadExecuted,
    required this.realShaVerificationExecuted,
    required this.realAtomicMoveExecuted,
    required this.artifactAcceptedForRuntime,
    required this.realPrivateArtifactLoaded,
    required this.modelFormatProbeExecuted,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.privateArtifactLoadPassClaimed,
    required this.modelFormatProbePassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussPrivateArtifactLoadRealDeviceSmokeGateInput.q307Default({
    String trialLabel = 'q307-private-artifact-load-real-device-smoke-gate',
  }) {
    return GaussPrivateArtifactLoadRealDeviceSmokeGateInput(
      q306ShaAtomicMoveGatePresent: true,
      q306VerifiedPrivateArtifactPathRecorded: false,
      q306ExpectedActualSha256Match: false,
      q306AtomicMoveSucceeded: false,
      privateArtifactPathReviewed: true,
      artifactByteLengthReviewed: true,
      modelFormatProbePlanReviewed: true,
      realAndroidDeviceLoadLogRequired: true,
      loadTimeoutPolicyReviewed: true,
      memoryPressurePolicyReviewed: true,
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
      productionDownloadEnabled: false,
      modelBinaryBundledInBaseApp: false,
      realModelDownloadExecuted: false,
      realShaVerificationExecuted: false,
      realAtomicMoveExecuted: false,
      artifactAcceptedForRuntime: false,
      realPrivateArtifactLoaded: false,
      modelFormatProbeExecuted: false,
      realRuntimeStartupExecuted: false,
      realDummyInputRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      realEditableMathLiveReviewOpened: false,
      realWorkspaceImportExecuted: false,
      privateArtifactLoadPassClaimed: false,
      modelFormatProbePassClaimed: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      trialLabel: trialLabel,
    );
  }

  final bool q306ShaAtomicMoveGatePresent;
  final bool q306VerifiedPrivateArtifactPathRecorded;
  final bool q306ExpectedActualSha256Match;
  final bool q306AtomicMoveSucceeded;
  final bool privateArtifactPathReviewed;
  final bool artifactByteLengthReviewed;
  final bool modelFormatProbePlanReviewed;
  final bool realAndroidDeviceLoadLogRequired;
  final bool loadTimeoutPolicyReviewed;
  final bool memoryPressurePolicyReviewed;
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
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realModelDownloadExecuted;
  final bool realShaVerificationExecuted;
  final bool realAtomicMoveExecuted;
  final bool artifactAcceptedForRuntime;
  final bool realPrivateArtifactLoaded;
  final bool modelFormatProbeExecuted;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool privateArtifactLoadPassClaimed;
  final bool modelFormatProbePassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussPrivateArtifactLoadRealDeviceSmokeGateResult {
  const GaussPrivateArtifactLoadRealDeviceSmokeGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.loadSmokeFeatureFlag,
    required this.loadSmokeMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforePrivateArtifactLoadSmoke,
    required this.loadSmokeEnvelopeFields,
    required this.loadSmokeStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.privateArtifactLoadSmokeGateDefined,
    required this.privateArtifactLoadSmokeDefaultOff,
    required this.q306ShaAtomicMoveGatePresent,
    required this.q306VerifiedPrivateArtifactPathRecorded,
    required this.q306ExpectedActualSha256Match,
    required this.q306AtomicMoveSucceeded,
    required this.privateArtifactPathReviewed,
    required this.artifactByteLengthReviewed,
    required this.modelFormatProbePlanReviewed,
    required this.realAndroidDeviceLoadLogRequired,
    required this.loadTimeoutPolicyReviewed,
    required this.memoryPressurePolicyReviewed,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realModelDownloadExecuted,
    required this.realShaVerificationExecuted,
    required this.realAtomicMoveExecuted,
    required this.artifactAcceptedForRuntime,
    required this.realPrivateArtifactLoaded,
    required this.modelFormatProbeExecuted,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.privateArtifactLoadPassClaimed,
    required this.modelFormatProbePassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String loadSmokeFeatureFlag;
  final String loadSmokeMode;
  final String readinessState;
  final GaussPrivateArtifactLoadRealDeviceSmokeGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforePrivateArtifactLoadSmoke;
  final List<String> loadSmokeEnvelopeFields;
  final List<String> loadSmokeStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool privateArtifactLoadSmokeGateDefined;
  final bool privateArtifactLoadSmokeDefaultOff;
  final bool q306ShaAtomicMoveGatePresent;
  final bool q306VerifiedPrivateArtifactPathRecorded;
  final bool q306ExpectedActualSha256Match;
  final bool q306AtomicMoveSucceeded;
  final bool privateArtifactPathReviewed;
  final bool artifactByteLengthReviewed;
  final bool modelFormatProbePlanReviewed;
  final bool realAndroidDeviceLoadLogRequired;
  final bool loadTimeoutPolicyReviewed;
  final bool memoryPressurePolicyReviewed;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realModelDownloadExecuted;
  final bool realShaVerificationExecuted;
  final bool realAtomicMoveExecuted;
  final bool artifactAcceptedForRuntime;
  final bool realPrivateArtifactLoaded;
  final bool modelFormatProbeExecuted;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool privateArtifactLoadPassClaimed;
  final bool modelFormatProbePassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
}

class GaussPrivateArtifactLoadRealDeviceSmokeGate {
  const GaussPrivateArtifactLoadRealDeviceSmokeGate._();

  static GaussPrivateArtifactLoadRealDeviceSmokeGateResult evaluate(
    GaussPrivateArtifactLoadRealDeviceSmokeGateInput input,
  ) {
    final rejectionReasons = <String>[];
    var decision = GaussPrivateArtifactLoadRealDeviceSmokeGateDecision
        .privateArtifactLoadSmokeGateDefinedDefaultOff;

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
      decision = GaussPrivateArtifactLoadRealDeviceSmokeGateDecision
          .blockedProtectedSurfaceRegression;
    }

    final hasCompleteQ306Evidence = input.q306VerifiedPrivateArtifactPathRecorded &&
        input.q306ExpectedActualSha256Match &&
        input.q306AtomicMoveSucceeded;
    if (hasCompleteQ306Evidence) {
      rejectionReasons.add(
        'q307-must-not-accept-complete-private-artifact-load-evidence-inside-static-package',
      );
      decision = GaussPrivateArtifactLoadRealDeviceSmokeGateDecision
          .blockedMissingVerifiedPrivateArtifactEvidence;
    } else {
      rejectionReasons.add(
        'q306-verified-private-artifact-evidence-not-complete-for-q307',
      );
    }

    final loadOrRuntimeMutationAttempted = input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.productionDownloadEnabled ||
        input.modelBinaryBundledInBaseApp ||
        input.realModelDownloadExecuted ||
        input.realShaVerificationExecuted ||
        input.realAtomicMoveExecuted ||
        input.artifactAcceptedForRuntime ||
        input.realPrivateArtifactLoaded ||
        input.modelFormatProbeExecuted ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted;
    if (loadOrRuntimeMutationAttempted) {
      rejectionReasons.add(
        'private-artifact-load-or-runtime-mutation-forbidden-in-q307',
      );
      decision = GaussPrivateArtifactLoadRealDeviceSmokeGateDecision
          .blockedLoadOrRuntimeMutationAttempt;
    }

    final fakePassClaimed = input.privateArtifactLoadPassClaimed ||
        input.modelFormatProbePassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed;
    if (fakePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
      decision = GaussPrivateArtifactLoadRealDeviceSmokeGateDecision
          .blockedFakePassClaim;
    }

    final contractStaticReady = protectedSurfacesOk &&
        !hasCompleteQ306Evidence &&
        !loadOrRuntimeMutationAttempted &&
        !fakePassClaimed &&
        input.q306ShaAtomicMoveGatePresent &&
        input.privateArtifactPathReviewed &&
        input.artifactByteLengthReviewed &&
        input.modelFormatProbePlanReviewed &&
        input.realAndroidDeviceLoadLogRequired &&
        input.loadTimeoutPolicyReviewed &&
        input.memoryPressurePolicyReviewed &&
        input.rollbackPlanPresent &&
        input.defaultOffFeatureFlagPresent;

    return GaussPrivateArtifactLoadRealDeviceSmokeGateResult(
      phase: GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.phase,
      sourcePhase: GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.sourcePhase,
      selectedEngineLabel:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.selectedEngineLabel,
      loadSmokeFeatureFlag:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.loadSmokeFeatureFlag,
      loadSmokeMode: GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.loadSmokeMode,
      readinessState:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: contractStaticReady,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      requiredBeforePrivateArtifactLoadSmoke:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy
              .requiredBeforePrivateArtifactLoadSmoke,
      loadSmokeEnvelopeFields:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.loadSmokeEnvelopeFields,
      loadSmokeStates:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.loadSmokeStates,
      errorCodes: GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.errorCodes,
      protectedSurfaceMarkers:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.protectedSurfaceMarkers,
      forbiddenActions:
          GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy.forbiddenActions,
      privateArtifactLoadSmokeGateDefined: true,
      privateArtifactLoadSmokeDefaultOff: true,
      q306ShaAtomicMoveGatePresent: input.q306ShaAtomicMoveGatePresent,
      q306VerifiedPrivateArtifactPathRecorded:
          input.q306VerifiedPrivateArtifactPathRecorded,
      q306ExpectedActualSha256Match: input.q306ExpectedActualSha256Match,
      q306AtomicMoveSucceeded: input.q306AtomicMoveSucceeded,
      privateArtifactPathReviewed: input.privateArtifactPathReviewed,
      artifactByteLengthReviewed: input.artifactByteLengthReviewed,
      modelFormatProbePlanReviewed: input.modelFormatProbePlanReviewed,
      realAndroidDeviceLoadLogRequired: input.realAndroidDeviceLoadLogRequired,
      loadTimeoutPolicyReviewed: input.loadTimeoutPolicyReviewed,
      memoryPressurePolicyReviewed: input.memoryPressurePolicyReviewed,
      pubspecChanged: input.pubspecChanged,
      androidManifestChanged: input.androidManifestChanged,
      mainActivityChanged: input.mainActivityChanged,
      productionDownloadEnabled: input.productionDownloadEnabled,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      realModelDownloadExecuted: input.realModelDownloadExecuted,
      realShaVerificationExecuted: input.realShaVerificationExecuted,
      realAtomicMoveExecuted: input.realAtomicMoveExecuted,
      artifactAcceptedForRuntime: input.artifactAcceptedForRuntime,
      realPrivateArtifactLoaded: input.realPrivateArtifactLoaded,
      modelFormatProbeExecuted: input.modelFormatProbeExecuted,
      realRuntimeStartupExecuted: input.realRuntimeStartupExecuted,
      realDummyInputRuntimeCallExecuted: input.realDummyInputRuntimeCallExecuted,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      realEditableMathLiveReviewOpened: input.realEditableMathLiveReviewOpened,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      reviewBeforeImportRequired: true,
      explicitUserApprovalRequired: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      privateArtifactLoadPassClaimed: input.privateArtifactLoadPassClaimed,
      modelFormatProbePassClaimed: input.modelFormatProbePassClaimed,
      runtimeIntegrationPassClaimed: input.runtimeIntegrationPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      storeReadyPassClaimed: input.storeReadyPassClaimed,
      releasePassClaimed: input.releasePassClaimed,
    );
  }
}
