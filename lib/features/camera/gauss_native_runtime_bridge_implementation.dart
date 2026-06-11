import 'gauss_native_runtime_bridge_implementation_policy.dart';

enum GaussNativeRuntimeBridgeImplementationDecision {
  blockedMissingQ279DependencyTrial,
  blockedMissingQ278EvidenceLock,
  blockedMissingDefaultOffBridgeFlag,
  blockedBridgeFlagEnabledByDefault,
  blockedMissingRequestOrResponseEnvelope,
  blockedMissingTimeoutCancellationOrMemoryPolicy,
  blockedMissingReviewApprovalBoundary,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedUnsafeNativeRuntimeOrInferenceAdded,
  readyForQ281PrivateArtifactLoadSmokeGateOnly,
}

class GaussNativeRuntimeBridgeImplementationInput {
  const GaussNativeRuntimeBridgeImplementationInput({
    required this.q279DependencyTrialPresent,
    required this.q278EvidenceLockPresent,
    required this.defaultOffBridgeFeatureFlagRequired,
    required this.bridgeFeatureFlagEnabledByDefault,
    required this.runtimeInvocationBlockedWhenFlagOff,
    required this.methodChannelEnvelopeDeclared,
    required this.requestEnvelopeDocumented,
    required this.responseEnvelopeDocumented,
    required this.errorTaxonomyDocumented,
    required this.timeoutCancellationPolicyDocumented,
    required this.memoryPressurePolicyDocumented,
    required this.reviewOnlyModeRequired,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveGraphSolutionHistoryBlocked,
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
    required this.bridgeImplementationPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.releasePassClaimed,
    required this.evidenceLabel,
  });

  final bool q279DependencyTrialPresent;
  final bool q278EvidenceLockPresent;
  final bool defaultOffBridgeFeatureFlagRequired;
  final bool bridgeFeatureFlagEnabledByDefault;
  final bool runtimeInvocationBlockedWhenFlagOff;
  final bool methodChannelEnvelopeDeclared;
  final bool requestEnvelopeDocumented;
  final bool responseEnvelopeDocumented;
  final bool errorTaxonomyDocumented;
  final bool timeoutCancellationPolicyDocumented;
  final bool memoryPressurePolicyDocumented;
  final bool reviewOnlyModeRequired;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveGraphSolutionHistoryBlocked;
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
  final bool bridgeImplementationPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool releasePassClaimed;
  final String evidenceLabel;
}

class GaussNativeRuntimeBridgeImplementationResult {
  const GaussNativeRuntimeBridgeImplementationResult._({
    required this.decision,
    required this.bridgeImplementationStaticReady,
    required this.readyForQ281PrivateArtifactLoadSmokeGateOnly,
    required this.rejectionReasons,
    required this.canEnableBridgeFlagByDefaultInQ280,
    required this.canInvokeNativeRuntimeInQ280,
    required this.canRunImageToLatexInferenceInQ280,
    required this.canImportCameraOutputWithoutReview,
    required this.canClaimBridgeImplementationPassInQ280,
    required this.canClaimOcrPassInQ280,
    required this.evidenceLabel,
  });

  final GaussNativeRuntimeBridgeImplementationDecision decision;
  final bool bridgeImplementationStaticReady;
  final bool readyForQ281PrivateArtifactLoadSmokeGateOnly;
  final List<String> rejectionReasons;
  final bool canEnableBridgeFlagByDefaultInQ280;
  final bool canInvokeNativeRuntimeInQ280;
  final bool canRunImageToLatexInferenceInQ280;
  final bool canImportCameraOutputWithoutReview;
  final bool canClaimBridgeImplementationPassInQ280;
  final bool canClaimOcrPassInQ280;
  final String evidenceLabel;

