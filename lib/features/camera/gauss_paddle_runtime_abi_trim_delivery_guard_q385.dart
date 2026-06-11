/// V172-Q385 — Paddle runtime ABI trim and delivery guard.
///
/// This phase keeps the Q384/Q384R1/Q384R2 download-only OCR contract intact:
/// model bytes are still downloaded by the user, ONNX Runtime is not re-added,
/// and arbitrary native runtime code is not downloaded from the network. The
/// base APK/AAB release packaging is narrowed to the single supported arm64-v8a
/// Paddle Lite native runtime path to reduce base native payload risk/size.
class GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy {
  const GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy._();

  static const String phase = 'V172-Q385-PADDLE-RUNTIME-ABI-TRIM-AND-DELIVERY-GUARD';
  static const String sourcePhase = 'V172-Q384R2-CAMERA-OCR-RUNTIME-MODEL-FORMAT-BINDING-PREFLIGHT';
  static const String baseRuntimeDeliveryMode = 'base-apk-arm64-v8a-only-paddle-lite-runtime-model-download-only';
  static const String packagedBaseAbi = 'arm64-v8a';
  static const String gradleAbiFilterContract = "abiFilters 'arm64-v8a'";
  static const String nativeBridgeMethod = 'paddleRuntimeDeliveryDecisionQ385';

  static const bool modelBinaryBundledInBaseApp = false;
  static const bool ppFormulaNetSModelRemainsDeferredDownload = true;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool paddleLiteRuntimeKeptInBaseForCurrentBridge = true;
  static const bool arm64OnlyBaseRuntimePackagingEnabled = true;
  static const bool armeabiV7aPackagedInBaseRelease = false;
  static const bool x86OrX64PackagedInBaseRelease = false;
  static const bool nativeRuntimeNetworkDownloadAllowed = false;
  static const bool playFeatureDeliveryRuntimeModuleImplemented = false;
  static const bool productionInferenceClaimedByQ385 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool workspaceAutoImportAllowed = false;
  static const bool solveGraphSolutionHistoryTouched = false;

  static const List<String> retainedBaseRuntimeFiles = <String>[
    'android/app/libs/PaddlePredictor.jar',
    'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
  ];
}
