import 'gauss_onnx_dummy_input_runtime_call_guard_preflight_q358_policy.dart';

class GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Result {
  const GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.selectedDependencyCoordinate,
    required this.expectedOnnxArtifactSha256,
    required this.expectedOnnxArtifactSizeBytes,
    required this.defaultOffBridgePresent,
    required this.mainActivityChangedForBridgeOnly,
    required this.dummyRuntimeCallAutoExecuted,
    required this.dummyRuntimeCallRequiresExplicitBridgeInvocation,
    required this.dummyRuntimeCallRequiresModelLoadGuard,
    required this.dummyRuntimeCallRequiresPrivateStorageArtifact,
    required this.dummyRuntimeCallRequiresExactSha256,
    required this.dummyRuntimeCallPassClaimedByPackage,
    required this.realImageToLatexInferenceExecuted,
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
  final bool dummyRuntimeCallAutoExecuted;
  final bool dummyRuntimeCallRequiresExplicitBridgeInvocation;
  final bool dummyRuntimeCallRequiresModelLoadGuard;
  final bool dummyRuntimeCallRequiresPrivateStorageArtifact;
  final bool dummyRuntimeCallRequiresExactSha256;
  final bool dummyRuntimeCallPassClaimedByPackage;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool uiRuntimeChanged;
}

class GaussOnnxDummyInputRuntimeCallGuardPreflightQ358 {
  const GaussOnnxDummyInputRuntimeCallGuardPreflightQ358._();

  static GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Result evaluate() {
    return const GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Result(
      phase: GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.phase,
      sourcePhase: GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.sourcePhase,
      status: GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.status,
      selectedDependencyCoordinate: GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.selectedDependencyCoordinate,
      expectedOnnxArtifactSha256: GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.expectedOnnxArtifactSha256,
      expectedOnnxArtifactSizeBytes: GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.expectedOnnxArtifactSizeBytes,
      defaultOffBridgePresent: true,
      mainActivityChangedForBridgeOnly: true,
      dummyRuntimeCallAutoExecuted: false,
      dummyRuntimeCallRequiresExplicitBridgeInvocation: true,
      dummyRuntimeCallRequiresModelLoadGuard: true,
      dummyRuntimeCallRequiresPrivateStorageArtifact: true,
      dummyRuntimeCallRequiresExactSha256: true,
      dummyRuntimeCallPassClaimedByPackage: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      uiRuntimeChanged: false,
    );
  }
}
