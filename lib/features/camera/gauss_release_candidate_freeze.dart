import 'gauss_release_candidate_freeze_policy.dart';
import 'gauss_store_release_candidate_audit.dart';

/// V172-Q300 — Release Candidate Freeze.
///
/// Final contract-only freeze gate after Q299. It keeps the project blocked from
/// release/store/OCR PASS claims until real Flutter, Android, Play Console,
/// privacy, Data Safety, runtime, and device evidence exists.
enum GaussReleaseCandidateFreezeDecision {
  releaseCandidateFreezeContractReadyReleaseBlocked,
  blockedMissingQ299StoreAudit,
  blockedMissingStoreReleaseEvidenceGate,
  blockedProtectedSurfaceRegression,
  blockedReviewApprovalRegression,
  blockedReleaseOrStoreAction,
  blockedRuntimeOrWorkspaceMutationRisk,
  blockedFakePassClaim,
}

class GaussReleaseCandidateFreezeInput {
  const GaussReleaseCandidateFreezeInput({
    required this.q299StoreReleaseCandidateAuditPresent,
    required this.q299StoreReleaseCandidateAuditStaticReady,
    required this.q298FullRealCameraOcrRegressionPresent,
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
    required this.contentRatingEvidenceRequired,
    required this.internalTestingEvidenceRequired,
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
    required this.releaseAabCreated,
    required this.releaseApkCreated,
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
    required this.releaseCandidateFreezePassClaimed,
    required this.storeReleaseCandidatePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.privacyPolicyPassClaimed,
    required this.dataSafetyPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.freezeLabel,
  });

  factory GaussReleaseCandidateFreezeInput.fromQ299Contract({
    required GaussStoreReleaseCandidateAuditResult q299Result,
    String freezeLabel = 'q300-release-candidate-freeze',
  }) {
    return GaussReleaseCandidateFreezeInput(
      q299StoreReleaseCandidateAuditPresent: true,
      q299StoreReleaseCandidateAuditStaticReady: q299Result.decision == GaussStoreReleaseCandidateAuditDecision.storeAuditContractReadyReleaseBlocked,
      q298FullRealCameraOcrRegressionPresent: true,
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
      contentRatingEvidenceRequired: true,
      internalTestingEvidenceRequired: true,
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
      storeSubmissionPerformed: q299Result.storeSubmissionPerformed,
      playConsoleConfigured: q299Result.playConsoleConfigured,
      productionReleaseCreated: q299Result.productionReleaseCreated,
      releaseAabCreated: false,
      releaseApkCreated: false,
      internalTestingTrackUploaded: q299Result.internalTestingTrackUploaded,
      realStoreListingAssetsAttached: q299Result.realStoreListingAssetsAttached,
      realLocalizedListingsAttached: q299Result.realLocalizedListingsAttached,
      directWorkspaceMutationAttempted: false,
      autoEvaluateAttempted: false,
      autoSolveGraphSolutionHistoryAttempted: false,
      runtimeDependencyAdded: false,
      methodChannelRuntimeBindingAdded: q299Result.methodChannelRuntimeBindingAdded,
      nativeRuntimeInvoked: false,
      modelBinaryBundledInBaseApp: q299Result.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: q299Result.productionDownloadEnabled,
      releaseCandidateFreezePassClaimed: false,
      storeReleaseCandidatePassClaimed: q299Result.storeReleaseCandidatePassClaimed,
      storeReadyPassClaimed: q299Result.storeReadyPassClaimed,
      releasePassClaimed: q299Result.releasePassClaimed,
      privacyPolicyPassClaimed: false,
      dataSafetyPassClaimed: false,
      ocrPassClaimed: q299Result.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: q299Result.cameraOcrRuntimePassClaimed,
      freezeLabel: freezeLabel,
    );
  }

  final bool q299StoreReleaseCandidateAuditPresent;
  final bool q299StoreReleaseCandidateAuditStaticReady;
  final bool q298FullRealCameraOcrRegressionPresent;
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
  final bool contentRatingEvidenceRequired;
  final bool internalTestingEvidenceRequired;
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
  final bool releaseAabCreated;
  final bool releaseApkCreated;
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
  final bool releaseCandidateFreezePassClaimed;
  final bool storeReleaseCandidatePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool privacyPolicyPassClaimed;
  final bool dataSafetyPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final String freezeLabel;
}

