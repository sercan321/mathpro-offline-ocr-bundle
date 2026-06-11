import 'gauss_pp_formulanet_s_private_artifact_load_prototype_policy.dart';

enum GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision {
  blockedMissingQ270BridgeSkeleton,
  blockedMissingPrivateArtifactPath,
  blockedArtifactOutsidePrivateStorage,
  blockedMissingVerifiedSha256,
  blockedMalformedSha256,
  blockedArtifactBundledInBaseApkOrAssets,
  blockedMissingModelFormatProbe,
  blockedMissingRuntimePathCandidate,
  blockedMissingBridgeProtocolCandidate,
  blockedMissingTimeoutCancellationPolicy,
  blockedMissingMemoryPressurePolicy,
  blockedMissingFailureRetryFallbackPlan,
  blockedMissingMathLiveReviewRequirement,
  blockedDirectSolveOrImportRisk,
  blockedUnsafeRuntimeOrInferenceAddedInQ271,
  readyForFuturePrivateArtifactLoadSmokeOnly,
}

class GaussPpFormulaNetSPrivateArtifactLoadPrototypeInput {
  const GaussPpFormulaNetSPrivateArtifactLoadPrototypeInput({
    required this.q270NativeRuntimeBridgeSkeletonPresent,
    required this.q270StillNoNativeRuntimeNoInference,
    required this.privateArtifactPathDocumented,
    required this.privateArtifactPathInsideAppStorage,
    required this.artifactSha256,
    required this.artifactShaPreviouslyAcceptedByCourt,
    required this.artifactNotBundledInBaseApk,
    required this.artifactNotLoadedFromAssets,
    required this.modelFormatProbeDocumented,
    required this.runtimePathCandidateDocumented,
    required this.bridgeProtocolCandidateDocumented,
    required this.artifactAccessEnvelopeDocumented,
    required this.loadDryRunContractDocumented,
    required this.timeoutCancellationPolicyDocumented,
    required this.memoryPressurePolicyDocumented,
    required this.latencyBudgetMs,
    required this.peakMemoryBudgetMb,
    required this.failureRetryPlanDocumented,
    required this.fallbackPlanDocumented,
    required this.featureFlagDefaultOffDocumented,
    required this.noDefaultRuntimeEnablement,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveBlocked,
    required this.directGraphSolutionHistoryBlocked,
    required this.noPaddleRuntimeAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noNativeBridgeImplementationAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.noProductionInferenceAllowed,
    required this.artifactLoadPrototypePassClaimed,
    required this.ocrPassClaimed,
    required this.artifactLoadLabel,
  });

  final bool q270NativeRuntimeBridgeSkeletonPresent;
  final bool q270StillNoNativeRuntimeNoInference;
  final bool privateArtifactPathDocumented;
  final bool privateArtifactPathInsideAppStorage;
  final String artifactSha256;
  final bool artifactShaPreviouslyAcceptedByCourt;
  final bool artifactNotBundledInBaseApk;
  final bool artifactNotLoadedFromAssets;
  final bool modelFormatProbeDocumented;
  final bool runtimePathCandidateDocumented;
  final bool bridgeProtocolCandidateDocumented;
  final bool artifactAccessEnvelopeDocumented;
  final bool loadDryRunContractDocumented;
  final bool timeoutCancellationPolicyDocumented;
  final bool memoryPressurePolicyDocumented;
  final int latencyBudgetMs;
  final int peakMemoryBudgetMb;
  final bool failureRetryPlanDocumented;
  final bool fallbackPlanDocumented;
  final bool featureFlagDefaultOffDocumented;
  final bool noDefaultRuntimeEnablement;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveBlocked;
  final bool directGraphSolutionHistoryBlocked;
  final bool noPaddleRuntimeAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noNativeBridgeImplementationAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool noProductionInferenceAllowed;
  final bool artifactLoadPrototypePassClaimed;
  final bool ocrPassClaimed;
  final String artifactLoadLabel;
}

