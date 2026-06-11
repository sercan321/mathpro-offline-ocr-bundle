import 'gauss_pp_formulanet_s_runtime_source_evidence_policy.dart';

enum GaussPpFormulaNetSRuntimeSourceEvidenceDecision {
  blockedMissingOfficialSourceEvidence,
  blockedMissingLicenseOrArtifactEvidence,
  blockedMissingChecksumEvidence,
  blockedMissingAndroidRuntimeEvidence,
  blockedUnsafeRuntimeBindingAttempt,
  blockedMissingMathLiveReviewSafety,
  runtimeSourceEvidenceStaticReady,
}

class GaussPpFormulaNetSRuntimeSourceEvidenceInput {
  const GaussPpFormulaNetSRuntimeSourceEvidenceInput({
    required this.officialPaddleOcrDocumentationVerified,
    required this.officialPaddleXDocumentationVerified,
    required this.officialModelRepositoryVerified,
    required this.apache2LicenseEvidenceVerified,
    required this.modelStorageSizeEvidenceVerified,
    required this.expectedSha256Recorded,
    required this.actualSha256VerifiedAfterDownload,
    required this.androidRuntimeFeasibilityVerified,
    required this.latencyAndMemoryBudgetRecorded,
    required this.privateAppStoragePlanned,
    required this.offlineAfterInstallPlanned,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noProductionInferenceAllowed,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.evidenceLabel,
  });

  final bool officialPaddleOcrDocumentationVerified;
  final bool officialPaddleXDocumentationVerified;
  final bool officialModelRepositoryVerified;
  final bool apache2LicenseEvidenceVerified;
  final bool modelStorageSizeEvidenceVerified;
  final bool expectedSha256Recorded;
  final bool actualSha256VerifiedAfterDownload;
  final bool androidRuntimeFeasibilityVerified;
  final bool latencyAndMemoryBudgetRecorded;
  final bool privateAppStoragePlanned;
  final bool offlineAfterInstallPlanned;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noProductionInferenceAllowed;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String evidenceLabel;

  bool get hasEvidenceLabel => evidenceLabel.trim().isNotEmpty;
}

class GaussPpFormulaNetSRuntimeSourceEvidenceResult {
  const GaussPpFormulaNetSRuntimeSourceEvidenceResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.productionInferenceAllowed,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
  });

  final String phase;
  final String sourcePhase;
  final GaussPpFormulaNetSRuntimeSourceEvidenceDecision decision;
  final GaussPpFormulaNetSRuntimeSourceEvidenceInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool productionInferenceAllowed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get runtimeSourceEvidenceStaticReady =>
      decision == GaussPpFormulaNetSRuntimeSourceEvidenceDecision.runtimeSourceEvidenceStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSRuntimeSourceEvidencePolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSRuntimeSourceEvidencePolicy.fallbackEngineLabel &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      productionInferenceAllowed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canClaimOcrPass => false;
  bool get canClaimFlutterPassWithoutLogs => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canSetProductionModelUrlWithoutSha256 => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
  bool get canSolveCameraOutputBeforeReviewApproval => false;
}

/// Q254 PP-FormulaNet-S source evidence gate.
///
/// This class intentionally stops before production runtime binding. It creates
/// a deterministic court for official docs, model repository, Apache-2.0
/// license evidence, model-size evidence, SHA256, Android runtime feasibility,
/// private storage, offline-after-install behavior, and MathLive editable review
/// safety. Real inference remains a later phase.
class GaussPpFormulaNetSRuntimeSourceEvidenceGate {
  const GaussPpFormulaNetSRuntimeSourceEvidenceGate._();

  static const phase = GaussPpFormulaNetSRuntimeSourceEvidencePolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSRuntimeSourceEvidencePolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSRuntimeSourceEvidencePolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSRuntimeSourceEvidencePolicy.fallbackEngineLabel;

