class GaussOnnxRealModelLoadSmokeExecutionQ365Policy {
  const GaussOnnxRealModelLoadSmokeExecutionQ365Policy._();

  static const String phase = 'V172-Q365-ONNX-REAL-MODEL-LOAD-SMOKE-EXECUTION';
  static const String sourcePhase = 'V172-Q364-ONNX-MODEL-ARTIFACT-PRIVATE-STORAGE-ACTIVATION';
  static const String activeProductGatePreservedPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String status = 'ONNX_REAL_MODEL_LOAD_SMOKE_EXECUTION_EXPLICIT_INVOCATION_ONLY_NO_AUTO_RUN_NO_OCR';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String bridgeMethod = 'onnxRealModelLoadSmokeExecution';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;
}
