import 'gauss_first_real_image_to_latex_inference_policy.dart';

enum GaussFirstRealImageToLatexInferenceDecision {
  imageToLatexInferenceContractReadyRealInferenceBlocked,
  blockedIfRuntimeInferenceOrPassClaimAdded,
}

class GaussFirstRealImageToLatexInferenceResult {
  const GaussFirstRealImageToLatexInferenceResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.inferenceFeatureFlag,
    required this.inferenceReadinessState,
    required this.inferenceDecision,
    required this.firstRealImageToLatexInferencePreconditions,
    required this.imageToLatexInferenceRequestFields,
    required this.imageToLatexInferenceResultFields,
    required this.imageToLatexInferenceErrorCodes,
    required this.decision,
    required this.inferenceFeatureFlagEnabledByDefault,
    required this.realImageToLatexInferenceExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.nativeRuntimeStartupExecuted,
    required this.nativeRuntimeHandlerImplemented,
    required this.methodChannelRuntimeBindingAdded,
    required this.cameraImageSentToNativeRuntime,
    required this.latexCandidateReturnedByRuntime,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String inferenceFeatureFlag;
  final String inferenceReadinessState;
  final String inferenceDecision;
  final List<String> firstRealImageToLatexInferencePreconditions;
  final List<String> imageToLatexInferenceRequestFields;
  final List<String> imageToLatexInferenceResultFields;
  final List<String> imageToLatexInferenceErrorCodes;
  final GaussFirstRealImageToLatexInferenceDecision decision;
  final bool inferenceFeatureFlagEnabledByDefault;
  final bool realImageToLatexInferenceExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool nativeRuntimeStartupExecuted;
  final bool nativeRuntimeHandlerImplemented;
  final bool methodChannelRuntimeBindingAdded;
  final bool cameraImageSentToNativeRuntime;
  final bool latexCandidateReturnedByRuntime;
  final bool ocrPassClaimed;
}

class GaussImageToLatexInferenceRequestEnvelope {
  const GaussImageToLatexInferenceRequestEnvelope({
    required this.requestId,
    required this.engineLabel,
    required this.runtimeSessionId,
    required this.verifiedPrivateArtifactPath,
    required this.expectedSha256,
    required this.actualSha256,
    required this.androidAbi,
    required this.captureId,
    required this.croppedImagePath,
    required this.croppedImageSha256,
    required this.croppedImageBytes,
    required this.cropLeft,
    required this.cropTop,
    required this.cropWidth,
    required this.cropHeight,
    required this.rotationDegrees,
    required this.orientationLabel,
    required this.lightingHint,
    required this.focusHint,
    required this.preprocessProfile,
    required this.timeoutMs,
    required this.inferenceFeatureFlagEnabled,
    required this.dummyInputRuntimeCallStatus,
    this.callMode = 'image-to-latex-candidate-only-review-first-no-direct-workspace',
  });

