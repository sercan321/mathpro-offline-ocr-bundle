/// V172-Q303 — Runtime Dependency Real Trial Behind Default-Off Flag.
///
/// Product-track continuation after Q302. This phase defines the real runtime
/// dependency trial gate for PP-FormulaNet-S, but intentionally keeps the trial
/// default-off and blocked until Q302's artifact SHA is computed and verified.
/// It does not mutate pubspec, add Paddle/PaddleOCR, bind MethodChannel, or run
/// any OCR/runtime path.
class GaussRuntimeDependencyRealTrialDefaultOffPolicy {
  const GaussRuntimeDependencyRealTrialDefaultOffPolicy._();

  static const String phase = 'V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF';
  static const String sourcePhase = 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String dependencyTrialFeatureFlag = 'gauss.ppFormulaNetS.runtimeDependencyRealTrial.defaultOff';
  static const String dependencyTrialMode = 'real-dependency-trial-gate-default-off-no-pubspec-mutation';
  static const String readinessState = 'BLOCKED_PENDING_Q302_CONTROLLED_DOWNLOAD_SHA_AND_RUNTIME_CANDIDATE_EVIDENCE';
  static const String q302ExpectedSha256State = 'PENDING_CONTROLLED_DOWNLOAD_HASH_VERIFICATION';
  static const String q302ActualSha256State = 'NOT_DOWNLOADED_IN_Q302';
  static const String dependencyDecision = 'DO_NOT_ADD_RUNTIME_DEPENDENCY_UNTIL_ARTIFACT_SHA_RUNTIME_ABI_LICENSE_AND_ROLLBACK_EVIDENCE_EXIST';
  static const String candidateRuntimeFamily = 'Paddle runtime candidate behind default-off flag';
  static const String androidAbiPolicy = 'arm64-v8a-first-with-explicit-abi-matrix-before-enable';
  static const String rollbackPolicy = 'remove-dependency-and-disable-flag-without-touching-ui-or-camera-shell';

  static const bool q302ArtifactUrlShaLockRequired = true;
  static const bool q302ExpectedSha256Verified = false;
  static const bool q302ActualSha256Computed = false;
  static const bool artifactAcceptedForRuntime = false;
  static const bool runtimeDependencyTrialDefined = true;
  static const bool runtimeDependencyTrialDefaultOff = true;
  static const bool runtimeDependencyActuallyAdded = false;
  static const bool pubspecChanged = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool onnxRuntimeAdded = false;
  static const bool tfliteRuntimeAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool realPrivateArtifactLoaded = false;
  static const bool realRuntimeStartupExecuted = false;
  static const bool realDummyInputRuntimeCallExecuted = false;
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
  static const bool cameraDependencyChanged = false;
  static const bool androidToolchainChanged = false;

  static const bool reviewBeforeImportRequired = true;
  static const bool explicitUserApprovalRequired = true;
  static const bool directWorkspaceImportBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;

  static const bool flutterAnalyzePassClaimed = false;
  static const bool flutterTestPassClaimed = false;
  static const bool flutterRunPassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool runtimeDependencyPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredBeforeRealDependencyAdd = <String>[
    'q302-controlled-download-log',
    'q302-expected-sha256-locked',
    'q302-actual-sha256-computed',
    'q302-expected-actual-sha256-match',
    'runtime-library-candidate-name-version-source',
    'license-compatibility-review',
    'android-abi-matrix',
    'apk-size-delta-budget',
    'ram-latency-budget',
    'rollback-plan',
    'default-off-feature-flag',
    'real-device-build-log-before-enable',
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
    'addPaddleRuntimeDependencyWithoutQ302Sha',
    'addPaddleOcrDependencyWithoutRuntimeCandidateEvidence',
    'mutatePubspecInQ303',
    'bindMethodChannelRuntimeInQ303',
    'implementNativeRuntimeHandlerInQ303',
    'bundleModelBinaryInBaseApkInQ303',
    'enableProductionDownloadInQ303',
    'runRuntimeStartupInQ303',
    'runImageToLatexInferenceInQ303',
    'openRealMathLiveReviewInQ303',
    'importOcrToWorkspaceInQ303',
    'autoSolveCameraOutput',
    'claimRuntimeDependencyOrOcrPassWithoutEvidence',
  ];
}
