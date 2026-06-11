import 'gauss_real_pp_formulanet_s_artifact_url_sha_lock_policy.dart';

/// V172-Q302 — Real PP-FormulaNet-S Artifact URL + SHA Lock.
///
/// Records official source locators and blocks runtime use until a future
/// controlled download computes and verifies a real SHA256.
enum GaussRealPpFormulaNetSArtifactUrlShaLockDecision {
  artifactSourceLockedShaPending,
  blockedMissingQ301ProductDevelopmentRebase,
  blockedMissingOfficialLocator,
  blockedShaInventedOrAcceptedWithoutDownload,
  blockedRuntimeMutationAttempt,
  blockedProtectedSurfaceRegression,
  blockedFakePassClaim,
}

class GaussRealPpFormulaNetSArtifactUrlShaLockInput {
  const GaussRealPpFormulaNetSArtifactUrlShaLockInput({
    required this.q301ProductDevelopmentTrackActive,
    required this.q301StoreTrackParked,
    required this.huggingFaceRepositoryLocatorRecorded,
    required this.officialBosInferenceLocatorRecorded,
    required this.licenseRecorded,
    required this.modelSizeRecorded,
    required this.expectedSha256,
    required this.actualSha256,
    required this.controlledDownloadPerformed,
    required this.expectedSha256Verified,
    required this.actualSha256Computed,
    required this.artifactAcceptedForRuntime,
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
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeHandlerImplemented,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.lockLabel,
  });

  factory GaussRealPpFormulaNetSArtifactUrlShaLockInput.q302Default({
    String lockLabel = 'q302-real-pp-formulanet-s-artifact-url-sha-lock',
  }) {
    return GaussRealPpFormulaNetSArtifactUrlShaLockInput(
      q301ProductDevelopmentTrackActive: true,
      q301StoreTrackParked: true,
      huggingFaceRepositoryLocatorRecorded: true,
      officialBosInferenceLocatorRecorded: true,
      licenseRecorded: true,
      modelSizeRecorded: true,
      expectedSha256: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.expectedSha256,
      actualSha256: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.actualSha256,
      controlledDownloadPerformed: false,
      expectedSha256Verified: false,
      actualSha256Computed: false,
      artifactAcceptedForRuntime: false,
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
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: false,
      nativeRuntimeHandlerImplemented: false,
      modelBinaryBundledInBaseApp: false,
      productionDownloadEnabled: false,
      realPrivateArtifactLoaded: false,
      realRuntimeStartupExecuted: false,
      realImageToLatexInferenceExecuted: false,
      realEditableMathLiveReviewOpened: false,
      realWorkspaceImportExecuted: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      lockLabel: lockLabel,
    );
  }

  final bool q301ProductDevelopmentTrackActive;
  final bool q301StoreTrackParked;
  final bool huggingFaceRepositoryLocatorRecorded;
  final bool officialBosInferenceLocatorRecorded;
  final bool licenseRecorded;
  final bool modelSizeRecorded;
  final String expectedSha256;
  final String actualSha256;
  final bool controlledDownloadPerformed;
  final bool expectedSha256Verified;
  final bool actualSha256Computed;
  final bool artifactAcceptedForRuntime;
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
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeHandlerImplemented;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String lockLabel;
}

class GaussRealPpFormulaNetSArtifactUrlShaLockResult {
  const GaussRealPpFormulaNetSArtifactUrlShaLockResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.artifactLockFeatureFlag,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.huggingFaceRepositoryLocator,
    required this.officialBosInferenceArtifactLocator,
    required this.recordedLicense,
    required this.documentedModelStorageMb,
    required this.expectedSha256,
    required this.actualSha256,
    required this.shaLockState,
    required this.requiredFutureEvidence,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.controlledDownloadPerformed,
    required this.expectedSha256Verified,
    required this.actualSha256Computed,
    required this.artifactAcceptedForRuntime,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeHandlerImplemented,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.releasePassClaimed,
    required this.lockLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String artifactLockFeatureFlag;
  final String readinessState;
  final GaussRealPpFormulaNetSArtifactUrlShaLockDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final String huggingFaceRepositoryLocator;
  final String officialBosInferenceArtifactLocator;
  final String recordedLicense;
  final int documentedModelStorageMb;
  final String expectedSha256;
  final String actualSha256;
  final String shaLockState;
  final List<String> requiredFutureEvidence;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool controlledDownloadPerformed;
  final bool expectedSha256Verified;
  final bool actualSha256Computed;
  final bool artifactAcceptedForRuntime;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeHandlerImplemented;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool releasePassClaimed;
  final String lockLabel;
}

class GaussRealPpFormulaNetSArtifactUrlShaLock {
  const GaussRealPpFormulaNetSArtifactUrlShaLock._();

