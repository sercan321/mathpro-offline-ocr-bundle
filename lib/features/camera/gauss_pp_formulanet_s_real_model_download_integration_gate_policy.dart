class GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy {
  const GaussPpFormulaNetSRealModelDownloadIntegrationGatePolicy._();

  static const phase = 'V172-Q260-PP-FORMULANET-S-REAL-MODEL-DOWNLOAD-INTEGRATION-GATE';
  static const sourcePhase = 'V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN';
  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const integrationMode = 'real-model-download-integration-gate-no-production-network-without-url-sha-consent';

  static const realModelDownloadIntegrationGateImplemented = true;
  static const productionDownloadEnabled = false;
  static const productionModelUrlBound = false;
  static const expectedProductionSha256Locked = false;
  static const realNetworkDownloadWorkerImplemented = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionInferenceAllowed = false;
  static const editableMathLiveReviewRequired = true;
  static const userApprovalRequiredBeforeWorkspaceImport = true;

  static const integrationStates = <String>[
    'integrationBlockedMissingUrl',
    'integrationBlockedMissingSha256',
    'integrationBlockedMissingConsent',
    'integrationBlockedNetworkPolicy',
    'integrationBlockedChecksumMismatch',
    'integrationBlockedRuntimeUnavailable',
    'integrationDownloadEligibleButDisabled',
    'integrationReadyOnlyAfterVerifiedPrivateArtifact',
  ];

  static const requiredIntegrationGates = <String>[
    'q259DryRunWorkerPresent',
    'q258ArtifactResolverPresent',
    'productionArtifactUrlCandidateRequired',
    'expectedSha256CandidateRequired',
    'expectedSha256MustBe64Hex',
    'explicitUserConsentRequired',
    'wifiOrApprovedNetworkRequired',
    'privateAppStorageOnly',
    'tempFileBeforeFinalArtifact',
    'checksumVerificationBeforeReady',
    'checksumMismatchBlocksReady',
    'atomicMoveOnlyAfterChecksumPass',
    'offlineReadyOnlyAfterVerifiedArtifact',
    'runtimeFeasibilityEvidenceRequired',
    'editableMathLiveReviewRequired',
    'explicitUserApprovalBeforeWorkspaceImport',
  ];

  static const requiredRealEvidenceBeforeEnablement = <String>[
    'realProductionArtifactUrl',
    'officialArtifactVersionLabel',
    'officialLicenseEvidence',
    'expectedArtifactSha256',
    'realChecksumVerificationLog',
    'privateAppStoragePathEvidence',
    'networkPolicyAndUserConsentEvidence',
    'AndroidFlutterDownloadRunLog',
    'runtimeFeasibilityEvidence',
    'noDirectSolveGraphSolutionHistoryEvidence',
  ];

  static const forbiddenActions = <String>[
    'enableProductionDownloadWithoutUrlAndSha',
    'bindProductionModelUrlInQ260',
    'startRealNetworkDownloadInQ260',
    'shipPpFormulaNetSModelBinaryInBaseApk',
    'addPaddleRuntimeDependencyInQ260',
    'addPaddleOcrDependencyInQ260',
    'claimModelDownloadPass',
    'claimOcrPass',
    'runPpFormulaNetSInference',
    'markReadyWithoutChecksumPass',
    'storeModelOutsidePrivateAppStorage',
    'setWorkspaceLatexWithoutUserApproval',
    'solveCameraResultWithoutReview',
    'graphCameraResultWithoutReview',
    'writeSolutionFromCameraWithoutReview',
    'writeHistoryFromCameraWithoutReview',
  ];
}
