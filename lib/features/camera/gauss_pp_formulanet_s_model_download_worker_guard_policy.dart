/// Static policy for V172-Q255 PP-FormulaNet-S model download worker guard.
///
/// This phase intentionally does not bind a production model URL, does not
/// implement a real network downloader, does not bundle PP-FormulaNet-S model
/// bytes, and does not run inference. It defines the safety contract that a
/// later real downloader must satisfy before any model artifact can become
/// ready for OCR runtime use.
class GaussPpFormulaNetSModelDownloadWorkerGuardPolicy {
  const GaussPpFormulaNetSModelDownloadWorkerGuardPolicy._();

  static const phase = 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD';
  static const sourcePhase = 'V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';

  static const downloadWorkerGuardMode = 'guard-only-no-production-network-download';
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const realNetworkDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
  static const directWorkspaceImportAllowed = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;

  static const officialSourceEvidenceRequired = true;
  static const expectedSha256RequiredBeforeDownload = true;
  static const actualSha256RequiredAfterDownload = true;
  static const privateAppStorageRequired = true;
  static const temporaryDownloadPathRequired = true;
  static const atomicMoveAfterVerifyRequired = true;
  static const corruptDownloadCleanupRequired = true;
  static const partialDownloadCleanupRequired = true;
  static const offlineAfterInstallRequired = true;
  static const networkPolicyRequired = true;
  static const userConsentOrWifiGateRequired = true;

  static const guardedInstallStates = <String>[
    'notInstalled',
    'queued',
    'downloading',
    'verifying',
    'ready',
    'failed',
    'updateAvailable',
    'disabledByUser',
  ];

  static const requiredWorkerSafetyGates = <String>[
    'officialSourceEvidenceVerified',
    'expectedSha256RecordedBeforeDownload',
    'actualSha256VerifiedAfterDownload',
    'downloadIntoTemporaryPrivateFile',
    'atomicMoveOnlyAfterChecksumPass',
    'deletePartialDownloadOnFailure',
    'deleteCorruptArtifactOnChecksumMismatch',
    'neverUseUnverifiedModel',
    'offlineAfterInstallReadyState',
    'noBaseApkModelBundle',
    'noProductionUrlWithoutChecksum',
    'noProductionInferenceBeforeRuntimeEvidence',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalBeforeWorkspaceImport',
  ];
}
