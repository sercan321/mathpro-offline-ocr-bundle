import 'gauss_onnx_model_artifact_private_storage_activation_q364_policy.dart';

class GaussOnnxModelArtifactPrivateStorageActivationQ364Result {
  const GaussOnnxModelArtifactPrivateStorageActivationQ364Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bridgeChannel,
    required this.bridgeMethod,
    required this.selectedDependencyCoordinate,
    required this.expectedOnnxArtifactSha256,
    required this.expectedOnnxArtifactSizeBytes,
    required this.expectedPrivateStorageRelativePath,
    required this.explicitBridgeInvocationRequired,
    required this.privateStorageActivationBridgePrepared,
    required this.modelBundledIntoProjectZip,
    required this.modelAutoCopied,
    required this.modelLoadAutoExecuted,
    required this.modelLoadAttemptedByPackage,
    required this.dummyRuntimeCallExecuted,
    required this.imageToLatexInferenceExecuted,
    required this.editableMathLiveReviewOpened,
    required this.workspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.ocrPassClaimed,
    required this.modelPrivateStoragePassClaimedByPackage,
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
  final bool explicitBridgeInvocationRequired;
  final bool privateStorageActivationBridgePrepared;
  final bool modelBundledIntoProjectZip;
  final bool modelAutoCopied;
  final bool modelLoadAutoExecuted;
  final bool modelLoadAttemptedByPackage;
  final bool dummyRuntimeCallExecuted;
  final bool imageToLatexInferenceExecuted;
  final bool editableMathLiveReviewOpened;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool ocrPassClaimed;
  final bool modelPrivateStoragePassClaimedByPackage;
}

class GaussOnnxModelArtifactPrivateStorageActivationQ364 {
  const GaussOnnxModelArtifactPrivateStorageActivationQ364._();

  static GaussOnnxModelArtifactPrivateStorageActivationQ364Result evaluate() {
    return const GaussOnnxModelArtifactPrivateStorageActivationQ364Result(
      phase: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.phase,
      sourcePhase: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.sourcePhase,
      status: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.status,
      bridgeChannel: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.bridgeChannel,
      bridgeMethod: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.bridgeMethod,
      selectedDependencyCoordinate: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.selectedDependencyCoordinate,
      expectedOnnxArtifactSha256: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.expectedOnnxArtifactSha256,
      expectedOnnxArtifactSizeBytes: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.expectedOnnxArtifactSizeBytes,
      expectedPrivateStorageRelativePath: GaussOnnxModelArtifactPrivateStorageActivationQ364Policy.expectedPrivateStorageRelativePath,
      explicitBridgeInvocationRequired: true,
      privateStorageActivationBridgePrepared: true,
      modelBundledIntoProjectZip: false,
      modelAutoCopied: false,
      modelLoadAutoExecuted: false,
      modelLoadAttemptedByPackage: false,
      dummyRuntimeCallExecuted: false,
      imageToLatexInferenceExecuted: false,
      editableMathLiveReviewOpened: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      ocrPassClaimed: false,
      modelPrivateStoragePassClaimedByPackage: false,
    );
  }
}
