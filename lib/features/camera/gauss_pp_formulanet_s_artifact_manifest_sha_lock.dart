import 'gauss_pp_formulanet_s_artifact_manifest_sha_lock_policy.dart';

enum GaussPpFormulaNetSArtifactManifestShaLockDecision {
  blockedMissingArtifactManifest,
  blockedMissingSourceOrLicenseLabel,
  blockedMissingSizeOrRuntimeBudget,
  blockedMissingExpectedSha256Lock,
  blockedInvalidSha256Format,
  blockedProductionDownloadEnabled,
  blockedUnsafeRuntimeBindingAttempt,
  blockedMissingMathLiveReviewSafety,
  artifactManifestShaLockStaticReady,
}

class GaussPpFormulaNetSArtifactManifestShaLockInput {
  const GaussPpFormulaNetSArtifactManifestShaLockInput({
    required this.officialArtifactManifestRecorded,
    required this.artifactSourceLabel,
    required this.artifactVersionLabel,
    required this.licenseLabel,
    required this.modelStorageSizeBytes,
    required this.expectedSha256,
    required this.expectedSha256LockedFromOfficialArtifact,
    required this.artifactSizeBudgetRecorded,
    required this.androidRuntimeFeasibilityBudgetRecorded,
    required this.latencyAndMemoryBudgetRecorded,
    required this.productionDownloadEnabled,
    required this.noProductionModelUrlBound,
    required this.noModelBinaryBundledInBaseApp,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noProductionInferenceAllowed,
    required this.checksumMismatchBlocksReadyState,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.lockLabel,
  });

  final bool officialArtifactManifestRecorded;
  final String artifactSourceLabel;
  final String artifactVersionLabel;
  final String licenseLabel;
  final int modelStorageSizeBytes;
  final String expectedSha256;
  final bool expectedSha256LockedFromOfficialArtifact;
  final bool artifactSizeBudgetRecorded;
  final bool androidRuntimeFeasibilityBudgetRecorded;
  final bool latencyAndMemoryBudgetRecorded;
  final bool productionDownloadEnabled;
  final bool noProductionModelUrlBound;
  final bool noModelBinaryBundledInBaseApp;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noProductionInferenceAllowed;
  final bool checksumMismatchBlocksReadyState;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String lockLabel;

  bool get hasSourceLabel => artifactSourceLabel.trim().isNotEmpty;
  bool get hasVersionLabel => artifactVersionLabel.trim().isNotEmpty;
  bool get hasLicenseLabel => licenseLabel.trim().isNotEmpty;
  bool get hasPositiveModelSize => modelStorageSizeBytes > 0;
  bool get hasLockLabel => lockLabel.trim().isNotEmpty;
  bool get expectedSha256LooksReal => RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(expectedSha256);
}

class GaussPpFormulaNetSArtifactManifestShaLockResult {
  const GaussPpFormulaNetSArtifactManifestShaLockResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.requiredArtifactManifestFields,
    required this.blockedUntilRealEvidence,
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
  final GaussPpFormulaNetSArtifactManifestShaLockDecision decision;
  final GaussPpFormulaNetSArtifactManifestShaLockInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final List<String> requiredArtifactManifestFields;
  final List<String> blockedUntilRealEvidence;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionInferenceAllowed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get artifactManifestShaLockStaticReady =>
      decision == GaussPpFormulaNetSArtifactManifestShaLockDecision.artifactManifestShaLockStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSArtifactManifestShaLockPolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSArtifactManifestShaLockPolicy.fallbackEngineLabel &&
      requiredArtifactManifestFields.length == GaussPpFormulaNetSArtifactManifestShaLockPolicy.requiredArtifactManifestFields.length &&
      blockedUntilRealEvidence.length == GaussPpFormulaNetSArtifactManifestShaLockPolicy.blockedUntilRealEvidence.length &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      realNetworkDownloadWorkerImplemented == false &&
      productionInferenceAllowed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canClaimArtifactShaLockedForProduction => false;
  bool get canClaimModelDownloadPass => false;
  bool get canClaimOcrPass => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canEnableProductionDownloadWithoutOfficialSha => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q256 PP-FormulaNet-S artifact manifest and SHA lock gate.
///
/// Q256 creates the artifact-manifest and checksum contract for a future real
/// downloader. It may evaluate a future official artifact manifest, but this
/// phase itself keeps production downloads disabled, binds no model URL, ships
/// no model bytes, adds no Paddle runtime, and performs no image-to-LaTeX
/// inference.
class GaussPpFormulaNetSArtifactManifestShaLockGate {
  const GaussPpFormulaNetSArtifactManifestShaLockGate._();

