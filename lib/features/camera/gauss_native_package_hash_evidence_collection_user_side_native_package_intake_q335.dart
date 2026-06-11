import 'gauss_native_package_hash_evidence_collection_user_side_native_package_intake_q335_policy.dart';

class GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Result {
  const GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Result({
    required this.phase,
    required this.sourcePhase,
    required this.methodName,
    required this.status,
    required this.requiredNativePackageFiles,
    required this.optionalNativePackageFiles,
    required this.plannedBundleTargets,
    required this.q335UserSideIntakeSteps,
    required this.q335HardBlocks,
    required this.userSideNativePackageFilesProvided,
    required this.q328NativePackageHashEvidenceJsonProvided,
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
  final List<String> q335UserSideIntakeSteps;
  final List<String> q335HardBlocks;
  final bool userSideNativePackageFilesProvided;
  final bool q328NativePackageHashEvidenceJsonProvided;
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

class GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335 {
  const GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335._();

  static GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Result evaluate() {
    return const GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Result(
      phase: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.phase,
      sourcePhase: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.sourcePhase,
      methodName: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.methodName,
      status: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.status,
      requiredNativePackageFiles: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.requiredNativePackageFiles,
      optionalNativePackageFiles: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.optionalNativePackageFiles,
      plannedBundleTargets: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.plannedBundleTargets,
      q335UserSideIntakeSteps: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.q335UserSideIntakeSteps,
      q335HardBlocks: GaussNativePackageHashEvidenceCollectionUserSideNativePackageIntakeQ335Policy.q335HardBlocks,
      userSideNativePackageFilesProvided: false,
      q328NativePackageHashEvidenceJsonProvided: false,
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
