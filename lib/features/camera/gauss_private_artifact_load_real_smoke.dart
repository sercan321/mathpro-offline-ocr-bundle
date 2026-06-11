import 'gauss_private_artifact_load_real_smoke_policy.dart';

enum GaussPrivateArtifactLoadRealSmokeDecision {
  blockedMissingQ280NativeRuntimeBridge,
  blockedMissingDependencyTrialOrEvidenceLock,
  blockedMissingPrivateArtifactEvidence,
  blockedInvalidShaEvidence,
  blockedShaMismatch,
  blockedMissingModelFormatProbeOrDummySmokePlan,
  blockedMissingReviewApprovalBoundary,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedUnsafeRuntimeOrInferenceAdded,
  readyForQ282FirstRuntimeSmokeGateOnly,
}

class GaussPrivateArtifactLoadRealSmokeInput {
  const GaussPrivateArtifactLoadRealSmokeInput({
    required this.q280NativeRuntimeBridgePresent,
    required this.q279DependencyTrialPresent,
    required this.q278EvidenceLockPresent,
    required this.privateAppStoragePathVerified,
    required this.verifiedPrivateArtifactRequired,
    required this.expectedSha256,
    required this.actualSha256,
    required this.checksumBeforeLoadRequired,
    required this.checksumMatchBeforeReadyRequired,
    required this.atomicMoveCompletedEvidenceRequired,
    required this.modelFormatProbePlanRequired,
    required this.dummyInputOnlySmokeRequired,
    required this.timeoutCancellationPolicyRequired,
    required this.memoryPressurePolicyRequired,
    required this.reviewOnlyModeRequired,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.noRealPrivateArtifactFileLoadedInQ281,
    required this.noModelFormatProbeExecutedInQ281,
    required this.noNativeRuntimeBridgeInvokedInQ281,
    required this.noNativeHandlerImplementationAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noPaddleRuntimeAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noRuntimeDependencyAddedToPubspec,
    required this.noGradleNativeRuntimeDependencyAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noProductionDownloadEnabled,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.noImageToLatexInferenceExecuted,
    required this.privateArtifactLoadPassClaimed,
    required this.runtimeSmokePassClaimed,
    required this.ocrPassClaimed,
    required this.releasePassClaimed,
    required this.evidenceLabel,
  });

  final bool q280NativeRuntimeBridgePresent;
  final bool q279DependencyTrialPresent;
  final bool q278EvidenceLockPresent;
  final bool privateAppStoragePathVerified;
  final bool verifiedPrivateArtifactRequired;
  final String expectedSha256;
  final String actualSha256;
  final bool checksumBeforeLoadRequired;
  final bool checksumMatchBeforeReadyRequired;
  final bool atomicMoveCompletedEvidenceRequired;
  final bool modelFormatProbePlanRequired;
  final bool dummyInputOnlySmokeRequired;
  final bool timeoutCancellationPolicyRequired;
  final bool memoryPressurePolicyRequired;
  final bool reviewOnlyModeRequired;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool noRealPrivateArtifactFileLoadedInQ281;
  final bool noModelFormatProbeExecutedInQ281;
  final bool noNativeRuntimeBridgeInvokedInQ281;
  final bool noNativeHandlerImplementationAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noPaddleRuntimeAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noRuntimeDependencyAddedToPubspec;
  final bool noGradleNativeRuntimeDependencyAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noProductionDownloadEnabled;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool noImageToLatexInferenceExecuted;
  final bool privateArtifactLoadPassClaimed;
  final bool runtimeSmokePassClaimed;
  final bool ocrPassClaimed;
  final bool releasePassClaimed;
  final String evidenceLabel;

  bool get hasValidExpectedSha256 => GaussPrivateArtifactLoadRequestEnvelope.isSha256(expectedSha256);
  bool get hasValidActualSha256 => GaussPrivateArtifactLoadRequestEnvelope.isSha256(actualSha256);
  bool get shaMatches => hasValidExpectedSha256 && hasValidActualSha256 && expectedSha256 == actualSha256;
}

