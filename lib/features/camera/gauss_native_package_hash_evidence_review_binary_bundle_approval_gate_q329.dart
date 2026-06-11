import 'gauss_native_package_hash_evidence_review_binary_bundle_approval_gate_q329_policy.dart';

class GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Result {
  const GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Result({
    required this.phase,
    required this.sourcePhase,
    required this.nativePackageHashEvidenceReviewMethod,
    required this.nativePackageHashEvidenceReviewStatus,
    required this.externalNativePackageEvidencePolicy,
    required this.nativePackageEvidenceFileName,
    required this.requiredNativePackageFiles,
    required this.optionalNativePackageFiles,
    required this.evidenceReviewRequirements,
    required this.q329HardBlocks,
    required this.q330EntryCriteria,
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
    required this.runtimeStartupExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String nativePackageHashEvidenceReviewMethod;
  final String nativePackageHashEvidenceReviewStatus;
  final String externalNativePackageEvidencePolicy;
  final String nativePackageEvidenceFileName;
  final List<String> requiredNativePackageFiles;
  final List<String> optionalNativePackageFiles;
  final List<String> evidenceReviewRequirements;
  final List<String> q329HardBlocks;
  final List<String> q330EntryCriteria;
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
  final bool runtimeStartupExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329 {
  const GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329._();

  static GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Result evaluate() {
    return const GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Result(
      phase: GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.phase,
      sourcePhase: GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.sourcePhase,
      nativePackageHashEvidenceReviewMethod:
          GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.nativePackageHashEvidenceReviewMethod,
      nativePackageHashEvidenceReviewStatus:
          GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.nativePackageHashEvidenceReviewStatus,
      externalNativePackageEvidencePolicy:
          GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.externalNativePackageEvidencePolicy,
      nativePackageEvidenceFileName:
          GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.nativePackageEvidenceFileName,
      requiredNativePackageFiles:
          GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.requiredNativePackageFiles,
      optionalNativePackageFiles:
          GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.optionalNativePackageFiles,
      evidenceReviewRequirements:
          GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.evidenceReviewRequirements,
      q329HardBlocks: GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.q329HardBlocks,
      q330EntryCriteria: GaussNativePackageHashEvidenceReviewBinaryBundleApprovalGateQ329Policy.q330EntryCriteria,
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
      runtimeStartupExecuted: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
    );
  }
}
