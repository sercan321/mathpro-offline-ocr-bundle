import 'gauss_approved_ocr_workspace_import_real_runtime.dart';
import 'gauss_full_real_camera_ocr_regression_policy.dart';

/// V172-Q298 — Full Real Camera/OCR Regression.
///
/// Contract-only regression court. It verifies that the future Camera/OCR path
/// remains review-first and approval-first without adding a runtime, invoking
/// PP-FormulaNet-S, mutating the workspace, or claiming OCR/runtime PASS.
enum GaussFullRealCameraOcrRegressionDecision {
  fullRegressionContractReadyRealRuntimeBlocked,
  blockedMissingQ297ApprovedWorkspaceImport,
  blockedMissingPreviousRuntimeEvidenceChain,
  blockedProtectedSurfaceRegression,
  blockedCameraShellRegression,
  blockedReviewApprovalRegression,
  blockedDirectWorkspaceMutationRisk,
  blockedRuntimeDependencyMutationRisk,
  blockedFakePassClaim,
}

class GaussFullRealCameraOcrRegressionInput {
  const GaussFullRealCameraOcrRegressionInput({
    required this.q297ApprovedWorkspaceImportPresent,
    required this.q297ApprovedWorkspaceImportStaticReady,
    required this.q296EditableMathLiveReviewPresent,
    required this.q295ImageToLatexInferencePresent,
    required this.q294DummyInputRuntimeCallPresent,
    required this.q293RuntimeStartupSmokePresent,
    required this.q292PrivateArtifactLoadSmokePresent,
    required this.q291PrivateModelDownloadShaPresent,
    required this.q290NativeHandlerAndroidBindingPresent,
    required this.q289RuntimeDependencyTrialDefaultOffPresent,
    required this.q288ArtifactSourceIntakePresent,
    required this.keyboardLayoutProtected,
    required this.moreTemplateTrayProtected,
    required this.longPressListsProtected,
    required this.mathLiveProductionRouteProtected,
    required this.mathLiveBridgeProtected,
    required this.graphSurfaceProtected,
    required this.solutionSurfaceProtected,
    required this.historySurfaceProtected,
    required this.appShellWorkspaceProtected,
    required this.splashIconProtected,
    required this.androidManifestMainActivityProtected,
    required this.cameraDependenciesProtected,
    required this.androidToolchainProtected,
    required this.cameraShellRuntimeProtected,
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
    required this.fullRealCameraOcrRegressionExecutedInQ298,
    required this.realWorkspaceImportRuntimeExecutedInQ298,
    required this.realEditableMathLiveReviewOpenedInQ298,
    required this.realImageToLatexInferenceExecutedInQ298,
    required this.realRuntimeInvocationExecutedInQ298,
    required this.nativeRuntimeBridgeInvokedInQ298,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.runtimeDependencyAddedToPubspec,
    required this.gradleNativeRuntimeDependencyAdded,
    required this.nativeHandlerImplementationAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.fullRegressionPassClaimed,
    required this.workspaceImportPassClaimed,
    required this.reviewBindingPassClaimed,
    required this.imageToLatexPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.premiumFinalPassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.regressionLabel,
  });

