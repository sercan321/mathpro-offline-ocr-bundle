import 'gauss_full_camera_ocr_runtime_premium_regression.dart';
import 'gauss_store_readiness_camera_ocr_release_audit_policy.dart';

/// V172-Q287 — Store-readiness Camera/OCR Release Audit.
///
/// This is a release/store audit court only. It does not submit to Play Store,
/// does not build a production AAB/APK, does not add OCR runtime, and does not
/// claim release readiness without real evidence.
enum GaussStoreReadinessCameraOcrReleaseAuditDecision {
  blockedMissingQ286FullRegressionCourt,
  blockedMissingStoreEvidence,
  blockedProtectedSurfaceRegression,
  blockedUnsafeClaimsOrPolicyRisk,
  blockedAutomaticCameraSideEffectRisk,
  blockedRuntimeOrPackagingMutation,
  blockedFakeReleasePassClaim,
  readyForFutureStoreReadinessEvidenceOnly,
}

class GaussStoreReadinessCameraOcrReleaseAuditInput {
  const GaussStoreReadinessCameraOcrReleaseAuditInput({
    required this.q286FullCameraOcrRuntimePremiumRegressionPresent,
    required this.q286FullCameraOcrRuntimePremiumRegressionStaticReady,
    required this.realFlutterAnalyzeCleanLogAvailable,
    required this.realFlutterTestPassLogAvailable,
    required this.realFlutterRunDeviceLogAvailable,
    required this.realCameraPreviewCaptureEvidenceAvailable,
    required this.realMathLiveReviewEvidenceAvailable,
    required this.storeListingCopyEvidenceAvailable,
    required this.privacyPolicyEvidenceAvailable,
    required this.dataSafetyFormEvidenceAvailable,
    required this.cameraPermissionDisclosureEvidenceAvailable,
    required this.modelLicenseEvidenceAvailable,
    required this.modelSizeEvidenceAvailable,
    required this.baseApkAabSizeEvidenceAvailable,
    required this.noBundledModelEvidenceAvailable,
    required this.crashFreeDeviceEvidenceAvailable,
    required this.keyboardLayoutProtected,
    required this.moreTemplateTrayProtected,
    required this.longPressListsProtected,
    required this.mathLiveProductionRouteProtected,
    required this.graphSurfaceProtected,
    required this.solutionSurfaceProtected,
    required this.historySurfaceProtected,
    required this.appShellWorkspaceProtected,
    required this.splashIconProtected,
    required this.androidManifestMainActivityProtected,
    required this.cameraDependenciesProtected,
    required this.androidToolchainProtected,
    required this.reviewBeforeImportStillMandatory,
    required this.explicitUserApprovalStillMandatory,
    required this.workspaceImportOnlyAfterApproval,
    required this.directWorkspaceMutationAttempted,
    required this.autoEvaluateAttempted,
    required this.autoSolveAttempted,
    required this.autoGraphAttempted,
    required this.autoSolutionAttempted,
    required this.autoHistoryAttempted,
    required this.playStoreSubmissionExecutedInQ287,
    required this.releaseCandidateFreezeExecutedInQ287,
    required this.productionAabBuiltInQ287,
    required this.productionApkBuiltInQ287,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.runtimeDependencyAddedToPubspec,
    required this.gradleNativeRuntimeDependencyAdded,
    required this.nativeHandlerImplementationAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionModelUrlBound,
    required this.productionDownloadEnabled,
    required this.realNetworkDownloadWorkerImplemented,
    required this.unsafeOcrAccuracyMarketingClaimed,
    required this.photomathLevelClaimedWithoutEvidence,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.premiumFinalPassClaimed,
    required this.auditLabel,
  });

