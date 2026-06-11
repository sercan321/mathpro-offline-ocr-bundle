/// V172-Q265 PP-FormulaNet-S runtime evidence acceptance court policy.
///
/// This phase defines the court that accepts or rejects future Q264 runtime
/// prototype evidence. It does not add Paddle/PaddleOCR runtime, JNI/native
/// bridge code, MethodChannel runtime binding, model bytes, production network
/// download, or image-to-LaTeX inference.
class GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy {
  const GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy._();

  static const phase = 'V172-Q265-PP-FORMULANET-S-RUNTIME-EVIDENCE-ACCEPTANCE-COURT';
  static const sourcePhase = 'V172-Q264-PP-FORMULANET-S-RUNTIME-PROTOTYPE-EVIDENCE-INTAKE-GATE';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const acceptanceCourtMode = 'runtime-evidence-acceptance-court-only-no-runtime-no-inference';

  static const runtimeEvidenceAcceptanceCourtImplemented = true;
  static const acceptsEvidenceOnlyAfterQ264Validation = true;
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
  static const runtimeEvidenceAcceptedWithoutCourt = false;
  static const ocrPassClaimed = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
  static const directCameraSolveBlocked = true;
  static const directCameraGraphSolutionHistoryBlocked = true;

  static const acceptanceStates = <String>[
    'rejectedMissingQ264IntakeGate',
    'rejectedMissingEvidenceJson',
    'rejectedMalformedSha256',
    'rejectedMissingDeviceAbiRuntimeEvidence',
    'rejectedMissingArtifactEvidence',
    'rejectedMissingBridgeEvidence',
    'rejectedLatencyBudget',
    'rejectedPeakMemoryBudget',
    'rejectedMissingMathLiveReviewEvidence',
    'rejectedMissingDirectSolveBlockedEvidence',
    'rejectedMissingFlutterAnalyzeTestRunLogs',
    'acceptedForPrototypeReviewOnlyRuntimeStillDisabled',
  ];

  static const requiredAcceptanceGates = <String>[
    'q264EvidenceIntakeGatePresent',
    'evidenceJsonSchemaValidated',
    'deviceIdPresent',
    'androidApiLevelPresent',
    'androidAbiPresent',
    'runtimeCandidatePresent',
    'privateArtifactPathPresent',
    'artifactSha256MustBe64Hex',
    'modelFormatProbeAccepted',
    'bridgeInputOutputHashesPresent',
    'bridgeInvocationStatusAccepted',
    'latencyWithinBudget',
    'peakMemoryWithinBudget',
    'timeoutCancellationRecorded',
    'bridgeErrorCodeRecorded',
    'mathLiveReviewOpenedTrue',
    'directSolveBlockedTrue',
    'flutterAnalyzeTestRunLogsPresent',
    'noRuntimePassWithoutAcceptedEvidence',
    'noOcrPassWithoutRealInferenceEvidence',
  ];

  static const rejectionReasons = <String>[
    'missingQ264IntakeGate',
    'missingEvidenceJson',
    'malformedArtifactSha256',
    'missingDeviceAbiRuntimeEvidence',
    'missingArtifactEvidence',
    'missingBridgeEvidence',
    'latencyBudgetExceededOrMissing',
    'peakMemoryBudgetExceededOrMissing',
    'missingMathLiveReviewOpenedEvidence',
    'missingDirectSolveBlockedEvidence',
    'missingFlutterAnalyzeTestRunLogs',
    'attemptedRuntimePassWithoutCourtAcceptance',
    'attemptedOcrPassWithoutRealInferenceEvidence',
  ];

  static const blockedUntilRealEvidence = <String>[
    'acceptedQ264EvidenceJson',
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
    'addPaddleRuntimeInQ265',
    'addPaddleOcrDependencyInQ265',
    'addJniBindingInQ265',
    'bindRuntimeMethodChannelInQ265',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ265',
    'startRealNetworkDownloadInQ265',
    'runPpFormulaNetSInferenceInQ265',
    'acceptEvidenceWithoutQ264Validation',
    'claimRuntimeSmokePassWithoutAcceptedEvidence',
    'claimOcrPassWithoutInferenceEvidence',
    'importCameraOutputWithoutMathLiveReview',
    'solveGraphSolutionHistoryFromCameraWithoutUserApproval',
  ];

  static const latencyBudgetMs = 2500;
  static const peakMemoryBudgetMb = 512;

  static bool isValidSha256(String value) => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value);
}
