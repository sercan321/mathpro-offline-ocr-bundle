import 'gauss_onnx_model_private_storage_sha_verification_q355_policy.dart';

class GaussOnnxModelPrivateStorageShaVerificationQ355Result {
  const GaussOnnxModelPrivateStorageShaVerificationQ355Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.q354OnnxRuntimeAndroidDependencyTrialPresent,
    required this.q353FeasibilityGatePresent,
    required this.q352OnnxConversionEvidenceAccepted,
    required this.q352R1LegacyVerifierHygienePresent,
    required this.q344PaddleLiteBinaryBundlePreserved,
    required this.selectedDependencyCoordinate,
    required this.expectedOnnxArtifactSha256,
    required this.expectedOnnxArtifactSizeBytes,
    required this.externalOnnxArtifactPathPolicy,
    required this.privateStoragePolicyPrepared,
    required this.shaVerificationPolicyPrepared,
    required this.atomicCopyPolicyPrepared,
    required this.userSideArtifactRequired,
    required this.userSideFlutterBuildEvidenceRequired,
    required this.onnxModelBundledIntoFlutterProject,
    required this.onnxModelCopiedToAppPrivateStorage,
    required this.onnxModelShaVerifiedOnDevice,
    required this.onnxModelLoadAttempted,
    required this.onnxModelLoaded,
    required this.runtimeStartupExecuted,
    required this.dummyRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.editableMathLiveReviewOpened,
    required this.workspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.gradleChanged,
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
  final bool q354OnnxRuntimeAndroidDependencyTrialPresent;
  final bool q353FeasibilityGatePresent;
  final bool q352OnnxConversionEvidenceAccepted;
  final bool q352R1LegacyVerifierHygienePresent;
  final bool q344PaddleLiteBinaryBundlePreserved;
  final String selectedDependencyCoordinate;
  final String expectedOnnxArtifactSha256;
  final int expectedOnnxArtifactSizeBytes;
  final String externalOnnxArtifactPathPolicy;
  final bool privateStoragePolicyPrepared;
  final bool shaVerificationPolicyPrepared;
  final bool atomicCopyPolicyPrepared;
  final bool userSideArtifactRequired;
  final bool userSideFlutterBuildEvidenceRequired;
  final bool onnxModelBundledIntoFlutterProject;
  final bool onnxModelCopiedToAppPrivateStorage;
  final bool onnxModelShaVerifiedOnDevice;
  final bool onnxModelLoadAttempted;
  final bool onnxModelLoaded;
  final bool runtimeStartupExecuted;
  final bool dummyRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool editableMathLiveReviewOpened;
  final bool workspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool gradleChanged;
  final bool mainActivityChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool uiRuntimeChanged;
  final bool flutterAnalyzePassClaimedByPackage;
  final bool flutterTestPassClaimedByPackage;
  final bool androidRealDevicePassClaimedByPackage;
  final bool ocrPassClaimed;
}

class GaussOnnxModelPrivateStorageShaVerificationQ355 {
  const GaussOnnxModelPrivateStorageShaVerificationQ355._();

  static GaussOnnxModelPrivateStorageShaVerificationQ355Result evaluate() {
    return const GaussOnnxModelPrivateStorageShaVerificationQ355Result(
      phase: GaussOnnxModelPrivateStorageShaVerificationQ355Policy.phase,
      sourcePhase: GaussOnnxModelPrivateStorageShaVerificationQ355Policy.sourcePhase,
      status: GaussOnnxModelPrivateStorageShaVerificationQ355Policy.status,
      q354OnnxRuntimeAndroidDependencyTrialPresent: true,
      q353FeasibilityGatePresent: true,
      q352OnnxConversionEvidenceAccepted: true,
      q352R1LegacyVerifierHygienePresent: true,
      q344PaddleLiteBinaryBundlePreserved: true,
      selectedDependencyCoordinate:
          GaussOnnxModelPrivateStorageShaVerificationQ355Policy.selectedDependencyCoordinate,
      expectedOnnxArtifactSha256:
          GaussOnnxModelPrivateStorageShaVerificationQ355Policy.expectedOnnxArtifactSha256,
      expectedOnnxArtifactSizeBytes:
          GaussOnnxModelPrivateStorageShaVerificationQ355Policy.expectedOnnxArtifactSizeBytes,
      externalOnnxArtifactPathPolicy:
          GaussOnnxModelPrivateStorageShaVerificationQ355Policy.externalOnnxArtifactPathPolicy,
      privateStoragePolicyPrepared: true,
      shaVerificationPolicyPrepared: true,
      atomicCopyPolicyPrepared: true,
      userSideArtifactRequired: true,
      userSideFlutterBuildEvidenceRequired: true,
      onnxModelBundledIntoFlutterProject: false,
      onnxModelCopiedToAppPrivateStorage: false,
      onnxModelShaVerifiedOnDevice: false,
      onnxModelLoadAttempted: false,
      onnxModelLoaded: false,
      runtimeStartupExecuted: false,
      dummyRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      editableMathLiveReviewOpened: false,
      workspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      gradleChanged: false,
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
