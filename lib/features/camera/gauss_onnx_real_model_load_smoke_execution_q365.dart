import 'gauss_onnx_real_model_load_smoke_execution_q365_policy.dart';

class GaussOnnxRealModelLoadSmokeExecutionQ365Result {
  const GaussOnnxRealModelLoadSmokeExecutionQ365Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bridgeChannel,
    required this.bridgeMethod,
    required this.selectedDependencyCoordinate,
    required this.expectedOnnxArtifactSha256,
    required this.expectedOnnxArtifactSizeBytes,
    required this.expectedPrivateStorageRelativePath,
    required this.realModelLoadSmokeBridgePrepared,
    required this.explicitBridgeInvocationRequired,
    required this.privateStorageModelRequired,
    required this.sizeVerificationRequiredBeforeLoad,
    required this.sha256VerificationRequiredBeforeLoad,
    required this.dependencyClassProbeRequired,
    required this.ortEnvironmentSessionPolicyPrepared,
    required this.sessionClosePolicyPrepared,
    required this.inputOutputNameCapturePrepared,
    required this.modelLoadAutoExecuted,
    required this.modelLoadAttemptedByPackage,
    required this.modelLoadPassClaimedByPackage,
    required this.dummyRuntimeCallExecuted,
    required this.imageToLatexInferenceExecuted,
    required this.editableMathLiveReviewOpened,
    required this.workspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String bridgeChannel;
  final String bridgeMethod;
  final String selectedDependencyCoordinate;
  final String expectedOnnxArtifactSha256;
  final int expectedOnnxArtifactSizeBytes;
  final String expectedPrivateStorageRelativePath;
  final bool realModelLoadSmokeBridgePrepared;
  final bool explicitBridgeInvocationRequired;
  final bool privateStorageModelRequired;
  final bool sizeVerificationRequiredBeforeLoad;
  final bool sha256VerificationRequiredBeforeLoad;
  final bool dependencyClassProbeRequired;
  final bool ortEnvironmentSessionPolicyPrepared;
  final bool sessionClosePolicyPrepared;
  final bool inputOutputNameCapturePrepared;
  final bool modelLoadAutoExecuted;
  final bool modelLoadAttemptedByPackage;
  final bool modelLoadPassClaimedByPackage;
  final bool dummyRuntimeCallExecuted;
  final bool imageToLatexInferenceExecuted;
  final bool editableMathLiveReviewOpened;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool ocrPassClaimed;
}

class GaussOnnxRealModelLoadSmokeExecutionQ365 {
  const GaussOnnxRealModelLoadSmokeExecutionQ365._();

  static GaussOnnxRealModelLoadSmokeExecutionQ365Result evaluate() {
    return const GaussOnnxRealModelLoadSmokeExecutionQ365Result(
      phase: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.phase,
      sourcePhase: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.sourcePhase,
      status: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.status,
      bridgeChannel: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.bridgeChannel,
      bridgeMethod: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.bridgeMethod,
      selectedDependencyCoordinate: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.selectedDependencyCoordinate,
      expectedOnnxArtifactSha256: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.expectedOnnxArtifactSha256,
      expectedOnnxArtifactSizeBytes: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.expectedOnnxArtifactSizeBytes,
      expectedPrivateStorageRelativePath: GaussOnnxRealModelLoadSmokeExecutionQ365Policy.expectedPrivateStorageRelativePath,
      realModelLoadSmokeBridgePrepared: true,
      explicitBridgeInvocationRequired: true,
      privateStorageModelRequired: true,
      sizeVerificationRequiredBeforeLoad: true,
      sha256VerificationRequiredBeforeLoad: true,
      dependencyClassProbeRequired: true,
      ortEnvironmentSessionPolicyPrepared: true,
      sessionClosePolicyPrepared: true,
      inputOutputNameCapturePrepared: true,
      modelLoadAutoExecuted: false,
      modelLoadAttemptedByPackage: false,
      modelLoadPassClaimedByPackage: false,
      dummyRuntimeCallExecuted: false,
      imageToLatexInferenceExecuted: false,
      editableMathLiveReviewOpened: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      ocrPassClaimed: false,
    );
  }
}
