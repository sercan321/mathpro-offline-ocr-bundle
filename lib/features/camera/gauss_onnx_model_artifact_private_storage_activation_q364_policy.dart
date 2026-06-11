class GaussOnnxModelArtifactPrivateStorageActivationQ364Policy {
  const GaussOnnxModelArtifactPrivateStorageActivationQ364Policy._();

  static const String phase = 'V172-Q364-ONNX-MODEL-ARTIFACT-PRIVATE-STORAGE-ACTIVATION';
  static const String sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String runtimeBridgeSourcePhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
  static const String status = 'ONNX_MODEL_ARTIFACT_PRIVATE_STORAGE_ACTIVATION_EXPLICIT_INVOCATION_ONLY_NO_AUTO_RUN_NO_OCR';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String bridgeMethod = 'onnxModelArtifactPrivateStorageActivation';

  static const List<String> activationRules = <String>[
    'The ONNX artifact may be copied into app-private storage only by explicit bridge invocation.',
    'The bridge must validate file name, byte size, and SHA256 before private-storage readiness is accepted.',
    'The 308 MB ONNX artifact must not be bundled into the Flutter project ZIP.',
    'A valid private-storage artifact only unlocks later model-load smoke; it is not OCR PASS.',
  ];

  static const List<String> safetyRules = <String>[
    'No startup, camera, workspace, Solve, Graph, Solution, or History path may auto-copy, auto-load, or auto-run OCR.',
    'Editable MathLive review and explicit user approval remain mandatory before any future workspace import.',
    'Missing, oversized, undersized, or bad-SHA ONNX artifacts must keep model-load blocked.',
    'The package must not claim Android, model-load, image-to-LaTeX, OCR, store, or release PASS from this static phase.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not change keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not mutate Gradle, pubspec, or AndroidManifest in Q364.',
    'MainActivity may change only for the explicit private-storage activation bridge.',
  ];
}
