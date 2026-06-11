import 'gauss_native_library_build_trial_approval_abi_packaging_preflight_q326_policy.dart';

class GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Result {
  const GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Result({
    required this.phase,
    required this.sourcePhase,
    required this.nativeLibraryBuildTrialPreflightMethod,
    required this.nativeLibraryBuildTrialPreflightStatus,
    required this.selectedRuntimeDependencyCandidate,
    required this.selectedModelLoaderCandidate,
    required this.nativeLibrarySourceCandidate,
    required this.modelConversionCandidate,
    required this.abiPackagingCandidates,
    required this.nativeLibraryCandidatePaths,
    required this.preflightEnvelopeFields,
    required this.q326HardBlocks,
    required this.q327EntryCriteria,
    required this.pubspecChanged,
    required this.gradleChanged,
    required this.nativeLibraryBundled,
    required this.abiPackagingTrialExecuted,
    required this.runtimeDependencyAdded,
    required this.runtimeStartupExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String nativeLibraryBuildTrialPreflightMethod;
  final String nativeLibraryBuildTrialPreflightStatus;
  final String selectedRuntimeDependencyCandidate;
  final String selectedModelLoaderCandidate;
  final String nativeLibrarySourceCandidate;
  final String modelConversionCandidate;
  final List<String> abiPackagingCandidates;
  final List<String> nativeLibraryCandidatePaths;
  final List<String> preflightEnvelopeFields;
  final List<String> q326HardBlocks;
  final List<String> q327EntryCriteria;
  final bool pubspecChanged;
  final bool gradleChanged;
  final bool nativeLibraryBundled;
  final bool abiPackagingTrialExecuted;
  final bool runtimeDependencyAdded;
  final bool runtimeStartupExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326 {
  const GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326._();

  static GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Result evaluate() {
    return const GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Result(
      phase: GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.phase,
      sourcePhase: GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.sourcePhase,
      nativeLibraryBuildTrialPreflightMethod:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.nativeLibraryBuildTrialPreflightMethod,
      nativeLibraryBuildTrialPreflightStatus:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.nativeLibraryBuildTrialPreflightStatus,
      selectedRuntimeDependencyCandidate:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.selectedRuntimeDependencyCandidate,
      selectedModelLoaderCandidate:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.selectedModelLoaderCandidate,
      nativeLibrarySourceCandidate:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.nativeLibrarySourceCandidate,
      modelConversionCandidate: GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.modelConversionCandidate,
      abiPackagingCandidates:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.abiPackagingCandidates,
      nativeLibraryCandidatePaths:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.nativeLibraryCandidatePaths,
      preflightEnvelopeFields:
          GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.preflightEnvelopeFields,
      q326HardBlocks: GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.q326HardBlocks,
      q327EntryCriteria: GaussNativeLibraryBuildTrialApprovalAbiPackagingPreflightQ326Policy.q327EntryCriteria,
      pubspecChanged: false,
      gradleChanged: false,
      nativeLibraryBundled: false,
      abiPackagingTrialExecuted: false,
      runtimeDependencyAdded: false,
      runtimeStartupExecuted: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
    );
  }
}
