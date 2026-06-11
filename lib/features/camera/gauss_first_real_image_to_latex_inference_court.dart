import 'gauss_first_real_image_to_latex_inference_court_policy.dart';

class GaussImageToLatexCropBounds {
  const GaussImageToLatexCropBounds({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final double left;
  final double top;
  final double width;
  final double height;

  bool get isNormalized => left >= 0 && top >= 0 && width > 0 && height > 0 && left + width <= 1 && top + height <= 1;
}

enum GaussFirstRealImageToLatexInferenceCourtDecision {
  blockedMissingQ282RuntimeSmokeEvidence,
  blockedMissingRuntimeEvidenceChain,
  blockedInvalidImageInputEnvelope,
  blockedMissingPreprocessCandidateMetadata,
  blockedMissingReviewApprovalBoundary,
  blockedDirectSolveGraphSolutionHistoryRisk,
  blockedUnsafeRuntimeInferenceOrPassClaim,
  readyForQ284RealMathLiveReviewRuntimeBindingOnly,
}

class GaussFirstRealImageToLatexInferenceCourtInput {
  const GaussFirstRealImageToLatexInferenceCourtInput({
    required this.q282FirstRealRuntimeSmokeOnDevicePresent,
    required this.q281PrivateArtifactLoadSmokePresent,
    required this.q280NativeRuntimeBridgePresent,
    required this.q279DependencyTrialPresent,
    required this.q278EvidenceLockPresent,
    required this.acceptedQ282RuntimeSmokeEvidence,
    required this.croppedImageEvidenceRequired,
    required this.preprocessMetadataRequired,
    required this.runtimeCandidateEnvelopeRequired,
    required this.primaryLatexCandidateFieldRequired,
    required this.alternativeLatexCandidatesFieldAllowed,
    required this.confidenceWarningsEngineMetadataRequired,
    required this.latencyMeasurementRequired,
    required this.peakMemoryMeasurementRequired,
    required this.timeoutCancellationEvidenceRequired,
    required this.memoryPressureEvidenceRequired,
    required this.runtimeFeatureFlagDefaultOffUntilEvidence,
    required this.reviewOnlyModeRequired,
    required this.editableMathLiveReviewRequired,
    required this.explicitUserApprovalRequiredBeforeWorkspaceImport,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.noRealImageToLatexInferenceExecutedInQ283,
    required this.noRealRuntimeInvocationExecutedInQ283,
    required this.noNativeRuntimeBridgeInvokedInQ283,
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
    required this.imageToLatexPassClaimed,
    required this.ocrPassClaimed,
    required this.releasePassClaimed,
    required this.evidenceLabel,
  });

  final bool q282FirstRealRuntimeSmokeOnDevicePresent;
  final bool q281PrivateArtifactLoadSmokePresent;
  final bool q280NativeRuntimeBridgePresent;
  final bool q279DependencyTrialPresent;
  final bool q278EvidenceLockPresent;
  final bool acceptedQ282RuntimeSmokeEvidence;
  final bool croppedImageEvidenceRequired;
  final bool preprocessMetadataRequired;
  final bool runtimeCandidateEnvelopeRequired;
  final bool primaryLatexCandidateFieldRequired;
  final bool alternativeLatexCandidatesFieldAllowed;
  final bool confidenceWarningsEngineMetadataRequired;
  final bool latencyMeasurementRequired;
  final bool peakMemoryMeasurementRequired;
  final bool timeoutCancellationEvidenceRequired;
  final bool memoryPressureEvidenceRequired;
  final bool runtimeFeatureFlagDefaultOffUntilEvidence;
  final bool reviewOnlyModeRequired;
  final bool editableMathLiveReviewRequired;
  final bool explicitUserApprovalRequiredBeforeWorkspaceImport;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool noRealImageToLatexInferenceExecutedInQ283;
  final bool noRealRuntimeInvocationExecutedInQ283;
  final bool noNativeRuntimeBridgeInvokedInQ283;
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
  final bool imageToLatexPassClaimed;
  final bool ocrPassClaimed;
  final bool releasePassClaimed;
  final String evidenceLabel;
}

class GaussFirstRealImageToLatexInferenceCourtResult {
  const GaussFirstRealImageToLatexInferenceCourtResult._({
    required this.decision,
    required this.imageToLatexCourtStaticReady,
    required this.readyForQ284RealMathLiveReviewRuntimeBindingOnly,
    required this.rejectionReasons,
    required this.canRunRealImageToLatexInQ283,
    required this.canImportCameraOutputWithoutReview,
    required this.canEvaluate,
    required this.canGraph,
    required this.canWriteSolutionOrHistory,
    required this.canClaimImageToLatexPassInQ283,
    required this.canClaimOcrPassInQ283,
    required this.evidenceLabel,
  });

  final GaussFirstRealImageToLatexInferenceCourtDecision decision;
  final bool imageToLatexCourtStaticReady;
  final bool readyForQ284RealMathLiveReviewRuntimeBindingOnly;
  final List<String> rejectionReasons;
  final bool canRunRealImageToLatexInQ283;
  final bool canImportCameraOutputWithoutReview;
  final bool canEvaluate;
  final bool canGraph;
  final bool canWriteSolutionOrHistory;
  final bool canClaimImageToLatexPassInQ283;
  final bool canClaimOcrPassInQ283;
  final String evidenceLabel;

  String get phase => GaussFirstRealImageToLatexInferenceCourtPolicy.phase;
  String get sourcePhase => GaussFirstRealImageToLatexInferenceCourtPolicy.sourcePhase;
  String get selectedEngineLabel => GaussFirstRealImageToLatexInferenceCourtPolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussFirstRealImageToLatexInferenceCourtPolicy.fallbackEngineLabel;
  String get courtMode => GaussFirstRealImageToLatexInferenceCourtPolicy.courtMode;
  bool get imageToLatexCourtEnvelopeAdded => GaussFirstRealImageToLatexInferenceCourtPolicy.imageToLatexCourtEnvelopeAdded;
  bool get realImageToLatexInferenceExecutedInQ283 => GaussFirstRealImageToLatexInferenceCourtPolicy.realImageToLatexInferenceExecutedInQ283;
  bool get ocrPassClaimed => GaussFirstRealImageToLatexInferenceCourtPolicy.ocrPassClaimed;
  List<String> get requiredImageToLatexCourtGates => GaussFirstRealImageToLatexInferenceCourtPolicy.requiredImageToLatexCourtGates;
  List<String> get blockedUntilRealEvidence => GaussFirstRealImageToLatexInferenceCourtPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussFirstRealImageToLatexInferenceCourtPolicy.forbiddenActions;
}

class GaussImageToLatexCourtRequestEnvelope {
  const GaussImageToLatexCourtRequestEnvelope({
    required this.requestId,
    required this.captureId,
    required this.croppedImagePath,
    required this.croppedImageSha256,
    required this.croppedImageBytes,
    required this.cropBounds,
    required this.rotationDegrees,
    required this.orientationLabel,
    required this.lightingHint,
    required this.focusHint,
    required this.preprocessProfile,
    required this.runtimeFeatureFlagEnabled,
    this.reviewOnlyMode = true,
  });

  final String requestId;
  final String captureId;
  final String croppedImagePath;
  final String croppedImageSha256;
  final int croppedImageBytes;
  final GaussImageToLatexCropBounds cropBounds;
  final int rotationDegrees;
  final String orientationLabel;
  final String lightingHint;
  final String focusHint;
  final String preprocessProfile;
  final bool runtimeFeatureFlagEnabled;
  final bool reviewOnlyMode;

  static bool isSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);

  bool get croppedShaIsValid => isSha256(croppedImageSha256);
  bool get cropPathLooksPrivateOrCache => croppedImagePath.contains('/cache/') || croppedImagePath.contains('/files/') || croppedImagePath.contains('\\cache\\') || croppedImagePath.contains('\\files\\');
  bool get imageSizeWithinBudget => croppedImageBytes > 0 && croppedImageBytes <= GaussFirstRealImageToLatexInferenceCourtPolicy.maxInputImageBytes;
  bool get rotationLooksSafe => rotationDegrees == 0 || rotationDegrees == 90 || rotationDegrees == 180 || rotationDegrees == 270;
  bool get metadataLooksComplete => requestId.trim().isNotEmpty && captureId.trim().isNotEmpty && orientationLabel.trim().isNotEmpty && lightingHint.trim().isNotEmpty && focusHint.trim().isNotEmpty && preprocessProfile.trim().isNotEmpty;
  bool get isSafeCourtEnvelope => croppedShaIsValid && cropPathLooksPrivateOrCache && imageSizeWithinBudget && cropBounds.isNormalized && rotationLooksSafe && metadataLooksComplete && reviewOnlyMode;
}

class GaussImageToLatexCandidateEnvelope {
  const GaussImageToLatexCandidateEnvelope._({
    required this.requestId,
    required this.engineLabel,
    required this.primaryLatexCandidate,
    required this.alternativeLatexCandidates,
    required this.confidence,
    required this.warnings,
    required this.engineMetadata,
    required this.latencyMs,
    required this.peakMemoryMb,
    required this.mathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.directWorkspaceMutationAttempted,
    required this.directSolveGraphSolutionHistoryAttempted,
    required this.errorCode,
  });

