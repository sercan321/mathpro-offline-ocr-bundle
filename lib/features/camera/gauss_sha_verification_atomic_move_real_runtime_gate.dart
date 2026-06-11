import 'gauss_sha_verification_atomic_move_real_runtime_gate_policy.dart';

/// V172-Q306 — SHA Verification + Atomic Move Real Runtime Gate.
///
/// Package-side gate only. It defines how a future verified PP-FormulaNet-S
/// artifact may be promoted from a temporary private file to a verified private
/// artifact path. No real SHA computation, file move, runtime startup, or OCR is
/// performed in this phase.
enum GaussShaVerificationAtomicMoveRealRuntimeGateDecision {
  shaVerificationAtomicMoveGateDefinedDefaultOff,
  blockedMissingQ302ShaOrQ305DownloadEvidence,
  blockedProtectedSurfaceRegression,
  blockedVerificationOrRuntimeMutationAttempt,
  blockedFakePassClaim,
}

class GaussShaVerificationAtomicMoveRealRuntimeGateInput {
  const GaussShaVerificationAtomicMoveRealRuntimeGateInput({
    required this.q305DownloadWorkerGatePresent,
    required this.q302ExpectedSha256Locked,
    required this.q302ActualSha256Computed,
    required this.q302ExpectedActualSha256Match,
    required this.temporaryPrivatePathReviewed,
    required this.verifiedPrivatePathReviewed,
    required this.checksumBeforeReadyPolicyReviewed,
    required this.atomicMoveAfterChecksumPolicyReviewed,
    required this.partialCorruptCleanupPolicyReviewed,
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
    required this.actualSha256ComputedInPackage,
    required this.shaVerificationExecutedInPackage,
    required this.atomicMoveExecutedInPackage,
    required this.artifactAcceptedForRuntime,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.shaVerificationPassClaimed,
    required this.atomicMovePassClaimed,
    required this.modelReadyPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussShaVerificationAtomicMoveRealRuntimeGateInput.q306Default({
    String trialLabel = 'q306-sha-verification-atomic-move-real-runtime-gate',
  }) {
    return GaussShaVerificationAtomicMoveRealRuntimeGateInput(
      q305DownloadWorkerGatePresent: true,
      q302ExpectedSha256Locked: false,
      q302ActualSha256Computed: false,
      q302ExpectedActualSha256Match: false,
      temporaryPrivatePathReviewed: true,
      verifiedPrivatePathReviewed: true,
      checksumBeforeReadyPolicyReviewed: true,
      atomicMoveAfterChecksumPolicyReviewed: true,
      partialCorruptCleanupPolicyReviewed: true,
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
      actualSha256ComputedInPackage: false,
      shaVerificationExecutedInPackage: false,
      atomicMoveExecutedInPackage: false,
      artifactAcceptedForRuntime: false,
      realPrivateArtifactLoaded: false,
      realRuntimeStartupExecuted: false,
      realDummyInputRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      realEditableMathLiveReviewOpened: false,
      realWorkspaceImportExecuted: false,
      shaVerificationPassClaimed: false,
      atomicMovePassClaimed: false,
      modelReadyPassClaimed: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      trialLabel: trialLabel,
    );
  }

  final bool q305DownloadWorkerGatePresent;
  final bool q302ExpectedSha256Locked;
  final bool q302ActualSha256Computed;
  final bool q302ExpectedActualSha256Match;
  final bool temporaryPrivatePathReviewed;
  final bool verifiedPrivatePathReviewed;
  final bool checksumBeforeReadyPolicyReviewed;
  final bool atomicMoveAfterChecksumPolicyReviewed;
  final bool partialCorruptCleanupPolicyReviewed;
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
  final bool actualSha256ComputedInPackage;
  final bool shaVerificationExecutedInPackage;
  final bool atomicMoveExecutedInPackage;
  final bool artifactAcceptedForRuntime;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool shaVerificationPassClaimed;
  final bool atomicMovePassClaimed;
  final bool modelReadyPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussShaVerificationAtomicMoveRealRuntimeGateResult {
  const GaussShaVerificationAtomicMoveRealRuntimeGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.verificationFeatureFlag,
    required this.verificationMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeArtifactReady,
    required this.verificationEnvelopeFields,
    required this.atomicMoveStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.shaVerificationAtomicMoveGateDefined,
    required this.shaVerificationAtomicMoveDefaultOff,
    required this.q305DownloadWorkerGatePresent,
    required this.q302ExpectedSha256Locked,
    required this.q302ActualSha256Computed,
    required this.q302ExpectedActualSha256Match,
    required this.temporaryPrivatePathReviewed,
    required this.verifiedPrivatePathReviewed,
    required this.checksumBeforeReadyPolicyReviewed,
    required this.atomicMoveAfterChecksumPolicyReviewed,
    required this.partialCorruptCleanupPolicyReviewed,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realModelDownloadExecuted,
    required this.actualSha256ComputedInPackage,
    required this.shaVerificationExecutedInPackage,
    required this.atomicMoveExecutedInPackage,
    required this.artifactAcceptedForRuntime,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.shaVerificationPassClaimed,
    required this.atomicMovePassClaimed,
    required this.modelReadyPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String verificationFeatureFlag;
  final String verificationMode;
  final String readinessState;
  final GaussShaVerificationAtomicMoveRealRuntimeGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeArtifactReady;
  final List<String> verificationEnvelopeFields;
  final List<String> atomicMoveStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool shaVerificationAtomicMoveGateDefined;
  final bool shaVerificationAtomicMoveDefaultOff;
  final bool q305DownloadWorkerGatePresent;
  final bool q302ExpectedSha256Locked;
  final bool q302ActualSha256Computed;
  final bool q302ExpectedActualSha256Match;
  final bool temporaryPrivatePathReviewed;
  final bool verifiedPrivatePathReviewed;
  final bool checksumBeforeReadyPolicyReviewed;
  final bool atomicMoveAfterChecksumPolicyReviewed;
  final bool partialCorruptCleanupPolicyReviewed;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realModelDownloadExecuted;
  final bool actualSha256ComputedInPackage;
  final bool shaVerificationExecutedInPackage;
  final bool atomicMoveExecutedInPackage;
  final bool artifactAcceptedForRuntime;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool shaVerificationPassClaimed;
  final bool atomicMovePassClaimed;
  final bool modelReadyPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
}

class GaussShaVerificationAtomicMoveRealRuntimeGate {
  const GaussShaVerificationAtomicMoveRealRuntimeGate._();

  static GaussShaVerificationAtomicMoveRealRuntimeGateResult evaluate(
    GaussShaVerificationAtomicMoveRealRuntimeGateInput input,
  ) {
    final rejectionReasons = <String>[];
    var decision = GaussShaVerificationAtomicMoveRealRuntimeGateDecision
        .shaVerificationAtomicMoveGateDefinedDefaultOff;

    if (!input.q305DownloadWorkerGatePresent ||
        !input.temporaryPrivatePathReviewed ||
        !input.verifiedPrivatePathReviewed ||
        !input.checksumBeforeReadyPolicyReviewed ||
        !input.atomicMoveAfterChecksumPolicyReviewed ||
        !input.partialCorruptCleanupPolicyReviewed ||
        !input.rollbackPlanPresent ||
        !input.defaultOffFeatureFlagPresent) {
      rejectionReasons.add('q306-required-verification-and-atomic-move-policy-evidence-missing');
      decision = GaussShaVerificationAtomicMoveRealRuntimeGateDecision
          .blockedMissingQ302ShaOrQ305DownloadEvidence;
    }

    if (!input.q302ExpectedSha256Locked ||
        !input.q302ActualSha256Computed ||
        !input.q302ExpectedActualSha256Match) {
      rejectionReasons.add('q302-q305-download-sha-evidence-not-complete-for-q306');
    } else {
      rejectionReasons.add('q306-must-not-accept-complete-sha-evidence-inside-static-package');
      decision = GaussShaVerificationAtomicMoveRealRuntimeGateDecision
          .blockedMissingQ302ShaOrQ305DownloadEvidence;
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
      decision = GaussShaVerificationAtomicMoveRealRuntimeGateDecision
          .blockedProtectedSurfaceRegression;
    }

    final mutationAttempted = input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.productionDownloadEnabled ||
        input.modelBinaryBundledInBaseApp ||
        input.realModelDownloadExecuted ||
        input.actualSha256ComputedInPackage ||
        input.shaVerificationExecutedInPackage ||
        input.atomicMoveExecutedInPackage ||
        input.artifactAcceptedForRuntime ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted;
    if (mutationAttempted) {
      rejectionReasons.add('sha-verification-atomic-move-or-runtime-mutation-forbidden-in-q306');
      decision = GaussShaVerificationAtomicMoveRealRuntimeGateDecision
          .blockedVerificationOrRuntimeMutationAttempt;
    }

    final fakePassClaimed = input.shaVerificationPassClaimed ||
        input.atomicMovePassClaimed ||
        input.modelReadyPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed;
    if (fakePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
      decision = GaussShaVerificationAtomicMoveRealRuntimeGateDecision
          .blockedFakePassClaim;
    }

    final contractStaticReady = decision ==
            GaussShaVerificationAtomicMoveRealRuntimeGateDecision
                .shaVerificationAtomicMoveGateDefinedDefaultOff &&
        input.q305DownloadWorkerGatePresent &&
        input.temporaryPrivatePathReviewed &&
        input.verifiedPrivatePathReviewed &&
        input.checksumBeforeReadyPolicyReviewed &&
        input.atomicMoveAfterChecksumPolicyReviewed &&
        input.partialCorruptCleanupPolicyReviewed &&
        input.rollbackPlanPresent &&
        input.defaultOffFeatureFlagPresent &&
        !input.q302ExpectedSha256Locked &&
        !input.q302ActualSha256Computed &&
        !input.q302ExpectedActualSha256Match &&
        !mutationAttempted &&
        !fakePassClaimed;

    return GaussShaVerificationAtomicMoveRealRuntimeGateResult(
      phase: GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.phase,
      sourcePhase: GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.sourcePhase,
      selectedEngineLabel:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.selectedEngineLabel,
      verificationFeatureFlag:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.verificationFeatureFlag,
      verificationMode:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.verificationMode,
      readinessState:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: contractStaticReady,
      rejectionReasons: rejectionReasons,
      requiredBeforeArtifactReady:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.requiredBeforeArtifactReady,
      verificationEnvelopeFields:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.verificationEnvelopeFields,
      atomicMoveStates:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.atomicMoveStates,
      errorCodes: GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.errorCodes,
      protectedSurfaceMarkers:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.protectedSurfaceMarkers,
      forbiddenActions:
          GaussShaVerificationAtomicMoveRealRuntimeGatePolicy.forbiddenActions,
      shaVerificationAtomicMoveGateDefined: true,
      shaVerificationAtomicMoveDefaultOff: true,
      q305DownloadWorkerGatePresent: input.q305DownloadWorkerGatePresent,
      q302ExpectedSha256Locked: input.q302ExpectedSha256Locked,
      q302ActualSha256Computed: input.q302ActualSha256Computed,
      q302ExpectedActualSha256Match: input.q302ExpectedActualSha256Match,
      temporaryPrivatePathReviewed: input.temporaryPrivatePathReviewed,
      verifiedPrivatePathReviewed: input.verifiedPrivatePathReviewed,
      checksumBeforeReadyPolicyReviewed: input.checksumBeforeReadyPolicyReviewed,
      atomicMoveAfterChecksumPolicyReviewed:
          input.atomicMoveAfterChecksumPolicyReviewed,
      partialCorruptCleanupPolicyReviewed:
          input.partialCorruptCleanupPolicyReviewed,
      pubspecChanged: input.pubspecChanged,
      androidManifestChanged: input.androidManifestChanged,
      mainActivityChanged: input.mainActivityChanged,
      productionDownloadEnabled: input.productionDownloadEnabled,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      realModelDownloadExecuted: input.realModelDownloadExecuted,
      actualSha256ComputedInPackage: input.actualSha256ComputedInPackage,
      shaVerificationExecutedInPackage: input.shaVerificationExecutedInPackage,
      atomicMoveExecutedInPackage: input.atomicMoveExecutedInPackage,
      artifactAcceptedForRuntime: input.artifactAcceptedForRuntime,
      realPrivateArtifactLoaded: input.realPrivateArtifactLoaded,
      realRuntimeStartupExecuted: input.realRuntimeStartupExecuted,
      realDummyInputRuntimeCallExecuted: input.realDummyInputRuntimeCallExecuted,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      realEditableMathLiveReviewOpened: input.realEditableMathLiveReviewOpened,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      reviewBeforeImportRequired: true,
      explicitUserApprovalRequired: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      shaVerificationPassClaimed: input.shaVerificationPassClaimed,
      atomicMovePassClaimed: input.atomicMovePassClaimed,
      modelReadyPassClaimed: input.modelReadyPassClaimed,
      runtimeIntegrationPassClaimed: input.runtimeIntegrationPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      storeReadyPassClaimed: input.storeReadyPassClaimed,
      releasePassClaimed: input.releasePassClaimed,
    );
  }
}
