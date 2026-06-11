import 'gauss_pp_formulanet_s_image_to_latex_prototype_gate_policy.dart';

enum GaussPpFormulaNetSImageToLatexPrototypeGateDecision {
  blockedMissingQ272FirstRuntimeSmokePrototype,
  blockedMissingCroppedImageInputEnvelope,
  blockedMissingPreprocessMetadata,
  blockedMissingRuntimeCandidateResponseEnvelope,
  blockedMissingPrimaryLatexCandidateField,
  blockedMissingAlternativeLatexCandidateField,
  blockedMissingConfidenceWarningsEngineMetadata,
  blockedUnsafeRuntimeDependencyOrBridgeBinding,
  blockedMissingTimeoutCancellationPolicy,
  blockedMissingMemoryPressurePolicy,
  blockedMissingMathLiveReviewRequirement,
  blockedDirectSolveOrImportRisk,
  blockedRealInferenceOrPassClaimedInQ273,
  readyForFutureImageToLatexPrototypeOnly,
}

class GaussPpFormulaNetSImageToLatexPrototypeGateInput {
  const GaussPpFormulaNetSImageToLatexPrototypeGateInput({
    required this.q272FirstRuntimeSmokePrototypePresent,
    required this.q272StillNoRuntimeNoInference,
    required this.croppedImageInputEnvelopeDocumented,
    required this.preprocessMetadataDocumented,
    required this.runtimeCandidateResponseEnvelopeDocumented,
    required this.primaryLatexCandidateFieldDocumented,
    required this.alternativeLatexCandidatesFieldDocumented,
    required this.confidenceFieldDocumented,
    required this.warningsFieldDocumented,
    required this.engineMetadataFieldDocumented,
    required this.imageHashFieldDocumented,
    required this.cropBoundsFieldDocumented,
    required this.rotationAndOrientationFieldDocumented,
    required this.lightingAndFocusHintsDocumented,
    required this.timeoutCancellationPolicyDocumented,
    required this.memoryPressurePolicyDocumented,
    required this.latencyBudgetMs,
    required this.peakMemoryBudgetMb,
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
    required this.noRealImageToLatexInferenceExecuted,
    required this.imageToLatexPassClaimed,
    required this.ocrPassClaimed,
    required this.prototypeLabel,
  });

  final bool q272FirstRuntimeSmokePrototypePresent;
  final bool q272StillNoRuntimeNoInference;
  final bool croppedImageInputEnvelopeDocumented;
  final bool preprocessMetadataDocumented;
  final bool runtimeCandidateResponseEnvelopeDocumented;
  final bool primaryLatexCandidateFieldDocumented;
  final bool alternativeLatexCandidatesFieldDocumented;
  final bool confidenceFieldDocumented;
  final bool warningsFieldDocumented;
  final bool engineMetadataFieldDocumented;
  final bool imageHashFieldDocumented;
  final bool cropBoundsFieldDocumented;
  final bool rotationAndOrientationFieldDocumented;
  final bool lightingAndFocusHintsDocumented;
  final bool timeoutCancellationPolicyDocumented;
  final bool memoryPressurePolicyDocumented;
  final int latencyBudgetMs;
  final int peakMemoryBudgetMb;
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
  final bool noRealImageToLatexInferenceExecuted;
  final bool imageToLatexPassClaimed;
  final bool ocrPassClaimed;
  final String prototypeLabel;
}

class GaussPpFormulaNetSImageToLatexPrototypeGateResult {
  const GaussPpFormulaNetSImageToLatexPrototypeGateResult._({
    required this.decision,
    required this.imageToLatexPrototypeStaticReady,
    required this.readyForFutureImageToLatexPrototypeOnly,
    required this.rejectionReasons,
    required this.canRunRealImageToLatexInQ273,
    required this.canClaimImageToLatexPassInQ273,
    required this.canClaimOcrPassInQ273,
    required this.canEnableRuntimeByDefaultInQ273,
    required this.canImportCameraOutputWithoutUserApproval,
    required this.prototypeLabel,
  });

  final GaussPpFormulaNetSImageToLatexPrototypeGateDecision decision;
  final bool imageToLatexPrototypeStaticReady;
  final bool readyForFutureImageToLatexPrototypeOnly;
  final List<String> rejectionReasons;
  final bool canRunRealImageToLatexInQ273;
  final bool canClaimImageToLatexPassInQ273;
  final bool canClaimOcrPassInQ273;
  final bool canEnableRuntimeByDefaultInQ273;
  final bool canImportCameraOutputWithoutUserApproval;
  final String prototypeLabel;

  String get phase => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.phase;
  String get sourcePhase => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.sourcePhase;
  String get selectedEngineLabel => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.selectedEngineLabel;
  String get fallbackEngineLabel => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.fallbackEngineLabel;
  String get imageToLatexPrototypeMode => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.imageToLatexPrototypeMode;
  List<String> get requiredPrototypeGates => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.requiredPrototypeGates;
  List<String> get blockedUntilRealEvidence => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.blockedUntilRealEvidence;
  List<String> get imageInputEnvelopeFields => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.imageInputEnvelopeFields;
  List<String> get latexCandidateEnvelopeFields => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.latexCandidateEnvelopeFields;
  List<String> get prototypeFailureCodes => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.prototypeFailureCodes;
  List<String> get forbiddenActions => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.forbiddenActions;
  bool get realOcrRuntimeAdded => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeImplementationAdded => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.nativeBridgeImplementationAdded;
  bool get jniBindingAdded => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.modelBinaryBundledInBaseApp;
  bool get productionModelUrlBound => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.productionModelUrlBound;
  bool get realNetworkDownloadWorkerImplemented => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.realNetworkDownloadWorkerImplemented;
  bool get productionDownloadEnabled => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.productionDownloadEnabled;
  bool get productionInferenceAllowed => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.productionInferenceAllowed;
  bool get runtimeFeatureFlagDefaultOff => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.runtimeFeatureFlagDefaultOff;
  bool get realImageToLatexInferenceExecuted => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.realImageToLatexInferenceExecuted;
  bool get imageToLatexPassClaimed => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.imageToLatexPassClaimed;
  bool get ocrPassClaimed => GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.ocrPassClaimed;
}

