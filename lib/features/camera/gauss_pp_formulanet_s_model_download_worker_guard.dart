import 'gauss_pp_formulanet_s_model_download_worker_guard_policy.dart';

enum GaussPpFormulaNetSModelDownloadWorkerGuardDecision {
  blockedMissingOfficialSourceEvidence,
  blockedMissingChecksumPlan,
  blockedUnsafeStoragePlan,
  blockedMissingCleanupPlan,
  blockedMissingNetworkPolicy,
  blockedUnsafeRuntimeBindingAttempt,
  blockedMissingMathLiveReviewSafety,
  modelDownloadWorkerGuardStaticReady,
}

class GaussPpFormulaNetSModelDownloadWorkerGuardInput {
  const GaussPpFormulaNetSModelDownloadWorkerGuardInput({
    required this.officialSourceEvidenceVerified,
    required this.expectedSha256RecordedBeforeDownload,
    required this.actualSha256VerificationPlannedAfterDownload,
    required this.downloadsIntoTemporaryPrivateFile,
    required this.atomicMoveOnlyAfterChecksumPass,
    required this.partialDownloadCleanupPlanned,
    required this.corruptArtifactCleanupPlanned,
    required this.neverUseUnverifiedModel,
    required this.offlineAfterInstallReadyStatePlanned,
    required this.networkPolicyRequiresUserConsentOrWifi,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noProductionInferenceAllowed,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.guardLabel,
  });

  final bool officialSourceEvidenceVerified;
  final bool expectedSha256RecordedBeforeDownload;
  final bool actualSha256VerificationPlannedAfterDownload;
  final bool downloadsIntoTemporaryPrivateFile;
  final bool atomicMoveOnlyAfterChecksumPass;
  final bool partialDownloadCleanupPlanned;
  final bool corruptArtifactCleanupPlanned;
  final bool neverUseUnverifiedModel;
  final bool offlineAfterInstallReadyStatePlanned;
  final bool networkPolicyRequiresUserConsentOrWifi;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noProductionInferenceAllowed;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String guardLabel;

  bool get hasGuardLabel => guardLabel.trim().isNotEmpty;
}

class GaussPpFormulaNetSModelDownloadWorkerGuardResult {
  const GaussPpFormulaNetSModelDownloadWorkerGuardResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.installStates,
    required this.requiredWorkerSafetyGates,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionInferenceAllowed,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
  });

  final String phase;
  final String sourcePhase;
  final GaussPpFormulaNetSModelDownloadWorkerGuardDecision decision;
  final GaussPpFormulaNetSModelDownloadWorkerGuardInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final List<String> installStates;
  final List<String> requiredWorkerSafetyGates;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionInferenceAllowed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get modelDownloadWorkerGuardStaticReady =>
      decision == GaussPpFormulaNetSModelDownloadWorkerGuardDecision.modelDownloadWorkerGuardStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.fallbackEngineLabel &&
      installStates.length == GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.guardedInstallStates.length &&
      requiredWorkerSafetyGates.length == GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.requiredWorkerSafetyGates.length &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      realNetworkDownloadWorkerImplemented == false &&
      productionInferenceAllowed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canClaimModelDownloadPass => false;
  bool get canClaimOcrPass => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canUseUnverifiedDownloadedModel => false;
  bool get canBindProductionModelUrlWithoutChecksum => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q255 PP-FormulaNet-S model download worker guard.
///
/// This is a guard-only layer. A later real downloader may reuse this contract,
/// but Q255 itself intentionally performs no network I/O and binds no model URL.
/// The model can only become usable after official source evidence, expected
/// SHA256, post-download checksum verification, private temporary storage,
/// atomic verified move, cleanup on failure, offline-ready state, and editable
/// MathLive review/user approval are all satisfied.
class GaussPpFormulaNetSModelDownloadWorkerGuard {
  const GaussPpFormulaNetSModelDownloadWorkerGuard._();

  static const phase = GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.fallbackEngineLabel;

