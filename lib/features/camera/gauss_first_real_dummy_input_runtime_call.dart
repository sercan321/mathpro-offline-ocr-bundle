import 'gauss_first_real_dummy_input_runtime_call_policy.dart';

enum GaussFirstRealDummyInputRuntimeCallDecision {
  dummyInputRuntimeCallContractReadyRealCallBlocked,
  blockedIfRuntimeCallOrPassClaimAdded,
}

class GaussFirstRealDummyInputRuntimeCallResult {
  const GaussFirstRealDummyInputRuntimeCallResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.dummyCallFeatureFlag,
    required this.dummyCallReadinessState,
    required this.runtimeInvocationDecision,
    required this.dummyInputRuntimeCallPreconditions,
    required this.dummyInputRuntimeCallRequestFields,
    required this.dummyInputRuntimeCallResultFields,
    required this.dummyInputRuntimeCallErrorCodes,
    required this.decision,
    required this.dummyCallFeatureFlagEnabledByDefault,
    required this.realDummyInputRuntimeCallExecuted,
    required this.nativeRuntimeStartupExecuted,
    required this.nativeRuntimeHandlerImplemented,
    required this.methodChannelRuntimeBindingAdded,
    required this.realPrivateArtifactFileLoaded,
    required this.modelFormatProbeExecuted,
    required this.dummyInputFixtureSentToNativeRuntime,
    required this.dummyRuntimeResponseParsed,
    required this.imageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String dummyCallFeatureFlag;
  final String dummyCallReadinessState;
  final String runtimeInvocationDecision;
  final List<String> dummyInputRuntimeCallPreconditions;
  final List<String> dummyInputRuntimeCallRequestFields;
  final List<String> dummyInputRuntimeCallResultFields;
  final List<String> dummyInputRuntimeCallErrorCodes;
  final GaussFirstRealDummyInputRuntimeCallDecision decision;
  final bool dummyCallFeatureFlagEnabledByDefault;
  final bool realDummyInputRuntimeCallExecuted;
  final bool nativeRuntimeStartupExecuted;
  final bool nativeRuntimeHandlerImplemented;
  final bool methodChannelRuntimeBindingAdded;
  final bool realPrivateArtifactFileLoaded;
  final bool modelFormatProbeExecuted;
  final bool dummyInputFixtureSentToNativeRuntime;
  final bool dummyRuntimeResponseParsed;
  final bool imageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussDummyInputRuntimeCallRequestEnvelope {
  const GaussDummyInputRuntimeCallRequestEnvelope({
    required this.requestId,
    required this.engineLabel,
    required this.runtimeSessionId,
    required this.verifiedPrivateArtifactPath,
    required this.expectedSha256,
    required this.actualSha256,
    required this.androidAbi,
    required this.dummyInputFixtureId,
    required this.dummyInputPayloadHash,
    required this.timeoutMs,
    required this.dummyCallFeatureFlagEnabled,
    required this.runtimeStartupStatus,
    required this.methodChannelBindingStatus,
    required this.nativeHandlerStatus,
    this.callMode = 'dummy-input-only-no-camera-image-no-latex-inference',
  });

  final String requestId;
  final String engineLabel;
  final String runtimeSessionId;
  final String verifiedPrivateArtifactPath;
  final String expectedSha256;
  final String actualSha256;
  final String androidAbi;
  final String dummyInputFixtureId;
  final String dummyInputPayloadHash;
  final int timeoutMs;
  final bool dummyCallFeatureFlagEnabled;
  final String runtimeStartupStatus;
  final String methodChannelBindingStatus;
  final String nativeHandlerStatus;
  final String callMode;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get hasValidExpectedSha256 => isSha256(expectedSha256);
  bool get hasValidActualSha256 => isSha256(actualSha256);
  bool get shaMatches => hasValidExpectedSha256 && hasValidActualSha256 && expectedSha256.toLowerCase() == actualSha256.toLowerCase();
  bool get isPrivateStoragePath => verifiedPrivateArtifactPath.contains('/files/models/') || verifiedPrivateArtifactPath.contains('\\files\\models\\');
  bool get supportedAbi => androidAbi == 'arm64-v8a' || androidAbi == 'armeabi-v7a' || androidAbi == 'x86_64';
  bool get runtimeStartupPassed => runtimeStartupStatus == 'passed';
  bool get methodChannelBindingPassed => methodChannelBindingStatus == 'passed';
  bool get nativeHandlerPassed => nativeHandlerStatus == 'passed';
  bool get hasDummyFixture => dummyInputFixtureId.isNotEmpty;
  bool get hasDummyPayloadHash => isSha256(dummyInputPayloadHash);
  bool get withinTimeoutBudget => timeoutMs > 0 && timeoutMs <= GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputTimeoutBudgetMs;
}

class GaussDummyInputRuntimeCallResultEnvelope {
  const GaussDummyInputRuntimeCallResultEnvelope._({
    required this.requestId,
    required this.status,
    required this.runtimeSessionUsed,
    required this.dummyInputSent,
    required this.nativeRuntimeInvoked,
    required this.dummyResponseParsed,
    required this.imageInferenceExecuted,
    required this.errorCode,
    required this.warnings,
    required this.dummyCallLatencyMs,
    required this.peakMemoryMb,
    required this.reviewRequired,
    required this.directWorkspaceMutationAttempted,
  });

