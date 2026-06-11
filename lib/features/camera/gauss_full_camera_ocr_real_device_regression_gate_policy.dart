/// V172-Q313 — Full Camera/OCR Real Device Regression Gate.
///
/// Contract/static guard phase only. It consolidates the Q302→Q312
/// PP-FormulaNet-S product-development OCR/runtime chain into a final real
/// device regression gate. Q313 does not run OCR, start native runtime, import
/// workspace content, solve, graph, write Solution/History, or claim PASS.
class GaussFullCameraOcrRealDeviceRegressionGatePolicy {
  const GaussFullCameraOcrRealDeviceRegressionGatePolicy._();

  static const String phase = 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE';
  static const String sourcePhase = 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String fullRegressionFeatureFlag = 'gauss.ppFormulaNetS.fullCameraOcrRealDeviceRegression.defaultOff';
  static const String fullRegressionMode = 'full-camera-ocr-real-device-regression-gate-default-off-no-runtime-execution';
  static const String readinessState = 'BLOCKED_PENDING_REAL_OCR_RUNTIME_DEVICE_EVIDENCE';

  static const bool contractStaticReady = true;
  static const bool fullRegressionGateDefined = true;
  static const bool fullRegressionDefaultOff = true;
  static const bool productDevelopmentTrackActive = true;
  static const bool storeReleaseTrackParked = true;

  static const bool q302ArtifactUrlShaLockGatePresent = true;
  static const bool q303RuntimeDependencyTrialGatePresent = true;
  static const bool q304AndroidNativeBridgeGatePresent = true;
  static const bool q305PrivateModelDownloadWorkerGatePresent = true;
  static const bool q306ShaAtomicMoveGatePresent = true;
  static const bool q307PrivateArtifactLoadGatePresent = true;
  static const bool q308RuntimeStartupGatePresent = true;
  static const bool q309DummyInputRuntimeCallGatePresent = true;
  static const bool q310ImageToLatexInferenceGatePresent = true;
  static const bool q311EditableMathLiveReviewGatePresent = true;
  static const bool q312ApprovedWorkspaceImportGatePresent = true;

  static const bool realModelSha256Verified = false;
  static const bool realRuntimeDependencyAdded = false;
  static const bool nativeMethodChannelBindingImplemented = false;
  static const bool nativeHandlerImplemented = false;
  static const bool realPrivateArtifactLoaded = false;
  static const bool realRuntimeStartupExecuted = false;
  static const bool realDummyInputRuntimeCallExecuted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool realEditableMathLiveReviewOpened = false;
  static const bool realWorkspaceImportExecuted = false;

  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequired = true;
  static const bool directWorkspaceImportBlockedBeforeApproval = true;
  static const bool directEvaluateBlocked = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool manualSolveGraphAfterApprovedImportOnly = true;
  static const bool realAndroidFullRegressionLogRequired = true;
  static const bool protectedSurfaceRegressionBlocked = true;
  static const bool rollbackPolicyPresent = true;
  static const bool timeoutPolicyPresent = true;
  static const bool memoryPressurePolicyPresent = true;

  static const bool pubspecChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool mathLiveBridgeChanged = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool splashIconChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool cameraDependencyChanged = false;
  static const bool androidToolchainChanged = false;

  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool jniNativeHandlerAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool productionDownloadEnabled = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool autoEvaluateEnabled = false;
  static const bool autoSolveGraphSolutionHistoryEnabled = false;
  static const bool solutionHistoryWriteEnabled = false;
  static const bool runtimeIntegrationPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool workspaceImportPassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredRegressionEvidence = [
    'q302-controlled-artifact-url-and-sha-lock-evidence',
    'q303-runtime-dependency-real-trial-device-build-evidence',
    'q304-android-native-bridge-implementation-evidence',
    'q305-private-model-download-worker-evidence',
    'q306-sha-verification-and-atomic-move-evidence',
    'q307-private-artifact-load-real-device-smoke-evidence',
    'q308-runtime-startup-real-device-smoke-evidence',
    'q309-dummy-input-real-runtime-call-evidence',
    'q310-first-image-to-latex-inference-evidence',
    'q311-editable-mathlive-review-ui-evidence',
    'q312-approved-workspace-import-envelope-evidence',
    'flutter-analyze-log',
    'flutter-test-log',
    'flutter-run-real-device-log',
    'camera-permission-flow-real-device-evidence',
    'protected-workspace-keyboard-graph-solution-history-regression-evidence',
  ];

