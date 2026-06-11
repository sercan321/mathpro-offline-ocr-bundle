class GaussSelectedRuntimeDependencyTrialPolicy {
  const GaussSelectedRuntimeDependencyTrialPolicy._();

  static const String phase = 'V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
  static const String sourcePhase = 'V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String dependencyTrialMode = 'selected-runtime-dependency-trial-default-off-gate-only-no-runtime-no-inference';

  static const int maximumAllowedApkSizeIncreaseMb = 35;
  static const int maximumAllowedNativeAbiCount = 4;

  static const bool selectedRuntimeDependencyTrialImplemented = true;
  static const bool requiresQ278EvidenceLock = true;
  static const bool requiresOfficialDependencyCoordinates = true;
  static const bool requiresPinnedRuntimeDependencyVersion = true;
  static const bool requiresDependencyLicenseCompatibility = true;
  static const bool requiresTransitiveDependencyAudit = true;
  static const bool requiresGradleCompatibilityEvidence = true;
  static const bool requiresAbiPackagingImpactEvidence = true;
  static const bool requiresApkSizeImpactBudget = true;
  static const bool requiresDefaultOffFeatureFlag = true;
  static const bool requiresRuntimeInstantiationBlockedWhenFlagOff = true;
  static const bool requiresRollbackPlan = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool featureFlagEnabledByDefault = false;
  static const bool productionRuntimeInstantiationAllowed = false;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeBridgeImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool runtimeDependencyTrialPassClaimed = false;
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredDependencyTrialGates = [
    'q278EvidenceLockPresent',
    'officialDependencyCoordinatesEvidence',
    'pinnedRuntimeDependencyVersionEvidence',
    'dependencyLicenseCompatibilityEvidence',
    'transitiveDependencyAuditEvidence',
    'gradleCompatibilityEvidence',
    'abiPackagingImpactEvidence',
    'apkSizeImpactBudgetEvidence',
    'defaultOffFeatureFlagRequired',
    'runtimeInstantiationBlockedWhenFlagOff',
    'rollbackPlanRequired',
    'noBaseApkModelBinaryBundling',
    'noProductionModelUrlBinding',
    'noProductionDownloadEnablement',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
    'noRuntimePassClaimWithoutDeviceEvidence',
    'noOcrPassClaimWithoutInferenceEvidence',
    'protectedUiSurfacePreservation',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'officialRuntimeDependencyCoordinates',
    'pinnedRuntimeDependencyVersion',
    'dependencyLicenseCompatibilityRecord',
    'transitiveDependencyAuditRecord',
    'GradleAgpKotlinCompatibilityRecord',
    'supportedAbiPackagingImpactRecord',
    'apkSizeDeltaBudgetRecord',
    'defaultOffFeatureFlagRecord',
    'runtimeInstantiationBlockedWhenFlagOffEvidence',
    'rollbackPlanEvidence',
    'userSideFlutterAnalyzeCleanLog',
    'userSideFlutterTestPassLog',
    'realDeviceQ277R3TapCadenceAcceptance',
    'explicitUserApprovalForDependencyTrial',
  ];

  static const List<String> forbiddenActions = [
    'addRuntimeDependencyWithoutQ278EvidenceLock',
    'enableRuntimeFeatureFlagByDefaultInQ279',
    'instantiateRuntimeWhenFlagOff',
    'addNativeBridgeImplementationInQ279',
    'addJniBindingInQ279',
    'addMethodChannelRuntimeBindingInQ279',
    'bundleModelBinaryInBaseApkInQ279',
    'bindProductionModelUrlInQ279',
    'enableProductionDownloadInQ279',
    'runImageToLatexInferenceInQ279',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCamera',
    'claimRuntimeDependencyTrialPassWithoutRealDeviceEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'claimReleasePassWithoutStoreAuditEvidence',
  ];
}
