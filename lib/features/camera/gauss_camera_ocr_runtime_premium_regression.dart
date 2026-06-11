// V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION
import 'gauss_camera_ocr_runtime_premium_regression_policy.dart';

enum GaussCameraOcrRuntimePremiumRegressionDecision {
  blockedMissingQ276DeviceCourt,
  blockedProtectedSurfaceRegressionRisk,
  blockedMathLiveProductionRouteRegression,
  blockedGraphSolutionHistoryRegression,
  blockedReviewOrApprovalRegression,
  blockedDirectAutoActionRisk,
  blockedUnsafeRuntimeOrPassClaim,
  readyForFutureRuntimePremiumRegressionOnly,
}

class GaussCameraOcrRuntimePremiumRegressionInput {
  const GaussCameraOcrRuntimePremiumRegressionInput({
    required this.q276CameraOcrRealEndToEndDeviceCourtPresent,
    required this.keyboardLayoutStable,
    required this.moreTemplateTrayStable,
    required this.longPressListsStable,
    required this.mathLiveProductionRouteStable,
    required this.legacyFlutterCursorRouteAbsent,
    required this.graphSurfaceStable,
    required this.solutionSurfaceStable,
    required this.historySurfaceStable,
    required this.cameraShellRuntimeStable,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.autoEvaluateAfterImport,
    required this.autoSolveAfterImport,
    required this.autoGraphAfterImport,
    required this.autoSolutionAfterImport,
    required this.autoHistoryAfterImport,
    required this.directCameraSolveBlocked,
    required this.directCameraGraphSolutionHistoryBlocked,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.nativeBridgeImplementationAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.productionInferenceAllowed,
    required this.realImageToLatexInferenceExecuted,
    required this.cameraPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.ocrPassClaimed,
    required this.premiumFinalPassClaimed,
    required this.releasePassClaimed,
  });

  final bool q276CameraOcrRealEndToEndDeviceCourtPresent;
  final bool keyboardLayoutStable;
  final bool moreTemplateTrayStable;
  final bool longPressListsStable;
  final bool mathLiveProductionRouteStable;
  final bool legacyFlutterCursorRouteAbsent;
  final bool graphSurfaceStable;
  final bool solutionSurfaceStable;
  final bool historySurfaceStable;
  final bool cameraShellRuntimeStable;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool autoEvaluateAfterImport;
  final bool autoSolveAfterImport;
  final bool autoGraphAfterImport;
  final bool autoSolutionAfterImport;
  final bool autoHistoryAfterImport;
  final bool directCameraSolveBlocked;
  final bool directCameraGraphSolutionHistoryBlocked;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool nativeBridgeImplementationAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool productionInferenceAllowed;
  final bool realImageToLatexInferenceExecuted;
  final bool cameraPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool ocrPassClaimed;
  final bool premiumFinalPassClaimed;
  final bool releasePassClaimed;
}

class GaussCameraOcrRuntimePremiumRegressionResult {
  const GaussCameraOcrRuntimePremiumRegressionResult({
    required this.decision,
    required this.input,
  });

  final GaussCameraOcrRuntimePremiumRegressionDecision decision;
  final GaussCameraOcrRuntimePremiumRegressionInput input;

  String get phase => GaussCameraOcrRuntimePremiumRegressionPolicy.phase;
  String get sourcePhase => GaussCameraOcrRuntimePremiumRegressionPolicy.sourcePhase;
  String get selectedEngineLabel => GaussCameraOcrRuntimePremiumRegressionPolicy.selectedEngineLabel;
  String get regressionMode => GaussCameraOcrRuntimePremiumRegressionPolicy.regressionMode;
  List<String> get protectedRuntimeSurfaces => GaussCameraOcrRuntimePremiumRegressionPolicy.protectedRuntimeSurfaces;
  List<String> get requiredRegressionGates => GaussCameraOcrRuntimePremiumRegressionPolicy.requiredRegressionGates;
  List<String> get blockedUntilRealEvidence => GaussCameraOcrRuntimePremiumRegressionPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussCameraOcrRuntimePremiumRegressionPolicy.forbiddenActions;

