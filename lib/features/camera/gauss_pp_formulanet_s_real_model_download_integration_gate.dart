import 'gauss_pp_formulanet_s_real_model_download_integration_gate_policy.dart';

enum GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision {
  blockedMissingQ259DryRunWorker,
  blockedMissingArtifactResolver,
  blockedMissingUrlOrShaEvidence,
  blockedUnsafeProductionDownloadEnablement,
  blockedMissingConsentOrNetworkPolicy,
  blockedMissingStorageOrIntegritySafety,
  blockedMissingRuntimeFeasibilityEvidence,
  blockedMissingMathLiveReviewSafety,
  realModelDownloadIntegrationGateStaticReady,
}

class GaussPpFormulaNetSRealModelDownloadIntegrationGateInput {
  const GaussPpFormulaNetSRealModelDownloadIntegrationGateInput({
    required this.q259DryRunWorkerPresent,
    required this.q258ArtifactResolverGatePresent,
    required this.integrationState,
    required this.allIntegrationStatesRepresented,
    required this.productionDownloadEnabled,
    required this.noProductionModelUrlBound,
    required this.expectedSha256LockedInPackage,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionInferenceAllowed,
    required this.productionArtifactUrlCandidatePresent,
    required this.expectedSha256CandidatePresent,
    required this.expectedSha256CandidateIs64Hex,
    required this.explicitUserConsentRequired,
    required this.wifiOrApprovedNetworkRequired,
    required this.privateAppStorageOnly,
    required this.temporaryFileBeforeFinalArtifact,
    required this.checksumVerificationBeforeReady,
    required this.checksumMismatchBlocksReady,
    required this.atomicMoveOnlyAfterChecksumPass,
    required this.offlineReadyOnlyAfterVerifiedArtifact,
    required this.runtimeFeasibilityEvidenceRequired,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.integrationLabel,
  });

  final bool q259DryRunWorkerPresent;
  final bool q258ArtifactResolverGatePresent;
  final String integrationState;
  final bool allIntegrationStatesRepresented;
  final bool productionDownloadEnabled;
  final bool noProductionModelUrlBound;
  final bool expectedSha256LockedInPackage;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionInferenceAllowed;
  final bool productionArtifactUrlCandidatePresent;
  final bool expectedSha256CandidatePresent;
  final bool expectedSha256CandidateIs64Hex;
  final bool explicitUserConsentRequired;
  final bool wifiOrApprovedNetworkRequired;
  final bool privateAppStorageOnly;
  final bool temporaryFileBeforeFinalArtifact;
  final bool checksumVerificationBeforeReady;
  final bool checksumMismatchBlocksReady;
  final bool atomicMoveOnlyAfterChecksumPass;
  final bool offlineReadyOnlyAfterVerifiedArtifact;
  final bool runtimeFeasibilityEvidenceRequired;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String integrationLabel;

  bool get integrationStateKnown => GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.integrationStates.contains(integrationState);
  bool get hasIntegrationLabel => integrationLabel.trim().isNotEmpty;
  bool get unsafeProductionBindingAbsent =>
      noProductionModelUrlBound &&
      noRealNetworkDownloadWorkerImplemented &&
      noPaddleRuntimeDependencyAdded &&
      noPaddleOcrDependencyAdded &&
      noModelBinaryBundledInBaseApp &&
      noProductionInferenceAllowed;
  bool get artifactEvidenceGatePresent => productionArtifactUrlCandidatePresent && expectedSha256CandidatePresent && expectedSha256CandidateIs64Hex;
  bool get consentAndNetworkGatePresent => explicitUserConsentRequired && wifiOrApprovedNetworkRequired;
  bool get storageAndIntegrityGatePresent =>
      privateAppStorageOnly &&
      temporaryFileBeforeFinalArtifact &&
      checksumVerificationBeforeReady &&
      checksumMismatchBlocksReady &&
      atomicMoveOnlyAfterChecksumPass &&
      offlineReadyOnlyAfterVerifiedArtifact;
}

class GaussPpFormulaNetSRealModelDownloadIntegrationGateResult {
  const GaussPpFormulaNetSRealModelDownloadIntegrationGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.integrationMode,
    required this.integrationStates,
    required this.requiredIntegrationGates,
    required this.requiredRealEvidenceBeforeEnablement,
    required this.forbiddenActions,
    required this.realModelDownloadIntegrationGateImplemented,
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
  final GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision decision;
  final GaussPpFormulaNetSRealModelDownloadIntegrationGateInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final String integrationMode;
  final List<String> integrationStates;
  final List<String> requiredIntegrationGates;
  final List<String> requiredRealEvidenceBeforeEnablement;
  final List<String> forbiddenActions;
  final bool realModelDownloadIntegrationGateImplemented;
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

  bool get realModelDownloadIntegrationGateStaticReady =>
      decision == GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.realModelDownloadIntegrationGateStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.fallbackEngineLabel &&
      integrationMode == GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.integrationMode &&
      integrationStates.length == GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.integrationStates.length &&
      requiredIntegrationGates.length == GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.requiredIntegrationGates.length &&
      requiredRealEvidenceBeforeEnablement.length == GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.requiredRealEvidenceBeforeEnablement.length &&
      forbiddenActions.length == GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.forbiddenActions.length &&
      realModelDownloadIntegrationGateImplemented &&
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

