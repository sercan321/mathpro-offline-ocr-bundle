import 'gauss_approved_ocr_workspace_import_runtime_court.dart';
import 'gauss_full_camera_ocr_runtime_premium_regression_policy.dart';

/// V172-Q286 — Full Camera/OCR Runtime Premium Regression.
///
/// This is still a regression court. It does not run PP-FormulaNet-S, does not
/// invoke a native bridge, does not mutate the workspace, and does not trigger
/// Solve/Graph/Solution/History from camera output.
enum GaussFullCameraOcrRuntimePremiumRegressionDecision {
  blockedMissingQ285ApprovedImportCourt,
  blockedMissingPreviousRuntimeEvidenceChain,
  blockedProtectedSurfaceRegression,
  blockedCameraShellRegression,
  blockedReviewApprovalRegression,
  blockedDirectWorkspaceMutationRisk,
  blockedAutoEvaluateSolveGraphSolutionHistoryRisk,
  blockedUnsafeRuntimeOrModelMutation,
  blockedFakePassClaim,
  readyForFutureFullRuntimeRegressionEvidenceOnly,
}

class GaussFullCameraOcrRuntimePremiumRegressionInput {
  const GaussFullCameraOcrRuntimePremiumRegressionInput({
    required this.q285ApprovedWorkspaceImportRuntimeCourtPresent,
    required this.q285ApprovedWorkspaceImportRuntimeCourtStaticReady,
    required this.q284EditableMathLiveReviewRuntimeBindingPresent,
    required this.q283ImageToLatexInferenceCourtPresent,
    required this.q282RuntimeSmokeCourtPresent,
    required this.q281PrivateArtifactLoadSmokePresent,
    required this.q280NativeRuntimeBridgeGatePresent,
    required this.q279DependencyTrialDefaultOffPresent,
    required this.q278RealRuntimeEvidenceLockPresent,
    required this.keyboardLayoutProtected,
    required this.moreTemplateTrayProtected,
    required this.longPressListsProtected,
    required this.mathLiveProductionRouteProtected,
    required this.graphSurfaceProtected,
    required this.solutionSurfaceProtected,
    required this.historySurfaceProtected,
    required this.appShellWorkspaceProtected,
    required this.splashIconProtected,
    required this.androidManifestMainActivityProtected,
    required this.cameraDependenciesProtected,
    required this.androidToolchainProtected,
    required this.cameraEntryButtonStillAvailable,
    required this.cameraPreviewStillAvailable,
    required this.cameraCaptureStillAvailable,
    required this.cropScanFrameMetadataStillAvailable,
    required this.editableMathLiveReviewStillRequired,
    required this.explicitUserApprovalStillRequired,
    required this.workspaceImportOnlyAfterApproval,
    required this.manualSolveGraphAfterImportOnly,
    required this.directWorkspaceMutationAttempted,
    required this.autoEvaluateAttempted,
    required this.autoSolveAttempted,
    required this.autoGraphAttempted,
    required this.autoSolutionAttempted,
    required this.autoHistoryAttempted,
    required this.realFullCameraOcrRuntimeRegressionExecutedInQ286,
    required this.realWorkspaceImportRuntimeExecutedInQ286,
    required this.realImageToLatexInferenceExecutedInQ286,
    required this.realRuntimeSmokeExecutedInQ286,
    required this.realRuntimeInvocationExecutedInQ286,
    required this.nativeRuntimeBridgeInvokedInQ286,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.runtimeDependencyAddedToPubspec,
    required this.gradleNativeRuntimeDependencyAdded,
    required this.nativeHandlerImplementationAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.productionDownloadEnabled,
    required this.realNetworkDownloadWorkerImplemented,
    required this.fullCameraOcrRuntimeRegressionPassClaimed,
    required this.workspaceImportRuntimePassClaimed,
    required this.reviewBindingPassClaimed,
    required this.imageToLatexPassClaimed,
    required this.runtimeSmokePassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.premiumFinalPassClaimed,
    required this.releasePassClaimed,
    required this.regressionLabel,
  });