  factory GaussDummyInputRuntimeCallResultEnvelope.blockedFlagOff(String requestId) {
    return GaussDummyInputRuntimeCallResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeSessionUsed: false,
      dummyInputSent: false,
      nativeRuntimeInvoked: false,
      dummyResponseParsed: false,
      imageInferenceExecuted: false,
      errorCode: 'dummyCallFeatureFlagOff',
      warnings: const <String>['Q294 dummy-input runtime call remains default-off; no runtime call was executed.'],
      dummyCallLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussDummyInputRuntimeCallResultEnvelope.blockedMissingEvidence(String requestId, String errorCode) {
    return GaussDummyInputRuntimeCallResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeSessionUsed: false,
      dummyInputSent: false,
      nativeRuntimeInvoked: false,
      dummyResponseParsed: false,
      imageInferenceExecuted: false,
      errorCode: errorCode,
      warnings: const <String>['Runtime startup, MethodChannel binding, native handler, verified artifact, and deterministic dummy fixture evidence are required before any dummy input runtime call.'],
      dummyCallLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussDummyInputRuntimeCallResultEnvelope.blockedNoRealDummyCallExecuted(String requestId) {
    return GaussDummyInputRuntimeCallResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeSessionUsed: true,
      dummyInputSent: false,
      nativeRuntimeInvoked: false,
      dummyResponseParsed: false,
      imageInferenceExecuted: false,
      errorCode: 'noRealDummyInputRuntimeCallExecutedInQ294',
      warnings: const <String>['Q294 defines the guarded first dummy-input runtime call boundary; no MethodChannel/JNI/native runtime invocation is executed in this package.'],
      dummyCallLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  final String requestId;
  final String status;
  final bool runtimeSessionUsed;
  final bool dummyInputSent;
  final bool nativeRuntimeInvoked;
  final bool dummyResponseParsed;
  final bool imageInferenceExecuted;
  final String errorCode;
  final List<String> warnings;
  final int dummyCallLatencyMs;
  final int peakMemoryMb;
  final bool reviewRequired;
  final bool directWorkspaceMutationAttempted;

  bool get canProceedToImageInference => false;
  bool get canImportToWorkspace => false;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussFirstRealDummyInputRuntimeCall {
  const GaussFirstRealDummyInputRuntimeCall._();

  static GaussFirstRealDummyInputRuntimeCallResult evaluate() {
    const blocked =
        GaussFirstRealDummyInputRuntimeCallPolicy.dummyCallFeatureFlagEnabledByDefault ||
            GaussFirstRealDummyInputRuntimeCallPolicy.realDummyInputRuntimeCallExecuted ||
            GaussFirstRealDummyInputRuntimeCallPolicy.nativeRuntimeStartupExecuted ||
            GaussFirstRealDummyInputRuntimeCallPolicy.nativeRuntimeHandlerImplemented ||
            GaussFirstRealDummyInputRuntimeCallPolicy.methodChannelRuntimeBindingAdded ||
            GaussFirstRealDummyInputRuntimeCallPolicy.jniBindingAdded ||
            GaussFirstRealDummyInputRuntimeCallPolicy.paddleRuntimeAdded ||
            GaussFirstRealDummyInputRuntimeCallPolicy.paddleOcrDependencyAdded ||
            GaussFirstRealDummyInputRuntimeCallPolicy.runtimeDependencyAddedToPubspec ||
            GaussFirstRealDummyInputRuntimeCallPolicy.gradleNativeRuntimeDependencyAdded ||
            GaussFirstRealDummyInputRuntimeCallPolicy.realPrivateArtifactFileLoaded ||
            GaussFirstRealDummyInputRuntimeCallPolicy.modelFormatProbeExecuted ||
            GaussFirstRealDummyInputRuntimeCallPolicy.runtimeWarmupCallExecuted ||
            GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputFixtureSentToNativeRuntime ||
            GaussFirstRealDummyInputRuntimeCallPolicy.dummyRuntimeResponseParsed ||
            GaussFirstRealDummyInputRuntimeCallPolicy.imageToLatexInferenceExecuted ||
            GaussFirstRealDummyInputRuntimeCallPolicy.cameraImageUsedAsInput ||
            GaussFirstRealDummyInputRuntimeCallPolicy.modelBinaryBundledInBaseApp ||
            GaussFirstRealDummyInputRuntimeCallPolicy.productionDownloadEnabled ||
            GaussFirstRealDummyInputRuntimeCallPolicy.directWorkspaceImportEnabled ||
            GaussFirstRealDummyInputRuntimeCallPolicy.directSolveGraphSolutionHistoryEnabled ||
            GaussFirstRealDummyInputRuntimeCallPolicy.runtimeDummyCallPassClaimed ||
            GaussFirstRealDummyInputRuntimeCallPolicy.ocrPassClaimed ||
            GaussFirstRealDummyInputRuntimeCallPolicy.cameraOcrRuntimePassClaimed ||
            GaussFirstRealDummyInputRuntimeCallPolicy.storeReadyPassClaimed ||
            GaussFirstRealDummyInputRuntimeCallPolicy.releasePassClaimed;

    return const GaussFirstRealDummyInputRuntimeCallResult(
      phase: GaussFirstRealDummyInputRuntimeCallPolicy.phase,
      sourcePhase: GaussFirstRealDummyInputRuntimeCallPolicy.sourcePhase,
      selectedEngineLabel: GaussFirstRealDummyInputRuntimeCallPolicy.selectedEngineLabel,
      dummyCallFeatureFlag: GaussFirstRealDummyInputRuntimeCallPolicy.dummyCallFeatureFlag,
      dummyCallReadinessState: GaussFirstRealDummyInputRuntimeCallPolicy.dummyCallReadinessState,
      runtimeInvocationDecision: GaussFirstRealDummyInputRuntimeCallPolicy.runtimeInvocationDecision,
      dummyInputRuntimeCallPreconditions: GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputRuntimeCallPreconditions,
      dummyInputRuntimeCallRequestFields: GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputRuntimeCallRequestFields,
      dummyInputRuntimeCallResultFields: GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputRuntimeCallResultFields,
      dummyInputRuntimeCallErrorCodes: GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputRuntimeCallErrorCodes,
      decision: blocked
          ? GaussFirstRealDummyInputRuntimeCallDecision.blockedIfRuntimeCallOrPassClaimAdded
          : GaussFirstRealDummyInputRuntimeCallDecision.dummyInputRuntimeCallContractReadyRealCallBlocked,
      dummyCallFeatureFlagEnabledByDefault: GaussFirstRealDummyInputRuntimeCallPolicy.dummyCallFeatureFlagEnabledByDefault,
      realDummyInputRuntimeCallExecuted: GaussFirstRealDummyInputRuntimeCallPolicy.realDummyInputRuntimeCallExecuted,
      nativeRuntimeStartupExecuted: GaussFirstRealDummyInputRuntimeCallPolicy.nativeRuntimeStartupExecuted,
      nativeRuntimeHandlerImplemented: GaussFirstRealDummyInputRuntimeCallPolicy.nativeRuntimeHandlerImplemented,
      methodChannelRuntimeBindingAdded: GaussFirstRealDummyInputRuntimeCallPolicy.methodChannelRuntimeBindingAdded,
      realPrivateArtifactFileLoaded: GaussFirstRealDummyInputRuntimeCallPolicy.realPrivateArtifactFileLoaded,
      modelFormatProbeExecuted: GaussFirstRealDummyInputRuntimeCallPolicy.modelFormatProbeExecuted,
      dummyInputFixtureSentToNativeRuntime: GaussFirstRealDummyInputRuntimeCallPolicy.dummyInputFixtureSentToNativeRuntime,
      dummyRuntimeResponseParsed: GaussFirstRealDummyInputRuntimeCallPolicy.dummyRuntimeResponseParsed,
      imageToLatexInferenceExecuted: GaussFirstRealDummyInputRuntimeCallPolicy.imageToLatexInferenceExecuted,
      ocrPassClaimed: GaussFirstRealDummyInputRuntimeCallPolicy.ocrPassClaimed,
    );
  }

  static GaussDummyInputRuntimeCallResultEnvelope guardedDummyInputCall(GaussDummyInputRuntimeCallRequestEnvelope request) {
    if (!request.dummyCallFeatureFlagEnabled) {
      return GaussDummyInputRuntimeCallResultEnvelope.blockedFlagOff(request.requestId);
    }
    if (!request.runtimeStartupPassed) {
      return GaussDummyInputRuntimeCallResultEnvelope.blockedMissingEvidence(request.requestId, 'runtimeStartupMissing');
    }
    if (!request.methodChannelBindingPassed) {
      return GaussDummyInputRuntimeCallResultEnvelope.blockedMissingEvidence(request.requestId, 'methodChannelNotBound');
    }
    if (!request.nativeHandlerPassed) {
      return GaussDummyInputRuntimeCallResultEnvelope.blockedMissingEvidence(request.requestId, 'nativeHandlerNotImplemented');
    }
    if (!request.isPrivateStoragePath || !request.shaMatches) {
      return GaussDummyInputRuntimeCallResultEnvelope.blockedMissingEvidence(request.requestId, 'artifactShaMismatch');
    }
    if (!request.supportedAbi || !request.hasDummyFixture || !request.hasDummyPayloadHash || !request.withinTimeoutBudget) {
      return GaussDummyInputRuntimeCallResultEnvelope.blockedMissingEvidence(request.requestId, 'dummyInputFixtureMissing');
    }
    return GaussDummyInputRuntimeCallResultEnvelope.blockedNoRealDummyCallExecuted(request.requestId);
  }
}
