class GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy {
  const GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy._();

  static const String phase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
  static const String sourcePhase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
  static const String status = 'FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_GUARD_CANDIDATE_ENVELOPE_PREFLIGHT_DEFAULT_OFF_NO_OCR';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> candidateEnvelopeRules = <String>[
    'Expose only a default-off first real image-to-LaTeX inference guard method.',
    'Do not invoke image-to-LaTeX inference during app startup, camera open, workspace edit, solve, graph, solution, or history flows.',
    'Require explicit bridge invocation, Q358 dummy runtime guard prerequisites, app-private pp_formulanet_s.onnx presence, exact byte size, exact SHA256, and a reviewed image payload before any future inference attempt.',
    'Prepare only a candidate envelope contract; keep editable MathLive review, workspace import, solve, graph, solution, and history blocked until later explicit approval phases.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not touch keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not bundle the 308 MB ONNX model into the Flutter project ZIP.',
    'Do not claim Android, ONNX Runtime, model-load, dummy inference, image-to-LaTeX, or OCR PASS from package-side static checks.',
  ];
}
