import 'gauss_real_private_artifact_load_smoke_policy.dart';

enum GaussRealPrivateArtifactLoadSmokeDecision {
  loadSmokeContractReadyRealLoadBlocked,
  blockedIfPrivateArtifactLoadRuntimeOrPassClaimAdded,
}

class GaussRealPrivateArtifactLoadSmokeResult {
  const GaussRealPrivateArtifactLoadSmokeResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.loadFeatureFlag,
    required this.verifiedPrivateArtifactState,
    required this.artifactAcceptanceDecision,
    required this.privateArtifactRootPolicy,
    required this.privateArtifactLoadSmokePreconditions,
    required this.privateArtifactLoadRequestFields,
    required this.privateArtifactLoadResultFields,
    required this.artifactLoadErrorCodes,
    required this.decision,
    required this.loadFeatureFlagEnabledByDefault,
    required this.realPrivateArtifactFileLoaded,
    required this.modelFormatProbeExecuted,
    required this.nativeRuntimeBridgeInvoked,
    required this.runtimeInvocationEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.imageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String loadFeatureFlag;
  final String verifiedPrivateArtifactState;
  final String artifactAcceptanceDecision;
  final String privateArtifactRootPolicy;
  final List<String> privateArtifactLoadSmokePreconditions;
  final List<String> privateArtifactLoadRequestFields;
  final List<String> privateArtifactLoadResultFields;
  final List<String> artifactLoadErrorCodes;
  final GaussRealPrivateArtifactLoadSmokeDecision decision;
  final bool loadFeatureFlagEnabledByDefault;
  final bool realPrivateArtifactFileLoaded;
  final bool modelFormatProbeExecuted;
  final bool nativeRuntimeBridgeInvoked;
  final bool runtimeInvocationEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool imageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussRealPrivateArtifactLoadRequestEnvelope {
  const GaussRealPrivateArtifactLoadRequestEnvelope({
    required this.requestId,
    required this.engineLabel,
    required this.verifiedPrivatePath,
    required this.expectedSha256,
    required this.actualSha256,
    required this.artifactSizeBytes,
    required this.androidAbi,
    required this.timeoutMs,
    required this.loadFeatureFlagEnabled,
    required this.privateStoragePathVerified,
    required this.checksumStatus,
    required this.atomicMoveStatus,
    this.dummyInputOnly = true,
  });

  final String requestId;
  final String engineLabel;
  final String verifiedPrivatePath;
  final String expectedSha256;
  final String actualSha256;
  final int artifactSizeBytes;
  final String androidAbi;
  final int timeoutMs;
  final bool loadFeatureFlagEnabled;
  final bool privateStoragePathVerified;
  final String checksumStatus;
  final String atomicMoveStatus;
  final bool dummyInputOnly;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get hasValidExpectedSha256 => isSha256(expectedSha256);
  bool get hasValidActualSha256 => isSha256(actualSha256);
  bool get shaMatches => hasValidExpectedSha256 && hasValidActualSha256 && expectedSha256.toLowerCase() == actualSha256.toLowerCase();
  bool get isPrivateStoragePath => verifiedPrivatePath.contains('/files/models/') || verifiedPrivatePath.contains('\\files\\models\\');
  bool get checksumPassed => checksumStatus == 'passed' && atomicMoveStatus == 'completed';
  bool get withinSizeBudget => artifactSizeBytes > 0 && artifactSizeBytes <= GaussRealPrivateArtifactLoadSmokePolicy.maxArtifactSizeBudgetMb * 1024 * 1024;
  bool get supportedAbi => androidAbi == 'arm64-v8a' || androidAbi == 'armeabi-v7a' || androidAbi == 'x86_64';
  bool get withinTimeoutBudget => timeoutMs > 0 && timeoutMs <= GaussRealPrivateArtifactLoadSmokePolicy.loadTimeoutBudgetMs;
}

class GaussRealPrivateArtifactLoadResultEnvelope {
  const GaussRealPrivateArtifactLoadResultEnvelope._({
    required this.requestId,
    required this.status,
    required this.artifactPathAccepted,
    required this.shaMatch,
    required this.realFileLoadExecuted,
    required this.modelFormatProbeExecuted,
    required this.runtimeBridgeInvoked,
    required this.errorCode,
    required this.warnings,
    required this.latencyMs,
    required this.reviewRequired,
    required this.directWorkspaceMutationAttempted,
  });