  final String requestId;
  final String engineLabel;
  final String runtimeSessionId;
  final String verifiedPrivateArtifactPath;
  final String expectedSha256;
  final String actualSha256;
  final String androidAbi;
  final String captureId;
  final String croppedImagePath;
  final String croppedImageSha256;
  final int croppedImageBytes;
  final double cropLeft;
  final double cropTop;
  final double cropWidth;
  final double cropHeight;
  final int rotationDegrees;
  final String orientationLabel;
  final String lightingHint;
  final String focusHint;
  final String preprocessProfile;
  final int timeoutMs;
  final bool inferenceFeatureFlagEnabled;
  final String dummyInputRuntimeCallStatus;
  final String callMode;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get hasValidExpectedSha256 => isSha256(expectedSha256);
  bool get hasValidActualSha256 => isSha256(actualSha256);
  bool get shaMatches => hasValidExpectedSha256 && hasValidActualSha256 && expectedSha256.toLowerCase() == actualSha256.toLowerCase();
  bool get hasCroppedImageSha => isSha256(croppedImageSha256);
  String get normalizedVerifiedPrivateArtifactPath => verifiedPrivateArtifactPath.replaceAll('\\', '/');
  String get normalizedCroppedImagePath => croppedImagePath.replaceAll('\\', '/');
  bool get isPrivateStoragePath => normalizedVerifiedPrivateArtifactPath.contains('/files/models/');
  bool get isPrivateCropPath => normalizedCroppedImagePath.contains('/cache/crops/');
  bool get supportedAbi => androidAbi == 'arm64-v8a' || androidAbi == 'armeabi-v7a' || androidAbi == 'x86_64';
  bool get hasValidCropBounds => cropLeft >= 0 && cropTop >= 0 && cropWidth > 0 && cropHeight > 0 && cropLeft + cropWidth <= 1 && cropTop + cropHeight <= 1;
  bool get hasImageWithinBudget => croppedImageBytes > 0 && croppedImageBytes <= GaussFirstRealImageToLatexInferencePolicy.maxInputImageBytes;
  bool get dummyCallPassed => dummyInputRuntimeCallStatus == 'passed';
  bool get hasPreprocessMetadata => orientationLabel.isNotEmpty && lightingHint.isNotEmpty && focusHint.isNotEmpty && preprocessProfile.isNotEmpty;
  bool get withinTimeoutBudget => timeoutMs > 0 && timeoutMs <= GaussFirstRealImageToLatexInferencePolicy.inferenceTimeoutBudgetMs;
}

class GaussImageToLatexInferenceResultEnvelope {
  const GaussImageToLatexInferenceResultEnvelope._({
    required this.requestId,
    required this.status,
    required this.runtimeSessionUsed,
    required this.cameraImageSent,
    required this.nativeRuntimeInvoked,
    required this.latexCandidateReturned,
    required this.primaryLatexCandidate,
    required this.alternativeLatexCandidates,
    required this.confidence,
    required this.warnings,
    required this.engineMetadata,
    required this.errorCode,
    required this.inferenceLatencyMs,
    required this.peakMemoryMb,
    required this.reviewRequired,
    required this.directWorkspaceMutationAttempted,
  });

