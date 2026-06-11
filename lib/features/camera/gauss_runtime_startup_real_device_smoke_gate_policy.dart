/// V172-Q308 — Runtime Startup Real Device Smoke Gate.
///
/// This policy defines the package-side contract for the future PP-FormulaNet-S
/// runtime startup smoke on a real Android device. It is intentionally static:
/// Q308 does not start native runtime, call MethodChannel, load an artifact,
/// warm up a model, or run OCR.
class GaussRuntimeStartupRealDeviceSmokeGatePolicy {
  const GaussRuntimeStartupRealDeviceSmokeGatePolicy._();

  static const String phase =
      'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE';
  static const String sourcePhase =
      'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String runtimeStartupFeatureFlag =
      'gauss.ppFormulaNetS.runtimeStartupRealDeviceSmoke.defaultOff';
  static const String startupSmokeMode =
      'runtime-startup-real-device-smoke-gate-default-off-no-runtime-start';
  static const String readinessState =
      'BLOCKED_PENDING_Q307_PRIVATE_ARTIFACT_LOAD_AND_REAL_DEVICE_RUNTIME_STARTUP_EVIDENCE';

  static const List<String> requiredBeforeRuntimeStartupSmoke = <String>[
    'q307-private-artifact-load-smoke-gate-present',
    'q306-verified-private-artifact-path-recorded',
    'q306-expected-actual-sha256-match',
    'q306-atomic-move-succeeded',
    'q307-real-private-artifact-load-evidence',
    'q307-model-format-probe-evidence',
    'native-runtime-package-selected',
    'android-abi-matrix-reviewed',
    'runtime-startup-timeout-policy-present',
    'runtime-memory-pressure-policy-present',
    'real-android-device-startup-log-required',
    'rollback-plan-present',
  ];

  static const List<String> startupEnvelopeFields = <String>[
    'startupRequestId',
    'verifiedPrivatePath',
    'expectedSha256',
    'actualSha256',
    'modelFormatProbeState',
    'runtimeCandidate',
    'androidAbi',
    'deviceModel',
    'androidSdk',
    'startupState',
    'durationMs',
    'peakMemoryMb',
    'errorCode',
  ];

  static const List<String> startupStates = <String>[
    'notStarted',
    'blockedFeatureFlagOff',
    'blockedMissingVerifiedArtifact',
    'blockedMissingPrivateArtifactLoadEvidence',
    'blockedNativeRuntimeNotBound',
    'startupRequested',
    'startupInProgress',
    'startupSucceeded',
    'startupFailed',
    'startupTimedOut',
    'cleanupRequired',
  ];

  static const List<String> errorCodes = <String>[
    'featureFlagOff',
    'verifiedArtifactMissing',
    'privateArtifactLoadEvidenceMissing',
    'modelFormatProbeEvidenceMissing',
    'nativeRuntimeDependencyMissing',
    'nativeBridgeNotBound',
    'unsupportedAndroidAbi',
    'startupTimeout',
    'memoryBudgetExceeded',
    'runtimeCrash',
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
    'startRuntimeInsideQ308Package',
    'callMethodChannelInsideQ308Package',
    'addRuntimeDependencyInQ308',
    'modifyMainActivityForRuntimeInQ308',
    'modifyAndroidManifestForRuntimeInQ308',
    'loadModelFileInsideQ308Package',
    'warmUpModelInsideQ308Package',
    'runImageToLatexInsideQ308Package',
    'claimRuntimeStartupPassWithoutDeviceEvidence',
    'claimRuntimeOrOcrPassWithoutEvidence',
    'bypassEditableMathLiveReview',
    'directWorkspaceSolveGraphSolutionHistoryFromOcr',
  ];
}
