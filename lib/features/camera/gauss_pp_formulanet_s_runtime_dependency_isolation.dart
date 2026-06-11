import 'gauss_pp_formulanet_s_runtime_dependency_isolation_policy.dart';

enum GaussPpFormulaNetSRuntimeDependencyIsolationDecision {
  blockedMissingQ268IsolationGate,
  blockedRuntimeDependencyCandidateUndecided,
  blockedMissingGradleImpactReview,
  blockedMissingAbiSplitPlan,
  blockedMissingTransitiveDependencyAudit,
  blockedMissingApkAabSizeBudget,
  blockedMissingBuildRollbackPlan,
  blockedMissingFeatureFlagIsolation,
  blockedMissingFallbackPlan,
  blockedMissingMathLiveReviewRequirement,
  blockedDirectSolveOrImportRisk,
  blockedUnsafeDependencyAddedInQ269,
  readyForFutureRuntimeDependencyImplementationOnly,
}

class GaussPpFormulaNetSRuntimeDependencyIsolationInput {
  const GaussPpFormulaNetSRuntimeDependencyIsolationInput({
    required this.q268IsolatedRuntimeImplementationGatePresent,
    required this.q268StillNoRuntimeNoInference,
    required this.runtimeDependencyCandidateDocumented,
    required this.dependencyIsolationPlanDocumented,
    required this.gradleImpactReviewDocumented,
    required this.androidAbiSplitPlanDocumented,
    required this.transitiveDependencyAuditDocumented,
    required this.apkAabSizeBudgetMb,
    required this.dependencyLicenseReviewDocumented,
    required this.buildRollbackPlanDocumented,
    required this.featureFlagDefaultOffDocumented,
    required this.noDefaultRuntimeEnablement,
    required this.runtimeClasspathIsolationDocumented,
    required this.fallbackPlanDocumented,
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
    required this.dependencyIsolationPassClaimed,
    required this.ocrPassClaimed,
    required this.dependencyIsolationLabel,
  });

  final bool q268IsolatedRuntimeImplementationGatePresent;
  final bool q268StillNoRuntimeNoInference;
  final bool runtimeDependencyCandidateDocumented;
  final bool dependencyIsolationPlanDocumented;
  final bool gradleImpactReviewDocumented;
  final bool androidAbiSplitPlanDocumented;
  final bool transitiveDependencyAuditDocumented;
  final int apkAabSizeBudgetMb;
  final bool dependencyLicenseReviewDocumented;
  final bool buildRollbackPlanDocumented;
  final bool featureFlagDefaultOffDocumented;
  final bool noDefaultRuntimeEnablement;
  final bool runtimeClasspathIsolationDocumented;
  final bool fallbackPlanDocumented;
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
  final bool dependencyIsolationPassClaimed;
  final bool ocrPassClaimed;
  final String dependencyIsolationLabel;
}

class GaussPpFormulaNetSRuntimeDependencyIsolationResult {
  const GaussPpFormulaNetSRuntimeDependencyIsolationResult._({
    required this.decision,
    required this.runtimeDependencyIsolationStaticReady,
    required this.readyForFutureRuntimeDependencyImplementationOnly,
    required this.rejectionReasons,
    required this.canAddRuntimeDependencyInQ269,
    required this.canClaimDependencyIsolationPassInQ269,
    required this.canClaimOcrPassInQ269,
    required this.canBindNativeBridgeInQ269,
    required this.canEnableRuntimeDependencyByDefaultInQ269,
    required this.canImportCameraOutputWithoutUserApproval,
    required this.dependencyIsolationLabel,
  });

  final GaussPpFormulaNetSRuntimeDependencyIsolationDecision decision;
  final bool runtimeDependencyIsolationStaticReady;
  final bool readyForFutureRuntimeDependencyImplementationOnly;
  final List<String> rejectionReasons;
  final bool canAddRuntimeDependencyInQ269;
  final bool canClaimDependencyIsolationPassInQ269;
  final bool canClaimOcrPassInQ269;
  final bool canBindNativeBridgeInQ269;
  final bool canEnableRuntimeDependencyByDefaultInQ269;
  final bool canImportCameraOutputWithoutUserApproval;
  final String dependencyIsolationLabel;

  String get phase => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.phase;
  String get sourcePhase => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.sourcePhase;
  String get selectedEngineLabel => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.fallbackEngineLabel;
  String get dependencyIsolationMode => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.dependencyIsolationMode;
  List<String> get requiredDependencyIsolationGates => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.requiredDependencyIsolationGates;
  List<String> get blockedUntilRealEvidence => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.blockedUntilRealEvidence;
  List<String> get runtimeDependencyCandidates => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.runtimeDependencyCandidates;
  List<String> get dependencyIsolationStrategies => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.dependencyIsolationStrategies;
  List<String> get forbiddenActions => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.forbiddenActions;
  bool get realOcrRuntimeAdded => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeAdded => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.nativeBridgeAdded;
  bool get jniBindingAdded => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.modelBinaryBundledInBaseApp;
  bool get productionModelUrlBound => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.productionModelUrlBound;
  bool get realNetworkDownloadWorkerImplemented => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.realNetworkDownloadWorkerImplemented;
  bool get productionDownloadEnabled => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.productionDownloadEnabled;
  bool get productionInferenceAllowed => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.productionInferenceAllowed;
  bool get runtimeDefaultEnabled => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.runtimeDefaultEnabled;
  bool get runtimeFeatureFlagDefaultOff => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.runtimeFeatureFlagDefaultOff;
  bool get dependencyIsolationPassClaimed => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.dependencyIsolationPassClaimed;
  bool get ocrPassClaimed => GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.ocrPassClaimed;
}