  factory GaussFullCameraOcrRuntimePremiumRegressionInput.fromQ285Court({
    required GaussApprovedOcrWorkspaceImportRuntimeCourtResult q285Result,
    String regressionLabel = 'q286-full-camera-ocr-runtime-premium-regression',
  }) {
    return GaussFullCameraOcrRuntimePremiumRegressionInput(
      q285ApprovedWorkspaceImportRuntimeCourtPresent: true,
      q285ApprovedWorkspaceImportRuntimeCourtStaticReady: q285Result.workspaceImportRuntimeCourtStaticReady,
      q284EditableMathLiveReviewRuntimeBindingPresent: true,
      q283ImageToLatexInferenceCourtPresent: true,
      q282RuntimeSmokeCourtPresent: true,
      q281PrivateArtifactLoadSmokePresent: true,
      q280NativeRuntimeBridgeGatePresent: true,
      q279DependencyTrialDefaultOffPresent: true,
      q278RealRuntimeEvidenceLockPresent: true,
      keyboardLayoutProtected: true,
      moreTemplateTrayProtected: true,
      longPressListsProtected: true,
      mathLiveProductionRouteProtected: true,
      graphSurfaceProtected: true,
      solutionSurfaceProtected: true,
      historySurfaceProtected: true,
      appShellWorkspaceProtected: true,
      splashIconProtected: true,
      androidManifestMainActivityProtected: true,
      cameraDependenciesProtected: true,
      androidToolchainProtected: true,
      cameraEntryButtonStillAvailable: true,
      cameraPreviewStillAvailable: true,
      cameraCaptureStillAvailable: true,
      cropScanFrameMetadataStillAvailable: true,
      editableMathLiveReviewStillRequired: true,
      explicitUserApprovalStillRequired: true,
      workspaceImportOnlyAfterApproval: true,
      manualSolveGraphAfterImportOnly: true,
      directWorkspaceMutationAttempted: q285Result.canMutateWorkspaceInQ285,
      autoEvaluateAttempted: q285Result.canEvaluate,
      autoSolveAttempted: q285Result.canSolve,
      autoGraphAttempted: q285Result.canGraph,
      autoSolutionAttempted: q285Result.canWriteSolutionOrHistory,
      autoHistoryAttempted: q285Result.canWriteSolutionOrHistory,
      realFullCameraOcrRuntimeRegressionExecutedInQ286: false,
      realWorkspaceImportRuntimeExecutedInQ286: false,
      realImageToLatexInferenceExecutedInQ286: false,
      realRuntimeSmokeExecutedInQ286: false,
      realRuntimeInvocationExecutedInQ286: false,
      nativeRuntimeBridgeInvokedInQ286: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      runtimeDependencyAddedToPubspec: false,
      gradleNativeRuntimeDependencyAdded: false,
      nativeHandlerImplementationAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      productionDownloadEnabled: false,
      realNetworkDownloadWorkerImplemented: false,
      fullCameraOcrRuntimeRegressionPassClaimed: false,
      workspaceImportRuntimePassClaimed: q285Result.canClaimWorkspaceImportRuntimePassInQ285,
      reviewBindingPassClaimed: false,
      imageToLatexPassClaimed: false,
      runtimeSmokePassClaimed: false,
      ocrPassClaimed: q285Result.canClaimOcrPassInQ285,
      cameraOcrRuntimePassClaimed: false,
      premiumFinalPassClaimed: false,
      releasePassClaimed: false,
      regressionLabel: regressionLabel,
    );
  }

