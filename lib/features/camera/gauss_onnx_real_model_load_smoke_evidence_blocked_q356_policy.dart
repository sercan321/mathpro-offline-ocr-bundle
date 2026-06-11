class GaussOnnxRealModelLoadSmokeEvidenceBlockedQ356Policy {
  const GaussOnnxRealModelLoadSmokeEvidenceBlockedQ356Policy._();

  static const String phase =
      'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
  static const String sourcePhase =
      'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION';
  static const String dependencyTrialSourcePhase =
      'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
  static const String feasibilitySourcePhase =
      'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
  static const String onnxConversionEvidenceSourcePhase =
      'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
  static const String hygieneSourcePhase =
      'V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR';
  static const String status =
      'ONNX_REAL_MODEL_LOAD_SMOKE_RECORDED_BUT_BLOCKED_PENDING_USER_SIDE_DEPENDENCY_BUILD_LOGS_NO_LOAD_NO_OCR';

  static const String selectedDependencyCoordinate =
      'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy =
      '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 =
      '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> blockers = <String>[
    'User-side Q354/Q355 flutter pub get/analyze/test/run logs are required because Q354 added the real ONNX Runtime Android dependency.',
    'The external pp_formulanet_s.onnx artifact must be available outside the project and must match the expected size and SHA256 before any copy/load action.',
    'The model may not be bundled into the Flutter project ZIP.',
    'MainActivity must not receive ONNX Runtime model-load calls until the dependency build trial has real user-side evidence.',
  ];

  static const List<String> redLines = <String>[
    'No ONNX model bundling.',
    'No app-private model copy in this phase.',
    'No on-device SHA verification in assistant environment.',
    'No OrtEnvironment, OnnxTensor, or Java/Kotlin model-load call added.',
    'No runtime startup, dummy call, image-to-LaTeX inference, OCR review, workspace import, Solve, Graph, Solution, or History.',
  ];

  static const List<String> nextPhaseRequirements = <String>[
    'User must provide Q354/Q355 or Q356 flutter pub get/analyze/test/run logs.',
    'If dependency resolution/build succeeds, a future execution phase may add a default-off real model-load smoke bridge.',
    'If dependency resolution/build fails, the next phase must be a surgical dependency/build repair, not OCR.',
  ];
}
