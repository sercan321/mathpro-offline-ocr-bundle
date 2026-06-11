class GaussControlledModelArtifactDownloadHashCaptureQ315Policy {
  const GaussControlledModelArtifactDownloadHashCaptureQ315Policy._();

  static const String phase = 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE';
  static const String sourcePhase = 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope = 'controlled-artifact-download-hash-capture-procedure-only';
  static const String captureState = 'BLOCKED_PENDING_USER_SIDE_CONTROLLED_DOWNLOAD_LOCAL_HASH_EVIDENCE';
  static const String nextRequiredPhase = 'Q316_RUNTIME_DEPENDENCY_FEASIBILITY_TRIAL_DEFAULT_OFF';
  static const String primaryRepositoryLocator = 'hf://PaddlePaddle/PP-FormulaNet-S';
  static const String primaryRepositoryLicense = 'apache-2.0';
  static const String primaryRepositoryTotalSizeLabel = '238 MB';
  static const String primaryRequiredArtifactFile = 'inference.pdiparams';
  static const String primaryRequiredArtifactSizeLabel = '232 MB';
  static const String publishedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const String publishedInferencePdiparamsXetHash =
      '704471ae47042d516484ce674f8e0973c3aa1e45db9f4f7e7bd1e22952c4527f';
  static const String officialResolveDownloadUrl =
      'hf-resolve://PaddlePaddle/PP-FormulaNet-S/main/inference.pdiparams';
  static const String controlledDownloadScript =
      'tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs';
  static const String artifactOutputDirectoryPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S';
  static const String localArtifactSha256State = 'NOT_COMPUTED_IN_ASSISTANT_CONTAINER_NETWORK_BLOCKED';
  static const String remoteHashEvidenceState = 'HF_LARGE_FILE_POINTER_SHA_RECORDED_NOT_RUNTIME_ACCEPTANCE';
  static const String runtimeDecisionState = 'PENDING_Q316_DEFAULT_OFF_RUNTIME_DEPENDENCY_FEASIBILITY_TRIAL';

  static const bool runtimeBehaviorChanged = false;
  static const bool cameraOcrRuntimeAdded = false;
  static const bool controlledDownloadPerformedByAssistant = false;
  static const bool assistantContainerNetworkBlocked = true;
  static const bool remoteRepositoryFileInventoryCaptured = true;
  static const bool remoteLargeFileSha256Recorded = true;
  static const bool localArtifactSha256Computed = false;
  static const bool localArtifactSha256MatchedPublishedHash = false;
  static const bool artifactAcceptedForRuntime = false;
  static const bool runtimeDependencyAdded = false;
  static const bool paddleRuntimeAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool onnxRuntimeAdded = false;
  static const bool tfliteRuntimeAdded = false;
  static const bool jniNativeHandlerAdded = false;
  static const bool methodChannelBindingAdded = false;
  static const bool mainActivityChanged = false;
  static const bool androidManifestChanged = false;
  static const bool pubspecChanged = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool productionDownloadEnabled = false;
  static const bool privateStorageImplementationAdded = false;
  static const bool realPrivateArtifactLoaded = false;
  static const bool realRuntimeStartupExecuted = false;
  static const bool realDummyInputRuntimeCallExecuted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool autoSolveGraphSolutionHistoryEnabled = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool storeReadyPassClaimed = false;
  static const bool releasePassClaimed = false;

  static const List<String> requiredRepositoryFiles = <String>[
    'README.md',
    'config.json',
    'inference.json',
    'inference.pdiparams',
    'inference.yml',
  ];

  static const List<String> controlledCaptureRequirements = <String>[
    'download-artifact-outside-project-root',
    'compute-sha256-from-local-downloaded-file',
    'compare-local-sha256-with-published-hf-large-file-sha256',
    'record-file-size-and-capture-timestamp',
    'do-not-commit-model-artifact-into-project-zip',
    'do-not-accept-artifact-for-runtime-until-local-hash-match-evidence-exists',
  ];

  static const List<String> q316EntryCriteria = <String>[
    'local-artifact-file-exists-outside-project-root',
    'local-artifact-sha256-equals-published-inference-pdiparams-sha256',
    'local-artifact-byte-size-is-recorded',
    'artifact-license-source-notes-are-recorded',
    'runtime-dependency-trial-remains-default-off-and-rollback-safe',
  ];

  static const List<String> hardBlocksBeforeRuntime = <String>[
    'no-runtime-dependency-before-local-hash-match-evidence',
    'no-mainactivity-or-androidmanifest-mutation-in-q315',
    'no-model-binary-in-base-app-or-delivery-zip',
    'no-methodchannel-runtime-binding-before-q317-healthcheck',
    'no-camera-image-to-runtime-before-q321-dummy-call-evidence',
    'no-workspace-import-before-editable-mathlive-review-and-user-approval',
  ];
}