  final bool q285ApprovedWorkspaceImportRuntimeCourtPresent;
  final bool q285ApprovedWorkspaceImportRuntimeCourtStaticReady;
  final bool q284EditableMathLiveReviewRuntimeBindingPresent;
  final bool q283ImageToLatexInferenceCourtPresent;
  final bool q282RuntimeSmokeCourtPresent;
  final bool q281PrivateArtifactLoadSmokePresent;
  final bool q280NativeRuntimeBridgeGatePresent;
  final bool q279DependencyTrialDefaultOffPresent;
  final bool q278RealRuntimeEvidenceLockPresent;
  final bool keyboardLayoutProtected;
  final bool moreTemplateTrayProtected;
  final bool longPressListsProtected;
  final bool mathLiveProductionRouteProtected;
  final bool graphSurfaceProtected;
  final bool solutionSurfaceProtected;
  final bool historySurfaceProtected;
  final bool appShellWorkspaceProtected;
  final bool splashIconProtected;
  final bool androidManifestMainActivityProtected;
  final bool cameraDependenciesProtected;
  final bool androidToolchainProtected;
  final bool cameraEntryButtonStillAvailable;
  final bool cameraPreviewStillAvailable;
  final bool cameraCaptureStillAvailable;
  final bool cropScanFrameMetadataStillAvailable;
  final bool editableMathLiveReviewStillRequired;
  final bool explicitUserApprovalStillRequired;
  final bool workspaceImportOnlyAfterApproval;
  final bool manualSolveGraphAfterImportOnly;
  final bool directWorkspaceMutationAttempted;
  final bool autoEvaluateAttempted;
  final bool autoSolveAttempted;
  final bool autoGraphAttempted;
  final bool autoSolutionAttempted;
  final bool autoHistoryAttempted;
  final bool realFullCameraOcrRuntimeRegressionExecutedInQ286;
  final bool realWorkspaceImportRuntimeExecutedInQ286;
  final bool realImageToLatexInferenceExecutedInQ286;
  final bool realRuntimeSmokeExecutedInQ286;
  final bool realRuntimeInvocationExecutedInQ286;
  final bool nativeRuntimeBridgeInvokedInQ286;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool runtimeDependencyAddedToPubspec;
  final bool gradleNativeRuntimeDependencyAdded;
  final bool nativeHandlerImplementationAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool productionDownloadEnabled;
  final bool realNetworkDownloadWorkerImplemented;
  final bool fullCameraOcrRuntimeRegressionPassClaimed;
  final bool workspaceImportRuntimePassClaimed;
  final bool reviewBindingPassClaimed;
  final bool imageToLatexPassClaimed;
  final bool runtimeSmokePassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool premiumFinalPassClaimed;
  final bool releasePassClaimed;
  final String regressionLabel;
}

class GaussFullCameraOcrRuntimePremiumRegressionResult {
  const GaussFullCameraOcrRuntimePremiumRegressionResult._({
    required this.decision,
    required this.fullRegressionCourtStaticReady,
    required this.readyForFutureFullRuntimeRegressionEvidenceOnly,
    required this.rejectionReasons,
    required this.canRunRealOcrInQ286,
    required this.canMutateWorkspaceFromCameraInQ286,
    required this.canEvaluateFromCameraInQ286,
    required this.canSolveFromCameraInQ286,
    required this.canGraphFromCameraInQ286,
    required this.canWriteSolutionOrHistoryFromCameraInQ286,
    required this.canClaimFullCameraOcrRuntimeRegressionPassInQ286,
    required this.canClaimOcrPassInQ286,
    required this.regressionLabel,
  });

  final GaussFullCameraOcrRuntimePremiumRegressionDecision decision;
  final bool fullRegressionCourtStaticReady;
  final bool readyForFutureFullRuntimeRegressionEvidenceOnly;
  final List<String> rejectionReasons;
  final bool canRunRealOcrInQ286;
  final bool canMutateWorkspaceFromCameraInQ286;
  final bool canEvaluateFromCameraInQ286;
  final bool canSolveFromCameraInQ286;
  final bool canGraphFromCameraInQ286;
  final bool canWriteSolutionOrHistoryFromCameraInQ286;
  final bool canClaimFullCameraOcrRuntimeRegressionPassInQ286;
  final bool canClaimOcrPassInQ286;
  final String regressionLabel;