  static GaussRealPpFormulaNetSArtifactUrlShaLockResult evaluate(
    GaussRealPpFormulaNetSArtifactUrlShaLockInput input,
  ) {
    final rejectionReasons = <String>[];

    if (!input.q301ProductDevelopmentTrackActive || !input.q301StoreTrackParked) {
      rejectionReasons.add('q301-product-development-track-rebase-store-track-park-required');
    }
    if (!input.huggingFaceRepositoryLocatorRecorded || !input.officialBosInferenceLocatorRecorded || !input.licenseRecorded || !input.modelSizeRecorded) {
      rejectionReasons.add('official-source-license-size-locators-required');
    }
    if (input.expectedSha256 != GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.expectedSha256 || input.actualSha256 != GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.actualSha256) {
      rejectionReasons.add('sha-must-remain-pending-until-controlled-download');
    }
    if (input.controlledDownloadPerformed || input.expectedSha256Verified || input.actualSha256Computed || input.artifactAcceptedForRuntime) {
      rejectionReasons.add('artifact-cannot-be-downloaded-hashed-or-accepted-in-q302');
    }
    if (!input.keyboardLayoutProtected || !input.moreTemplateTrayProtected || !input.longPressListsProtected || !input.mathLiveProductionRouteProtected || !input.mathLiveBridgeProtected || !input.graphSolutionHistoryProtected || !input.appShellWorkspaceProtected || !input.androidManifestMainActivityProtected || !input.cameraShellRuntimeProtected || !input.splashIconProtected) {
      rejectionReasons.add('protected-surface-regression-detected');
    }
    if (input.paddleRuntimeAdded || input.paddleOcrDependencyAdded || input.jniBindingAdded || input.methodChannelRuntimeBindingAdded || input.nativeRuntimeHandlerImplemented || input.modelBinaryBundledInBaseApp || input.productionDownloadEnabled || input.realPrivateArtifactLoaded || input.realRuntimeStartupExecuted || input.realImageToLatexInferenceExecuted || input.realEditableMathLiveReviewOpened || input.realWorkspaceImportExecuted) {
      rejectionReasons.add('runtime-download-model-or-workspace-mutation-forbidden-in-q302');
    }
    if (input.ocrPassClaimed || input.cameraOcrRuntimePassClaimed || input.storeReadyPassClaimed || input.releasePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    final decision = _decisionFor(rejectionReasons);

    return GaussRealPpFormulaNetSArtifactUrlShaLockResult(
      phase: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.phase,
      sourcePhase: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.sourcePhase,
      selectedEngineLabel: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.selectedEngineLabel,
      artifactLockFeatureFlag: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.artifactLockFeatureFlag,
      readinessState: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.readinessState,
      decision: decision,
      contractStaticReady: rejectionReasons.isEmpty,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      huggingFaceRepositoryLocator: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.huggingFaceRepositoryLocator,
      officialBosInferenceArtifactLocator: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.officialBosInferenceArtifactLocator,
      recordedLicense: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.recordedLicense,
      documentedModelStorageMb: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.documentedModelStorageMb,
      expectedSha256: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.expectedSha256,
      actualSha256: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.actualSha256,
      shaLockState: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.shaLockState,
      requiredFutureEvidence: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.requiredFutureEvidence,
      protectedSurfaceMarkers: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussRealPpFormulaNetSArtifactUrlShaLockPolicy.forbiddenActions,
      controlledDownloadPerformed: input.controlledDownloadPerformed,
      expectedSha256Verified: input.expectedSha256Verified,
      actualSha256Computed: input.actualSha256Computed,
      artifactAcceptedForRuntime: input.artifactAcceptedForRuntime,
      paddleRuntimeAdded: input.paddleRuntimeAdded,
      paddleOcrDependencyAdded: input.paddleOcrDependencyAdded,
      methodChannelRuntimeBindingAdded: input.methodChannelRuntimeBindingAdded,
      nativeRuntimeHandlerImplemented: input.nativeRuntimeHandlerImplemented,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: input.productionDownloadEnabled,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      releasePassClaimed: input.releasePassClaimed,
      lockLabel: input.lockLabel,
    );
  }

  static GaussRealPpFormulaNetSArtifactUrlShaLockDecision _decisionFor(List<String> rejectionReasons) {
    if (rejectionReasons.isEmpty) {
      return GaussRealPpFormulaNetSArtifactUrlShaLockDecision.artifactSourceLockedShaPending;
    }
    if (rejectionReasons.contains('q301-product-development-track-rebase-store-track-park-required')) {
      return GaussRealPpFormulaNetSArtifactUrlShaLockDecision.blockedMissingQ301ProductDevelopmentRebase;
    }
    if (rejectionReasons.contains('official-source-license-size-locators-required')) {
      return GaussRealPpFormulaNetSArtifactUrlShaLockDecision.blockedMissingOfficialLocator;
    }
    if (rejectionReasons.contains('sha-must-remain-pending-until-controlled-download') || rejectionReasons.contains('artifact-cannot-be-downloaded-hashed-or-accepted-in-q302')) {
      return GaussRealPpFormulaNetSArtifactUrlShaLockDecision.blockedShaInventedOrAcceptedWithoutDownload;
    }
    if (rejectionReasons.contains('protected-surface-regression-detected')) {
      return GaussRealPpFormulaNetSArtifactUrlShaLockDecision.blockedProtectedSurfaceRegression;
    }
    if (rejectionReasons.contains('fake-pass-claim-forbidden')) {
      return GaussRealPpFormulaNetSArtifactUrlShaLockDecision.blockedFakePassClaim;
    }
    return GaussRealPpFormulaNetSArtifactUrlShaLockDecision.blockedRuntimeMutationAttempt;
  }
}
