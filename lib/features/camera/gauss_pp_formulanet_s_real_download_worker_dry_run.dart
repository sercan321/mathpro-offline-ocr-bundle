import 'gauss_pp_formulanet_s_real_download_worker_dry_run_policy.dart';

enum GaussPpFormulaNetSRealDownloadWorkerDryRunDecision {
  blockedMissingQ258ResolverGate,
  blockedUnknownDryRunState,
  blockedProductionDownloadEnabled,
  blockedUnsafeNetworkOrRuntimeBinding,
  blockedMissingPrivateStorageSafety,
  blockedMissingPartialCleanupSafety,
  blockedMissingChecksumSimulation,
  blockedMissingAtomicMoveSafety,
  blockedMissingRetryOrOfflineSafety,
  blockedMissingMathLiveReviewSafety,
  realDownloadWorkerDryRunStaticReady,
}

class GaussPpFormulaNetSRealDownloadWorkerDryRunInput {
  const GaussPpFormulaNetSRealDownloadWorkerDryRunInput({
    required this.q258ProductionArtifactResolverGatePresent,
    required this.dryRunState,
    required this.allDryRunStatesRepresented,
    required this.productionDownloadEnabled,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noProductionDownloadWorkerImplemented,
    required this.noModelBinaryBundledInBaseApp,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noProductionInferenceAllowed,
    required this.privateTemporaryAppStorageOnly,
    required this.temporaryFileDryRunPrepared,
    required this.partialDownloadCleanupDryRun,
    required this.checksumMismatchSimulationPresent,
    required this.checksumMismatchBlocksReadyState,
    required this.checksumPassRequiredBeforeAtomicMove,
    required this.atomicMoveSimulationOnly,
    required this.readyStateOnlyAfterVerifiedMove,
    required this.failedRetryStateSimulationPresent,
    required this.modelUnavailableBlocksScanToOcr,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.dryRunLabel,
  });

  final bool q258ProductionArtifactResolverGatePresent;
  final String dryRunState;
  final bool allDryRunStatesRepresented;
  final bool productionDownloadEnabled;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noProductionDownloadWorkerImplemented;
  final bool noModelBinaryBundledInBaseApp;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noProductionInferenceAllowed;
  final bool privateTemporaryAppStorageOnly;
  final bool temporaryFileDryRunPrepared;
  final bool partialDownloadCleanupDryRun;
  final bool checksumMismatchSimulationPresent;
  final bool checksumMismatchBlocksReadyState;
  final bool checksumPassRequiredBeforeAtomicMove;
  final bool atomicMoveSimulationOnly;
  final bool readyStateOnlyAfterVerifiedMove;
  final bool failedRetryStateSimulationPresent;
  final bool modelUnavailableBlocksScanToOcr;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String dryRunLabel;

  bool get dryRunStateKnown => GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.guardedDryRunStates.contains(dryRunState);
  bool get hasDryRunLabel => dryRunLabel.trim().isNotEmpty;
  bool get unsafeNetworkOrRuntimeBindingAbsent =>
      noProductionModelUrlBound &&
      noRealNetworkDownloadWorkerImplemented &&
      noProductionDownloadWorkerImplemented &&
      noModelBinaryBundledInBaseApp &&
      noPaddleRuntimeDependencyAdded &&
      noPaddleOcrDependencyAdded &&
      noProductionInferenceAllowed;
  bool get privateTempSafetyPresent => privateTemporaryAppStorageOnly && temporaryFileDryRunPrepared;
  bool get checksumSafetyPresent => checksumMismatchSimulationPresent && checksumMismatchBlocksReadyState;
  bool get atomicMoveSafetyPresent => checksumPassRequiredBeforeAtomicMove && atomicMoveSimulationOnly;
  bool get retryOfflineSafetyPresent => readyStateOnlyAfterVerifiedMove && failedRetryStateSimulationPresent && modelUnavailableBlocksScanToOcr;
}

class GaussPpFormulaNetSRealDownloadWorkerDryRunResult {
  const GaussPpFormulaNetSRealDownloadWorkerDryRunResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.dryRunMode,
    required this.guardedDryRunStates,
    required this.requiredDryRunSafetyGates,
    required this.requiredDryRunEvidence,
    required this.forbiddenActions,
    required this.dryRunWorkerContractImplemented,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.productionInferenceAllowed,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
  });

  final String phase;
  final String sourcePhase;
  final GaussPpFormulaNetSRealDownloadWorkerDryRunDecision decision;
  final GaussPpFormulaNetSRealDownloadWorkerDryRunInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final String dryRunMode;
  final List<String> guardedDryRunStates;
  final List<String> requiredDryRunSafetyGates;
  final List<String> requiredDryRunEvidence;
  final List<String> forbiddenActions;
  final bool dryRunWorkerContractImplemented;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool productionInferenceAllowed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get realDownloadWorkerDryRunStaticReady =>
      decision == GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.realDownloadWorkerDryRunStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.fallbackEngineLabel &&
      dryRunMode == GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.dryRunMode &&
      guardedDryRunStates.length == GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.guardedDryRunStates.length &&
      requiredDryRunSafetyGates.length == GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.requiredDryRunSafetyGates.length &&
      requiredDryRunEvidence.length == GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.requiredDryRunEvidence.length &&
      forbiddenActions.length == GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.forbiddenActions.length &&
      dryRunWorkerContractImplemented &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      paddleOcrDependencyAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      realNetworkDownloadWorkerImplemented == false &&
      productionDownloadWorkerImplemented == false &&
      productionDownloadEnabled == false &&
      productionInferenceAllowed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canStartProductionNetworkDownload => false;
  bool get canBindProductionModelUrl => false;
  bool get canClaimModelDownloadPass => false;
  bool get canClaimOcrPass => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canMarkReadyAfterChecksumMismatch => false;
  bool get canAtomicMoveBeforeChecksumPass => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q259 PP-FormulaNet-S real download worker dry-run.
