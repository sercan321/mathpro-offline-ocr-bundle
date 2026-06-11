class GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy {
  const GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy._();

  static const String phase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
  static const String sourcePhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'native-package-hash-evidence-acceptance-and-binary-bundle-permission-gate-without-bundling-so-jar-aar-jnilibs-gradle-pubspec-or-androidmanifest-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String nativePackageHashEvidenceAcceptanceMethod = 'nativePackageHashEvidenceAcceptance';
  static const String nativePackageHashEvidenceAcceptanceStatus =
      'NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.nativePackageHashEvidenceAcceptance.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String bundlePermissionStatus =
      'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_PROVIDED_REVIEWED_AND_EXPLICITLY_APPROVED';
  static const String mainActivityChangeReason =
      'add default-off native package hash evidence acceptance envelope method only; no .so, .aar, jar, jniLibs, Gradle, pubspec, AndroidManifest, System.loadLibrary, Paddle Lite instantiate, model loader, runtime startup, dummy execution, or inference';
  static const String nextRequiredPhase =
      'Q332_REQUIRES_ACCEPTED_NATIVE_HASH_EVIDENCE_AND_EXPLICIT_BINARY_BUNDLE_APPROVAL';

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

  static const List<String> evidenceAcceptanceRequirements = <String>[
    'q330-flutter-analyze-and-test-clean-on-user-machine',
    'q328-native-package-hash-evidence-json-provided-from-outside-project-root',
    'required-native-package-files-present-in-evidence-json',
    'per-file-sha256-values-present-and-nonempty',
    'native-package-source-url-or-release-identifier-recorded',
    'explicit-user-approval-before-binary-bundle-trial',
    'rollback-plan-recorded-before-bundle',
  ];

  static const List<String> q331HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q331',
    'no-jnilibs-or-android-app-libs-directory-created-in-q331',
    'no-pubspec-gradle-androidmanifest-mutation-in-q331',
    'no-system-loadlibrary-in-q331',
    'no-paddle-lite-instantiation-in-q331',
    'no-model-loader-runtime-startup-dummy-execution-or-inference-in-q331',
    'no-mathlive-review-or-workspace-import-in-q331',
    'no-ocr-android-real-device-store-or-release-pass-claims-in-q331',
  ];

  static const List<String> q332EntryCriteria = <String>[
    'q331-flutter-analyze-and-test-clean-on-user-machine',
    'native-package-hash-evidence-json-provided-and-accepted',
    'explicit-user-approval-to-create-android-app-libs-and-jnilibs',
    'expected-apk-size-delta-recorded-before-bundle',
    'rollback-plan-recorded-before-bundle',
  ];
}