  static const requiresOfficialPaddleOcrDocumentation = true;
  static const requiresOfficialPaddleXDocumentation = true;
  static const requiresOfficialModelRepository = true;
  static const requiresApache2LicenseEvidence = true;
  static const requiresExpectedSha256BeforeDownload = true;
  static const requiresActualSha256AfterDownload = true;
  static const requiresAndroidRuntimeFeasibilityEvidence = true;
  static const requiresEditableMathLiveReview = true;
  static const allowsProductionInferenceInQ254 = false;
  static const callsProductionMathLiveBridge = false;

  static GaussPpFormulaNetSRuntimeSourceEvidenceResult evaluate(
    GaussPpFormulaNetSRuntimeSourceEvidenceInput input,
  ) {
    final issues = <String>[];

    if (!input.officialPaddleOcrDocumentationVerified ||
        !input.officialPaddleXDocumentationVerified ||
        !input.officialModelRepositoryVerified) {
      issues.add('PP-FormulaNet-S official PaddleOCR/PaddleX/model repository evidence must be verified before runtime binding.');
    }
    if (!input.apache2LicenseEvidenceVerified || !input.modelStorageSizeEvidenceVerified) {
      issues.add('PP-FormulaNet-S license and model storage-size evidence must be verified before distribution planning.');
    }
    if (!input.expectedSha256Recorded || !input.actualSha256VerifiedAfterDownload) {
      issues.add('Expected SHA256 and post-download actual SHA256 verification are mandatory before using model artifacts.');
    }
    if (!input.androidRuntimeFeasibilityVerified || !input.latencyAndMemoryBudgetRecorded) {
      issues.add('Android runtime feasibility plus latency and memory budget evidence must be recorded before inference work.');
    }
    if (!input.privateAppStoragePlanned || !input.offlineAfterInstallPlanned) {
      issues.add('Model storage must use private app storage and support offline-after-install behavior.');
    }
    if (!input.noPaddleRuntimeDependencyAdded ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noProductionModelUrlBound ||
        !input.noProductionInferenceAllowed) {
      issues.add('Q254 must not bind Paddle runtime, bundle model bytes, set production URL, or allow production inference.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Editable MathLive review, user approval, and direct solve/Graph/Solution/History blocks must remain mandatory.');
    }
    if (!input.hasEvidenceLabel) {
      issues.add('Q254 requires a static evidence label.');
    }

    return GaussPpFormulaNetSRuntimeSourceEvidenceResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: _decisionFor(input, issues),
      input: input,
      issues: List<String>.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      realOcrRuntimeAdded: false,
      paddleRuntimeAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      productionInferenceAllowed: false,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
    );
  }

  static GaussPpFormulaNetSRuntimeSourceEvidenceDecision _decisionFor(
    GaussPpFormulaNetSRuntimeSourceEvidenceInput input,
    List<String> issues,
  ) {
    if (!input.officialPaddleOcrDocumentationVerified ||
        !input.officialPaddleXDocumentationVerified ||
        !input.officialModelRepositoryVerified) {
      return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingOfficialSourceEvidence;
    }
    if (!input.apache2LicenseEvidenceVerified || !input.modelStorageSizeEvidenceVerified) {
      return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingLicenseOrArtifactEvidence;
    }
    if (!input.expectedSha256Recorded || !input.actualSha256VerifiedAfterDownload) {
      return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingChecksumEvidence;
    }
    if (!input.androidRuntimeFeasibilityVerified || !input.latencyAndMemoryBudgetRecorded) {
      return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingAndroidRuntimeEvidence;
    }
    if (!input.noPaddleRuntimeDependencyAdded ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noProductionModelUrlBound ||
        !input.noProductionInferenceAllowed) {
      return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedUnsafeRuntimeBindingAttempt;
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingMathLiveReviewSafety;
    }
    if (issues.isNotEmpty) {
      return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.blockedMissingOfficialSourceEvidence;
    }
    return GaussPpFormulaNetSRuntimeSourceEvidenceDecision.runtimeSourceEvidenceStaticReady;
  }
}
