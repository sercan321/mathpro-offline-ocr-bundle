/// V172-Q264 PP-FormulaNet-S runtime prototype evidence intake gate policy.
///
/// This phase defines the intake/validation gate for future real-device smoke
/// evidence JSON/logs. It does not add Paddle/PaddleOCR runtime, JNI/native
/// bridge code, MethodChannel runtime binding, model bytes, production network
/// download, or image-to-LaTeX inference.
class GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy {
  const GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy._();

  static const phase = 'V172-Q264-PP-FORMULANET-S-RUNTIME-PROTOTYPE-EVIDENCE-INTAKE-GATE';
  static const sourcePhase = 'V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const evidenceIntakeMode = 'runtime-prototype-evidence-intake-gate-only-no-runtime-no-inference';

  static const runtimePrototypeEvidenceIntakeGateImplemented = true;
  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const nativeBridgeAdded = false;
  static const jniBindingAdded = false;
  static const methodChannelRuntimeBindingAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const realNetworkDownloadWorkerImplemented = false;
  static const productionDownloadEnabled = false;
  static const productionInferenceAllowed = false;
  static const runtimeSmokePassClaimed = false;
  static const runtimeEvidenceAcceptedWithoutValidation = false;
  static const ocrPassClaimed = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;

  static const intakeStates = <String>[
    'intakeBlockedMissingQ263Template',
    'intakeBlockedMissingEvidenceJsonSchema',
    'intakeBlockedMissingDeviceAndAbiEvidence',
    'intakeBlockedMissingArtifactEvidence',
    'intakeBlockedMissingBridgeEvidence',
    'intakeBlockedMissingPerformanceEvidence',
    'intakeBlockedMissingSafetyEvidence',
    'intakeTemplateReadyButRuntimeDisabled',
  ];

  static const requiredEvidenceJsonFields = <String>[
    'deviceId',
    'appVersionPhase',
    'androidApiLevel',
    'androidAbi',
    'runtimeCandidate',
    'privateArtifactPath',
    'artifactSha256',
    'modelFormatProbeResult',
    'bridgeInputEnvelopeHash',
    'bridgeOutputEnvelopeHash',
    'bridgeInvocationStatus',
    'latencyMs',
    'peakMemoryMb',
    'timeoutCancellationStatus',
    'bridgeErrorCode',
    'mathLiveReviewOpened',
    'directSolveBlocked',
    'flutterAnalyzeTestRunLogReference',
  ];

  static const requiredIntakeValidationGates = <String>[
    'q263SmokeEvidenceTemplatePresent',
    'evidenceJsonSchemaRequired',
    'evidenceJsonVersionRequired',
    'deviceIdRequired',
    'androidApiAndAbiRequired',
    'runtimeCandidateRequired',
    'privateArtifactPathRequired',
    'artifactSha256MustBe64Hex',
    'modelFormatProbeMustBeRecorded',
    'bridgeInputOutputHashesRequired',
    'bridgeInvocationStatusRequired',
    'latencyAndPeakMemoryRequired',
    'timeoutCancellationStatusRequired',
    'bridgeErrorCodeRequired',
    'mathLiveReviewOpenedMustBeTrue',
    'directSolveBlockedMustBeTrue',
    'flutterAnalyzeTestRunLogReferenceRequired',
    'noRuntimeSmokePassWithoutAcceptedEvidence',
    'noOcrPassWithoutRealInferenceEvidence',
  ];

  static const blockedUntilRealEvidence = <String>[
    'realDeviceSmokeEvidenceJsonFile',
    'realFlutterAnalyzeLog',
    'realFlutterTestLog',
    'realFlutterRunLog',
    'realAndroidAbiMatrixCapture',
    'realArtifactSha256Capture',
    'realModelFormatProbeLog',
    'realBridgeInvocationLog',
    'realLatencyMeasurementLog',
    'realPeakMemoryMeasurementLog',
    'realTimeoutCancellationLog',
    'realMathLiveReviewOpenedEvidence',
    'realDirectSolveBlockedEvidence',
  ];

  static const forbiddenActions = <String>[
    'addPaddleRuntimeInQ264',
    'addPaddleOcrDependencyInQ264',
    'addJniBindingInQ264',
    'bindRuntimeMethodChannelInQ264',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ264',
    'startRealNetworkDownloadInQ264',
    'runPpFormulaNetSInferenceInQ264',
    'acceptRuntimeEvidenceWithoutSchemaValidation',
    'claimRuntimeSmokePassWithoutAcceptedEvidence',
    'claimOcrPassWithoutInferenceEvidence',
    'importCameraOutputWithoutMathLiveReview',
    'solveGraphSolutionHistoryFromCameraWithoutUserApproval',
  ];

  static bool isValidSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);
}