  String get phase => GaussFullCameraOcrRuntimePremiumRegressionPolicy.phase;
  String get sourcePhase => GaussFullCameraOcrRuntimePremiumRegressionPolicy.sourcePhase;
  String get selectedEngineLabel => GaussFullCameraOcrRuntimePremiumRegressionPolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussFullCameraOcrRuntimePremiumRegressionPolicy.fallbackEngineLabel;
  String get regressionMode => GaussFullCameraOcrRuntimePremiumRegressionPolicy.regressionMode;
  bool get realFullCameraOcrRuntimeRegressionExecutedInQ286 => GaussFullCameraOcrRuntimePremiumRegressionPolicy.realFullCameraOcrRuntimeRegressionExecutedInQ286;
  bool get realImageToLatexInferenceExecutedInQ286 => GaussFullCameraOcrRuntimePremiumRegressionPolicy.realImageToLatexInferenceExecutedInQ286;
  bool get realRuntimeInvocationExecutedInQ286 => GaussFullCameraOcrRuntimePremiumRegressionPolicy.realRuntimeInvocationExecutedInQ286;
  bool get modelBinaryBundledInBaseApp => GaussFullCameraOcrRuntimePremiumRegressionPolicy.modelBinaryBundledInBaseApp;
  bool get ocrPassClaimed => GaussFullCameraOcrRuntimePremiumRegressionPolicy.ocrPassClaimed;
  List<String> get requiredFullRegressionGates => GaussFullCameraOcrRuntimePremiumRegressionPolicy.requiredFullRegressionGates;
  List<String> get blockedUntilRealEvidence => GaussFullCameraOcrRuntimePremiumRegressionPolicy.blockedUntilRealEvidence;
  List<String> get regressionCourtCases => GaussFullCameraOcrRuntimePremiumRegressionPolicy.regressionCourtCases;
  List<String> get forbiddenActions => GaussFullCameraOcrRuntimePremiumRegressionPolicy.forbiddenActions;
}

class GaussFullCameraOcrRuntimePremiumRegression {
  const GaussFullCameraOcrRuntimePremiumRegression._();