class GaussPrivateArtifactLoadRealSmokeResult {
  const GaussPrivateArtifactLoadRealSmokeResult._({
    required this.decision,
    required this.privateArtifactLoadSmokeStaticReady,
    required this.readyForQ282FirstRuntimeSmokeGateOnly,
    required this.rejectionReasons,
    required this.canLoadRealPrivateArtifactInQ281,
    required this.canExecuteModelFormatProbeInQ281,
    required this.canInvokeNativeRuntimeBridgeInQ281,
    required this.canImportCameraOutputWithoutReview,
    required this.canClaimPrivateArtifactLoadPassInQ281,
    required this.canClaimOcrPassInQ281,
    required this.evidenceLabel,
  });

  final GaussPrivateArtifactLoadRealSmokeDecision decision;
  final bool privateArtifactLoadSmokeStaticReady;
  final bool readyForQ282FirstRuntimeSmokeGateOnly;
  final List<String> rejectionReasons;
  final bool canLoadRealPrivateArtifactInQ281;
  final bool canExecuteModelFormatProbeInQ281;
  final bool canInvokeNativeRuntimeBridgeInQ281;
  final bool canImportCameraOutputWithoutReview;
  final bool canClaimPrivateArtifactLoadPassInQ281;
  final bool canClaimOcrPassInQ281;
  final String evidenceLabel;

  String get phase => GaussPrivateArtifactLoadRealSmokePolicy.phase;
  String get sourcePhase => GaussPrivateArtifactLoadRealSmokePolicy.sourcePhase;
  String get selectedEngineLabel => GaussPrivateArtifactLoadRealSmokePolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussPrivateArtifactLoadRealSmokePolicy.fallbackEngineLabel;
  String get smokeMode => GaussPrivateArtifactLoadRealSmokePolicy.smokeMode;
  bool get privateArtifactLoadSmokeEnvelopeAdded => GaussPrivateArtifactLoadRealSmokePolicy.privateArtifactLoadSmokeEnvelopeAdded;
  bool get realPrivateArtifactFileLoadedInQ281 => GaussPrivateArtifactLoadRealSmokePolicy.realPrivateArtifactFileLoadedInQ281;
  bool get modelFormatProbeExecutedInQ281 => GaussPrivateArtifactLoadRealSmokePolicy.modelFormatProbeExecutedInQ281;
  bool get nativeRuntimeBridgeInvokedInQ281 => GaussPrivateArtifactLoadRealSmokePolicy.nativeRuntimeBridgeInvokedInQ281;
  bool get realOcrRuntimeAdded => GaussPrivateArtifactLoadRealSmokePolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussPrivateArtifactLoadRealSmokePolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussPrivateArtifactLoadRealSmokePolicy.paddleOcrDependencyAdded;
  bool get modelBinaryBundledInBaseApp => GaussPrivateArtifactLoadRealSmokePolicy.modelBinaryBundledInBaseApp;
  bool get realImageToLatexInferenceExecuted => GaussPrivateArtifactLoadRealSmokePolicy.realImageToLatexInferenceExecuted;
  List<String> get requiredPrivateArtifactLoadSmokeGates => GaussPrivateArtifactLoadRealSmokePolicy.requiredPrivateArtifactLoadSmokeGates;
  List<String> get forbiddenActions => GaussPrivateArtifactLoadRealSmokePolicy.forbiddenActions;
}

class GaussPrivateArtifactLoadRequestEnvelope {
  const GaussPrivateArtifactLoadRequestEnvelope({
    required this.requestId,
    required this.privateArtifactPath,
    required this.expectedSha256,
    required this.actualSha256,
    required this.artifactSizeBytes,
    required this.androidAbi,
    required this.timeoutMs,
    required this.runtimeFeatureFlagEnabled,
    required this.privateStoragePathVerified,
    this.dummyInputOnly = true,
  });

  final String requestId;
  final String privateArtifactPath;
  final String expectedSha256;
  final String actualSha256;
  final int artifactSizeBytes;
  final String androidAbi;
  final int timeoutMs;
  final bool runtimeFeatureFlagEnabled;
  final bool privateStoragePathVerified;
  final bool dummyInputOnly;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get hasValidExpectedSha256 => isSha256(expectedSha256);
  bool get hasValidActualSha256 => isSha256(actualSha256);
  bool get shaMatches => hasValidExpectedSha256 && hasValidActualSha256 && expectedSha256.toLowerCase() == actualSha256.toLowerCase();
  bool get isPrivateStoragePath => privateArtifactPath.contains('/files/models/') || privateArtifactPath.contains('\\files\\models\\');
  bool get withinSizeBudget => artifactSizeBytes > 0 && artifactSizeBytes <= GaussPrivateArtifactLoadRealSmokePolicy.maxArtifactSizeMb * 1024 * 1024;
  bool get supportedAbiEnvelope => androidAbi == 'arm64-v8a' || androidAbi == 'armeabi-v7a' || androidAbi == 'x86_64';
  bool get isDummySmokeOnlySafe => dummyInputOnly && timeoutMs <= GaussPrivateArtifactLoadRealSmokePolicy.loadTimeoutBudgetMs;
}

