import 'gauss_selected_runtime_dependency_trial_policy.dart';

enum GaussSelectedRuntimeDependencyTrialDecision {
  blockedMissingQ278EvidenceLock,
  blockedMissingDependencyCoordinates,
  blockedMissingDependencyLicenseOrVersionEvidence,
  blockedMissingBuildAbiOrApkEvidence,
  blockedMissingDefaultOffFlagOrRollback,
  blockedMissingReviewApprovalBoundary,
  blockedUnsafeRuntimeMutationOrPassClaim,
  readyForQ280BridgeImplementationGateOnly,
}

class GaussSelectedRuntimeDependencyTrialInput {
  const GaussSelectedRuntimeDependencyTrialInput({
    required this.q278EvidenceLockPresent,
    required this.officialDependencyCoordinatesDocumented,
    required this.pinnedRuntimeDependencyVersionDocumented,
    required this.dependencyLicenseCompatible,
    required this.transitiveDependencyAuditComplete,
    required this.gradleCompatibilityDocumented,
    required this.abiPackagingImpactDocumented,
    required this.nativeAbiCount,
    required this.apkSizeIncreaseBudgetMb,
    required this.defaultOffFeatureFlagRequired,
    required this.featureFlagEnabledByDefault,
    required this.runtimeInstantiationBlockedWhenFlagOff,
    required this.rollbackPlanDocumented,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.noRuntimeDependencyAddedToPubspec,
    required this.noGradleNativeRuntimeDependencyAdded,
    required this.noNativeBridgeImplementationAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noProductionDownloadEnabled,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noImageToLatexInferenceExecuted,
    required this.runtimeDependencyTrialPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.releasePassClaimed,
    required this.evidenceLabel,
  });

  final bool q278EvidenceLockPresent;
  final bool officialDependencyCoordinatesDocumented;
  final bool pinnedRuntimeDependencyVersionDocumented;
  final bool dependencyLicenseCompatible;
  final bool transitiveDependencyAuditComplete;
  final bool gradleCompatibilityDocumented;
  final bool abiPackagingImpactDocumented;
  final int nativeAbiCount;
  final int apkSizeIncreaseBudgetMb;
  final bool defaultOffFeatureFlagRequired;
  final bool featureFlagEnabledByDefault;
  final bool runtimeInstantiationBlockedWhenFlagOff;
  final bool rollbackPlanDocumented;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool noRuntimeDependencyAddedToPubspec;
  final bool noGradleNativeRuntimeDependencyAdded;
  final bool noNativeBridgeImplementationAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noProductionDownloadEnabled;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noImageToLatexInferenceExecuted;
  final bool runtimeDependencyTrialPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool releasePassClaimed;
  final String evidenceLabel;
}

class GaussSelectedRuntimeDependencyTrialResult {
  const GaussSelectedRuntimeDependencyTrialResult._({
    required this.decision,
    required this.dependencyTrialStaticReady,
    required this.readyForQ280BridgeImplementationGateOnly,
    required this.rejectionReasons,
    required this.canEnableRuntimeFlagByDefaultInQ279,
    required this.canInstantiateRuntimeInQ279,
    required this.canBindNativeBridgeInQ279,
    required this.canRunImageToLatexInferenceInQ279,
    required this.canClaimRuntimeDependencyTrialPassInQ279,
    required this.canClaimOcrPassInQ279,
    required this.canImportCameraOutputWithoutReview,
    required this.evidenceLabel,
  });

  final GaussSelectedRuntimeDependencyTrialDecision decision;
  final bool dependencyTrialStaticReady;
  final bool readyForQ280BridgeImplementationGateOnly;
  final List<String> rejectionReasons;
  final bool canEnableRuntimeFlagByDefaultInQ279;
  final bool canInstantiateRuntimeInQ279;
  final bool canBindNativeBridgeInQ279;
  final bool canRunImageToLatexInferenceInQ279;
  final bool canClaimRuntimeDependencyTrialPassInQ279;
  final bool canClaimOcrPassInQ279;
  final bool canImportCameraOutputWithoutReview;
  final String evidenceLabel;

