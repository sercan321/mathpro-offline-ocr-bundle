import 'gauss_first_real_runtime_startup_smoke_policy.dart';

enum GaussFirstRealRuntimeStartupSmokeDecision {
  startupSmokeContractReadyRealStartupBlocked,
  blockedIfRuntimeStartupOrPassClaimAdded,
}

class GaussFirstRealRuntimeStartupSmokeResult {
  const GaussFirstRealRuntimeStartupSmokeResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.startupFeatureFlag,
    required this.startupReadinessState,
    required this.runtimeActivationDecision,
    required this.runtimeStartupSmokePreconditions,
    required this.runtimeStartupRequestFields,
    required this.runtimeStartupResultFields,
    required this.runtimeStartupErrorCodes,
    required this.decision,
    required this.startupFeatureFlagEnabledByDefault,
    required this.realRuntimeStartupExecuted,
    required this.nativeRuntimeHandlerImplemented,
    required this.methodChannelRuntimeBindingAdded,
    required this.realPrivateArtifactFileLoaded,
    required this.modelFormatProbeExecuted,
    required this.runtimeWarmupCallExecuted,
    required this.imageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String startupFeatureFlag;
  final String startupReadinessState;
  final String runtimeActivationDecision;
  final List<String> runtimeStartupSmokePreconditions;
  final List<String> runtimeStartupRequestFields;
  final List<String> runtimeStartupResultFields;
  final List<String> runtimeStartupErrorCodes;
  final GaussFirstRealRuntimeStartupSmokeDecision decision;
  final bool startupFeatureFlagEnabledByDefault;
  final bool realRuntimeStartupExecuted;
  final bool nativeRuntimeHandlerImplemented;
  final bool methodChannelRuntimeBindingAdded;
  final bool realPrivateArtifactFileLoaded;
  final bool modelFormatProbeExecuted;
  final bool runtimeWarmupCallExecuted;
  final bool imageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussRuntimeStartupRequestEnvelope {
  const GaussRuntimeStartupRequestEnvelope({
    required this.requestId,
    required this.engineLabel,
    required this.verifiedPrivateArtifactPath,
    required this.expectedSha256,
    required this.actualSha256,
    required this.runtimePackageId,
    required this.androidAbi,
    required this.startupTimeoutMs,
    required this.startupFeatureFlagEnabled,
    required this.modelFormatProbeStatus,
    required this.privateArtifactLoadStatus,
    this.startupMode = 'startup-smoke-only-no-inference',
  });

  final String requestId;
  final String engineLabel;
  final String verifiedPrivateArtifactPath;
  final String expectedSha256;
  final String actualSha256;
  final String runtimePackageId;
  final String androidAbi;
  final int startupTimeoutMs;
  final bool startupFeatureFlagEnabled;
  final String modelFormatProbeStatus;
  final String privateArtifactLoadStatus;
  final String startupMode;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get hasValidExpectedSha256 => isSha256(expectedSha256);
  bool get hasValidActualSha256 => isSha256(actualSha256);
  bool get shaMatches => hasValidExpectedSha256 && hasValidActualSha256 && expectedSha256.toLowerCase() == actualSha256.toLowerCase();
  bool get isPrivateStoragePath => verifiedPrivateArtifactPath.contains('/files/models/') || verifiedPrivateArtifactPath.contains('\\files\\models\\');
  bool get privateArtifactLoadPassed => privateArtifactLoadStatus == 'passed';
  bool get modelFormatProbePassed => modelFormatProbeStatus == 'passed';
  bool get supportedAbi => androidAbi == 'arm64-v8a' || androidAbi == 'armeabi-v7a' || androidAbi == 'x86_64';
  bool get withinStartupTimeoutBudget => startupTimeoutMs > 0 && startupTimeoutMs <= GaussFirstRealRuntimeStartupSmokePolicy.startupTimeoutBudgetMs;
}

class GaussRuntimeStartupResultEnvelope {
  const GaussRuntimeStartupResultEnvelope._({
    required this.requestId,
    required this.status,
    required this.runtimeProcessStarted,
    required this.modelArtifactOpened,
    required this.modelFormatProbePassed,
    required this.warmupCallExecuted,
    required this.imageInferenceExecuted,
    required this.errorCode,
    required this.warnings,
    required this.startupLatencyMs,
    required this.peakMemoryMb,
    required this.reviewRequired,
    required this.directWorkspaceMutationAttempted,
  });