  factory GaussFullRealCameraOcrRegressionInput.fromQ297Contract({
    required GaussApprovedOcrWorkspaceImportRealRuntimeResult q297Result,
    String regressionLabel = 'q298-full-real-camera-ocr-regression',
  }) {
    return GaussFullRealCameraOcrRegressionInput(
      q297ApprovedWorkspaceImportPresent: true,
      q297ApprovedWorkspaceImportStaticReady: q297Result.decision == GaussApprovedOcrWorkspaceImportRealRuntimeDecision.approvedWorkspaceImportContractReadyRealImportBlocked,
      q296EditableMathLiveReviewPresent: true,
      q295ImageToLatexInferencePresent: true,
      q294DummyInputRuntimeCallPresent: true,
      q293RuntimeStartupSmokePresent: true,
      q292PrivateArtifactLoadSmokePresent: true,
      q291PrivateModelDownloadShaPresent: true,
      q290NativeHandlerAndroidBindingPresent: true,
      q289RuntimeDependencyTrialDefaultOffPresent: true,
      q288ArtifactSourceIntakePresent: true,
      keyboardLayoutProtected: true,
      moreTemplateTrayProtected: true,
      longPressListsProtected: true,
      mathLiveProductionRouteProtected: true,
      mathLiveBridgeProtected: true,
      graphSurfaceProtected: true,
      solutionSurfaceProtected: true,
      historySurfaceProtected: true,
      appShellWorkspaceProtected: true,
      splashIconProtected: true,
      androidManifestMainActivityProtected: true,
      cameraDependenciesProtected: true,
      androidToolchainProtected: true,
      cameraShellRuntimeProtected: true,
      cameraEntryButtonStillAvailable: true,
      cameraPreviewStillAvailable: true,
      cameraCaptureStillAvailable: true,
      cropScanFrameMetadataStillAvailable: true,
      editableMathLiveReviewStillRequired: true,
      explicitUserApprovalStillRequired: true,
      workspaceImportOnlyAfterApproval: true,
      manualSolveGraphAfterImportOnly: true,
      directWorkspaceMutationAttempted: q297Result.directWorkspaceImportEnabled,
      autoEvaluateAttempted: q297Result.autoEvaluateEnabled,
      autoSolveAttempted: q297Result.autoSolveGraphSolutionHistoryEnabled,
      autoGraphAttempted: q297Result.autoSolveGraphSolutionHistoryEnabled,
      autoSolutionAttempted: q297Result.autoSolveGraphSolutionHistoryEnabled,
      autoHistoryAttempted: q297Result.autoSolveGraphSolutionHistoryEnabled,
      fullRealCameraOcrRegressionExecutedInQ298: false,
      realWorkspaceImportRuntimeExecutedInQ298: q297Result.realWorkspaceImportRuntimeExecuted,
      realEditableMathLiveReviewOpenedInQ298: q297Result.realEditableMathLiveReviewOpened,
      realImageToLatexInferenceExecutedInQ298: false,
      realRuntimeInvocationExecutedInQ298: false,
      nativeRuntimeBridgeInvokedInQ298: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      runtimeDependencyAddedToPubspec: false,
      gradleNativeRuntimeDependencyAdded: false,
      nativeHandlerImplementationAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionDownloadEnabled: false,
      fullRegressionPassClaimed: false,
      workspaceImportPassClaimed: q297Result.workspaceImportPassClaimed,
      reviewBindingPassClaimed: false,
      imageToLatexPassClaimed: false,
      ocrPassClaimed: q297Result.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: false,
      premiumFinalPassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      regressionLabel: regressionLabel,
    );
  }

  final bool q297ApprovedWorkspaceImportPresent;
  final bool q297ApprovedWorkspaceImportStaticReady;
  final bool q296EditableMathLiveReviewPresent;
  final bool q295ImageToLatexInferencePresent;
  final bool q294DummyInputRuntimeCallPresent;
  final bool q293RuntimeStartupSmokePresent;
  final bool q292PrivateArtifactLoadSmokePresent;
  final bool q291PrivateModelDownloadShaPresent;
  final bool q290NativeHandlerAndroidBindingPresent;
  final bool q289RuntimeDependencyTrialDefaultOffPresent;
  final bool q288ArtifactSourceIntakePresent;
  final bool keyboardLayoutProtected;
  final bool moreTemplateTrayProtected;
  final bool longPressListsProtected;
  final bool mathLiveProductionRouteProtected;
  final bool mathLiveBridgeProtected;
  final bool graphSurfaceProtected;
  final bool solutionSurfaceProtected;
  final bool historySurfaceProtected;
  final bool appShellWorkspaceProtected;
  final bool splashIconProtected;
  final bool androidManifestMainActivityProtected;
  final bool cameraDependenciesProtected;
  final bool androidToolchainProtected;
  final bool cameraShellRuntimeProtected;
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
  final bool fullRealCameraOcrRegressionExecutedInQ298;
  final bool realWorkspaceImportRuntimeExecutedInQ298;
  final bool realEditableMathLiveReviewOpenedInQ298;
  final bool realImageToLatexInferenceExecutedInQ298;
  final bool realRuntimeInvocationExecutedInQ298;
  final bool nativeRuntimeBridgeInvokedInQ298;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool runtimeDependencyAddedToPubspec;
  final bool gradleNativeRuntimeDependencyAdded;
  final bool nativeHandlerImplementationAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool fullRegressionPassClaimed;
  final bool workspaceImportPassClaimed;
  final bool reviewBindingPassClaimed;
  final bool imageToLatexPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool premiumFinalPassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String regressionLabel;
}

