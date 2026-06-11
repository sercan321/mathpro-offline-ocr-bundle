import 'gauss_full_real_camera_ocr_regression.dart';
import 'gauss_store_release_candidate_audit_policy.dart';

/// V172-Q299 — Store Release Candidate Audit.
///
/// Contract-only store audit gate. It checks whether the future Camera/OCR
/// chain remains truthful, review-first, approval-first, and blocked from store
/// or release claims until real Play Console, privacy, Data Safety, device, and
/// OCR/runtime evidence exists.
enum GaussStoreReleaseCandidateAuditDecision {
  storeAuditContractReadyReleaseBlocked,
  blockedMissingQ298Regression,
  blockedMissingStoreDisclosureGate,
  blockedProtectedSurfaceRegression,
  blockedReviewApprovalRegression,
  blockedStoreSubmissionOrClaim,
  blockedRuntimeOrWorkspaceMutationRisk,
  blockedFakePassClaim,
}

class GaussStoreReleaseCandidateAuditInput {
  const GaussStoreReleaseCandidateAuditInput({
    required this.q298FullRealCameraOcrRegressionPresent,
    required this.q298FullRealCameraOcrRegressionStaticReady,
    required this.q297ApprovedWorkspaceImportPresent,
    required this.q296EditableMathLiveReviewPresent,
    required this.q295ImageToLatexInferencePresent,
    required this.q294DummyInputRuntimeCallPresent,
    required this.q293RuntimeStartupSmokePresent,
    required this.q292PrivateArtifactLoadSmokePresent,
    required this.q291PrivateModelDownloadShaPresent,
    required this.q288ArtifactSourceIntakePresent,
    required this.privacyPolicyRequired,
    required this.dataSafetyFormRequired,
    required this.cameraPermissionDisclosureRequired,
    required this.modelLicenseDisclosureRequired,
    required this.truthfulOcrClaimsRequired,
    required this.screenshotsRealDeviceEvidenceRequired,
    required this.localizationReviewRequired,
    required this.noMedicalFinancialOrExamGuaranteeClaims,
    required this.keyboardLayoutProtected,
    required this.moreTemplateTrayProtected,
    required this.longPressListsProtected,
    required this.mathLiveProductionRouteProtected,
    required this.mathLiveBridgeProtected,
    required this.graphSolutionHistoryProtected,
    required this.appShellWorkspaceProtected,
    required this.androidManifestMainActivityProtected,
    required this.cameraDependenciesProtected,
    required this.androidToolchainProtected,
    required this.cameraShellRuntimeProtected,
    required this.editableMathLiveReviewStillRequired,
    required this.explicitUserApprovalStillRequired,
    required this.workspaceImportOnlyAfterApproval,
    required this.manualSolveGraphAfterImportOnly,
    required this.storeSubmissionPerformed,
    required this.playConsoleConfigured,
    required this.productionReleaseCreated,
    required this.internalTestingTrackUploaded,
    required this.realStoreListingAssetsAttached,
    required this.realLocalizedListingsAttached,
    required this.directWorkspaceMutationAttempted,
    required this.autoEvaluateAttempted,
    required this.autoSolveGraphSolutionHistoryAttempted,
    required this.runtimeDependencyAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeInvoked,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.storeReleaseCandidatePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.privacyPolicyPassClaimed,
    required this.dataSafetyPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.auditLabel,
  });

