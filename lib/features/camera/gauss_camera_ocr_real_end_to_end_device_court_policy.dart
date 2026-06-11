class GaussCameraOcrRealEndToEndDeviceCourtPolicy {
  const GaussCameraOcrRealEndToEndDeviceCourtPolicy._();

  static const String phase = 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT';
  static const String sourcePhase = 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const String courtMode = 'camera-ocr-real-end-to-end-device-court-gate-only-no-real-inference-no-runtime-pass';

  static const bool cameraOcrRealEndToEndDeviceCourtImplemented = true;
  static const bool requiresQ275ApprovedOcrWorkspaceImportGate = true;
  static const bool requiresCameraCaptureEvidence = true;
  static const bool requiresCropScanFrameEvidence = true;
  static const bool requiresQ273ImageToLatexCandidateEnvelope = true;
  static const bool requiresQ274MathLiveReviewBinding = true;
  static const bool requiresQ275ApprovedWorkspaceImportGate = true;
  static const bool editableMathLiveReviewRequired = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool workspaceImportDoesNotAutoEvaluate = true;
  static const bool workspaceImportDoesNotAutoSolve = true;
  static const bool workspaceImportDoesNotAutoGraph = true;
  static const bool workspaceImportDoesNotAutoWriteSolution = true;
  static const bool workspaceImportDoesNotAutoWriteHistory = true;
  static const bool directCameraSolveBlocked = true;
  static const bool directCameraGraphSolutionHistoryBlocked = true;
  static const bool realOcrRuntimeAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool nativeBridgeImplementationAdded = false;
  static const bool jniBindingAdded = false;
  static const bool methodChannelRuntimeBindingAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionModelUrlBound = false;
  static const bool realNetworkDownloadWorkerImplemented = false;
  static const bool productionDownloadEnabled = false;
  static const bool productionInferenceAllowed = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool realEndToEndDeviceCourtPassClaimed = false;
  static const bool ocrPassClaimed = false;
  static const bool premiumFinalPassClaimed = false;

  static const List<String> requiredRealDeviceCourtCases = <String>[
    'simpleArithmetic_2_plus_3',
    'quadratic_x_squared_plus_2x_plus_1',
    'fraction_one_over_two',
    'squareRoot_x_plus_1',
    'indefiniteIntegral_x_squared_dx',
    'definiteIntegral_zero_to_one_x_squared_dx',
    'primeDerivative_y_prime',
    'leibnizDerivative_dy_dx',
    'limit_sin_x_over_x',
    'sigma_sum_n_equals_1_to_10',
    'twoByTwoMatrix',
    'lowLightCapture',
    'skewedCapture',
    'mildBlurCapture',
    'notebookLineOrShadowCapture',
  ];

  static const List<String> requiredCourtGates = <String>[
    'q275ApprovedOcrWorkspaceImportGatePresent',
    'cameraCaptureEvidenceRequired',
    'cropScanFrameEvidenceRequired',
    'q273ImageToLatexCandidateEnvelopeRequired',
    'q274MathLiveReviewBindingRequired',
    'q275WorkspaceImportGateRequired',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequiredBeforeWorkspaceImport',
    'workspaceImportDoesNotAutoEvaluate',
    'workspaceImportDoesNotAutoSolve',
    'workspaceImportDoesNotAutoGraph',
    'workspaceImportDoesNotAutoWriteSolution',
    'workspaceImportDoesNotAutoWriteHistory',
    'directCameraSolveBlocked',
    'directCameraGraphSolutionHistoryBlocked',
    'realDeviceCaseMatrixRequired',
    'realFlutterAnalyzeLogRequired',
    'realFlutterTestLogRequired',
    'realFlutterRunLogRequired',
    'noPaddleRuntimeAddedInQ276',
    'noPaddleOcrDependencyAddedInQ276',
    'noNativeBridgeImplementationAddedInQ276',
    'noJniBindingAddedInQ276',
    'noMethodChannelRuntimeBindingAddedInQ276',
    'noModelBinaryBundledInQ276',
    'noProductionModelUrlBoundInQ276',
    'noRealDownloadWorkerInQ276',
    'noProductionInferenceInQ276',
    'noRealImageToLatexInferenceInQ276',
    'noEndToEndDevicePassClaimedWithoutRealEvidence',
    'noOcrPassClaimedWithoutRealInferenceEvidence',
  ];

  static const List<String> courtEvidenceFields = <String>[
    'deviceId',
    'androidApiLevel',
    'appPhase',
    'cameraCaptureEvidence',
    'cropScanFrameEvidence',
    'imageToLatexCandidateEnvelopeEvidence',
    'mathLiveReviewOpenedEvidence',
    'userEditedOrApprovedEvidence',
    'workspaceImportPreparedAfterApprovalEvidence',
    'autoEvaluateBlockedEvidence',
    'autoSolveBlockedEvidence',
    'autoGraphBlockedEvidence',
    'autoSolutionBlockedEvidence',
    'autoHistoryBlockedEvidence',
    'caseId',
    'inputCondition',
    'resultStatus',
    'latencyMs',
    'peakMemoryMb',
    'flutterAnalyzeLogReference',
    'flutterTestLogReference',
    'flutterRunLogReference',
  ];

  static const List<String> blockedUntilRealEvidence = <String>[
    'realCameraCaptureEvidence',
    'realCropScanFrameEvidence',
    'realQ273CandidateEnvelopeEvidence',
    'realQ274MathLiveReviewBindingEvidence',
    'realQ275ApprovedWorkspaceImportEvidence',
    'realExplicitUserApprovalEvidence',
    'realNoAutoEvaluateEvidence',
    'realNoAutoSolveEvidence',
    'realNoAutoGraphEvidence',
    'realNoAutoSolutionEvidence',
    'realNoAutoHistoryEvidence',
    'realDirectSolveBlockedEvidence',
    'realGraphSolutionHistoryBlockedEvidence',
    'realCaseMatrixEvidenceForAllRequiredCases',
    'realFlutterAnalyzeLog',
    'realFlutterTestLog',
    'realFlutterRunLog',
  ];

  static const List<String> forbiddenActions = <String>[
    'claimRealEndToEndDevicePassWithoutEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
    'addPaddleRuntimeDependencyInQ276',
    'addPaddleOcrDependencyInQ276',
    'addNativeBridgeImplementationInQ276',
    'bindRuntimeMethodChannelInQ276',
    'bundlePPFormulaNetSModelInBaseApk',
    'bindProductionModelUrlInQ276',
    'startRealNetworkDownloadInQ276',
    'runRealImageToLatexInferenceInQ276',
    'importCameraOutputWithoutMathLiveReview',
    'importCameraOutputWithoutUserApproval',
    'autoSolveCameraOutputAfterImport',
    'autoGraphCameraOutputAfterImport',
    'autoWriteSolutionOrHistoryAfterImport',
  ];
}
