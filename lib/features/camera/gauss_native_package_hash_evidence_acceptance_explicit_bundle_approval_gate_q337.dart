import 'gauss_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_q337_policy.dart';

class GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Result {
  const GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Result({
    required this.phase,
    required this.sourcePhase,
    required this.methodName,
    required this.status,
    required this.requiredNativePackageFiles,
    required this.optionalNativePackageFiles,
    required this.plannedBundleTargets,
    required this.q337EvidenceAcceptanceSteps,
    required this.q337HardBlocks,
    required this.q328NativePackageHashEvidenceJsonProvided,
    required this.q328NativePackageHashEvidenceJsonReviewed,
    required this.requiredNativePackageFilesAllPresentInEvidence,
    required this.perFileSha256EvidenceAccepted,
    required this.explicitUserBinaryBundleApprovalProvided,
    required this.binaryBundlePermissionGranted,
    required this.nativeLibraryBundled,
    required this.jarBundled,
    required this.jniLibsDirectoryCreated,
    required this.androidAppLibsDirectoryCreated,
    required this.gradleChanged,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.systemLoadLibraryAdded,
    required this.paddleLiteInstantiated,
    required this.runtimeDependencyAdded,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String methodName;
  final String status;
  final List<String> requiredNativePackageFiles;
  final List<String> optionalNativePackageFiles;
  final List<String> plannedBundleTargets;
  final List<String> q337EvidenceAcceptanceSteps;
  final List<String> q337HardBlocks;
  final bool q328NativePackageHashEvidenceJsonProvided;
  final bool q328NativePackageHashEvidenceJsonReviewed;
  final bool requiredNativePackageFilesAllPresentInEvidence;
  final bool perFileSha256EvidenceAccepted;
  final bool explicitUserBinaryBundleApprovalProvided;
  final bool binaryBundlePermissionGranted;
  final bool nativeLibraryBundled;
  final bool jarBundled;
  final bool jniLibsDirectoryCreated;
  final bool androidAppLibsDirectoryCreated;
  final bool gradleChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool systemLoadLibraryAdded;
  final bool paddleLiteInstantiated;
  final bool runtimeDependencyAdded;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337 {
  const GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337._();

  static GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Result evaluate() {
    return const GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Result(
      phase: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.phase,
      sourcePhase: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.sourcePhase,
      methodName: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.methodName,
      status: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.status,
      requiredNativePackageFiles: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.requiredNativePackageFiles,
      optionalNativePackageFiles: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.optionalNativePackageFiles,
      plannedBundleTargets: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.plannedBundleTargets,
      q337EvidenceAcceptanceSteps: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.q337EvidenceAcceptanceSteps,
      q337HardBlocks: GaussNativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateQ337Policy.q337HardBlocks,
      q328NativePackageHashEvidenceJsonProvided: false,
      q328NativePackageHashEvidenceJsonReviewed: false,
      requiredNativePackageFilesAllPresentInEvidence: false,
      perFileSha256EvidenceAccepted: false,
      explicitUserBinaryBundleApprovalProvided: false,
      binaryBundlePermissionGranted: false,
      nativeLibraryBundled: false,
      jarBundled: false,
      jniLibsDirectoryCreated: false,
      androidAppLibsDirectoryCreated: false,
      gradleChanged: false,
      pubspecChanged: false,
      androidManifestChanged: false,
      systemLoadLibraryAdded: false,
      paddleLiteInstantiated: false,
      runtimeDependencyAdded: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
    );
  }
}
