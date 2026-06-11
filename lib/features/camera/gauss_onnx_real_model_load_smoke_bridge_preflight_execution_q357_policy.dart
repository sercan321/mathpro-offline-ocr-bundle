class GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy {
  const GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy._();

  static const String phase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
  static const String sourcePhase = 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD';
  static const String status = 'ONNX_REAL_MODEL_LOAD_SMOKE_BRIDGE_PRESENT_DEFAULT_OFF_NO_AUTO_EXECUTION_NO_OCR';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> runtimeBridgeRules = <String>[
    'Expose only a default-off ONNX model-load smoke bridge method.',
    'Do not invoke model-load during app startup, camera open, workspace edit, solve, graph, solution, or history flows.',
    'Require app-private pp_formulanet_s.onnx presence, exact byte size, and exact SHA256 before any model-load attempt.',
    'Keep OCR, dummy runtime call, image-to-LaTeX inference, MathLive review, and workspace import blocked.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not touch keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not bundle the 308 MB ONNX model into the Flutter project ZIP.',
    'Do not claim Android, ONNX Runtime, model-load, inference, or OCR PASS from package-side static checks.',
  ];
}