  bool get staticReadyForFutureRegressionOnly => decision == GaussCameraOcrRuntimePremiumRegressionDecision.readyForFutureRuntimePremiumRegressionOnly;
  bool get realOcrRuntimeAdded => GaussCameraOcrRuntimePremiumRegressionPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussCameraOcrRuntimePremiumRegressionPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussCameraOcrRuntimePremiumRegressionPolicy.paddleOcrDependencyAdded;
  bool get productionInferenceAllowed => GaussCameraOcrRuntimePremiumRegressionPolicy.productionInferenceAllowed;
  bool get cameraOcrRuntimePassClaimed => GaussCameraOcrRuntimePremiumRegressionPolicy.cameraOcrRuntimePassClaimed;
  bool get ocrPassClaimed => GaussCameraOcrRuntimePremiumRegressionPolicy.ocrPassClaimed;
  bool get premiumFinalPassClaimed => GaussCameraOcrRuntimePremiumRegressionPolicy.premiumFinalPassClaimed;
  bool get releasePassClaimed => GaussCameraOcrRuntimePremiumRegressionPolicy.releasePassClaimed;
}

class GaussCameraOcrRuntimePremiumRegression {
  const GaussCameraOcrRuntimePremiumRegression._();

  static GaussCameraOcrRuntimePremiumRegressionResult evaluate(GaussCameraOcrRuntimePremiumRegressionInput input) {
    if (!input.q276CameraOcrRealEndToEndDeviceCourtPresent) {
      return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.blockedMissingQ276DeviceCourt, input: input);
    }
    if (!input.keyboardLayoutStable || !input.moreTemplateTrayStable || !input.longPressListsStable || !input.cameraShellRuntimeStable) {
      return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.blockedProtectedSurfaceRegressionRisk, input: input);
    }
    if (!input.mathLiveProductionRouteStable || !input.legacyFlutterCursorRouteAbsent) {
      return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.blockedMathLiveProductionRouteRegression, input: input);
    }
    if (!input.graphSurfaceStable || !input.solutionSurfaceStable || !input.historySurfaceStable) {
      return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.blockedGraphSolutionHistoryRegression, input: input);
    }
    if (!input.editableMathLiveReviewRequired || !input.explicitUserApprovalRequiredBeforeWorkspaceImport) {
      return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.blockedReviewOrApprovalRegression, input: input);
    }
    if (input.autoEvaluateAfterImport || input.autoSolveAfterImport || input.autoGraphAfterImport || input.autoSolutionAfterImport || input.autoHistoryAfterImport || !input.directCameraSolveBlocked || !input.directCameraGraphSolutionHistoryBlocked) {
      return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.blockedDirectAutoActionRisk, input: input);
    }
    if (input.realOcrRuntimeAdded || input.paddleRuntimeAdded || input.paddleOcrDependencyAdded || input.nativeBridgeImplementationAdded || input.jniBindingAdded || input.methodChannelRuntimeBindingAdded || input.modelBinaryBundledInBaseApp || input.productionModelUrlBound || input.realNetworkDownloadWorkerImplemented || input.productionDownloadEnabled || input.productionInferenceAllowed || input.realImageToLatexInferenceExecuted || input.cameraPassClaimed || input.cameraOcrRuntimePassClaimed || input.ocrPassClaimed || input.premiumFinalPassClaimed || input.releasePassClaimed) {
      return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.blockedUnsafeRuntimeOrPassClaim, input: input);
    }
    return GaussCameraOcrRuntimePremiumRegressionResult(decision: GaussCameraOcrRuntimePremiumRegressionDecision.readyForFutureRuntimePremiumRegressionOnly, input: input);
  }
}