  factory GaussStoreReleaseCandidateAuditInput.fromQ298Contract({
    required GaussFullRealCameraOcrRegressionResult q298Result,
    String auditLabel = 'q299-store-release-candidate-audit',
  }) {
    return GaussStoreReleaseCandidateAuditInput(
      q298FullRealCameraOcrRegressionPresent: true,
      q298FullRealCameraOcrRegressionStaticReady: q298Result.decision == GaussFullRealCameraOcrRegressionDecision.fullRegressionContractReadyRealRuntimeBlocked,
      q297ApprovedWorkspaceImportPresent: true,
      q296EditableMathLiveReviewPresent: true,
      q295ImageToLatexInferencePresent: true,
      q294DummyInputRuntimeCallPresent: true,
      q293RuntimeStartupSmokePresent: true,
      q292PrivateArtifactLoadSmokePresent: true,
      q291PrivateModelDownloadShaPresent: true,
      q288ArtifactSourceIntakePresent: true,
      privacyPolicyRequired: true,
      dataSafetyFormRequired: true,
      cameraPermissionDisclosureRequired: true,
      modelLicenseDisclosureRequired: true,
      truthfulOcrClaimsRequired: true,
      screenshotsRealDeviceEvidenceRequired: true,
      localizationReviewRequired: true,
      noMedicalFinancialOrExamGuaranteeClaims: true,
      keyboardLayoutProtected: true,
      moreTemplateTrayProtected: true,
      longPressListsProtected: true,
      mathLiveProductionRouteProtected: true,
      mathLiveBridgeProtected: true,
      graphSolutionHistoryProtected: true,
      appShellWorkspaceProtected: true,
      androidManifestMainActivityProtected: true,
      cameraDependenciesProtected: true,
      androidToolchainProtected: true,
      cameraShellRuntimeProtected: true,
      editableMathLiveReviewStillRequired: true,
      explicitUserApprovalStillRequired: true,
      workspaceImportOnlyAfterApproval: true,
      manualSolveGraphAfterImportOnly: true,
      storeSubmissionPerformed: false,
      playConsoleConfigured: false,
      productionReleaseCreated: false,
      internalTestingTrackUploaded: false,
      realStoreListingAssetsAttached: false,
      realLocalizedListingsAttached: false,
      directWorkspaceMutationAttempted: false,
      autoEvaluateAttempted: false,
      autoSolveGraphSolutionHistoryAttempted: false,
      runtimeDependencyAdded: false,
      methodChannelRuntimeBindingAdded: q298Result.methodChannelRuntimeBindingAdded,
      nativeRuntimeInvoked: q298Result.nativeRuntimeStartupExecuted,
      modelBinaryBundledInBaseApp: q298Result.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: q298Result.productionDownloadEnabled,
      storeReleaseCandidatePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: q298Result.releasePassClaimed,
      privacyPolicyPassClaimed: false,
      dataSafetyPassClaimed: false,
      ocrPassClaimed: q298Result.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: q298Result.cameraOcrRuntimePassClaimed,
      auditLabel: auditLabel,
    );
  }

  final bool q298FullRealCameraOcrRegressionPresent;
  final bool q298FullRealCameraOcrRegressionStaticReady;
  final bool q297ApprovedWorkspaceImportPresent;
  final bool q296EditableMathLiveReviewPresent;
  final bool q295ImageToLatexInferencePresent;
  final bool q294DummyInputRuntimeCallPresent;
  final bool q293RuntimeStartupSmokePresent;
  final bool q292PrivateArtifactLoadSmokePresent;
  final bool q291PrivateModelDownloadShaPresent;
  final bool q288ArtifactSourceIntakePresent;
  final bool privacyPolicyRequired;
  final bool dataSafetyFormRequired;
  final bool cameraPermissionDisclosureRequired;
  final bool modelLicenseDisclosureRequired;
  final bool truthfulOcrClaimsRequired;
  final bool screenshotsRealDeviceEvidenceRequired;
  final bool localizationReviewRequired;
  final bool noMedicalFinancialOrExamGuaranteeClaims;
  final bool keyboardLayoutProtected;
  final bool moreTemplateTrayProtected;
  final bool longPressListsProtected;
  final bool mathLiveProductionRouteProtected;
  final bool mathLiveBridgeProtected;
  final bool graphSolutionHistoryProtected;
  final bool appShellWorkspaceProtected;
  final bool androidManifestMainActivityProtected;
  final bool cameraDependenciesProtected;
  final bool androidToolchainProtected;
  final bool cameraShellRuntimeProtected;
  final bool editableMathLiveReviewStillRequired;
  final bool explicitUserApprovalStillRequired;
  final bool workspaceImportOnlyAfterApproval;
  final bool manualSolveGraphAfterImportOnly;
  final bool storeSubmissionPerformed;
  final bool playConsoleConfigured;
  final bool productionReleaseCreated;
  final bool internalTestingTrackUploaded;
  final bool realStoreListingAssetsAttached;
  final bool realLocalizedListingsAttached;
  final bool directWorkspaceMutationAttempted;
  final bool autoEvaluateAttempted;
  final bool autoSolveGraphSolutionHistoryAttempted;
  final bool runtimeDependencyAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeInvoked;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool storeReleaseCandidatePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool privacyPolicyPassClaimed;
  final bool dataSafetyPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final String auditLabel;
}

