import 'gauss_onnx_runtime_android_dependency_abi_build_trial_q354_policy.dart';

class GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Result {
  const GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.selectedDependencyCoordinate,
    required this.q353FeasibilityGateAccepted,
    required this.q352OnnxConversionEvidenceAccepted,
    required this.q352R1LegacyVerifierHygienePresent,
    required this.q344PaddleLiteBinaryBundlePreserved,
    required this.gradleChanged,
    required this.onnxRuntimeDependencyAdded,
    required this.dependencyCoordinateSelected,
    required this.androidAbiBuildTrialPrepared,
    required this.assistantSideAndroidBuildExecuted,
    required this.userSideAndroidBuildEvidenceRequired,
    required this.onnxArtifactSha256,
    required this.onnxArtifactSizeBytes,
    required this.onnxModelBundledIntoFlutterProject,
    required this.onnxModelCopiedToAppPrivateStorage,
    required this.onnxModelLoadAttempted,
    required this.onnxModelLoaded,
    required this.runtimeStartupExecuted,
    required this.dummyRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.editableMathLiveReviewOpened,
    required this.workspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.mainActivityChanged,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.uiRuntimeChanged,
    required this.flutterAnalyzePassClaimedByPackage,
    required this.flutterTestPassClaimedByPackage,
    required this.androidRealDevicePassClaimedByPackage,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String selectedDependencyCoordinate;
  final bool q353FeasibilityGateAccepted;
  final bool q352OnnxConversionEvidenceAccepted;
  final bool q352R1LegacyVerifierHygienePresent;
  final bool q344PaddleLiteBinaryBundlePreserved;
  final bool gradleChanged;
  final bool onnxRuntimeDependencyAdded;
  final bool dependencyCoordinateSelected;
  final bool androidAbiBuildTrialPrepared;
  final bool assistantSideAndroidBuildExecuted;
  final bool userSideAndroidBuildEvidenceRequired;
  final String onnxArtifactSha256;
  final int onnxArtifactSizeBytes;
  final bool onnxModelBundledIntoFlutterProject;
  final bool onnxModelCopiedToAppPrivateStorage;
  final bool onnxModelLoadAttempted;
  final bool onnxModelLoaded;
  final bool runtimeStartupExecuted;
  final bool dummyRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool editableMathLiveReviewOpened;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool mainActivityChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool uiRuntimeChanged;
  final bool flutterAnalyzePassClaimedByPackage;
  final bool flutterTestPassClaimedByPackage;
  final bool androidRealDevicePassClaimedByPackage;
  final bool ocrPassClaimed;
}

class GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354 {
  const GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354._();

  static GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Result evaluate() {
    return const GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Result(
      phase: GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.phase,
      sourcePhase: GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.sourcePhase,
      status: GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.status,
      selectedDependencyCoordinate:
          GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.selectedDependencyCoordinate,
      q353FeasibilityGateAccepted: true,
      q352OnnxConversionEvidenceAccepted: true,
      q352R1LegacyVerifierHygienePresent: true,
      q344PaddleLiteBinaryBundlePreserved: true,
      gradleChanged: true,
      onnxRuntimeDependencyAdded: true,
      dependencyCoordinateSelected: true,
      androidAbiBuildTrialPrepared: true,
      assistantSideAndroidBuildExecuted: false,
      userSideAndroidBuildEvidenceRequired: true,
      onnxArtifactSha256:
          GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.externalOnnxArtifactSha256,
      onnxArtifactSizeBytes:
          GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.externalOnnxArtifactSizeBytes,
      onnxModelBundledIntoFlutterProject: false,
      onnxModelCopiedToAppPrivateStorage: false,
      onnxModelLoadAttempted: false,
      onnxModelLoaded: false,
      runtimeStartupExecuted: false,
      dummyRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      editableMathLiveReviewOpened: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      mainActivityChanged: false,
      pubspecChanged: false,
      androidManifestChanged: false,
      uiRuntimeChanged: false,
      flutterAnalyzePassClaimedByPackage: false,
      flutterTestPassClaimedByPackage: false,
      androidRealDevicePassClaimedByPackage: false,
      ocrPassClaimed: false,
    );
  }
}
