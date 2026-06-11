/// V172-Q387 — Paddle Lite .nb model format decision gate.
///
/// This phase stops the Q386 bridge from blindly giving the downloaded
/// Paddle inference-directory `inference.pdiparams` file to Android
/// Paddle Lite MobileConfig. The bundled PaddlePredictor.jar exposes
/// `setModelFromFile`/`setModelFromBuffer`, but no `setModelDir`; therefore
/// Android OCR must proceed only when a download-only Paddle Lite optimized
/// `.nb` model artifact is present and verified by the later Q387R1/Q387R2
/// phases.
class GaussPaddleLiteNbModelFormatDecisionQ387Policy {
  const GaussPaddleLiteNbModelFormatDecisionQ387Policy._();

  static const String phase = 'V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE';
  static const String sourcePhase = 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE';
  static const String status = 'PADDLE_LITE_MOBILECONFIG_API_INVENTORIED_NB_MODEL_REQUIRED_NO_INFERENCE_DIRECTORY_LOAD_CLAIM';

  static const String currentDownloadedArtifactFormat = 'paddle-inference-directory';
  static const String requiredAndroidArtifactFormat = 'paddle-lite-optimized-nb';
  static const String requiredModelFileExtension = '.nb';
  static const String selectedFutureLoadMethod = 'MobileConfig.setModelFromFile(.nb)';

  static const String setModelFromFileMethodName = 'setModelFromFile';
  static const String setModelFromBufferMethodName = 'setModelFromBuffer';
  static const String setModelDirMethodName = 'setModelDir';

  static const String nbModelRequiredBlockedReason = 'q387-paddle-lite-nb-model-required';
  static const String inferenceDirectoryRejectedReason = 'q387-paddle-inference-directory-not-loadable-by-current-mobileconfig';
  static const String setModelDirUnavailableReason = 'q387-current-paddlepredictor-jar-has-no-setModelDir';
  static const String setModelFromFileUnavailableReason = 'q387-setModelFromFile-unavailable';

  static const bool setModelDirClaimedAvailableByPackage = false;
  static const bool inferenceDirectoryAcceptedForAndroidRuntime = false;
  static const bool nbModelBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387 = false;
  static const bool androidRealDevicePassClaimedByQ387 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussPaddleLiteNbModelFormatDecisionQ387Result {
  const GaussPaddleLiteNbModelFormatDecisionQ387Result({
    required this.phase,
    required this.sourcePhase,
    required this.currentDownloadedArtifactFormat,
    required this.requiredAndroidArtifactFormat,
    required this.supportsSetModelFromFile,
    required this.supportsSetModelFromBuffer,
    required this.supportsSetModelDir,
    required this.paddleLiteNbModelAvailable,
    required this.downloadedArtifactIsPaddleInferenceDirectory,
    required this.selectedModelLoadStrategy,
    required this.blockedReason,
    required this.canAttemptModelLoad,
  });

  final String phase;
  final String sourcePhase;
  final String currentDownloadedArtifactFormat;
  final String requiredAndroidArtifactFormat;
  final bool supportsSetModelFromFile;
  final bool supportsSetModelFromBuffer;
  final bool supportsSetModelDir;
  final bool paddleLiteNbModelAvailable;
  final bool downloadedArtifactIsPaddleInferenceDirectory;
  final String selectedModelLoadStrategy;
  final String blockedReason;
  final bool canAttemptModelLoad;
}

class GaussPaddleLiteNbModelFormatDecisionQ387Gate {
  const GaussPaddleLiteNbModelFormatDecisionQ387Gate._();

  static GaussPaddleLiteNbModelFormatDecisionQ387Result evaluate({
    required bool supportsSetModelFromFile,
    required bool supportsSetModelFromBuffer,
    required bool supportsSetModelDir,
    required bool paddleLiteNbModelAvailable,
    required bool downloadedArtifactIsPaddleInferenceDirectory,
  }) {
    final String selectedModelLoadStrategy;
    final String blockedReason;
    final bool canAttemptModelLoad;

    if (!supportsSetModelFromFile) {
      selectedModelLoadStrategy = 'q387-blocked-setModelFromFile-unavailable';
      blockedReason = GaussPaddleLiteNbModelFormatDecisionQ387Policy.setModelFromFileUnavailableReason;
      canAttemptModelLoad = false;
    } else if (paddleLiteNbModelAvailable) {
      selectedModelLoadStrategy = 'q387-setModelFromFile-paddle-lite-nb';
      blockedReason = '';
      canAttemptModelLoad = true;
    } else if (downloadedArtifactIsPaddleInferenceDirectory && !supportsSetModelDir) {
      selectedModelLoadStrategy = 'q387-blocked-nb-model-required-current-jar-has-no-setModelDir';
      blockedReason = GaussPaddleLiteNbModelFormatDecisionQ387Policy.nbModelRequiredBlockedReason;
      canAttemptModelLoad = false;
    } else if (downloadedArtifactIsPaddleInferenceDirectory) {
      selectedModelLoadStrategy = 'q387-inference-directory-not-selected-for-current-android-runtime';
      blockedReason = GaussPaddleLiteNbModelFormatDecisionQ387Policy.inferenceDirectoryRejectedReason;
      canAttemptModelLoad = false;
    } else {
      selectedModelLoadStrategy = 'q387-blocked-paddle-lite-nb-model-missing';
      blockedReason = GaussPaddleLiteNbModelFormatDecisionQ387Policy.nbModelRequiredBlockedReason;
      canAttemptModelLoad = false;
    }

    return GaussPaddleLiteNbModelFormatDecisionQ387Result(
      phase: GaussPaddleLiteNbModelFormatDecisionQ387Policy.phase,
      sourcePhase: GaussPaddleLiteNbModelFormatDecisionQ387Policy.sourcePhase,
      currentDownloadedArtifactFormat: GaussPaddleLiteNbModelFormatDecisionQ387Policy.currentDownloadedArtifactFormat,
      requiredAndroidArtifactFormat: GaussPaddleLiteNbModelFormatDecisionQ387Policy.requiredAndroidArtifactFormat,
      supportsSetModelFromFile: supportsSetModelFromFile,
      supportsSetModelFromBuffer: supportsSetModelFromBuffer,
      supportsSetModelDir: supportsSetModelDir,
      paddleLiteNbModelAvailable: paddleLiteNbModelAvailable,
      downloadedArtifactIsPaddleInferenceDirectory: downloadedArtifactIsPaddleInferenceDirectory,
      selectedModelLoadStrategy: selectedModelLoadStrategy,
      blockedReason: blockedReason,
      canAttemptModelLoad: canAttemptModelLoad,
    );
  }
}
