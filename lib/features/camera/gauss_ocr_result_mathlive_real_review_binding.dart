import 'gauss_ocr_result_mathlive_real_review_binding_policy.dart';

enum GaussOcrResultMathLiveRealReviewBindingDecision {
  blockedMissingQ273ImageToLatexPrototypeGate,
  blockedMissingCandidateEnvelope,
  blockedMissingPrimaryLatexCandidate,
  blockedMissingEditableMathLiveReview,
  blockedMissingAlternativeCandidateHandling,
  blockedMissingConfidenceWarningsMetadata,
  blockedUserApprovalNotRequired,
  blockedDirectWorkspaceImportRisk,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedUnsafeRuntimeOrInferenceClaim,
  readyForFutureMathLiveReviewBindingOnly,
}

class GaussOcrResultMathLiveRealReviewBindingInput {
  const GaussOcrResultMathLiveRealReviewBindingInput({
    required this.q273ImageToLatexPrototypeGatePresent,
    required this.q273StillNoRealInferenceNoRuntime,
    required this.candidateEnvelopeAccepted,
    required this.primaryLatexCandidatePreserved,
    required this.alternativeCandidatesPreserved,
    required this.confidenceWarningsEngineMetadataPreserved,
    required this.imageHashCropBoundsPreprocessMetadataPreserved,
    required this.editableMathLiveReviewRequired,
    required this.reviewDraftMayBeEditedBeforeImport,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.workspaceImportPreparedOnlyAfterUserApproval,
    required this.directWorkspaceImportBlocked,
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
    required this.reviewBindingPassClaimed,
    required this.ocrPassClaimed,
    required this.bindingLabel,
  });

  final bool q273ImageToLatexPrototypeGatePresent;
  final bool q273StillNoRealInferenceNoRuntime;
  final bool candidateEnvelopeAccepted;
  final bool primaryLatexCandidatePreserved;
  final bool alternativeCandidatesPreserved;
  final bool confidenceWarningsEngineMetadataPreserved;
  final bool imageHashCropBoundsPreprocessMetadataPreserved;
  final bool editableMathLiveReviewRequired;
  final bool reviewDraftMayBeEditedBeforeImport;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final bool workspaceImportPreparedOnlyAfterUserApproval;
  final bool directWorkspaceImportBlocked;
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
  final bool reviewBindingPassClaimed;
  final bool ocrPassClaimed;
  final String bindingLabel;
}

class GaussOcrResultMathLiveRealReviewBindingResult {
  const GaussOcrResultMathLiveRealReviewBindingResult({
    required this.decision,
    required this.reviewBindingStaticReady,
    required this.input,
  });

  final GaussOcrResultMathLiveRealReviewBindingDecision decision;
  final bool reviewBindingStaticReady;
  final GaussOcrResultMathLiveRealReviewBindingInput input;

  String get phase => GaussOcrResultMathLiveRealReviewBindingPolicy.phase;
  String get sourcePhase => GaussOcrResultMathLiveRealReviewBindingPolicy.sourcePhase;
  String get selectedEngineLabel => GaussOcrResultMathLiveRealReviewBindingPolicy.selectedEngineLabel;
  String get reviewBindingMode => GaussOcrResultMathLiveRealReviewBindingPolicy.reviewBindingMode;
  bool get realOcrRuntimeAdded => GaussOcrResultMathLiveRealReviewBindingPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussOcrResultMathLiveRealReviewBindingPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussOcrResultMathLiveRealReviewBindingPolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeImplementationAdded => GaussOcrResultMathLiveRealReviewBindingPolicy.nativeBridgeImplementationAdded;
  bool get jniBindingAdded => GaussOcrResultMathLiveRealReviewBindingPolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussOcrResultMathLiveRealReviewBindingPolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussOcrResultMathLiveRealReviewBindingPolicy.modelBinaryBundledInBaseApp;
  bool get productionDownloadEnabled => GaussOcrResultMathLiveRealReviewBindingPolicy.productionDownloadEnabled;
  bool get productionInferenceAllowed => GaussOcrResultMathLiveRealReviewBindingPolicy.productionInferenceAllowed;
  bool get runtimeFeatureFlagDefaultOff => GaussOcrResultMathLiveRealReviewBindingPolicy.runtimeFeatureFlagDefaultOff;
  bool get realImageToLatexInferenceExecuted => GaussOcrResultMathLiveRealReviewBindingPolicy.realImageToLatexInferenceExecuted;
  bool get reviewBindingPassClaimed => GaussOcrResultMathLiveRealReviewBindingPolicy.reviewBindingPassClaimed;
  bool get ocrPassClaimed => GaussOcrResultMathLiveRealReviewBindingPolicy.ocrPassClaimed;
  bool get canBindToMathLiveReviewInQ274 => reviewBindingStaticReady;
  bool get canImportWorkspaceWithoutUserApproval => false;
  bool get canClaimOcrPassInQ274 => false;

