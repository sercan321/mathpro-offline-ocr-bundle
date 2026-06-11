class GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy {
  const GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy._();

  static const String phase = 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD';
  static const String sourcePhase = 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD';
  static const String status = 'Q357_REAL_MODEL_LOAD_LOCKED_BECAUSE_REQUIRED_USER_SIDE_ANDROID_BUILD_EVIDENCE_IS_STILL_MISSING';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> requiredBeforeQ357 = <String>[
    'User-side flutter pub get log after Q354/Q356R1 package extraction.',
    'User-side flutter analyze log after Q354/Q356R1 package extraction.',
    'User-side flutter test log after Q354/Q356R1 package extraction.',
    'User-side flutter run -d 23106RN0DA build/install/open log after Q354/Q356R1 package extraction.',
  ];

  static const List<String> lockedActions = <String>[
    'Do not add MainActivity ONNX Runtime model-load bridge yet.',
    'Do not add Kotlin/Java OrtEnvironment or OnnxTensor references yet.',
    'Do not copy or bundle the 308 MB ONNX artifact.',
    'Do not attempt on-device SHA verification yet.',
    'Do not claim ONNX Runtime Android build PASS, model-load PASS, or OCR PASS.',
  ];

  static const List<String> nextPhaseRules = <String>[
    'If required user logs pass, Q357 may be a default-off ONNX real model-load smoke bridge preflight/execution phase.',
    'If any required user log fails, the next phase must be a Q356R3 dependency/build repair, not OCR.',
    'If logs are absent, remain in evidence-hold/lock state and do not open runtime model-load code.',
  ];
}
