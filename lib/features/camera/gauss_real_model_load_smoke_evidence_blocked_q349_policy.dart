class GaussRealModelLoadSmokeEvidenceBlockedQ349Policy {
  const GaussRealModelLoadSmokeEvidenceBlockedQ349Policy._();

  static const String phase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
  static const String sourcePhase = 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE';
  static const String status = 'REAL_MODEL_LOAD_SMOKE_BLOCKED_PENDING_Q348_CONVERSION_AND_MODEL_LOADER_EVIDENCE_DEFAULT_OFF';

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
    'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE',
  ];

  static const List<String> requiredBeforeRealModelLoad = <String>[
    'accepted Paddle Lite Android model format evidence',
    'Paddle Lite optimized model artifact or model directory outside project root',
    'conversion command and conversion log',
    'converted model SHA256 and size evidence',
    'approved model-loader path contract',
    'user-side clean Flutter analyze/test/build or run evidence after Q348',
  ];

  static const List<String> blockedReasons = <String>[
    'q348-conversion-evidence-not-provided',
    'model-loader-path-not-approved',
    'optimized-model-artifact-not-provided',
    'inference-pdiparams-alone-not-accepted-for-paddle-lite-android-model-load',
    'q349-real-model-load-not-executed-in-this-package',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-model-binary-bundle-in-q349',
    'no-model-loader-implementation-in-q349',
    'no-model-load-execution-in-q349',
    'no-runtime-startup-or-dummy-call-in-q349',
    'no-image-to-latex-inference-in-q349',
    'no-ocr-review-ui-or-workspace-import-in-q349',
    'no-mainactivity-gradle-pubspec-androidmanifest-mutation-in-q349',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
    'no-ocr-pass-claim-without-real-device-evidence',
  ];
}