  static const requiresExpectedSha256BeforeDownload = true;
  static const requiresActualSha256AfterDownload = true;
  static const requiresTemporaryPrivateFile = true;
  static const requiresAtomicMoveAfterVerify = true;
  static const requiresPartialDownloadCleanup = true;
  static const requiresCorruptDownloadCleanup = true;
  static const allowsProductionModelUrlInQ255 = false;
  static const implementsRealNetworkDownloadWorkerInQ255 = false;
  static const allowsProductionInferenceInQ255 = false;

  static GaussPpFormulaNetSModelDownloadWorkerGuardResult evaluate(
    GaussPpFormulaNetSModelDownloadWorkerGuardInput input,
  ) {
    final issues = <String>[];

    if (!input.officialSourceEvidenceVerified) {
      issues.add('PP-FormulaNet-S official source evidence must remain verified before download planning.');
    }
    if (!input.expectedSha256RecordedBeforeDownload || !input.actualSha256VerificationPlannedAfterDownload) {
      issues.add('Expected SHA256 before download and actual SHA256 verification after download are mandatory.');
    }
    if (!input.downloadsIntoTemporaryPrivateFile || !input.atomicMoveOnlyAfterChecksumPass || !input.neverUseUnverifiedModel) {
      issues.add('Model artifacts must be staged in private temporary storage and atomically promoted only after checksum pass.');
    }
    if (!input.partialDownloadCleanupPlanned || !input.corruptArtifactCleanupPlanned) {
      issues.add('Partial downloads and corrupt artifacts must be deleted and must never enter ready state.');
    }
    if (!input.offlineAfterInstallReadyStatePlanned || !input.networkPolicyRequiresUserConsentOrWifi) {
      issues.add('Offline-after-install readiness and user-consent/Wi-Fi network policy are mandatory.');
    }
    if (!input.noModelBinaryBundledInBaseApp ||
        !input.noProductionModelUrlBound ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      issues.add('Q255 must not bundle model bytes, bind production URL, implement real network download, add Paddle runtime, or allow inference.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Editable MathLive review, explicit user approval, and direct solve/Graph/Solution/History blocks must remain mandatory.');
    }
    if (!input.hasGuardLabel) {
      issues.add('Q255 requires a static download worker guard label.');
    }

    return GaussPpFormulaNetSModelDownloadWorkerGuardResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: _decisionFor(input),
      input: input,
      issues: List<String>.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      installStates: List<String>.unmodifiable(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.guardedInstallStates),
      requiredWorkerSafetyGates: List<String>.unmodifiable(GaussPpFormulaNetSModelDownloadWorkerGuardPolicy.requiredWorkerSafetyGates),
      realOcrRuntimeAdded: false,
      paddleRuntimeAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      realNetworkDownloadWorkerImplemented: false,
      productionInferenceAllowed: false,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
    );
  }

  static GaussPpFormulaNetSModelDownloadWorkerGuardDecision _decisionFor(
    GaussPpFormulaNetSModelDownloadWorkerGuardInput input,
  ) {
    if (!input.officialSourceEvidenceVerified) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingOfficialSourceEvidence;
    }
    if (!input.expectedSha256RecordedBeforeDownload || !input.actualSha256VerificationPlannedAfterDownload) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingChecksumPlan;
    }
    if (!input.downloadsIntoTemporaryPrivateFile || !input.atomicMoveOnlyAfterChecksumPass || !input.neverUseUnverifiedModel) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedUnsafeStoragePlan;
    }
    if (!input.partialDownloadCleanupPlanned || !input.corruptArtifactCleanupPlanned) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingCleanupPlan;
    }
    if (!input.offlineAfterInstallReadyStatePlanned || !input.networkPolicyRequiresUserConsentOrWifi) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingNetworkPolicy;
    }
    if (!input.noModelBinaryBundledInBaseApp ||
        !input.noProductionModelUrlBound ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedUnsafeRuntimeBindingAttempt;
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingMathLiveReviewSafety;
    }
    if (!input.hasGuardLabel) {
      return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.blockedMissingChecksumPlan;
    }
    return GaussPpFormulaNetSModelDownloadWorkerGuardDecision.modelDownloadWorkerGuardStaticReady;
  }
}