class GaussFullRealCameraOcrRegressionResult {
  const GaussFullRealCameraOcrRegressionResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.regressionFeatureFlag,
    required this.regressionReadinessState,
    required this.fullRegressionCourtStaticReady,
    required this.readyForFutureFullRuntimeRegressionEvidenceOnly,
    required this.decision,
    required this.rejectionReasons,
    required this.requiredRegressionGates,
    required this.regressionCourtCases,
    required this.blockedUntilRealEvidence,
    required this.forbiddenActions,
    required this.fullRealCameraOcrRegressionExecuted,
    required this.realWorkspaceImportRuntimeExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.nativeRuntimeStartupExecuted,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.fullRegressionPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.releasePassClaimed,
    required this.regressionLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String regressionFeatureFlag;
  final String regressionReadinessState;
  final bool fullRegressionCourtStaticReady;
  final bool readyForFutureFullRuntimeRegressionEvidenceOnly;
  final GaussFullRealCameraOcrRegressionDecision decision;
  final List<String> rejectionReasons;
  final List<String> requiredRegressionGates;
  final List<String> regressionCourtCases;
  final List<String> blockedUntilRealEvidence;
  final List<String> forbiddenActions;
  final bool fullRealCameraOcrRegressionExecuted;
  final bool realWorkspaceImportRuntimeExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool nativeRuntimeStartupExecuted;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool fullRegressionPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool releasePassClaimed;
  final String regressionLabel;

  bool get canRunRealOcrInQ298 => false;
  bool get canMutateWorkspaceFromCameraInQ298 => false;
  bool get canEvaluateFromCameraInQ298 => false;
  bool get canSolveFromCameraInQ298 => false;
  bool get canGraphFromCameraInQ298 => false;
  bool get canWriteSolutionOrHistoryFromCameraInQ298 => false;
  bool get canClaimFullCameraOcrRegressionPassInQ298 => false;
  bool get canClaimOcrPassInQ298 => false;
}

class GaussFullRealCameraOcrRegression {
  const GaussFullRealCameraOcrRegression._();