  factory GaussImageToLatexCandidateEnvelope.blockedFlagOff(String requestId) {
    return GaussImageToLatexCandidateEnvelope._(
      requestId: requestId,
      engineLabel: GaussFirstRealImageToLatexInferenceCourtPolicy.selectedEngineLabel,
      primaryLatexCandidate: r'\text{Image-to-LaTeX court pending}',
      alternativeLatexCandidates: const <String>[],
      confidence: 0,
      warnings: const <String>['Q283 image-to-LaTeX court remains default-off until real runtime smoke evidence and explicit approval exist.'],
      engineMetadata: const <String, String>{'phase': GaussFirstRealImageToLatexInferenceCourtPolicy.phase},
      latencyMs: 0,
      peakMemoryMb: 0,
      mathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directWorkspaceMutationAttempted: false,
      directSolveGraphSolutionHistoryAttempted: false,
      errorCode: 'imageToLatexFeatureFlagOff',
    );
  }

  factory GaussImageToLatexCandidateEnvelope.blockedUnsafeEnvelope(String requestId) {
    return GaussImageToLatexCandidateEnvelope._(
      requestId: requestId,
      engineLabel: GaussFirstRealImageToLatexInferenceCourtPolicy.selectedEngineLabel,
      primaryLatexCandidate: r'\text{Invalid cropped image envelope}',
      alternativeLatexCandidates: const <String>[],
      confidence: 0,
      warnings: const <String>['Cropped image evidence is incomplete; inference and workspace import remain blocked.'],
      engineMetadata: const <String, String>{'error': 'invalidCroppedImageEnvelope'},
      latencyMs: 0,
      peakMemoryMb: 0,
      mathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directWorkspaceMutationAttempted: false,
      directSolveGraphSolutionHistoryAttempted: false,
      errorCode: 'invalidCroppedImageEnvelope',
    );
  }

