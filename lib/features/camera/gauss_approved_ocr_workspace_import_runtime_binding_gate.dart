import 'gauss_approved_ocr_workspace_import_runtime_binding_gate_policy.dart';

/// V172-Q312 — Approved OCR → Workspace Import Runtime Binding Gate.
///
/// Static package-side gate only. It defines the future conditions for preparing
/// a workspace import envelope from a user-approved editable MathLive OCR review
/// draft. It does not mutate the workspace, evaluate, solve, graph, write
/// Solution/History, or run OCR in Q312.
enum GaussApprovedOcrWorkspaceImportRuntimeBindingGateDecision {
  workspaceImportBindingGateDefinedDefaultOff,
  blockedMissingQ311ReviewApprovalEvidence,
  blockedMissingApprovedLatexDraft,
  blockedWorkspaceMutationAttempt,
  blockedDirectEvaluateRisk,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedFakePassClaim,
}

class GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput {
  const GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput({
    required this.q311ReviewUiBindingGatePresent,
    required this.q311RealEditableReviewOpened,
    required this.q311RealUserApprovalCaptured,
    required this.q311ApprovedReviewDraftEnvelopePresent,
    required this.approvedLatexDraftSanitized,
    required this.reviewMetadataPreserved,
    required this.engineMetadataPreserved,
    required this.cropAndImageShaPreserved,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.defaultOffFeatureFlagPresent,
    required this.realAndroidDeviceWorkspaceImportLogRequired,
    required this.importRollbackPolicyPresent,
    required this.importTimeoutPolicyPresent,
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
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.cameraImageSentToRuntime,
    required this.realImageToLatexInferenceExecuted,
    required this.runtimeLatexResponseParsed,
    required this.realEditableMathLiveReviewOpened,
    required this.realWorkspaceImportExecuted,
    required this.workspaceImportActuallyMutatedWorkspace,
    required this.autoEvaluateEnabled,
    required this.autoSolveGraphSolutionHistoryEnabled,
    required this.solutionHistoryWriteEnabled,
    required this.workspaceImportPassClaimed,
    required this.reviewBindingPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput.q312Default({
    String trialLabel = 'q312-approved-ocr-workspace-import-runtime-binding-gate',
  }) {
    return GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput(
      q311ReviewUiBindingGatePresent: true,
      q311RealEditableReviewOpened: false,
      q311RealUserApprovalCaptured: false,
      q311ApprovedReviewDraftEnvelopePresent: false,
      approvedLatexDraftSanitized: true,
      reviewMetadataPreserved: true,
      engineMetadataPreserved: true,
      cropAndImageShaPreserved: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      defaultOffFeatureFlagPresent: true,
      realAndroidDeviceWorkspaceImportLogRequired: true,
      importRollbackPolicyPresent: true,
      importTimeoutPolicyPresent: true,
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
      realPrivateArtifactLoaded: false,
      realRuntimeStartupExecuted: false,
      realDummyInputRuntimeCallExecuted: false,
      cameraImageSentToRuntime: false,
      realImageToLatexInferenceExecuted: false,
      runtimeLatexResponseParsed: false,
      realEditableMathLiveReviewOpened: false,
      realWorkspaceImportExecuted: false,
      workspaceImportActuallyMutatedWorkspace: false,
      autoEvaluateEnabled: false,
      autoSolveGraphSolutionHistoryEnabled: false,
      solutionHistoryWriteEnabled: false,
      workspaceImportPassClaimed: false,
      reviewBindingPassClaimed: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      trialLabel: trialLabel,
    );
  }

  final bool q311ReviewUiBindingGatePresent;
  final bool q311RealEditableReviewOpened;
  final bool q311RealUserApprovalCaptured;
  final bool q311ApprovedReviewDraftEnvelopePresent;
  final bool approvedLatexDraftSanitized;
  final bool reviewMetadataPreserved;
  final bool engineMetadataPreserved;
  final bool cropAndImageShaPreserved;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool defaultOffFeatureFlagPresent;
  final bool realAndroidDeviceWorkspaceImportLogRequired;
  final bool importRollbackPolicyPresent;
  final bool importTimeoutPolicyPresent;
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
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool cameraImageSentToRuntime;
  final bool realImageToLatexInferenceExecuted;
  final bool runtimeLatexResponseParsed;
  final bool realEditableMathLiveReviewOpened;
  final bool realWorkspaceImportExecuted;
  final bool workspaceImportActuallyMutatedWorkspace;
  final bool autoEvaluateEnabled;
  final bool autoSolveGraphSolutionHistoryEnabled;
  final bool solutionHistoryWriteEnabled;
  final bool workspaceImportPassClaimed;
  final bool reviewBindingPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussApprovedOcrWorkspaceImportRuntimeBindingGateResult {
  const GaussApprovedOcrWorkspaceImportRuntimeBindingGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.workspaceImportBindingFeatureFlag,
    required this.workspaceImportBindingMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeWorkspaceImportBinding,
    required this.workspaceImportEnvelopeFields,
    required this.workspaceImportStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.workspaceImportBindingGateDefined,
    required this.workspaceImportBindingDefaultOff,
    required this.q311ReviewUiBindingGatePresent,
    required this.q311RealEditableReviewOpened,
    required this.q311RealUserApprovalCaptured,
    required this.q311ApprovedReviewDraftEnvelopePresent,
    required this.approvedLatexDraftSanitized,
    required this.reviewMetadataPreserved,
    required this.engineMetadataPreserved,
    required this.cropAndImageShaPreserved,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.realAndroidDeviceWorkspaceImportLogRequired,
    required this.workspaceMutationRuntimeExecutionBlocked,
    required this.directEvaluateBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.manualSolveGraphAfterImportOnly,
    required this.realWorkspaceImportExecuted,
    required this.workspaceImportActuallyMutatedWorkspace,
    required this.autoEvaluateEnabled,
    required this.autoSolveGraphSolutionHistoryEnabled,
    required this.solutionHistoryWriteEnabled,
    required this.workspaceImportPassClaimed,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String workspaceImportBindingFeatureFlag;
  final String workspaceImportBindingMode;
  final String readinessState;
  final GaussApprovedOcrWorkspaceImportRuntimeBindingGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeWorkspaceImportBinding;
  final List<String> workspaceImportEnvelopeFields;
  final List<String> workspaceImportStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool workspaceImportBindingGateDefined;
  final bool workspaceImportBindingDefaultOff;
  final bool q311ReviewUiBindingGatePresent;
  final bool q311RealEditableReviewOpened;
  final bool q311RealUserApprovalCaptured;
  final bool q311ApprovedReviewDraftEnvelopePresent;
  final bool approvedLatexDraftSanitized;
  final bool reviewMetadataPreserved;
  final bool engineMetadataPreserved;
  final bool cropAndImageShaPreserved;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool realAndroidDeviceWorkspaceImportLogRequired;
  final bool workspaceMutationRuntimeExecutionBlocked;
  final bool directEvaluateBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool manualSolveGraphAfterImportOnly;
  final bool realWorkspaceImportExecuted;
  final bool workspaceImportActuallyMutatedWorkspace;
  final bool autoEvaluateEnabled;
  final bool autoSolveGraphSolutionHistoryEnabled;
  final bool solutionHistoryWriteEnabled;
  final bool workspaceImportPassClaimed;
  final bool ocrPassClaimed;
}

class GaussApprovedOcrWorkspaceImportRuntimeBindingGate {
  const GaussApprovedOcrWorkspaceImportRuntimeBindingGate._();

  static GaussApprovedOcrWorkspaceImportRuntimeBindingGateResult evaluate(
    GaussApprovedOcrWorkspaceImportRuntimeBindingGateInput input,
  ) {
    final rejectionReasons = <String>[];

    if (!input.q311ReviewUiBindingGatePresent) {
      rejectionReasons.add('q311-review-ui-binding-gate-missing');
    }
    if (input.q311RealEditableReviewOpened || input.q311RealUserApprovalCaptured || input.q311ApprovedReviewDraftEnvelopePresent) {
      rejectionReasons.add('q312-must-not-accept-complete-workspace-import-evidence-inside-static-package');
    }
    if (!input.explicitUserApprovalRequiredBeforeWorkspaceImport || !input.defaultOffFeatureFlagPresent) {
      rejectionReasons.add('workspace-import-safety-preconditions-missing');
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
    final forbiddenMutation = input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.nativeRuntimeDependencyAdded ||
        input.methodChannelRuntimeBoundInsidePackage ||
        input.jniNativeHandlerImplementedInsidePackage ||
        input.productionDownloadEnabled ||
        input.modelBinaryBundledInBaseApp ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.cameraImageSentToRuntime ||
        input.realImageToLatexInferenceExecuted ||
        input.runtimeLatexResponseParsed ||
        input.realEditableMathLiveReviewOpened ||
        input.realWorkspaceImportExecuted ||
        input.workspaceImportActuallyMutatedWorkspace ||
        input.autoEvaluateEnabled ||
        input.autoSolveGraphSolutionHistoryEnabled ||
        input.solutionHistoryWriteEnabled;
    if (forbiddenMutation) {
      rejectionReasons.add('workspace-import-or-runtime-mutation-forbidden-in-q312');
    }
    final fakePassClaim = input.workspaceImportPassClaimed ||
        input.reviewBindingPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed;
    if (fakePassClaim) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    final staticReady = rejectionReasons.isEmpty;
    final decision = !staticReady
        ? (forbiddenMutation
            ? GaussApprovedOcrWorkspaceImportRuntimeBindingGateDecision.blockedWorkspaceMutationAttempt
            : fakePassClaim
                ? GaussApprovedOcrWorkspaceImportRuntimeBindingGateDecision.blockedFakePassClaim
                : GaussApprovedOcrWorkspaceImportRuntimeBindingGateDecision.blockedMissingQ311ReviewApprovalEvidence)
        : GaussApprovedOcrWorkspaceImportRuntimeBindingGateDecision.workspaceImportBindingGateDefinedDefaultOff;

    return GaussApprovedOcrWorkspaceImportRuntimeBindingGateResult(
      phase: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.phase,
      sourcePhase: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.sourcePhase,
      selectedEngineLabel: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.selectedEngineLabel,
      workspaceImportBindingFeatureFlag: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.workspaceImportBindingFeatureFlag,
      workspaceImportBindingMode: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.workspaceImportBindingMode,
      readinessState: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: staticReady,
      rejectionReasons: List.unmodifiable(rejectionReasons),
      requiredBeforeWorkspaceImportBinding: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.requiredBeforeWorkspaceImportBinding,
      workspaceImportEnvelopeFields: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.workspaceImportEnvelopeFields,
      workspaceImportStates: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.workspaceImportStates,
      errorCodes: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.errorCodes,
      protectedSurfaceMarkers: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.forbiddenActions,
      workspaceImportBindingGateDefined: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.workspaceImportBindingGateDefined,
      workspaceImportBindingDefaultOff: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.workspaceImportBindingDefaultOff,
      q311ReviewUiBindingGatePresent: input.q311ReviewUiBindingGatePresent,
      q311RealEditableReviewOpened: input.q311RealEditableReviewOpened,
      q311RealUserApprovalCaptured: input.q311RealUserApprovalCaptured,
      q311ApprovedReviewDraftEnvelopePresent: input.q311ApprovedReviewDraftEnvelopePresent,
      approvedLatexDraftSanitized: input.approvedLatexDraftSanitized,
      reviewMetadataPreserved: input.reviewMetadataPreserved,
      engineMetadataPreserved: input.engineMetadataPreserved,
      cropAndImageShaPreserved: input.cropAndImageShaPreserved,
      explicitUserApprovalRequiredBeforeWorkspaceImport: input.explicitUserApprovalRequiredBeforeWorkspaceImport,
      realAndroidDeviceWorkspaceImportLogRequired: input.realAndroidDeviceWorkspaceImportLogRequired,
      workspaceMutationRuntimeExecutionBlocked: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.workspaceMutationRuntimeExecutionBlocked,
      directEvaluateBlocked: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.directEvaluateBlocked,
      directSolveGraphSolutionHistoryBlocked: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.directSolveGraphSolutionHistoryBlocked,
      manualSolveGraphAfterImportOnly: GaussApprovedOcrWorkspaceImportRuntimeBindingGatePolicy.manualSolveGraphAfterImportOnly,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      workspaceImportActuallyMutatedWorkspace: input.workspaceImportActuallyMutatedWorkspace,
      autoEvaluateEnabled: input.autoEvaluateEnabled,
      autoSolveGraphSolutionHistoryEnabled: input.autoSolveGraphSolutionHistoryEnabled,
      solutionHistoryWriteEnabled: input.solutionHistoryWriteEnabled,
      workspaceImportPassClaimed: input.workspaceImportPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
    );
  }
}
