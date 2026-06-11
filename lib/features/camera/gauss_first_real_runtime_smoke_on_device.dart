import 'gauss_first_real_runtime_smoke_on_device_policy.dart';

enum GaussFirstRealRuntimeSmokeOnDeviceDecision {
  blockedMissingQ281PrivateArtifactLoadSmoke,
  blockedMissingRuntimeEvidenceChain,
  blockedMissingDeviceEvidence,
  blockedInvalidDummyInputEnvelope,
  blockedMissingReviewApprovalBoundary,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedUnsafeRuntimeOrInferenceAdded,
  readyForQ283ImageToLatexInferenceCourtOnly,
}

class GaussFirstRealRuntimeSmokeOnDeviceInput {
  const GaussFirstRealRuntimeSmokeOnDeviceInput({
    required this.q281PrivateArtifactLoadSmokePresent,
    required this.q280NativeRuntimeBridgePresent,
    required this.q279DependencyTrialPresent,
    required this.q278EvidenceLockPresent,
    required this.verifiedPrivateArtifactEvidenceAccepted,
    required this.acceptedArtifactSha256,
    required this.privateAppStoragePathVerified,
    required this.modelFormatProbeEvidenceRequired,
    required this.runtimeStartupEvidenceRequired,
    required this.dummyInputOnlyBridgeEvidenceRequired,
    required this.timeoutCancellationEvidenceRequired,
    required this.memoryPressureEvidenceRequired,
    required this.latencyMeasurementEvidenceRequired,
    required this.realDeviceFlutterRunEvidenceRequired,
    required this.runtimeFeatureFlagDefaultOffUntilEvidence,
    required this.reviewOnlyModeRequired,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.noRealRuntimeStartedInQ282,
    required this.noRealDummyInputBridgeExecutedInQ282,
    required this.noRealModelFormatProbeExecutedInQ282,
    required this.noNativeRuntimeBridgeInvokedInQ282,
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
    required this.runtimeSmokePassClaimed,
    required this.ocrPassClaimed,
    required this.releasePassClaimed,
    required this.evidenceLabel,
  });

  final bool q281PrivateArtifactLoadSmokePresent;
  final bool q280NativeRuntimeBridgePresent;
  final bool q279DependencyTrialPresent;
  final bool q278EvidenceLockPresent;
  final bool verifiedPrivateArtifactEvidenceAccepted;
  final String acceptedArtifactSha256;
  final bool privateAppStoragePathVerified;
  final bool modelFormatProbeEvidenceRequired;
  final bool runtimeStartupEvidenceRequired;
  final bool dummyInputOnlyBridgeEvidenceRequired;
  final bool timeoutCancellationEvidenceRequired;
  final bool memoryPressureEvidenceRequired;
  final bool latencyMeasurementEvidenceRequired;
  final bool realDeviceFlutterRunEvidenceRequired;
  final bool runtimeFeatureFlagDefaultOffUntilEvidence;
  final bool reviewOnlyModeRequired;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool noRealRuntimeStartedInQ282;
  final bool noRealDummyInputBridgeExecutedInQ282;
  final bool noRealModelFormatProbeExecutedInQ282;
  final bool noNativeRuntimeBridgeInvokedInQ282;
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
  final bool runtimeSmokePassClaimed;
  final bool ocrPassClaimed;
  final bool releasePassClaimed;
  final String evidenceLabel;

  bool get acceptedShaIsValid => GaussFirstRuntimeSmokeRequestEnvelope.isSha256(acceptedArtifactSha256);
}

class GaussFirstRealRuntimeSmokeOnDeviceResult {
  const GaussFirstRealRuntimeSmokeOnDeviceResult._({
    required this.decision,
    required this.runtimeSmokeStaticReady,
    required this.readyForQ283ImageToLatexInferenceCourtOnly,
    required this.rejectionReasons,
    required this.canStartRealRuntimeInQ282,
    required this.canRunDummyInputBridgeInQ282,
    required this.canRunImageToLatexInQ282,
    required this.canImportCameraOutputWithoutReview,
    required this.canClaimRuntimeSmokePassInQ282,
    required this.canClaimOcrPassInQ282,
    required this.evidenceLabel,
  });

