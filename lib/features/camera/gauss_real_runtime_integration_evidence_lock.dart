import 'gauss_real_runtime_integration_evidence_lock_policy.dart';

enum GaussRealRuntimeIntegrationEvidenceLockDecision {
  blockedMissingQ277R3Baseline,
  blockedMissingUserSideCleanFlutterEvidence,
  blockedMissingOfficialSourceEvidence,
  blockedMissingArtifactUrlOrSha,
  blockedLicenseOrModelSizeEvidence,
  blockedRuntimePathOrAbiEvidence,
  blockedRuntimeBudgetOrPrivateStorageEvidence,
  blockedMissingReviewApprovalBoundary,
  blockedUnsafeRuntimeMutationOrPassClaim,
  readyForQ279DependencyTrialOnly,
}

class GaussRealRuntimeIntegrationEvidenceLockInput {
  const GaussRealRuntimeIntegrationEvidenceLockInput({
    required this.q277r3TapLatencyCadenceBaselinePresent,
    required this.userFlutterAnalyzeClean,
    required this.userFlutterTestPassed,
    required this.realDeviceUiRegressionAccepted,
    required this.officialModelRepositoryUrlDocumented,
    required this.productionArtifactUrlDocumented,
    required this.expectedProductionArtifactSha256,
    required this.licenseCompatibilityDocumented,
    required this.modelSizeMb,
    required this.selectedRuntimePathDocumented,
    required this.abiMatrixDocumented,
    required this.androidToolchainCompatibilityDocumented,
    required this.runtimeLatencyBudgetMs,
    required this.runtimePeakMemoryBudgetMb,
    required this.privateAppStoragePlanDocumented,
    required this.checksumBeforeReadyRequired,
    required this.atomicMoveAfterChecksumRequired,
    required this.offlineReadyOnlyAfterVerifiedPrivateArtifactRequired,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noNativeBridgeImplementationAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noProductionDownloadEnabled,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noImageToLatexInferenceExecuted,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.releasePassClaimed,
    required this.evidenceLabel,
  });

  final bool q277r3TapLatencyCadenceBaselinePresent;
  final bool userFlutterAnalyzeClean;
  final bool userFlutterTestPassed;
  final bool realDeviceUiRegressionAccepted;
  final bool officialModelRepositoryUrlDocumented;
  final bool productionArtifactUrlDocumented;
  final String expectedProductionArtifactSha256;
  final bool licenseCompatibilityDocumented;
  final int modelSizeMb;
  final bool selectedRuntimePathDocumented;
  final bool abiMatrixDocumented;
  final bool androidToolchainCompatibilityDocumented;
  final int runtimeLatencyBudgetMs;
  final int runtimePeakMemoryBudgetMb;
  final bool privateAppStoragePlanDocumented;
  final bool checksumBeforeReadyRequired;
  final bool atomicMoveAfterChecksumRequired;
  final bool offlineReadyOnlyAfterVerifiedPrivateArtifactRequired;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noNativeBridgeImplementationAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noProductionDownloadEnabled;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noImageToLatexInferenceExecuted;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool releasePassClaimed;
  final String evidenceLabel;
}

class GaussRealRuntimeIntegrationEvidenceLockResult {
  const GaussRealRuntimeIntegrationEvidenceLockResult._({
    required this.decision,
    required this.evidenceStaticReady,
    required this.readyForQ279DependencyTrialOnly,
    required this.rejectionReasons,
    required this.canAddRuntimeDependencyInQ278,
    required this.canBindNativeBridgeInQ278,
    required this.canRunImageToLatexInferenceInQ278,
    required this.canClaimRuntimeIntegrationPassInQ278,
    required this.canClaimOcrPassInQ278,
    required this.canImportCameraOutputWithoutReview,
    required this.evidenceLabel,
  });

