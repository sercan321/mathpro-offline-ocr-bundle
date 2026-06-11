import 'gauss_pp_formulanet_s_runtime_evidence_acceptance_court_policy.dart';

enum GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision {
  rejectedMissingQ264IntakeGate,
  rejectedMissingEvidenceJson,
  rejectedMalformedSha256,
  rejectedMissingDeviceAbiRuntimeEvidence,
  rejectedMissingArtifactEvidence,
  rejectedMissingBridgeEvidence,
  rejectedLatencyBudget,
  rejectedPeakMemoryBudget,
  rejectedMissingMathLiveReviewEvidence,
  rejectedMissingDirectSolveBlockedEvidence,
  rejectedMissingFlutterAnalyzeTestRunLogs,
  rejectedUnsafeRuntimeBinding,
  runtimeEvidenceAcceptedForPrototypeReviewOnly,
}

class GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtInput {
  const GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtInput({
    required this.q264EvidenceIntakeGatePresent,
    required this.evidenceJsonPresent,
    required this.evidenceJsonSchemaValidated,
    required this.deviceIdPresent,
    required this.androidApiLevelPresent,
    required this.androidAbiPresent,
    required this.runtimeCandidatePresent,
    required this.privateArtifactPathPresent,
    required this.artifactSha256Candidate,
    required this.modelFormatProbeAccepted,
    required this.bridgeInputEnvelopeHashPresent,
    required this.bridgeOutputEnvelopeHashPresent,
    required this.bridgeInvocationStatusAccepted,
    required this.latencyMs,
    required this.peakMemoryMb,
    required this.timeoutCancellationRecorded,
    required this.bridgeErrorCodeRecorded,
    required this.mathLiveReviewOpened,
    required this.directSolveBlocked,
    required this.flutterAnalyzeLogPresent,
    required this.flutterTestLogPresent,
    required this.flutterRunLogPresent,
    required this.noPaddleRuntimeDependencyAdded,
    required this.noPaddleOcrDependencyAdded,
    required this.noNativeBridgeAdded,
    required this.noJniBindingAdded,
    required this.noMethodChannelRuntimeBindingAdded,
    required this.noModelBinaryBundledInBaseApp,
    required this.noProductionModelUrlBound,
    required this.noRealNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.noProductionInferenceAllowed,
    required this.runtimeSmokePassClaimed,
    required this.ocrPassClaimed,
    required this.evidenceAcceptedWithoutCourt,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.acceptanceLabel,
  });

  final bool q264EvidenceIntakeGatePresent;
  final bool evidenceJsonPresent;
  final bool evidenceJsonSchemaValidated;
  final bool deviceIdPresent;
  final bool androidApiLevelPresent;
  final bool androidAbiPresent;
  final bool runtimeCandidatePresent;
  final bool privateArtifactPathPresent;
  final String artifactSha256Candidate;
  final bool modelFormatProbeAccepted;
  final bool bridgeInputEnvelopeHashPresent;
  final bool bridgeOutputEnvelopeHashPresent;
  final bool bridgeInvocationStatusAccepted;
  final int latencyMs;
  final int peakMemoryMb;
  final bool timeoutCancellationRecorded;
  final bool bridgeErrorCodeRecorded;
  final bool mathLiveReviewOpened;
  final bool directSolveBlocked;
  final bool flutterAnalyzeLogPresent;
  final bool flutterTestLogPresent;
  final bool flutterRunLogPresent;
  final bool noPaddleRuntimeDependencyAdded;
  final bool noPaddleOcrDependencyAdded;
  final bool noNativeBridgeAdded;
  final bool noJniBindingAdded;
  final bool noMethodChannelRuntimeBindingAdded;
  final bool noModelBinaryBundledInBaseApp;
  final bool noProductionModelUrlBound;
  final bool noRealNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool noProductionInferenceAllowed;
  final bool runtimeSmokePassClaimed;
  final bool ocrPassClaimed;
  final bool evidenceAcceptedWithoutCourt;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final String acceptanceLabel;
}

class GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtResult {
  const GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtResult._({
    required this.decision,
    required this.runtimeEvidenceAcceptanceCourtStaticReady,
    required this.acceptedForPrototypeReviewOnly,
    required this.rejectionReasons,
    required this.canClaimRuntimeSmokePassInQ265,
    required this.canClaimOcrPassInQ265,
    required this.canAddPaddleRuntimeInQ265,
    required this.canBindRuntimeBridgeInQ265,
    required this.canImportCameraOutputWithoutUserApproval,
    required this.canAcceptEvidenceWithoutCourt,
    required this.acceptanceLabel,
  });

  final GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision decision;
  final bool runtimeEvidenceAcceptanceCourtStaticReady;
  final bool acceptedForPrototypeReviewOnly;
  final List<String> rejectionReasons;
  final bool canClaimRuntimeSmokePassInQ265;
  final bool canClaimOcrPassInQ265;
  final bool canAddPaddleRuntimeInQ265;
  final bool canBindRuntimeBridgeInQ265;
  final bool canImportCameraOutputWithoutUserApproval;
  final bool canAcceptEvidenceWithoutCourt;
  final String acceptanceLabel;