  final GaussFirstRealRuntimeSmokeOnDeviceDecision decision;
  final bool runtimeSmokeStaticReady;
  final bool readyForQ283ImageToLatexInferenceCourtOnly;
  final List<String> rejectionReasons;
  final bool canStartRealRuntimeInQ282;
  final bool canRunDummyInputBridgeInQ282;
  final bool canRunImageToLatexInQ282;
  final bool canImportCameraOutputWithoutReview;
  final bool canClaimRuntimeSmokePassInQ282;
  final bool canClaimOcrPassInQ282;
  final String evidenceLabel;

  String get phase => GaussFirstRealRuntimeSmokeOnDevicePolicy.phase;
  String get sourcePhase => GaussFirstRealRuntimeSmokeOnDevicePolicy.sourcePhase;
  String get selectedEngineLabel => GaussFirstRealRuntimeSmokeOnDevicePolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussFirstRealRuntimeSmokeOnDevicePolicy.fallbackEngineLabel;
  String get smokeMode => GaussFirstRealRuntimeSmokeOnDevicePolicy.smokeMode;
  bool get runtimeSmokeEnvelopeAdded => GaussFirstRealRuntimeSmokeOnDevicePolicy.runtimeSmokeEnvelopeAdded;
  bool get realRuntimeStartedInQ282 => GaussFirstRealRuntimeSmokeOnDevicePolicy.realRuntimeStartedInQ282;
  bool get imageToLatexInferenceExecuted => GaussFirstRealRuntimeSmokeOnDevicePolicy.imageToLatexInferenceExecuted;
  bool get ocrPassClaimed => GaussFirstRealRuntimeSmokeOnDevicePolicy.ocrPassClaimed;
  List<String> get requiredRuntimeSmokeGates => GaussFirstRealRuntimeSmokeOnDevicePolicy.requiredRuntimeSmokeGates;
  List<String> get blockedUntilRealEvidence => GaussFirstRealRuntimeSmokeOnDevicePolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussFirstRealRuntimeSmokeOnDevicePolicy.forbiddenActions;
}

class GaussFirstRuntimeSmokeRequestEnvelope {
  const GaussFirstRuntimeSmokeRequestEnvelope({
    required this.requestId,
    required this.privateArtifactPath,
    required this.acceptedArtifactSha256,
    required this.androidAbi,
    required this.deviceModel,
    required this.androidApiLevel,
    required this.runtimeFeatureFlagEnabled,
    required this.dummyInputPayloadHash,
    required this.dummyInputPayloadBytes,
    required this.startupTimeoutMs,
    required this.dummyInputTimeoutMs,
    this.reviewOnlyMode = true,
  });

  final String requestId;
  final String privateArtifactPath;
  final String acceptedArtifactSha256;
  final String androidAbi;
  final String deviceModel;
  final int androidApiLevel;
  final bool runtimeFeatureFlagEnabled;
  final String dummyInputPayloadHash;
  final int dummyInputPayloadBytes;
  final int startupTimeoutMs;
  final int dummyInputTimeoutMs;
  final bool reviewOnlyMode;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get acceptedShaIsValid => isSha256(acceptedArtifactSha256);
  bool get isPrivateStoragePath => privateArtifactPath.contains('/files/models/') || privateArtifactPath.contains('\\files\\models\\');
  bool get supportedAbiEnvelope => androidAbi == 'arm64-v8a' || androidAbi == 'armeabi-v7a' || androidAbi == 'x86_64';
  bool get dummyPayloadWithinBudget => dummyInputPayloadBytes > 0 && dummyInputPayloadBytes <= GaussFirstRealRuntimeSmokeOnDevicePolicy.maxDummyInputPayloadBytes;
  bool get timeoutsWithinBudget => startupTimeoutMs <= GaussFirstRealRuntimeSmokeOnDevicePolicy.runtimeStartupTimeoutMs && dummyInputTimeoutMs <= GaussFirstRealRuntimeSmokeOnDevicePolicy.dummyInputTimeoutMs;
  bool get deviceEnvelopeLooksReal => deviceModel.trim().isNotEmpty && androidApiLevel >= 23;
  bool get isSafeDummySmokeEnvelope => acceptedShaIsValid && isPrivateStoragePath && supportedAbiEnvelope && dummyPayloadWithinBudget && timeoutsWithinBudget && reviewOnlyMode && deviceEnvelopeLooksReal;
}

