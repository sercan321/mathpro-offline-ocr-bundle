import 'gauss_pp_formulanet_s_runtime_prototype_evidence_intake_gate_policy.dart';

enum GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision {
  blockedMissingQ263Template,
  blockedMissingIntakeState,
  blockedMissingEvidenceJsonSchema,
  blockedMissingDeviceAndAbiEvidence,
  blockedMissingArtifactEvidence,
  blockedMissingBridgeEvidence,
  blockedMissingPerformanceEvidence,
  blockedMissingSafetyEvidence,
  blockedUnsafeRuntimeBinding,
  runtimePrototypeEvidenceIntakeGateStaticReady,
}

class GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateInput {
  const GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateInput({
    required this.q263SmokeEvidenceTemplatePresent,
    required this.intakeState,
    required this.allIntakeStatesRepresented,
    required this.evidenceJsonSchemaRequired,
    required this.evidenceJsonVersionRequired,
    required this.deviceIdRequired,
    required this.androidApiAndAbiRequired,
    required this.runtimeCandidateRequired,
    required this.privateArtifactPathRequired,
    required this.artifactSha256Candidate,
    required this.modelFormatProbeRecorded,
    required this.bridgeInputEnvelopeHashRequired,
    required this.bridgeOutputEnvelopeHashRequired,
    required this.bridgeInvocationStatusRequired,
    required this.latencyMeasurementRequired,
    required this.peakMemoryMeasurementRequired,
    required this.timeoutCancellationStatusRequired,
    required this.bridgeErrorCodeRequired,
    required this.mathLiveReviewOpenedMustBeTrue,
    required this.directSolveBlockedMustBeTrue,
    required this.flutterAnalyzeTestRunLogReferenceRequired,
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
    required this.evidenceAcceptedWithoutValidation,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.intakeLabel,
  });

  final bool q263SmokeEvidenceTemplatePresent;
  final String intakeState;
  final bool allIntakeStatesRepresented;
  final bool evidenceJsonSchemaRequired;
  final bool evidenceJsonVersionRequired;
  final bool deviceIdRequired;
  final bool androidApiAndAbiRequired;
  final bool runtimeCandidateRequired;
  final bool privateArtifactPathRequired;
  final String artifactSha256Candidate;
  final bool modelFormatProbeRecorded;
  final bool bridgeInputEnvelopeHashRequired;
  final bool bridgeOutputEnvelopeHashRequired;
  final bool bridgeInvocationStatusRequired;
  final bool latencyMeasurementRequired;
  final bool peakMemoryMeasurementRequired;
  final bool timeoutCancellationStatusRequired;
  final bool bridgeErrorCodeRequired;
  final bool mathLiveReviewOpenedMustBeTrue;
  final bool directSolveBlockedMustBeTrue;
  final bool flutterAnalyzeTestRunLogReferenceRequired;
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
  final bool evidenceAcceptedWithoutValidation;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final String intakeLabel;

  bool get intakeStateKnown => GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.intakeStates.contains(intakeState);
  bool get hasIntakeLabel => intakeLabel.trim().isNotEmpty;
  bool get intakeStatePresent => intakeStateKnown && allIntakeStatesRepresented && hasIntakeLabel;
  bool get evidenceSchemaPresent => evidenceJsonSchemaRequired && evidenceJsonVersionRequired;
  bool get deviceAndAbiEvidencePresent => deviceIdRequired && androidApiAndAbiRequired && runtimeCandidateRequired;
  bool get artifactEvidencePresent => privateArtifactPathRequired && GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.isValidSha256(artifactSha256Candidate) && modelFormatProbeRecorded;
  bool get bridgeEvidencePresent => bridgeInputEnvelopeHashRequired && bridgeOutputEnvelopeHashRequired && bridgeInvocationStatusRequired && bridgeErrorCodeRequired;
  bool get performanceEvidencePresent => latencyMeasurementRequired && peakMemoryMeasurementRequired && timeoutCancellationStatusRequired;
  bool get safetyEvidencePresent => mathLiveReviewOpenedMustBeTrue && directSolveBlockedMustBeTrue && flutterAnalyzeTestRunLogReferenceRequired && editableMathLiveReviewRequired && userApprovalRequiredBeforeWorkspaceImport;
  bool get unsafeRuntimeBindingAbsent =>
      noPaddleRuntimeDependencyAdded &&
      noPaddleOcrDependencyAdded &&
      noNativeBridgeAdded &&
      noJniBindingAdded &&
      noMethodChannelRuntimeBindingAdded &&
      noModelBinaryBundledInBaseApp &&
      noProductionModelUrlBound &&
      noRealNetworkDownloadWorkerImplemented &&
      productionDownloadEnabled == false &&
      noProductionInferenceAllowed &&
      runtimeSmokePassClaimed == false &&
      ocrPassClaimed == false &&
      evidenceAcceptedWithoutValidation == false;
}

class GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateResult {
  const GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.fallbackEngineLabel,
    required this.evidenceIntakeMode,
    required this.intakeStates,
    required this.requiredEvidenceJsonFields,
    required this.requiredIntakeValidationGates,
    required this.blockedUntilRealEvidence,
    required this.forbiddenActions,
    required this.runtimePrototypeEvidenceIntakeGateImplemented,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.nativeBridgeAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.realNetworkDownloadWorkerImplemented,
    required this.productionDownloadEnabled,
    required this.productionInferenceAllowed,
    required this.runtimeSmokePassClaimed,
    required this.runtimeEvidenceAcceptedWithoutValidation,
    required this.ocrPassClaimed,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
  });

  final String phase;
  final String sourcePhase;
  final GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision decision;
  final GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final String fallbackEngineLabel;
  final String evidenceIntakeMode;
  final List<String> intakeStates;
  final List<String> requiredEvidenceJsonFields;
  final List<String> requiredIntakeValidationGates;
  final List<String> blockedUntilRealEvidence;
  final List<String> forbiddenActions;
  final bool runtimePrototypeEvidenceIntakeGateImplemented;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool nativeBridgeAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool realNetworkDownloadWorkerImplemented;
  final bool productionDownloadEnabled;
  final bool productionInferenceAllowed;
  final bool runtimeSmokePassClaimed;
  final bool runtimeEvidenceAcceptedWithoutValidation;
  final bool ocrPassClaimed;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get runtimePrototypeEvidenceIntakeGateStaticReady =>
      decision == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.runtimePrototypeEvidenceIntakeGateStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.selectedEngineLabel &&
      fallbackEngineLabel == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.fallbackEngineLabel &&
      evidenceIntakeMode == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.evidenceIntakeMode &&
      intakeStates.length == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.intakeStates.length &&
      requiredEvidenceJsonFields.length == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.requiredEvidenceJsonFields.length &&
      requiredIntakeValidationGates.length == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.requiredIntakeValidationGates.length &&
      blockedUntilRealEvidence.length == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.blockedUntilRealEvidence.length &&
      forbiddenActions.length == GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.forbiddenActions.length &&
      runtimePrototypeEvidenceIntakeGateImplemented &&
      realOcrRuntimeAdded == false &&
      paddleRuntimeAdded == false &&
      paddleOcrDependencyAdded == false &&
      nativeBridgeAdded == false &&
      jniBindingAdded == false &&
      methodChannelRuntimeBindingAdded == false &&
      modelBinaryBundledInBaseApp == false &&
      productionModelUrlBound == false &&
      realNetworkDownloadWorkerImplemented == false &&
      productionDownloadEnabled == false &&
      productionInferenceAllowed == false &&
      runtimeSmokePassClaimed == false &&
      runtimeEvidenceAcceptedWithoutValidation == false &&
      ocrPassClaimed == false &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport;

  bool get canAcceptEvidenceWithoutValidation => false;
  bool get canClaimRuntimeSmokePassInQ264 => false;
  bool get canClaimOcrPassInQ264 => false;
  bool get canAddPaddleRuntimeInQ264 => false;
  bool get canBindRuntimeBridgeInQ264 => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
}

/// Q264 PP-FormulaNet-S runtime prototype evidence intake gate.
///
/// It validates the intake shape for future real-device runtime smoke evidence,
/// but deliberately keeps runtime/dependency/model/download/inference paths
/// disabled in this phase.
class GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGate {
  const GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGate._();

  static const phase = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.phase;
  static const sourcePhase = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.sourcePhase;
  static const selectedEngineLabel = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.fallbackEngineLabel;