  factory GaussStoreReadinessCameraOcrReleaseAuditInput.fromQ286Regression({
    required GaussFullCameraOcrRuntimePremiumRegressionResult q286Result,
    String auditLabel = 'q287-store-readiness-camera-ocr-release-audit',
  }) {
    return GaussStoreReadinessCameraOcrReleaseAuditInput(
      q286FullCameraOcrRuntimePremiumRegressionPresent: true,
      q286FullCameraOcrRuntimePremiumRegressionStaticReady: q286Result.fullRegressionCourtStaticReady,
      realFlutterAnalyzeCleanLogAvailable: false,
      realFlutterTestPassLogAvailable: false,
      realFlutterRunDeviceLogAvailable: false,
      realCameraPreviewCaptureEvidenceAvailable: false,
      realMathLiveReviewEvidenceAvailable: false,
      storeListingCopyEvidenceAvailable: false,
      privacyPolicyEvidenceAvailable: false,
      dataSafetyFormEvidenceAvailable: false,
      cameraPermissionDisclosureEvidenceAvailable: false,
      modelLicenseEvidenceAvailable: false,
      modelSizeEvidenceAvailable: false,
      baseApkAabSizeEvidenceAvailable: false,
      noBundledModelEvidenceAvailable: !q286Result.modelBinaryBundledInBaseApp,
      crashFreeDeviceEvidenceAvailable: false,
      keyboardLayoutProtected: true,
      moreTemplateTrayProtected: true,
      longPressListsProtected: true,
      mathLiveProductionRouteProtected: true,
      graphSurfaceProtected: true,
      solutionSurfaceProtected: true,
      historySurfaceProtected: true,
      appShellWorkspaceProtected: true,
      splashIconProtected: true,
      androidManifestMainActivityProtected: true,
      cameraDependenciesProtected: true,
      androidToolchainProtected: true,
      reviewBeforeImportStillMandatory: true,
      explicitUserApprovalStillMandatory: true,
      workspaceImportOnlyAfterApproval: true,
      directWorkspaceMutationAttempted: q286Result.canMutateWorkspaceFromCameraInQ286,
      autoEvaluateAttempted: q286Result.canEvaluateFromCameraInQ286,
      autoSolveAttempted: q286Result.canSolveFromCameraInQ286,
      autoGraphAttempted: q286Result.canGraphFromCameraInQ286,
      autoSolutionAttempted: q286Result.canWriteSolutionOrHistoryFromCameraInQ286,
      autoHistoryAttempted: q286Result.canWriteSolutionOrHistoryFromCameraInQ286,
      playStoreSubmissionExecutedInQ287: false,
      releaseCandidateFreezeExecutedInQ287: false,
      productionAabBuiltInQ287: false,
      productionApkBuiltInQ287: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      runtimeDependencyAddedToPubspec: false,
      gradleNativeRuntimeDependencyAdded: false,
      nativeHandlerImplementationAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      productionDownloadEnabled: false,
      realNetworkDownloadWorkerImplemented: false,
      unsafeOcrAccuracyMarketingClaimed: false,
      photomathLevelClaimedWithoutEvidence: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      ocrPassClaimed: q286Result.canClaimOcrPassInQ286,
      cameraOcrRuntimePassClaimed: false,
      premiumFinalPassClaimed: false,
      auditLabel: auditLabel,
    );
  }

  final bool q286FullCameraOcrRuntimePremiumRegressionPresent;
  final bool q286FullCameraOcrRuntimePremiumRegressionStaticReady;
  final bool realFlutterAnalyzeCleanLogAvailable;
  final bool realFlutterTestPassLogAvailable;
  final bool realFlutterRunDeviceLogAvailable;
  final bool realCameraPreviewCaptureEvidenceAvailable;
  final bool realMathLiveReviewEvidenceAvailable;
  final bool storeListingCopyEvidenceAvailable;
  final bool privacyPolicyEvidenceAvailable;
  final bool dataSafetyFormEvidenceAvailable;
  final bool cameraPermissionDisclosureEvidenceAvailable;
  final bool modelLicenseEvidenceAvailable;
  final bool modelSizeEvidenceAvailable;
  final bool baseApkAabSizeEvidenceAvailable;
  final bool noBundledModelEvidenceAvailable;
  final bool crashFreeDeviceEvidenceAvailable;
  final bool keyboardLayoutProtected;
  final bool moreTemplateTrayProtected;
  final bool longPressListsProtected;
  final bool mathLiveProductionRouteProtected;
  final bool graphSurfaceProtected;
  final bool solutionSurfaceProtected;
  final bool historySurfaceProtected;
  final bool appShellWorkspaceProtected;
  final bool splashIconProtected;
  final bool androidManifestMainActivityProtected;
  final bool cameraDependenciesProtected;
  final bool androidToolchainProtected;
  final bool reviewBeforeImportStillMandatory;
  final bool explicitUserApprovalStillMandatory;
  final bool workspaceImportOnlyAfterApproval;
  final bool directWorkspaceMutationAttempted;
  final bool autoEvaluateAttempted;
  final bool autoSolveAttempted;
  final bool autoGraphAttempted;
  final bool autoSolutionAttempted;
  final bool autoHistoryAttempted;
  final bool playStoreSubmissionExecutedInQ287;
  final bool releaseCandidateFreezeExecutedInQ287;
  final bool productionAabBuiltInQ287;
  final bool productionApkBuiltInQ287;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool runtimeDependencyAddedToPubspec;
  final bool gradleNativeRuntimeDependencyAdded;
  final bool nativeHandlerImplementationAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionModelUrlBound;
  final bool productionDownloadEnabled;
  final bool realNetworkDownloadWorkerImplemented;
  final bool unsafeOcrAccuracyMarketingClaimed;
  final bool photomathLevelClaimedWithoutEvidence;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool premiumFinalPassClaimed;
  final String auditLabel;
}

