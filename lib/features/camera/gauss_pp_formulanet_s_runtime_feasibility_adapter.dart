import 'gauss_pp_formulanet_s_runtime_feasibility_adapter_policy.dart';

enum GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision {
  blockedMissingQ260IntegrationGate,
  blockedMissingRuntimePathEvidence,
  blockedMissingModelFormatEvidence,
  blockedMissingAndroidCompatibilityEvidence,
  blockedMissingLatencyOrMemoryBudget,
  blockedUnsafeRuntimeOrInferenceBinding,
  blockedMissingMathLiveReviewSafety,
  runtimeFeasibilityAdapterStaticReady,
}

class GaussPpFormulaNetSRuntimeFeasibilityAdapterInput {
  const GaussPpFormulaNetSRuntimeFeasibilityAdapterInput({
    required this.q260RealModelDownloadIntegrationGatePresent,
    required this.feasibilityState,
    required this.allFeasibilityStatesRepresented,
    required this.officialOnDeviceDeploymentEvidenceRequired,
    required this.ppFormulaNetSModelFormatEvidenceRequired,
    required this.androidRuntimePathEvidenceRequired,
    required this.abiCompatibilityEvidenceRequired,
    required this.nativeBridgePlanEvidenceRequired,
    required this.modelArtifactPrivateStorageAccessRequired,
    required this.latencyBudgetEvidenceRequired,
    required this.peakMemoryBudgetEvidenceRequired,
    required this.offlineAfterInstallEvidenceRequired,
    required this.thermalAndBatteryRiskReviewRequired,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noNativeBridgeAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.noProductionInferenceAllowed,
    required this.runtimeFeasibilityPassClaimed,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.feasibilityLabel,
  });

  final bool q260RealModelDownloadIntegrationGatePresent;
  final String feasibilityState;
  final bool allFeasibilityStatesRepresented;
  final bool officialOnDeviceDeploymentEvidenceRequired;
  final bool ppFormulaNetSModelFormatEvidenceRequired;
  final bool androidRuntimePathEvidenceRequired;
  final bool abiCompatibilityEvidenceRequired;
  final bool nativeBridgePlanEvidenceRequired;
  final bool modelArtifactPrivateStorageAccessRequired;
  final bool latencyBudgetEvidenceRequired;
  final bool peakMemoryBudgetEvidenceRequired;
  final bool offlineAfterInstallEvidenceRequired;
  final bool thermalAndBatteryRiskReviewRequired;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noNativeBridgeAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool noProductionInferenceAllowed;
  final bool runtimeFeasibilityPassClaimed;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String feasibilityLabel;

  bool get feasibilityStateKnown => GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.feasibilityStates.contains(feasibilityState);
  bool get hasFeasibilityLabel => feasibilityLabel.trim().isNotEmpty;
  bool get runtimePathGatePresent => officialOnDeviceDeploymentEvidenceRequired && androidRuntimePathEvidenceRequired;
  bool get modelFormatGatePresent => ppFormulaNetSModelFormatEvidenceRequired && modelArtifactPrivateStorageAccessRequired;
  bool get androidCompatibilityGatePresent => abiCompatibilityEvidenceRequired && nativeBridgePlanEvidenceRequired;
  bool get performanceGatePresent => latencyBudgetEvidenceRequired && peakMemoryBudgetEvidenceRequired && thermalAndBatteryRiskReviewRequired;
  bool get unsafeRuntimeBindingAbsent =>
      noPaddleRuntimeDependencyAdded &&
      noPaddleOcrDependencyAdded &&
      noNativeBridgeAdded &&
      noModelBinaryBundledInBaseApp &&
      noProductionModelUrlBound &&
      noRealNetworkDownloadWorkerImplemented &&
      productionDownloadEnabled == false &&
      noProductionInferenceAllowed &&
      runtimeFeasibilityPassClaimed == false;
}

class GaussPpFormulaNetSRuntimeFeasibilityAdapterResult {
  const GaussPpFormulaNetSRuntimeFeasibilityAdapterResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.feasibilityMode,
    required this.runtimePathCandidates,
    required this.feasibilityStates,
    required this.requiredFeasibilityGates,
    required this.blockedUntilRealEvidence,
    required this.forbiddenActions,
    required this.runtimeFeasibilityAdapterImplemented,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.nativeBridgeAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.productionInferenceAllowed,
    required this.runtimeFeasibilityPassClaimed,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
  });

  final String phase;
  final String sourcePhase;
  final GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision decision;
  final GaussPpFormulaNetSRuntimeFeasibilityAdapterInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final String feasibilityMode;
  final List<String> runtimePathCandidates;
  final List<String> feasibilityStates;
  final List<String> requiredFeasibilityGates;
  final List<String> blockedUntilRealEvidence;
  final List<String> forbiddenActions;
  final bool runtimeFeasibilityAdapterImplemented;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool nativeBridgeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool productionInferenceAllowed;
  final bool runtimeFeasibilityPassClaimed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get runtimeFeasibilityAdapterStaticReady =>
      decision == GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.runtimeFeasibilityAdapterStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.fallbackEngineLabel &&
      feasibilityMode == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.feasibilityMode &&
      runtimePathCandidates.length == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.runtimePathCandidates.length &&
      feasibilityStates.length == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.feasibilityStates.length &&
      requiredFeasibilityGates.length == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.requiredFeasibilityGates.length &&
      blockedUntilRealEvidence.length == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.blockedUntilRealEvidence.length &&
      forbiddenActions.length == GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.forbiddenActions.length &&
      runtimeFeasibilityAdapterImplemented &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      paddleOcrDependencyAdded == false &&
      nativeBridgeAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      realNetworkDownloadWorkerImplemented == false &&
      productionDownloadEnabled == false &&
      productionInferenceAllowed == false &&
      runtimeFeasibilityPassClaimed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canAddPaddleRuntimeInQ261 => false;
  bool get canAddNativeBridgeInQ261 => false;
  bool get canClaimRuntimeFeasibilityPass => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canClaimOcrPass => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q261 PP-FormulaNet-S runtime feasibility adapter.
