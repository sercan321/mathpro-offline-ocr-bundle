import 'gauss_onnx_real_model_load_smoke_bridge_preflight_execution_q357_policy.dart';

class GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Result {
  const GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.selectedDependencyCoordinate,
    required this.expectedOnnxArtifactSha256,
    required this.expectedOnnxArtifactSizeBytes,
    required this.defaultOffBridgePresent,
    required this.mainActivityChangedForBridgeOnly,
    required this.modelLoadAutoExecuted,
    required this.modelLoadRequiresExplicitBridgeInvocation,
    required this.modelLoadRequiresPrivateStorageArtifact,
    required this.modelLoadRequiresExactSha256,
    required this.modelLoadPassClaimedByPackage,
    required this.ocrPassClaimed,
    required this.workspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.uiRuntimeChanged,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String selectedDependencyCoordinate;
  final String expectedOnnxArtifactSha256;
  final int expectedOnnxArtifactSizeBytes;
  final bool defaultOffBridgePresent;
  final bool mainActivityChangedForBridgeOnly;
  final bool modelLoadAutoExecuted;
  final bool modelLoadRequiresExplicitBridgeInvocation;
  final bool modelLoadRequiresPrivateStorageArtifact;
  final bool modelLoadRequiresExactSha256;
  final bool modelLoadPassClaimedByPackage;
  final bool ocrPassClaimed;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool uiRuntimeChanged;
}

class GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357 {
  const GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357._();

  static GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Result evaluate() {
    return const GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Result(
      phase: GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.phase,
      sourcePhase: GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.sourcePhase,
      status: GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.status,
      selectedDependencyCoordinate: GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.selectedDependencyCoordinate,
      expectedOnnxArtifactSha256: GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.expectedOnnxArtifactSha256,
      expectedOnnxArtifactSizeBytes: GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.expectedOnnxArtifactSizeBytes,
      defaultOffBridgePresent: true,
      mainActivityChangedForBridgeOnly: true,
      modelLoadAutoExecuted: false,
      modelLoadRequiresExplicitBridgeInvocation: true,
      modelLoadRequiresPrivateStorageArtifact: true,
      modelLoadRequiresExactSha256: true,
      modelLoadPassClaimedByPackage: false,
      ocrPassClaimed: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      uiRuntimeChanged: false,
    );
  }
}
