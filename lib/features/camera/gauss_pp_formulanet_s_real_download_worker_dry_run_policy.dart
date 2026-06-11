class GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy {
  const GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy._();

  static const phase = 'V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN';
  static const sourcePhase = 'V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const dryRunMode = 'real-download-worker-dry-run-no-production-network';

  static const dryRunWorkerContractImplemented = true;
  static const productionDownloadEnabled = false;
  static const productionModelUrlBound = false;
  static const realNetworkDownloadWorkerImplemented = false;
  static const productionDownloadWorkerImplemented = false;
  static const modelBinaryBundledInBaseApp = false;
  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const productionInferenceAllowed = false;
  static const productionRuntimeBindingAllowed = false;
  static const productionMathLiveBridgeCalled = false;

  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
  static const directWorkspaceImportAllowed = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;

  static const guardedDryRunStates = <String>[
    'dryRunIdle',
    'dryRunTempFilePrepared',
    'dryRunPartialBytesWritten',
    'dryRunChecksumMismatch',
    'dryRunChecksumVerified',
    'dryRunAtomicMovePrepared',
    'dryRunReadySimulation',
    'dryRunFailedRetrySimulation',
  ];

  static const requiredDryRunSafetyGates = <String>[
    'q258ProductionArtifactResolverGatePresent',
    'downloadDisabledByDefault',
    'noProductionModelUrlBound',
    'noRealNetworkDownloadWorkerImplemented',
    'privateTemporaryAppStorageOnly',
    'partialDownloadCleanupDryRun',
    'checksumMismatchSimulation',
    'checksumMismatchBlocksReadyState',
    'checksumPassRequiredBeforeAtomicMove',
    'atomicMoveSimulationOnly',
    'failedRetryStateSimulation',
    'offlineReadyStateOnlyAfterVerifiedMove',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalRequired',
  ];

  static const requiredDryRunEvidence = <String>[
    'temporaryPathIsPrivateAppStorage',
    'partialFileCanBeDeletedOnFailure',
    'checksumMismatchNeverMarksReady',
    'atomicMoveDoesNotRunBeforeChecksumPass',
    'readyStateIsOnlyASimulationInQ259',
    'failedStateKeepsRetryAvailable',
    'dryRunDoesNotClaimModelDownloadPass',
    'dryRunDoesNotClaimOcrPass',
  ];

  static const forbiddenActions = <String>[
    'bindProductionModelUrlInQ259',
    'startProductionNetworkDownloadInQ259',
    'shipPpFormulaNetSModelBinaryInBaseApk',
    'addPaddleRuntimeDependencyInQ259',
    'addPaddleOcrDependencyInQ259',
    'runPpFormulaNetSInference',
    'claimModelDownloadPass',
    'claimOcrPass',
    'markReadyAfterChecksumMismatch',
    'atomicMoveBeforeChecksumPass',
    'writeModelOutsidePrivateAppStorage',
    'setWorkspaceLatexWithoutUserApproval',
    'solveCameraResultWithoutReview',
    'graphCameraResultWithoutReview',
    'writeSolutionFromCameraWithoutReview',
    'writeHistoryFromCameraWithoutReview',
  ];
}