  String get phase => GaussNativeRuntimeBridgeImplementationPolicy.phase;
  String get sourcePhase => GaussNativeRuntimeBridgeImplementationPolicy.sourcePhase;
  String get selectedEngineLabel => GaussNativeRuntimeBridgeImplementationPolicy.selectedEngineLabel;
  String get bridgeImplementationMode => GaussNativeRuntimeBridgeImplementationPolicy.bridgeImplementationMode;
  List<String> get requiredBridgeImplementationGates => GaussNativeRuntimeBridgeImplementationPolicy.requiredBridgeImplementationGates;
  List<String> get blockedUntilRealEvidence => GaussNativeRuntimeBridgeImplementationPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussNativeRuntimeBridgeImplementationPolicy.forbiddenActions;
  bool get dartBridgeFacadeAdded => GaussNativeRuntimeBridgeImplementationPolicy.dartBridgeFacadeAdded;
  bool get nativeHandlerImplementationAdded => GaussNativeRuntimeBridgeImplementationPolicy.nativeHandlerImplementationAdded;
  bool get bridgeFeatureFlagEnabledByDefault => GaussNativeRuntimeBridgeImplementationPolicy.bridgeFeatureFlagEnabledByDefault;
  bool get runtimeInvocationAllowedWhenFlagOff => GaussNativeRuntimeBridgeImplementationPolicy.runtimeInvocationAllowedWhenFlagOff;
  bool get realOcrRuntimeAdded => GaussNativeRuntimeBridgeImplementationPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussNativeRuntimeBridgeImplementationPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussNativeRuntimeBridgeImplementationPolicy.paddleOcrDependencyAdded;
  bool get modelBinaryBundledInBaseApp => GaussNativeRuntimeBridgeImplementationPolicy.modelBinaryBundledInBaseApp;
  bool get realImageToLatexInferenceExecuted => GaussNativeRuntimeBridgeImplementationPolicy.realImageToLatexInferenceExecuted;
}

class GaussNativeRuntimeBridgeRequestEnvelope {
  const GaussNativeRuntimeBridgeRequestEnvelope({
    required this.requestId,
    required this.croppedImagePath,
    required this.privateArtifactPath,
    required this.artifactSha256,
    required this.androidAbi,
    required this.timeoutMs,
    required this.runtimeFeatureFlagEnabled,
    this.reviewOnlyMode = true,
  });

  final String requestId;
  final String croppedImagePath;
  final String privateArtifactPath;
  final String artifactSha256;
  final String androidAbi;
  final int timeoutMs;
  final bool runtimeFeatureFlagEnabled;
  final bool reviewOnlyMode;

  bool get hasValidSha256 => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(artifactSha256);
  bool get isReviewOnlySafe => reviewOnlyMode && !runtimeFeatureFlagEnabled;
}

class GaussNativeRuntimeBridgeResponseEnvelope {
  const GaussNativeRuntimeBridgeResponseEnvelope({
    required this.requestId,
    required this.status,
    required this.reviewRequired,
    required this.directWorkspaceMutationAttempted,
    this.primaryLatexCandidate,
    this.alternativeLatexCandidates = const <String>[],
    this.confidence,
    this.warnings = const <String>[],
    this.errorCode,
    this.engineMetadata = const <String, String>{},
    this.latencyMs,
  });

  factory GaussNativeRuntimeBridgeResponseEnvelope.blockedFlagOff(String requestId) {
    return GaussNativeRuntimeBridgeResponseEnvelope(
      requestId: requestId,
      status: 'blocked',
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
      errorCode: 'runtimeFeatureFlagOff',
      warnings: const <String>['Q280 bridge flag is default-off; no native runtime invocation was attempted.'],
    );
  }

  factory GaussNativeRuntimeBridgeResponseEnvelope.blockedNoNativeHandler(String requestId) {
    return GaussNativeRuntimeBridgeResponseEnvelope(
      requestId: requestId,
      status: 'blocked',
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
      errorCode: 'nativeHandlerNotBound',
      warnings: const <String>['Q280 declares the bridge envelope only; native handler binding is deferred.'],
    );
  }

  final String requestId;
  final String status;
  final bool reviewRequired;
  final bool directWorkspaceMutationAttempted;
  final String? primaryLatexCandidate;
  final List<String> alternativeLatexCandidates;
  final double? confidence;
  final List<String> warnings;
  final String? errorCode;
  final Map<String, String> engineMetadata;
  final int? latencyMs;