  bool get canEnableProductionDownloadInQ260 => false;
  bool get canStartRealNetworkDownloadInQ260 => false;
  bool get canClaimModelDownloadPass => false;
  bool get canClaimOcrPass => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canMarkReadyWithoutChecksumPass => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q260 PP-FormulaNet-S real model download integration gate.
///
/// This phase defines the final production-download enablement gates, but it
/// still does not bind a URL, lock a real SHA, implement network download,
/// include model bytes, add Paddle runtime, or run OCR inference. It exists to
/// prevent an unsafe jump from Q259 dry-run into production download without
/// URL/SHA/license/storage/network/runtime evidence.
class GaussPpFormulaNetSRealModelDownloadIntegrationGate {
  const GaussPpFormulaNetSRealModelDownloadIntegrationGate._();

  static const phase = GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.fallbackEngineLabel;

  static const productionDownloadDisabledByDefault = true;
  static const implementsRealModelDownloadIntegrationGateInQ260 = true;
  static const implementsRealNetworkDownloadWorkerInQ260 = false;
  static const allowsProductionModelUrlInQ260 = false;
  static const allowsExpectedProductionShaLockInQ260 = false;
  static const allowsProductionInferenceInQ260 = false;

  static GaussPpFormulaNetSRealModelDownloadIntegrationGateResult evaluate(
    GaussPpFormulaNetSRealModelDownloadIntegrationGateInput input,
  ) {
    final issues = <String>[];

    if (!input.q259DryRunWorkerPresent) {
      issues.add('Q260 requires the Q259 real download worker dry-run gate before production-download integration can be considered.');
    }
    if (!input.q258ArtifactResolverGatePresent) {
      issues.add('Q260 requires the Q258 artifact resolver gate.');
    }
    if (!input.integrationStateKnown || !input.allIntegrationStatesRepresented) {
      issues.add('All Q260 integration states must be represented.');
    }
    if (input.productionDownloadEnabled || !input.unsafeProductionBindingAbsent || input.expectedSha256LockedInPackage) {
      issues.add('Q260 must not enable production download, bind URL/SHA, add runtime dependencies, ship model bytes, or allow inference.');
    }
    if (!input.artifactEvidenceGatePresent) {
      issues.add('A future production download requires both URL and exact 64-hex SHA candidates; Q260 records the gate but does not lock them.');
    }
    if (!input.consentAndNetworkGatePresent) {
      issues.add('User consent and Wi-Fi/approved-network policy are mandatory before future production download.');
    }
    if (!input.storageAndIntegrityGatePresent) {
      issues.add('Private storage, temp-file discipline, checksum-before-ready, mismatch blocking, and atomic move safety are mandatory.');
    }
    if (!input.runtimeFeasibilityEvidenceRequired) {
      issues.add('Runtime feasibility evidence remains mandatory before any PP-FormulaNet-S download/inference integration can be enabled.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Camera OCR must remain editable MathLive review first with explicit user approval before workspace import and no direct solve/graph/solution/history.');
    }
    if (!input.hasIntegrationLabel) {
      issues.add('Q260 integration label must be non-empty.');
    }

    final decision = _decisionFor(input, issues);

    return GaussPpFormulaNetSRealModelDownloadIntegrationGateResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: decision,
      input: input,
      issues: issues,
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      integrationMode: GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.integrationMode,
      integrationStates: GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.integrationStates,
      requiredIntegrationGates: GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.requiredIntegrationGates,
      requiredRealEvidenceBeforeEnablement: GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.requiredRealEvidenceBeforeEnablement,
      forbiddenActions: GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.forbiddenActions,
      realModelDownloadIntegrationGateImplemented: GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy.realModelDownloadIntegrationGateImplemented,
      realOcrRuntimeAdded: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      expectedProductionSha256Locked: false,
      realNetworkDownloadWorkerImplemented: false,
      productionDownloadEnabled: false,
      productionInferenceAllowed: false,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
    );
  }

  static GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision _decisionFor(
    GaussPpFormulaNetSRealModelDownloadIntegrationGateInput input,
    List<String> issues,
  ) {
    if (!input.q259DryRunWorkerPresent) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingQ259DryRunWorker;
    }
    if (!input.q258ArtifactResolverGatePresent) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingArtifactResolver;
    }
    if (!input.artifactEvidenceGatePresent) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingUrlOrShaEvidence;
    }
    if (input.productionDownloadEnabled || !input.unsafeProductionBindingAbsent || input.expectedSha256LockedInPackage) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedUnsafeProductionDownloadEnablement;
    }
    if (!input.consentAndNetworkGatePresent) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingConsentOrNetworkPolicy;
    }
    if (!input.storageAndIntegrityGatePresent) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingStorageOrIntegritySafety;
    }
    if (!input.runtimeFeasibilityEvidenceRequired) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingRuntimeFeasibilityEvidence;
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedMissingMathLiveReviewSafety;
    }
    if (issues.isEmpty) {
      return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.realModelDownloadIntegrationGateStaticReady;
    }
    return GaussPpFormulaNetSRealModelDownloadIntegrationGateDecision.blockedUnsafeProductionDownloadEnablement;
  }
}
