import 'gauss_approved_ocr_workspace_import_gate_policy.dart';

enum GaussApprovedOcrWorkspaceImportDecision {
  blockedMissingQ274ReviewBindingGate,
  blockedMissingEditableMathLiveReviewDraft,
  blockedReviewDraftNotUserEditable,
  blockedMissingExplicitUserApproval,
  blockedEmptyApprovedLatexDraft,
  blockedWorkspaceImportPreparedBeforeApproval,
  blockedAutoEvaluateRisk,
  blockedAutoSolveRisk,
  blockedAutoGraphSolutionHistoryRisk,
  blockedDirectImportWithoutApprovalRisk,
  blockedUnsafeRuntimeOrOcrClaim,
  readyForFutureApprovedWorkspaceImportOnly,
}

class GaussApprovedOcrWorkspaceImportInput {
  const GaussApprovedOcrWorkspaceImportInput({
    required this.q274OcrResultMathLiveReviewBindingPresent,
    required this.q274StillNoRealInferenceNoRuntime,
    required this.editableMathLiveReviewDraftRequired,
    required this.reviewDraftMayBeEditedBeforeApproval,
    required this.explicitUserApprovalRequired,
    required this.approvedLatexDraft,
    required this.workspaceImportPreparedOnlyAfterUserApproval,
    required this.workspaceImportMayUseApprovedLatexDraft,
    required this.autoEvaluateAfterImport,
    required this.autoSolveAfterImport,
    required this.autoGraphAfterImport,
    required this.autoSolutionAfterImport,
    required this.autoHistoryAfterImport,
    required this.directWorkspaceImportWithoutApprovalBlocked,
    required this.directSolveBlocked,
    required this.directGraphSolutionHistoryBlocked,
    required this.noPaddleRuntimeAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noNativeBridgeImplementationAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.noProductionInferenceAllowed,
    required this.noRealImageToLatexInferenceExecuted,
    required this.workspaceImportRuntimePassClaimed,
    required this.ocrPassClaimed,
    required this.importLabel,
  });

  final bool q274OcrResultMathLiveReviewBindingPresent;
  final bool q274StillNoRealInferenceNoRuntime;
  final bool editableMathLiveReviewDraftRequired;
  final bool reviewDraftMayBeEditedBeforeApproval;
  final bool explicitUserApprovalRequired;
  final String approvedLatexDraft;
  final bool workspaceImportPreparedOnlyAfterUserApproval;
  final bool workspaceImportMayUseApprovedLatexDraft;
  final bool autoEvaluateAfterImport;
  final bool autoSolveAfterImport;
  final bool autoGraphAfterImport;
  final bool autoSolutionAfterImport;
  final bool autoHistoryAfterImport;
  final bool directWorkspaceImportWithoutApprovalBlocked;
  final bool directSolveBlocked;
  final bool directGraphSolutionHistoryBlocked;
  final bool noPaddleRuntimeAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noNativeBridgeImplementationAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool noProductionInferenceAllowed;
  final bool noRealImageToLatexInferenceExecuted;
  final bool workspaceImportRuntimePassClaimed;
  final bool ocrPassClaimed;
  final String importLabel;
}

class GaussApprovedOcrWorkspaceImportResult {
  const GaussApprovedOcrWorkspaceImportResult({
    required this.decision,
    required this.workspaceImportGateStaticReady,
    required this.input,
  });

  final GaussApprovedOcrWorkspaceImportDecision decision;
  final bool workspaceImportGateStaticReady;
  final GaussApprovedOcrWorkspaceImportInput input;

  String get phase => GaussApprovedOcrWorkspaceImportGatePolicy.phase;
  String get sourcePhase => GaussApprovedOcrWorkspaceImportGatePolicy.sourcePhase;
  String get selectedEngineLabel => GaussApprovedOcrWorkspaceImportGatePolicy.selectedEngineLabel;
  String get workspaceImportMode => GaussApprovedOcrWorkspaceImportGatePolicy.workspaceImportMode;
  bool get realOcrRuntimeAdded => GaussApprovedOcrWorkspaceImportGatePolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussApprovedOcrWorkspaceImportGatePolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussApprovedOcrWorkspaceImportGatePolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeImplementationAdded => GaussApprovedOcrWorkspaceImportGatePolicy.nativeBridgeImplementationAdded;
  bool get jniBindingAdded => GaussApprovedOcrWorkspaceImportGatePolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussApprovedOcrWorkspaceImportGatePolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussApprovedOcrWorkspaceImportGatePolicy.modelBinaryBundledInBaseApp;
  bool get productionDownloadEnabled => GaussApprovedOcrWorkspaceImportGatePolicy.productionDownloadEnabled;
  bool get productionInferenceAllowed => GaussApprovedOcrWorkspaceImportGatePolicy.productionInferenceAllowed;
  bool get runtimeFeatureFlagDefaultOff => GaussApprovedOcrWorkspaceImportGatePolicy.runtimeFeatureFlagDefaultOff;
  bool get realImageToLatexInferenceExecuted => GaussApprovedOcrWorkspaceImportGatePolicy.realImageToLatexInferenceExecuted;
  bool get workspaceImportRuntimePassClaimed => GaussApprovedOcrWorkspaceImportGatePolicy.workspaceImportRuntimePassClaimed;
  bool get ocrPassClaimed => GaussApprovedOcrWorkspaceImportGatePolicy.ocrPassClaimed;
  bool get canPrepareWorkspaceImportAfterApprovalInQ275 => workspaceImportGateStaticReady;
  bool get canImportWithoutUserApproval => false;
  bool get canAutoEvaluateAfterImport => false;
  bool get canAutoSolveAfterImport => false;
  bool get canAutoGraphSolutionHistoryAfterImport => false;
  bool get canClaimOcrPassInQ275 => false;