class GaussPpFormulaNetSImageToLatexPrototypeGate {
  const GaussPpFormulaNetSImageToLatexPrototypeGate._();

  static GaussPpFormulaNetSImageToLatexPrototypeGateResult evaluate(GaussPpFormulaNetSImageToLatexPrototypeGateInput input) {
    GaussPpFormulaNetSImageToLatexPrototypeGateResult reject(
      GaussPpFormulaNetSImageToLatexPrototypeGateDecision decision,
      String reason,
    ) => GaussPpFormulaNetSImageToLatexPrototypeGateResult._(
      decision: decision,
      imageToLatexPrototypeStaticReady: false,
      readyForFutureImageToLatexPrototypeOnly: false,
      rejectionReasons: <String>[reason],
      canRunRealImageToLatexInQ273: false,
      canClaimImageToLatexPassInQ273: false,
      canClaimOcrPassInQ273: false,
      canEnableRuntimeByDefaultInQ273: false,
      canImportCameraOutputWithoutUserApproval: false,
      prototypeLabel: input.prototypeLabel,
    );

    if (!input.q272FirstRuntimeSmokePrototypePresent || !input.q272StillNoRuntimeNoInference) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingQ272FirstRuntimeSmokePrototype, 'missingQ272FirstRuntimeSmokePrototypeOrUnsafeSourceState');
    if (!input.croppedImageInputEnvelopeDocumented || !input.imageHashFieldDocumented || !input.cropBoundsFieldDocumented || !input.rotationAndOrientationFieldDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingCroppedImageInputEnvelope, 'missingCroppedImageInputEnvelope');
    if (!input.preprocessMetadataDocumented || !input.lightingAndFocusHintsDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingPreprocessMetadata, 'missingPreprocessMetadata');
    if (!input.runtimeCandidateResponseEnvelopeDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingRuntimeCandidateResponseEnvelope, 'missingRuntimeCandidateResponseEnvelope');
    if (!input.primaryLatexCandidateFieldDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingPrimaryLatexCandidateField, 'missingPrimaryLatexCandidateField');
    if (!input.alternativeLatexCandidatesFieldDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingAlternativeLatexCandidateField, 'missingAlternativeLatexCandidateField');
    if (!input.confidenceFieldDocumented || !input.warningsFieldDocumented || !input.engineMetadataFieldDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingConfidenceWarningsEngineMetadata, 'missingConfidenceWarningsEngineMetadata');
    if (!input.noPaddleRuntimeAdded || !input.noPaddleOcrDependencyAdded || !input.noNativeBridgeImplementationAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedUnsafeRuntimeDependencyOrBridgeBinding, 'unsafeRuntimeDependencyOrBridgeBinding');
    if (!input.timeoutCancellationPolicyDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingTimeoutCancellationPolicy, 'missingTimeoutCancellationPolicy');
    if (!input.memoryPressurePolicyDocumented) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingMemoryPressurePolicy, 'missingMemoryPressurePolicy');
    if (input.latencyBudgetMs <= 0 || input.latencyBudgetMs > GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.maxPrototypeLatencyMs || input.peakMemoryBudgetMb <= 0 || input.peakMemoryBudgetMb > GaussPpFormulaNetSImageToLatexPrototypeGatePolicy.maxPrototypePeakMemoryMb) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingMemoryPressurePolicy, 'latencyOrMemoryBudgetOutsidePrototypeBounds');
    if (!input.featureFlagDefaultOffDocumented || !input.noDefaultRuntimeEnablement) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedUnsafeRuntimeDependencyOrBridgeBinding, 'runtimeFeatureFlagOrDefaultEnablementUnsafe');
    if (!input.editableMathLiveReviewRequired || !input.userApprovalRequiredBeforeWorkspaceImport) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedMissingMathLiveReviewRequirement, 'missingMathLiveReviewOrUserApproval');
    if (!input.directSolveBlocked || !input.directGraphSolutionHistoryBlocked) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedDirectSolveOrImportRisk, 'directSolveGraphSolutionHistoryRisk');
    if (!input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noRealNetworkDownloadWorkerImplemented || input.productionDownloadEnabled || !input.noProductionInferenceAllowed || !input.noRealImageToLatexInferenceExecuted || input.imageToLatexPassClaimed || input.ocrPassClaimed) return reject(GaussPpFormulaNetSImageToLatexPrototypeGateDecision.blockedRealInferenceOrPassClaimedInQ273, 'unsafeDownloadInferenceOrPassClaim');

    return GaussPpFormulaNetSImageToLatexPrototypeGateResult._(
      decision: GaussPpFormulaNetSImageToLatexPrototypeGateDecision.readyForFutureImageToLatexPrototypeOnly,
      imageToLatexPrototypeStaticReady: true,
      readyForFutureImageToLatexPrototypeOnly: true,
      rejectionReasons: const <String>[],
      canRunRealImageToLatexInQ273: false,
      canClaimImageToLatexPassInQ273: false,
      canClaimOcrPassInQ273: false,
      canEnableRuntimeByDefaultInQ273: false,
      canImportCameraOutputWithoutUserApproval: false,
      prototypeLabel: input.prototypeLabel,
    );
  }
}
