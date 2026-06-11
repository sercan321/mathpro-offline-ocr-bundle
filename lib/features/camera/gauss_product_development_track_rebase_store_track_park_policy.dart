/// V172-Q301 — Product Development Track Rebase / Store Track Park.
///
/// This is a contract-only rebase after Q299/Q300. It records that store,
/// Play Console, listing, Data Safety, AAB, and release-candidate work is
/// intentionally parked, and the active product-development track returns to
/// real app quality and the PP-FormulaNet-S OCR runtime path. It does not add
/// runtime dependencies, Android bindings, model binaries, store assets, or OCR
/// inference.
class GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy {
  const GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy._();

  static const String phase = 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK';
  static const String sourcePhase = 'V172-Q300-RELEASE-CANDIDATE-FREEZE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String developmentTrackFeatureFlag = 'gauss.productDevelopment.track.rebase.defaultOff';
  static const String activeDevelopmentTrack = 'PRODUCT_DEVELOPMENT_FIRST_STORE_TRACK_PARKED';
  static const String readinessState = 'PRODUCT_DEVELOPMENT_RESUMED_STORE_RELEASE_BLOCKED_PENDING_REAL_APP_AND_OCR_RUNTIME_WORK';

  static const bool storeTrackParked = true;
  static const bool playStorePreparationParked = true;
  static const bool releaseCandidateFreezePreservedAsHistoricalAuditOnly = true;
  static const bool productDevelopmentTrackActive = true;
  static const bool realOcrRuntimeTrackActive = true;
  static const bool premiumUiUxTrackActive = true;
  static const bool deviceQaTrackActive = true;

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

  static const bool storeSubmissionPerformed = false;
  static const bool playConsoleConfigured = false;
  static const bool privacyPolicyWritten = false;
  static const bool dataSafetyFormCompleted = false;
  static const bool releaseAabCreated = false;
  static const bool releaseApkCreated = false;
  static const bool productionReleaseCreated = false;
  static const bool storeListingAssetsCreated = false;
  static const bool localizedStoreListingsCreated = false;

  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool realModelDownloadedAndShaVerified = false;
  static const bool realPrivateArtifactLoaded = false;
  static const bool realRuntimeStartupExecuted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool realEditableMathLiveReviewOpened = false;
  static const bool realWorkspaceImportExecuted = false;
  static const bool autoEvaluateEnabled = false;
  static const bool autoSolveGraphSolutionHistoryEnabled = false;

  static const bool flutterAnalyzePassClaimed = false;
  static const bool flutterTestPassClaimed = false;
  static const bool flutterRunPassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;
  static const bool premiumFinalPassClaimed = false;

  static const List<String> parkedStoreTopics = <String>[
    'play-store-listing',
    'privacy-policy-authoring',
    'data-safety-form',
    'store-screenshots',
    'feature-graphic',
    'closed-testing-track',
    'release-aab-apk',
    'production-release-submission',
  ];

  static const List<String> activeProductTracks = <String>[
    'real-pp-formulanet-s-runtime-source-and-sha-lock',
    'default-off-runtime-dependency-trial',
    'private-model-download-and-sha-verification',
    'private-artifact-load-real-device-smoke',
    'runtime-startup-real-device-smoke',
    'first-real-image-to-latex-inference',
    'ocr-candidate-editable-mathlive-review',
    'approved-ocr-workspace-import',
    'mathlive-input-caret-latency-device-quality',
    'workspace-keyboard-graph-solution-history-premium-qa',
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
    'startPlayStorePreparationInQ301',
    'createPrivacyPolicyOrDataSafetyInQ301',
    'buildReleaseAabOrApkInQ301',
    'submitPlayStoreReleaseInQ301',
    'addPaddleRuntimeDependencyInQ301',
    'bindRuntimeMethodChannelInQ301',
    'implementNativeRuntimeHandlerInQ301',
    'bundlePPFormulaNetSModelInBaseApkInQ301',
    'enableProductionModelDownloadInQ301',
    'runImageToLatexInferenceInQ301',
    'autoImportOcrToWorkspaceWithoutReview',
    'autoSolveCameraOutput',
    'claimStoreReadyReleaseOrOcrPassWithoutEvidence',
  ];
}
