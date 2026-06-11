import 'gauss_pp_formulanet_s_production_artifact_resolver_gate_policy.dart';

enum GaussPpFormulaNetSProductionArtifactResolverDecision {
  blockedMissingQ257OrchestratorGate,
  blockedMissingQ256ArtifactShaGate,
  blockedMissingResolverManifestFields,
  blockedInvalidShaCandidate,
  blockedProductionDownloadEnabled,
  blockedUnsafeUrlOrRuntimeBinding,
  blockedMissingLicenseSizeOrRuntimeEvidence,
  blockedMissingChecksumSafety,
  blockedMissingMathLiveReviewSafety,
  productionArtifactResolverGateStaticReady,
}

class GaussPpFormulaNetSProductionArtifactResolverInput {
  const GaussPpFormulaNetSProductionArtifactResolverInput({
    required this.q257DownloadOrchestratorUiGuardPresent,
    required this.q256ArtifactManifestShaGatePresent,
    required this.officialArtifactSourceLabelPresent,
    required this.artifactVersionLabelPresent,
    required this.artifactLicenseLabelPresent,
    required this.artifactStorageSizeBudgetPresent,
    required this.androidRuntimeCompatibilityLabelPresent,
    required this.latencyAndMemoryBudgetPresent,
    required this.productionArtifactUrlCandidateBound,
    required this.expectedSha256Candidate,
    required this.productionDownloadEnabled,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noModelBinaryBundledInBaseApp,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noProductionInferenceAllowed,
    required this.checksumMismatchBlocksReadyState,
    required this.urlCannotEnableDownloadWithoutExpectedSha,
    required this.downloadDisabledByDefaultVisible,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.resolverLabel,
  });

  final bool q257DownloadOrchestratorUiGuardPresent;
  final bool q256ArtifactManifestShaGatePresent;
  final bool officialArtifactSourceLabelPresent;
  final bool artifactVersionLabelPresent;
  final bool artifactLicenseLabelPresent;
  final bool artifactStorageSizeBudgetPresent;
  final bool androidRuntimeCompatibilityLabelPresent;
  final bool latencyAndMemoryBudgetPresent;
  final bool productionArtifactUrlCandidateBound;
  final String expectedSha256Candidate;
  final bool productionDownloadEnabled;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noModelBinaryBundledInBaseApp;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noProductionInferenceAllowed;
  final bool checksumMismatchBlocksReadyState;
  final bool urlCannotEnableDownloadWithoutExpectedSha;
  final bool downloadDisabledByDefaultVisible;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String resolverLabel;

  bool get allResolverManifestFieldsPresent =>
      officialArtifactSourceLabelPresent &&
      artifactVersionLabelPresent &&
      artifactLicenseLabelPresent &&
      artifactStorageSizeBudgetPresent &&
      androidRuntimeCompatibilityLabelPresent &&
      latencyAndMemoryBudgetPresent &&
      downloadDisabledByDefaultVisible;

  bool get expectedShaCandidateIsEmptyOr64Hex =>
      expectedSha256Candidate.isEmpty || RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(expectedSha256Candidate);

  bool get sourceLicenseSizeRuntimeEvidencePresent =>
      officialArtifactSourceLabelPresent &&
      artifactVersionLabelPresent &&
      artifactLicenseLabelPresent &&
      artifactStorageSizeBudgetPresent &&
      androidRuntimeCompatibilityLabelPresent &&
      latencyAndMemoryBudgetPresent;

  bool get hasResolverLabel => resolverLabel.trim().isNotEmpty;
}

class GaussPpFormulaNetSProductionArtifactResolverResult {
  const GaussPpFormulaNetSProductionArtifactResolverResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.resolverMode,
    required this.requiredResolverFields,
    required this.requiredResolverSafetyGates,
    required this.blockedUntilRealEvidence,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.expectedProductionSha256Locked,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.productionInferenceAllowed,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
  });

  final String phase;
  final String sourcePhase;
  final GaussPpFormulaNetSProductionArtifactResolverDecision decision;
  final GaussPpFormulaNetSProductionArtifactResolverInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final String resolverMode;
  final List<String> requiredResolverFields;
  final List<String> requiredResolverSafetyGates;
  final List<String> blockedUntilRealEvidence;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool expectedProductionSha256Locked;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool productionInferenceAllowed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get productionArtifactResolverGateStaticReady =>
      decision == GaussPpFormulaNetSProductionArtifactResolverDecision.productionArtifactResolverGateStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSProductionArtifactResolverGatePolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSProductionArtifactResolverGatePolicy.fallbackEngineLabel &&
      resolverMode == GaussPpFormulaNetSProductionArtifactResolverGatePolicy.resolverMode &&
      requiredResolverFields.length == GaussPpFormulaNetSProductionArtifactResolverGatePolicy.requiredResolverFields.length &&
      requiredResolverSafetyGates.length == GaussPpFormulaNetSProductionArtifactResolverGatePolicy.requiredResolverSafetyGates.length &&
      blockedUntilRealEvidence.length == GaussPpFormulaNetSProductionArtifactResolverGatePolicy.blockedUntilRealEvidence.length &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      paddleOcrDependencyAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      expectedProductionSha256Locked == false &&
      realNetworkDownloadWorkerImplemented == false &&
      productionDownloadEnabled == false &&
      productionInferenceAllowed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canResolveProductionArtifactUrl => false;
  bool get canLockExpectedProductionSha256 => false;
  bool get canEnableProductionDownloadInQ258 => false;
  bool get canClaimModelDownloadPass => false;
  bool get canClaimOcrPass => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q258 PP-FormulaNet-S production artifact resolver gate.
