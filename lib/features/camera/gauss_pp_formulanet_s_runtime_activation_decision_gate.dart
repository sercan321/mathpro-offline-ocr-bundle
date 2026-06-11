import 'gauss_pp_formulanet_s_runtime_activation_decision_gate_policy.dart';

enum GaussPpFormulaNetSRuntimeActivationDecisionGateDecision {
  rejectedMissingQ265AcceptedEvidence,
  rejectedUnsafeRuntimeCandidate,
  rejectedMissingRuntimePathEvidence,
  rejectedUnsupportedAbi,
  rejectedModelFormatMismatch,
  rejectedPrivateArtifactNotVerified,
  rejectedLatencyBudget,
  rejectedPeakMemoryBudget,
  rejectedMissingFallbackPlan,
  rejectedMissingMathLiveReviewRequirement,
  rejectedDirectSolveOrImportRisk,
  approvedForFutureRuntimeIntegrationGateOnly,
}

class GaussPpFormulaNetSRuntimeActivationDecisionGateInput {
  const GaussPpFormulaNetSRuntimeActivationDecisionGateInput({
    required this.q265AcceptedEvidencePresent,
    required this.runtimeCandidateSelected,
    required this.runtimeCandidateSafe,
    required this.runtimePathEvidencePresent,
    required this.androidAbiSupported,
    required this.modelFormatAccepted,
    required this.privateArtifactVerified,
    required this.artifactSha256AcceptedByQ265,
    required this.latencyMs,
    required this.peakMemoryMb,
    required this.fallbackPlanDefined,
    required this.formulaOcrPrimaryOnly,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveBlocked,
    required this.directGraphSolutionHistoryBlocked,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noNativeBridgeAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.noProductionInferenceAllowed,
    required this.runtimeActivationPassClaimed,
    required this.ocrPassClaimed,
    required this.activationLabel,
  });

  final bool q265AcceptedEvidencePresent;
  final bool runtimeCandidateSelected;
  final bool runtimeCandidateSafe;
  final bool runtimePathEvidencePresent;
  final bool androidAbiSupported;
  final bool modelFormatAccepted;
  final bool privateArtifactVerified;
  final bool artifactSha256AcceptedByQ265;
  final int latencyMs;
  final int peakMemoryMb;
  final bool fallbackPlanDefined;
  final bool formulaOcrPrimaryOnly;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveBlocked;
  final bool directGraphSolutionHistoryBlocked;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noNativeBridgeAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool noProductionInferenceAllowed;
  final bool runtimeActivationPassClaimed;
  final bool ocrPassClaimed;
  final String activationLabel;
}

class GaussPpFormulaNetSRuntimeActivationDecisionGateResult {
  const GaussPpFormulaNetSRuntimeActivationDecisionGateResult._({
    required this.decision,
    required this.runtimeActivationDecisionGateStaticReady,
    required this.approvedForFutureRuntimeIntegrationGateOnly,
    required this.rejectionReasons,
    required this.canActivateRuntimeInQ266,
    required this.canClaimRuntimeActivationPassInQ266,
    required this.canClaimOcrPassInQ266,
    required this.canAddPaddleRuntimeInQ266,
    required this.canBindRuntimeBridgeInQ266,
    required this.canImportCameraOutputWithoutUserApproval,
    required this.activationLabel,
  });

  final GaussPpFormulaNetSRuntimeActivationDecisionGateDecision decision;
  final bool runtimeActivationDecisionGateStaticReady;
  final bool approvedForFutureRuntimeIntegrationGateOnly;
  final List<String> rejectionReasons;
  final bool canActivateRuntimeInQ266;
  final bool canClaimRuntimeActivationPassInQ266;
  final bool canClaimOcrPassInQ266;
  final bool canAddPaddleRuntimeInQ266;
  final bool canBindRuntimeBridgeInQ266;
  final bool canImportCameraOutputWithoutUserApproval;
  final String activationLabel;

  String get phase => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.phase;
  String get sourcePhase => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.sourcePhase;
  String get selectedEngineLabel => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.fallbackEngineLabel;
  String get activationMode => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.activationMode;
  List<String> get activationDecisionStates => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.activationDecisionStates;
  List<String> get requiredActivationGates => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.requiredActivationGates;
  List<String> get blockedUntilRealEvidence => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.forbiddenActions;
  bool get realOcrRuntimeAdded => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeAdded => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.nativeBridgeAdded;
  bool get jniBindingAdded => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.modelBinaryBundledInBaseApp;
  bool get productionModelUrlBound => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.productionModelUrlBound;
  bool get realNetworkDownloadWorkerImplemented => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.realNetworkDownloadWorkerImplemented;
  bool get productionDownloadEnabled => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.productionDownloadEnabled;
  bool get productionInferenceAllowed => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.productionInferenceAllowed;
  bool get runtimeActivationPassClaimed => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.runtimeActivationPassClaimed;
  bool get ocrPassClaimed => GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.ocrPassClaimed;
}

