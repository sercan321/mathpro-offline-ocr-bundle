class GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy {
  const GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy._();

  static const String phase =
      'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
  static const String sourcePhase =
      'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
  static const String hygieneSourcePhase =
      'V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR';
  static const String status =
      'ONNX_RUNTIME_MOBILE_FEASIBILITY_RECORDED_DEFAULT_OFF_NO_DEPENDENCY_NO_MODEL_LOAD_NO_OCR';

  static const String externalOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String externalOnnxArtifactPathPolicy =
      '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String externalOnnxArtifactSha256 =
      '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int externalOnnxArtifactSizeBytes = 308743097;

  static const List<String> feasibilityQuestions = <String>[
    'Which Android ONNX Runtime Mobile dependency coordinate/version is selected for Q354 build trial?',
    'Which ABIs are packaged by the selected dependency and how do they interact with existing Q344 Paddle Lite ABIs?',
    'How much APK/AAB size does the dependency add before the 308 MB model is handled separately?',
    'Where will the external ONNX model be stored without bundling it into the Flutter project ZIP?',
    'How will Android verify SHA256 before any model-load attempt?',
    'What timeout, memory-pressure, rollback, and default-off guard boundaries must exist before Q356 model-load smoke?',
  ];

  static const List<String> q354EntryRequirements = <String>[
    'Explicit human approval to add an Android ONNX Runtime dependency for build trial',
    'Chosen dependency coordinate/version recorded before Gradle mutation',
    'Default-off feature flag remains off by default',
    'No ONNX model bundle in the project ZIP',
    'No model-load, inference, OCR review, workspace import, Solve, Graph, Solution, or History mutation in Q354',
  ];

  static const List<String> blockedRuntimeActions = <String>[
    'ONNX Runtime dependency has not been added in Q353',
    'ONNX model has not been bundled or copied into app-private storage',
    'ONNX model SHA has not been verified by Android runtime',
    'ONNX model load has not been attempted',
    'dummy input runtime call has not been attempted',
    'real image-to-LaTeX inference has not been executed',
    'editable MathLive OCR review has not been opened',
    'approved workspace import has not been executed',
  ];
}