class GaussStoreReadinessCameraOcrReleaseAuditResult {
  const GaussStoreReadinessCameraOcrReleaseAuditResult._({
    required this.decision,
    required this.storeReadinessAuditStaticReady,
    required this.readyForFutureStoreReadinessEvidenceOnly,
    required this.rejectionReasons,
    required this.canSubmitToPlayStoreInQ287,
    required this.canBuildProductionAabInQ287,
    required this.canClaimStoreReadyPassInQ287,
    required this.canClaimReleasePassInQ287,
    required this.canClaimOcrPassInQ287,
    required this.canUseOcrAccuracyMarketingClaimsInQ287,
    required this.auditLabel,
  });

  final GaussStoreReadinessCameraOcrReleaseAuditDecision decision;
  final bool storeReadinessAuditStaticReady;
  final bool readyForFutureStoreReadinessEvidenceOnly;
  final List<String> rejectionReasons;
  final bool canSubmitToPlayStoreInQ287;
  final bool canBuildProductionAabInQ287;
  final bool canClaimStoreReadyPassInQ287;
  final bool canClaimReleasePassInQ287;
  final bool canClaimOcrPassInQ287;
  final bool canUseOcrAccuracyMarketingClaimsInQ287;
  final String auditLabel;

  String get phase => GaussStoreReadinessCameraOcrReleaseAuditPolicy.phase;
  String get sourcePhase => GaussStoreReadinessCameraOcrReleaseAuditPolicy.sourcePhase;
  String get selectedEngineLabel => GaussStoreReadinessCameraOcrReleaseAuditPolicy.selectedEngineLabel;
  String get auditMode => GaussStoreReadinessCameraOcrReleaseAuditPolicy.auditMode;
  bool get playStoreSubmissionExecutedInQ287 => GaussStoreReadinessCameraOcrReleaseAuditPolicy.playStoreSubmissionExecutedInQ287;
  bool get productionAabBuiltInQ287 => GaussStoreReadinessCameraOcrReleaseAuditPolicy.productionAabBuiltInQ287;
  bool get realOcrRuntimeAdded => GaussStoreReadinessCameraOcrReleaseAuditPolicy.realOcrRuntimeAdded;
  bool get modelBinaryBundledInBaseApp => GaussStoreReadinessCameraOcrReleaseAuditPolicy.modelBinaryBundledInBaseApp;
  bool get releasePassClaimed => GaussStoreReadinessCameraOcrReleaseAuditPolicy.releasePassClaimed;
  List<String> get requiredStoreAuditGates => GaussStoreReadinessCameraOcrReleaseAuditPolicy.requiredStoreAuditGates;
  List<String> get storeEvidenceFields => GaussStoreReadinessCameraOcrReleaseAuditPolicy.storeEvidenceFields;
  List<String> get blockedUntilRealEvidence => GaussStoreReadinessCameraOcrReleaseAuditPolicy.blockedUntilRealEvidence;
  List<String> get forbiddenActions => GaussStoreReadinessCameraOcrReleaseAuditPolicy.forbiddenActions;
}

class GaussStoreReadinessCameraOcrReleaseAudit {
  const GaussStoreReadinessCameraOcrReleaseAudit._();