  static const phase = GaussPpFormulaNetSArtifactManifestShaLockPolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSArtifactManifestShaLockPolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSArtifactManifestShaLockPolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSArtifactManifestShaLockPolicy.fallbackEngineLabel;

  static const requiresExpectedSha256LockBeforeDownload = true;
  static const requiresSixtyFourHexExpectedSha256 = true;
  static const disablesProductionDownloadInQ256 = true;
  static const allowsProductionModelUrlInQ256 = false;
  static const implementsRealNetworkDownloadWorkerInQ256 = false;
  static const allowsProductionInferenceInQ256 = false;

  static GaussPpFormulaNetSArtifactManifestShaLockResult evaluate(
    GaussPpFormulaNetSArtifactManifestShaLockInput input,
  ) {
    final issues = <String>[];

    if (!input.officialArtifactManifestRecorded) {
      issues.add('Official PP-FormulaNet-S artifact manifest evidence must be recorded before any production download plan.');
    }
    if (!input.hasSourceLabel || !input.hasVersionLabel || !input.hasLicenseLabel) {
      issues.add('Artifact source, version, and license labels are required.');
    }
    if (!input.hasPositiveModelSize || !input.artifactSizeBudgetRecorded || !input.androidRuntimeFeasibilityBudgetRecorded || !input.latencyAndMemoryBudgetRecorded) {
      issues.add('Artifact size, Android runtime feasibility, latency, and memory budgets must be recorded.');
    }
    if (!input.expectedSha256LockedFromOfficialArtifact) {
      issues.add('Expected SHA256 must be locked from the official artifact before download can be enabled.');
    }
    if (!input.expectedSha256LooksReal) {
      issues.add('Expected SHA256 must be exactly 64 hexadecimal characters.');
    }
    if (input.productionDownloadEnabled) {
      issues.add('Q256 keeps production download disabled until real artifact and runtime evidence are reviewed.');
    }
    if (!input.noProductionModelUrlBound ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      issues.add('Q256 must not bind production model URL, ship model bytes, add Paddle runtime, create real downloader, or allow inference.');
    }
    if (!input.checksumMismatchBlocksReadyState) {
      issues.add('Checksum mismatch must block ready state and trigger cleanup in the future downloader.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Editable MathLive review, user approval, and direct solve/Graph/Solution/History blocks must remain mandatory.');
    }
    if (!input.hasLockLabel) {
      issues.add('Q256 requires a static lock label.');
    }

    return GaussPpFormulaNetSArtifactManifestShaLockResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: _decisionFor(input, issues),
      input: input,
      issues: List<String>.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      requiredArtifactManifestFields: List<String>.unmodifiable(GaussPpFormulaNetSArtifactManifestShaLockPolicy.requiredArtifactManifestFields),
      blockedUntilRealEvidence: List<String>.unmodifiable(GaussPpFormulaNetSArtifactManifestShaLockPolicy.blockedUntilRealEvidence),
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

  static GaussPpFormulaNetSArtifactManifestShaLockDecision _decisionFor(
    GaussPpFormulaNetSArtifactManifestShaLockInput input,
    List<String> issues,
  ) {
    if (!input.officialArtifactManifestRecorded) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingArtifactManifest;
    }
    if (!input.hasSourceLabel || !input.hasVersionLabel || !input.hasLicenseLabel) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingSourceOrLicenseLabel;
    }
    if (!input.hasPositiveModelSize || !input.artifactSizeBudgetRecorded || !input.androidRuntimeFeasibilityBudgetRecorded || !input.latencyAndMemoryBudgetRecorded) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingSizeOrRuntimeBudget;
    }
    if (!input.expectedSha256LockedFromOfficialArtifact) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingExpectedSha256Lock;
    }
    if (!input.expectedSha256LooksReal) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedInvalidSha256Format;
    }
    if (input.productionDownloadEnabled) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedProductionDownloadEnabled;
    }
    if (!input.noProductionModelUrlBound ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedUnsafeRuntimeBindingAttempt;
    }
    if (!input.checksumMismatchBlocksReadyState || !input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingMathLiveReviewSafety;
    }
    if (issues.isNotEmpty) {
      return GaussPpFormulaNetSArtifactManifestShaLockDecision.blockedMissingArtifactManifest;
    }
    return GaussPpFormulaNetSArtifactManifestShaLockDecision.artifactManifestShaLockStaticReady;
  }
}
