import 'gauss_full_camera_ocr_real_device_regression_gate_policy.dart';

/// V172-Q313 — Full Camera/OCR Real Device Regression Gate.
///
/// Static package-side gate only. It consolidates the future real-device
/// PP-FormulaNet-S Camera/OCR regression requirements without executing OCR,
/// runtime, workspace import, solve, graph, or Solution/History writes.
enum GaussFullCameraOcrRealDeviceRegressionGateDecision {
  fullRegressionGateDefinedDefaultOff,
  blockedMissingChainGate,
  blockedProtectedSurfaceRegression,
  blockedRuntimeMutationAttempt,
  blockedFakePassClaim,
}

class GaussFullCameraOcrRealDeviceRegressionGateInput {
  const GaussFullCameraOcrRealDeviceRegressionGateInput({
    required this.q302ArtifactUrlShaLockGatePresent,
    required this.q303RuntimeDependencyTrialGatePresent,
    required this.q304AndroidNativeBridgeGatePresent,
    required this.q305PrivateModelDownloadWorkerGatePresent,
    required this.q306ShaAtomicMoveGatePresent,
    required this.q307PrivateArtifactLoadGatePresent,
    required this.q308RuntimeStartupGatePresent,
    required this.q309DummyInputRuntimeCallGatePresent,
    required this.q310ImageToLatexInferenceGatePresent,
    required this.q311EditableMathLiveReviewGatePresent,
    required this.q312ApprovedWorkspaceImportGatePresent,
    required this.defaultOffFeatureFlagPresent,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlockedBeforeApproval,
    required this.directEvaluateBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.realAndroidFullRegressionLogRequired,
    required this.keyboardLayoutProtected,
    required this.moreTemplateTrayProtected,
    required this.longPressListsProtected,
    required this.mathLiveProductionRouteProtected,
    required this.mathLiveBridgeProtected,
    required this.graphSolutionHistoryProtected,
    required this.appShellWorkspaceProtected,
    required this.androidManifestMainActivityProtected,
    required this.cameraShellRuntimeProtected,
    required this.splashIconProtected,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.nativeRuntimeDependencyAdded,
    required this.methodChannelRuntimeBoundInsidePackage,
    required this.jniNativeHandlerImplementedInsidePackage,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realModelSha256Verified,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.autoEvaluateEnabled,
    required this.autoSolveGraphSolutionHistoryEnabled,
    required this.solutionHistoryWriteEnabled,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.workspaceImportPassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussFullCameraOcrRealDeviceRegressionGateInput.q313Default({
    String trialLabel = 'q313-full-camera-ocr-real-device-regression-gate',
  }) {
    return GaussFullCameraOcrRealDeviceRegressionGateInput(
      q302ArtifactUrlShaLockGatePresent: true,
      q303RuntimeDependencyTrialGatePresent: true,
      q304AndroidNativeBridgeGatePresent: true,
      q305PrivateModelDownloadWorkerGatePresent: true,
      q306ShaAtomicMoveGatePresent: true,
      q307PrivateArtifactLoadGatePresent: true,
      q308RuntimeStartupGatePresent: true,
      q309DummyInputRuntimeCallGatePresent: true,
      q310ImageToLatexInferenceGatePresent: true,
      q311EditableMathLiveReviewGatePresent: true,
      q312ApprovedWorkspaceImportGatePresent: true,
      defaultOffFeatureFlagPresent: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequired: true,
      directWorkspaceImportBlockedBeforeApproval: true,
      directEvaluateBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      realAndroidFullRegressionLogRequired: true,
      keyboardLayoutProtected: true,
      moreTemplateTrayProtected: true,
      longPressListsProtected: true,
      mathLiveProductionRouteProtected: true,
      mathLiveBridgeProtected: true,
      graphSolutionHistoryProtected: true,
      appShellWorkspaceProtected: true,
      androidManifestMainActivityProtected: true,
      cameraShellRuntimeProtected: true,
      splashIconProtected: true,
      pubspecChanged: false,
      androidManifestChanged: false,
      mainActivityChanged: false,
      nativeRuntimeDependencyAdded: false,
      methodChannelRuntimeBoundInsidePackage: false,
      jniNativeHandlerImplementedInsidePackage: false,
      productionDownloadEnabled: false,
      modelBinaryBundledInBaseApp: false,
      realModelSha256Verified: false,
      realPrivateArtifactLoaded: false,
      realRuntimeStartupExecuted: false,
      realDummyInputRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      realEditableMathLiveReviewOpened: false,
      realWorkspaceImportExecuted: false,
      autoEvaluateEnabled: false,
      autoSolveGraphSolutionHistoryEnabled: false,
      solutionHistoryWriteEnabled: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      workspaceImportPassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      trialLabel: trialLabel,
    );
  }

  final bool q302ArtifactUrlShaLockGatePresent;
  final bool q303RuntimeDependencyTrialGatePresent;
  final bool q304AndroidNativeBridgeGatePresent;
  final bool q305PrivateModelDownloadWorkerGatePresent;
  final bool q306ShaAtomicMoveGatePresent;
  final bool q307PrivateArtifactLoadGatePresent;
  final bool q308RuntimeStartupGatePresent;
  final bool q309DummyInputRuntimeCallGatePresent;
  final bool q310ImageToLatexInferenceGatePresent;
  final bool q311EditableMathLiveReviewGatePresent;
  final bool q312ApprovedWorkspaceImportGatePresent;
  final bool defaultOffFeatureFlagPresent;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlockedBeforeApproval;
  final bool directEvaluateBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool realAndroidFullRegressionLogRequired;
  final bool keyboardLayoutProtected;
  final bool moreTemplateTrayProtected;
  final bool longPressListsProtected;
  final bool mathLiveProductionRouteProtected;
  final bool mathLiveBridgeProtected;
  final bool graphSolutionHistoryProtected;
  final bool appShellWorkspaceProtected;
  final bool androidManifestMainActivityProtected;
  final bool cameraShellRuntimeProtected;
  final bool splashIconProtected;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool nativeRuntimeDependencyAdded;
  final bool methodChannelRuntimeBoundInsidePackage;
  final bool jniNativeHandlerImplementedInsidePackage;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realModelSha256Verified;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool autoEvaluateEnabled;
  final bool autoSolveGraphSolutionHistoryEnabled;
  final bool solutionHistoryWriteEnabled;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool workspaceImportPassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussFullCameraOcrRealDeviceRegressionGateResult {
  const GaussFullCameraOcrRealDeviceRegressionGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.fullRegressionFeatureFlag,
    required this.fullRegressionMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredRegressionEvidence,
    required this.regressionEnvelopeFields,
    required this.regressionStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.fullRegressionGateDefined,
    required this.fullRegressionDefaultOff,
    required this.q302ArtifactUrlShaLockGatePresent,
    required this.q303RuntimeDependencyTrialGatePresent,
    required this.q304AndroidNativeBridgeGatePresent,
    required this.q305PrivateModelDownloadWorkerGatePresent,
    required this.q306ShaAtomicMoveGatePresent,
    required this.q307PrivateArtifactLoadGatePresent,
    required this.q308RuntimeStartupGatePresent,
    required this.q309DummyInputRuntimeCallGatePresent,
    required this.q310ImageToLatexInferenceGatePresent,
    required this.q311EditableMathLiveReviewGatePresent,
    required this.q312ApprovedWorkspaceImportGatePresent,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequired,
    required this.directWorkspaceImportBlockedBeforeApproval,
    required this.directEvaluateBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.realAndroidFullRegressionLogRequired,
    required this.realImageToLatexInferenceExecuted,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.autoEvaluateEnabled,
    required this.autoSolveGraphSolutionHistoryEnabled,
    required this.solutionHistoryWriteEnabled,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String fullRegressionFeatureFlag;
  final String fullRegressionMode;
  final String readinessState;
  final GaussFullCameraOcrRealDeviceRegressionGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredRegressionEvidence;
  final List<String> regressionEnvelopeFields;
  final List<String> regressionStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool fullRegressionGateDefined;
  final bool fullRegressionDefaultOff;
  final bool q302ArtifactUrlShaLockGatePresent;
  final bool q303RuntimeDependencyTrialGatePresent;
  final bool q304AndroidNativeBridgeGatePresent;
  final bool q305PrivateModelDownloadWorkerGatePresent;
  final bool q306ShaAtomicMoveGatePresent;
  final bool q307PrivateArtifactLoadGatePresent;
  final bool q308RuntimeStartupGatePresent;
  final bool q309DummyInputRuntimeCallGatePresent;
  final bool q310ImageToLatexInferenceGatePresent;
  final bool q311EditableMathLiveReviewGatePresent;
  final bool q312ApprovedWorkspaceImportGatePresent;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequired;
  final bool directWorkspaceImportBlockedBeforeApproval;
  final bool directEvaluateBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool realAndroidFullRegressionLogRequired;
  final bool realImageToLatexInferenceExecuted;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool autoEvaluateEnabled;
  final bool autoSolveGraphSolutionHistoryEnabled;
  final bool solutionHistoryWriteEnabled;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
}

class GaussFullCameraOcrRealDeviceRegressionGate {
  const GaussFullCameraOcrRealDeviceRegressionGate._();

  static GaussFullCameraOcrRealDeviceRegressionGateResult evaluate(
    GaussFullCameraOcrRealDeviceRegressionGateInput input,
  ) {
    final rejectionReasons = <String>[];

    final chainPresent = input.q302ArtifactUrlShaLockGatePresent &&
        input.q303RuntimeDependencyTrialGatePresent &&
        input.q304AndroidNativeBridgeGatePresent &&
        input.q305PrivateModelDownloadWorkerGatePresent &&
        input.q306ShaAtomicMoveGatePresent &&
        input.q307PrivateArtifactLoadGatePresent &&
        input.q308RuntimeStartupGatePresent &&
        input.q309DummyInputRuntimeCallGatePresent &&
        input.q310ImageToLatexInferenceGatePresent &&
        input.q311EditableMathLiveReviewGatePresent &&
        input.q312ApprovedWorkspaceImportGatePresent;
    if (!chainPresent) {
      rejectionReasons.add('q302-through-q312-regression-chain-incomplete');
    }

    final reviewAndApprovalSafe = input.defaultOffFeatureFlagPresent &&
        input.editableMathLiveReviewRequired &&
        input.explicitUserApprovalRequired &&
        input.directWorkspaceImportBlockedBeforeApproval &&
        input.directEvaluateBlocked &&
        input.directSolveGraphSolutionHistoryBlocked &&
        input.realAndroidFullRegressionLogRequired;
    if (!reviewAndApprovalSafe) {
      rejectionReasons.add('review-approval-regression-safety-missing');
    }

    final protectedSurfacesOk = input.keyboardLayoutProtected &&
        input.moreTemplateTrayProtected &&
        input.longPressListsProtected &&
        input.mathLiveProductionRouteProtected &&
        input.mathLiveBridgeProtected &&
        input.graphSolutionHistoryProtected &&
        input.appShellWorkspaceProtected &&
        input.androidManifestMainActivityProtected &&
        input.cameraShellRuntimeProtected &&
        input.splashIconProtected;
    if (!protectedSurfacesOk) {
      rejectionReasons.add('protected-surface-regression-forbidden');
    }

    final forbiddenRuntimeMutation = input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.nativeRuntimeDependencyAdded ||
        input.methodChannelRuntimeBoundInsidePackage ||
        input.jniNativeHandlerImplementedInsidePackage ||
        input.productionDownloadEnabled ||
        input.modelBinaryBundledInBaseApp ||
        input.realModelSha256Verified ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.realImageToLatexInferenceExecuted ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted ||
        input.autoEvaluateEnabled ||
        input.autoSolveGraphSolutionHistoryEnabled ||
        input.solutionHistoryWriteEnabled;
    if (forbiddenRuntimeMutation) {
      rejectionReasons.add('runtime-or-workspace-mutation-forbidden-in-q313-static-package');
    }

    final fakePassClaim = input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.workspaceImportPassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed;
    if (fakePassClaim) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    final staticReady = rejectionReasons.isEmpty;
    final decision = !staticReady
        ? (!chainPresent
            ? GaussFullCameraOcrRealDeviceRegressionGateDecision.blockedMissingChainGate
            : forbiddenRuntimeMutation
                ? GaussFullCameraOcrRealDeviceRegressionGateDecision.blockedRuntimeMutationAttempt
                : fakePassClaim
                    ? GaussFullCameraOcrRealDeviceRegressionGateDecision.blockedFakePassClaim
                    : GaussFullCameraOcrRealDeviceRegressionGateDecision.blockedProtectedSurfaceRegression)
        : GaussFullCameraOcrRealDeviceRegressionGateDecision.fullRegressionGateDefinedDefaultOff;

    return GaussFullCameraOcrRealDeviceRegressionGateResult(
      phase: GaussFullCameraOcrRealDeviceRegressionGatePolicy.phase,
      sourcePhase: GaussFullCameraOcrRealDeviceRegressionGatePolicy.sourcePhase,
      selectedEngineLabel: GaussFullCameraOcrRealDeviceRegressionGatePolicy.selectedEngineLabel,
      fullRegressionFeatureFlag: GaussFullCameraOcrRealDeviceRegressionGatePolicy.fullRegressionFeatureFlag,
      fullRegressionMode: GaussFullCameraOcrRealDeviceRegressionGatePolicy.fullRegressionMode,
      readinessState: GaussFullCameraOcrRealDeviceRegressionGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: staticReady,
      rejectionReasons: List.unmodifiable(rejectionReasons),
      requiredRegressionEvidence: GaussFullCameraOcrRealDeviceRegressionGatePolicy.requiredRegressionEvidence,
      regressionEnvelopeFields: GaussFullCameraOcrRealDeviceRegressionGatePolicy.regressionEnvelopeFields,
      regressionStates: GaussFullCameraOcrRealDeviceRegressionGatePolicy.regressionStates,
      errorCodes: GaussFullCameraOcrRealDeviceRegressionGatePolicy.errorCodes,
      protectedSurfaceMarkers: GaussFullCameraOcrRealDeviceRegressionGatePolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussFullCameraOcrRealDeviceRegressionGatePolicy.forbiddenActions,
      fullRegressionGateDefined: GaussFullCameraOcrRealDeviceRegressionGatePolicy.fullRegressionGateDefined,
      fullRegressionDefaultOff: GaussFullCameraOcrRealDeviceRegressionGatePolicy.fullRegressionDefaultOff,
      q302ArtifactUrlShaLockGatePresent: input.q302ArtifactUrlShaLockGatePresent,
      q303RuntimeDependencyTrialGatePresent: input.q303RuntimeDependencyTrialGatePresent,
      q304AndroidNativeBridgeGatePresent: input.q304AndroidNativeBridgeGatePresent,
      q305PrivateModelDownloadWorkerGatePresent: input.q305PrivateModelDownloadWorkerGatePresent,
      q306ShaAtomicMoveGatePresent: input.q306ShaAtomicMoveGatePresent,
      q307PrivateArtifactLoadGatePresent: input.q307PrivateArtifactLoadGatePresent,
      q308RuntimeStartupGatePresent: input.q308RuntimeStartupGatePresent,
      q309DummyInputRuntimeCallGatePresent: input.q309DummyInputRuntimeCallGatePresent,
      q310ImageToLatexInferenceGatePresent: input.q310ImageToLatexInferenceGatePresent,
      q311EditableMathLiveReviewGatePresent: input.q311EditableMathLiveReviewGatePresent,
      q312ApprovedWorkspaceImportGatePresent: input.q312ApprovedWorkspaceImportGatePresent,
      editableMathLiveReviewRequired: input.editableMathLiveReviewRequired,
      explicitUserApprovalRequired: input.explicitUserApprovalRequired,
      directWorkspaceImportBlockedBeforeApproval: input.directWorkspaceImportBlockedBeforeApproval,
      directEvaluateBlocked: input.directEvaluateBlocked,
      directSolveGraphSolutionHistoryBlocked: input.directSolveGraphSolutionHistoryBlocked,
      realAndroidFullRegressionLogRequired: input.realAndroidFullRegressionLogRequired,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      realEditableMathLiveReviewOpened: input.realEditableMathLiveReviewOpened,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      autoEvaluateEnabled: input.autoEvaluateEnabled,
      autoSolveGraphSolutionHistoryEnabled: input.autoSolveGraphSolutionHistoryEnabled,
      solutionHistoryWriteEnabled: input.solutionHistoryWriteEnabled,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
    );
  }
}