class GaussReleaseCandidateFreezeResult {
  const GaussReleaseCandidateFreezeResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.freezeFeatureFlag,
    required this.freezeReadinessState,
    required this.freezeContractStaticReady,
    required this.readyForFutureReleaseEvidenceOnly,
    required this.decision,
    required this.rejectionReasons,
    required this.requiredFreezeGates,
    required this.releaseFreezeCourtCases,
    required this.blockedUntilRealEvidence,
    required this.forbiddenActions,
    required this.storeSubmissionPerformed,
    required this.playConsoleConfigured,
    required this.productionReleaseCreated,
    required this.releaseAabCreated,
    required this.releaseApkCreated,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.releaseCandidateFreezePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.freezeLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String freezeFeatureFlag;
  final String freezeReadinessState;
  final bool freezeContractStaticReady;
  final bool readyForFutureReleaseEvidenceOnly;
  final GaussReleaseCandidateFreezeDecision decision;
  final List<String> rejectionReasons;
  final List<String> requiredFreezeGates;
  final List<String> releaseFreezeCourtCases;
  final List<String> blockedUntilRealEvidence;
  final List<String> forbiddenActions;
  final bool storeSubmissionPerformed;
  final bool playConsoleConfigured;
  final bool productionReleaseCreated;
  final bool releaseAabCreated;
  final bool releaseApkCreated;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool releaseCandidateFreezePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final String freezeLabel;

  bool get canSubmitStoreReleaseInQ300 => false;
  bool get canCreateReleaseBuildInQ300 => false;
  bool get canClaimStoreReadyPassInQ300 => false;
  bool get canClaimReleasePassInQ300 => false;
  bool get canClaimOcrPassInQ300 => false;
  bool get canMutateWorkspaceFromCameraInQ300 => false;
  bool get canEvaluateSolveGraphFromCameraInQ300 => false;
}

class GaussReleaseCandidateFreeze {
  const GaussReleaseCandidateFreeze._();