class GaussPpFormulaNetSRuntimeDependencyIsolation {
  const GaussPpFormulaNetSRuntimeDependencyIsolation._();

  static GaussPpFormulaNetSRuntimeDependencyIsolationResult evaluate(GaussPpFormulaNetSRuntimeDependencyIsolationInput input) {
    GaussPpFormulaNetSRuntimeDependencyIsolationResult reject(
      GaussPpFormulaNetSRuntimeDependencyIsolationDecision decision,
      String reason,
    ) => GaussPpFormulaNetSRuntimeDependencyIsolationResult._(
      decision: decision,
      runtimeDependencyIsolationStaticReady: false,
      readyForFutureRuntimeDependencyImplementationOnly: false,
      rejectionReasons: <String>[reason],
      canAddRuntimeDependencyInQ269: false,
      canClaimDependencyIsolationPassInQ269: false,
      canClaimOcrPassInQ269: false,
      canBindNativeBridgeInQ269: false,
      canEnableRuntimeDependencyByDefaultInQ269: false,
      canImportCameraOutputWithoutUserApproval: false,
      dependencyIsolationLabel: input.dependencyIsolationLabel,
    );

    if (!input.q268IsolatedRuntimeImplementationGatePresent || !input.q268StillNoRuntimeNoInference) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingQ268IsolationGate, 'missingQ268IsolationGateOrUnsafeRuntimeState');
    if (!input.runtimeDependencyCandidateDocumented || !input.dependencyIsolationPlanDocumented) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedRuntimeDependencyCandidateUndecided, 'runtimeDependencyCandidateOrIsolationPlanMissing');
    if (!input.gradleImpactReviewDocumented) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingGradleImpactReview, 'missingGradleImpactReview');
    if (!input.androidAbiSplitPlanDocumented) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingAbiSplitPlan, 'missingAbiSplitPlan');
    if (!input.transitiveDependencyAuditDocumented) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingTransitiveDependencyAudit, 'missingTransitiveDependencyAudit');
    if (input.apkAabSizeBudgetMb <= 0 || input.apkAabSizeBudgetMb > GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.apkAabSizeBudgetMb) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingApkAabSizeBudget, 'missingOrExceededApkAabSizeBudget');
    if (!input.dependencyLicenseReviewDocumented || !input.buildRollbackPlanDocumented) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingBuildRollbackPlan, 'missingLicenseReviewOrBuildRollbackPlan');
    if (!input.featureFlagDefaultOffDocumented || !input.noDefaultRuntimeEnablement || !input.runtimeClasspathIsolationDocumented) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingFeatureFlagIsolation, 'missingFeatureFlagOrClasspathIsolation');
    if (!input.fallbackPlanDocumented || !input.formulaOcrPrimaryOnly) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingFallbackPlan, 'missingFormulaOcrPrimaryOnlyGate');
    if (!input.editableMathLiveReviewRequired || !input.userApprovalRequiredBeforeWorkspaceImport) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingMathLiveReviewRequirement, 'missingMathLiveReviewOrUserApproval');
    if (!input.directSolveBlocked || !input.directGraphSolutionHistoryBlocked) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedDirectSolveOrImportRisk, 'directCameraSolveGraphSolutionHistoryRisk');
    final unsafeDependencyAttempt = !input.noPaddleRuntimeDependencyAdded || !input.noPaddleOcrDependencyAdded || !input.noNativeBridgeAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noRealNetworkDownloadWorkerImplemented || input.productionDownloadEnabled || !input.noProductionInferenceAllowed || input.dependencyIsolationPassClaimed || input.ocrPassClaimed;
    if (unsafeDependencyAttempt) return reject(GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedUnsafeDependencyAddedInQ269, 'unsafeRuntimeDependencyOrFalsePassAttempt');

    return GaussPpFormulaNetSRuntimeDependencyIsolationResult._(
      decision: GaussPpFormulaNetSRuntimeDependencyIsolationDecision.readyForFutureRuntimeDependencyImplementationOnly,
      runtimeDependencyIsolationStaticReady: true,
      readyForFutureRuntimeDependencyImplementationOnly: true,
      rejectionReasons: const <String>[],
      canAddRuntimeDependencyInQ269: false,
      canClaimDependencyIsolationPassInQ269: false,
      canClaimOcrPassInQ269: false,
      canBindNativeBridgeInQ269: false,
      canEnableRuntimeDependencyByDefaultInQ269: false,
      canImportCameraOutputWithoutUserApproval: false,
      dependencyIsolationLabel: input.dependencyIsolationLabel,
    );
  }
}