  String get phase => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.phase;
  String get sourcePhase => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.sourcePhase;
  String get selectedEngineLabel => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.selectedEngineLabel;
  String get acceptanceCourtMode => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.acceptanceCourtMode;
  List<String> get acceptanceStates => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.acceptanceStates;
  List<String> get requiredAcceptanceGates => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.requiredAcceptanceGates;
  List<String> get blockedUntilRealEvidence => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.forbiddenActions;
  bool get realOcrRuntimeAdded => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.realOcrRuntimeAdded;
  bool get paddleRuntimeAdded => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.paddleRuntimeAdded;
  bool get paddleOcrDependencyAdded => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.paddleOcrDependencyAdded;
  bool get nativeBridgeAdded => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.nativeBridgeAdded;
  bool get jniBindingAdded => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.jniBindingAdded;
  bool get methodChannelRuntimeBindingAdded => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.methodChannelRuntimeBindingAdded;
  bool get modelBinaryBundledInBaseApp => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.modelBinaryBundledInBaseApp;
  bool get productionModelUrlBound => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.productionModelUrlBound;
  bool get realNetworkDownloadWorkerImplemented => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.realNetworkDownloadWorkerImplemented;
  bool get productionDownloadEnabled => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.productionDownloadEnabled;
  bool get productionInferenceAllowed => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.productionInferenceAllowed;
  bool get runtimeSmokePassClaimed => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.runtimeSmokePassClaimed;
  bool get runtimeEvidenceAcceptedWithoutCourt => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.runtimeEvidenceAcceptedWithoutCourt;
  bool get ocrPassClaimed => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.ocrPassClaimed;
}

class GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourt {
  const GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourt._();

  static GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtResult evaluate(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtInput input) {
    GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtResult reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision decision, String reason) => GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtResult._(
      decision: decision,
      runtimeEvidenceAcceptanceCourtStaticReady: false,
      acceptedForPrototypeReviewOnly: false,
      rejectionReasons: <String>[reason],
      canClaimRuntimeSmokePassInQ265: false,
      canClaimOcrPassInQ265: false,
      canAddPaddleRuntimeInQ265: false,
      canBindRuntimeBridgeInQ265: false,
      canImportCameraOutputWithoutUserApproval: false,
      canAcceptEvidenceWithoutCourt: false,
      acceptanceLabel: input.acceptanceLabel,
    );

    if (!input.q264EvidenceIntakeGatePresent) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingQ264IntakeGate, 'missingQ264IntakeGate');
    if (!input.evidenceJsonPresent || !input.evidenceJsonSchemaValidated) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingEvidenceJson, 'missingEvidenceJson');
    if (!input.deviceIdPresent || !input.androidApiLevelPresent || !input.androidAbiPresent || !input.runtimeCandidatePresent) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingDeviceAbiRuntimeEvidence, 'missingDeviceAbiRuntimeEvidence');
    if (!input.privateArtifactPathPresent || !GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.isValidSha256(input.artifactSha256Candidate)) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMalformedSha256, 'malformedArtifactSha256');
    if (!input.modelFormatProbeAccepted) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingArtifactEvidence, 'missingArtifactEvidence');
    if (!input.bridgeInputEnvelopeHashPresent || !input.bridgeOutputEnvelopeHashPresent || !input.bridgeInvocationStatusAccepted) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingBridgeEvidence, 'missingBridgeEvidence');
    if (input.latencyMs <= 0 || input.latencyMs > GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.latencyBudgetMs) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedLatencyBudget, 'latencyBudgetExceededOrMissing');
    if (input.peakMemoryMb <= 0 || input.peakMemoryMb > GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.peakMemoryBudgetMb) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedPeakMemoryBudget, 'peakMemoryBudgetExceededOrMissing');
    if (!input.timeoutCancellationRecorded || !input.bridgeErrorCodeRecorded) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingBridgeEvidence, 'missingTimeoutOrBridgeErrorEvidence');
    if (!input.mathLiveReviewOpened || !input.editableMathLiveReviewRequired) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingMathLiveReviewEvidence, 'missingMathLiveReviewOpenedEvidence');
    if (!input.directSolveBlocked || !input.userApprovalRequiredBeforeWorkspaceImport) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingDirectSolveBlockedEvidence, 'missingDirectSolveBlockedEvidence');
    if (!input.flutterAnalyzeLogPresent || !input.flutterTestLogPresent || !input.flutterRunLogPresent) return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingFlutterAnalyzeTestRunLogs, 'missingFlutterAnalyzeTestRunLogs');
    if (!input.noPaddleRuntimeDependencyAdded || !input.noPaddleOcrDependencyAdded || !input.noNativeBridgeAdded || !input.noJniBindingAdded || !input.noMethodChannelRuntimeBindingAdded || !input.noModelBinaryBundledInBaseApp || !input.noProductionModelUrlBound || !input.noRealNetworkDownloadWorkerImplemented || input.productionDownloadEnabled || !input.noProductionInferenceAllowed || input.runtimeSmokePassClaimed || input.ocrPassClaimed || input.evidenceAcceptedWithoutCourt) {
      return reject(GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedUnsafeRuntimeBinding, 'unsafeRuntimeBindingOrFalsePassClaim');
    }

    return GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtResult._(
      decision: GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.runtimeEvidenceAcceptedForPrototypeReviewOnly,
      runtimeEvidenceAcceptanceCourtStaticReady: true,
      acceptedForPrototypeReviewOnly: true,
      rejectionReasons: const <String>[],
      canClaimRuntimeSmokePassInQ265: false,
      canClaimOcrPassInQ265: false,
      canAddPaddleRuntimeInQ265: false,
      canBindRuntimeBridgeInQ265: false,
      canImportCameraOutputWithoutUserApproval: false,
      canAcceptEvidenceWithoutCourt: false,
      acceptanceLabel: input.acceptanceLabel,
    );
  }
}