  static GaussReleaseCandidateFreezeResult evaluate(GaussReleaseCandidateFreezeInput input) {
    final rejections = <String>[];
    if (!input.q299StoreReleaseCandidateAuditPresent || !input.q299StoreReleaseCandidateAuditStaticReady) {
      rejections.add('missingQ299StoreReleaseCandidateAudit');
    }
    if (!input.q298FullRealCameraOcrRegressionPresent || !input.q297ApprovedWorkspaceImportPresent || !input.q296EditableMathLiveReviewPresent || !input.q295ImageToLatexInferencePresent || !input.q294DummyInputRuntimeCallPresent || !input.q293RuntimeStartupSmokePresent || !input.q292PrivateArtifactLoadSmokePresent || !input.q291PrivateModelDownloadShaPresent || !input.q288ArtifactSourceIntakePresent) {
      rejections.add('missingPreviousCameraOcrEvidenceChain');
    }
    if (!input.privacyPolicyRequired || !input.dataSafetyFormRequired || !input.cameraPermissionDisclosureRequired || !input.modelLicenseDisclosureRequired || !input.truthfulOcrClaimsRequired || !input.screenshotsRealDeviceEvidenceRequired || !input.localizationReviewRequired || !input.contentRatingEvidenceRequired || !input.internalTestingEvidenceRequired || !input.noMedicalFinancialOrExamGuaranteeClaims) {
      rejections.add('missingStoreReleaseEvidenceGate');
    }
    if (!input.keyboardLayoutProtected || !input.moreTemplateTrayProtected || !input.longPressListsProtected || !input.mathLiveProductionRouteProtected || !input.mathLiveBridgeProtected || !input.graphSolutionHistoryProtected || !input.appShellWorkspaceProtected || !input.androidManifestMainActivityProtected || !input.cameraDependenciesProtected || !input.androidToolchainProtected || !input.cameraShellRuntimeProtected) {
      rejections.add('protectedSurfaceRegression');
    }
    if (!input.editableMathLiveReviewStillRequired || !input.explicitUserApprovalStillRequired || !input.workspaceImportOnlyAfterApproval || !input.manualSolveGraphAfterImportOnly) {
      rejections.add('reviewApprovalRegression');
    }
    if (input.storeSubmissionPerformed || input.playConsoleConfigured || input.productionReleaseCreated || input.releaseAabCreated || input.releaseApkCreated || input.internalTestingTrackUploaded || input.realStoreListingAssetsAttached || input.realLocalizedListingsAttached) {
      rejections.add('releaseOrStoreActionAttempted');
    }
    if (input.directWorkspaceMutationAttempted || input.autoEvaluateAttempted || input.autoSolveGraphSolutionHistoryAttempted || input.runtimeDependencyAdded || input.methodChannelRuntimeBindingAdded || input.nativeRuntimeInvoked || input.modelBinaryBundledInBaseApp || input.productionDownloadEnabled) {
      rejections.add('runtimeOrWorkspaceMutationRisk');
    }
    if (input.releaseCandidateFreezePassClaimed || input.storeReleaseCandidatePassClaimed || input.storeReadyPassClaimed || input.releasePassClaimed || input.privacyPolicyPassClaimed || input.dataSafetyPassClaimed || input.ocrPassClaimed || input.cameraOcrRuntimePassClaimed) {
      rejections.add('fakePassClaim');
    }

    final decision = rejections.contains('missingQ299StoreReleaseCandidateAudit') || rejections.contains('missingPreviousCameraOcrEvidenceChain')
        ? GaussReleaseCandidateFreezeDecision.blockedMissingQ299StoreAudit
        : rejections.contains('missingStoreReleaseEvidenceGate')
            ? GaussReleaseCandidateFreezeDecision.blockedMissingStoreReleaseEvidenceGate
            : rejections.contains('protectedSurfaceRegression')
                ? GaussReleaseCandidateFreezeDecision.blockedProtectedSurfaceRegression
                : rejections.contains('reviewApprovalRegression')
                    ? GaussReleaseCandidateFreezeDecision.blockedReviewApprovalRegression
                    : rejections.contains('releaseOrStoreActionAttempted')
                        ? GaussReleaseCandidateFreezeDecision.blockedReleaseOrStoreAction
                        : rejections.contains('runtimeOrWorkspaceMutationRisk')
                            ? GaussReleaseCandidateFreezeDecision.blockedRuntimeOrWorkspaceMutationRisk
                            : rejections.contains('fakePassClaim')
                                ? GaussReleaseCandidateFreezeDecision.blockedFakePassClaim
                                : GaussReleaseCandidateFreezeDecision.releaseCandidateFreezeContractReadyReleaseBlocked;

    final staticReady = rejections.isEmpty;
    return GaussReleaseCandidateFreezeResult(
      phase: GaussReleaseCandidateFreezePolicy.phase,
      sourcePhase: GaussReleaseCandidateFreezePolicy.sourcePhase,
      selectedEngineLabel: GaussReleaseCandidateFreezePolicy.selectedEngineLabel,
      freezeFeatureFlag: GaussReleaseCandidateFreezePolicy.freezeFeatureFlag,
      freezeReadinessState: GaussReleaseCandidateFreezePolicy.freezeReadinessState,
      freezeContractStaticReady: staticReady,
      readyForFutureReleaseEvidenceOnly: staticReady,
      decision: decision,
      rejectionReasons: rejections,
      requiredFreezeGates: GaussReleaseCandidateFreezePolicy.requiredFreezeGates,
      releaseFreezeCourtCases: GaussReleaseCandidateFreezePolicy.releaseFreezeCourtCases,
      blockedUntilRealEvidence: GaussReleaseCandidateFreezePolicy.blockedUntilRealEvidence,
      forbiddenActions: GaussReleaseCandidateFreezePolicy.forbiddenActions,
      storeSubmissionPerformed: GaussReleaseCandidateFreezePolicy.storeSubmissionPerformed,
      playConsoleConfigured: GaussReleaseCandidateFreezePolicy.playConsoleConfigured,
      productionReleaseCreated: GaussReleaseCandidateFreezePolicy.productionReleaseCreated,
      releaseAabCreated: GaussReleaseCandidateFreezePolicy.releaseAabCreated,
      releaseApkCreated: GaussReleaseCandidateFreezePolicy.releaseApkCreated,
      methodChannelRuntimeBindingAdded: GaussReleaseCandidateFreezePolicy.methodChannelRuntimeBindingAdded,
      modelBinaryBundledInBaseApp: GaussReleaseCandidateFreezePolicy.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: GaussReleaseCandidateFreezePolicy.productionDownloadEnabled,
      releaseCandidateFreezePassClaimed: GaussReleaseCandidateFreezePolicy.releaseCandidateFreezePassClaimed,
      storeReadyPassClaimed: GaussReleaseCandidateFreezePolicy.storeReadyPassClaimed,
      releasePassClaimed: GaussReleaseCandidateFreezePolicy.releasePassClaimed,
      ocrPassClaimed: GaussReleaseCandidateFreezePolicy.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: GaussReleaseCandidateFreezePolicy.cameraOcrRuntimePassClaimed,
      freezeLabel: input.freezeLabel,
    );
  }
}
