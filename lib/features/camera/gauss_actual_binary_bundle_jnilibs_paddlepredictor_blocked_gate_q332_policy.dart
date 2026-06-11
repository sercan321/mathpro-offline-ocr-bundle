class GaussActualBinaryBundleJniLibsPaddlePredictorBlockedGateQ332Policy {
  const GaussActualBinaryBundleJniLibsPaddlePredictorBlockedGateQ332Policy._();

  static const String phase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
  static const String sourcePhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope =
      'actual-binary-bundle-gate-blocked-until-native-package-hash-evidence-and-explicit-user-bundle-approval-without-adding-so-jar-aar-jnilibs-gradle-pubspec-or-androidmanifest-mutation';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String actualBinaryBundleGateMethod = 'actualBinaryBundleGate';
  static const String actualBinaryBundleGateStatus =
      'ACTUAL_BINARY_BUNDLE_BLOCKED_PENDING_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF';
  static const String featureFlagName = 'gauss.ppFormulaNetS.actualBinaryBundle.defaultOff';
  static const String selectedRuntimeDependencyCandidate =
      'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate =
      'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String bundlePermissionStatus =
      'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_PROVIDED';
  static const String mainActivityChangeReason =
      'add default-off actual binary bundle gate envelope method only; no binary files, Gradle, pubspec, AndroidManifest, native loader, runtime startup, inference, review, or workspace import';
  static const String nextRequiredPhase =
      'Q333_REQUIRES_NATIVE_PACKAGE_HASH_EVIDENCE_AND_USER_APPROVAL_BEFORE_ANY_REAL_BINARY_BUNDLE_OR_PACKAGING_TRIAL';

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

  static const List<String> actualBundleRequirements = <String>[
    'q331-flutter-analyze-and-test-clean-on-user-machine',
    'q328-native-package-hash-evidence-json-provided-from-outside-project-root',
    'required-native-package-files-present-in-evidence-json',
    'per-file-sha256-values-present-and-nonempty',
    'native-package-source-url-or-release-identifier-recorded',
    'explicit-user-approval-to-create-android-app-libs-and-jnilibs',
    'expected-apk-size-delta-recorded-before-bundle',
    'rollback-plan-recorded-before-bundle',
  ];

  static const List<String> q332HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q332',
    'no-jnilibs-or-android-app-libs-directory-created-in-q332',
    'no-pubspec-gradle-androidmanifest-mutation-in-q332',
    'no-native-library-load-in-q332',
    'no-paddle-lite-instantiation-in-q332',
    'no-model-loader-runtime-startup-dummy-execution-or-inference-in-q332',
    'no-mathlive-review-or-workspace-import-in-q332',
    'no-ocr-android-real-device-store-or-release-pass-claims-in-q332',
  ];

  static const List<String> q333EntryCriteria = <String>[
    'q332-flutter-analyze-and-test-clean-on-user-machine',
    'native-package-hash-evidence-json-provided-and-accepted',
    'explicit-user-approval-to-bundle-required-native-files',
    'binary-files-copied-from-approved-external-native-package-only',
    'rollback-plan-recorded-before-bundle',
  ];
}