  String get phase => GaussSelectedRuntimeDependencyTrialPolicy.phase;
  String get sourcePhase => GaussSelectedRuntimeDependencyTrialPolicy.sourcePhase;
  String get selectedEngineLabel => GaussSelectedRuntimeDependencyTrialPolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussSelectedRuntimeDependencyTrialPolicy.fallbackEngineLabel;
  String get dependencyTrialMode => GaussSelectedRuntimeDependencyTrialPolicy.dependencyTrialMode;
  List<String> get requiredDependencyTrialGates => GaussSelectedRuntimeDependencyTrialPolicy.requiredDependencyTrialGates;
  List<String> get blockedUntilRealEvidence => GaussSelectedRuntimeDependencyTrialPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussSelectedRuntimeDependencyTrialPolicy.forbiddenActions;
  bool get runtimeDependencyAddedToPubspec => GaussSelectedRuntimeDependencyTrialPolicy.runtimeDependencyAddedToPubspec;
  bool get gradleNativeRuntimeDependencyAdded => GaussSelectedRuntimeDependencyTrialPolicy.gradleNativeRuntimeDependencyAdded;
  bool get featureFlagEnabledByDefault => GaussSelectedRuntimeDependencyTrialPolicy.featureFlagEnabledByDefault;
  bool get productionRuntimeInstantiationAllowed => GaussSelectedRuntimeDependencyTrialPolicy.productionRuntimeInstantiationAllowed;
  bool get realOcrRuntimeAdded => GaussSelectedRuntimeDependencyTrialPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussSelectedRuntimeDependencyTrialPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussSelectedRuntimeDependencyTrialPolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeImplementationAdded => GaussSelectedRuntimeDependencyTrialPolicy.nativeBridgeImplementationAdded;
  bool get jniBindingAdded => GaussSelectedRuntimeDependencyTrialPolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussSelectedRuntimeDependencyTrialPolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussSelectedRuntimeDependencyTrialPolicy.modelBinaryBundledInBaseApp;
  bool get productionModelUrlBound => GaussSelectedRuntimeDependencyTrialPolicy.productionModelUrlBound;
  bool get productionDownloadEnabled => GaussSelectedRuntimeDependencyTrialPolicy.productionDownloadEnabled;
  bool get realNetworkDownloadWorkerImplemented => GaussSelectedRuntimeDependencyTrialPolicy.realNetworkDownloadWorkerImplemented;
  bool get realImageToLatexInferenceExecuted => GaussSelectedRuntimeDependencyTrialPolicy.realImageToLatexInferenceExecuted;
  bool get runtimeDependencyTrialPassClaimed => GaussSelectedRuntimeDependencyTrialPolicy.runtimeDependencyTrialPassClaimed;
  bool get runtimeIntegrationPassClaimed => GaussSelectedRuntimeDependencyTrialPolicy.runtimeIntegrationPassClaimed;
  bool get ocrPassClaimed => GaussSelectedRuntimeDependencyTrialPolicy.ocrPassClaimed;
  bool get releasePassClaimed => GaussSelectedRuntimeDependencyTrialPolicy.releasePassClaimed;
}

class GaussSelectedRuntimeDependencyTrial {
  const GaussSelectedRuntimeDependencyTrial._();