  factory GaussImageToLatexCandidateEnvelope.blockedNoRealInference(String requestId) {
    return GaussImageToLatexCandidateEnvelope._(
      requestId: requestId,
      engineLabel: GaussFirstRealImageToLatexInferenceCourtPolicy.selectedEngineLabel,
      primaryLatexCandidate: r'\text{Real inference not executed in Q283}',
      alternativeLatexCandidates: const <String>[],
      confidence: 0,
      warnings: const <String>['Q283 defines the first real image-to-LaTeX inference court envelope only; no Paddle runtime or inference path is executed in this package.'],
      engineMetadata: const <String, String>{'mode': GaussFirstRealImageToLatexInferenceCourtPolicy.courtMode},
      latencyMs: 0,
      peakMemoryMb: 0,
      mathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directWorkspaceMutationAttempted: false,
      directSolveGraphSolutionHistoryAttempted: false,
      errorCode: 'noRealImageToLatexInferenceExecutedInQ283',
    );
  }

  final String requestId;
  final String engineLabel;
  final String primaryLatexCandidate;
  final List<String> alternativeLatexCandidates;
  final double confidence;
  final List<String> warnings;
  final Map<String, String> engineMetadata;
  final int latencyMs;
  final int peakMemoryMb;
  final bool mathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final bool directWorkspaceMutationAttempted;
  final bool directSolveGraphSolutionHistoryAttempted;
  final String errorCode;

  bool get canOpenMathLiveReview => mathLiveReviewRequired && !directWorkspaceMutationAttempted && !directSolveGraphSolutionHistoryAttempted;
  bool get canImportToWorkspace => false;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteSolutionOrHistory => false;
}

class GaussFirstRealImageToLatexInferenceCourt {
  const GaussFirstRealImageToLatexInferenceCourt._();

