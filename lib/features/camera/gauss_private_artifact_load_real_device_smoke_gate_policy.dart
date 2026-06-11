/// V172-Q307 — Private Artifact Load Real Device Smoke Gate.
///
/// This policy defines the package-side contract for the future PP-FormulaNet-S
/// verified private artifact load smoke on a real Android device. It is
/// intentionally static: Q307 does not read a model file, probe model format,
/// start native runtime, call MethodChannel, or run OCR.
class GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy {
  const GaussPrivateArtifactLoadRealDeviceSmokeGatePolicy._();

  static const String phase =
      'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE';
  static const String sourcePhase =
      'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String loadSmokeFeatureFlag =
      'gauss.ppFormulaNetS.privateArtifactLoadRealDeviceSmoke.defaultOff';
  static const String loadSmokeMode =
      'private-artifact-load-real-device-smoke-gate-default-off-no-file-load';
  static const String readinessState =
      'BLOCKED_PENDING_Q306_VERIFIED_PRIVATE_ARTIFACT_AND_REAL_DEVICE_LOAD_EVIDENCE';

  static const List<String> requiredBeforePrivateArtifactLoadSmoke = <String>[
    'q306-verified-private-artifact-path-recorded',
    'q306-expected-actual-sha256-match',
    'q306-atomic-move-succeeded',
    'private-artifact-path-is-app-private',
    'artifact-byte-length-recorded',
    'model-format-probe-plan-present',
    'real-android-device-load-log-required',
    'load-timeout-policy-present',
    'memory-pressure-policy-present',
    'rollback-plan-present',
  ];

  static const List<String> loadSmokeEnvelopeFields = <String>[
    'artifactLocator',
    'verifiedPrivatePath',
    'expectedSha256',
    'actualSha256',
    'byteLength',
    'modelFormatProbeState',
    'loadSmokeState',
    'deviceModel',
    'androidSdk',
    'durationMs',
    'peakMemoryMb',
    'errorCode',
  ];

  static const List<String> loadSmokeStates = <String>[
    'notStarted',
    'blockedMissingVerifiedArtifact',
    'blockedFeatureFlagOff',
    'artifactOpenPending',
    'artifactOpenSucceeded',
    'formatProbePending',
    'formatProbeSucceeded',
    'formatProbeFailed',
    'loadSmokeSucceeded',
    'loadSmokeFailed',
    'cleanupRequired',
  ];

  static const List<String> errorCodes = <String>[
    'featureFlagOff',
    'verifiedArtifactMissing',
    'verifiedArtifactPathUnsafe',
    'shaEvidenceMissing',
    'atomicMoveEvidenceMissing',
    'artifactOpenFailed',
    'modelFormatProbeFailed',
    'loadTimeout',
    'memoryBudgetExceeded',
    'nativeRuntimeNotBound',
  ];

  static const List<String> protectedSurfaceMarkers = <String>[
    'keyboard-layout-preserved',
    'more-template-tray-preserved',
    'long-press-lists-preserved',
    'mathlive-production-route-preserved',
    'mathlive-bridge-preserved',
    'graph-solution-history-preserved',
    'camera-shell-runtime-preserved',
    'android-manifest-mainactivity-preserved',
    'pubspec-preserved',
  ];

  static const List<String> forbiddenActions = <String>[
    'openModelFileInsideQ307Package',
    'probeModelFormatInsideQ307Package',
    'startRuntimeInsideQ307Package',
    'callNativeBridgeInsideQ307Package',
    'addRuntimeDependencyInQ307',
    'modifyMainActivityForRuntimeInQ307',
    'claimPrivateArtifactLoadPassWithoutDeviceEvidence',
    'claimRuntimeOrOcrPassWithoutEvidence',
    'bypassEditableMathLiveReview',
    'directWorkspaceSolveGraphSolutionHistoryFromOcr',
  ];
}
