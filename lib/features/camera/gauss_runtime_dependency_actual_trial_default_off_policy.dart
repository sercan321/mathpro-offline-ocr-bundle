class GaussRuntimeDependencyActualTrialDefaultOffPolicy {
  const GaussRuntimeDependencyActualTrialDefaultOffPolicy._();

  static const String phase = 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
  static const String sourcePhase = 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String trialMode = 'default-off-dependency-readiness-trial-no-pubspec-runtime-mutation-no-ocr-pass';
  static const String dependencyTrialFlag = 'gauss.ppFormulaNetS.runtimeDependencyTrial.defaultOff';
  static const String dependencyCandidateFamily = 'Paddle inference runtime candidate';
  static const String dependencyDecision = 'blocked-until-artifact-sha-license-abi-memory-latency-and-runtime-package-are-real';
  static const String rollbackMode = 'remove-default-off-trial-policy-without-runtime-state-migration';

  static const bool q288SourceIntakeRequired = true;
  static const bool q288ArtifactSha256StillPending = true;
  static const bool dependencyTrialFlagDefined = true;
  static const bool dependencyTrialDefaultEnabled = false;
  static const bool dependencyAddedToPubspec = false;
  static const bool dependencyResolvedByFlutterPubGet = false;
  static const bool dependencyImportedInProductionCode = false;
  static const bool dependencyReachableFromCameraRuntime = false;
  static const bool runtimeActivationAllowed = false;
  static const bool realDeviceRuntimeSmokeRequiredBeforeActivation = true;
  static const bool rollbackRequiredBeforeActivation = true;

  static const bool changesRuntimeBehavior = false;
  static const bool keyboardLayoutChanged = false;
  static const bool moreTemplateTrayChanged = false;
  static const bool longPressListsChanged = false;
  static const bool graphSolutionHistoryChanged = false;
  static const bool mathLiveProductionRouteChanged = false;
  static const bool cameraShellRuntimeChanged = false;
  static const bool workspaceRuntimeChanged = false;
  static const bool solverEvaluatorChanged = false;
  static const bool androidToolchainChanged = false;
  static const bool cameraDependencyChanged = false;

  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeHandlerImplementationAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool productionDownloadEnabled = false;
  static const bool imageToLatexInferenceExecuted = false;
  static const bool directWorkspaceImportEnabled = false;
  static const bool directSolveGraphSolutionHistoryEnabled = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> dependencyTrialPreconditions = [
    'q288-real-artifact-source-intake-present',
    'real-artifact-sha256-must-be-computed-before-runtime-ready',
    'license-compatibility-must-remain-apache-2-compatible-for-distribution',
    'android-abi-and-runtime-package-must-be-proven-before-pubspec-mutation',
    'memory-and-latency-budget-must-be-proven-on-real-device-before-activation',
    'runtime-dependency-must-remain-default-off-until-real-smoke-evidence',
    'model-binary-must-stay-out-of-base-apk',
    'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
    'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
  ];

  static const List<String> blockedDependencyFamilies = [
    'paddleocr',
    'paddle_ocr',
    'paddle_flutter',
    'paddle_lite',
    'google_mlkit_text_recognition',
    'onnxruntime',
    'tesseract',
    'pix2text',
    'flutter_downloader',
    'background_downloader',
    'dio',
  ];

  static const List<String> requiresUserSideRetest = [
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];
}
