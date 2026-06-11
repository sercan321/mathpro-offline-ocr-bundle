import 'gauss_product_development_track_rebase_store_track_park_policy.dart';
import 'gauss_release_candidate_freeze.dart';

/// V172-Q301 — Product Development Track Rebase / Store Track Park.
///
/// Contract-only phase that parks Play Store/release work and returns the active
/// direction to real product quality plus the PP-FormulaNet-S OCR runtime path.
enum GaussProductDevelopmentTrackRebaseStoreTrackParkDecision {
  productDevelopmentTrackRebasedStoreTrackParked,
  blockedMissingQ300FreezeContract,
  blockedStoreWorkStillActive,
  blockedProtectedSurfaceRegression,
  blockedRuntimeMutationAttempt,
  blockedFakePassClaim,
}

class GaussProductDevelopmentTrackRebaseStoreTrackParkInput {
  const GaussProductDevelopmentTrackRebaseStoreTrackParkInput({
    required this.q300ReleaseCandidateFreezePresent,
    required this.q300ReleaseCandidateFreezeStaticReady,
    required this.storeTrackParked,
    required this.playStorePreparationParked,
    required this.releaseCandidateFreezePreservedAsHistoricalAuditOnly,
    required this.productDevelopmentTrackActive,
    required this.realOcrRuntimeTrackActive,
    required this.premiumUiUxTrackActive,
    required this.deviceQaTrackActive,
    required this.keyboardLayoutProtected,
    required this.moreTemplateTrayProtected,
    required this.longPressListsProtected,
    required this.mathLiveProductionRouteProtected,
    required this.mathLiveBridgeProtected,
    required this.graphSolutionHistoryProtected,
    required this.appShellWorkspaceProtected,
    required this.androidManifestMainActivityProtected,
    required this.cameraShellRuntimeProtected,
    required this.splashIconProtected,
    required this.storeSubmissionPerformed,
    required this.playConsoleConfigured,
    required this.privacyPolicyWritten,
    required this.dataSafetyFormCompleted,
    required this.releaseAabCreated,
    required this.releaseApkCreated,
    required this.productionReleaseCreated,
    required this.storeListingAssetsCreated,
    required this.localizedStoreListingsCreated,
    required this.paddleRuntimeAdded,
    required this.paddleOcrDependencyAdded,
    required this.jniBindingAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeHandlerImplemented,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.realImageToLatexInferenceExecuted,
    required this.realWorkspaceImportExecuted,
    required this.autoEvaluateEnabled,
    required this.autoSolveGraphSolutionHistoryEnabled,
    required this.flutterAnalyzePassClaimed,
    required this.flutterTestPassClaimed,
    required this.flutterRunPassClaimed,
    required this.androidRealDevicePassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.premiumFinalPassClaimed,
    required this.rebaseLabel,
  });

  factory GaussProductDevelopmentTrackRebaseStoreTrackParkInput.fromQ300Freeze({
    required GaussReleaseCandidateFreezeResult q300Result,
    String rebaseLabel = 'q301-product-development-track-rebase',
  }) {
    return GaussProductDevelopmentTrackRebaseStoreTrackParkInput(
      q300ReleaseCandidateFreezePresent: true,
      q300ReleaseCandidateFreezeStaticReady: q300Result.freezeContractStaticReady,
      storeTrackParked: true,
      playStorePreparationParked: true,
      releaseCandidateFreezePreservedAsHistoricalAuditOnly: true,
      productDevelopmentTrackActive: true,
      realOcrRuntimeTrackActive: true,
      premiumUiUxTrackActive: true,
      deviceQaTrackActive: true,
      keyboardLayoutProtected: true,
      moreTemplateTrayProtected: true,
      longPressListsProtected: true,
      mathLiveProductionRouteProtected: true,
      mathLiveBridgeProtected: true,
      graphSolutionHistoryProtected: true,
      appShellWorkspaceProtected: true,
      androidManifestMainActivityProtected: true,
      cameraShellRuntimeProtected: true,
      splashIconProtected: true,
      storeSubmissionPerformed: q300Result.storeSubmissionPerformed,
      playConsoleConfigured: q300Result.playConsoleConfigured,
      privacyPolicyWritten: false,
      dataSafetyFormCompleted: false,
      releaseAabCreated: q300Result.releaseAabCreated,
      releaseApkCreated: q300Result.releaseApkCreated,
      productionReleaseCreated: q300Result.productionReleaseCreated,
      storeListingAssetsCreated: false,
      localizedStoreListingsCreated: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: q300Result.methodChannelRuntimeBindingAdded,
      nativeRuntimeHandlerImplemented: false,
      modelBinaryBundledInBaseApp: q300Result.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: q300Result.productionDownloadEnabled,
      realImageToLatexInferenceExecuted: false,
      realWorkspaceImportExecuted: false,
      autoEvaluateEnabled: false,
      autoSolveGraphSolutionHistoryEnabled: false,
      flutterAnalyzePassClaimed: false,
      flutterTestPassClaimed: false,
      flutterRunPassClaimed: false,
      androidRealDevicePassClaimed: false,
      ocrPassClaimed: q300Result.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: q300Result.cameraOcrRuntimePassClaimed,
      storeReadyPassClaimed: q300Result.storeReadyPassClaimed,
      releasePassClaimed: q300Result.releasePassClaimed,
      premiumFinalPassClaimed: false,
      rebaseLabel: rebaseLabel,
    );
  }