class GaussFirstRuntimeSmokeResultEnvelope {
  const GaussFirstRuntimeSmokeResultEnvelope._({
    required this.requestId,
    required this.status,
    required this.runtimeStartupAttempted,
    required this.dummyInputBridgeAttempted,
    required this.modelFormatProbeAttempted,
    required this.imageToLatexInferenceAttempted,
    required this.latencyMs,
    required this.peakMemoryMb,
    required this.errorCode,
    required this.warnings,
    required this.reviewRequired,
    required this.directWorkspaceMutationAttempted,
  });

  factory GaussFirstRuntimeSmokeResultEnvelope.blockedFlagOff(String requestId) {
    return GaussFirstRuntimeSmokeResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeStartupAttempted: false,
      dummyInputBridgeAttempted: false,
      modelFormatProbeAttempted: false,
      imageToLatexInferenceAttempted: false,
      latencyMs: 0,
      peakMemoryMb: 0,
      errorCode: 'runtimeFeatureFlagOff',
      warnings: const <String>['Q282 runtime smoke remains default-off until real device evidence and explicit approval exist.'],
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussFirstRuntimeSmokeResultEnvelope.blockedUnsafeEnvelope(String requestId) {
    return GaussFirstRuntimeSmokeResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeStartupAttempted: false,
      dummyInputBridgeAttempted: false,
      modelFormatProbeAttempted: false,
      imageToLatexInferenceAttempted: false,
      latencyMs: 0,
      peakMemoryMb: 0,
      errorCode: 'invalidDummyInputEnvelope',
      warnings: const <String>['Q282 requires private storage, accepted SHA256, supported ABI, review-only mode, and bounded dummy input before any future smoke can run.'],
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussFirstRuntimeSmokeResultEnvelope.blockedNoRealRuntimeSmokeExecuted(String requestId) {
    return GaussFirstRuntimeSmokeResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeStartupAttempted: false,
      dummyInputBridgeAttempted: false,
      modelFormatProbeAttempted: false,
      imageToLatexInferenceAttempted: false,
      latencyMs: 0,
      peakMemoryMb: 0,
      errorCode: 'noRealRuntimeSmokeExecutedInQ282',
      warnings: const <String>['Q282 defines the first real runtime smoke device court envelope only; no Paddle runtime or inference path is executed in this package.'],
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  final String requestId;
  final String status;
  final bool runtimeStartupAttempted;
  final bool dummyInputBridgeAttempted;
  final bool modelFormatProbeAttempted;
  final bool imageToLatexInferenceAttempted;
  final int latencyMs;
  final int peakMemoryMb;
  final String errorCode;
  final List<String> warnings;
  final bool reviewRequired;
  final bool directWorkspaceMutationAttempted;

  bool get canProceedToImageToLatexCourt => false;
  bool get canImportToWorkspace => false;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussFirstRealRuntimeSmokeOnDevice {
  const GaussFirstRealRuntimeSmokeOnDevice._();

  static GaussFirstRealRuntimeSmokeOnDeviceResult evaluate(GaussFirstRealRuntimeSmokeOnDeviceInput input) {
    GaussFirstRealRuntimeSmokeOnDeviceResult reject(GaussFirstRealRuntimeSmokeOnDeviceDecision decision, String reason) {
      return GaussFirstRealRuntimeSmokeOnDeviceResult._(
        decision: decision,
        runtimeSmokeStaticReady: false,
        readyForQ283ImageToLatexInferenceCourtOnly: false,
        rejectionReasons: <String>[reason],
        canStartRealRuntimeInQ282: false,
        canRunDummyInputBridgeInQ282: false,
        canRunImageToLatexInQ282: false,
        canImportCameraOutputWithoutReview: false,
        canClaimRuntimeSmokePassInQ282: false,
        canClaimOcrPassInQ282: false,
        evidenceLabel: input.evidenceLabel,
      );
    }

    if (!input.q281PrivateArtifactLoadSmokePresent) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedMissingQ281PrivateArtifactLoadSmoke, 'missingQ281PrivateArtifactLoadSmoke');
    }
    if (!input.q280NativeRuntimeBridgePresent || !input.q279DependencyTrialPresent || !input.q278EvidenceLockPresent) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedMissingRuntimeEvidenceChain, 'missingQ280BridgeQ279TrialOrQ278EvidenceLock');
    }
    if (!input.verifiedPrivateArtifactEvidenceAccepted || !input.privateAppStoragePathVerified || !input.acceptedShaIsValid) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedMissingDeviceEvidence, 'missingPrivateArtifactPathOrAcceptedShaEvidence');
    }
    if (!input.modelFormatProbeEvidenceRequired || !input.runtimeStartupEvidenceRequired || !input.dummyInputOnlyBridgeEvidenceRequired || !input.runtimeFeatureFlagDefaultOffUntilEvidence) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedInvalidDummyInputEnvelope, 'missingModelFormatRuntimeStartupDummyInputOrFlagBoundary');
    }
    if (!input.timeoutCancellationEvidenceRequired || !input.memoryPressureEvidenceRequired || !input.latencyMeasurementEvidenceRequired || !input.realDeviceFlutterRunEvidenceRequired) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedMissingDeviceEvidence, 'missingRuntimeSmokeDeviceBudgetOrFlutterRunEvidence');
    }
    if (!input.reviewOnlyModeRequired || !input.editableMathLiveReviewRequired || !input.explicitUserApprovalRequiredBeforeWorkspaceImport) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedMissingReviewApprovalBoundary, 'missingMathLiveReviewOrUserApprovalBoundary');
    }
    if (!input.directSolveGraphSolutionHistoryBlocked) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedDirectSolveGraphSolutionHistoryRisk, 'directSolveGraphSolutionHistoryRisk');
    }
    if (!input.noRealRuntimeStartedInQ282 || !input.noRealDummyInputBridgeExecutedInQ282 || !input.noRealModelFormatProbeExecutedInQ282 || !input.noNativeRuntimeBridgeInvokedInQ282 || !input.noNativeHandlerImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noPaddleRuntimeAdded || !input.noPaddleOcrDependencyAdded || !input.noRuntimeDependencyAddedToPubspec || !input.noGradleNativeRuntimeDependencyAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noProductionDownloadEnabled || !input.noRealNetworkDownloadWorkerImplemented || !input.noImageToLatexInferenceExecuted || input.runtimeSmokePassClaimed || input.ocrPassClaimed || input.releasePassClaimed) {
      return reject(GaussFirstRealRuntimeSmokeOnDeviceDecision.blockedUnsafeRuntimeOrInferenceAdded, 'unsafeRuntimeInferenceOrPassClaim');
    }

    return GaussFirstRealRuntimeSmokeOnDeviceResult._(
      decision: GaussFirstRealRuntimeSmokeOnDeviceDecision.readyForQ283ImageToLatexInferenceCourtOnly,
      runtimeSmokeStaticReady: true,
      readyForQ283ImageToLatexInferenceCourtOnly: true,
      rejectionReasons: const <String>[],
      canStartRealRuntimeInQ282: false,
      canRunDummyInputBridgeInQ282: false,
      canRunImageToLatexInQ282: false,
      canImportCameraOutputWithoutReview: false,
      canClaimRuntimeSmokePassInQ282: false,
      canClaimOcrPassInQ282: false,
      evidenceLabel: input.evidenceLabel,
    );
  }

  static GaussFirstRuntimeSmokeResultEnvelope guardedRuntimeSmoke(GaussFirstRuntimeSmokeRequestEnvelope request) {
    if (!request.runtimeFeatureFlagEnabled) {
      return GaussFirstRuntimeSmokeResultEnvelope.blockedFlagOff(request.requestId);
    }
    if (!request.isSafeDummySmokeEnvelope) {
      return GaussFirstRuntimeSmokeResultEnvelope.blockedUnsafeEnvelope(request.requestId);
    }
    return GaussFirstRuntimeSmokeResultEnvelope.blockedNoRealRuntimeSmokeExecuted(request.requestId);
  }
}