class GaussPpFormulaNetSPrivateArtifactLoadPrototypeResult {
  const GaussPpFormulaNetSPrivateArtifactLoadPrototypeResult._({
    required this.decision,
    required this.privateArtifactLoadPrototypeStaticReady,
    required this.readyForFuturePrivateArtifactLoadSmokeOnly,
    required this.rejectionReasons,
    required this.canLoadPrivateArtifactInQ271,
    required this.canProbeModelFormatInQ271,
    required this.canRunInferenceInQ271,
    required this.canClaimArtifactLoadPassInQ271,
    required this.canClaimOcrPassInQ271,
    required this.canEnableRuntimeByDefaultInQ271,
    required this.canImportCameraOutputWithoutUserApproval,
    required this.artifactLoadLabel,
  });

  final GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision decision;
  final bool privateArtifactLoadPrototypeStaticReady;
  final bool readyForFuturePrivateArtifactLoadSmokeOnly;
  final List<String> rejectionReasons;
  final bool canLoadPrivateArtifactInQ271;
  final bool canProbeModelFormatInQ271;
  final bool canRunInferenceInQ271;
  final bool canClaimArtifactLoadPassInQ271;
  final bool canClaimOcrPassInQ271;
  final bool canEnableRuntimeByDefaultInQ271;
  final bool canImportCameraOutputWithoutUserApproval;
  final String artifactLoadLabel;

  String get phase => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.phase;
  String get sourcePhase => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.sourcePhase;
  String get selectedEngineLabel => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.fallbackEngineLabel;
  String get artifactLoadMode => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.artifactLoadMode;
  List<String> get requiredArtifactLoadGates => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.requiredArtifactLoadGates;
  List<String> get blockedUntilRealEvidence => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.blockedUntilRealEvidence;
  List<String> get artifactAccessEnvelopeFields => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.artifactAccessEnvelopeFields;
  List<String> get modelFormatProbeFields => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.modelFormatProbeFields;
  List<String> get artifactLoadFailureCodes => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.artifactLoadFailureCodes;
  List<String> get artifactLoadStrategies => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.artifactLoadStrategies;
  List<String> get forbiddenActions => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.forbiddenActions;
  bool get realOcrRuntimeAdded => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeImplementationAdded => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.nativeBridgeImplementationAdded;
  bool get jniBindingAdded => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.modelBinaryBundledInBaseApp;
  bool get productionModelUrlBound => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.productionModelUrlBound;
  bool get realNetworkDownloadWorkerImplemented => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.realNetworkDownloadWorkerImplemented;
  bool get productionDownloadEnabled => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.productionDownloadEnabled;
  bool get productionInferenceAllowed => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.productionInferenceAllowed;
  bool get runtimeFeatureFlagDefaultOff => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.runtimeFeatureFlagDefaultOff;
  bool get privateStorageOnly => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.privateStorageOnly;
  bool get artifactLoadPrototypePassClaimed => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.artifactLoadPrototypePassClaimed;
  bool get ocrPassClaimed => GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.ocrPassClaimed;
}

class GaussPpFormulaNetSPrivateArtifactLoadPrototype {
  const GaussPpFormulaNetSPrivateArtifactLoadPrototype._();

  static final RegExp _sha256Pattern = RegExp(r'^[0-9a-fA-F]{64}$');

