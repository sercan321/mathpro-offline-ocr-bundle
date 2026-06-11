import 'gauss_private_model_download_worker_real_implementation_gate_policy.dart';

/// V172-Q305 — Private Model Download Worker Real Implementation Gate.
///
/// Defines the safe worker contract for future PP-FormulaNet-S private model
/// downloads. In this package the worker remains disabled: Q302 has not locked
/// a verified expected/actual SHA pair, so no production download or artifact
/// acceptance can occur.
enum GaussPrivateModelDownloadWorkerRealImplementationGateDecision {
  privateModelDownloadWorkerGateDefinedDefaultOff,
  blockedMissingQ302ShaOrDownloadEvidence,
  blockedProtectedSurfaceRegression,
  blockedDownloadWorkerMutationAttempt,
  blockedFakePassClaim,
}

class GaussPrivateModelDownloadWorkerRealImplementationGateInput {
  const GaussPrivateModelDownloadWorkerRealImplementationGateInput({
    required this.q304NativeBridgeGatePresent,
    required this.q302ExpectedSha256Locked,
    required this.q302ActualSha256Computed,
    required this.q302ExpectedActualSha256Match,
    required this.officialArtifactSourceReviewed,
    required this.licenseCompatibilityReviewed,
    required this.modelSizeBudgetReviewed,
    required this.privateAppStoragePathReviewed,
    required this.userConsentCopyReviewed,
    required this.networkPolicyReviewed,
    required this.atomicMovePolicyReviewed,
    required this.partialDownloadCleanupPolicyReviewed,
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
    required this.networkDownloaderDependencyAdded,
    required this.backgroundWorkerDependencyAdded,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realModelDownloadExecuted,
    required this.actualSha256ComputedInPackage,
    required this.artifactAcceptedForRuntime,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.downloadWorkerImplementationPassClaimed,
    required this.modelDownloadPassClaimed,
    required this.shaVerificationPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussPrivateModelDownloadWorkerRealImplementationGateInput.q305Default({
    String trialLabel = 'q305-private-model-download-worker-real-implementation-gate',
  }) {
    return GaussPrivateModelDownloadWorkerRealImplementationGateInput(
      q304NativeBridgeGatePresent: true,
      q302ExpectedSha256Locked: false,
      q302ActualSha256Computed: false,
      q302ExpectedActualSha256Match: false,
      officialArtifactSourceReviewed: true,
      licenseCompatibilityReviewed: true,
      modelSizeBudgetReviewed: true,
      privateAppStoragePathReviewed: true,
      userConsentCopyReviewed: true,
      networkPolicyReviewed: true,
      atomicMovePolicyReviewed: true,
      partialDownloadCleanupPolicyReviewed: true,
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
      networkDownloaderDependencyAdded: false,
      backgroundWorkerDependencyAdded: false,
      productionDownloadEnabled: false,
      modelBinaryBundledInBaseApp: false,
      realModelDownloadExecuted: false,
      actualSha256ComputedInPackage: false,
      artifactAcceptedForRuntime: false,
      realPrivateArtifactLoaded: false,
      realRuntimeStartupExecuted: false,
      realDummyInputRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      realEditableMathLiveReviewOpened: false,
      realWorkspaceImportExecuted: false,
      downloadWorkerImplementationPassClaimed: false,
      modelDownloadPassClaimed: false,
      shaVerificationPassClaimed: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      trialLabel: trialLabel,
    );
  }

  final bool q304NativeBridgeGatePresent;
  final bool q302ExpectedSha256Locked;
  final bool q302ActualSha256Computed;
  final bool q302ExpectedActualSha256Match;
  final bool officialArtifactSourceReviewed;
  final bool licenseCompatibilityReviewed;
  final bool modelSizeBudgetReviewed;
  final bool privateAppStoragePathReviewed;
  final bool userConsentCopyReviewed;
  final bool networkPolicyReviewed;
  final bool atomicMovePolicyReviewed;
  final bool partialDownloadCleanupPolicyReviewed;
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
  final bool networkDownloaderDependencyAdded;
  final bool backgroundWorkerDependencyAdded;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realModelDownloadExecuted;
  final bool actualSha256ComputedInPackage;
  final bool artifactAcceptedForRuntime;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool downloadWorkerImplementationPassClaimed;
  final bool modelDownloadPassClaimed;
  final bool shaVerificationPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussPrivateModelDownloadWorkerRealImplementationGateResult {
  const GaussPrivateModelDownloadWorkerRealImplementationGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.downloadWorkerFeatureFlag,
    required this.workerImplementationMode,
    required this.readinessState,
    required this.implementationDecision,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeWorkerEnablement,
    required this.workerRequestEnvelopeFields,
    required this.workerProgressEnvelopeFields,
    required this.workerErrorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.privateModelDownloadWorkerGateDefined,
    required this.privateModelDownloadWorkerDefaultOff,
    required this.privateModelDownloadWorkerActuallyImplemented,
    required this.q302ExpectedSha256Locked,
    required this.q302ActualSha256Computed,
    required this.q302ExpectedActualSha256Match,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.networkDownloaderDependencyAdded,
    required this.backgroundWorkerDependencyAdded,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realModelDownloadExecuted,
    required this.actualSha256ComputedInPackage,
    required this.artifactAcceptedForRuntime,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.downloadWorkerImplementationPassClaimed,
    required this.modelDownloadPassClaimed,
    required this.shaVerificationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String downloadWorkerFeatureFlag;
  final String workerImplementationMode;
  final String readinessState;
  final String implementationDecision;
  final GaussPrivateModelDownloadWorkerRealImplementationGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeWorkerEnablement;
  final List<String> workerRequestEnvelopeFields;
  final List<String> workerProgressEnvelopeFields;
  final List<String> workerErrorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool privateModelDownloadWorkerGateDefined;
  final bool privateModelDownloadWorkerDefaultOff;
  final bool privateModelDownloadWorkerActuallyImplemented;
  final bool q302ExpectedSha256Locked;
  final bool q302ActualSha256Computed;
  final bool q302ExpectedActualSha256Match;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool networkDownloaderDependencyAdded;
  final bool backgroundWorkerDependencyAdded;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realModelDownloadExecuted;
  final bool actualSha256ComputedInPackage;
  final bool artifactAcceptedForRuntime;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool downloadWorkerImplementationPassClaimed;
  final bool modelDownloadPassClaimed;
  final bool shaVerificationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussPrivateModelDownloadWorkerRealImplementationGate {
  const GaussPrivateModelDownloadWorkerRealImplementationGate._();

  static GaussPrivateModelDownloadWorkerRealImplementationGateResult evaluate(
    GaussPrivateModelDownloadWorkerRealImplementationGateInput input,
  ) {
    final rejectionReasons = <String>[];

    final protectedSurfacesClean = input.keyboardLayoutProtected &&
        input.moreTemplateTrayProtected &&
        input.longPressListsProtected &&
        input.mathLiveProductionRouteProtected &&
        input.mathLiveBridgeProtected &&
        input.graphSolutionHistoryProtected &&
        input.appShellWorkspaceProtected &&
        input.androidManifestMainActivityProtected &&
        input.cameraShellRuntimeProtected &&
        input.splashIconProtected;

    final evidenceIncomplete = !input.q304NativeBridgeGatePresent ||
        !input.q302ExpectedSha256Locked ||
        !input.q302ActualSha256Computed ||
        !input.q302ExpectedActualSha256Match ||
        !input.officialArtifactSourceReviewed ||
        !input.licenseCompatibilityReviewed ||
        !input.modelSizeBudgetReviewed ||
        !input.privateAppStoragePathReviewed ||
        !input.userConsentCopyReviewed ||
        !input.networkPolicyReviewed ||
        !input.atomicMovePolicyReviewed ||
        !input.partialDownloadCleanupPolicyReviewed ||
        !input.rollbackPlanPresent ||
        !input.defaultOffFeatureFlagPresent;

    if (!protectedSurfacesClean) {
      rejectionReasons.add('protected-surface-regression-forbidden');
    }
    if (evidenceIncomplete) {
      rejectionReasons.add('q302-download-sha-evidence-not-complete-for-q305');
    }

    final forbiddenMutation = input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.networkDownloaderDependencyAdded ||
        input.backgroundWorkerDependencyAdded ||
        input.productionDownloadEnabled ||
        input.modelBinaryBundledInBaseApp ||
        input.realModelDownloadExecuted ||
        input.actualSha256ComputedInPackage ||
        input.artifactAcceptedForRuntime ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted;
    if (forbiddenMutation) {
      rejectionReasons.add('private-model-download-worker-or-runtime-mutation-forbidden-in-q305');
    }

    final fakePass = input.downloadWorkerImplementationPassClaimed ||
        input.modelDownloadPassClaimed ||
        input.shaVerificationPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed;
    if (fakePass) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    GaussPrivateModelDownloadWorkerRealImplementationGateDecision decision;
    if (!protectedSurfacesClean) {
      decision = GaussPrivateModelDownloadWorkerRealImplementationGateDecision.blockedProtectedSurfaceRegression;
    } else if (forbiddenMutation) {
      decision = GaussPrivateModelDownloadWorkerRealImplementationGateDecision.blockedDownloadWorkerMutationAttempt;
    } else if (fakePass) {
      decision = GaussPrivateModelDownloadWorkerRealImplementationGateDecision.blockedFakePassClaim;
    } else if (evidenceIncomplete) {
      decision = GaussPrivateModelDownloadWorkerRealImplementationGateDecision.privateModelDownloadWorkerGateDefinedDefaultOff;
    } else {
      decision = GaussPrivateModelDownloadWorkerRealImplementationGateDecision.blockedMissingQ302ShaOrDownloadEvidence;
      rejectionReasons.add('q305-must-not-accept-complete-download-evidence-inside-static-package');
    }

    return GaussPrivateModelDownloadWorkerRealImplementationGateResult(
      phase: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.phase,
      sourcePhase: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.sourcePhase,
      selectedEngineLabel: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.selectedEngineLabel,
      downloadWorkerFeatureFlag: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.downloadWorkerFeatureFlag,
      workerImplementationMode: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.workerImplementationMode,
      readinessState: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.readinessState,
      implementationDecision: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.implementationDecision,
      decision: decision,
      contractStaticReady: rejectionReasons.isEmpty || decision == GaussPrivateModelDownloadWorkerRealImplementationGateDecision.privateModelDownloadWorkerGateDefinedDefaultOff,
      rejectionReasons: rejectionReasons,
      requiredBeforeWorkerEnablement: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.requiredBeforeWorkerEnablement,
      workerRequestEnvelopeFields: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.workerRequestEnvelopeFields,
      workerProgressEnvelopeFields: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.workerProgressEnvelopeFields,
      workerErrorCodes: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.workerErrorCodes,
      protectedSurfaceMarkers: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussPrivateModelDownloadWorkerRealImplementationGatePolicy.forbiddenActions,
      privateModelDownloadWorkerGateDefined: true,
      privateModelDownloadWorkerDefaultOff: true,
      privateModelDownloadWorkerActuallyImplemented: false,
      q302ExpectedSha256Locked: input.q302ExpectedSha256Locked,
      q302ActualSha256Computed: input.q302ActualSha256Computed,
      q302ExpectedActualSha256Match: input.q302ExpectedActualSha256Match,
      pubspecChanged: input.pubspecChanged,
      androidManifestChanged: input.androidManifestChanged,
      mainActivityChanged: input.mainActivityChanged,
      networkDownloaderDependencyAdded: input.networkDownloaderDependencyAdded,
      backgroundWorkerDependencyAdded: input.backgroundWorkerDependencyAdded,
      productionDownloadEnabled: input.productionDownloadEnabled,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      realModelDownloadExecuted: input.realModelDownloadExecuted,
      actualSha256ComputedInPackage: input.actualSha256ComputedInPackage,
      artifactAcceptedForRuntime: input.artifactAcceptedForRuntime,
      realPrivateArtifactLoaded: input.realPrivateArtifactLoaded,
      realRuntimeStartupExecuted: input.realRuntimeStartupExecuted,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      reviewBeforeImportRequired: true,
      explicitUserApprovalRequired: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      downloadWorkerImplementationPassClaimed: input.downloadWorkerImplementationPassClaimed,
      modelDownloadPassClaimed: input.modelDownloadPassClaimed,
      shaVerificationPassClaimed: input.shaVerificationPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      releasePassClaimed: input.releasePassClaimed,
      trialLabel: input.trialLabel,
    );
  }
}
