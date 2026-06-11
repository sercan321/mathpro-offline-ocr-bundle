/// V172-Q302 — Real PP-FormulaNet-S Artifact URL + SHA Lock.
///
/// Contract-only source/SHA evidence phase after Q301. It locks the official
/// PP-FormulaNet-S source locators and records the SHA gap honestly: no model
/// is downloaded, no hash is invented, and no runtime is allowed to consume an
/// artifact until a controlled download computes and verifies the real SHA256.
class GaussRealPpFormulaNetSArtifactUrlShaLockPolicy {
  const GaussRealPpFormulaNetSArtifactUrlShaLockPolicy._();

  static const String phase = 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK';
  static const String sourcePhase = 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String artifactLockFeatureFlag = 'gauss.ppFormulaNetS.artifactUrlShaLock.defaultOff';
  static const String readinessState = 'BLOCKED_PENDING_CONTROLLED_DOWNLOAD_AND_REAL_SHA256_VERIFICATION';

  static const String huggingFaceRepositoryLocator = 'hf://PaddlePaddle/PP-FormulaNet-S';
  static const String officialDocsModelName = 'PP-FormulaNet-S';
  static const String officialBosInferenceArtifactLocator = 'bos://paddle-model-ecology.bj.bcebos.com/paddlex/official_inference_model/paddle3.0.0/PP-FormulaNet-S_infer.tar';
  static const String officialBosTrainingArtifactLocator = 'bos://paddle-model-ecology.bj.bcebos.com/paddlex/official_pretrained_model/PP-FormulaNet-S_pretrained.pdparams';
  static const String recordedLicense = 'apache-2.0';
  static const String recordedLibraryName = 'PaddleOCR';
  static const String modelFormatCandidate = 'Paddle inference tar candidate';
  static const int documentedModelStorageMb = 224;
  static const double documentedGpuInferenceMs = 182.25;
  static const double documentedCpuInferenceMs = 254.39;

  static const String expectedSha256 = 'PENDING_CONTROLLED_DOWNLOAD_HASH_VERIFICATION';
  static const String actualSha256 = 'NOT_DOWNLOADED_IN_Q302';
  static const String shaLockState = 'URL_LOCKED_SHA_PENDING_NO_ARTIFACT_ACCEPTED';
  static const String shaBlockedReason = 'Official source locators are recorded, but Q302 intentionally does not download the artifact or invent SHA256. Future Q303/Q304+ must compute SHA256 from a controlled download before enabling runtime use.';

  static const bool officialSourceLocatorRecorded = true;
  static const bool officialBosInferenceLocatorRecorded = true;
  static const bool officialHuggingFaceLocatorRecorded = true;
  static const bool licenseRecorded = true;
  static const bool modelSizeRecorded = true;
  static const bool expectedSha256Verified = false;
  static const bool actualSha256Computed = false;
  static const bool artifactAcceptedForRuntime = false;
  static const bool controlledDownloadPerformed = false;
  static const bool productionDownloadEnabled = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool realPrivateArtifactLoaded = false;
  static const bool realRuntimeStartupExecuted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool realEditableMathLiveReviewOpened = false;
  static const bool realWorkspaceImportExecuted = false;

  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool mathLiveBridgeChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool splashIconChanged = false;
  static const bool pubspecChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidToolchainChanged = false;

  static const bool flutterAnalyzePassClaimed = false;
  static const bool flutterTestPassClaimed = false;
  static const bool flutterRunPassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredFutureEvidence = <String>[
    'controlled-download-command-or-worker-log',
    'downloaded-private-temp-file-path',
    'actual-sha256-of-downloaded-artifact',
    'expected-sha256-locked-from-controlled-download',
    'expected-actual-sha256-match',
    'artifact-size-bytes',
    'license-compatibility-review',
    'model-format-probe',
    'android-abi-runtime-compatibility-review',
    'private-app-storage-final-path',
    'checksum-pass-before-atomic-move',
    'offline-ready-only-after-verified-artifact',
  ];

  static const List<String> protectedSurfaceMarkers = <String>[
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'graph-solution-history-preserved',
    'app-shell-workspace-preserved',
    'android-manifest-mainactivity-preserved',
    'camera-shell-runtime-preserved',
    'splash-icon-preserved',
  ];

  static const List<String> forbiddenActions = <String>[
    'inventSha256InQ302',
    'downloadModelArtifactInQ302',
    'acceptArtifactForRuntimeWithoutShaMatch',
    'addPaddleRuntimeDependencyInQ302',
    'addPaddleOcrDependencyInQ302',
    'bindMethodChannelRuntimeInQ302',
    'implementNativeRuntimeHandlerInQ302',
    'bundleModelBinaryInBaseApkInQ302',
    'enableProductionModelDownloadInQ302',
    'runImageToLatexInferenceInQ302',
    'openRealMathLiveReviewInQ302',
    'importOcrToWorkspaceInQ302',
    'autoSolveCameraOutput',
    'claimOcrOrRuntimePassWithoutEvidence',
  ];
}