  static const implementsRuntimePrototypeEvidenceIntakeGateInQ264 = true;
  static const addsPaddleRuntimeInQ264 = false;
  static const addsPaddleOcrDependencyInQ264 = false;
  static const addsNativeBridgeInQ264 = false;
  static const addsJniBindingInQ264 = false;
  static const bindsRuntimeMethodChannelInQ264 = false;
  static const acceptsRuntimeEvidenceWithoutValidationInQ264 = false;
  static const allowsRuntimeSmokePassClaimInQ264 = false;
  static const allowsOcrPassClaimInQ264 = false;
  static const allowsProductionInferenceInQ264 = false;

  static GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateResult evaluate(GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateInput input) {
    final issues = <String>[];
    if (!input.q263SmokeEvidenceTemplatePresent) {
      issues.add('Q264 requires Q263 smoke evidence template before intake gate work.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingQ263Template);
    }
    if (!input.intakeStatePresent) {
      issues.add('Q264 requires a known intake state and non-empty label.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingIntakeState);
    }
    if (!input.evidenceSchemaPresent) {
      issues.add('Q264 requires evidence JSON schema and version fields.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingEvidenceJsonSchema);
    }
    if (!input.deviceAndAbiEvidencePresent) {
      issues.add('Q264 requires device, Android API/ABI, and runtime candidate evidence fields.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingDeviceAndAbiEvidence);
    }
    if (!input.artifactEvidencePresent) {
      issues.add('Q264 requires private artifact path, exact 64-hex SHA256, and model-format probe evidence.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingArtifactEvidence);
    }
    if (!input.bridgeEvidencePresent) {
      issues.add('Q264 requires bridge input/output hash, invocation status, and error-code evidence fields.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingBridgeEvidence);
    }
    if (!input.performanceEvidencePresent) {
      issues.add('Q264 requires latency, peak-memory, and timeout/cancellation evidence fields.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingPerformanceEvidence);
    }
    if (!input.safetyEvidencePresent) {
      issues.add('Q264 requires MathLive review opened, direct solve blocked, Flutter log reference, and user approval safety fields.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingSafetyEvidence);
    }
    if (!input.unsafeRuntimeBindingAbsent) {
      issues.add('Q264 must not add runtime/dependency/model/download/inference binding or accept evidence without validation.');
      return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedUnsafeRuntimeBinding);
    }
    return _result(input, issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.runtimePrototypeEvidenceIntakeGateStaticReady);
  }

  static GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateResult _result(GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateInput input, List<String> issues, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision decision) {
    return GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateResult(
      phase: phase,
      sourcePhase: sourcePhase,
      decision: decision,
      input: input,
      issues: List.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      fallbackEngineLabel: fallbackEngineLabel,
      evidenceIntakeMode: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.evidenceIntakeMode,
      intakeStates: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.intakeStates,
      requiredEvidenceJsonFields: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.requiredEvidenceJsonFields,
      requiredIntakeValidationGates: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.requiredIntakeValidationGates,
      blockedUntilRealEvidence: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.blockedUntilRealEvidence,
      forbiddenActions: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.forbiddenActions,
      runtimePrototypeEvidenceIntakeGateImplemented: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.runtimePrototypeEvidenceIntakeGateImplemented,
      realOcrRuntimeAdded: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.realOcrRuntimeAdded,
      paddleRuntimeAdded: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.paddleRuntimeAdded,
      paddleOcrDependencyAdded: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.paddleOcrDependencyAdded,
      nativeBridgeAdded: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.nativeBridgeAdded,
      jniBindingAdded: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.jniBindingAdded,
      methodChannelRuntimeBindingAdded: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.methodChannelRuntimeBindingAdded,
      modelBinaryBundledInBaseApp: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.modelBinaryBundledInBaseApp,
      productionModelUrlBound: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.productionModelUrlBound,
      realNetworkDownloadWorkerImplemented: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.realNetworkDownloadWorkerImplemented,
      productionDownloadEnabled: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.productionDownloadEnabled,
      productionInferenceAllowed: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.productionInferenceAllowed,
      runtimeSmokePassClaimed: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.runtimeSmokePassClaimed,
      runtimeEvidenceAcceptedWithoutValidation: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.runtimeEvidenceAcceptedWithoutValidation,
      ocrPassClaimed: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.ocrPassClaimed,
      editableMathLiveReviewRequired: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.editableMathLiveReviewRequired,
      userApprovalRequiredBeforeWorkspaceImport: GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.userApprovalRequiredBeforeWorkspaceImport,
    );
  }
}