  static GaussPpFormulaNetSPrivateArtifactLoadPrototypeResult evaluate(GaussPpFormulaNetSPrivateArtifactLoadPrototypeInput input) {
    GaussPpFormulaNetSPrivateArtifactLoadPrototypeResult reject(
      GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision decision,
      String reason,
    ) => GaussPpFormulaNetSPrivateArtifactLoadPrototypeResult._(
      decision: decision,
      privateArtifactLoadPrototypeStaticReady: false,
      readyForFuturePrivateArtifactLoadSmokeOnly: false,
      rejectionReasons: <String>[reason],
      canLoadPrivateArtifactInQ271: false,
      canProbeModelFormatInQ271: false,
      canRunInferenceInQ271: false,
      canClaimArtifactLoadPassInQ271: false,
      canClaimOcrPassInQ271: false,
      canEnableRuntimeByDefaultInQ271: false,
      canImportCameraOutputWithoutUserApproval: false,
      artifactLoadLabel: input.artifactLoadLabel,
    );

    if (!input.q270NativeRuntimeBridgeSkeletonPresent || !input.q270StillNoNativeRuntimeNoInference) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingQ270BridgeSkeleton, 'missingQ270BridgeSkeletonOrUnsafeRuntimeState');
    if (!input.privateArtifactPathDocumented) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingPrivateArtifactPath, 'missingPrivateArtifactPath');
    if (!input.privateArtifactPathInsideAppStorage) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedArtifactOutsidePrivateStorage, 'artifactOutsidePrivateAppStorage');
    if (input.artifactSha256.isEmpty) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingVerifiedSha256, 'missingArtifactSha256');
    if (!_sha256Pattern.hasMatch(input.artifactSha256)) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMalformedSha256, 'malformedArtifactSha256');
    if (!input.artifactShaPreviouslyAcceptedByCourt) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingVerifiedSha256, 'artifactShaNotAcceptedByCourt');
    if (!input.artifactNotBundledInBaseApk || !input.artifactNotLoadedFromAssets) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedArtifactBundledInBaseApkOrAssets, 'artifactBundledOrLoadedFromAssets');
    if (!input.modelFormatProbeDocumented) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingModelFormatProbe, 'missingModelFormatProbe');
    if (!input.runtimePathCandidateDocumented) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingRuntimePathCandidate, 'missingRuntimePathCandidate');
    if (!input.bridgeProtocolCandidateDocumented || !input.artifactAccessEnvelopeDocumented || !input.loadDryRunContractDocumented) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingBridgeProtocolCandidate, 'missingBridgeProtocolOrArtifactAccessEnvelope');
    if (!input.timeoutCancellationPolicyDocumented || input.latencyBudgetMs <= 0 || input.latencyBudgetMs > GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.artifactLoadTimeoutBudgetMs) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingTimeoutCancellationPolicy, 'missingOrInvalidTimeoutCancellationPolicy');
    if (!input.memoryPressurePolicyDocumented || input.peakMemoryBudgetMb <= 0 || input.peakMemoryBudgetMb > GaussPpFormulaNetSPrivateArtifactLoadPrototypePolicy.artifactProbePeakMemoryBudgetMb) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingMemoryPressurePolicy, 'missingOrInvalidMemoryPressurePolicy');
    if (!input.failureRetryPlanDocumented || !input.fallbackPlanDocumented) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingFailureRetryFallbackPlan, 'missingFailureRetryOrFallbackPlan');
    if (!input.featureFlagDefaultOffDocumented || !input.noDefaultRuntimeEnablement) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedUnsafeRuntimeOrInferenceAddedInQ271, 'missingFeatureFlagDefaultOffOrNoDefaultRuntimeEnablement');
    if (!input.editableMathLiveReviewRequired || !input.userApprovalRequiredBeforeWorkspaceImport) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedMissingMathLiveReviewRequirement, 'missingMathLiveReviewOrUserApproval');
    if (!input.directSolveBlocked || !input.directGraphSolutionHistoryBlocked) return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedDirectSolveOrImportRisk, 'directSolveGraphSolutionHistoryRisk');
    if (!input.noPaddleRuntimeAdded || !input.noPaddleOcrDependencyAdded || !input.noNativeBridgeImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noRealNetworkDownloadWorkerImplemented || input.productionDownloadEnabled || !input.noProductionInferenceAllowed || input.artifactLoadPrototypePassClaimed || input.ocrPassClaimed) {
      return reject(GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.blockedUnsafeRuntimeOrInferenceAddedInQ271, 'unsafeRuntimeImplementationOrFalsePassInQ271');
    }

    return GaussPpFormulaNetSPrivateArtifactLoadPrototypeResult._(
      decision: GaussPpFormulaNetSPrivateArtifactLoadPrototypeDecision.readyForFuturePrivateArtifactLoadSmokeOnly,
      privateArtifactLoadPrototypeStaticReady: true,
      readyForFuturePrivateArtifactLoadSmokeOnly: true,
      rejectionReasons: const <String>[],
      canLoadPrivateArtifactInQ271: false,
      canProbeModelFormatInQ271: false,
      canRunInferenceInQ271: false,
      canClaimArtifactLoadPassInQ271: false,
      canClaimOcrPassInQ271: false,
      canEnableRuntimeByDefaultInQ271: false,
      canImportCameraOutputWithoutUserApproval: false,
      artifactLoadLabel: input.artifactLoadLabel,
    );
  }
}