  static GaussStoreReadinessCameraOcrReleaseAuditResult evaluate(GaussStoreReadinessCameraOcrReleaseAuditInput input) {
    GaussStoreReadinessCameraOcrReleaseAuditResult reject(
      GaussStoreReadinessCameraOcrReleaseAuditDecision decision,
      String reason,
    ) {
      return GaussStoreReadinessCameraOcrReleaseAuditResult._(
        decision: decision,
        storeReadinessAuditStaticReady: false,
        readyForFutureStoreReadinessEvidenceOnly: false,
        rejectionReasons: <String>[reason],
        canSubmitToPlayStoreInQ287: false,
        canBuildProductionAabInQ287: false,
        canClaimStoreReadyPassInQ287: false,
        canClaimReleasePassInQ287: false,
        canClaimOcrPassInQ287: false,
        canUseOcrAccuracyMarketingClaimsInQ287: false,
        auditLabel: input.auditLabel,
      );
    }

    if (!input.q286FullCameraOcrRuntimePremiumRegressionPresent || !input.q286FullCameraOcrRuntimePremiumRegressionStaticReady) {
      return reject(GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedMissingQ286FullRegressionCourt, 'missingQ286FullCameraOcrRuntimePremiumRegressionCourt');
    }
    final protectedSurfacesClean = input.keyboardLayoutProtected &&
        input.moreTemplateTrayProtected &&
        input.longPressListsProtected &&
        input.mathLiveProductionRouteProtected &&
        input.graphSurfaceProtected &&
        input.solutionSurfaceProtected &&
        input.historySurfaceProtected &&
        input.appShellWorkspaceProtected &&
        input.splashIconProtected &&
        input.androidManifestMainActivityProtected &&
        input.cameraDependenciesProtected &&
        input.androidToolchainProtected;
    if (!protectedSurfacesClean) {
      return reject(GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedProtectedSurfaceRegression, 'protectedSurfaceRegression');
    }
    if (!input.reviewBeforeImportStillMandatory || !input.explicitUserApprovalStillMandatory || !input.workspaceImportOnlyAfterApproval) {
      return reject(GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedUnsafeClaimsOrPolicyRisk, 'reviewApprovalStorePolicyRisk');
    }
    if (input.directWorkspaceMutationAttempted || input.autoEvaluateAttempted || input.autoSolveAttempted || input.autoGraphAttempted || input.autoSolutionAttempted || input.autoHistoryAttempted) {
      return reject(GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedAutomaticCameraSideEffectRisk, 'automaticCameraSideEffectRisk');
    }
    final runtimeOrPackagingMutation = input.playStoreSubmissionExecutedInQ287 ||
        input.releaseCandidateFreezeExecutedInQ287 ||
        input.productionAabBuiltInQ287 ||
        input.productionApkBuiltInQ287 ||
        input.paddleRuntimeAdded ||
        input.paddleOcrDependencyAdded ||
        input.runtimeDependencyAddedToPubspec ||
        input.gradleNativeRuntimeDependencyAdded ||
        input.nativeHandlerImplementationAdded ||
        input.jniBindingAdded ||
        input.methodChannelRuntimeBindingAdded ||
        input.modelBinaryBundledInBaseApp ||
        input.productionModelUrlBound ||
        input.productionDownloadEnabled ||
        input.realNetworkDownloadWorkerImplemented;
    if (runtimeOrPackagingMutation) {
      return reject(GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedRuntimeOrPackagingMutation, 'runtimeOrPackagingMutation');
    }
    final unsafeClaim = input.unsafeOcrAccuracyMarketingClaimed || input.photomathLevelClaimedWithoutEvidence;
    if (unsafeClaim) {
      return reject(GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedUnsafeClaimsOrPolicyRisk, 'unsafeStoreMarketingClaim');
    }
    final fakePassClaim = input.storeReadyPassClaimed ||
        input.releasePassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.premiumFinalPassClaimed;
    if (fakePassClaim) {
      return reject(GaussStoreReadinessCameraOcrReleaseAuditDecision.blockedFakeReleasePassClaim, 'fakeStoreReleaseOrOcrPassClaim');
    }

    return GaussStoreReadinessCameraOcrReleaseAuditResult._(
      decision: GaussStoreReadinessCameraOcrReleaseAuditDecision.readyForFutureStoreReadinessEvidenceOnly,
      storeReadinessAuditStaticReady: true,
      readyForFutureStoreReadinessEvidenceOnly: true,
      rejectionReasons: const <String>[],
      canSubmitToPlayStoreInQ287: false,
      canBuildProductionAabInQ287: false,
      canClaimStoreReadyPassInQ287: false,
      canClaimReleasePassInQ287: false,
      canClaimOcrPassInQ287: false,
      canUseOcrAccuracyMarketingClaimsInQ287: false,
      auditLabel: input.auditLabel,
    );
  }
}