  static const List<String> regressionEnvelopeFields = [
    'regressionRunId',
    'deviceId',
    'androidApiLevel',
    'abi',
    'appPhase',
    'artifactSource',
    'expectedSha256',
    'actualSha256',
    'runtimeCandidate',
    'modelFormatProbeStatus',
    'runtimeStartupStatus',
    'dummyInputCallStatus',
    'imageToLatexInferenceStatus',
    'editableReviewStatus',
    'userApprovalStatus',
    'workspaceImportEnvelopeStatus',
    'directSolveGraphSolutionHistoryStatus',
    'protectedSurfaceRegressionStatus',
    'latencyMs',
    'peakMemoryMb',
    'errorCode',
  ];

  static const List<String> regressionStates = [
    'notStarted',
    'blockedFeatureFlagOff',
    'blockedMissingArtifactShaEvidence',
    'blockedMissingRuntimeDependencyEvidence',
    'blockedMissingNativeBridgeEvidence',
    'blockedMissingPrivateArtifactLoadEvidence',
    'blockedMissingRuntimeStartupEvidence',
    'blockedMissingDummyCallEvidence',
    'blockedMissingImageToLatexEvidence',
    'blockedMissingEditableReviewEvidence',
    'blockedMissingExplicitUserApproval',
    'blockedWorkspaceImportBeforeApproval',
    'regressionEnvelopePrepared',
    'regressionFailed',
  ];

  static const List<String> errorCodes = [
    'featureFlagOff',
    'artifactShaEvidenceMissing',
    'runtimeDependencyEvidenceMissing',
    'nativeBridgeEvidenceMissing',
    'privateArtifactLoadEvidenceMissing',
    'runtimeStartupEvidenceMissing',
    'dummyRuntimeCallEvidenceMissing',
    'imageToLatexInferenceEvidenceMissing',
    'editableReviewEvidenceMissing',
    'explicitUserApprovalMissing',
    'workspaceImportBeforeApprovalBlocked',
    'directSolveGraphSolutionHistoryBlocked',
    'protectedSurfaceRegressionDetected',
    'fakePassClaimBlocked',
  ];

  static const List<String> protectedSurfaceMarkers = [
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'graph-solution-history-preserved',
    'camera-shell-runtime-preserved',
    'workspace-runtime-preserved',
    'android-manifest-mainactivity-preserved',
    'pubspec-preserved',
    'splash-icon-preserved',
  ];

  static const List<String> forbiddenActions = [
    'claimOcrPassInsideQ313Package',
    'claimRuntimePassInsideQ313Package',
    'claimWorkspaceImportPassInsideQ313Package',
    'addPaddleRuntimeInsideQ313Package',
    'modifyMainActivityForRuntimeInsideQ313Package',
    'modifyAndroidManifestForRuntimeInsideQ313Package',
    'mutatePubspecRuntimeDependenciesInsideQ313Package',
    'callMethodChannelInsideQ313Package',
    'invokeNativeRuntimeInsideQ313Package',
    'runImageToLatexInsideQ313Package',
    'openEditableReviewInsideQ313Package',
    'mutateWorkspaceInsideQ313Package',
    'autoSolveGraphSolutionHistoryFromOcrInsideQ313Package',
    'bypassEditableMathLiveReview',
    'bypassExplicitUserApproval',
  ];
}