///
/// This phase bridges the Q260 download integration gate to future real runtime
/// work by recording the Android runtime evidence that must exist before any
/// Paddle/mobile/native inference path is enabled. It remains review-only and
/// evidence-only: no Paddle runtime, no native bridge, no model bytes, no
/// production download, and no OCR inference are added here.
class GaussPpFormulaNetSRuntimeFeasibilityAdapter {
  const GaussPpFormulaNetSRuntimeFeasibilityAdapter._();

  static const phase = GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.fallbackEngineLabel;

  static const implementsRuntimeFeasibilityAdapterInQ261 = true;
  static const addsPaddleRuntimeInQ261 = false;
  static const addsPaddleOcrDependencyInQ261 = false;
  static const addsNativeBridgeInQ261 = false;
  static const allowsRuntimeFeasibilityPassClaimInQ261 = false;
  static const allowsProductionInferenceInQ261 = false;

  static GaussPpFormulaNetSRuntimeFeasibilityAdapterResult evaluate(
    GaussPpFormulaNetSRuntimeFeasibilityAdapterInput input,
  ) {
    final issues = <String>[];

    if (!input.q260RealModelDownloadIntegrationGatePresent) {
      issues.add('Q261 requires Q260 real model download integration gate before runtime feasibility evaluation.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingQ260IntegrationGate);
    }
    if (!input.feasibilityStateKnown || !input.allFeasibilityStatesRepresented || !input.hasFeasibilityLabel) {
      issues.add('Q261 requires a known runtime feasibility state and non-empty label.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingRuntimePathEvidence);
    }
    if (!input.runtimePathGatePresent) {
      issues.add('Q261 requires official on-device/runtime-path evidence before runtime work.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingRuntimePathEvidence);
    }
    if (!input.modelFormatGatePresent) {
      issues.add('Q261 requires PP-FormulaNet-S model-format/private-storage access evidence.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingModelFormatEvidence);
    }
    if (!input.androidCompatibilityGatePresent) {
      issues.add('Q261 requires Android ABI/native bridge compatibility evidence.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingAndroidCompatibilityEvidence);
    }
    if (!input.performanceGatePresent || !input.offlineAfterInstallEvidenceRequired) {
      issues.add('Q261 requires latency, peak-memory, thermal/battery, and offline-readiness evidence.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingLatencyOrMemoryBudget);
    }
    if (!input.unsafeRuntimeBindingAbsent) {
      issues.add('Q261 must not add Paddle/native/runtime/model/download/inference binding or claim feasibility PASS.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedUnsafeRuntimeOrInferenceBinding);
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Q261 requires editable MathLive review, user approval, and direct solve/graph/solution/history block.');
      return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingMathLiveReviewSafety);
    }

    return _result(input, issues, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.runtimeFeasibilityAdapterStaticReady);
  }

  static GaussPpFormulaNetSRuntimeFeasibilityAdapterResult _result(
    GaussPpFormulaNetSRuntimeFeasibilityAdapterInput input,
    List<String> issues,
    GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision decision,
  ) {
    return GaussPpFormulaNetSRuntimeFeasibilityAdapterResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: decision,
      input: input,
      issues: List.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      feasibilityMode: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.feasibilityMode,
      runtimePathCandidates: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.runtimePathCandidates,
      feasibilityStates: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.feasibilityStates,
      requiredFeasibilityGates: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.requiredFeasibilityGates,
      blockedUntilRealEvidence: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.blockedUntilRealEvidence,
      forbiddenActions: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.forbiddenActions,
      runtimeFeasibilityAdapterImplemented: implementsRuntimeFeasibilityAdapterInQ261,
      realOcrRuntimeAdded: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.realOcrRuntimeAdded,
      paddleRuntimeAdded: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.paddleRuntimeAdded,
      paddleOcrDependencyAdded: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.paddleOcrDependencyAdded,
      nativeBridgeAdded: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.nativeBridgeAdded,
      modelBinaryBundledInBaseApp: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.modelBinaryBundledInBaseApp,
      productionModelUrlBound: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.productionModelUrlBound,
      realNetworkDownloadWorkerImplemented: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.realNetworkDownloadWorkerImplemented,
      productionDownloadEnabled: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.productionDownloadEnabled,
      productionInferenceAllowed: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.productionInferenceAllowed,
      runtimeFeasibilityPassClaimed: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.runtimeFeasibilityPassClaimed,
      editableMathLiveReviewRequired: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.editableMathLiveReviewRequired,
      userApprovalRequiredBeforeWorkspaceImport: GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.userApprovalRequiredBeforeWorkspaceImport,
    );
  }
}