  final GaussRealRuntimeIntegrationEvidenceLockDecision decision;
  final bool evidenceStaticReady;
  final bool readyForQ279DependencyTrialOnly;
  final List<String> rejectionReasons;
  final bool canAddRuntimeDependencyInQ278;
  final bool canBindNativeBridgeInQ278;
  final bool canRunImageToLatexInferenceInQ278;
  final bool canClaimRuntimeIntegrationPassInQ278;
  final bool canClaimOcrPassInQ278;
  final bool canImportCameraOutputWithoutReview;
  final String evidenceLabel;

  String get phase => GaussRealRuntimeIntegrationEvidenceLockPolicy.phase;
  String get sourcePhase => GaussRealRuntimeIntegrationEvidenceLockPolicy.sourcePhase;
  String get selectedEngineLabel => GaussRealRuntimeIntegrationEvidenceLockPolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussRealRuntimeIntegrationEvidenceLockPolicy.fallbackEngineLabel;
  String get evidenceLockMode => GaussRealRuntimeIntegrationEvidenceLockPolicy.evidenceLockMode;
  List<String> get requiredEvidenceLocks => GaussRealRuntimeIntegrationEvidenceLockPolicy.requiredEvidenceLocks;
  List<String> get blockedUntilRealEvidence => GaussRealRuntimeIntegrationEvidenceLockPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussRealRuntimeIntegrationEvidenceLockPolicy.forbiddenActions;
  bool get realOcrRuntimeAdded => GaussRealRuntimeIntegrationEvidenceLockPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussRealRuntimeIntegrationEvidenceLockPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussRealRuntimeIntegrationEvidenceLockPolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeImplementationAdded => GaussRealRuntimeIntegrationEvidenceLockPolicy.nativeBridgeImplementationAdded;
  bool get jniBindingAdded => GaussRealRuntimeIntegrationEvidenceLockPolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussRealRuntimeIntegrationEvidenceLockPolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussRealRuntimeIntegrationEvidenceLockPolicy.modelBinaryBundledInBaseApp;
  bool get productionModelUrlBound => GaussRealRuntimeIntegrationEvidenceLockPolicy.productionModelUrlBound;
  bool get productionDownloadEnabled => GaussRealRuntimeIntegrationEvidenceLockPolicy.productionDownloadEnabled;
  bool get realNetworkDownloadWorkerImplemented => GaussRealRuntimeIntegrationEvidenceLockPolicy.realNetworkDownloadWorkerImplemented;
  bool get realImageToLatexInferenceExecuted => GaussRealRuntimeIntegrationEvidenceLockPolicy.realImageToLatexInferenceExecuted;
  bool get runtimeIntegrationPassClaimed => GaussRealRuntimeIntegrationEvidenceLockPolicy.runtimeIntegrationPassClaimed;
  bool get ocrPassClaimed => GaussRealRuntimeIntegrationEvidenceLockPolicy.ocrPassClaimed;
  bool get releasePassClaimed => GaussRealRuntimeIntegrationEvidenceLockPolicy.releasePassClaimed;
}

class GaussRealRuntimeIntegrationEvidenceLock {
  const GaussRealRuntimeIntegrationEvidenceLock._();

  static final RegExp _sha256Pattern = RegExp(r'^[a-fA-F0-9]{64}$');

