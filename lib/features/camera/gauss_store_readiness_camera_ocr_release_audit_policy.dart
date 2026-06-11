class GaussStoreReadinessCameraOcrReleaseAuditPolicy {
  const GaussStoreReadinessCameraOcrReleaseAuditPolicy._();

  static const String phase = 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT';
  static const String sourcePhase = 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String auditMode = 'store-readiness-camera-ocr-release-audit-gate-only-no-release-pass';
  static const String releaseFlagName = 'ppFormulaNetSStoreReadinessCameraOcrReleaseAuditEnabled';

  static const int minimumRequiredStoreAuditGates = 44;
  static const int minimumStoreEvidenceFields = 28;
  static const int minimumBlockedEvidenceCount = 26;

  static const bool storeReadinessCameraOcrReleaseAuditImplemented = true;
  static const bool requiresQ286FullCameraOcrRuntimePremiumRegression = true;
  static const bool requiresRealFlutterAnalyzeCleanLog = true;
  static const bool requiresRealFlutterTestPassLog = true;
  static const bool requiresRealFlutterRunDeviceLog = true;
  static const bool requiresRealCameraPreviewCaptureEvidence = true;
  static const bool requiresRealOcrRuntimeEvidenceBeforeOcrClaims = true;
  static const bool requiresModelLicenseEvidence = true;
  static const bool requiresPrivacyPolicyEvidence = true;
  static const bool requiresPlayStoreDataSafetyEvidence = true;
  static const bool reviewBeforeImportStillMandatory = true;
  static const bool explicitUserApprovalStillMandatory = true;
  static const bool workspaceImportAfterApprovalOnly = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool truthfulStoreClaimsOnly = true;

  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool graphRuntimeChanged = false;
  static const bool solutionRuntimeChanged = false;
  static const bool historyRuntimeChanged = false;
  static const bool appShellChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool splashIconChanged = false;

  static const bool playStoreSubmissionExecutedInQ287 = false;
  static const bool releaseCandidateFreezeExecutedInQ287 = false;
  static const bool productionAabBuiltInQ287 = false;
  static const bool productionApkBuiltInQ287 = false;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool realImageToLatexInferenceExecutedInQ287 = false;
  static const bool realWorkspaceImportRuntimeExecutedInQ287 = false;
  static const bool directWorkspaceMutationAllowed = false;
  static const bool directSolveAllowed = false;
  static const bool directGraphAllowed = false;
  static const bool directSolutionHistoryWriteAllowed = false;
  static const bool ocrAccuracyMarketingClaimAllowedWithoutEvidence = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;
  static const bool storeReadyPassClaimed = false;

  static const List<String> requiredStoreAuditGates = [
    'q286FullCameraOcrRuntimePremiumRegressionPresent',
    'q286ProtectedSurfaceRegressionCourtClean',
    'realFlutterAnalyzeCleanLogRequired',
    'realFlutterTestPassLogRequired',
    'realFlutterRunDeviceLogRequired',
    'realCameraPreviewEvidenceRequired',
    'realCameraCaptureEvidenceRequired',
    'realOcrRuntimeEvidenceRequiredBeforeOcrClaims',
    'realImageToLatexEvidenceRequiredBeforeMarketingClaims',
    'playStoreListingCopyTruthful',
    'playStoreScreenshotsDoNotImplyUnprovenOcr',
    'playStoreShortDescriptionDoesNotClaimUnprovenAccuracy',
    'playStoreFullDescriptionDisclosesReviewFirstFlow',
    'cameraPermissionPurposeClear',
    'photoDataHandlingDisclosed',
    'privacyPolicyEvidenceRequired',
    'dataSafetyFormEvidenceRequired',
    'modelLicenseCompatibilityEvidenceRequired',
    'modelArtifactSizeEvidenceRequired',
    'baseApkOrAabSizeBudgetEvidenceRequired',
    'basePackageContainsNoModelBinary',
    'modelDownloadedToPrivateStorageOnlyAfterVerification',
    'offlineOnlineBehaviorDisclosed',
    'crashFreeDeviceSmokeEvidenceRequired',
    'lowEndDevicePerformanceEvidenceRequired',
    'reviewBeforeImportRequired',
    'explicitUserApprovalRequired',
    'workspaceImportOnlyAfterApproval',
    'noDirectWorkspaceMutationFromCamera',
    'noAutoEvaluateFromCamera',
    'noAutoSolveFromCamera',
    'noAutoGraphFromCamera',
    'noAutoSolutionWriteFromCamera',
    'noAutoHistoryWriteFromCamera',
    'manualSolveGraphOnlyAfterFutureImport',
    'keyboardMoreLongPressRegressionEvidenceRequired',
    'mathLiveProductionRouteRegressionEvidenceRequired',
    'graphSolutionHistoryRegressionEvidenceRequired',
    'androidManifestPermissionAuditRequired',
    'mainActivitySplashStartupAuditRequired',
    'noFakeOcrPassClaim',
    'noFakeRuntimePassClaim',
    'noFakePremiumFinalPassClaim',
    'noFakeReleasePassClaim',
  ];

  static const List<String> storeEvidenceFields = [
    'flutterAnalyzeLogReference',
    'flutterTestLogReference',
    'flutterRunDeviceLogReference',
    'deviceModelAndAndroidVersion',
    'appVersionAndPackageName',
    'cameraPreviewCaptureEvidence',
    'mathLiveReviewEvidence',
    'approvedWorkspaceImportBlockEvidence',
    'noAutoSolveGraphHistoryEvidence',
    'playStoreListingDraftReference',
    'shortDescriptionClaimReview',
    'fullDescriptionClaimReview',
    'screenshotSetReference',
    'privacyPolicyReference',
    'dataSafetyFormReference',
    'cameraPermissionDisclosureReference',
    'photoDataRetentionDisclosure',
    'modelLicenseReference',
    'modelArtifactSizeEvidence',
    'baseApkAabSizeEvidence',
    'privateStorageDownloadDisclosure',
    'offlineOnlineBehaviorDisclosure',
    'crashFreeSmokeEvidence',
    'lowEndDeviceSmokeEvidence',
    'keyboardRegressionEvidence',
    'moreLongPressRegressionEvidence',
    'graphSolutionHistoryRegressionEvidence',
    'releaseApprovalOwner',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'realQ286RegressionEvidenceAccepted',
    'realFlutterAnalyzeCleanLog',
    'realFlutterTestPassLog',
    'realFlutterRunDeviceLog',
    'realCameraPreviewEvidence',
    'realCameraCaptureEvidence',
    'realMathLiveReviewEvidence',
    'realNoAutoSolveGraphHistoryEvidence',
    'realModelLicenseEvidence',
    'realPrivacyPolicyEvidence',
    'realDataSafetyEvidence',
    'realPermissionDisclosureEvidence',
    'realBaseApkAabSizeEvidence',
    'realNoBundledModelEvidence',
    'realStoreListingDraftEvidence',
    'realScreenshotSetEvidence',
    'realCrashFreeDeviceEvidence',
    'realLowEndDeviceEvidence',
    'realKeyboardMoreLongPressEvidence',
    'realMathLiveRouteEvidence',
    'realGraphSolutionHistoryEvidence',
    'realOcrRuntimeEvidenceBeforeOcrMarketing',
    'realImageToLatexEvidenceBeforeAccuracyClaim',
    'explicitReleaseApproval',
    'explicitStoreSubmissionApproval',
    'finalHumanReviewOfClaims',
  ];

  static const List<String> forbiddenActions = [
    'submitToPlayStoreInQ287',
    'buildProductionAabInQ287',
    'claimStoreReadyWithoutEvidence',
    'claimReleasePassWithoutEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'claimCameraOcrRuntimePassWithoutRealDeviceEvidence',
    'claimAccuracyPercentageWithoutBenchmarkEvidence',
    'marketPhotomathLevelOcrWithoutEvidence',
    'showScreenshotsImplyingUnprovenOcrAutomation',
    'omitCameraPermissionDisclosure',
    'omitPrivacyPolicyEvidence',
    'omitDataSafetyEvidence',
    'bundleModelBinaryInBaseApk',
    'enableProductionDownloadWithoutLicenseAndShaEvidence',
    'autoImportCameraOutputWithoutReview',
    'autoSolveCameraOutput',
    'autoGraphCameraOutput',
    'autoWriteSolutionOrHistoryFromCameraOutput',
    'changeKeyboardLayoutForStoreAudit',
    'changeMoreOrLongPressForStoreAudit',
    'changeGraphSolutionHistoryForStoreAudit',
    'changeSplashIconForStoreAudit',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