class GaussPrivateArtifactLoadResultEnvelope {
  const GaussPrivateArtifactLoadResultEnvelope._({
    required this.requestId,
    required this.status,
    required this.artifactPathAccepted,
    required this.shaMatch,
    required this.modelFormatProbePlanned,
    required this.realFileLoadExecuted,
    required this.runtimeBridgeInvoked,
    required this.warnings,
    required this.errorCode,
    required this.latencyMs,
    required this.reviewRequired,
    required this.directWorkspaceMutationAttempted,
  });

  factory GaussPrivateArtifactLoadResultEnvelope.blockedFlagOff(String requestId) {
    return GaussPrivateArtifactLoadResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      artifactPathAccepted: false,
      shaMatch: false,
      modelFormatProbePlanned: false,
      realFileLoadExecuted: false,
      runtimeBridgeInvoked: false,
      warnings: const <String>['Q281 private artifact load smoke is default-off; no runtime path was invoked.'],
      errorCode: 'runtimeFeatureFlagOff',
      latencyMs: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussPrivateArtifactLoadResultEnvelope.blockedShaMismatch(String requestId) {
    return GaussPrivateArtifactLoadResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      artifactPathAccepted: false,
      shaMatch: false,
      modelFormatProbePlanned: false,
      realFileLoadExecuted: false,
      runtimeBridgeInvoked: false,
      warnings: const <String>['Expected and actual artifact SHA256 values do not match.'],
      errorCode: 'artifactShaMismatch',
      latencyMs: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussPrivateArtifactLoadResultEnvelope.blockedNoRealLoadExecuted(String requestId) {
    return GaussPrivateArtifactLoadResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      artifactPathAccepted: true,
      shaMatch: true,
      modelFormatProbePlanned: true,
      realFileLoadExecuted: false,
      runtimeBridgeInvoked: false,
      warnings: const <String>['Q281 defines the private artifact load smoke envelope only; real file load is deferred to Q282 evidence.'],
      errorCode: 'noRealArtifactLoadExecutedInQ281',
      latencyMs: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  final String requestId;
  final String status;
  final bool artifactPathAccepted;
  final bool shaMatch;
  final bool modelFormatProbePlanned;
  final bool realFileLoadExecuted;
  final bool runtimeBridgeInvoked;
  final List<String> warnings;
  final String errorCode;
  final int latencyMs;
  final bool reviewRequired;
  final bool directWorkspaceMutationAttempted;

  bool get canProceedToRuntimeSmoke => false;
  bool get canImportToWorkspace => false;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussPrivateArtifactLoadRealSmoke {
  const GaussPrivateArtifactLoadRealSmoke._();

  static GaussPrivateArtifactLoadRealSmokeResult evaluate(GaussPrivateArtifactLoadRealSmokeInput input) {
    GaussPrivateArtifactLoadRealSmokeResult reject(GaussPrivateArtifactLoadRealSmokeDecision decision, String reason) {
      return GaussPrivateArtifactLoadRealSmokeResult._(
        decision: decision,
        privateArtifactLoadSmokeStaticReady: false,
        readyForQ282FirstRuntimeSmokeGateOnly: false,
        rejectionReasons: <String>[reason],
        canLoadRealPrivateArtifactInQ281: false,
        canExecuteModelFormatProbeInQ281: false,
        canInvokeNativeRuntimeBridgeInQ281: false,
        canImportCameraOutputWithoutReview: false,
        canClaimPrivateArtifactLoadPassInQ281: false,
        canClaimOcrPassInQ281: false,
        evidenceLabel: input.evidenceLabel,
      );
    }

    if (!input.q280NativeRuntimeBridgePresent) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedMissingQ280NativeRuntimeBridge, 'missingQ280NativeRuntimeBridge');
    }
    if (!input.q279DependencyTrialPresent || !input.q278EvidenceLockPresent) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedMissingDependencyTrialOrEvidenceLock, 'missingQ279DependencyTrialOrQ278EvidenceLock');
    }
    if (!input.privateAppStoragePathVerified || !input.verifiedPrivateArtifactRequired || !input.atomicMoveCompletedEvidenceRequired) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedMissingPrivateArtifactEvidence, 'missingPrivateStorageArtifactOrAtomicMoveEvidence');
    }
    if (!input.hasValidExpectedSha256 || !input.hasValidActualSha256 || !input.checksumBeforeLoadRequired || !input.checksumMatchBeforeReadyRequired) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedInvalidShaEvidence, 'invalidShaOrMissingChecksumGate');
    }
    if (!input.shaMatches) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedShaMismatch, 'artifactShaMismatch');
    }
    if (!input.modelFormatProbePlanRequired || !input.dummyInputOnlySmokeRequired || !input.timeoutCancellationPolicyRequired || !input.memoryPressurePolicyRequired) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedMissingModelFormatProbeOrDummySmokePlan, 'missingModelFormatProbeDummySmokeOrBudgetPolicy');
    }
    if (!input.reviewOnlyModeRequired || !input.editableMathLiveReviewRequired || !input.explicitUserApprovalRequiredBeforeWorkspaceImport) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedMissingReviewApprovalBoundary, 'missingMathLiveReviewOrUserApprovalBoundary');
    }
    if (!input.directSolveGraphSolutionHistoryBlocked) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedDirectSolveGraphSolutionHistoryRisk, 'directSolveGraphSolutionHistoryRisk');
    }
    if (!input.noRealPrivateArtifactFileLoadedInQ281 || !input.noModelFormatProbeExecutedInQ281 || !input.noNativeRuntimeBridgeInvokedInQ281 || !input.noNativeHandlerImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noPaddleRuntimeAdded || !input.noPaddleOcrDependencyAdded || !input.noRuntimeDependencyAddedToPubspec || !input.noGradleNativeRuntimeDependencyAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noProductionDownloadEnabled || !input.noRealNetworkDownloadWorkerImplemented || !input.noImageToLatexInferenceExecuted || input.privateArtifactLoadPassClaimed || input.runtimeSmokePassClaimed || input.ocrPassClaimed || input.releasePassClaimed) {
      return reject(GaussPrivateArtifactLoadRealSmokeDecision.blockedUnsafeRuntimeOrInferenceAdded, 'unsafeRuntimeInferenceOrPassClaim');
    }

    return GaussPrivateArtifactLoadRealSmokeResult._(
      decision: GaussPrivateArtifactLoadRealSmokeDecision.readyForQ282FirstRuntimeSmokeGateOnly,
      privateArtifactLoadSmokeStaticReady: true,
      readyForQ282FirstRuntimeSmokeGateOnly: true,
      rejectionReasons: const <String>[],
      canLoadRealPrivateArtifactInQ281: false,
      canExecuteModelFormatProbeInQ281: false,
      canInvokeNativeRuntimeBridgeInQ281: false,
      canImportCameraOutputWithoutReview: false,
      canClaimPrivateArtifactLoadPassInQ281: false,
      canClaimOcrPassInQ281: false,
      evidenceLabel: input.evidenceLabel,
    );
  }

  static GaussPrivateArtifactLoadResultEnvelope guardedLoadSmoke(GaussPrivateArtifactLoadRequestEnvelope request) {
    if (!request.runtimeFeatureFlagEnabled) {
      return GaussPrivateArtifactLoadResultEnvelope.blockedFlagOff(request.requestId);
    }
    if (!request.privateStoragePathVerified || !request.isPrivateStoragePath || !request.withinSizeBudget || !request.supportedAbiEnvelope || !request.isDummySmokeOnlySafe) {
      return GaussPrivateArtifactLoadResultEnvelope.blockedShaMismatch(request.requestId);
    }
    if (!request.shaMatches) {
      return GaussPrivateArtifactLoadResultEnvelope.blockedShaMismatch(request.requestId);
    }
    return GaussPrivateArtifactLoadResultEnvelope.blockedNoRealLoadExecuted(request.requestId);
  }
}
