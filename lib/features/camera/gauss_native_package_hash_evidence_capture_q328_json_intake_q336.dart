import 'gauss_native_package_hash_evidence_capture_q328_json_intake_q336_policy.dart';

class GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Result {
  const GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Result({
    required this.phase,
    required this.sourcePhase,
    required this.methodName,
    required this.status,
    required this.requiredNativePackageFiles,
    required this.optionalNativePackageFiles,
    required this.plannedBundleTargets,
    required this.q336EvidenceReviewSteps,
    required this.q336HardBlocks,
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
  final List<String> q336EvidenceReviewSteps;
  final List<String> q336HardBlocks;
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

class GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336 {
  const GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336._();

  static GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Result evaluate() {
    return const GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Result(
      phase: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.phase,
      sourcePhase: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.sourcePhase,
      methodName: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.methodName,
      status: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.status,
      requiredNativePackageFiles: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.requiredNativePackageFiles,
      optionalNativePackageFiles: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.optionalNativePackageFiles,
      plannedBundleTargets: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.plannedBundleTargets,
      q336EvidenceReviewSteps: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.q336EvidenceReviewSteps,
      q336HardBlocks: GaussNativePackageHashEvidenceCaptureQ328JsonIntakeQ336Policy.q336HardBlocks,
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