  static GaussFirstRealImageToLatexInferenceCourtResult evaluate(GaussFirstRealImageToLatexInferenceCourtInput input) {
    GaussFirstRealImageToLatexInferenceCourtResult reject(GaussFirstRealImageToLatexInferenceCourtDecision decision, String reason) {
      return GaussFirstRealImageToLatexInferenceCourtResult._(
        decision: decision,
        imageToLatexCourtStaticReady: false,
        readyForQ284RealMathLiveReviewRuntimeBindingOnly: false,
        rejectionReasons: <String>[reason],
        canRunRealImageToLatexInQ283: false,
        canImportCameraOutputWithoutReview: false,
        canEvaluate: false,
        canGraph: false,
        canWriteSolutionOrHistory: false,
        canClaimImageToLatexPassInQ283: false,
        canClaimOcrPassInQ283: false,
        evidenceLabel: input.evidenceLabel,
      );
    }

    if (!input.q282FirstRealRuntimeSmokeOnDevicePresent || !input.acceptedQ282RuntimeSmokeEvidence) {
      return reject(GaussFirstRealImageToLatexInferenceCourtDecision.blockedMissingQ282RuntimeSmokeEvidence, 'missingQ282RuntimeSmokeEvidence');
    }
    if (!input.q281PrivateArtifactLoadSmokePresent || !input.q280NativeRuntimeBridgePresent || !input.q279DependencyTrialPresent || !input.q278EvidenceLockPresent) {
      return reject(GaussFirstRealImageToLatexInferenceCourtDecision.blockedMissingRuntimeEvidenceChain, 'missingQ281Q280Q279Q278EvidenceChain');
    }
    if (!input.croppedImageEvidenceRequired) {
      return reject(GaussFirstRealImageToLatexInferenceCourtDecision.blockedInvalidImageInputEnvelope, 'missingCroppedImageEvidence');
    }
    if (!input.preprocessMetadataRequired || !input.runtimeCandidateEnvelopeRequired || !input.primaryLatexCandidateFieldRequired || !input.alternativeLatexCandidatesFieldAllowed || !input.confidenceWarningsEngineMetadataRequired || !input.latencyMeasurementRequired || !input.peakMemoryMeasurementRequired || !input.timeoutCancellationEvidenceRequired || !input.memoryPressureEvidenceRequired || !input.runtimeFeatureFlagDefaultOffUntilEvidence) {
      return reject(GaussFirstRealImageToLatexInferenceCourtDecision.blockedMissingPreprocessCandidateMetadata, 'missingPreprocessCandidateBudgetOrFlagMetadata');
    }
    if (!input.reviewOnlyModeRequired || !input.editableMathLiveReviewRequired || !input.explicitUserApprovalRequiredBeforeWorkspaceImport) {
      return reject(GaussFirstRealImageToLatexInferenceCourtDecision.blockedMissingReviewApprovalBoundary, 'missingMathLiveReviewOrUserApprovalBoundary');
    }
    if (!input.directSolveGraphSolutionHistoryBlocked) {
      return reject(GaussFirstRealImageToLatexInferenceCourtDecision.blockedDirectSolveGraphSolutionHistoryRisk, 'directSolveGraphSolutionHistoryRisk');
    }
    if (!input.noRealImageToLatexInferenceExecutedInQ283 || !input.noRealRuntimeInvocationExecutedInQ283 || !input.noNativeRuntimeBridgeInvokedInQ283 || !input.noNativeHandlerImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noPaddleRuntimeAdded || !input.noPaddleOcrDependencyAdded || !input.noRuntimeDependencyAddedToPubspec || !input.noGradleNativeRuntimeDependencyAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noProductionDownloadEnabled || !input.noRealNetworkDownloadWorkerImplemented || input.imageToLatexPassClaimed || input.ocrPassClaimed || input.releasePassClaimed) {
      return reject(GaussFirstRealImageToLatexInferenceCourtDecision.blockedUnsafeRuntimeInferenceOrPassClaim, 'unsafeRuntimeInferenceOrPassClaim');
    }

    return GaussFirstRealImageToLatexInferenceCourtResult._(
      decision: GaussFirstRealImageToLatexInferenceCourtDecision.readyForQ284RealMathLiveReviewRuntimeBindingOnly,
      imageToLatexCourtStaticReady: true,
      readyForQ284RealMathLiveReviewRuntimeBindingOnly: true,
      rejectionReasons: const <String>[],
      canRunRealImageToLatexInQ283: false,
      canImportCameraOutputWithoutReview: false,
      canEvaluate: false,
      canGraph: false,
      canWriteSolutionOrHistory: false,
      canClaimImageToLatexPassInQ283: false,
      canClaimOcrPassInQ283: false,
      evidenceLabel: input.evidenceLabel,
    );
  }

  static GaussImageToLatexCandidateEnvelope guardedImageToLatexCourt(GaussImageToLatexCourtRequestEnvelope request) {
    if (!request.runtimeFeatureFlagEnabled) {
      return GaussImageToLatexCandidateEnvelope.blockedFlagOff(request.requestId);
    }
    if (!request.isSafeCourtEnvelope) {
      return GaussImageToLatexCandidateEnvelope.blockedUnsafeEnvelope(request.requestId);
    }
    return GaussImageToLatexCandidateEnvelope.blockedNoRealInference(request.requestId);
  }
}