  bool get canImportToWorkspace => primaryLatexCandidate != null && reviewRequired && !directWorkspaceMutationAttempted;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussNativeRuntimeBridgeImplementation {
  const GaussNativeRuntimeBridgeImplementation._();

  static GaussNativeRuntimeBridgeImplementationResult evaluate(GaussNativeRuntimeBridgeImplementationInput input) {
    GaussNativeRuntimeBridgeImplementationResult reject(
      GaussNativeRuntimeBridgeImplementationDecision decision,
      String reason,
    ) {
      return GaussNativeRuntimeBridgeImplementationResult._(
        decision: decision,
        bridgeImplementationStaticReady: false,
        readyForQ281PrivateArtifactLoadSmokeGateOnly: false,
        rejectionReasons: <String>[reason],
        canEnableBridgeFlagByDefaultInQ280: false,
        canInvokeNativeRuntimeInQ280: false,
        canRunImageToLatexInferenceInQ280: false,
        canImportCameraOutputWithoutReview: false,
        canClaimBridgeImplementationPassInQ280: false,
        canClaimOcrPassInQ280: false,
        evidenceLabel: input.evidenceLabel,
      );
    }

    if (!input.q279DependencyTrialPresent) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedMissingQ279DependencyTrial, 'missingQ279DependencyTrial');
    }
    if (!input.q278EvidenceLockPresent) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedMissingQ278EvidenceLock, 'missingQ278EvidenceLock');
    }
    if (!input.defaultOffBridgeFeatureFlagRequired || !input.runtimeInvocationBlockedWhenFlagOff) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedMissingDefaultOffBridgeFlag, 'missingDefaultOffBridgeFlagOrFlagOffBlock');
    }
    if (input.bridgeFeatureFlagEnabledByDefault) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedBridgeFlagEnabledByDefault, 'bridgeFlagEnabledByDefault');
    }
    if (!input.methodChannelEnvelopeDeclared || !input.requestEnvelopeDocumented || !input.responseEnvelopeDocumented || !input.errorTaxonomyDocumented) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedMissingRequestOrResponseEnvelope, 'missingBridgeEnvelopeOrErrorTaxonomy');
    }
    if (!input.timeoutCancellationPolicyDocumented || !input.memoryPressurePolicyDocumented) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedMissingTimeoutCancellationOrMemoryPolicy, 'missingTimeoutCancellationOrMemoryPolicy');
    }
    if (!input.reviewOnlyModeRequired || !input.editableMathLiveReviewRequired || !input.explicitUserApprovalRequiredBeforeWorkspaceImport) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedMissingReviewApprovalBoundary, 'missingMathLiveReviewOrUserApprovalBoundary');
    }
    if (!input.directSolveGraphSolutionHistoryBlocked) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedDirectSolveGraphSolutionHistoryRisk, 'directSolveGraphSolutionHistoryRisk');
    }
    if (!input.noNativeHandlerImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noPaddleRuntimeAdded || !input.noPaddleOcrDependencyAdded || !input.noRuntimeDependencyAddedToPubspec || !input.noGradleNativeRuntimeDependencyAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noProductionDownloadEnabled || !input.noRealNetworkDownloadWorkerImplemented || !input.noImageToLatexInferenceExecuted || input.bridgeImplementationPassClaimed || input.runtimeIntegrationPassClaimed || input.ocrPassClaimed || input.releasePassClaimed) {
      return reject(GaussNativeRuntimeBridgeImplementationDecision.blockedUnsafeNativeRuntimeOrInferenceAdded, 'unsafeNativeRuntimeInferenceOrPassClaim');
    }

    return GaussNativeRuntimeBridgeImplementationResult._(
      decision: GaussNativeRuntimeBridgeImplementationDecision.readyForQ281PrivateArtifactLoadSmokeGateOnly,
      bridgeImplementationStaticReady: true,
      readyForQ281PrivateArtifactLoadSmokeGateOnly: true,
      rejectionReasons: const <String>[],
      canEnableBridgeFlagByDefaultInQ280: false,
      canInvokeNativeRuntimeInQ280: false,
      canRunImageToLatexInferenceInQ280: false,
      canImportCameraOutputWithoutReview: false,
      canClaimBridgeImplementationPassInQ280: false,
      canClaimOcrPassInQ280: false,
      evidenceLabel: input.evidenceLabel,
    );
  }

  static GaussNativeRuntimeBridgeResponseEnvelope guardedRequest(GaussNativeRuntimeBridgeRequestEnvelope request) {
    if (!request.runtimeFeatureFlagEnabled) {
      return GaussNativeRuntimeBridgeResponseEnvelope.blockedFlagOff(request.requestId);
    }
    return GaussNativeRuntimeBridgeResponseEnvelope.blockedNoNativeHandler(request.requestId);
  }
}