class GaussStoreReleaseCandidateAuditResult {
  const GaussStoreReleaseCandidateAuditResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.auditFeatureFlag,
    required this.auditReadinessState,
    required this.storeAuditContractStaticReady,
    required this.readyForFutureStoreSubmissionEvidenceOnly,
    required this.decision,
    required this.rejectionReasons,
    required this.requiredStoreAuditGates,
    required this.storeAuditCourtCases,
    required this.blockedUntilRealEvidence,
    required this.forbiddenActions,
    required this.storeSubmissionPerformed,
    required this.playConsoleConfigured,
    required this.productionReleaseCreated,
    required this.internalTestingTrackUploaded,
    required this.realStoreListingAssetsAttached,
    required this.realLocalizedListingsAttached,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.storeReleaseCandidatePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.auditLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String auditFeatureFlag;
  final String auditReadinessState;
  final bool storeAuditContractStaticReady;
  final bool readyForFutureStoreSubmissionEvidenceOnly;
  final GaussStoreReleaseCandidateAuditDecision decision;
  final List<String> rejectionReasons;
  final List<String> requiredStoreAuditGates;
  final List<String> storeAuditCourtCases;
  final List<String> blockedUntilRealEvidence;
  final List<String> forbiddenActions;
  final bool storeSubmissionPerformed;
  final bool playConsoleConfigured;
  final bool productionReleaseCreated;
  final bool internalTestingTrackUploaded;
  final bool realStoreListingAssetsAttached;
  final bool realLocalizedListingsAttached;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool storeReleaseCandidatePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final String auditLabel;

  bool get canSubmitStoreReleaseInQ299 => false;
  bool get canClaimStoreReadyPassInQ299 => false;
  bool get canClaimReleasePassInQ299 => false;
  bool get canClaimOcrPassInQ299 => false;
  bool get canMutateWorkspaceFromCameraInQ299 => false;
  bool get canEvaluateSolveGraphFromCameraInQ299 => false;
}

class GaussStoreReleaseCandidateAudit {
  const GaussStoreReleaseCandidateAudit._();