  static GaussFullCameraOcrRuntimePremiumRegressionResult evaluate(GaussFullCameraOcrRuntimePremiumRegressionInput input) {
    GaussFullCameraOcrRuntimePremiumRegressionResult reject(GaussFullCameraOcrRuntimePremiumRegressionDecision decision, String reason) {
      return GaussFullCameraOcrRuntimePremiumRegressionResult._(
        decision: decision,
        fullRegressionCourtStaticReady: false,
        readyForFutureFullRuntimeRegressionEvidenceOnly: false,
        rejectionReasons: <String>[reason],
        canRunRealOcrInQ286: false,
        canMutateWorkspaceFromCameraInQ286: false,
        canEvaluateFromCameraInQ286: false,
        canSolveFromCameraInQ286: false,
        canGraphFromCameraInQ286: false,
        canWriteSolutionOrHistoryFromCameraInQ286: false,
        canClaimFullCameraOcrRuntimeRegressionPassInQ286: false,
        canClaimOcrPassInQ286: false,
        regressionLabel: input.regressionLabel,
      );
    }

    if (!input.q285ApprovedWorkspaceImportRuntimeCourtPresent || !input.q285ApprovedWorkspaceImportRuntimeCourtStaticReady) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedMissingQ285ApprovedImportCourt, 'missingQ285ApprovedWorkspaceImportRuntimeCourt');
    }
    final previousEvidenceChainPresent = input.q284EditableMathLiveReviewRuntimeBindingPresent &&
        input.q283ImageToLatexInferenceCourtPresent &&
        input.q282RuntimeSmokeCourtPresent &&
        input.q281PrivateArtifactLoadSmokePresent &&
        input.q280NativeRuntimeBridgeGatePresent &&
        input.q279DependencyTrialDefaultOffPresent &&
        input.q278RealRuntimeEvidenceLockPresent;
    if (!previousEvidenceChainPresent) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedMissingPreviousRuntimeEvidenceChain, 'missingPreviousRuntimeEvidenceChain');
    }
    final protectedSurfacesClean = input.keyboardLayoutProtected &&
        input.moreTemplateTrayProtected &&
        input.longPressListsProtected &&
        input.mathLiveProductionRouteProtected &&
        input.graphSurfaceProtected &&
        input.solutionSurfaceProtected &&
        input.historySurfaceProtected &&
        input.appShellWorkspaceProtected &&
        input.splashIconProtected &&
        input.androidManifestMainActivityProtected &&
        input.cameraDependenciesProtected &&
        input.androidToolchainProtected;
    if (!protectedSurfacesClean) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedProtectedSurfaceRegression, 'protectedSurfaceRegression');
    }
    if (!input.cameraEntryButtonStillAvailable || !input.cameraPreviewStillAvailable || !input.cameraCaptureStillAvailable || !input.cropScanFrameMetadataStillAvailable) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedCameraShellRegression, 'cameraShellRegression');
    }
    if (!input.editableMathLiveReviewStillRequired || !input.explicitUserApprovalStillRequired || !input.workspaceImportOnlyAfterApproval || !input.manualSolveGraphAfterImportOnly) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedReviewApprovalRegression, 'reviewApprovalRegression');
    }
    if (input.directWorkspaceMutationAttempted) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedDirectWorkspaceMutationRisk, 'directWorkspaceMutationRisk');
    }
    if (input.autoEvaluateAttempted || input.autoSolveAttempted || input.autoGraphAttempted || input.autoSolutionAttempted || input.autoHistoryAttempted) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedAutoEvaluateSolveGraphSolutionHistoryRisk, 'autoEvaluateSolveGraphSolutionHistoryRisk');
    }
    final unsafeRuntimeMutation = input.realFullCameraOcrRuntimeRegressionExecutedInQ286 ||
        input.realWorkspaceImportRuntimeExecutedInQ286 ||
        input.realImageToLatexInferenceExecutedInQ286 ||
        input.realRuntimeSmokeExecutedInQ286 ||
        input.realRuntimeInvocationExecutedInQ286 ||
        input.nativeRuntimeBridgeInvokedInQ286 ||
        input.paddleRuntimeAdded ||
        input.paddleOcrDependencyAdded ||
        input.runtimeDependencyAddedToPubspec ||
        input.gradleNativeRuntimeDependencyAdded ||
        input.nativeHandlerImplementationAdded ||
        input.jniBindingAdded ||
        input.methodChannelRuntimeBindingAdded ||
        input.modelBinaryBundledInBaseApp ||
        input.productionModelUrlBound ||
        input.productionDownloadEnabled ||
        input.realNetworkDownloadWorkerImplemented;
    if (unsafeRuntimeMutation) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedUnsafeRuntimeOrModelMutation, 'unsafeRuntimeOrModelMutation');
    }
    final fakePassClaim = input.fullCameraOcrRuntimeRegressionPassClaimed ||
        input.workspaceImportRuntimePassClaimed ||
        input.reviewBindingPassClaimed ||
        input.imageToLatexPassClaimed ||
        input.runtimeSmokePassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.premiumFinalPassClaimed ||
        input.releasePassClaimed;
    if (fakePassClaim) {
      return reject(GaussFullCameraOcrRuntimePremiumRegressionDecision.blockedFakePassClaim, 'fakePassClaim');
    }

    return GaussFullCameraOcrRuntimePremiumRegressionResult._(
      decision: GaussFullCameraOcrRuntimePremiumRegressionDecision.readyForFutureFullRuntimeRegressionEvidenceOnly,
      fullRegressionCourtStaticReady: true,
      readyForFutureFullRuntimeRegressionEvidenceOnly: true,
      rejectionReasons: const <String>[],
      canRunRealOcrInQ286: false,
      canMutateWorkspaceFromCameraInQ286: false,
      canEvaluateFromCameraInQ286: false,
      canSolveFromCameraInQ286: false,
      canGraphFromCameraInQ286: false,
      canWriteSolutionOrHistoryFromCameraInQ286: false,
      canClaimFullCameraOcrRuntimeRegressionPassInQ286: false,
      canClaimOcrPassInQ286: false,
      regressionLabel: input.regressionLabel,
    );
  }
}
