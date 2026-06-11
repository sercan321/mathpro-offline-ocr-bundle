class GaussCameraOcrRuntimeExecutionBridgeQ361Policy {
  const GaussCameraOcrRuntimeExecutionBridgeQ361Policy._();

  static const String phase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
  static const String sourcePhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
  static const String status = 'CAMERA_OCR_RUNTIME_EXECUTION_BRIDGE_DEFAULT_OFF_NO_AUTO_RUN_REVIEW_APPROVAL_REQUIRED';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> runtimeBridgeRules = <String>[
    'Camera/OCR runtime execution may be orchestrated only through a default-off bridge and explicit invocation.',
    'The bridge must preserve Q357 model-load, Q358 dummy-call, Q359 candidate-envelope, and Q360 editable-review/approved-import guards.',
    'No camera, startup, workspace, Solve, Graph, Solution, or History path may auto-run model-load, dummy runtime call, image-to-LaTeX, review, or import.',
    'Static packages may not claim Flutter, Android, ONNX Runtime, model-load, dummy-call, image-to-LaTeX, review, import, or OCR PASS.',
  ];

  static const List<String> reviewAndImportRules = <String>[
    'Any future candidate must go to editable MathLive review before import.',
    'Workspace import requires explicit user approval.',
    'Approved import prepares expression content only and must not auto-trigger Solve, Graph, Solution, or History.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not change keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not bundle the 308 MB ONNX model in the Flutter project ZIP.',
    'Keep Q361 default-off until real user-side Flutter/Android/model evidence is provided.',
  ];
}
