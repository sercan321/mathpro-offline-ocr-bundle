class GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy {
  const GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy._();

  static const String phase = 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD';
  static const String sourcePhase = 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
  static const String status = 'ONNX_RUNTIME_ANDROID_BUILD_EVIDENCE_INTAKE_INSTALLED_MODEL_LOAD_UNLOCK_REMAINS_BLOCKED_PENDING_REAL_USER_LOGS';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> requiredUserSideLogs = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];

  static const List<String> blockers = <String>[
    'Q354 introduced a real ONNX Runtime Android dependency, so dependency resolution and Android build/install/open logs must be reviewed before model-load code is added.',
    'Q356 recorded real model-load smoke as the next milestone but intentionally blocked it until user-side evidence exists.',
    'The 308 MB ONNX model remains outside the project ZIP and cannot be bundled in this phase.',
    'MainActivity must remain unchanged until model-load unlock is explicitly granted by real logs.',
  ];

  static const List<String> redLines = <String>[
    'No MainActivity ONNX Runtime model-load bridge.',
    'No new Gradle/pubspec/AndroidManifest dependency mutation.',
    'No ONNX model bundling or app-private copy.',
    'No on-device SHA verification in this phase.',
    'No runtime startup, dummy call, image-to-LaTeX inference, OCR review, workspace import, Solve, Graph, Solution, or History.',
  ];

  static const List<String> unlockRequirements = <String>[
    'User-side flutter pub get must resolve the ONNX Runtime Android dependency.',
    'User-side flutter analyze must pass.',
    'User-side flutter test must pass.',
    'User-side flutter run must build, install, and open on the real Android device.',
    'If any required log fails, the next phase must be a dependency/build repair rather than model load.',
  ];
}
