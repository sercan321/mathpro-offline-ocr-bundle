class GaussFirstRealImageToLatexInferenceQ367Policy {
  const GaussFirstRealImageToLatexInferenceQ367Policy._();

  static const String phase = 'V172-Q367-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE';
  static const String sourcePhase = 'V172-Q366-ONNX-DUMMY-INPUT-RUNTIME-CALL-EXECUTION';
  static const String activeProductGatePreservedPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String status = 'FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_EXPLICIT_INVOCATION_ONLY_CANDIDATE_ENVELOPE_NO_AUTO_IMPORT';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String bridgeMethod = 'onnxFirstRealImageToLatexInferenceExecution';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;
  static const String candidateEnvelopeVersion = 'q367-candidate-envelope-v1-explicit-image-inference';
  static const String imageTensorLayoutPolicy = 'nchw-float32-rgb-1x3x224x224-generic-smoke-adapter';
}
