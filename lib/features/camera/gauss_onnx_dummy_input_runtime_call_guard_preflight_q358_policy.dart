class GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy {
  const GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy._();

  static const String phase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
  static const String sourcePhase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
  static const String status = 'ONNX_DUMMY_INPUT_RUNTIME_CALL_GUARD_PRESENT_DEFAULT_OFF_NO_AUTO_EXECUTION_NO_OCR';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> dummyRuntimeCallRules = <String>[
    'Expose only a default-off ONNX dummy input runtime call guard method.',
    'Do not invoke dummy runtime call during app startup, camera open, workspace edit, solve, graph, solution, or history flows.',
    'Require explicit bridge invocation, Q357 model-load guard prerequisites, app-private pp_formulanet_s.onnx presence, exact byte size, and exact SHA256 before any future dummy call attempt.',
    'Keep real image-to-LaTeX inference, editable MathLive review, workspace import, solve, graph, solution, and history blocked.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not touch keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not bundle the 308 MB ONNX model into the Flutter project ZIP.',
    'Do not claim Android, ONNX Runtime, model-load, dummy inference, image-to-LaTeX, or OCR PASS from package-side static checks.',
  ];
}
