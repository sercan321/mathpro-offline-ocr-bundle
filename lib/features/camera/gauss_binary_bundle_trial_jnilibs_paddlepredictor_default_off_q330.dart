import 'gauss_binary_bundle_trial_jnilibs_paddlepredictor_default_off_q330_policy.dart';

class GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Result {
  const GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Result({
    required this.phase,
    required this.sourcePhase,
    required this.binaryBundleTrialMethod,
    required this.binaryBundleTrialStatus,
    required this.externalNativePackageEvidencePolicy,
    required this.nativePackageEvidenceFileName,
    required this.requiredNativePackageFiles,
    required this.optionalNativePackageFiles,
    required this.plannedBundleTargets,
    required this.binaryBundleTrialRequirements,
    required this.q330HardBlocks,
    required this.q331EntryCriteria,
    required this.perFileSha256EvidenceProvidedToAssistant,
    required this.nativePackageHashEvidenceAccepted,
    required this.binaryBundleApproved,
    required this.pubspecChanged,
    required this.gradleChanged,
    required this.androidManifestChanged,
    required this.nativeLibraryBundled,
    required this.aarBundled,
    required this.jarBundled,
    required this.jniLibsDirectoryCreated,
    required this.androidAppLibsDirectoryCreated,
    required this.runtimeDependencyAdded,
    required this.systemLoadLibraryAdded,
    required this.paddleLiteInstantiated,
    required this.runtimeStartupExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String binaryBundleTrialMethod;
  final String binaryBundleTrialStatus;
  final String externalNativePackageEvidencePolicy;
  final String nativePackageEvidenceFileName;
  final List<String> requiredNativePackageFiles;
  final List<String> optionalNativePackageFiles;
  final List<String> plannedBundleTargets;
  final List<String> binaryBundleTrialRequirements;
  final List<String> q330HardBlocks;
  final List<String> q331EntryCriteria;
  final bool perFileSha256EvidenceProvidedToAssistant;
  final bool nativePackageHashEvidenceAccepted;
  final bool binaryBundleApproved;
  final bool pubspecChanged;
  final bool gradleChanged;
  final bool androidManifestChanged;
  final bool nativeLibraryBundled;
  final bool aarBundled;
  final bool jarBundled;
  final bool jniLibsDirectoryCreated;
  final bool androidAppLibsDirectoryCreated;
  final bool runtimeDependencyAdded;
  final bool systemLoadLibraryAdded;
  final bool paddleLiteInstantiated;
  final bool runtimeStartupExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330 {
  const GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330._();

  static GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Result evaluate() {
    return const GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Result(
      phase: GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.phase,
      sourcePhase: GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.sourcePhase,
      binaryBundleTrialMethod:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.binaryBundleTrialMethod,
      binaryBundleTrialStatus:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.binaryBundleTrialStatus,
      externalNativePackageEvidencePolicy:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.externalNativePackageEvidencePolicy,
      nativePackageEvidenceFileName:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.nativePackageEvidenceFileName,
      requiredNativePackageFiles:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.requiredNativePackageFiles,
      optionalNativePackageFiles:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.optionalNativePackageFiles,
      plannedBundleTargets:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.plannedBundleTargets,
      binaryBundleTrialRequirements:
          GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.binaryBundleTrialRequirements,
      q330HardBlocks: GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.q330HardBlocks,
      q331EntryCriteria: GaussBinaryBundleTrialJniLibsPaddlePredictorDefaultOffQ330Policy.q331EntryCriteria,
      perFileSha256EvidenceProvidedToAssistant: false,
      nativePackageHashEvidenceAccepted: false,
      binaryBundleApproved: false,
      pubspecChanged: false,
      gradleChanged: false,
      androidManifestChanged: false,
      nativeLibraryBundled: false,
      aarBundled: false,
      jarBundled: false,
      jniLibsDirectoryCreated: false,
      androidAppLibsDirectoryCreated: false,
      runtimeDependencyAdded: false,
      systemLoadLibraryAdded: false,
      paddleLiteInstantiated: false,
      runtimeStartupExecuted: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
    );
  }
}
