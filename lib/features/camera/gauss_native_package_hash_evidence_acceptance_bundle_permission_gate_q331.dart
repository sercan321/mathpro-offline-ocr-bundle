import 'gauss_native_package_hash_evidence_acceptance_bundle_permission_gate_q331_policy.dart';

class GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Result {
  const GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Result({
    required this.phase,
    required this.sourcePhase,
    required this.nativePackageHashEvidenceAcceptanceMethod,
    required this.nativePackageHashEvidenceAcceptanceStatus,
    required this.externalNativePackageEvidencePolicy,
    required this.nativePackageEvidenceFileName,
    required this.requiredNativePackageFiles,
    required this.optionalNativePackageFiles,
    required this.plannedBundleTargets,
    required this.evidenceAcceptanceRequirements,
    required this.q331HardBlocks,
    required this.q332EntryCriteria,
    required this.perFileSha256EvidenceProvidedToAssistant,
    required this.nativePackageHashEvidenceAccepted,
    required this.binaryBundlePermissionGranted,
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
  final String nativePackageHashEvidenceAcceptanceMethod;
  final String nativePackageHashEvidenceAcceptanceStatus;
  final String externalNativePackageEvidencePolicy;
  final String nativePackageEvidenceFileName;
  final List<String> requiredNativePackageFiles;
  final List<String> optionalNativePackageFiles;
  final List<String> plannedBundleTargets;
  final List<String> evidenceAcceptanceRequirements;
  final List<String> q331HardBlocks;
  final List<String> q332EntryCriteria;
  final bool perFileSha256EvidenceProvidedToAssistant;
  final bool nativePackageHashEvidenceAccepted;
  final bool binaryBundlePermissionGranted;
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

class GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331 {
  const GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331._();

  static GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Result evaluate() {
    return const GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Result(
      phase: GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.phase,
      sourcePhase: GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.sourcePhase,
      nativePackageHashEvidenceAcceptanceMethod:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.nativePackageHashEvidenceAcceptanceMethod,
      nativePackageHashEvidenceAcceptanceStatus:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.nativePackageHashEvidenceAcceptanceStatus,
      externalNativePackageEvidencePolicy:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.externalNativePackageEvidencePolicy,
      nativePackageEvidenceFileName:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.nativePackageEvidenceFileName,
      requiredNativePackageFiles:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.requiredNativePackageFiles,
      optionalNativePackageFiles:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.optionalNativePackageFiles,
      plannedBundleTargets:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.plannedBundleTargets,
      evidenceAcceptanceRequirements:
          GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.evidenceAcceptanceRequirements,
      q331HardBlocks: GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.q331HardBlocks,
      q332EntryCriteria: GaussNativePackageHashEvidenceAcceptanceBundlePermissionGateQ331Policy.q332EntryCriteria,
      perFileSha256EvidenceProvidedToAssistant: false,
      nativePackageHashEvidenceAccepted: false,
      binaryBundlePermissionGranted: false,
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