///
/// Q258 defines the production artifact resolver contract and blocker list. It
/// does not bind a real artifact URL, does not lock a real production SHA, does
/// not implement a downloader, does not ship model bytes, and does not run OCR.
class GaussPpFormulaNetSProductionArtifactResolverGate {
  const GaussPpFormulaNetSProductionArtifactResolverGate._();

  static const phase = GaussPpFormulaNetSProductionArtifactResolverGatePolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSProductionArtifactResolverGatePolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSProductionArtifactResolverGatePolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSProductionArtifactResolverGatePolicy.fallbackEngineLabel;

  static const productionArtifactUrlResolutionEnabledInQ258 = false;
  static const productionShaLockEnabledInQ258 = false;
  static const productionDownloadEnabledInQ258 = false;
  static const implementsRealNetworkDownloadWorkerInQ258 = false;
  static const allowsProductionInferenceInQ258 = false;

  static GaussPpFormulaNetSProductionArtifactResolverResult evaluate(
    GaussPpFormulaNetSProductionArtifactResolverInput input,
  ) {
    final issues = <String>[];

    if (!input.q257DownloadOrchestratorUiGuardPresent) {
      issues.add('Q258 requires the Q257 download-orchestrator UI guard before artifact resolution can be trusted.');
    }
    if (!input.q256ArtifactManifestShaGatePresent) {
      issues.add('Q258 requires the Q256 artifact manifest/SHA gate before any artifact resolver state is trusted.');
    }
    if (!input.allResolverManifestFieldsPresent) {
      issues.add('Resolver manifest fields for source, version, license, size, runtime, latency/memory, and disabled download are mandatory.');
    }
    if (!input.expectedShaCandidateIsEmptyOr64Hex) {
      issues.add('Expected SHA candidate must be empty while unlocked or exactly 64 hexadecimal characters when supplied.');
    }
    if (input.productionDownloadEnabled) {
      issues.add('Q258 keeps production download disabled by default.');
    }
    if (input.productionArtifactUrlCandidateBound ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noPaddleOcrDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      issues.add('Q258 must not bind URL, implement downloader, ship model bytes, add Paddle runtime, add PaddleOCR, or enable inference.');
    }
    if (!input.sourceLicenseSizeRuntimeEvidencePresent) {
      issues.add('Source, license, artifact size, Android runtime, latency, and memory evidence gates remain mandatory.');
    }
    if (!input.checksumMismatchBlocksReadyState || !input.urlCannotEnableDownloadWithoutExpectedSha || !input.downloadDisabledByDefaultVisible) {
      issues.add('Checksum mismatch, URL/SHA coupling, and disabled-by-default download safety must stay visible.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Editable MathLive review, explicit approval, and direct solve/Graph/Solution/History blocks remain mandatory.');
    }
    if (!input.hasResolverLabel) {
      issues.add('Q258 requires a static resolver label.');
    }

    return GaussPpFormulaNetSProductionArtifactResolverResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: _decisionFor(input, issues),
      input: input,
      issues: List.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      resolverMode: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.resolverMode,
      requiredResolverFields: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.requiredResolverFields,
      requiredResolverSafetyGates: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.requiredResolverSafetyGates,
      blockedUntilRealEvidence: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.blockedUntilRealEvidence,
      realOcrRuntimeAdded: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.realOcrRuntimeAdded,
      paddleRuntimeAdded: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.paddleRuntimeAdded,
      paddleOcrDependencyAdded: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.paddleOcrDependencyAdded,
      modelBinaryBundledInBaseApp: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.modelBinaryBundledInBaseApp,
      productionModelUrlBound: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.productionModelUrlBound,
      expectedProductionSha256Locked: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.expectedProductionSha256Locked,
      realNetworkDownloadWorkerImplemented: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.realNetworkDownloadWorkerImplemented,
      productionDownloadEnabled: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.productionDownloadEnabled,
      productionInferenceAllowed: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.productionInferenceAllowed,
      editableMathLiveReviewRequired: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.editableMathLiveReviewRequired,
      userApprovalRequiredBeforeWorkspaceImport: GaussPpFormulaNetSProductionArtifactResolverGatePolicy.userApprovalRequiredBeforeWorkspaceImport,
    );
  }

  static GaussPpFormulaNetSProductionArtifactResolverDecision _decisionFor(
    GaussPpFormulaNetSProductionArtifactResolverInput input,
    List<String> issues,
  ) {
    if (issues.isEmpty) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.productionArtifactResolverGateStaticReady;
    }
    if (!input.q257DownloadOrchestratorUiGuardPresent) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingQ257OrchestratorGate;
    }
    if (!input.q256ArtifactManifestShaGatePresent) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingQ256ArtifactShaGate;
    }
    if (!input.allResolverManifestFieldsPresent) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingResolverManifestFields;
    }
    if (!input.expectedShaCandidateIsEmptyOr64Hex) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedInvalidShaCandidate;
    }
    if (input.productionDownloadEnabled) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedProductionDownloadEnabled;
    }
    if (input.productionArtifactUrlCandidateBound ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noPaddleOcrDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedUnsafeUrlOrRuntimeBinding;
    }
    if (!input.sourceLicenseSizeRuntimeEvidencePresent) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingLicenseSizeOrRuntimeEvidence;
    }
    if (!input.checksumMismatchBlocksReadyState || !input.urlCannotEnableDownloadWithoutExpectedSha || !input.downloadDisabledByDefaultVisible) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingChecksumSafety;
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingMathLiveReviewSafety;
    }
    return GaussPpFormulaNetSProductionArtifactResolverDecision.blockedMissingResolverManifestFields;
  }
}
