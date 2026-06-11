class GaussOnnxDummyInputRuntimeCallExecutionQ366Policy {
  const GaussOnnxDummyInputRuntimeCallExecutionQ366Policy._();

  static const String phase = 'V172-Q366-ONNX-DUMMY-INPUT-RUNTIME-CALL-EXECUTION';
  static const String sourcePhase = 'V172-Q365-ONNX-REAL-MODEL-LOAD-SMOKE-EXECUTION';
  static const String activeProductGatePreservedPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String status = 'ONNX_DUMMY_INPUT_RUNTIME_CALL_EXECUTION_EXPLICIT_INVOCATION_ONLY_NO_AUTO_RUN_NO_OCR';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String bridgeMethod = 'onnxDummyInputRuntimeCallExecution';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;
  static const String dummyInputTensorShapePolicy = 'minimal-scalar-float-placeholder-for-smoke-only';
}
