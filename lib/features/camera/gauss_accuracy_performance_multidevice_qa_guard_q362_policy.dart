class GaussAccuracyPerformanceMultideviceQaGuardQ362Policy {
  const GaussAccuracyPerformanceMultideviceQaGuardQ362Policy._();

  static const String phase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
  static const String sourcePhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
  static const String reviewAndApprovedImportSourcePhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
  static const String candidateEnvelopeSourcePhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
  static const String status = 'ACCURACY_PERFORMANCE_MULTIDEVICE_QA_GUARD_STATIC_NO_RUNTIME_PASS_NO_UI_CHANGE';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> accuracyGuardRules = <String>[
    'Accuracy may be evaluated only from reviewed OCR candidate envelopes, not from direct camera-to-workspace imports.',
    'Candidate ranking must keep raw candidate, normalized LaTeX, confidence, source image metadata, and rejection reason fields auditable.',
    'No package may claim OCR accuracy PASS before a real-device/user-side sample set is run and preserved as evidence.',
    'Low-confidence or empty candidates must remain blocked from import until editable MathLive review and explicit user approval.',
  ];

  static const List<String> performanceGuardRules = <String>[
    'Latency, memory, and thermal measurements must be captured as evidence before performance PASS can be claimed.',
    'Model-load time, dummy runtime-call time, image-to-LaTeX time, and review/import preparation time must be tracked separately.',
    'No package may claim latency, RAM, thermal, or battery PASS from static verification alone.',
  ];

  static const List<String> multiDeviceGuardRules = <String>[
    'QA must cover the primary physical device plus at least one lower-memory Android profile and one tablet/large-screen profile before multi-device PASS.',
    'ABI, camera permission, private-storage model path, offline behavior, and MathLive review route must be checked per device class.',
    'Failures must route to repair phases and must not be hidden behind OCR PASS wording.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not change keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not auto-run camera OCR, model-load, dummy-call, image-to-LaTeX, review, import, Solve, Graph, Solution, or History from QA guards.',
    'Do not bundle the 308 MB ONNX model in the Flutter project ZIP.',
  ];
}
