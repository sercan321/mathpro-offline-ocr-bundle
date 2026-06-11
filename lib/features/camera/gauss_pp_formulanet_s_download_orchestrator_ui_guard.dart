import 'gauss_pp_formulanet_s_download_orchestrator_ui_guard_policy.dart';

enum GaussPpFormulaNetSDownloadOrchestratorUiDecision {
  blockedMissingQ256ArtifactShaGate,
  blockedUnknownInstallState,
  blockedMissingUiCopy,
  blockedProductionDownloadEnabled,
  blockedUnsafeRuntimeBindingAttempt,
  blockedMissingNetworkOrConsentPolicy,
  blockedMissingChecksumOrReadySafety,
  blockedMissingMathLiveReviewSafety,
  downloadOrchestratorUiGuardStaticReady,
}

class GaussPpFormulaNetSDownloadOrchestratorUiInput {
  const GaussPpFormulaNetSDownloadOrchestratorUiInput({
    required this.q256ArtifactManifestShaGatePresent,
    required this.installState,
    required this.allInstallStatesRepresentedInUi,
    required this.modelNotInstalledCopyPresent,
    required this.downloadConsentCopyPresent,
    required this.wifiOrNetworkPolicyCopyPresent,
    required this.progressAndVerifyingCopyPresent,
    required this.checksumMismatchErrorCopyPresent,
    required this.failedRetryCopyPresent,
    required this.readyButReviewRequiredCopyPresent,
    required this.productionDownloadEnabled,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noModelBinaryBundledInBaseApp,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noProductionInferenceAllowed,
    required this.userConsentRequiredBeforeDownload,
    required this.wifiOrUnmeteredNetworkPolicyVisible,
    required this.checksumMismatchBlocksReadyState,
    required this.failedStateNeverPretendsReady,
    required this.readyStateDoesNotClaimOcrPass,
    required this.modelUnavailableBlocksScanToOcr,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.orchestratorLabel,
  });

  final bool q256ArtifactManifestShaGatePresent;
  final String installState;
  final bool allInstallStatesRepresentedInUi;
  final bool modelNotInstalledCopyPresent;
  final bool downloadConsentCopyPresent;
  final bool wifiOrNetworkPolicyCopyPresent;
  final bool progressAndVerifyingCopyPresent;
  final bool checksumMismatchErrorCopyPresent;
  final bool failedRetryCopyPresent;
  final bool readyButReviewRequiredCopyPresent;
  final bool productionDownloadEnabled;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noModelBinaryBundledInBaseApp;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noProductionInferenceAllowed;
  final bool userConsentRequiredBeforeDownload;
  final bool wifiOrUnmeteredNetworkPolicyVisible;
  final bool checksumMismatchBlocksReadyState;
  final bool failedStateNeverPretendsReady;
  final bool readyStateDoesNotClaimOcrPass;
  final bool modelUnavailableBlocksScanToOcr;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final String orchestratorLabel;

  bool get installStateKnown => GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.guardedInstallStates.contains(installState);
  bool get hasOrchestratorLabel => orchestratorLabel.trim().isNotEmpty;
  bool get allRequiredUiCopyPresent =>
      modelNotInstalledCopyPresent &&
      downloadConsentCopyPresent &&
      wifiOrNetworkPolicyCopyPresent &&
      progressAndVerifyingCopyPresent &&
      checksumMismatchErrorCopyPresent &&
      failedRetryCopyPresent &&
      readyButReviewRequiredCopyPresent;
}

class GaussPpFormulaNetSDownloadOrchestratorUiResult {
  const GaussPpFormulaNetSDownloadOrchestratorUiResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.guardedInstallStates,
    required this.requiredUiCopyBlocks,
    required this.requiredOrchestratorSafetyGates,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.productionInferenceAllowed,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
  });

  final String phase;
  final String sourcePhase;
  final GaussPpFormulaNetSDownloadOrchestratorUiDecision decision;
  final GaussPpFormulaNetSDownloadOrchestratorUiInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final List<String> guardedInstallStates;
  final List<String> requiredUiCopyBlocks;
  final List<String> requiredOrchestratorSafetyGates;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool productionInferenceAllowed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get downloadOrchestratorUiGuardStaticReady =>
      decision == GaussPpFormulaNetSDownloadOrchestratorUiDecision.downloadOrchestratorUiGuardStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.fallbackEngineLabel &&
      guardedInstallStates.length == GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.guardedInstallStates.length &&
      requiredUiCopyBlocks.length == GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.requiredUiCopyBlocks.length &&
      requiredOrchestratorSafetyGates.length == GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.requiredOrchestratorSafetyGates.length &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      realNetworkDownloadWorkerImplemented == false &&
      productionDownloadEnabled == false &&
      productionInferenceAllowed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canClaimModelDownloadPass => false;
  bool get canClaimOcrPass => false;
  bool get canRunPpFormulaNetSInference => false;
  bool get canEnableProductionDownloadInQ257 => false;
  bool get canStartScanToOcrWhenModelUnavailable => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q257 PP-FormulaNet-S download orchestrator UI guard.
