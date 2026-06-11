/// V172-Q305 — Private Model Download Worker Real Implementation Gate.
///
/// Product-track continuation after Q304. This phase defines the future
/// app-private PP-FormulaNet-S download worker implementation contract, but it
/// intentionally keeps the worker disabled because Q302's expected/actual SHA
/// evidence is still pending and no production artifact may be accepted yet.
class GaussPrivateModelDownloadWorkerRealImplementationGatePolicy {
  const GaussPrivateModelDownloadWorkerRealImplementationGatePolicy._();

  static const String phase = 'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE';
  static const String sourcePhase = 'V172-Q304-ANDROID-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String downloadWorkerFeatureFlag = 'gauss.ppFormulaNetS.privateModelDownloadWorker.defaultOff';
  static const String workerImplementationMode = 'implementation-gate-default-off-no-production-download';
  static const String readinessState = 'BLOCKED_PENDING_Q302_EXPECTED_ACTUAL_SHA_AND_CONTROLLED_DOWNLOAD_EVIDENCE';
  static const String implementationDecision = 'DO_NOT_ENABLE_PRIVATE_MODEL_DOWNLOAD_WORKER_UNTIL_EXPECTED_SHA_ACTUAL_SHA_SOURCE_LICENSE_SIZE_AND_USER_CONSENT_EVIDENCE_EXIST';

  static const List<String> requiredBeforeWorkerEnablement = <String>[
    'q302-controlled-download-log',
    'q302-expected-sha256-locked',
    'q302-actual-sha256-computed',
    'q302-expected-actual-sha256-match',
    'official-artifact-source-reviewed',
    'license-compatibility-reviewed',
    'model-size-budget-reviewed',
    'private-app-storage-path-reviewed',
    'user-consent-large-download-copy-reviewed',
    'wifi-or-metered-network-policy-reviewed',
    'atomic-move-after-checksum-policy-reviewed',
    'partial-corrupt-download-cleanup-policy-reviewed',
    'rollback-plan',
    'default-off-feature-flag',
  ];

  static const List<String> workerRequestEnvelopeFields = <String>[
    'requestId',
    'artifactLocator',
    'expectedSha256',
    'temporaryPrivatePath',
    'verifiedPrivatePath',
    'allowMeteredNetwork',
    'requiresUserConsent',
    'timeoutMs',
  ];

  static const List<String> workerProgressEnvelopeFields = <String>[
    'requestId',
    'status',
    'bytesDownloaded',
    'totalBytesExpected',
    'actualSha256SoFar',
    'temporaryPrivatePath',
    'verifiedPrivatePath',
    'errorCode',
  ];

  static const List<String> workerErrorCodes = <String>[
    'featureFlagOff',
    'expectedShaMissing',
    'artifactLocatorMissing',
    'userConsentMissing',
    'meteredNetworkBlocked',
    'downloadTimeout',
    'checksumMismatch',
    'atomicMoveFailed',
    'partialDownloadCleanupFailed',
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
    'enableProductionDownloadInQ305',
    'addNetworkDownloaderDependencyInQ305',
    'addBackgroundWorkerDependencyInQ305',
    'mutatePubspecInQ305',
    'modifyAndroidManifestInQ305',
    'modifyMainActivityInQ305',
    'downloadModelWithoutExpectedSha',
    'acceptArtifactWithoutChecksumMatch',
    'bundleModelBinaryInBaseApkInQ305',
    'loadPrivateArtifactInQ305',
    'runRuntimeStartupInQ305',
    'runImageToLatexInferenceInQ305',
    'openRealMathLiveReviewInQ305',
    'importOcrToWorkspaceInQ305',
    'autoSolveCameraOutput',
    'claimDownloadShaRuntimeOrOcrPassWithoutEvidence',
  ];
}
