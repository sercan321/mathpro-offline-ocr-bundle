import 'gauss_native_library_source_package_approval_abi_matrix_lock_q327_policy.dart';

class GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Result {
  const GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Result({
    required this.phase,
    required this.sourcePhase,
    required this.nativeLibrarySourcePackageApprovalMethod,
    required this.nativeLibrarySourcePackageApprovalStatus,
    required this.selectedRuntimeDependencyCandidate,
    required this.selectedModelLoaderCandidate,
    required this.approvedNativeLibrarySourcePackage,
    required this.requiredNativeLibraryFiles,
    required this.abiMatrix,
    required this.nativeLibraryCandidatePaths,
    required this.sourcePackageEvidenceRequirements,
    required this.q327HardBlocks,
    required this.q328EntryCriteria,
    required this.pubspecChanged,
    required this.gradleChanged,
    required this.nativeLibraryBundled,
    required this.jarBundled,
    required this.abiPackagingTrialExecuted,
    required this.runtimeDependencyAdded,
    required this.runtimeStartupExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String nativeLibrarySourcePackageApprovalMethod;
  final String nativeLibrarySourcePackageApprovalStatus;
  final String selectedRuntimeDependencyCandidate;
  final String selectedModelLoaderCandidate;
  final String approvedNativeLibrarySourcePackage;
  final List<String> requiredNativeLibraryFiles;
  final List<String> abiMatrix;
  final List<String> nativeLibraryCandidatePaths;
  final List<String> sourcePackageEvidenceRequirements;
  final List<String> q327HardBlocks;
  final List<String> q328EntryCriteria;
  final bool pubspecChanged;
  final bool gradleChanged;
  final bool nativeLibraryBundled;
  final bool jarBundled;
  final bool abiPackagingTrialExecuted;
  final bool runtimeDependencyAdded;
  final bool runtimeStartupExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327 {
  const GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327._();

  static GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Result evaluate() {
    return const GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Result(
      phase: GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.phase,
      sourcePhase: GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.sourcePhase,
      nativeLibrarySourcePackageApprovalMethod:
          GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.nativeLibrarySourcePackageApprovalMethod,
      nativeLibrarySourcePackageApprovalStatus:
          GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.nativeLibrarySourcePackageApprovalStatus,
      selectedRuntimeDependencyCandidate:
          GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.selectedRuntimeDependencyCandidate,
      selectedModelLoaderCandidate:
          GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.selectedModelLoaderCandidate,
      approvedNativeLibrarySourcePackage:
          GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.approvedNativeLibrarySourcePackage,
      requiredNativeLibraryFiles: GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.requiredNativeLibraryFiles,
      abiMatrix: GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.abiMatrix,
      nativeLibraryCandidatePaths:
          GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.nativeLibraryCandidatePaths,
      sourcePackageEvidenceRequirements:
          GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.sourcePackageEvidenceRequirements,
      q327HardBlocks: GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.q327HardBlocks,
      q328EntryCriteria: GaussNativeLibrarySourcePackageApprovalAbiMatrixLockQ327Policy.q328EntryCriteria,
      pubspecChanged: false,
      gradleChanged: false,
      nativeLibraryBundled: false,
      jarBundled: false,
      abiPackagingTrialExecuted: false,
      runtimeDependencyAdded: false,
      runtimeStartupExecuted: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
    );
  }
}
