import 'gauss_runtime_dependency_real_trial_default_off_policy.dart';

/// V172-Q303 — Runtime Dependency Real Trial Behind Default-Off Flag.
///
/// Evaluates whether the project may proceed from Q302 source/SHA lock toward a
/// real runtime dependency trial. In this package the answer remains blocked:
/// Q302 deliberately kept SHA pending, so no runtime dependency is added.
enum GaussRuntimeDependencyRealTrialDefaultOffDecision {
  realDependencyTrialGateDefinedDefaultOff,
  blockedMissingQ302ArtifactSourceShaLock,
  blockedMissingShaRuntimeAbiLicenseEvidence,
  blockedRuntimeDependencyMutationAttempt,
  blockedProtectedSurfaceRegression,
  blockedFakePassClaim,
}

class GaussRuntimeDependencyRealTrialDefaultOffInput {
  const GaussRuntimeDependencyRealTrialDefaultOffInput({
    required this.q302ArtifactUrlShaLockPresent,
    required this.q302ExpectedSha256,
    required this.q302ActualSha256,
    required this.q302ExpectedSha256Verified,
    required this.q302ActualSha256Computed,
    required this.artifactAcceptedForRuntime,
    required this.runtimeLibraryCandidateEvidencePresent,
    required this.licenseCompatibilityReviewed,
    required this.androidAbiMatrixPresent,
    required this.apkSizeDeltaBudgetReviewed,
    required this.ramLatencyBudgetReviewed,
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
    required this.runtimeDependencyActuallyAdded,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.onnxRuntimeAdded,
    required this.tfliteRuntimeAdded,
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
    required this.runtimeDependencyPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussRuntimeDependencyRealTrialDefaultOffInput.q303Default({
    String trialLabel = 'q303-runtime-dependency-real-trial-default-off',
  }) {
    return GaussRuntimeDependencyRealTrialDefaultOffInput(
      q302ArtifactUrlShaLockPresent: true,
      q302ExpectedSha256: GaussRuntimeDependencyRealTrialDefaultOffPolicy.q302ExpectedSha256State,
      q302ActualSha256: GaussRuntimeDependencyRealTrialDefaultOffPolicy.q302ActualSha256State,
      q302ExpectedSha256Verified: false,
      q302ActualSha256Computed: false,
      artifactAcceptedForRuntime: false,
      runtimeLibraryCandidateEvidencePresent: false,
      licenseCompatibilityReviewed: false,
      androidAbiMatrixPresent: false,
      apkSizeDeltaBudgetReviewed: false,
      ramLatencyBudgetReviewed: false,
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
      runtimeDependencyActuallyAdded: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      onnxRuntimeAdded: false,
      tfliteRuntimeAdded: false,
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
      runtimeDependencyPassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      trialLabel: trialLabel,
    );
  }

  final bool q302ArtifactUrlShaLockPresent;
  final String q302ExpectedSha256;
  final String q302ActualSha256;
  final bool q302ExpectedSha256Verified;
  final bool q302ActualSha256Computed;
  final bool artifactAcceptedForRuntime;
  final bool runtimeLibraryCandidateEvidencePresent;
  final bool licenseCompatibilityReviewed;
  final bool androidAbiMatrixPresent;
  final bool apkSizeDeltaBudgetReviewed;
  final bool ramLatencyBudgetReviewed;
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
  final bool runtimeDependencyActuallyAdded;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool onnxRuntimeAdded;
  final bool tfliteRuntimeAdded;
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
  final bool runtimeDependencyPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussRuntimeDependencyRealTrialDefaultOffResult {
  const GaussRuntimeDependencyRealTrialDefaultOffResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.dependencyTrialFeatureFlag,
    required this.dependencyTrialMode,
    required this.readinessState,
    required this.dependencyDecision,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeRealDependencyAdd,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.runtimeDependencyTrialDefined,
    required this.runtimeDependencyTrialDefaultOff,
    required this.runtimeDependencyActuallyAdded,
    required this.pubspecChanged,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeHandlerImplemented,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.realImageToLatexInferenceExecuted,
    required this.reviewBeforeImportRequired,
    required this.explicitUserApprovalRequired,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.runtimeDependencyPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String dependencyTrialFeatureFlag;
  final String dependencyTrialMode;
  final String readinessState;
  final String dependencyDecision;
  final GaussRuntimeDependencyRealTrialDefaultOffDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeRealDependencyAdd;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool runtimeDependencyTrialDefined;
  final bool runtimeDependencyTrialDefaultOff;
  final bool runtimeDependencyActuallyAdded;
  final bool pubspecChanged;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeHandlerImplemented;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool realImageToLatexInferenceExecuted;
  final bool reviewBeforeImportRequired;
  final bool explicitUserApprovalRequired;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool runtimeDependencyPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussRuntimeDependencyRealTrialDefaultOff {
  const GaussRuntimeDependencyRealTrialDefaultOff._();

  static GaussRuntimeDependencyRealTrialDefaultOffResult evaluate(
    GaussRuntimeDependencyRealTrialDefaultOffInput input,
  ) {
    final rejectionReasons = <String>[];

    if (!input.q302ArtifactUrlShaLockPresent) {
      rejectionReasons.add('q302-artifact-url-sha-lock-required');
    }
    if (input.q302ExpectedSha256 != GaussRuntimeDependencyRealTrialDefaultOffPolicy.q302ExpectedSha256State ||
        input.q302ActualSha256 != GaussRuntimeDependencyRealTrialDefaultOffPolicy.q302ActualSha256State ||
        input.q302ExpectedSha256Verified ||
        input.q302ActualSha256Computed ||
        input.artifactAcceptedForRuntime ||
        input.runtimeLibraryCandidateEvidencePresent ||
        input.licenseCompatibilityReviewed ||
        input.androidAbiMatrixPresent ||
        input.apkSizeDeltaBudgetReviewed ||
        input.ramLatencyBudgetReviewed) {
      rejectionReasons.add('real-runtime-dependency-evidence-not-complete-for-q303');
    }
    if (!input.rollbackPlanPresent || !input.defaultOffFeatureFlagPresent) {
      rejectionReasons.add('rollback-and-default-off-flag-required');
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
    if (input.pubspecChanged ||
        input.runtimeDependencyActuallyAdded ||
        input.paddleRuntimeAdded ||
        input.paddleOcrDependencyAdded ||
        input.onnxRuntimeAdded ||
        input.tfliteRuntimeAdded ||
        input.jniBindingAdded ||
        input.methodChannelRuntimeBindingAdded ||
        input.nativeRuntimeHandlerImplemented ||
        input.modelBinaryBundledInBaseApp ||
        input.productionDownloadEnabled ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted) {
      rejectionReasons.add('runtime-dependency-or-runtime-mutation-forbidden-in-q303');
    }
    if (input.runtimeDependencyPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    return GaussRuntimeDependencyRealTrialDefaultOffResult(
      phase: GaussRuntimeDependencyRealTrialDefaultOffPolicy.phase,
      sourcePhase: GaussRuntimeDependencyRealTrialDefaultOffPolicy.sourcePhase,
      selectedEngineLabel: GaussRuntimeDependencyRealTrialDefaultOffPolicy.selectedEngineLabel,
      dependencyTrialFeatureFlag: GaussRuntimeDependencyRealTrialDefaultOffPolicy.dependencyTrialFeatureFlag,
      dependencyTrialMode: GaussRuntimeDependencyRealTrialDefaultOffPolicy.dependencyTrialMode,
      readinessState: GaussRuntimeDependencyRealTrialDefaultOffPolicy.readinessState,
      dependencyDecision: GaussRuntimeDependencyRealTrialDefaultOffPolicy.dependencyDecision,
      decision: _decisionFor(rejectionReasons),
      contractStaticReady: rejectionReasons.isEmpty,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      requiredBeforeRealDependencyAdd: GaussRuntimeDependencyRealTrialDefaultOffPolicy.requiredBeforeRealDependencyAdd,
      protectedSurfaceMarkers: GaussRuntimeDependencyRealTrialDefaultOffPolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussRuntimeDependencyRealTrialDefaultOffPolicy.forbiddenActions,
      runtimeDependencyTrialDefined: GaussRuntimeDependencyRealTrialDefaultOffPolicy.runtimeDependencyTrialDefined,
      runtimeDependencyTrialDefaultOff: GaussRuntimeDependencyRealTrialDefaultOffPolicy.runtimeDependencyTrialDefaultOff,
      runtimeDependencyActuallyAdded: input.runtimeDependencyActuallyAdded,
      pubspecChanged: input.pubspecChanged,
      paddleRuntimeAdded: input.paddleRuntimeAdded,
      paddleOcrDependencyAdded: input.paddleOcrDependencyAdded,
      methodChannelRuntimeBindingAdded: input.methodChannelRuntimeBindingAdded,
      nativeRuntimeHandlerImplemented: input.nativeRuntimeHandlerImplemented,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: input.productionDownloadEnabled,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      reviewBeforeImportRequired: GaussRuntimeDependencyRealTrialDefaultOffPolicy.reviewBeforeImportRequired,
      explicitUserApprovalRequired: GaussRuntimeDependencyRealTrialDefaultOffPolicy.explicitUserApprovalRequired,
      directSolveGraphSolutionHistoryBlocked: GaussRuntimeDependencyRealTrialDefaultOffPolicy.directSolveGraphSolutionHistoryBlocked,
      runtimeDependencyPassClaimed: input.runtimeDependencyPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      releasePassClaimed: input.releasePassClaimed,
      trialLabel: input.trialLabel,
    );
  }

  static GaussRuntimeDependencyRealTrialDefaultOffDecision _decisionFor(List<String> rejectionReasons) {
    if (rejectionReasons.isEmpty) {
      return GaussRuntimeDependencyRealTrialDefaultOffDecision.realDependencyTrialGateDefinedDefaultOff;
    }
    if (rejectionReasons.contains('q302-artifact-url-sha-lock-required')) {
      return GaussRuntimeDependencyRealTrialDefaultOffDecision.blockedMissingQ302ArtifactSourceShaLock;
    }
    if (rejectionReasons.contains('real-runtime-dependency-evidence-not-complete-for-q303') ||
        rejectionReasons.contains('rollback-and-default-off-flag-required')) {
      return GaussRuntimeDependencyRealTrialDefaultOffDecision.blockedMissingShaRuntimeAbiLicenseEvidence;
    }
    if (rejectionReasons.contains('protected-surface-regression-detected')) {
      return GaussRuntimeDependencyRealTrialDefaultOffDecision.blockedProtectedSurfaceRegression;
    }
    if (rejectionReasons.contains('fake-pass-claim-forbidden')) {
      return GaussRuntimeDependencyRealTrialDefaultOffDecision.blockedFakePassClaim;
    }
    return GaussRuntimeDependencyRealTrialDefaultOffDecision.blockedRuntimeDependencyMutationAttempt;
  }
}