  static GaussRealRuntimeIntegrationEvidenceLockResult evaluate(GaussRealRuntimeIntegrationEvidenceLockInput input) {
    GaussRealRuntimeIntegrationEvidenceLockResult reject(
      GaussRealRuntimeIntegrationEvidenceLockDecision decision,
      String reason,
    ) {
      return GaussRealRuntimeIntegrationEvidenceLockResult._(
        decision: decision,
        evidenceStaticReady: false,
        readyForQ279DependencyTrialOnly: false,
        rejectionReasons: <String>[reason],
        canAddRuntimeDependencyInQ278: false,
        canBindNativeBridgeInQ278: false,
        canRunImageToLatexInferenceInQ278: false,
        canClaimRuntimeIntegrationPassInQ278: false,
        canClaimOcrPassInQ278: false,
        canImportCameraOutputWithoutReview: false,
        evidenceLabel: input.evidenceLabel,
      );
    }

    if (!input.q277r3TapLatencyCadenceBaselinePresent) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingQ277R3Baseline, 'missingQ277R3TapLatencyCadenceBaseline');
    }
    if (!input.userFlutterAnalyzeClean || !input.userFlutterTestPassed || !input.realDeviceUiRegressionAccepted) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingUserSideCleanFlutterEvidence, 'missingUserSideAnalyzeTestOrDeviceAcceptanceEvidence');
    }
    if (!input.officialModelRepositoryUrlDocumented) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingOfficialSourceEvidence, 'missingOfficialModelRepositoryEvidence');
    }
    if (!input.productionArtifactUrlDocumented || !_sha256Pattern.hasMatch(input.expectedProductionArtifactSha256)) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingArtifactUrlOrSha, 'missingProductionArtifactUrlOrValid64HexSha256');
    }
    if (!input.licenseCompatibilityDocumented || input.modelSizeMb <= 0 || input.modelSizeMb > GaussRealRuntimeIntegrationEvidenceLockPolicy.maximumAllowedModelSizeMb) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedLicenseOrModelSizeEvidence, 'missingLicenseEvidenceOrModelSizeOutsideBudget');
    }
    if (!input.selectedRuntimePathDocumented || !input.abiMatrixDocumented || !input.androidToolchainCompatibilityDocumented) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedRuntimePathOrAbiEvidence, 'missingRuntimePathAbiOrToolchainEvidence');
    }
    if (input.runtimeLatencyBudgetMs <= 0 || input.runtimeLatencyBudgetMs > GaussRealRuntimeIntegrationEvidenceLockPolicy.maximumRuntimeLatencyBudgetMs || input.runtimePeakMemoryBudgetMb <= 0 || input.runtimePeakMemoryBudgetMb > GaussRealRuntimeIntegrationEvidenceLockPolicy.maximumRuntimePeakMemoryBudgetMb || !input.privateAppStoragePlanDocumented || !input.checksumBeforeReadyRequired || !input.atomicMoveAfterChecksumRequired || !input.offlineReadyOnlyAfterVerifiedPrivateArtifactRequired) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedRuntimeBudgetOrPrivateStorageEvidence, 'missingRuntimeBudgetOrPrivateStorageSafetyGate');
    }
    if (!input.editableMathLiveReviewRequired || !input.explicitUserApprovalRequiredBeforeWorkspaceImport || !input.directSolveGraphSolutionHistoryBlocked) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedMissingReviewApprovalBoundary, 'missingMathLiveReviewApprovalOrDirectActionBlock');
    }
    if (!input.noPaddleRuntimeDependencyAdded || !input.noPaddleOcrDependencyAdded || !input.noNativeBridgeImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noProductionDownloadEnabled || !input.noRealNetworkDownloadWorkerImplemented || !input.noImageToLatexInferenceExecuted || input.runtimeIntegrationPassClaimed || input.ocrPassClaimed || input.releasePassClaimed) {
      return reject(GaussRealRuntimeIntegrationEvidenceLockDecision.blockedUnsafeRuntimeMutationOrPassClaim, 'unsafeRuntimeMutationOrPassClaimInQ278');
    }

    return GaussRealRuntimeIntegrationEvidenceLockResult._(
      decision: GaussRealRuntimeIntegrationEvidenceLockDecision.readyForQ279DependencyTrialOnly,
      evidenceStaticReady: true,
      readyForQ279DependencyTrialOnly: true,
      rejectionReasons: const <String>[],
      canAddRuntimeDependencyInQ278: false,
      canBindNativeBridgeInQ278: false,
      canRunImageToLatexInferenceInQ278: false,
      canClaimRuntimeIntegrationPassInQ278: false,
      canClaimOcrPassInQ278: false,
      canImportCameraOutputWithoutReview: false,
      evidenceLabel: input.evidenceLabel,
    );
  }
}