  factory GaussImageToLatexInferenceResultEnvelope.blockedFlagOff(String requestId) {
    return GaussImageToLatexInferenceResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeSessionUsed: false,
      cameraImageSent: false,
      nativeRuntimeInvoked: false,
      latexCandidateReturned: false,
      primaryLatexCandidate: '',
      alternativeLatexCandidates: const <String>[],
      confidence: 0,
      warnings: const <String>['Q295 image-to-LaTeX inference remains default-off; no camera image was sent to runtime.'],
      engineMetadata: const <String, String>{'phase': 'Q295', 'mode': 'contract-only'},
      errorCode: 'imageToLatexFeatureFlagOff',
      inferenceLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(String requestId, String errorCode) {
    return GaussImageToLatexInferenceResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeSessionUsed: false,
      cameraImageSent: false,
      nativeRuntimeInvoked: false,
      latexCandidateReturned: false,
      primaryLatexCandidate: '',
      alternativeLatexCandidates: const <String>[],
      confidence: 0,
      warnings: const <String>['Q294 dummy input runtime call, verified artifact, MethodChannel/native handler, crop, preprocess, latency, memory, and review evidence are required before image-to-LaTeX inference.'],
      engineMetadata: const <String, String>{'phase': 'Q295', 'mode': 'evidence-missing'},
      errorCode: errorCode,
      inferenceLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  factory GaussImageToLatexInferenceResultEnvelope.blockedNoRealInferenceExecuted(String requestId) {
    return GaussImageToLatexInferenceResultEnvelope._(
      requestId: requestId,
      status: 'blocked',
      runtimeSessionUsed: true,
      cameraImageSent: false,
      nativeRuntimeInvoked: false,
      latexCandidateReturned: false,
      primaryLatexCandidate: '',
      alternativeLatexCandidates: const <String>[],
      confidence: 0,
      warnings: const <String>['Q295 defines the first image-to-LaTeX inference boundary; no runtime image inference is executed in this package.'],
      engineMetadata: const <String, String>{'phase': 'Q295', 'mode': 'no-real-inference-executed'},
      errorCode: 'noRealImageToLatexInferenceExecutedInQ295',
      inferenceLatencyMs: 0,
      peakMemoryMb: 0,
      reviewRequired: true,
      directWorkspaceMutationAttempted: false,
    );
  }

  final String requestId;
  final String status;
  final bool runtimeSessionUsed;
  final bool cameraImageSent;
  final bool nativeRuntimeInvoked;
  final bool latexCandidateReturned;
  final String primaryLatexCandidate;
  final List<String> alternativeLatexCandidates;
  final double confidence;
  final List<String> warnings;
  final Map<String, String> engineMetadata;
  final String errorCode;
  final int inferenceLatencyMs;
  final int peakMemoryMb;
  final bool reviewRequired;
  final bool directWorkspaceMutationAttempted;

  bool get canOpenMathLiveReview => reviewRequired;
  bool get canImportToWorkspace => false;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussFirstRealImageToLatexInference {
  const GaussFirstRealImageToLatexInference._();

  static GaussFirstRealImageToLatexInferenceResult evaluate() {
    const blocked =
        GaussFirstRealImageToLatexInferencePolicy.inferenceFeatureFlagEnabledByDefault ||
            GaussFirstRealImageToLatexInferencePolicy.realImageToLatexInferenceExecuted ||
            GaussFirstRealImageToLatexInferencePolicy.realDummyInputRuntimeCallExecuted ||
            GaussFirstRealImageToLatexInferencePolicy.nativeRuntimeStartupExecuted ||
            GaussFirstRealImageToLatexInferencePolicy.nativeRuntimeHandlerImplemented ||
            GaussFirstRealImageToLatexInferencePolicy.methodChannelRuntimeBindingAdded ||
            GaussFirstRealImageToLatexInferencePolicy.jniBindingAdded ||
            GaussFirstRealImageToLatexInferencePolicy.paddleRuntimeAdded ||
            GaussFirstRealImageToLatexInferencePolicy.paddleOcrDependencyAdded ||
            GaussFirstRealImageToLatexInferencePolicy.runtimeDependencyAddedToPubspec ||
            GaussFirstRealImageToLatexInferencePolicy.gradleNativeRuntimeDependencyAdded ||
            GaussFirstRealImageToLatexInferencePolicy.realPrivateArtifactFileLoaded ||
            GaussFirstRealImageToLatexInferencePolicy.modelFormatProbeExecuted ||
            GaussFirstRealImageToLatexInferencePolicy.runtimeWarmupCallExecuted ||
            GaussFirstRealImageToLatexInferencePolicy.dummyInputFixtureSentToNativeRuntime ||
            GaussFirstRealImageToLatexInferencePolicy.dummyRuntimeResponseParsed ||
            GaussFirstRealImageToLatexInferencePolicy.cameraImageSentToNativeRuntime ||
            GaussFirstRealImageToLatexInferencePolicy.latexCandidateReturnedByRuntime ||
            GaussFirstRealImageToLatexInferencePolicy.modelBinaryBundledInBaseApp ||
            GaussFirstRealImageToLatexInferencePolicy.productionDownloadEnabled ||
            GaussFirstRealImageToLatexInferencePolicy.directWorkspaceImportEnabled ||
            GaussFirstRealImageToLatexInferencePolicy.directSolveGraphSolutionHistoryEnabled ||
            GaussFirstRealImageToLatexInferencePolicy.imageToLatexPassClaimed ||
            GaussFirstRealImageToLatexInferencePolicy.ocrPassClaimed ||
            GaussFirstRealImageToLatexInferencePolicy.cameraOcrRuntimePassClaimed ||
            GaussFirstRealImageToLatexInferencePolicy.storeReadyPassClaimed ||
            GaussFirstRealImageToLatexInferencePolicy.releasePassClaimed;

    return const GaussFirstRealImageToLatexInferenceResult(
      phase: GaussFirstRealImageToLatexInferencePolicy.phase,
      sourcePhase: GaussFirstRealImageToLatexInferencePolicy.sourcePhase,
      selectedEngineLabel: GaussFirstRealImageToLatexInferencePolicy.selectedEngineLabel,
      inferenceFeatureFlag: GaussFirstRealImageToLatexInferencePolicy.inferenceFeatureFlag,
      inferenceReadinessState: GaussFirstRealImageToLatexInferencePolicy.inferenceReadinessState,
      inferenceDecision: GaussFirstRealImageToLatexInferencePolicy.inferenceDecision,
      firstRealImageToLatexInferencePreconditions: GaussFirstRealImageToLatexInferencePolicy.firstRealImageToLatexInferencePreconditions,
      imageToLatexInferenceRequestFields: GaussFirstRealImageToLatexInferencePolicy.imageToLatexInferenceRequestFields,
      imageToLatexInferenceResultFields: GaussFirstRealImageToLatexInferencePolicy.imageToLatexInferenceResultFields,
      imageToLatexInferenceErrorCodes: GaussFirstRealImageToLatexInferencePolicy.imageToLatexInferenceErrorCodes,
      decision: blocked
          ? GaussFirstRealImageToLatexInferenceDecision.blockedIfRuntimeInferenceOrPassClaimAdded
          : GaussFirstRealImageToLatexInferenceDecision.imageToLatexInferenceContractReadyRealInferenceBlocked,
      inferenceFeatureFlagEnabledByDefault: GaussFirstRealImageToLatexInferencePolicy.inferenceFeatureFlagEnabledByDefault,
      realImageToLatexInferenceExecuted: GaussFirstRealImageToLatexInferencePolicy.realImageToLatexInferenceExecuted,
      realDummyInputRuntimeCallExecuted: GaussFirstRealImageToLatexInferencePolicy.realDummyInputRuntimeCallExecuted,
      nativeRuntimeStartupExecuted: GaussFirstRealImageToLatexInferencePolicy.nativeRuntimeStartupExecuted,
      nativeRuntimeHandlerImplemented: GaussFirstRealImageToLatexInferencePolicy.nativeRuntimeHandlerImplemented,
      methodChannelRuntimeBindingAdded: GaussFirstRealImageToLatexInferencePolicy.methodChannelRuntimeBindingAdded,
      cameraImageSentToNativeRuntime: GaussFirstRealImageToLatexInferencePolicy.cameraImageSentToNativeRuntime,
      latexCandidateReturnedByRuntime: GaussFirstRealImageToLatexInferencePolicy.latexCandidateReturnedByRuntime,
      ocrPassClaimed: GaussFirstRealImageToLatexInferencePolicy.ocrPassClaimed,
    );
  }

  static GaussImageToLatexInferenceResultEnvelope guardedImageToLatexInference(GaussImageToLatexInferenceRequestEnvelope request) {
    if (!request.inferenceFeatureFlagEnabled) {
      return GaussImageToLatexInferenceResultEnvelope.blockedFlagOff(request.requestId);
    }
    if (!request.dummyCallPassed) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'q294DummyInputCallMissing');
    }
    if (!request.shaMatches) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'artifactShaMismatch');
    }
    if (!request.isPrivateStoragePath) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'verifiedArtifactMissing');
    }
    if (!request.hasCroppedImageSha || !request.isPrivateCropPath) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'croppedImageMissing');
    }
    if (!request.hasValidCropBounds) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'invalidCropBounds');
    }
    if (!request.hasImageWithinBudget) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'imageTooLarge');
    }
    if (!request.supportedAbi) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'runtimeStartupMissing');
    }
    if (!request.hasPreprocessMetadata) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'preprocessMetadataMissing');
    }
    if (!request.withinTimeoutBudget) {
      return GaussImageToLatexInferenceResultEnvelope.blockedMissingEvidence(request.requestId, 'imageToLatexTimeout');
    }
    return GaussImageToLatexInferenceResultEnvelope.blockedNoRealInferenceExecuted(request.requestId);
  }
}
