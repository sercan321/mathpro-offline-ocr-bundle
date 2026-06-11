/// V172-Q253 Android Toolchain Modernization policy.
///
/// This phase is deliberately separate from the Camera/OCR runtime chain. It
/// modernizes the Android build toolchain warning surface while preserving the
/// Q245-Q252 camera/OCR foundation and every protected premium UI surface.
class GaussAndroidToolchainModernizationPolicy {
  const GaussAndroidToolchainModernizationPolicy._();

  static const phase = 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
  static const sourcePhase = 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION';
  static const sourcePackageSha256 = '0d1d6f118744dabe3faf48c821b6d009eb163aa5eef854708dca0718e37fd358';

  static const modernizationMode = 'android-build-toolchain-warning-cleanup-with-camera-ocr-preservation';

  static const previousAgpVersion = '8.3.2';
  static const targetAgpVersion = '8.6.1';
  static const kotlinGradlePluginVersion = '2.1.0';
  static const gradleWrapperVersion = '8.7';
  static const javaSourceCompatibility = '17';
  static const javaTargetCompatibility = '17';
  static const kotlinJvmTarget = '17';

  static const androidOfficialKotlin21MinimumAgp = '8.6';
  static const androidOfficialAgp86MinimumGradle = '8.7';
  static const androidOfficialAgp86Jdk = '17';

  static const agpUpgradePerformed = true;
  static const kotlinPluginPreserved = true;
  static const gradleWrapperPreservedAtRequiredVersion = true;
  static const java17CompileOptionsPreserved = true;
  static const cameraDependencyLinePreserved = true;

  static const cameraOcrFoundationPreserved = true;
  static const ppFormulaNetSUserSelectionPreserved = true;
  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const ppFormulaNetSModelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const productionDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;

  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
  static const directWorkspaceImportAllowed = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;

  static const keyboardLayoutMustRemainUnchanged = true;
  static const moreInventoryMustRemainUnchanged = true;
  static const longPressInventoryMustRemainUnchanged = true;
  static const mathLiveProductionRouteMustRemainUnchanged = true;
  static const graphSurfaceMustRemainUnchanged = true;
  static const solutionSurfaceMustRemainUnchanged = true;
  static const historySurfaceMustRemainUnchanged = true;
  static const splashAndLauncherMustRemainUnchanged = true;

  static const expectedAndroidToolchainFilesChanged = <String>[
    'android/settings.gradle',
    'lib/features/camera/gauss_android_toolchain_modernization_policy.dart',
    'lib/features/camera/gauss_android_toolchain_modernization.dart',
    'test/v172_q253_android_toolchain_modernization_test.dart',
    'tool/verify_android_toolchain_modernization_v172_q253.mjs',
    'docs/audit/V172_Q253_ANDROID_TOOLCHAIN_MODERNIZATION_AUDIT.md',
    'docs/audit/V172_Q253_CHANGED_FILES.md',
    'assets/mathlive/manifest.json',
    'README.md',
  ];

  static const forbiddenQ253Actions = <String>[
    'changeKeyboardLayout',
    'changeMoreInventory',
    'changeLongPressInventory',
    'replaceMathLiveProductionRoute',
    'modifyGraphRuntime',
    'modifySolutionRuntime',
    'modifyHistoryRuntime',
    'modifyCameraCaptureShellRuntime',
    'addPaddleRuntime',
    'addPaddleOcrDependency',
    'bundlePpFormulaNetSModelInBaseApk',
    'setProductionModelUrl',
    'runPpFormulaNetSInference',
    'importCameraOutputWithoutUserApproval',
    'solveFromCameraWithoutReview',
    'graphFromCameraWithoutReview',
  ];
}