  List<String> get requiredReviewBindingGates => GaussOcrResultMathLiveRealReviewBindingPolicy.requiredReviewBindingGates;
  List<String> get reviewDraftEnvelopeFields => GaussOcrResultMathLiveRealReviewBindingPolicy.reviewDraftEnvelopeFields;
  List<String> get reviewBindingFailureCodes => GaussOcrResultMathLiveRealReviewBindingPolicy.reviewBindingFailureCodes;
  List<String> get forbiddenActions => GaussOcrResultMathLiveRealReviewBindingPolicy.forbiddenActions;
}

class GaussOcrResultMathLiveRealReviewBinding {
  const GaussOcrResultMathLiveRealReviewBinding._();

  static GaussOcrResultMathLiveRealReviewBindingResult evaluate(
    GaussOcrResultMathLiveRealReviewBindingInput input,
  ) {
    if (!input.q273ImageToLatexPrototypeGatePresent || !input.q273StillNoRealInferenceNoRuntime) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedMissingQ273ImageToLatexPrototypeGate, input);
    }
    if (!input.candidateEnvelopeAccepted) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedMissingCandidateEnvelope, input);
    }
    if (!input.primaryLatexCandidatePreserved) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedMissingPrimaryLatexCandidate, input);
    }
    if (!input.editableMathLiveReviewRequired || !input.reviewDraftMayBeEditedBeforeImport) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedMissingEditableMathLiveReview, input);
    }
    if (!input.alternativeCandidatesPreserved) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedMissingAlternativeCandidateHandling, input);
    }
    if (!input.confidenceWarningsEngineMetadataPreserved || !input.imageHashCropBoundsPreprocessMetadataPreserved) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedMissingConfidenceWarningsMetadata, input);
    }
    if (!input.userApprovalRequiredBeforeWorkspaceImport || !input.workspaceImportPreparedOnlyAfterUserApproval) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedUserApprovalNotRequired, input);
    }
    if (!input.directWorkspaceImportBlocked) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedDirectWorkspaceImportRisk, input);
    }
    if (!input.directSolveBlocked || !input.directGraphSolutionHistoryBlocked) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedDirectSolveGraphSolutionHistoryRisk, input);
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
        input.reviewBindingPassClaimed ||
        input.ocrPassClaimed;
    if (unsafeRuntimeClaim) {
      return _blocked(GaussOcrResultMathLiveRealReviewBindingDecision.blockedUnsafeRuntimeOrInferenceClaim, input);
    }
    return GaussOcrResultMathLiveRealReviewBindingResult(
      decision: GaussOcrResultMathLiveRealReviewBindingDecision.readyForFutureMathLiveReviewBindingOnly,
      reviewBindingStaticReady: true,
      input: input,
    );
  }

  static GaussOcrResultMathLiveRealReviewBindingResult _blocked(
    GaussOcrResultMathLiveRealReviewBindingDecision decision,
    GaussOcrResultMathLiveRealReviewBindingInput input,
  ) {
    return GaussOcrResultMathLiveRealReviewBindingResult(
      decision: decision,
      reviewBindingStaticReady: false,
      input: input,
    );
  }
}
