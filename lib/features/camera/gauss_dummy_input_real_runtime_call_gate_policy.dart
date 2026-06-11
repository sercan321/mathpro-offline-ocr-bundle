/// V172-Q309 — Dummy Input Real Runtime Call Gate.
///
/// This policy defines the package-side contract for a future first dummy
/// PP-FormulaNet-S runtime call on a real Android device. It is intentionally
/// static: Q309 does not call MethodChannel, invoke native runtime, parse a
/// dummy response, load an image, or run OCR.
class GaussDummyInputRealRuntimeCallGatePolicy {
  const GaussDummyInputRealRuntimeCallGatePolicy._();

  static const String phase =
      'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
  static const String sourcePhase =
      'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String dummyInputRuntimeCallFeatureFlag =
      'gauss.ppFormulaNetS.dummyInputRuntimeCall.defaultOff';
  static const String dummyInputCallMode =
      'dummy-input-real-runtime-call-gate-default-off-no-runtime-call';
  static const String readinessState =
      'BLOCKED_PENDING_Q308_RUNTIME_STARTUP_AND_NATIVE_CALL_EVIDENCE';

  static const List<String> requiredBeforeDummyInputRuntimeCall = <String>[
    'q308-runtime-startup-smoke-gate-present',
    'q308-real-runtime-startup-evidence',
    'q308-runtime-startup-succeeded',
    'native-runtime-method-channel-bound',
    'native-handler-implemented',
    'dummy-input-fixture-defined',
    'dummy-input-payload-sha256-recorded',
    'real-android-device-dummy-call-log-required',
    'runtime-call-timeout-policy-present',
    'runtime-call-cancellation-policy-present',
    'runtime-memory-pressure-policy-present',
    'rollback-plan-present',
  ];

  static const List<String> dummyCallEnvelopeFields = <String>[
    'dummyCallRequestId',
    'verifiedPrivatePath',
    'runtimeStartupEvidenceId',
    'dummyInputFixtureId',
    'dummyInputPayloadSha256',
    'androidAbi',
    'deviceModel',
    'androidSdk',
    'callState',
    'durationMs',
    'peakMemoryMb',
    'nativeResultKind',
    'errorCode',
  ];

  static const List<String> dummyCallStates = <String>[
    'notStarted',
    'blockedFeatureFlagOff',
    'blockedMissingRuntimeStartupEvidence',
    'blockedNativeBridgeNotBound',
    'dummyCallRequested',
    'dummyCallInProgress',
    'dummyCallSucceeded',
    'dummyCallFailed',
    'dummyCallTimedOut',
    'cleanupRequired',
  ];

  static const List<String> errorCodes = <String>[
    'featureFlagOff',
    'runtimeStartupEvidenceMissing',
    'nativeBridgeNotBound',
    'dummyFixtureMissing',
    'dummyPayloadHashMissing',
    'dummyCallTimeout',
    'memoryBudgetExceeded',
    'runtimeCrash',
    'unexpectedNativeResult',
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
    'callMethodChannelInsideQ309Package',
    'invokeNativeRuntimeInsideQ309Package',
    'implementNativeHandlerInsideQ309Package',
    'addRuntimeDependencyInQ309',
    'modifyMainActivityForRuntimeInQ309',
    'modifyAndroidManifestForRuntimeInQ309',
    'sendCameraImageInsideQ309Package',
    'runImageToLatexInsideQ309Package',
    'claimDummyRuntimeCallPassWithoutDeviceEvidence',
    'claimRuntimeOrOcrPassWithoutEvidence',
    'bypassEditableMathLiveReview',
    'directWorkspaceSolveGraphSolutionHistoryFromOcr',
  ];
}
