class GaussPpFormulaNetSProductionArtifactResolverGatePolicy {
  const GaussPpFormulaNetSProductionArtifactResolverGatePolicy._();

  static const phase = 'V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE';
  static const sourcePhase = 'V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const resolverMode = 'production-artifact-resolver-gate-only-no-production-download';

  static const productionDownloadEnabled = false;
  static const productionModelUrlBound = false;
  static const expectedProductionSha256Locked = false;
  static const realNetworkDownloadWorkerImplemented = false;
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

  static const requiredResolverFields = <String>[
    'officialArtifactSourceLabel',
    'artifactVersionLabel',
    'artifactLicenseLabel',
    'artifactStorageSizeBytes',
    'androidRuntimeCompatibilityLabel',
    'latencyBudgetLabel',
    'memoryBudgetLabel',
    'productionArtifactUrlCandidate',
    'expectedSha256Candidate',
    'checksumMismatchBehavior',
    'downloadDisabledByDefault',
    'editableMathLiveReviewRequirement',
    'explicitUserApprovalRequirement',
  ];

  static const blockedUntilRealEvidence = <String>[
    'officialArtifactUrlResolved',
    'expectedProductionSha256Locked',
    'apache2OrCompatibleDistributionLicenseConfirmed',
    'artifactSizeWithinBudgetConfirmed',
    'androidRuntimeCompatibilityConfirmed',
    'downloadWorkerDryRunPassed',
    'checksumMismatchRejectionProven',
    'offlineAfterInstallReadinessProven',
  ];

  static const requiredResolverSafetyGates = <String>[
    'q257OrchestratorUiGuardPresent',
    'q256ArtifactManifestShaGatePresent',
    'urlCannotEnableDownloadWithoutExpectedSha',
    'expectedShaMustBe64Hex',
    'licenseLabelRequiredBeforeResolverReady',
    'artifactSizeBudgetRequiredBeforeResolverReady',
    'runtimeCompatibilityRequiredBeforeResolverReady',
    'checksumMismatchBlocksReadyState',
    'productionDownloadDisabledByDefault',
    'noModelBinaryBundledInBaseApk',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalBeforeWorkspaceImport',
    'directSolveGraphSolutionHistoryBlocked',
  ];

  static const forbiddenActions = <String>[
    'bindProductionArtifactUrlInQ258',
    'lockExpectedProductionShaWithoutRealArtifactInQ258',
    'enableProductionDownloadInQ258',
    'implementRealNetworkDownloadWorkerInQ258',
    'bundlePpFormulaNetSModelInBaseApk',
    'addPaddleRuntimeDependencyInQ258',
    'addPaddleOcrDependencyInQ258',
    'addTextOcrFallbackDependencyInQ258',
    'runPpFormulaNetSInference',
    'callFormulaRecognitionInProduction',
    'callMathLiveProductionBridgeFromOcr',
    'setWorkspaceLatexWithoutUserApproval',
    'solveCameraOutputDirectly',
    'graphCameraOutputDirectly',
    'writeSolutionFromCameraOutputDirectly',
    'writeHistoryFromCameraOutputDirectly',
    'claimModelDownloadPass',
    'claimOcrPass',
  ];
}
