class GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy {
  const GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy._();

  static const String phase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
  static const String sourcePhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String methodName = 'nativePackageHashEvidenceCollectionIntake';
  static const String status = 'NATIVE_PACKAGE_HASH_EVIDENCE_COLLECTION_INTAKE_BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES_DEFAULT_OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String bundlePermissionStatus = 'BLOCKED_UNTIL_USER_SIDE_NATIVE_PACKAGE_FILES_AND_Q328_HASH_EVIDENCE_JSON_ARE_PROVIDED_AND_EXPLICITLY_APPROVED';

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

  static const List<String> q335UserSideIntakeSteps = <String>[
    'place-paddle-lite-android-native-files-outside-project-root',
    'run-q328-native-package-hash-capture-script',
    'provide-q328-native-package-hash-evidence-json-to-assistant',
    'explicitly-approve-binary-bundle-before-q336',
  ];

  static const List<String> q335HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q335',
    'no-jniLibs-directory-created-in-q335',
    'no-android-app-libs-directory-created-in-q335',
    'no-gradle-or-pubspec-mutation-in-q335',
    'no-system-load-library-in-q335',
    'no-paddle-lite-instantiation-in-q335',
    'no-runtime-or-ocr-pass-claim-in-q335',
  ];
}
