class GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy {
  const GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy._();

  static const String phase =
      'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
  static const String sourcePhase =
      'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
  static const String onnxConversionEvidenceSourcePhase =
      'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
  static const String hygieneSourcePhase =
      'V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR';
  static const String status =
      'ONNX_RUNTIME_ANDROID_DEPENDENCY_ADDED_FOR_ABI_BUILD_TRIAL_DEFAULT_OFF_NO_MODEL_LOAD_NO_OCR';

  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String selectedDependencyGroup = 'com.microsoft.onnxruntime';
  static const String selectedDependencyArtifact = 'onnxruntime-android';
  static const String selectedDependencyVersion = '1.26.0';
  static const String dependencyScope = 'android/app/build.gradle implementation';

  static const String externalOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String externalOnnxArtifactPathPolicy =
      '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String externalOnnxArtifactSha256 =
      '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int externalOnnxArtifactSizeBytes = 308743097;

  static const List<String> buildTrialBoundaries = <String>[
    'Only android/app/build.gradle may add the ONNX Runtime Android AAR dependency in Q354.',
    'Q354 must not add Java/Kotlin ONNX Runtime calls in MainActivity or any Android runtime bridge.',
    'Q354 must not bundle, copy, load, or infer with pp_formulanet_s.onnx.',
    'Q354 must not open OCR review UI or import OCR output into the workspace.',
    'Q354 may only be validated by user-side flutter clean/pub get/analyze/test/run because assistant environment has no Android SDK.',
  ];

  static const List<String> nextPhaseRequirements = <String>[
    'User-side flutter pub get/analyze/test/run evidence after ONNX Runtime dependency trial',
    'APK/AAB size impact evidence from Android build output when available',
    'ABI/native library inventory evidence after dependency resolution when available',
    'No model-load, dummy call, OCR, review UI, workspace import, Solve, Graph, Solution, or History mutation before Q355/Q356 gates',
  ];
}
