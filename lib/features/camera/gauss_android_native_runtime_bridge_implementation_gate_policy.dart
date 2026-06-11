/// V172-Q304 — Android Native Runtime Bridge Implementation Gate.
///
/// Product-track continuation after Q303. This phase defines the Android native
/// runtime bridge implementation gate for PP-FormulaNet-S, but intentionally
/// blocks real binding because Q302's artifact SHA and Q303's runtime dependency
/// evidence are still incomplete. It does not modify MainActivity, AndroidManifest,
/// pubspec, MathLive, camera shell, or any protected UI/runtime surface.
class GaussAndroidNativeRuntimeBridgeImplementationGatePolicy {
  const GaussAndroidNativeRuntimeBridgeImplementationGatePolicy._();

  static const String phase = 'V172-Q304-ANDROID-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-GATE';
  static const String sourcePhase = 'V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String methodChannelName = 'com.mathpro.gauss/pp_formulanet_s_runtime';
  static const String nativeHandlerName = 'GaussPpFormulaNetSRuntimeHandler';
  static const String bridgeFeatureFlag = 'gauss.ppFormulaNetS.androidNativeRuntimeBridge.defaultOff';
  static const String bridgeImplementationMode = 'implementation-gate-default-off-no-mainactivity-binding';
  static const String readinessState = 'BLOCKED_PENDING_Q302_SHA_AND_Q303_RUNTIME_DEPENDENCY_EVIDENCE';
  static const String implementationDecision = 'DO_NOT_BIND_ANDROID_NATIVE_RUNTIME_BRIDGE_UNTIL_ARTIFACT_SHA_DEPENDENCY_ABI_LICENSE_AND_DEVICE_EVIDENCE_EXIST';
  static const String androidBindingTarget = 'MainActivity MethodChannel binding remains reserved but not implemented in Q304';
  static const String rollbackPolicy = 'disable-flag-and-remove-future-bridge-without-touching-keyboard-mathlive-camera-ui';

  static const bool q303RuntimeDependencyTrialRequired = true;
  static const bool q302ExpectedSha256Verified = false;
  static const bool q302ActualSha256Computed = false;
  static const bool runtimeDependencyActuallyAdded = false;
  static const bool artifactAcceptedForRuntime = false;
  static const bool androidNativeRuntimeBridgeGateDefined = true;
  static const bool androidNativeRuntimeBridgeDefaultOff = true;
  static const bool androidNativeRuntimeBridgeActuallyImplemented = false;
  static const bool methodChannelNameReserved = true;
  static const bool nativeHandlerNameReserved = true;
  static const bool mainActivityBindingAdded = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool pubspecChanged = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool nativeRuntimeHandlerImplemented = false;
  static const bool gradleNativeRuntimeDependencyAdded = false;
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
  static const bool splashIconChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidToolchainChanged = false;

  static const bool reviewBeforeImportRequired = true;
  static const bool explicitUserApprovalRequired = true;
  static const bool directWorkspaceImportBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool rollbackRequiredBeforeActivation = true;

  static const bool flutterAnalyzePassClaimed = false;
  static const bool flutterTestPassClaimed = false;
  static const bool flutterRunPassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool nativeBridgeImplementationPassClaimed = false;
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredBeforeBridgeImplementation = <String>[
    'q302-controlled-download-log',
    'q302-expected-sha256-locked',
    'q302-actual-sha256-computed',
    'q302-expected-actual-sha256-match',
    'q303-real-runtime-dependency-version-source',
    'q303-runtime-dependency-build-evidence',
    'license-compatibility-review',
    'android-abi-matrix',
    'method-channel-contract-review',
    'mainactivity-binding-diff-review',
    'rollback-plan',
    'default-off-feature-flag',
    'real-device-build-log-before-enable',
  ];

  static const List<String> requestEnvelopeFields = <String>[
    'requestId',
    'croppedImagePrivatePath',
    'croppedImageSha256',
    'verifiedArtifactPrivatePath',
    'expectedArtifactSha256',
    'actualArtifactSha256',
    'androidAbi',
    'runtimeFeatureFlagEnabled',
    'reviewOnlyMode',
    'timeoutMs',
  ];

  static const List<String> responseEnvelopeFields = <String>[
    'requestId',
    'status',
    'primaryLatexCandidate',
    'alternativeLatexCandidates',
    'confidence',
    'latencyMs',
    'peakMemoryMb',
    'reviewRequired',
    'directWorkspaceMutationAttempted',
    'errorCode',
  ];

  static const List<String> bridgeErrorCodes = <String>[
    'runtimeFeatureFlagOff',
    'nativeBridgeNotImplemented',
    'methodChannelNotBound',
    'artifactShaMismatch',
    'verifiedArtifactMissing',
    'unsupportedAbi',
    'runtimeDependencyMissing',
    'timeout',
    'memoryPressure',
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
    'modifyMainActivityInQ304',
    'modifyAndroidManifestInQ304',
    'mutatePubspecInQ304',
    'bindMethodChannelRuntimeWithoutQ302Q303Evidence',
    'implementNativeHandlerWithoutRuntimeDependencyEvidence',
    'addPaddleRuntimeDependencyInQ304',
    'bundleModelBinaryInBaseApkInQ304',
    'enableProductionDownloadInQ304',
    'runRuntimeStartupInQ304',
    'runImageToLatexInferenceInQ304',
    'openRealMathLiveReviewInQ304',
    'importOcrToWorkspaceInQ304',
    'autoSolveCameraOutput',
    'claimNativeBridgeOrOcrPassWithoutEvidence',
  ];
}