  static GaussStoreReleaseCandidateAuditResult evaluate(GaussStoreReleaseCandidateAuditInput input) {
    final rejections = <String>[];
    if (!input.q298FullRealCameraOcrRegressionPresent || !input.q298FullRealCameraOcrRegressionStaticReady) {
      rejections.add('missingQ298FullRealCameraOcrRegression');
    }
    if (!input.q297ApprovedWorkspaceImportPresent || !input.q296EditableMathLiveReviewPresent || !input.q295ImageToLatexInferencePresent || !input.q294DummyInputRuntimeCallPresent || !input.q293RuntimeStartupSmokePresent || !input.q292PrivateArtifactLoadSmokePresent || !input.q291PrivateModelDownloadShaPresent || !input.q288ArtifactSourceIntakePresent) {
      rejections.add('missingPreviousCameraOcrEvidenceChain');
    }
    if (!input.privacyPolicyRequired || !input.dataSafetyFormRequired || !input.cameraPermissionDisclosureRequired || !input.modelLicenseDisclosureRequired || !input.truthfulOcrClaimsRequired || !input.screenshotsRealDeviceEvidenceRequired || !input.localizationReviewRequired || !input.noMedicalFinancialOrExamGuaranteeClaims) {
      rejections.add('missingStoreDisclosureGate');
    }
    if (!input.keyboardLayoutProtected || !input.moreTemplateTrayProtected || !input.longPressListsProtected || !input.mathLiveProductionRouteProtected || !input.mathLiveBridgeProtected || !input.graphSolutionHistoryProtected || !input.appShellWorkspaceProtected || !input.androidManifestMainActivityProtected || !input.cameraDependenciesProtected || !input.androidToolchainProtected || !input.cameraShellRuntimeProtected) {
      rejections.add('protectedSurfaceRegression');
    }
    if (!input.editableMathLiveReviewStillRequired || !input.explicitUserApprovalStillRequired || !input.workspaceImportOnlyAfterApproval || !input.manualSolveGraphAfterImportOnly) {
      rejections.add('reviewApprovalRegression');
    }
    if (input.storeSubmissionPerformed || input.playConsoleConfigured || input.productionReleaseCreated || input.internalTestingTrackUploaded || input.realStoreListingAssetsAttached || input.realLocalizedListingsAttached) {
      rejections.add('storeSubmissionOrClaimAttempted');
    }
    if (input.directWorkspaceMutationAttempted || input.autoEvaluateAttempted || input.autoSolveGraphSolutionHistoryAttempted || input.runtimeDependencyAdded || input.methodChannelRuntimeBindingAdded || input.nativeRuntimeInvoked || input.modelBinaryBundledInBaseApp || input.productionDownloadEnabled) {
      rejections.add('runtimeOrWorkspaceMutationRisk');
    }
    if (input.storeReleaseCandidatePassClaimed || input.storeReadyPassClaimed || input.releasePassClaimed || input.privacyPolicyPassClaimed || input.dataSafetyPassClaimed || input.ocrPassClaimed || input.cameraOcrRuntimePassClaimed) {
      rejections.add('fakePassClaim');
    }

    final decision = rejections.contains('missingQ298FullRealCameraOcrRegression') || rejections.contains('missingPreviousCameraOcrEvidenceChain')
        ? GaussStoreReleaseCandidateAuditDecision.blockedMissingQ298Regression
        : rejections.contains('missingStoreDisclosureGate')
            ? GaussStoreReleaseCandidateAuditDecision.blockedMissingStoreDisclosureGate
            : rejections.contains('protectedSurfaceRegression')
                ? GaussStoreReleaseCandidateAuditDecision.blockedProtectedSurfaceRegression
                : rejections.contains('reviewApprovalRegression')
                    ? GaussStoreReleaseCandidateAuditDecision.blockedReviewApprovalRegression
                    : rejections.contains('storeSubmissionOrClaimAttempted')
                        ? GaussStoreReleaseCandidateAuditDecision.blockedStoreSubmissionOrClaim
                        : rejections.contains('runtimeOrWorkspaceMutationRisk')
                            ? GaussStoreReleaseCandidateAuditDecision.blockedRuntimeOrWorkspaceMutationRisk
                            : rejections.contains('fakePassClaim')
                                ? GaussStoreReleaseCandidateAuditDecision.blockedFakePassClaim
                                : GaussStoreReleaseCandidateAuditDecision.storeAuditContractReadyReleaseBlocked;

    final staticReady = rejections.isEmpty;
    return GaussStoreReleaseCandidateAuditResult(
      phase: GaussStoreReleaseCandidateAuditPolicy.phase,
      sourcePhase: GaussStoreReleaseCandidateAuditPolicy.sourcePhase,
      selectedEngineLabel: GaussStoreReleaseCandidateAuditPolicy.selectedEngineLabel,
      auditFeatureFlag: GaussStoreReleaseCandidateAuditPolicy.auditFeatureFlag,
      auditReadinessState: GaussStoreReleaseCandidateAuditPolicy.auditReadinessState,
      storeAuditContractStaticReady: staticReady,
      readyForFutureStoreSubmissionEvidenceOnly: staticReady,
      decision: decision,
      rejectionReasons: rejections,
      requiredStoreAuditGates: GaussStoreReleaseCandidateAuditPolicy.requiredStoreAuditGates,
      storeAuditCourtCases: GaussStoreReleaseCandidateAuditPolicy.storeAuditCourtCases,
      blockedUntilRealEvidence: GaussStoreReleaseCandidateAuditPolicy.blockedUntilRealEvidence,
      forbiddenActions: GaussStoreReleaseCandidateAuditPolicy.forbiddenActions,
      storeSubmissionPerformed: GaussStoreReleaseCandidateAuditPolicy.storeSubmissionPerformed,
      playConsoleConfigured: GaussStoreReleaseCandidateAuditPolicy.playConsoleConfigured,
      productionReleaseCreated: GaussStoreReleaseCandidateAuditPolicy.productionReleaseCreated,
      internalTestingTrackUploaded: GaussStoreReleaseCandidateAuditPolicy.internalTestingTrackUploaded,
      realStoreListingAssetsAttached: GaussStoreReleaseCandidateAuditPolicy.realStoreListingAssetsAttached,
      realLocalizedListingsAttached: GaussStoreReleaseCandidateAuditPolicy.realLocalizedListingsAttached,
      methodChannelRuntimeBindingAdded: GaussStoreReleaseCandidateAuditPolicy.methodChannelRuntimeBindingAdded,
      modelBinaryBundledInBaseApp: GaussStoreReleaseCandidateAuditPolicy.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: GaussStoreReleaseCandidateAuditPolicy.productionDownloadEnabled,
      storeReleaseCandidatePassClaimed: GaussStoreReleaseCandidateAuditPolicy.storeReleaseCandidatePassClaimed,
      storeReadyPassClaimed: GaussStoreReleaseCandidateAuditPolicy.storeReadyPassClaimed,
      releasePassClaimed: GaussStoreReleaseCandidateAuditPolicy.releasePassClaimed,
      ocrPassClaimed: GaussStoreReleaseCandidateAuditPolicy.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: GaussStoreReleaseCandidateAuditPolicy.cameraOcrRuntimePassClaimed,
      auditLabel: input.auditLabel,
    );
  }
}
