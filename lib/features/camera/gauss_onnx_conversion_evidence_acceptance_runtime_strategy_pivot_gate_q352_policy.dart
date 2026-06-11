class GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy {
  const GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy._();

  static const String phase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
  static const String sourcePhase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
  static const String status =
      'ONNX_CONVERSION_EVIDENCE_ACCEPTED_RUNTIME_STRATEGY_PIVOT_GATE_DEFAULT_OFF_NO_MODEL_LOAD_NO_OCR';

  static const String externalOnnxArtifactPathPolicy =
      '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String externalOnnxArtifactSha256 =
      '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int externalOnnxArtifactSizeBytes = 308743097;
  static const String externalOnnxArtifactLastWriteTime = '2026-06-07T18:53:33+03:00';
  static const String conversionEnvironment = 'MathProOcrP2OExactEnv';
  static const String conversionPaddleVersion = '3.0.0.dev20250426';
  static const String conversionPaddle2OnnxVersion = '2.1.0';
  static const String conversionModelFilename = 'inference.json';
  static const String conversionParamsFilename = 'inference.pdiparams';
  static const String conversionRequestedOpset = '11';
  static const String conversionObservedOpset = '18';

  static const List<String> acceptedExternalEvidence = <String>[
    'PP-FormulaNet-S official PaddleOCR/PaddleX model downloaded outside the Flutter project',
    'Paddle2ONNX export succeeded using explicit inference.json and inference.pdiparams filenames',
    'pp_formulanet_s.onnx exists outside project root',
    'pp_formulanet_s.onnx SHA256 and byte size captured',
    'ONNX optimizer warning recorded as skipped optimization, not an OCR/runtime PASS',
  ];

  static const List<String> blockedBeforeOnnxRuntimeLoad = <String>[
    'ONNX Runtime Mobile dependency has not been selected or added',
    'ONNX model has not been copied into app-private storage by the app',
    'ONNX model hash has not been verified by Android runtime',
    'ONNX model load has not been attempted on Android',
    'image-to-LaTeX inference has not been executed',
    'editable MathLive OCR review has not been opened',
  ];
}
