class GaussRealRuntimeIntegrationEvidenceLockPolicy {
  const GaussRealRuntimeIntegrationEvidenceLockPolicy._();

  static const String phase = 'V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK';
  static const String sourcePhase = 'V172-Q277R3-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-TAP-LATENCY-CADENCE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String evidenceLockMode = 'real-runtime-integration-evidence-lock-only-no-dependency-no-runtime-no-inference';

  static const int maximumAllowedModelSizeMb = 512;
  static const int maximumRuntimeLatencyBudgetMs = 1800;
  static const int maximumRuntimePeakMemoryBudgetMb = 384;

  static const bool realRuntimeIntegrationEvidenceLockImplemented = true;
  static const bool requiresQ277R3TapLatencyCadenceBaseline = true;
  static const bool requiresUserSideFlutterAnalyzeTestClean = true;
  static const bool requiresRealDeviceUiRegressionAccepted = true;
  static const bool requiresOfficialSourceEvidence = true;
  static const bool requiresProductionArtifactUrlEvidence = true;
  static const bool requiresExpectedSha256Evidence = true;
  static const bool requiresLicenseEvidence = true;
  static const bool requiresModelSizeEvidence = true;
  static const bool requiresRuntimePathDecisionEvidence = true;
  static const bool requiresAbiMatrixEvidence = true;
  static const bool requiresAndroidToolchainCompatibilityEvidence = true;
  static const bool requiresPrivateAppStoragePlan = true;
  static const bool requiresChecksumBeforeReady = true;
  static const bool requiresAtomicMoveAfterChecksum = true;
  static const bool requiresOfflineReadyOnlyAfterVerifiedPrivateArtifact = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

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
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool imageToLatexPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredEvidenceLocks = [
    'q277r3TapLatencyCadenceBaselinePresent',
    'userFlutterAnalyzeCleanEvidence',
    'userFlutterTestPassEvidence',
    'realDeviceUiRegressionAcceptedEvidence',
    'officialModelRepositoryEvidence',
    'productionArtifactUrlEvidence',
    'expectedProductionArtifactSha256Evidence',
    'apache2LicenseCompatibilityEvidence',
    'modelStorageSizeEvidence',
    'runtimePathDecisionEvidence',
    'abiMatrixEvidence',
    'androidToolchainCompatibilityEvidence',
    'runtimeLatencyBudgetEvidence',
    'runtimePeakMemoryBudgetEvidence',
    'privateAppStorageDownloadPlan',
    'checksumBeforeReadyGate',
    'atomicMoveAfterChecksumGate',
    'offlineReadyOnlyAfterVerifiedPrivateArtifactGate',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
    'baseApkModelBinaryExclusionEvidence',
    'noRuntimeDependencyAddedBeforeEvidenceLock',
    'noFakeOcrPassClaim',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'officialPPFormulaNetSModelRepositoryUrl',
    'productionArtifactDownloadUrl',
    'expectedProductionArtifactSha256',
    'licenseCompatibilityRecord',
    'modelArtifactSizeRecord',
    'selectedAndroidRuntimePathDecision',
    'supportedAbiMatrixRecord',
    'runtimeMemoryAndLatencyBudgetRecord',
    'privateStorageDownloadAndLoadPlan',
    'userSideFlutterAnalyzeCleanLog',
    'userSideFlutterTestPassLog',
    'realDeviceQ277R3UiAndTapCadenceAcceptance',
    'editableMathLiveReviewEvidence',
    'directSolveGraphSolutionHistoryBlockEvidence',
    'explicitUserApprovalForDependencyTrial',
  ];

  static const List<String> forbiddenActions = [
    'addPaddleRuntimeInQ278',
    'addPaddleOcrDependencyInQ278',
    'addNativeBridgeImplementationInQ278',
    'addJniBindingInQ278',
    'addMethodChannelRuntimeBindingInQ278',
    'bundleModelBinaryInBaseApkInQ278',
    'bindProductionModelUrlInQ278',
    'enableProductionDownloadInQ278',
    'implementRealNetworkDownloaderInQ278',
    'runImageToLatexInferenceInQ278',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCamera',
    'claimRuntimeIntegrationPassWithoutRealRuntimeEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'claimReleasePassWithoutStoreAuditEvidence',
  ];
}
