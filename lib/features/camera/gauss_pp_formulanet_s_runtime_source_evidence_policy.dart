/// V172-Q254 — PP-FormulaNet-S Runtime Source Evidence Gate policy.
///
/// Q254 is the first real-runtime preparation gate after Q253 Android
/// toolchain modernization. It records the official/source-evidence obligations
/// for PP-FormulaNet-S without binding Paddle runtime, without adding a model
/// binary, without setting a production model URL, without creating a download
/// worker, and without running image-to-LaTeX inference. Runtime integration is
/// blocked until source, license, artifact, checksum, storage, latency, and
/// MathLive-review requirements are all proven.
class GaussPpFormulaNetSRuntimeSourceEvidencePolicy {
  const GaussPpFormulaNetSRuntimeSourceEvidencePolicy._();

  static const phase = 'V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE';
  static const sourcePhase = 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
  static const sourcePackageSha256 = '329d317c4462c5d3d3e28660ab3e0d9fb19e50b8d72cc7990e59fce821f00cd7';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const evidenceMode = 'official-model-source-license-artifact-runtime-gate';

  static const officialPaddleOcrDocumentationRequired = true;
  static const officialPaddleXDocumentationRequired = true;
  static const officialModelRepositoryRequired = true;
  static const apache2LicenseEvidenceRequired = true;
  static const modelStorageSizeEvidenceRequired = true;
  static const expectedSha256RequiredBeforeDownload = true;
  static const actualSha256RequiredAfterDownload = true;
  static const privateAppStorageRequired = true;
  static const offlineAfterInstallRequired = true;
  static const androidRuntimeFeasibilityEvidenceRequired = true;
  static const latencyAndMemoryEvidenceRequired = true;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;

  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const productionDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;
  static const productionRuntimeBindingAllowed = false;
  static const productionMathLiveBridgeCalled = false;

  static const directWorkspaceImportAllowed = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;

  static const officialSourceEvidenceRequirements = <String>[
    'officialPaddleOcrFormulaRecognitionDocumentation',
    'officialPaddleXFormulaRecognitionDocumentation',
    'officialPaddlePaddleModelRepository',
    'apache2LicenseEvidence',
    'modelStorageSizeEvidence',
    'runtimeDistributionFeasibilityEvidence',
    'androidDeviceRuntimeFeasibilityEvidence',
    'expectedSha256BeforeDownload',
    'actualSha256AfterDownload',
    'privateAppStoragePlan',
    'offlineAfterInstallPlan',
    'latencyAndMemoryBudget',
    'editableMathLiveReviewPlan',
    'explicitUserApprovalBeforeWorkspaceImport',
  ];

  static const forbiddenActions = <String>[
    'addPaddleRuntimeDependency',
    'addPaddleOcrDependency',
    'bundlePpFormulaNetSModelInBaseApk',
    'setProductionModelUrlWithoutChecksum',
    'implementBackgroundDownloadWorkerWithoutEvidence',
    'runPpFormulaNetSInference',
    'callFormulaRecognitionProductionRuntime',
    'setWorkspaceLatexWithoutUserApproval',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeSolutionFromCamera',
    'writeHistoryFromCamera',
    'claimOcrPassWithoutRealInferenceEvidence',
  ];
}