  factory GaussRuntimeStartupResultEnvelope.blockedFlagOff(String requestId) {
    return GaussRuntimeStartupResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeProcessStarted: false,
      modelArtifactOpened: false,
      modelFormatProbePassed: false,
      warmupCallExecuted: false,
      imageInferenceExecuted: false,
      errorCode: 'startupFeatureFlagOff',
      warnings: const <String>['Q293 runtime startup smoke remains default-off; no runtime startup was executed.'],
      startupLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(String requestId, String errorCode) {
    return GaussRuntimeStartupResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeProcessStarted: false,
      modelArtifactOpened: false,
      modelFormatProbePassed: false,
      warmupCallExecuted: false,
      imageInferenceExecuted: false,
      errorCode: errorCode,
      warnings: const <String>['Verified artifact load, model format probe, native runtime package, and real-device startup evidence are required before runtime startup.'],
      startupLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussRuntimeStartupResultEnvelope.blockedNoRealStartupExecuted(String requestId) {
    return GaussRuntimeStartupResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeProcessStarted: false,
      modelArtifactOpened: true,
      modelFormatProbePassed: true,
      warmupCallExecuted: false,
      imageInferenceExecuted: false,
      errorCode: 'noRealRuntimeStartupExecutedInQ293',
      warnings: const <String>['Q293 defines the guarded first runtime startup smoke boundary; no native runtime process is started in this package.'],
      startupLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  final String requestId;
  final String status;
  final bool runtimeProcessStarted;
  final bool modelArtifactOpened;
  final bool modelFormatProbePassed;
  final bool warmupCallExecuted;
  final bool imageInferenceExecuted;
  final String errorCode;
  final List<String> warnings;
  final int startupLatencyMs;
  final int peakMemoryMb;
  final bool reviewRequired;
  final bool directWorkspaceMutationAttempted;

  bool get canProceedToImageInference => false;
  bool get canImportToWorkspace => false;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussFirstRealRuntimeStartupSmoke {
  const GaussFirstRealRuntimeStartupSmoke._();

  static GaussFirstRealRuntimeStartupSmokeResult evaluate() {
    const blocked =
        GaussFirstRealRuntimeStartupSmokePolicy.startupFeatureFlagEnabledByDefault ||
            GaussFirstRealRuntimeStartupSmokePolicy.realRuntimeStartupExecuted ||
            GaussFirstRealRuntimeStartupSmokePolicy.nativeRuntimePackageBundled ||
            GaussFirstRealRuntimeStartupSmokePolicy.nativeRuntimeHandlerImplemented ||
            GaussFirstRealRuntimeStartupSmokePolicy.methodChannelRuntimeBindingAdded ||
            GaussFirstRealRuntimeStartupSmokePolicy.jniBindingAdded ||
            GaussFirstRealRuntimeStartupSmokePolicy.paddleRuntimeAdded ||
            GaussFirstRealRuntimeStartupSmokePolicy.paddleOcrDependencyAdded ||
            GaussFirstRealRuntimeStartupSmokePolicy.runtimeDependencyAddedToPubspec ||
            GaussFirstRealRuntimeStartupSmokePolicy.gradleNativeRuntimeDependencyAdded ||
            GaussFirstRealRuntimeStartupSmokePolicy.realPrivateArtifactFileLoaded ||
            GaussFirstRealRuntimeStartupSmokePolicy.modelFormatProbeExecuted ||
            GaussFirstRealRuntimeStartupSmokePolicy.runtimeWarmupCallExecuted ||
            GaussFirstRealRuntimeStartupSmokePolicy.imageToLatexInferenceExecuted ||
            GaussFirstRealRuntimeStartupSmokePolicy.modelBinaryBundledInBaseApp ||
            GaussFirstRealRuntimeStartupSmokePolicy.productionDownloadEnabled ||
            GaussFirstRealRuntimeStartupSmokePolicy.directWorkspaceImportEnabled ||
            GaussFirstRealRuntimeStartupSmokePolicy.directSolveGraphSolutionHistoryEnabled ||
            GaussFirstRealRuntimeStartupSmokePolicy.runtimeStartupPassClaimed ||
            GaussFirstRealRuntimeStartupSmokePolicy.runtimeSmokePassClaimed ||
            GaussFirstRealRuntimeStartupSmokePolicy.ocrPassClaimed ||
            GaussFirstRealRuntimeStartupSmokePolicy.cameraOcrRuntimePassClaimed ||
            GaussFirstRealRuntimeStartupSmokePolicy.storeReadyPassClaimed ||
            GaussFirstRealRuntimeStartupSmokePolicy.releasePassClaimed;

    return const GaussFirstRealRuntimeStartupSmokeResult(
      phase: GaussFirstRealRuntimeStartupSmokePolicy.phase,
      sourcePhase: GaussFirstRealRuntimeStartupSmokePolicy.sourcePhase,
      selectedEngineLabel: GaussFirstRealRuntimeStartupSmokePolicy.selectedEngineLabel,
      startupFeatureFlag: GaussFirstRealRuntimeStartupSmokePolicy.startupFeatureFlag,
      startupReadinessState: GaussFirstRealRuntimeStartupSmokePolicy.startupReadinessState,
      runtimeActivationDecision: GaussFirstRealRuntimeStartupSmokePolicy.runtimeActivationDecision,
      runtimeStartupSmokePreconditions: GaussFirstRealRuntimeStartupSmokePolicy.runtimeStartupSmokePreconditions,
      runtimeStartupRequestFields: GaussFirstRealRuntimeStartupSmokePolicy.runtimeStartupRequestFields,
      runtimeStartupResultFields: GaussFirstRealRuntimeStartupSmokePolicy.runtimeStartupResultFields,
      runtimeStartupErrorCodes: GaussFirstRealRuntimeStartupSmokePolicy.runtimeStartupErrorCodes,
      decision: blocked
          ? GaussFirstRealRuntimeStartupSmokeDecision.blockedIfRuntimeStartupOrPassClaimAdded
          : GaussFirstRealRuntimeStartupSmokeDecision.startupSmokeContractReadyRealStartupBlocked,
      startupFeatureFlagEnabledByDefault: GaussFirstRealRuntimeStartupSmokePolicy.startupFeatureFlagEnabledByDefault,
      realRuntimeStartupExecuted: GaussFirstRealRuntimeStartupSmokePolicy.realRuntimeStartupExecuted,
      nativeRuntimeHandlerImplemented: GaussFirstRealRuntimeStartupSmokePolicy.nativeRuntimeHandlerImplemented,
      methodChannelRuntimeBindingAdded: GaussFirstRealRuntimeStartupSmokePolicy.methodChannelRuntimeBindingAdded,
      realPrivateArtifactFileLoaded: GaussFirstRealRuntimeStartupSmokePolicy.realPrivateArtifactFileLoaded,
      modelFormatProbeExecuted: GaussFirstRealRuntimeStartupSmokePolicy.modelFormatProbeExecuted,
      runtimeWarmupCallExecuted: GaussFirstRealRuntimeStartupSmokePolicy.runtimeWarmupCallExecuted,
      imageToLatexInferenceExecuted: GaussFirstRealRuntimeStartupSmokePolicy.imageToLatexInferenceExecuted,
      ocrPassClaimed: GaussFirstRealRuntimeStartupSmokePolicy.ocrPassClaimed,
    );
  }

  static GaussRuntimeStartupResultEnvelope guardedStartupSmoke(GaussRuntimeStartupRequestEnvelope request) {
    if (!request.startupFeatureFlagEnabled) {
      return GaussRuntimeStartupResultEnvelope.blockedFlagOff(request.requestId);
    }
    if (!request.isPrivateStoragePath) {
      return GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(request.requestId, 'verifiedArtifactMissing');
    }
    if (!request.shaMatches) {
      return GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(request.requestId, 'artifactShaMismatch');
    }
    if (!request.privateArtifactLoadPassed) {
      return GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(request.requestId, 'privateArtifactLoadMissing');
    }
    if (!request.modelFormatProbePassed) {
      return GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(request.requestId, 'modelFormatProbeMissing');
    }
    if (request.runtimePackageId.isEmpty) {
      return GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(request.requestId, 'nativeRuntimePackageMissing');
    }
    if (!request.supportedAbi) {
      return GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(request.requestId, 'unsupportedAbi');
    }
    if (!request.withinStartupTimeoutBudget) {
      return GaussRuntimeStartupResultEnvelope.blockedMissingEvidence(request.requestId, 'startupTimeout');
    }
    return GaussRuntimeStartupResultEnvelope.blockedNoRealStartupExecuted(request.requestId);
  }
}
