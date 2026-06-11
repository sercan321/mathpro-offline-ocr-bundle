import 'gauss_store_privacy_final_release_gate_q363_policy.dart';

class GaussStorePrivacyFinalReleaseGateQ363Result {
  const GaussStorePrivacyFinalReleaseGateQ363Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.selectedDependencyCoordinate,
    required this.expectedOnnxArtifactSha256,
    required this.expectedOnnxArtifactSizeBytes,
    required this.storePrivacyGatePrepared,
    required this.dataSafetyGatePrepared,
    required this.finalReleaseGatePrepared,
    required this.cameraPermissionDisclosureRequired,
    required this.offlineOcrDisclosureRequired,
    required this.privateModelStorageDisclosureRequired,
    required this.modelStorageCleanupPolicyRequired,
    required this.requiresRealDeviceFlutterEvidenceBeforeRelease,
    required this.requiresOnnxRuntimeEvidenceBeforeRelease,
    required this.requiresModelLoadEvidenceBeforeRelease,
    required this.requiresDummyCallEvidenceBeforeRelease,
    required this.requiresImageToLatexEvidenceBeforeRelease,
    required this.requiresEditableMathLiveReviewEvidenceBeforeRelease,
    required this.requiresApprovedWorkspaceImportEvidenceBeforeRelease,
    required this.requiresAccuracyPerformanceMultideviceEvidenceBeforeRelease,
    required this.requiresEditableMathLiveReviewBeforeImport,
    required this.requiresExplicitUserApprovalBeforeWorkspaceImport,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.featureFlagDefaultEnabled,
    required this.runtimeAutoExecutionBlocked,
    required this.storeReadyPassClaimed,
    required this.privacyDataSafetyPassClaimed,
    required this.finalReleasePassClaimed,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String selectedDependencyCoordinate;
  final String expectedOnnxArtifactSha256;
  final int expectedOnnxArtifactSizeBytes;
  final bool storePrivacyGatePrepared;
  final bool dataSafetyGatePrepared;
  final bool finalReleaseGatePrepared;
  final bool cameraPermissionDisclosureRequired;
  final bool offlineOcrDisclosureRequired;
  final bool privateModelStorageDisclosureRequired;
  final bool modelStorageCleanupPolicyRequired;
  final bool requiresRealDeviceFlutterEvidenceBeforeRelease;
  final bool requiresOnnxRuntimeEvidenceBeforeRelease;
  final bool requiresModelLoadEvidenceBeforeRelease;
  final bool requiresDummyCallEvidenceBeforeRelease;
  final bool requiresImageToLatexEvidenceBeforeRelease;
  final bool requiresEditableMathLiveReviewEvidenceBeforeRelease;
  final bool requiresApprovedWorkspaceImportEvidenceBeforeRelease;
  final bool requiresAccuracyPerformanceMultideviceEvidenceBeforeRelease;
  final bool requiresEditableMathLiveReviewBeforeImport;
  final bool requiresExplicitUserApprovalBeforeWorkspaceImport;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool featureFlagDefaultEnabled;
  final bool runtimeAutoExecutionBlocked;
  final bool storeReadyPassClaimed;
  final bool privacyDataSafetyPassClaimed;
  final bool finalReleasePassClaimed;
  final bool ocrPassClaimed;
}

class GaussStorePrivacyFinalReleaseGateQ363 {
  const GaussStorePrivacyFinalReleaseGateQ363._();

  static GaussStorePrivacyFinalReleaseGateQ363Result evaluate() {
    return const GaussStorePrivacyFinalReleaseGateQ363Result(
      phase: GaussStorePrivacyFinalReleaseGateQ363Policy.phase,
      sourcePhase: GaussStorePrivacyFinalReleaseGateQ363Policy.sourcePhase,
      status: GaussStorePrivacyFinalReleaseGateQ363Policy.status,
      selectedDependencyCoordinate: GaussStorePrivacyFinalReleaseGateQ363Policy.selectedDependencyCoordinate,
      expectedOnnxArtifactSha256: GaussStorePrivacyFinalReleaseGateQ363Policy.expectedOnnxArtifactSha256,
      expectedOnnxArtifactSizeBytes: GaussStorePrivacyFinalReleaseGateQ363Policy.expectedOnnxArtifactSizeBytes,
      storePrivacyGatePrepared: true,
      dataSafetyGatePrepared: true,
      finalReleaseGatePrepared: true,
      cameraPermissionDisclosureRequired: true,
      offlineOcrDisclosureRequired: true,
      privateModelStorageDisclosureRequired: true,
      modelStorageCleanupPolicyRequired: true,
      requiresRealDeviceFlutterEvidenceBeforeRelease: true,
      requiresOnnxRuntimeEvidenceBeforeRelease: true,
      requiresModelLoadEvidenceBeforeRelease: true,
      requiresDummyCallEvidenceBeforeRelease: true,
      requiresImageToLatexEvidenceBeforeRelease: true,
      requiresEditableMathLiveReviewEvidenceBeforeRelease: true,
      requiresApprovedWorkspaceImportEvidenceBeforeRelease: true,
      requiresAccuracyPerformanceMultideviceEvidenceBeforeRelease: true,
      requiresEditableMathLiveReviewBeforeImport: true,
      requiresExplicitUserApprovalBeforeWorkspaceImport: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      featureFlagDefaultEnabled: false,
      runtimeAutoExecutionBlocked: true,
      storeReadyPassClaimed: false,
      privacyDataSafetyPassClaimed: false,
      finalReleasePassClaimed: false,
      ocrPassClaimed: false,
    );
  }
}