///
/// Q257 is not a downloader. It defines the premium user-facing state and copy
/// contract for a later downloader while keeping production download disabled,
/// model URL unbound, model bytes absent, Paddle runtime absent, and inference
/// blocked.
class GaussPpFormulaNetSDownloadOrchestratorUiGuard {
  const GaussPpFormulaNetSDownloadOrchestratorUiGuard._();

  static const phase = GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.fallbackEngineLabel;

  static const productionDownloadDisabledByDefault = true;
  static const implementsRealNetworkDownloadWorkerInQ257 = false;
  static const allowsProductionModelUrlInQ257 = false;
  static const allowsProductionInferenceInQ257 = false;

  static GaussPpFormulaNetSDownloadOrchestratorUiResult evaluate(
    GaussPpFormulaNetSDownloadOrchestratorUiInput input,
  ) {
    final issues = <String>[];

    if (!input.q256ArtifactManifestShaGatePresent) {
      issues.add('Q257 requires the Q256 artifact-manifest/SHA gate before any download UI can be trusted.');
    }
    if (!input.installStateKnown || !input.allInstallStatesRepresentedInUi) {
      issues.add('All guarded install states must be represented in the orchestrator UI.');
    }
    if (!input.allRequiredUiCopyPresent) {
      issues.add('Premium user-facing copy is required for install, consent, network, progress, verifying, mismatch, failed, and ready states.');
    }
    if (input.productionDownloadEnabled) {
      issues.add('Q257 keeps production download disabled by default.');
    }
    if (!input.noProductionModelUrlBound ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      issues.add('Q257 must not bind URL, implement real downloader, ship model bytes, add Paddle runtime, or enable inference.');
    }
    if (!input.userConsentRequiredBeforeDownload || !input.wifiOrUnmeteredNetworkPolicyVisible) {
      issues.add('Download UI must show user consent and Wi-Fi/unmetered network policy before any future real download.');
    }
    if (!input.checksumMismatchBlocksReadyState ||
        !input.failedStateNeverPretendsReady ||
        !input.readyStateDoesNotClaimOcrPass ||
        !input.modelUnavailableBlocksScanToOcr) {
      issues.add('Checksum, failed, ready, and unavailable states must not misrepresent OCR readiness.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Editable MathLive review, explicit approval, and direct solve/Graph/Solution/History blocks remain mandatory.');
    }
    if (!input.hasOrchestratorLabel) {
      issues.add('Q257 requires a static orchestrator label.');
    }

    return GaussPpFormulaNetSDownloadOrchestratorUiResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: _decisionFor(input, issues),
      input: input,
      issues: List<String>.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      guardedInstallStates: List<String>.unmodifiable(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.guardedInstallStates),
      requiredUiCopyBlocks: List<String>.unmodifiable(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.requiredUiCopyBlocks),
      requiredOrchestratorSafetyGates: List<String>.unmodifiable(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.requiredOrchestratorSafetyGates),
      realOcrRuntimeAdded: false,
      paddleRuntimeAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      realNetworkDownloadWorkerImplemented: false,
      productionDownloadEnabled: false,
      productionInferenceAllowed: false,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
    );
  }

  static GaussPpFormulaNetSDownloadOrchestratorUiDecision _decisionFor(
    GaussPpFormulaNetSDownloadOrchestratorUiInput input,
    List<String> issues,
  ) {
    if (!input.q256ArtifactManifestShaGatePresent) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingQ256ArtifactShaGate;
    }
    if (!input.installStateKnown || !input.allInstallStatesRepresentedInUi) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedUnknownInstallState;
    }
    if (!input.allRequiredUiCopyPresent) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingUiCopy;
    }
    if (input.productionDownloadEnabled) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedProductionDownloadEnabled;
    }
    if (!input.noProductionModelUrlBound ||
        !input.noRealNetworkDownloadWorkerImplemented ||
        !input.noModelBinaryBundledInBaseApp ||
        !input.noPaddleRuntimeDependencyAdded ||
        !input.noProductionInferenceAllowed) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedUnsafeRuntimeBindingAttempt;
    }
    if (!input.userConsentRequiredBeforeDownload || !input.wifiOrUnmeteredNetworkPolicyVisible) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingNetworkOrConsentPolicy;
    }
    if (!input.checksumMismatchBlocksReadyState ||
        !input.failedStateNeverPretendsReady ||
        !input.readyStateDoesNotClaimOcrPass ||
        !input.modelUnavailableBlocksScanToOcr) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingChecksumOrReadySafety;
    }
    if (!input.mathLiveReviewAndUserApprovalRequired || !input.noDirectSolveGraphSolutionHistoryFromCamera) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingMathLiveReviewSafety;
    }
    if (issues.isNotEmpty) {
      return GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingUiCopy;
    }
    return GaussPpFormulaNetSDownloadOrchestratorUiDecision.downloadOrchestratorUiGuardStaticReady;
  }
}