  static GaussFullRealCameraOcrRegressionResult evaluate(GaussFullRealCameraOcrRegressionInput input) {
    final rejections = <String>[];
    if (!input.q297ApprovedWorkspaceImportPresent || !input.q297ApprovedWorkspaceImportStaticReady) {
      rejections.add('missingQ297ApprovedOcrWorkspaceImportRealRuntime');
    }
    if (!input.q296EditableMathLiveReviewPresent || !input.q295ImageToLatexInferencePresent || !input.q294DummyInputRuntimeCallPresent || !input.q293RuntimeStartupSmokePresent || !input.q292PrivateArtifactLoadSmokePresent || !input.q291PrivateModelDownloadShaPresent || !input.q290NativeHandlerAndroidBindingPresent || !input.q289RuntimeDependencyTrialDefaultOffPresent || !input.q288ArtifactSourceIntakePresent) {
      rejections.add('missingPreviousRuntimeEvidenceChain');
    }
    if (!input.keyboardLayoutProtected || !input.moreTemplateTrayProtected || !input.longPressListsProtected || !input.mathLiveProductionRouteProtected || !input.mathLiveBridgeProtected || !input.graphSurfaceProtected || !input.solutionSurfaceProtected || !input.historySurfaceProtected || !input.appShellWorkspaceProtected || !input.splashIconProtected || !input.androidManifestMainActivityProtected || !input.cameraDependenciesProtected || !input.androidToolchainProtected) {
      rejections.add('protectedSurfaceRegression');
    }
    if (!input.cameraShellRuntimeProtected || !input.cameraEntryButtonStillAvailable || !input.cameraPreviewStillAvailable || !input.cameraCaptureStillAvailable || !input.cropScanFrameMetadataStillAvailable) {
      rejections.add('cameraShellRegression');
    }
    if (!input.editableMathLiveReviewStillRequired || !input.explicitUserApprovalStillRequired || !input.workspaceImportOnlyAfterApproval || !input.manualSolveGraphAfterImportOnly) {
      rejections.add('reviewApprovalRegression');
    }
    if (input.directWorkspaceMutationAttempted || input.autoEvaluateAttempted || input.autoSolveAttempted || input.autoGraphAttempted || input.autoSolutionAttempted || input.autoHistoryAttempted) {
      rejections.add('directWorkspaceMutationOrAutomaticSideEffectRisk');
    }
    if (input.paddleRuntimeAdded || input.paddleOcrDependencyAdded || input.runtimeDependencyAddedToPubspec || input.gradleNativeRuntimeDependencyAdded || input.nativeHandlerImplementationAdded || input.jniBindingAdded || input.methodChannelRuntimeBindingAdded || input.modelBinaryBundledInBaseApp || input.productionDownloadEnabled || input.realRuntimeInvocationExecutedInQ298 || input.nativeRuntimeBridgeInvokedInQ298) {
      rejections.add('runtimeDependencyOrInvocationMutationRisk');
    }
    if (input.fullRealCameraOcrRegressionExecutedInQ298 || input.realWorkspaceImportRuntimeExecutedInQ298 || input.realEditableMathLiveReviewOpenedInQ298 || input.realImageToLatexInferenceExecutedInQ298 || input.fullRegressionPassClaimed || input.workspaceImportPassClaimed || input.reviewBindingPassClaimed || input.imageToLatexPassClaimed || input.ocrPassClaimed || input.cameraOcrRuntimePassClaimed || input.premiumFinalPassClaimed || input.storeReadyPassClaimed || input.releasePassClaimed) {
      rejections.add('fakePassClaimOrRealRuntimeClaim');
    }

    final decision = rejections.contains('missingQ297ApprovedOcrWorkspaceImportRealRuntime')
        ? GaussFullRealCameraOcrRegressionDecision.blockedMissingQ297ApprovedWorkspaceImport
        : rejections.contains('missingPreviousRuntimeEvidenceChain')
            ? GaussFullRealCameraOcrRegressionDecision.blockedMissingPreviousRuntimeEvidenceChain
            : rejections.contains('protectedSurfaceRegression')
                ? GaussFullRealCameraOcrRegressionDecision.blockedProtectedSurfaceRegression
                : rejections.contains('cameraShellRegression')
                    ? GaussFullRealCameraOcrRegressionDecision.blockedCameraShellRegression
                    : rejections.contains('reviewApprovalRegression')
                        ? GaussFullRealCameraOcrRegressionDecision.blockedReviewApprovalRegression
                        : rejections.contains('directWorkspaceMutationOrAutomaticSideEffectRisk')
                            ? GaussFullRealCameraOcrRegressionDecision.blockedDirectWorkspaceMutationRisk
                            : rejections.contains('runtimeDependencyOrInvocationMutationRisk')
                                ? GaussFullRealCameraOcrRegressionDecision.blockedRuntimeDependencyMutationRisk
                                : rejections.contains('fakePassClaimOrRealRuntimeClaim')
                                    ? GaussFullRealCameraOcrRegressionDecision.blockedFakePassClaim
                                    : GaussFullRealCameraOcrRegressionDecision.fullRegressionContractReadyRealRuntimeBlocked;

    final staticReady = rejections.isEmpty;
    return GaussFullRealCameraOcrRegressionResult(
      phase: GaussFullRealCameraOcrRegressionPolicy.phase,
      sourcePhase: GaussFullRealCameraOcrRegressionPolicy.sourcePhase,
      selectedEngineLabel: GaussFullRealCameraOcrRegressionPolicy.selectedEngineLabel,
      regressionFeatureFlag: GaussFullRealCameraOcrRegressionPolicy.regressionFeatureFlag,
      regressionReadinessState: GaussFullRealCameraOcrRegressionPolicy.regressionReadinessState,
      fullRegressionCourtStaticReady: staticReady,
      readyForFutureFullRuntimeRegressionEvidenceOnly: staticReady,
      decision: decision,
      rejectionReasons: rejections,
      requiredRegressionGates: GaussFullRealCameraOcrRegressionPolicy.requiredRegressionGates,
      regressionCourtCases: GaussFullRealCameraOcrRegressionPolicy.regressionCourtCases,
      blockedUntilRealEvidence: GaussFullRealCameraOcrRegressionPolicy.blockedUntilRealEvidence,
      forbiddenActions: GaussFullRealCameraOcrRegressionPolicy.forbiddenActions,
      fullRealCameraOcrRegressionExecuted: GaussFullRealCameraOcrRegressionPolicy.fullRealCameraOcrRegressionExecuted,
      realWorkspaceImportRuntimeExecuted: GaussFullRealCameraOcrRegressionPolicy.realWorkspaceImportRuntimeExecuted,
      realImageToLatexInferenceExecuted: GaussFullRealCameraOcrRegressionPolicy.realImageToLatexInferenceExecuted,
      nativeRuntimeStartupExecuted: GaussFullRealCameraOcrRegressionPolicy.nativeRuntimeStartupExecuted,
      methodChannelRuntimeBindingAdded: GaussFullRealCameraOcrRegressionPolicy.methodChannelRuntimeBindingAdded,
      modelBinaryBundledInBaseApp: GaussFullRealCameraOcrRegressionPolicy.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: GaussFullRealCameraOcrRegressionPolicy.productionDownloadEnabled,
      fullRegressionPassClaimed: GaussFullRealCameraOcrRegressionPolicy.fullRegressionPassClaimed,
      ocrPassClaimed: GaussFullRealCameraOcrRegressionPolicy.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: GaussFullRealCameraOcrRegressionPolicy.cameraOcrRuntimePassClaimed,
      releasePassClaimed: GaussFullRealCameraOcrRegressionPolicy.releasePassClaimed,
      regressionLabel: input.regressionLabel,
    );
  }
}
