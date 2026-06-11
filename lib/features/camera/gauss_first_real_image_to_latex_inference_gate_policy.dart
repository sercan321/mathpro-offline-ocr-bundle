/// V172-Q310 — First Real Image-to-LaTeX Inference Gate.
///
/// This policy defines the package-side contract for a future first real
/// PP-FormulaNet-S image-to-LaTeX inference on a real Android device. It is
/// intentionally static: Q310 does not call MethodChannel, invoke native
/// runtime, send camera image bytes, parse a LaTeX response, open MathLive
/// review, or run OCR.
class GaussFirstRealImageToLatexInferenceGatePolicy {
  const GaussFirstRealImageToLatexInferenceGatePolicy._();

  static const String phase =
      'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
  static const String sourcePhase =
      'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L only';
  static const String imageToLatexInferenceFeatureFlag =
      'gauss.ppFormulaNetS.firstImageToLatexInference.defaultOff';
  static const String inferenceMode =
      'first-real-image-to-latex-inference-gate-default-off-no-inference';
  static const String readinessState =
      'BLOCKED_PENDING_Q309_DUMMY_RUNTIME_CALL_AND_NATIVE_IMAGE_INFERENCE_EVIDENCE';

  static const List<String> requiredBeforeImageToLatexInference = <String>[
    'q309-dummy-input-runtime-call-gate-present',
    'q309-real-dummy-runtime-call-evidence',
    'q309-dummy-runtime-call-succeeded',
    'native-runtime-method-channel-bound',
    'native-handler-implemented',
    'verified-private-artifact-path-present',
    'cropped-image-fixture-defined',
    'cropped-image-sha256-recorded',
    'crop-preprocess-metadata-recorded',
    'real-android-device-inference-log-required',
    'inference-timeout-policy-present',
    'inference-cancellation-policy-present',
    'runtime-memory-pressure-policy-present',
    'rollback-plan-present',
    'editable-mathlive-review-required',
    'explicit-user-approval-required',
  ];

  static const List<String> imageToLatexEnvelopeFields = <String>[
    'inferenceRequestId',
    'dummyRuntimeCallEvidenceId',
    'verifiedPrivatePath',
    'croppedImageSha256',
    'cropBox',
    'preprocessProfileId',
    'androidAbi',
    'deviceModel',
    'androidSdk',
    'inferenceState',
    'candidateLatex',
    'alternativeLatexCandidates',
    'confidence',
    'warnings',
    'durationMs',
    'peakMemoryMb',
    'errorCode',
  ];

  static const List<String> inferenceStates = <String>[
    'notStarted',
    'blockedFeatureFlagOff',
    'blockedMissingDummyRuntimeCallEvidence',
    'blockedNativeBridgeNotBound',
    'blockedMissingImageFixture',
    'inferenceRequested',
    'inferenceInProgress',
    'inferenceCandidateProduced',
    'inferenceFailed',
    'inferenceTimedOut',
    'cleanupRequired',
  ];

  static const List<String> errorCodes = <String>[
    'featureFlagOff',
    'dummyRuntimeCallEvidenceMissing',
    'nativeBridgeNotBound',
    'croppedImageFixtureMissing',
    'croppedImageShaMissing',
    'preprocessMetadataMissing',
    'imageToLatexTimeout',
    'memoryBudgetExceeded',
    'runtimeCrash',
    'invalidLatexCandidate',
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
    'callMethodChannelInsideQ310Package',
    'invokeNativeRuntimeInsideQ310Package',
    'sendCameraImageToNativeRuntimeInsideQ310Package',
    'parseRuntimeLatexResponseInsideQ310Package',
    'openMathLiveReviewInsideQ310Package',
    'importWorkspaceInsideQ310Package',
    'addRuntimeDependencyInQ310',
    'modifyMainActivityForRuntimeInQ310',
    'modifyAndroidManifestForRuntimeInQ310',
    'claimImageToLatexPassWithoutDeviceEvidence',
    'claimRuntimeOrOcrPassWithoutEvidence',
    'bypassEditableMathLiveReview',
    'directWorkspaceSolveGraphSolutionHistoryFromOcr',
  ];
}
