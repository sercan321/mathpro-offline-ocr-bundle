class GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy {
  const GaussControlledModelArtifactDownloadHashCaptureFlutterTestRepairQ315R1Policy._();

  static const String phase = 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR';
  static const String sourcePhase = 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE';
  static const String repairScope = 'flutter-test-literal-path-policy-repair-only';
  static const String failureTestFile = 'test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart';
  static const String failurePlainName = 'q315 capture script exists and project zip does not contain model binary artifacts';
  static const String failureCause =
      'test expected literal artifact output policy while capture script built the same path from path.resolve components';
  static const String scriptDefaultOutputDirPolicyLiteral = '../MathProOcrArtifacts/PP-FormulaNet-S';
  static const String captureScriptPath = 'tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs';
  static const String nextRequiredPhase = 'Q316_RUNTIME_DEPENDENCY_FEASIBILITY_TRIAL_DEFAULT_OFF';

  static const bool failureObservedInUserFlutterTest = true;
  static const bool q315EnvelopePreserved = true;
  static const bool runtimeBehaviorChanged = false;
  static const bool cameraOcrRuntimeAdded = false;
  static const bool controlledDownloadPerformedByAssistant = false;
  static const bool localArtifactSha256Computed = false;
  static const bool artifactAcceptedForRuntime = false;
  static const bool runtimeDependencyAdded = false;
  static const bool methodChannelBindingAdded = false;
  static const bool mainActivityChanged = false;
  static const bool androidManifestChanged = false;
  static const bool pubspecChanged = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool realImageToLatexInferenceExecuted = false;
  static const bool editableMathLiveReviewOpened = false;
  static const bool workspaceImportExecuted = false;
  static const bool ocrPassClaimed = false;
  static const bool cameraOcrRuntimePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
}