  factory GaussRealPrivateArtifactLoadResultEnvelope.blockedFlagOff(String requestId) {
    return GaussRealPrivateArtifactLoadResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      artifactPathAccepted: false,
      shaMatch: false,
      realFileLoadExecuted: false,
      modelFormatProbeExecuted: false,
      runtimeBridgeInvoked: false,
      errorCode: 'loadFeatureFlagOff',
      warnings: const <String>['Q292 private artifact load smoke remains default-off; no file load was executed.'],
      latencyMs: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussRealPrivateArtifactLoadResultEnvelope.blockedShaMismatch(String requestId) {
    return GaussRealPrivateArtifactLoadResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      artifactPathAccepted: false,
      shaMatch: false,
      realFileLoadExecuted: false,
      modelFormatProbeExecuted: false,
      runtimeBridgeInvoked: false,
      errorCode: 'artifactShaMismatch',
      warnings: const <String>['Expected and actual private artifact SHA256 values do not match.'],
      latencyMs: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussRealPrivateArtifactLoadResultEnvelope.blockedNoRealLoadExecuted(String requestId) {
    return GaussRealPrivateArtifactLoadResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      artifactPathAccepted: true,
      shaMatch: true,
      realFileLoadExecuted: false,
      modelFormatProbeExecuted: false,
      runtimeBridgeInvoked: false,
      errorCode: 'noRealArtifactLoadExecutedInQ292',
      warnings: const <String>['Q292 defines the guarded private artifact load smoke boundary; real artifact load requires user-side verified artifact evidence.'],
      latencyMs: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  final String requestId;
  final String status;
  final bool artifactPathAccepted;
  final bool shaMatch;
  final bool realFileLoadExecuted;
  final bool modelFormatProbeExecuted;
  final bool runtimeBridgeInvoked;
  final String errorCode;
  final List<String> warnings;
  final int latencyMs;
  final bool reviewRequired;
  final bool directWorkspaceMutationAttempted;

  bool get canProceedToRuntimeStartup => false;
  bool get canImportToWorkspace => false;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussRealPrivateArtifactLoadSmoke {
  const GaussRealPrivateArtifactLoadSmoke._();

  static GaussRealPrivateArtifactLoadSmokeResult evaluate() {
    const blocked =
        GaussRealPrivateArtifactLoadSmokePolicy.loadFeatureFlagEnabledByDefault ||
            GaussRealPrivateArtifactLoadSmokePolicy.realPrivateArtifactFileLoaded ||
            GaussRealPrivateArtifactLoadSmokePolicy.modelFormatProbeExecuted ||
            GaussRealPrivateArtifactLoadSmokePolicy.nativeRuntimeBridgeInvoked ||
            GaussRealPrivateArtifactLoadSmokePolicy.runtimeInvocationEnabled ||
            GaussRealPrivateArtifactLoadSmokePolicy.nativeHandlerImplementationAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.androidBindingImplementationAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.jniBindingAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.methodChannelRuntimeBindingAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.realOcrRuntimeAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.paddleRuntimeAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.paddleOcrDependencyAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.runtimeDependencyAddedToPubspec ||
            GaussRealPrivateArtifactLoadSmokePolicy.gradleNativeRuntimeDependencyAdded ||
            GaussRealPrivateArtifactLoadSmokePolicy.modelBinaryBundledInBaseApp ||
            GaussRealPrivateArtifactLoadSmokePolicy.productionModelUrlBound ||
            GaussRealPrivateArtifactLoadSmokePolicy.productionDownloadEnabled ||
            GaussRealPrivateArtifactLoadSmokePolicy.realNetworkDownloadWorkerImplemented ||
            GaussRealPrivateArtifactLoadSmokePolicy.imageToLatexInferenceExecuted ||
            GaussRealPrivateArtifactLoadSmokePolicy.directWorkspaceImportEnabled ||
            GaussRealPrivateArtifactLoadSmokePolicy.directSolveGraphSolutionHistoryEnabled ||
            GaussRealPrivateArtifactLoadSmokePolicy.privateArtifactLoadPassClaimed ||
            GaussRealPrivateArtifactLoadSmokePolicy.runtimeSmokePassClaimed ||
            GaussRealPrivateArtifactLoadSmokePolicy.modelFormatProbePassClaimed ||
            GaussRealPrivateArtifactLoadSmokePolicy.ocrPassClaimed ||
            GaussRealPrivateArtifactLoadSmokePolicy.cameraOcrRuntimePassClaimed ||
            GaussRealPrivateArtifactLoadSmokePolicy.storeReadyPassClaimed ||
            GaussRealPrivateArtifactLoadSmokePolicy.releasePassClaimed;

    return const GaussRealPrivateArtifactLoadSmokeResult(
      phase: GaussRealPrivateArtifactLoadSmokePolicy.phase,
      sourcePhase: GaussRealPrivateArtifactLoadSmokePolicy.sourcePhase,
      selectedEngineLabel: GaussRealPrivateArtifactLoadSmokePolicy.selectedEngineLabel,
      loadFeatureFlag: GaussRealPrivateArtifactLoadSmokePolicy.loadFeatureFlag,
      verifiedPrivateArtifactState: GaussRealPrivateArtifactLoadSmokePolicy.verifiedPrivateArtifactState,
      artifactAcceptanceDecision: GaussRealPrivateArtifactLoadSmokePolicy.artifactAcceptanceDecision,
      privateArtifactRootPolicy: GaussRealPrivateArtifactLoadSmokePolicy.privateArtifactRootPolicy,
      privateArtifactLoadSmokePreconditions: GaussRealPrivateArtifactLoadSmokePolicy.privateArtifactLoadSmokePreconditions,
      privateArtifactLoadRequestFields: GaussRealPrivateArtifactLoadSmokePolicy.privateArtifactLoadRequestFields,
      privateArtifactLoadResultFields: GaussRealPrivateArtifactLoadSmokePolicy.privateArtifactLoadResultFields,
      artifactLoadErrorCodes: GaussRealPrivateArtifactLoadSmokePolicy.artifactLoadErrorCodes,
      decision: blocked
          ? GaussRealPrivateArtifactLoadSmokeDecision.blockedIfPrivateArtifactLoadRuntimeOrPassClaimAdded
          : GaussRealPrivateArtifactLoadSmokeDecision.loadSmokeContractReadyRealLoadBlocked,
      loadFeatureFlagEnabledByDefault: GaussRealPrivateArtifactLoadSmokePolicy.loadFeatureFlagEnabledByDefault,
      realPrivateArtifactFileLoaded: GaussRealPrivateArtifactLoadSmokePolicy.realPrivateArtifactFileLoaded,
      modelFormatProbeExecuted: GaussRealPrivateArtifactLoadSmokePolicy.modelFormatProbeExecuted,
      nativeRuntimeBridgeInvoked: GaussRealPrivateArtifactLoadSmokePolicy.nativeRuntimeBridgeInvoked,
      runtimeInvocationEnabled: GaussRealPrivateArtifactLoadSmokePolicy.runtimeInvocationEnabled,
      modelBinaryBundledInBaseApp: GaussRealPrivateArtifactLoadSmokePolicy.modelBinaryBundledInBaseApp,
      imageToLatexInferenceExecuted: GaussRealPrivateArtifactLoadSmokePolicy.imageToLatexInferenceExecuted,
      ocrPassClaimed: GaussRealPrivateArtifactLoadSmokePolicy.ocrPassClaimed,
    );
  }

  static GaussRealPrivateArtifactLoadResultEnvelope guardedLoadSmoke(GaussRealPrivateArtifactLoadRequestEnvelope request) {
    if (!request.loadFeatureFlagEnabled) {
      return GaussRealPrivateArtifactLoadResultEnvelope.blockedFlagOff(request.requestId);
    }
    if (!request.privateStoragePathVerified || !request.isPrivateStoragePath || !request.withinSizeBudget || !request.supportedAbi || !request.withinTimeoutBudget || !request.checksumPassed) {
      return GaussRealPrivateArtifactLoadResultEnvelope.blockedShaMismatch(request.requestId);
    }
    if (!request.shaMatches) {
      return GaussRealPrivateArtifactLoadResultEnvelope.blockedShaMismatch(request.requestId);
    }
    return GaussRealPrivateArtifactLoadResultEnvelope.blockedNoRealLoadExecuted(request.requestId);
  }
}