  static GaussSelectedRuntimeDependencyTrialResult evaluate(GaussSelectedRuntimeDependencyTrialInput input) {
    GaussSelectedRuntimeDependencyTrialResult reject(
      GaussSelectedRuntimeDependencyTrialDecision decision,
      String reason,
    ) {
      return GaussSelectedRuntimeDependencyTrialResult._(
        decision: decision,
        dependencyTrialStaticReady: false,
        readyForQ280BridgeImplementationGateOnly: false,
        rejectionReasons: <String>[reason],
        canEnableRuntimeFlagByDefaultInQ279: false,
        canInstantiateRuntimeInQ279: false,
        canBindNativeBridgeInQ279: false,
        canRunImageToLatexInferenceInQ279: false,
        canClaimRuntimeDependencyTrialPassInQ279: false,
        canClaimOcrPassInQ279: false,
        canImportCameraOutputWithoutReview: false,
        evidenceLabel: input.evidenceLabel,
      );
    }

    if (!input.q278EvidenceLockPresent) {
      return reject(GaussSelectedRuntimeDependencyTrialDecision.blockedMissingQ278EvidenceLock, 'missingQ278EvidenceLock');
    }
    if (!input.officialDependencyCoordinatesDocumented) {
      return reject(GaussSelectedRuntimeDependencyTrialDecision.blockedMissingDependencyCoordinates, 'missingOfficialDependencyCoordinates');
    }
    if (!input.pinnedRuntimeDependencyVersionDocumented || !input.dependencyLicenseCompatible || !input.transitiveDependencyAuditComplete) {
      return reject(GaussSelectedRuntimeDependencyTrialDecision.blockedMissingDependencyLicenseOrVersionEvidence, 'missingPinnedVersionLicenseOrTransitiveAudit');
    }
    if (!input.gradleCompatibilityDocumented || !input.abiPackagingImpactDocumented || input.nativeAbiCount <= 0 || input.nativeAbiCount > GaussSelectedRuntimeDependencyTrialPolicy.maximumAllowedNativeAbiCount || input.apkSizeIncreaseBudgetMb <= 0 || input.apkSizeIncreaseBudgetMb > GaussSelectedRuntimeDependencyTrialPolicy.maximumAllowedApkSizeIncreaseMb) {
      return reject(GaussSelectedRuntimeDependencyTrialDecision.blockedMissingBuildAbiOrApkEvidence, 'missingGradleAbiOrApkBudgetEvidence');
    }
    if (!input.defaultOffFeatureFlagRequired || input.featureFlagEnabledByDefault || !input.runtimeInstantiationBlockedWhenFlagOff || !input.rollbackPlanDocumented) {
      return reject(GaussSelectedRuntimeDependencyTrialDecision.blockedMissingDefaultOffFlagOrRollback, 'missingDefaultOffFlagRuntimeBlockOrRollbackPlan');
    }
    if (!input.editableMathLiveReviewRequired || !input.explicitUserApprovalRequiredBeforeWorkspaceImport || !input.directSolveGraphSolutionHistoryBlocked) {
      return reject(GaussSelectedRuntimeDependencyTrialDecision.blockedMissingReviewApprovalBoundary, 'missingReviewApprovalOrDirectActionBlocks');
    }
    if (!input.noRuntimeDependencyAddedToPubspec || !input.noGradleNativeRuntimeDependencyAdded || !input.noNativeBridgeImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noProductionDownloadEnabled || !input.noRealNetworkDownloadWorkerImplemented || !input.noImageToLatexInferenceExecuted || input.runtimeDependencyTrialPassClaimed || input.runtimeIntegrationPassClaimed || input.ocrPassClaimed || input.releasePassClaimed) {
      return reject(GaussSelectedRuntimeDependencyTrialDecision.blockedUnsafeRuntimeMutationOrPassClaim, 'unsafeRuntimeDependencyMutationOrPassClaim');
    }

    return GaussSelectedRuntimeDependencyTrialResult._(
      decision: GaussSelectedRuntimeDependencyTrialDecision.readyForQ280BridgeImplementationGateOnly,
      dependencyTrialStaticReady: true,
      readyForQ280BridgeImplementationGateOnly: true,
      rejectionReasons: const <String>[],
      canEnableRuntimeFlagByDefaultInQ279: false,
      canInstantiateRuntimeInQ279: false,
      canBindNativeBridgeInQ279: false,
      canRunImageToLatexInferenceInQ279: false,
      canClaimRuntimeDependencyTrialPassInQ279: false,
      canClaimOcrPassInQ279: false,
      canImportCameraOutputWithoutReview: false,
      evidenceLabel: input.evidenceLabel,
    );
  }
}