  List<String> get requiredWorkspaceImportGates => GaussApprovedOcrWorkspaceImportGatePolicy.requiredWorkspaceImportGates;
  List<String> get workspaceImportEnvelopeFields => GaussApprovedOcrWorkspaceImportGatePolicy.workspaceImportEnvelopeFields;
  List<String> get workspaceImportFailureCodes => GaussApprovedOcrWorkspaceImportGatePolicy.workspaceImportFailureCodes;
  List<String> get forbiddenActions => GaussApprovedOcrWorkspaceImportGatePolicy.forbiddenActions;
}

class GaussApprovedOcrWorkspaceImportGate {
  const GaussApprovedOcrWorkspaceImportGate._();

  static GaussApprovedOcrWorkspaceImportResult evaluate(
    GaussApprovedOcrWorkspaceImportInput input,
  ) {
    if (!input.q274OcrResultMathLiveReviewBindingPresent || !input.q274StillNoRealInferenceNoRuntime) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedMissingQ274ReviewBindingGate, input);
    }
    if (!input.editableMathLiveReviewDraftRequired) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedMissingEditableMathLiveReviewDraft, input);
    }
    if (!input.reviewDraftMayBeEditedBeforeApproval) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedReviewDraftNotUserEditable, input);
    }
    if (!input.explicitUserApprovalRequired) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedMissingExplicitUserApproval, input);
    }
    if (input.approvedLatexDraft.trim().isEmpty) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedEmptyApprovedLatexDraft, input);
    }
    if (!input.workspaceImportPreparedOnlyAfterUserApproval || !input.workspaceImportMayUseApprovedLatexDraft) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedWorkspaceImportPreparedBeforeApproval, input);
    }
    if (input.autoEvaluateAfterImport) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedAutoEvaluateRisk, input);
    }
    if (input.autoSolveAfterImport) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedAutoSolveRisk, input);
    }
    if (input.autoGraphAfterImport || input.autoSolutionAfterImport || input.autoHistoryAfterImport) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedAutoGraphSolutionHistoryRisk, input);
    }
    if (!input.directWorkspaceImportWithoutApprovalBlocked || !input.directSolveBlocked || !input.directGraphSolutionHistoryBlocked) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedDirectImportWithoutApprovalRisk, input);
    }
    final unsafeRuntimeClaim = !input.noPaddleRuntimeAdded ||
        !input.noPaddleOcrDependencyAdded ||
        !input.noNativeBridgeImplementationAdded ||
        !input.noJniBindingAdded ||
        !input.noMethodChannelRuntimeBindingAdded ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noProductionModelUrlBound ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        input.productionDownloadEnabled ||
        !input.noProductionInferenceAllowed ||
        !input.noRealImageToLatexInferenceExecuted ||
        input.workspaceImportRuntimePassClaimed ||
        input.ocrPassClaimed;
    if (unsafeRuntimeClaim) {
      return _blocked(GaussApprovedOcrWorkspaceImportDecision.blockedUnsafeRuntimeOrOcrClaim, input);
    }
    return GaussApprovedOcrWorkspaceImportResult(
      decision: GaussApprovedOcrWorkspaceImportDecision.readyForFutureApprovedWorkspaceImportOnly,
      workspaceImportGateStaticReady: true,
      input: input,
    );
  }

  static GaussApprovedOcrWorkspaceImportResult _blocked(
    GaussApprovedOcrWorkspaceImportDecision decision,
    GaussApprovedOcrWorkspaceImportInput input,
  ) {
    return GaussApprovedOcrWorkspaceImportResult(
      decision: decision,
      workspaceImportGateStaticReady: false,
      input: input,
    );
  }
}
