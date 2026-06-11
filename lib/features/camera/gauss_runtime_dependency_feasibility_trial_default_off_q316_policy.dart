class GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy {
  const GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Policy._();

  static const String phase = 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
  static const String sourcePhase = 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR';
  static const String selectedEngineLabel = 'PP-FormulaNet-S';
  static const String implementationScope = 'runtime-dependency-feasibility-preflight-only-default-off';
  static const String dependencyTrialState = 'BLOCKED_PENDING_Q315_LOCAL_HASH_EVIDENCE_AND_EXPLICIT_RUNTIME_DEPENDENCY_APPROVAL';
  static const String featureFlagName = 'gauss.ppFormulaNetS.runtimeDependencyTrial.defaultOff';
  static const String nextRequiredPhase = 'Q317_NATIVE_BRIDGE_MINIMAL_HEALTHCHECK_AFTER_HASH_EVIDENCE_AND_EXPLICIT_APPROVAL';
  static const String q315RequiredEvidenceScript = 'tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs --download --verify';
  static const String q315ExpectedArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S/inference.pdiparams';
  static const String expectedInferencePdiparamsSha256 =
      'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const String runtimeDependencyDecision = 'NO_RUNTIME_DEPENDENCY_ADDED_IN_Q316_STATIC_PREFLIGHT';

  static const bool q315UserSideFlutterAnalyzePassed = true;
  static const bool q315UserSideFlutterTestPassed = true;
  static const bool q315LocalArtifactHashEvidenceProvidedToAssistant = false;
  static const bool explicitRuntimeDependencyApprovalProvided = false;
  static const bool runtimeDependencyTrialDefaultOff = true;
  static const bool runtimeFeatureFlagDefaultEnabled = false;
  static const bool rollbackRequiredBeforeTrial = true;
  static const bool pubspecChanged = false;
  static const bool gradleChanged = false;
  static const bool androidManifestChanged = false;
  static const bool mainActivityChanged = false;
  static const bool paddleRuntimeDependencyAdded = false;
  static const bool paddleOcrDependencyAdded = false;
  static const bool onnxRuntimeDependencyAdded = false;
  static const bool tfliteRuntimeDependencyAdded = false;
  static const bool downloadDependencyAdded = false;
  static const bool methodChannelBindingAdded = false;
  static const bool jniNativeHandlerAdded = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool modelArtifactAcceptedForRuntime = false;
  static const bool privateStorageImplementationAdded = false;
  static const bool runtimeStartupExecuted = false;
  static const bool dummyRuntimeCallExecuted = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;

  static const List<String> candidateRuntimePaths = <String>[
    'paddle-lite-android-or-paddle-inference-android-feasibility-research',
    'onnxruntime-mobile-feasibility-research-if-export-path-exists',
    'tflite-feasibility-research-only-if-model-conversion-is-proven',
  ];

  static const List<String> q316DependencyTrialPreconditions = <String>[
    'q315-local-artifact-sha256-evidence-matches-published-hash',
    'artifact-stored-outside-project-root',
    'license-source-recorded',
    'explicit-user-approval-before-pubspec-or-gradle-mutation',
    'runtime-dependency-must-remain-default-off',
    'rollback-plan-before-any-android-build-system-change',
  ];

  static const List<String> q316HardBlocks = <String>[
    'no-pubspec-change-without-q315-hash-evidence',
    'no-gradle-change-without-explicit-runtime-dependency-approval',
    'no-mainactivity-methodchannel-binding-in-q316',
    'no-androidmanifest-runtime-permission-change-in-q316',
    'no-model-binary-in-base-app-or-delivery-zip',
    'no-ocr-runtime-pass-without-real-device-runtime-log',
    'no-direct-ocr-to-workspace-or-solve-graph-solution-history',
  ];

  static const List<String> q317EntryCriteria = <String>[
    'q315-hash-capture-evidence-json-provided-and-matches-expected-sha256',
    'chosen-runtime-dependency-is-explicitly-approved',
    'dependency-trial-plan-records-android-abi-size-memory-and-rollback-risk',
    'feature-flag-default-off-remains-enforced',
    'flutter-analyze-and-test-clean-after-q316',
  ];
}
