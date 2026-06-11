class GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy {
  const GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy._();

  static const String phase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
  static const String sourcePhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
  static const String nativeChannelName = 'mathpro/ocr_runtime_bridge';
  static const String methodName = 'nativePackageHashEvidenceAcceptanceExplicitBundleApproval';
  static const String status = 'NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_EXPLICIT_BUNDLE_APPROVAL_BLOCKED_PENDING_Q328_JSON_AND_USER_APPROVAL_DEFAULT_OFF';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String selectedRuntimeDependencyCandidate = 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING';
  static const String selectedModelLoaderCandidate = 'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE';
  static const String externalNativePackageEvidencePolicy = '../MathProOcrNativePackages/Paddle_Lite_Android';
  static const String nativePackageEvidenceFileName = 'q328_native_library_package_hash_evidence.json';
  static const String q337BundleApprovalGateScript = 'tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs';
  static const String bundlePermissionStatus = 'BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_REVIEWED_AND_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE';

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

  static const List<String> q337EvidenceAcceptanceSteps = <String>[
    'run-q335-native-package-intake-preparation-script',
    'place-native-package-files-outside-project-root',
    'run-q328-native-package-hash-capture-script',
    'run-q336-q328-evidence-intake-script',
    'provide-q328-and-q336-evidence-json-to-assistant',
    'review-per-file-sha256-evidence',
    'provide-explicit-user-binary-bundle-approval-before-q338',
  ];

  static const List<String> q337HardBlocks = <String>[
    'no-so-aar-jar-bundled-in-q337',
    'no-jniLibs-directory-created-in-q337',
    'no-android-app-libs-directory-created-in-q337',
    'no-gradle-or-pubspec-mutation-in-q337',
    'no-system-load-library-in-q337',
    'no-paddle-lite-instantiation-in-q337',
    'no-runtime-or-ocr-pass-claim-in-q337',
  ];
}
