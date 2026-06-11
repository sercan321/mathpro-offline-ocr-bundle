class GaussPrivateModelDownloadShaVerificationRuntimePolicy {
  const GaussPrivateModelDownloadShaVerificationRuntimePolicy._();

  static const String phase = 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME';
  static const String sourcePhase = 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String downloadMode = 'private-model-download-sha-verification-contract-only-no-production-network-no-runtime-load';
  static const String downloadFeatureFlag = 'gauss.ppFormulaNetS.privateModelDownload.defaultOff';
  static const String expectedSha256State = 'PENDING_DOWNLOAD_AND_HASH_VERIFICATION';
  static const String artifactAcceptanceDecision = 'blocked-until-official-url-expected-sha-actual-sha-private-storage-atomic-move-and-user-side-smoke-evidence';
  static const String privateStorageRootPolicy = 'application-private-files-dir-only';
  static const String temporaryArtifactName = 'pp_formulanet_s.pending.download';
  static const String verifiedArtifactName = 'pp_formulanet_s.verified.artifact';
  static const String rollbackMode = 'delete-q291-contract-files-and-private-pending-artifact-without-runtime-state-migration';

  static const int minimumExpectedSha256HexLength = 64;
  static const int maximumModelSizeBudgetMb = 260;
  static const int downloadTimeoutBudgetMs = 30000;
  static const int checksumTimeoutBudgetMs = 12000;
  static const int atomicMoveTimeoutBudgetMs = 3000;
  static const int partialCleanupTimeoutBudgetMs = 1500;

  static const bool q288SourceIntakeRequired = true;
  static const bool q289DependencyTrialDefaultOffRequired = true;
  static const bool q290NativeHandlerSkeletonRequired = true;
  static const bool expectedSha256RequiredBeforeDownloadReady = true;
  static const bool expectedSha256StillPending = true;
  static const bool officialArtifactUrlRequiredBeforeProductionDownload = true;
  static const bool privateAppStorageRequired = true;
  static const bool temporaryDownloadPathRequired = true;
  static const bool checksumBeforeReadyRequired = true;
  static const bool actualSha256MustMatchExpectedSha256 = true;
  static const bool atomicMoveAfterChecksumRequired = true;
  static const bool partialOrCorruptDownloadCleanupRequired = true;
  static const bool neverUseUnverifiedModelRequired = true;
  static const bool offlineReadyOnlyAfterVerifiedArtifact = true;
  static const bool userConsentRequiredBeforeDownload = true;
  static const bool wifiPolicyRequiredBeforeLargeDownload = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;

  static const bool downloadFeatureFlagEnabledByDefault = false;
  static const bool productionDownloadEnabled = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool modelDownloadStarted = false;
  static const bool actualSha256ComputedInPackage = false;
  static const bool artifactSha256Verified = false;
  static const bool artifactAcceptedForRuntime = false;
  static const bool privateArtifactLoadEnabled = false;
  static const bool runtimeInvocationEnabled = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool androidBindingImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool runtimeDependencyAddedToPubspec = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool modelDownloadPassClaimed = false;
  static const bool shaVerificationPassClaimed = false;
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> downloadVerificationPreconditions = [
    'q288-real-artifact-source-intake-present',
    'q289-runtime-dependency-trial-default-off-present',
    'q290-native-runtime-handler-skeleton-present',
    'official-artifact-url-required-before-production-download',
    'expected-sha256-must-be-64-hex-before-ready',
    'download-must-target-private-app-storage-only',
    'temporary-file-required-before-checksum',
    'actual-sha256-must-match-expected-sha256-before-atomic-move',
    'atomic-move-required-after-checksum-pass',
    'partial-or-corrupt-download-cleanup-required',
    'unverified-model-must-never-be-used-by-runtime',
    'offline-ready-only-after-verified-artifact',
    'user-consent-and-wifi-policy-required-before-large-download',
    'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
    'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
  ];

  static const List<String> privateArtifactEnvelopeFields = [
    'artifactId',
    'engineLabel',
    'officialSourceLocator',
    'expectedSha256',
    'actualSha256',
    'temporaryPrivatePath',
    'verifiedPrivatePath',
    'downloadBytes',
    'checksumStatus',
    'atomicMoveStatus',
    'offlineReady',
    'runtimeAccepted',
  ];

  static const List<String> downloadErrorCodes = [
    'downloadFeatureFlagOff',
    'officialUrlMissing',
    'expectedSha256Missing',
    'expectedSha256Invalid',
    'userConsentMissing',
    'wifiPolicyBlocked',
    'downloadTimeout',
    'checksumTimeout',
    'artifactShaMismatch',
    'atomicMoveFailed',
    'partialDownloadCleanupFailed',
    'privateStorageUnavailable',
  ];

  static const List<String> forbiddenActions = [
    'enable-production-download-without-expected-sha',
    'bind-production-model-url-in-q291',
    'start-network-download-in-q291',
    'bundle-pp-formulanet-s-model-in-base-apk-in-q291',
    'use-unverified-model-for-runtime',
    'add-paddle-runtime-dependency-in-q291',
    'add-paddleocr-dependency-in-q291',
    'add-jni-binding-in-q291',
    'add-methodchannel-runtime-binding-in-q291',
    'run-image-to-latex-inference-in-q291',
    'import-camera-output-without-mathlive-review',
    'auto-solve-camera-output',
    'auto-graph-camera-output',
    'auto-write-solution-or-history-from-camera',
    'claim-model-download-pass-without-real-download-log',
    'claim-sha-verification-pass-without-actual-hash-evidence',
    'claim-ocr-pass-without-real-inference-evidence',
  ];

  static const List<String> blockedDependencyFamilies = [
    'paddleocr',
    'paddle_ocr',
    'paddle_flutter',
    'paddle_lite',
    'onnxruntime',
    'tesseract',
    'pix2text',
    'flutter_downloader',
    'background_downloader',
    'dio',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
