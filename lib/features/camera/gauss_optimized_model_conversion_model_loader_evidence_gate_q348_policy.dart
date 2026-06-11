class GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy {
  const GaussOptimizedModelConversionModelLoaderEvidenceGateQ348Policy._();

  static const String phase = 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE';
  static const String sourcePhase = 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE';
  static const String status = 'OPTIMIZED_MODEL_CONVERSION_MODEL_LOADER_EVIDENCE_REQUIRED_BEFORE_MODEL_LOAD_DEFAULT_OFF';

  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_BUNDLED_Q344_Q345';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String knownUserArtifactFileName = 'inference.pdiparams';
  static const String knownUserArtifactSha256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int knownUserArtifactSizeBytes = 231675001;
  static const String externalConversionEvidencePolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-PaddleLite-Optimized';

  static const List<String> requiredPriorPhases = <String>[
    'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR',
    'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL',
    'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE',
    'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE',
  ];

  static const List<String> requiredModelConversionEvidence = <String>[
    'source PP-FormulaNet-S artifact hash evidence remains tied to inference.pdiparams',
    'model format accepted for Paddle Lite Android is explicitly identified',
    'Paddle Lite optimized model artifact or model directory evidence is provided outside project root',
    'conversion command and log are provided',
    'converted artifact SHA256 and size are captured before model load',
    'model loader path contract is approved before Q349 real model load smoke',
  ];

  static const List<String> blockedUntilEvidence = <String>[
    'inference.pdiparams-alone-is-not-accepted-as-android-model-loader-proof',
    'inference-pdmodel-or-optimized-nb-model-evidence-is-required',
    'conversion-log-required',
    'converted-model-sha256-required',
    'q349-real-model-load-blocked-until-q348-evidence-accepted',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-model-binary-bundle-in-q348',
    'no-model-loader-implementation-in-q348',
    'no-model-load-in-q348',
    'no-runtime-startup-or-dummy-call-in-q348',
    'no-image-to-latex-inference-in-q348',
    'no-ocr-review-ui-or-workspace-import-in-q348',
    'no-mainactivity-gradle-pubspec-androidmanifest-mutation-in-q348',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
    'no-ocr-pass-claim-without-real-device-evidence',
  ];
}
