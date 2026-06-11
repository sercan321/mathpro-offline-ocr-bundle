class GaussCameraOcrRuntimePremiumRegressionPolicy {
  const GaussCameraOcrRuntimePremiumRegressionPolicy._();

  static const String phase = 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION';
  static const String sourcePhase = 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const String regressionMode = 'camera-ocr-runtime-premium-regression-guard-only-no-real-inference-no-runtime-pass';

  static const bool cameraOcrRuntimePremiumRegressionImplemented = true;
  static const bool requiresQ276CameraOcrRealEndToEndDeviceCourt = true;
  static const bool protectsKeyboardLayout = true;
  static const bool protectsMoreTemplateTray = true;
  static const bool protectsLongPressLists = true;
  static const bool protectsMathLiveProductionRoute = true;
  static const bool blocksLegacyFlutterCursorRoute = true;
  static const bool protectsGraphSurface = true;
  static const bool protectsSolutionSurface = true;
  static const bool protectsHistorySurface = true;
  static const bool protectsCameraShellRuntime = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool workspaceImportDoesNotAutoEvaluate = true;
  static const bool workspaceImportDoesNotAutoSolve = true;
  static const bool workspaceImportDoesNotAutoGraph = true;
  static const bool workspaceImportDoesNotAutoWriteSolution = true;
  static const bool workspaceImportDoesNotAutoWriteHistory = true;
  static const bool directCameraSolveBlocked = true;
  static const bool directCameraGraphSolutionHistoryBlocked = true;

  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeBridgeImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool productionDownloadEnabled = false;
  static const bool productionInferenceAllowed = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool cameraPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool premiumFinalPassClaimed = false;
  static const bool releasePassClaimed = false;
  static const bool graphPixelPerfectPassClaimed = false;
  static const bool longPressVisualPassClaimed = false;

  static const List<String> protectedRuntimeSurfaces = [
    'lib/features/keyboard/key_config.dart',
    'lib/features/keyboard/math_keyboard.dart',
    'lib/features/keyboard/bottom_dock.dart',
    'lib/features/keyboard/long_press_popup.dart',
    'lib/features/keyboard/premium_key.dart',
    'lib/features/workspace/template_tray.dart',
    'assets/mathlive/main_editor_prod.html',
    'assets/mathlive/mathlive_prod_bridge.js',
    'lib/features/mathlive/mathlive_production_editor_surface.dart',
    'lib/features/graph/graph_card.dart',
    'lib/features/solution/solution_steps_panel.dart',
    'lib/features/solution/solution_step_models.dart',
    'lib/features/history/history_panel.dart',
    'lib/features/history/history_controller.dart',
    'lib/app/app_shell.dart',
    'lib/main.dart',
    'lib/app/gauss_splash_screen.dart',
    'lib/features/workspace/workspace_panel.dart',
    'lib/features/camera/gauss_camera_capture_shell.dart',
  ];

  static const List<String> requiredRegressionGates = [
    'q276CameraOcrRealEndToEndDeviceCourtPresent',
    'keyboardLayoutHashStable',
    'moreTemplateTrayHashStable',
    'longPressListsHashStable',
    'mathLiveProductionHtmlHashStable',
    'mathLiveProductionBridgeHashStable',
    'mathLiveProductionSurfaceHashStable',
    'legacyFlutterCursorRouteNotReintroduced',
    'graphSurfaceHashStable',
    'solutionSurfaceHashStable',
    'historySurfaceHashStable',
    'appShellHashStable',
    'workspacePanelHashStable',
    'cameraShellRuntimeHashStable',
    'pubspecCameraDependenciesStable',
    'androidToolchainStable',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'workspaceImportDoesNotAutoEvaluate',
    'workspaceImportDoesNotAutoSolve',
    'workspaceImportDoesNotAutoGraph',
    'workspaceImportDoesNotAutoWriteSolution',
    'workspaceImportDoesNotAutoWriteHistory',
    'directCameraSolveBlocked',
    'directCameraGraphSolutionHistoryBlocked',
    'noPaddleRuntimeAddedInQ277',
    'noPaddleOcrDependencyAddedInQ277',
    'noNativeBridgeImplementationAddedInQ277',
    'noJniBindingAddedInQ277',
    'noMethodChannelRuntimeBindingAddedInQ277',
    'noModelBinaryBundledInQ277',
    'noProductionModelUrlBoundInQ277',
    'noRealNetworkDownloadWorkerInQ277',
    'noProductionInferenceInQ277',
    'noRealImageToLatexInferenceInQ277',
    'noCameraPassClaimedWithoutRealDeviceEvidence',
    'noOcrPassClaimedWithoutRealInferenceEvidence',
    'noPremiumFinalPassClaimedWithoutRealEvidence',
  ];

  static const List<String> blockedUntilRealEvidence = [
    'realFlutterPubGetLog',
    'realFlutterAnalyzeLog',
    'realFlutterTestLog',
    'realFlutterRunLog',
    'realAndroidCameraOpenEvidence',
    'realCameraCaptureEvidence',
    'realCropScanFrameEvidence',
    'realQ273CandidateEnvelopeEvidence',
    'realQ274MathLiveReviewBindingEvidence',
    'realQ275ApprovedWorkspaceImportEvidence',
    'realExplicitUserApprovalEvidence',
    'realNoAutoEvaluateEvidence',
    'realNoAutoSolveEvidence',
    'realNoAutoGraphEvidence',
    'realNoAutoSolutionEvidence',
    'realNoAutoHistoryEvidence',
    'realKeyboardRegressionEvidence',
    'realMoreRegressionEvidence',
    'realLongPressRegressionEvidence',
    'realMathLiveProductionRouteEvidence',
    'realGraphRegressionEvidence',
    'realSolutionRegressionEvidence',
    'realHistoryRegressionEvidence',
  ];

  static const List<String> forbiddenActions = [
    'changeKeyboardLayoutInQ277',
    'changeMoreInventoryOrOrderInQ277',
    'changeLongPressListsInQ277',
    'changeMathLiveProductionRouteInQ277',
    'reintroduceLegacyFlutterCursorRouteInQ277',
    'changeGraphSolutionHistoryRuntimeInQ277',
    'changeSplashOrLauncherIconInQ277',
    'changeSolverEvaluatorBehaviorInQ277',
    'addPaddleRuntimeDependencyInQ277',
    'addPaddleOcrDependencyInQ277',
    'addNativeBridgeImplementationInQ277',
    'addJniBindingInQ277',
    'bindRuntimeMethodChannelInQ277',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ277',
    'startRealNetworkDownloadInQ277',
    'runRealImageToLatexInferenceInQ277',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutputAfterImport',
    'autoGraphCameraOutputAfterImport',
    'autoWriteSolutionOrHistoryAfterImport',
    'claimCameraPassWithoutRealDeviceEvidence',
    'claimCameraOcrRuntimePassWithoutRealRuntimeEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'claimPremiumFinalPassWithoutRealEvidence',
    'claimReleasePassWithoutRealEvidence',
  ];
}
