class GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy {
  const GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy._();

  static const String phase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
  static const String sourcePhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'binary-bundle-trial-default-off-blocked-pending-native-package-hash-evidence-with-no-so-jar-aar-jnilibs-gradle-pubspec-or-androidmanifest-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String binaryBundleTrialMethod = 'binaryBundleTrialDefaultOff';
  static const String binaryBundleTrialStatus =
      'BINARY_BUNDLE_TRIAL_BLOCKED_PENDING_NATIVE_PACKAGE_HASH_EVIDENCE_AND_USER_APPROVAL_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.binaryBundleTrial.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String requiredPrimaryAbi = 'arm64-v8a';
  static const String optionalLegacyAbi = 'armeabi-v7a';
  static const String emulatorAbi = 'x86_64';
  static const String futureAndroidAppLibsDirectory = 'android/app/libs';
  static const String futureJniLibsDirectory = 'android/app/src/main/jniLibs';
  static const String futurePaddlePredictorJarPath = 'android/app/libs/PaddlePredictor.jar';
  static const String mainActivityChangeReason =
      'add default-off binary bundle trial envelope method only; no .so, .aar, jar, jniLibs, Gradle, pubspec, AndroidManifest, System.loadLibrary, Paddle Lite instantiate, model loader, runtime startup, dummy execution, or inference';
  static const String nextRequiredPhase =
      'Q331_REQUIRES_Q330_FLUTTER_LOGS_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_BINARY_BUNDLE_APPROVAL';

  static const List<String> requiredNativePackageFiles = <String>[
    'PaddlePredictor.jar',
    'arm64-v8a/libpaddle_lite_jni.so',
    'armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> optionalNativePackageFiles = <String>[
    'x86_64/libpaddle_lite_jni.so',
  ];

  static const List<String> plannedBundleTargets = <String>[
    'android/app/libs/PaddlePredictor.jar',
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
    'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
  ];

  static const List<String> binaryBundleTrialRequirements = <String>[
    'q329-flutter-analyze-and-test-clean-on-user-machine',
    'q328-native-package-hash-evidence-json-provided',
    'per-file-sha256-evidence-reviewed-for-required-native-package-files',
    'explicit-user-approval-for-binary-bundle-trial',
    'rollback-plan-before-creating-android-app-libs-or-jnilibs',
    'fresh-flutter-clean-pub-get-analyze-test-run-after-future-bundle',
  ];

  static const List<String> q330HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q330',
    'no-jnilibs-or-android-app-libs-directory-created-in-q330',
    'no-pubspec-gradle-androidmanifest-mutation-in-q330',
    'no-system-loadlibrary-in-q330',
    'no-paddle-lite-instantiation-in-q330',
    'no-model-loader-runtime-startup-dummy-execution-or-inference-in-q330',
    'no-mathlive-review-or-workspace-import-in-q330',
    'no-ocr-android-real-device-store-or-release-pass-claims-in-q330',
  ];

  static const List<String> q331EntryCriteria = <String>[
    'q330-flutter-analyze-and-test-clean-on-user-machine',
    'native-package-hash-evidence-json-provided-and-accepted',
    'explicit-user-approval-to-create-android-app-libs-and-jnilibs',
    'expected-apk-size-delta-recorded-before-bundle',
    'rollback-plan-recorded-before-bundle',
  ];
}