  final bool q300ReleaseCandidateFreezePresent;
  final bool q300ReleaseCandidateFreezeStaticReady;
  final bool storeTrackParked;
  final bool playStorePreparationParked;
  final bool releaseCandidateFreezePreservedAsHistoricalAuditOnly;
  final bool productDevelopmentTrackActive;
  final bool realOcrRuntimeTrackActive;
  final bool premiumUiUxTrackActive;
  final bool deviceQaTrackActive;
  final bool keyboardLayoutProtected;
  final bool moreTemplateTrayProtected;
  final bool longPressListsProtected;
  final bool mathLiveProductionRouteProtected;
  final bool mathLiveBridgeProtected;
  final bool graphSolutionHistoryProtected;
  final bool appShellWorkspaceProtected;
  final bool androidManifestMainActivityProtected;
  final bool cameraShellRuntimeProtected;
  final bool splashIconProtected;
  final bool storeSubmissionPerformed;
  final bool playConsoleConfigured;
  final bool privacyPolicyWritten;
  final bool dataSafetyFormCompleted;
  final bool releaseAabCreated;
  final bool releaseApkCreated;
  final bool productionReleaseCreated;
  final bool storeListingAssetsCreated;
  final bool localizedStoreListingsCreated;
  final bool paddleRuntimeAdded;
  final bool paddleOcrDependencyAdded;
  final bool jniBindingAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeHandlerImplemented;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool realImageToLatexInferenceExecuted;
  final bool realWorkspaceImportExecuted;
  final bool autoEvaluateEnabled;
  final bool autoSolveGraphSolutionHistoryEnabled;
  final bool flutterAnalyzePassClaimed;
  final bool flutterTestPassClaimed;
  final bool flutterRunPassClaimed;
  final bool androidRealDevicePassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool premiumFinalPassClaimed;
  final String rebaseLabel;
}

class GaussProductDevelopmentTrackRebaseStoreTrackParkResult {
  const GaussProductDevelopmentTrackRebaseStoreTrackParkResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.developmentTrackFeatureFlag,
    required this.activeDevelopmentTrack,
    required this.readinessState,
    required this.contractStaticReady,
    required this.decision,
    required this.rejectionReasons,
    required this.parkedStoreTopics,
    required this.activeProductTracks,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.storeTrackParked,
    required this.playStorePreparationParked,
    required this.productDevelopmentTrackActive,
    required this.realOcrRuntimeTrackActive,
    required this.storeSubmissionPerformed,
    required this.playConsoleConfigured,
    required this.releaseAabCreated,
    required this.releaseApkCreated,
    required this.productionReleaseCreated,
    required this.paddleRuntimeAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.nativeRuntimeHandlerImplemented,
    required this.productionDownloadEnabled,
    required this.realImageToLatexInferenceExecuted,
    required this.realWorkspaceImportExecuted,
    required this.ocrPassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.rebaseLabel,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String developmentTrackFeatureFlag;
  final String activeDevelopmentTrack;
  final String readinessState;
  final bool contractStaticReady;
  final GaussProductDevelopmentTrackRebaseStoreTrackParkDecision decision;
  final List<String> rejectionReasons;
  final List<String> parkedStoreTopics;
  final List<String> activeProductTracks;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool storeTrackParked;
  final bool playStorePreparationParked;
  final bool productDevelopmentTrackActive;
  final bool realOcrRuntimeTrackActive;
  final bool storeSubmissionPerformed;
  final bool playConsoleConfigured;
  final bool releaseAabCreated;
  final bool releaseApkCreated;
  final bool productionReleaseCreated;
  final bool paddleRuntimeAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool nativeRuntimeHandlerImplemented;
  final bool productionDownloadEnabled;
  final bool realImageToLatexInferenceExecuted;
  final bool realWorkspaceImportExecuted;
  final bool ocrPassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String rebaseLabel;

  bool get canStartPlayStorePreparationInQ301 => false;
  bool get canBuildReleaseAabInQ301 => false;
  bool get canAddRuntimeDependencyInQ301 => false;
  bool get canBindNativeRuntimeInQ301 => false;
  bool get canRunImageToLatexInferenceInQ301 => false;
  bool get canAutoSolveCameraOutputInQ301 => false;
}

class GaussProductDevelopmentTrackRebaseStoreTrackPark {
  const GaussProductDevelopmentTrackRebaseStoreTrackPark._();

