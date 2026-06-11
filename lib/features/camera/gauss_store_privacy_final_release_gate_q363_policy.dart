class GaussStorePrivacyFinalReleaseGateQ363Policy {
  const GaussStorePrivacyFinalReleaseGateQ363Policy._();

  static const String phase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String sourcePhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
  static const String runtimeBridgeSourcePhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
  static const String reviewAndApprovedImportSourcePhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
  static const String candidateEnvelopeSourcePhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
  static const String status = 'STORE_PRIVACY_FINAL_RELEASE_GATE_STATIC_BLOCKED_NO_STORE_READY_PASS_NO_RUNTIME_PASS';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> storePrivacyRules = <String>[
    'Store/privacy readiness is a gate, not a release PASS claim.',
    'Camera permission, offline OCR processing, model storage, and user-data handling must be documented before store submission.',
    'No package may claim Play Store, App Store, privacy, data-safety, or release readiness without user-side Flutter/Android and OCR evidence.',
    'The 308 MB ONNX model must remain outside the project ZIP unless a later explicit packaging policy changes it.',
  ];

  static const List<String> dataSafetyRules = <String>[
    'OCR/camera data must not be described as uploaded unless a future implementation really uploads it.',
    'Offline/private-storage behavior must remain auditable through model path, SHA, size, and deletion/repair evidence.',
    'Model download/storage/cleanup policy must be reviewed before any store-ready claim.',
    'Crash, permission denial, missing model, bad SHA, low-memory, and thermal failure paths must be represented in release evidence.',
  ];

  static const List<String> finalReleaseRules = <String>[
    'Release may not be marked final until flutter pub get, flutter analyze, flutter test, and flutter run pass on a real user device.',
    'Release may not be marked final until ONNX Runtime dependency resolution, model-load, dummy call, image-to-LaTeX, editable review, approved import, accuracy, performance, and multi-device evidence are provided.',
    'Direct OCR-to-workspace, OCR-to-Solve, OCR-to-Graph, OCR-to-Solution, and OCR-to-History remain blocked.',
    'Editable MathLive review and explicit user approval remain mandatory before workspace import.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not change keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not auto-run camera OCR, model-load, dummy-call, image-to-LaTeX, review, import, Solve, Graph, Solution, or History from release gates.',
    'Do not claim store-ready, release-ready, premium-final, OCR, ONNX Runtime, model-load, or Android PASS from static verification.',
  ];
}
