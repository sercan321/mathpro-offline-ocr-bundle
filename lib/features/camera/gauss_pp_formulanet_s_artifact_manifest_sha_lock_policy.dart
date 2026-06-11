/// Static policy for V172-Q256 PP-FormulaNet-S artifact manifest and SHA lock.
///
/// Q256 is a manifest/SHA-lock gate only. It does not bind a production model
/// URL, does not ship model bytes, does not implement a real downloader, does
/// not add Paddle/PaddleOCR runtime dependencies, and does not run inference.
/// It records the artifact-manifest fields and checksum obligations that must
/// be satisfied before any later downloader can fetch or promote a model.
class GaussPpFormulaNetSArtifactManifestShaLockPolicy {
  const GaussPpFormulaNetSArtifactManifestShaLockPolicy._();

  static const phase = 'V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK';
  static const sourcePhase = 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD';
  static const sourcePackageSha256 = '4fa66118e537afdc2b962b148a60c7a22c58752562eb10cbe110dcbdbff51343';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';

  static const artifactManifestMode = 'artifact-manifest-and-sha-lock-gate-only-no-production-download';
  static const officialArtifactManifestRequired = true;
  static const artifactSourceLabelRequired = true;
  static const artifactVersionLabelRequired = true;
  static const licenseLabelRequired = true;
  static const modelStorageSizeBudgetRequired = true;
  static const expectedSha256LockRequiredBeforeDownload = true;
  static const expectedSha256MustBeSixtyFourHex = true;
  static const checksumMismatchMustBlockReadyState = true;
  static const artifactManifestMustRemainDisabledByDefault = true;
  static const productionModelUrlBound = false;
  static const expectedProductionSha256LockedInQ256 = false;
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

  static const requiredArtifactManifestFields = <String>[
    'engineLabel',
    'artifactSourceLabel',
    'artifactVersionLabel',
    'licenseLabel',
    'modelStorageSizeBytes',
    'expectedSha256',
    'expectedSha256Status',
    'productionDownloadEnabled',
    'privateStorageDestination',
    'checksumMismatchBehavior',
    'offlineAfterInstallBehavior',
    'mathLiveReviewRequired',
    'userApprovalRequiredBeforeWorkspaceImport',
  ];

  static const blockedUntilRealEvidence = <String>[
    'officialArtifactUrlVerified',
    'expectedSha256LockedFromOfficialArtifact',
    'artifactSizeVerified',
    'licenseDistributionVerified',
    'androidRuntimeFeasibilityVerified',
    'latencyAndMemoryBudgetVerified',
    'realDownloaderEvidence',
    'realPpFormulaNetSInferenceEvidence',
  ];

  static const forbiddenActions = <String>[
    'bindProductionModelUrlInQ256',
    'storePlaceholderShaAsReady',
    'acceptNonHexSha256',
    'downloadModelWithoutExpectedSha256',
    'promoteArtifactOnChecksumMismatch',
    'bundleModelInBaseApk',
    'addPaddleRuntimeDependency',
    'addPaddleOcrDependency',
    'runPpFormulaNetSInference',
    'setWorkspaceLatexWithoutUserApproval',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeSolutionFromCamera',
    'writeHistoryFromCamera',
    'claimModelDownloadPassWithoutRealDownloaderEvidence',
    'claimOcrPassWithoutRealInferenceEvidence',
  ];
}