///
/// This is a dry-run safety contract, not a production downloader. It models
/// temp-file creation, partial cleanup, checksum mismatch, checksum-pass atomic
/// move, failed/retry, and offline-ready state behavior while keeping real
/// network download, model URL binding, model bytes, Paddle runtime, and OCR
/// inference disabled.
class GaussPpFormulaNetSRealDownloadWorkerDryRun {
  const GaussPpFormulaNetSRealDownloadWorkerDryRun._();

  static const phase = GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.fallbackEngineLabel;

  static const productionDownloadDisabledByDefault = true;
  static const implementsDryRunWorkerContractInQ259 = true;
  static const implementsRealNetworkDownloadWorkerInQ259 = false;
  static const allowsProductionModelUrlInQ259 = false;
  static const allowsProductionInferenceInQ259 = false;

  static GaussPpFormulaNetSRealDownloadWorkerDryRunResult evaluate(
    GaussPpFormulaNetSRealDownloadWorkerDryRunInput input,
  ) {
    final issues = <String>[];

    if (!input.q258ProductionArtifactResolverGatePresent) {
      issues.add('Q259 requires the Q258 production artifact resolver gate before any download dry-run can be trusted.');
    }
    if (!input.dryRunStateKnown || !input.allDryRunStatesRepresented) {
      issues.add('All Q259 dry-run worker states must be represented.');
    }
    if (input.productionDownloadEnabled) {
      issues.add('Q259 keeps production download disabled by default.');
    }
    if (!input.unsafeNetworkOrRuntimeBindingAbsent) {
      issues.add('Q259 must not bind a production URL, implement a real network worker, ship model bytes, add Paddle/PaddleOCR runtime, or enable inference.');
    }
    if (!input.privateTempSafetyPresent) {
      issues.add('Q259 requires private temporary app storage and a dry-run temp-file preparation path.');
    }
    if (!input.partialDownloadCleanupDryRun) {
      issues.add('Q259 requires partial/corrupt dry-run cleanup behavior.');
    }
    if (!input.checksumSafetyPresent) {
      issues.add('Q259 requires checksum mismatch simulation and ready-state blocking.');
    }
    if (!input.atomicMoveSafetyPresent) {
      issues.add('Q259 requires checksum-pass-before-atomic-move simulation only.');
    }
    if (!input.retryOfflineSafetyPresent) {
      issues.add('Q259 requires failed/retry simulation and offline-ready only after verified move.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Editable MathLive review, explicit approval, and direct solve/Graph/Solution/History blocks remain mandatory.');
    }
    if (!input.hasDryRunLabel) {
      issues.add('Q259 requires a static dry-run label.');
    }

    return GaussPpFormulaNetSRealDownloadWorkerDryRunResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: _decisionFor(input, issues),
      input: input,
      issues: List<String>.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      dryRunMode: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.dryRunMode,
      guardedDryRunStates: List<String>.unmodifiable(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.guardedDryRunStates),
      requiredDryRunSafetyGates: List<String>.unmodifiable(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.requiredDryRunSafetyGates),
      requiredDryRunEvidence: List<String>.unmodifiable(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.requiredDryRunEvidence),
      forbiddenActions: List<String>.unmodifiable(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.forbiddenActions),
      dryRunWorkerContractImplemented: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.dryRunWorkerContractImplemented,
      realOcrRuntimeAdded: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.realOcrRuntimeAdded,
      paddleRuntimeAdded: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.paddleRuntimeAdded,
      paddleOcrDependencyAdded: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.paddleOcrDependencyAdded,
      modelBinaryBundledInBaseApp: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.modelBinaryBundledInBaseApp,
      productionModelUrlBound: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.productionModelUrlBound,
      realNetworkDownloadWorkerImplemented: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.realNetworkDownloadWorkerImplemented,
      productionDownloadWorkerImplemented: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.productionDownloadWorkerImplemented,
      productionDownloadEnabled: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.productionDownloadEnabled,
      productionInferenceAllowed: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.productionInferenceAllowed,
      editableMathLiveReviewRequired: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.editableMathLiveReviewRequired,
      userApprovalRequiredBeforeWorkspaceImport: GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.userApprovalRequiredBeforeWorkspaceImport,
    );
  }

  static GaussPpFormulaNetSRealDownloadWorkerDryRunDecision _decisionFor(
    GaussPpFormulaNetSRealDownloadWorkerDryRunInput input,
    List<String> issues,
  ) {
    if (issues.isEmpty) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.realDownloadWorkerDryRunStaticReady;
    }
    if (!input.q258ProductionArtifactResolverGatePresent) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingQ258ResolverGate;
    }
    if (!input.dryRunStateKnown || !input.allDryRunStatesRepresented) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedUnknownDryRunState;
    }
    if (input.productionDownloadEnabled) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedProductionDownloadEnabled;
    }
    if (!input.unsafeNetworkOrRuntimeBindingAbsent) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedUnsafeNetworkOrRuntimeBinding;
    }
    if (!input.privateTempSafetyPresent) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingPrivateStorageSafety;
    }
    if (!input.partialDownloadCleanupDryRun) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingPartialCleanupSafety;
    }
    if (!input.checksumSafetyPresent) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingChecksumSimulation;
    }
    if (!input.atomicMoveSafetyPresent) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingAtomicMoveSafety;
    }
    if (!input.retryOfflineSafetyPresent) {
      return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingRetryOrOfflineSafety;
    }
    return GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingMathLiveReviewSafety;
  }
}
