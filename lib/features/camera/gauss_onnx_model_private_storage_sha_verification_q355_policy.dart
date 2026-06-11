class GaussOnnxModelPrivateStorageShaVerificationQ355Policy {
  const GaussOnnxModelPrivateStorageShaVerificationQ355Policy._();

  static const String phase =
      'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION';
  static const String sourcePhase =
      'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
  static const String feasibilitySourcePhase =
      'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
  static const String onnxConversionEvidenceSourcePhase =
      'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
  static const String hygieneSourcePhase =
      'V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR';
  static const String status =
      'ONNX_MODEL_PRIVATE_STORAGE_SHA_VERIFICATION_POLICY_PREPARED_NO_COPY_NO_LOAD_NO_OCR';

  static const String selectedDependencyCoordinate =
      'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String externalOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String externalOnnxArtifactPathPolicy =
      '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 =
      '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const String appPrivateStoragePolicy =
      'Future runtime phases must copy the verified ONNX artifact into app-private storage only after size and SHA256 match.';
  static const String expectedPrivateStorageFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageDirectoryPolicy =
      'Android app-private files directory, not project root, assets, cache-only storage, public Downloads, or bundled APK assets.';

  static const List<String> verificationBoundaries = <String>[
    'Q355 prepares private-storage and SHA verification policy only.',
    'Q355 must not bundle pp_formulanet_s.onnx inside the Flutter project ZIP.',
    'Q355 must not copy the ONNX file into app-private storage in assistant environment.',
    'Q355 must not add Java/Kotlin ONNX Runtime calls or model-load code.',
    'Q355 must not run runtime startup, dummy call, image-to-LaTeX inference, OCR review, workspace import, Solve, Graph, Solution, or History.',
    'Q355 must keep the ONNX Runtime Android dependency from Q354 as the last dependency trial state without claiming user-side build success.',
  ];

  static const List<String> nextPhaseRequirements = <String>[
    'User-side Q354/Q355 flutter pub get/analyze/test/run logs, because Q354 added a real Android dependency.',
    'Verified external pp_formulanet_s.onnx size and SHA256 evidence before any future copy/load action.',
    'A future Q356 model-load smoke may only run after private-storage SHA policy remains satisfied.',
  ];
}