class GaussPpFormulaNetSRuntimeActivationDecisionGate {
  const GaussPpFormulaNetSRuntimeActivationDecisionGate._();

  static GaussPpFormulaNetSRuntimeActivationDecisionGateResult evaluate(GaussPpFormulaNetSRuntimeActivationDecisionGateInput input) {
    GaussPpFormulaNetSRuntimeActivationDecisionGateResult reject(
      GaussPpFormulaNetSRuntimeActivationDecisionGateDecision decision,
      String reason,
    ) => GaussPpFormulaNetSRuntimeActivationDecisionGateResult._(
      decision: decision,
      runtimeActivationDecisionGateStaticReady: false,
      approvedForFutureRuntimeIntegrationGateOnly: false,
      rejectionReasons: <String>[reason],
      canActivateRuntimeInQ266: false,
      canClaimRuntimeActivationPassInQ266: false,
      canClaimOcrPassInQ266: false,
      canAddPaddleRuntimeInQ266: false,
      canBindRuntimeBridgeInQ266: false,
      canImportCameraOutputWithoutUserApproval: false,
      activationLabel: input.activationLabel,
    );

    if (!input.q265AcceptedEvidencePresent) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedMissingQ265AcceptedEvidence, 'missingQ265AcceptedEvidence');
    if (!input.runtimeCandidateSelected || !input.runtimeCandidateSafe) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedUnsafeRuntimeCandidate, 'unsafeRuntimeCandidate');
    if (!input.runtimePathEvidencePresent) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedMissingRuntimePathEvidence, 'missingRuntimePathEvidence');
    if (!input.androidAbiSupported) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedUnsupportedAbi, 'unsupportedAndroidAbi');
    if (!input.modelFormatAccepted) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedModelFormatMismatch, 'modelFormatMismatch');
    if (!input.privateArtifactVerified || !input.artifactSha256AcceptedByQ265) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedPrivateArtifactNotVerified, 'privateArtifactNotVerified');
    if (input.latencyMs <= 0 || input.latencyMs > GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.latencyBudgetMs) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedLatencyBudget, 'latencyBudgetExceededOrMissing');
    if (input.peakMemoryMb <= 0 || input.peakMemoryMb > GaussPpFormulaNetSRuntimeActivationDecisionGatePolicy.peakMemoryBudgetMb) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedPeakMemoryBudget, 'peakMemoryBudgetExceededOrMissing');
    if (!input.fallbackPlanDefined || !input.formulaOcrPrimaryOnly) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedMissingFallbackPlan, 'missingFallbackPlan');
    if (!input.editableMathLiveReviewRequired || !input.userApprovalRequiredBeforeWorkspaceImport) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedMissingMathLiveReviewRequirement, 'missingMathLiveReviewRequirement');
    if (!input.directSolveBlocked || !input.directGraphSolutionHistoryBlocked) return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedDirectSolveOrImportRisk, 'directSolveOrImportRisk');
    if (!input.noPaddleRuntimeDependencyAdded || !input.noPaddleOcrDependencyAdded || !input.noNativeBridgeAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noRealNetworkDownloadWorkerImplemented || input.productionDownloadEnabled || !input.noProductionInferenceAllowed || input.runtimeActivationPassClaimed || input.ocrPassClaimed) {
      return reject(GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.rejectedUnsafeRuntimeCandidate, 'unsafeRuntimeBindingOrFalsePassAttempt');
    }

    return GaussPpFormulaNetSRuntimeActivationDecisionGateResult._(
      decision: GaussPpFormulaNetSRuntimeActivationDecisionGateDecision.approvedForFutureRuntimeIntegrationGateOnly,
      runtimeActivationDecisionGateStaticReady: true,
      approvedForFutureRuntimeIntegrationGateOnly: true,
      rejectionReasons: const <String>[],
      canActivateRuntimeInQ266: false,
      canClaimRuntimeActivationPassInQ266: false,
      canClaimOcrPassInQ266: false,
      canAddPaddleRuntimeInQ266: false,
      canBindRuntimeBridgeInQ266: false,
      canImportCameraOutputWithoutUserApproval: false,
      activationLabel: input.activationLabel,
    );
  }
}
