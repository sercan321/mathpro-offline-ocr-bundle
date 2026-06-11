class GaussFlutterAnalyzeInfoHygieneQ313R2Policy {
  const GaussFlutterAnalyzeInfoHygieneQ313R2Policy._();

  static const String phase = 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE';
  static const String sourcePhase = 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE';
  static const String repairScope = 'flutter-analyze-info-hygiene-only';

  static const bool preferConstConstructorsApplied = true;
  static const bool q291TestConstDeclarationApplied = true;
  static const bool parserErrorReintroduced = false;
  static const bool runtimeBehaviorChanged = false;
  static const bool cameraOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool jniNativeHandlerAdded = false;
  static const bool methodChannelBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> repairedAnalyzerFindings = <String>[
    'prefer_const_constructors-in-q288-q295-camera-contract-result-objects',
    'prefer_const_declarations-in-q291-download-sha-test-fields',
  ];

  static const List<String> repairedFiles = <String>[
    'lib/features/camera/gauss_first_real_dummy_input_runtime_call.dart',
    'lib/features/camera/gauss_first_real_image_to_latex_inference.dart',
    'lib/features/camera/gauss_first_real_runtime_startup_smoke.dart',
    'lib/features/camera/gauss_native_runtime_handler_skeleton_android_binding.dart',
    'lib/features/camera/gauss_private_model_download_sha_verification_runtime.dart',
    'lib/features/camera/gauss_real_ocr_artifact_source_intake.dart',
    'lib/features/camera/gauss_real_private_artifact_load_smoke.dart',
    'lib/features/camera/gauss_runtime_dependency_actual_trial_default_off.dart',
    'test/v172_q291_private_model_download_sha_verification_runtime_test.dart',
  ];

  static const List<String> protectedRuntimeSurfacesNotModified = <String>[
    'MainActivity.kt',
    'AndroidManifest.xml',
    'pubspec.yaml',
    'keyboard layout',
    'MORE/template tray',
    'long-press lists',
    'MathLive production route',
    'Graph/Solution/History',
    'Workspace runtime',
    'Camera shell runtime',
  ];
}