  static GaussProductDevelopmentTrackRebaseStoreTrackParkResult evaluate(
    GaussProductDevelopmentTrackRebaseStoreTrackParkInput input,
  ) {
    final rejections = <String>[];

    if (!input.q300ReleaseCandidateFreezePresent || !input.q300ReleaseCandidateFreezeStaticReady) {
      rejections.add('missingQ300ReleaseCandidateFreezeContract');
    }
    if (!input.storeTrackParked || !input.playStorePreparationParked || !input.releaseCandidateFreezePreservedAsHistoricalAuditOnly || !input.productDevelopmentTrackActive || !input.realOcrRuntimeTrackActive || !input.premiumUiUxTrackActive || !input.deviceQaTrackActive) {
      rejections.add('storeTrackNotParkedOrProductTrackInactive');
    }
    if (!input.keyboardLayoutProtected || !input.moreTemplateTrayProtected || !input.longPressListsProtected || !input.mathLiveProductionRouteProtected || !input.mathLiveBridgeProtected || !input.graphSolutionHistoryProtected || !input.appShellWorkspaceProtected || !input.androidManifestMainActivityProtected || !input.cameraShellRuntimeProtected || !input.splashIconProtected) {
      rejections.add('protectedSurfaceRegression');
    }
    if (input.storeSubmissionPerformed || input.playConsoleConfigured || input.privacyPolicyWritten || input.dataSafetyFormCompleted || input.releaseAabCreated || input.releaseApkCreated || input.productionReleaseCreated || input.storeListingAssetsCreated || input.localizedStoreListingsCreated) {
      rejections.add('storeWorkStillActive');
    }
    if (input.paddleRuntimeAdded || input.paddleOcrDependencyAdded || input.jniBindingAdded || input.methodChannelRuntimeBindingAdded || input.nativeRuntimeHandlerImplemented || input.modelBinaryBundledInBaseApp || input.productionDownloadEnabled || input.realImageToLatexInferenceExecuted || input.realWorkspaceImportExecuted || input.autoEvaluateEnabled || input.autoSolveGraphSolutionHistoryEnabled) {
      rejections.add('runtimeMutationAttempted');
    }
    if (input.flutterAnalyzePassClaimed || input.flutterTestPassClaimed || input.flutterRunPassClaimed || input.androidRealDevicePassClaimed || input.ocrPassClaimed || input.cameraOcrRuntimePassClaimed || input.storeReadyPassClaimed || input.releasePassClaimed || input.premiumFinalPassClaimed) {
      rejections.add('fakePassClaim');
    }

    final decision = rejections.contains('missingQ300ReleaseCandidateFreezeContract')
        ? GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.blockedMissingQ300FreezeContract
        : rejections.contains('storeWorkStillActive') || rejections.contains('storeTrackNotParkedOrProductTrackInactive')
            ? GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.blockedStoreWorkStillActive
            : rejections.contains('protectedSurfaceRegression')
                ? GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.blockedProtectedSurfaceRegression
                : rejections.contains('runtimeMutationAttempted')
                    ? GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.blockedRuntimeMutationAttempt
                    : rejections.contains('fakePassClaim')
                        ? GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.blockedFakePassClaim
                        : GaussProductDevelopmentTrackRebaseStoreTrackParkDecision.productDevelopmentTrackRebasedStoreTrackParked;

    final staticReady = rejections.isEmpty;
    return GaussProductDevelopmentTrackRebaseStoreTrackParkResult(
      phase: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.phase,
      sourcePhase: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.sourcePhase,
      selectedEngineLabel: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.selectedEngineLabel,
      developmentTrackFeatureFlag: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.developmentTrackFeatureFlag,
      activeDevelopmentTrack: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.activeDevelopmentTrack,
      readinessState: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.readinessState,
      contractStaticReady: staticReady,
      decision: decision,
      rejectionReasons: rejections,
      parkedStoreTopics: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.parkedStoreTopics,
      activeProductTracks: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.activeProductTracks,
      protectedSurfaceMarkers: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.protectedSurfaceMarkers,
      forbiddenActions: GaussProductDevelopmentTrackRebaseStoreTrackParkPolicy.forbiddenActions,
      storeTrackParked: input.storeTrackParked,
      playStorePreparationParked: input.playStorePreparationParked,
      productDevelopmentTrackActive: input.productDevelopmentTrackActive,
      realOcrRuntimeTrackActive: input.realOcrRuntimeTrackActive,
      storeSubmissionPerformed: input.storeSubmissionPerformed,
      playConsoleConfigured: input.playConsoleConfigured,
      releaseAabCreated: input.releaseAabCreated,
      releaseApkCreated: input.releaseApkCreated,
      productionReleaseCreated: input.productionReleaseCreated,
      paddleRuntimeAdded: input.paddleRuntimeAdded,
      methodChannelRuntimeBindingAdded: input.methodChannelRuntimeBindingAdded,
      nativeRuntimeHandlerImplemented: input.nativeRuntimeHandlerImplemented,
      productionDownloadEnabled: input.productionDownloadEnabled,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      ocrPassClaimed: input.ocrPassClaimed,
      storeReadyPassClaimed: input.storeReadyPassClaimed,
      releasePassClaimed: input.releasePassClaimed,
      rebaseLabel: input.rebaseLabel,
    );
  }
}
