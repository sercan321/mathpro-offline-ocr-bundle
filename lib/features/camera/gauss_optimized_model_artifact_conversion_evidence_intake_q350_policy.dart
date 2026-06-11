class GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy {
  const GaussOptimizedModelArtifactConversionEvidenceIntakeQ350Policy._();

  static const String phase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
  static const String sourcePhase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
  static const String status = 'OPTIMIZED_MODEL_ARTIFACT_CONVERSION_EVIDENCE_INTAKE_READY_PENDING_USER_SIDE_CONVERTED_MODEL_EVIDENCE_DEFAULT_OFF';

  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_BUNDLED_Q344_Q345';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String knownUserArtifactFileName = 'inference.pdiparams';
  static const String knownUserArtifactSha256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int knownUserArtifactSizeBytes = 231675001;
  static const String externalOptimizedModelEvidenceRootPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-PaddleLite-Optimized';
  static const String q350PrepareScript = 'tool/prepare_pp_formulanet_s_optimized_model_intake_v172_q350.mjs';
  static const String q350CaptureScript = 'tool/capture_pp_formulanet_s_optimized_model_evidence_v172_q350.mjs';

  static const List<String> requiredBeforeRealModelLoad = <String>[
    'accepted Paddle Lite Android model format evidence',
    'Paddle Lite optimized model artifact or model directory outside project root',
    'conversion command and conversion log',
    'converted model SHA256 and size evidence',
    'approved model-loader path contract',
    'user-side clean Flutter analyze/test/build or run evidence after Q350',
  ];

  static const List<String> intakeArtifacts = <String>[
    'q350_optimized_model_intake_instructions.json',
    'q350_optimized_model_conversion_evidence.json',
    'conversion command/log supplied by user',
    'optimized model directory or .nb artifact supplied by user',
  ];

  static const List<String> hardNonGoals = <String>[
    'no-model-binary-bundle-in-q350',
    'no-model-loader-implementation-in-q350',
    'no-model-load-execution-in-q350',
    'no-runtime-startup-or-dummy-call-in-q350',
    'no-image-to-latex-inference-in-q350',
    'no-ocr-review-ui-or-workspace-import-in-q350',
    'no-mainactivity-gradle-pubspec-androidmanifest-mutation-in-q350',
    'no-workspace-keyboard-more-longpress-mathlive-graph-solution-history-splash-icon-change',
    'no-ocr-pass-claim-without-real-device-evidence',
  ];
}
