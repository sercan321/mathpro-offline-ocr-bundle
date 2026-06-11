/// Static policy for V172-Q257 PP-FormulaNet-S download orchestrator UI guard.
///
/// Q257 is a user-facing orchestration guard only. It does not bind a
/// production model URL, does not implement a real network downloader, does
/// not add Paddle/PaddleOCR runtime dependencies, does not ship model bytes,
/// and does not run image-to-LaTeX inference. It defines the premium UI state
/// contract that must be satisfied before a later real downloader can be shown
/// to the user.
class GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy {
  const GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy._();

  static const phase = 'V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD';
  static const sourcePhase = 'V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK';
  static const sourcePackageSha256 = 'c243d6a54c2b0ce217a7f983a683669794b0b7eb80080a672462f6db1d328364';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';

  static const orchestratorMode = 'download-orchestrator-ui-guard-only-no-production-download';
  static const productionDownloadEnabled = false;
  static const productionModelUrlBound = false;
  static const realNetworkDownloadWorkerImplemented = false;
  static const modelBinaryBundledInBaseApp = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const productionInferenceAllowed = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;
  static const directWorkspaceImportAllowed = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;

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

  static const requiredUiCopyBlocks = <String>[
    'modelNotInstalledCopy',
    'downloadConsentCopy',
    'wifiOrNetworkPolicyCopy',
    'downloadingProgressCopy',
    'verifyingChecksumCopy',
    'checksumMismatchErrorCopy',
    'failedRetryCopy',
    'readyButReviewRequiredCopy',
  ];

  static const requiredOrchestratorSafetyGates = <String>[
    'q256ArtifactManifestShaGatePresent',
    'productionDownloadDisabledByDefault',
    'noProductionUrlUntilExpectedShaLocked',
    'userConsentBeforeDownloadUi',
    'wifiOrUnmeteredNetworkPolicyUi',
    'checksumMismatchBlocksReadyUi',
    'failedStateNeverPretendsReady',
    'readyStateDoesNotClaimOcrInference',
    'modelUnavailableBlocksScanToOcr',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalBeforeWorkspaceImport',
  ];

  static const forbiddenActions = <String>[
    'enableProductionDownloadInQ257',
    'bindProductionModelUrlInQ257',
    'implementRealNetworkDownloadWorkerInQ257',
    'bundlePpFormulaNetSModelInBaseApk',
    'addPaddleRuntimeDependency',
    'addPaddleOcrDependency',
    'runPpFormulaNetSInference',
    'showReadyStateAsOcrPass',
    'hideChecksumMismatchFromUser',
    'allowScanToOcrWhenModelUnavailable',
    'setWorkspaceLatexWithoutUserApproval',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeSolutionFromCamera',
    'writeHistoryFromCamera',
    'claimModelDownloadPassWithoutRealDownloaderEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
  ];
}
