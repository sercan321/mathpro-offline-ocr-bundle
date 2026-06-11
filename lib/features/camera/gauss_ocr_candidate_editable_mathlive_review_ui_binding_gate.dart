import 'gauss_ocr_candidate_editable_mathlive_review_ui_binding_gate_policy.dart';

/// V172-Q311 — OCR Candidate → Editable MathLive Review UI Binding Gate.
///
/// Static package-side gate only. It defines the future conditions for showing
/// a verified OCR candidate in an editable MathLive review surface. It does not
/// open review UI, call MethodChannel, invoke native runtime, import workspace,
/// or run OCR in Q311.
enum GaussOcrCandidateEditableMathLiveReviewUiBindingGateDecision {
  reviewUiBindingGateDefinedDefaultOff,
  blockedMissingQ310InferenceEvidence,
  blockedProtectedSurfaceRegression,
  blockedReviewUiMutationAttempt,
  blockedFakePassClaim,
}

class GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput {
  const GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput({
    required this.q310ImageToLatexInferenceGatePresent,
    required this.q310RealImageToLatexInferenceEvidencePresent,
    required this.q310NativeLatexCandidateEnvelopePresent,
    required this.candidateLatexSanitized,
    required this.candidateAlternativesPreserved,
    required this.candidateConfidenceRecorded,
    required this.cropPreprocessMetadataPreserved,
    required this.editableMathLiveReviewSurfacePresent,
    required this.mathLiveReviewDraftCreatedFromCandidate,
    required this.userEditCapabilityRequired,
    required this.explicitUserApprovalRequired,
    required this.defaultOffFeatureFlagPresent,
    required this.realAndroidDeviceReviewUiLogRequired,
    required this.reviewUiTimeoutPolicyPresent,
    required this.reviewUiRollbackPolicyPresent,
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
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.nativeRuntimeDependencyAdded,
    required this.methodChannelRuntimeBoundInsidePackage,
    required this.jniNativeHandlerImplementedInsidePackage,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.cameraImageSentToRuntime,
    required this.realImageToLatexInferenceExecuted,
    required this.runtimeLatexResponseParsed,
    required this.realEditableMathLiveReviewOpened,
    required this.reviewUiActuallyOpenedInsidePackage,
    required this.ocrCandidateAutoApproved,
    required this.realWorkspaceImportExecuted,
    required this.reviewBindingPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.trialLabel,
  });

  factory GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput.q311Default({
    String trialLabel = 'q311-ocr-candidate-editable-mathlive-review-ui-binding-gate',
  }) {
    return GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput(
      q310ImageToLatexInferenceGatePresent: true,
      q310RealImageToLatexInferenceEvidencePresent: false,
      q310NativeLatexCandidateEnvelopePresent: false,
      candidateLatexSanitized: true,
      candidateAlternativesPreserved: true,
      candidateConfidenceRecorded: true,
      cropPreprocessMetadataPreserved: true,
      editableMathLiveReviewSurfacePresent: true,
      mathLiveReviewDraftCreatedFromCandidate: false,
      userEditCapabilityRequired: true,
      explicitUserApprovalRequired: true,
      defaultOffFeatureFlagPresent: true,
      realAndroidDeviceReviewUiLogRequired: true,
      reviewUiTimeoutPolicyPresent: true,
      reviewUiRollbackPolicyPresent: true,
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
      pubspecChanged: false,
      androidManifestChanged: false,
      mainActivityChanged: false,
      nativeRuntimeDependencyAdded: false,
      methodChannelRuntimeBoundInsidePackage: false,
      jniNativeHandlerImplementedInsidePackage: false,
      productionDownloadEnabled: false,
      modelBinaryBundledInBaseApp: false,
      realPrivateArtifactLoaded: false,
      realRuntimeStartupExecuted: false,
      realDummyInputRuntimeCallExecuted: false,
      cameraImageSentToRuntime: false,
      realImageToLatexInferenceExecuted: false,
      runtimeLatexResponseParsed: false,
      realEditableMathLiveReviewOpened: false,
      reviewUiActuallyOpenedInsidePackage: false,
      ocrCandidateAutoApproved: false,
      realWorkspaceImportExecuted: false,
      reviewBindingPassClaimed: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      storeReadyPassClaimed: false,
      releasePassClaimed: false,
      trialLabel: trialLabel,
    );
  }

  final bool q310ImageToLatexInferenceGatePresent;
  final bool q310RealImageToLatexInferenceEvidencePresent;
  final bool q310NativeLatexCandidateEnvelopePresent;
  final bool candidateLatexSanitized;
  final bool candidateAlternativesPreserved;
  final bool candidateConfidenceRecorded;
  final bool cropPreprocessMetadataPreserved;
  final bool editableMathLiveReviewSurfacePresent;
  final bool mathLiveReviewDraftCreatedFromCandidate;
  final bool userEditCapabilityRequired;
  final bool explicitUserApprovalRequired;
  final bool defaultOffFeatureFlagPresent;
  final bool realAndroidDeviceReviewUiLogRequired;
  final bool reviewUiTimeoutPolicyPresent;
  final bool reviewUiRollbackPolicyPresent;
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
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool nativeRuntimeDependencyAdded;
  final bool methodChannelRuntimeBoundInsidePackage;
  final bool jniNativeHandlerImplementedInsidePackage;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool cameraImageSentToRuntime;
  final bool realImageToLatexInferenceExecuted;
  final bool runtimeLatexResponseParsed;
  final bool realEditableMathLiveReviewOpened;
  final bool reviewUiActuallyOpenedInsidePackage;
  final bool ocrCandidateAutoApproved;
  final bool realWorkspaceImportExecuted;
  final bool reviewBindingPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final String trialLabel;
}

class GaussOcrCandidateEditableMathLiveReviewUiBindingGateResult {
  const GaussOcrCandidateEditableMathLiveReviewUiBindingGateResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.reviewUiBindingFeatureFlag,
    required this.reviewUiBindingMode,
    required this.readinessState,
    required this.decision,
    required this.contractStaticReady,
    required this.rejectionReasons,
    required this.requiredBeforeReviewUiBinding,
    required this.reviewDraftEnvelopeFields,
    required this.reviewStates,
    required this.errorCodes,
    required this.protectedSurfaceMarkers,
    required this.forbiddenActions,
    required this.reviewUiBindingGateDefined,
    required this.reviewUiBindingDefaultOff,
    required this.q310ImageToLatexInferenceGatePresent,
    required this.q310RealImageToLatexInferenceEvidencePresent,
    required this.q310NativeLatexCandidateEnvelopePresent,
    required this.candidateLatexSanitized,
    required this.candidateAlternativesPreserved,
    required this.candidateConfidenceRecorded,
    required this.cropPreprocessMetadataPreserved,
    required this.editableMathLiveReviewSurfacePresent,
    required this.mathLiveReviewDraftCreatedFromCandidate,
    required this.userEditCapabilityRequired,
    required this.explicitUserApprovalRequired,
    required this.realAndroidDeviceReviewUiLogRequired,
    required this.reviewUiTimeoutPolicyPresent,
    required this.reviewUiRollbackPolicyPresent,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.nativeRuntimeDependencyAdded,
    required this.methodChannelRuntimeBoundInsidePackage,
    required this.jniNativeHandlerImplementedInsidePackage,
    required this.productionDownloadEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.realPrivateArtifactLoaded,
    required this.realRuntimeStartupExecuted,
    required this.realDummyInputRuntimeCallExecuted,
    required this.cameraImageSentToRuntime,
    required this.realImageToLatexInferenceExecuted,
    required this.runtimeLatexResponseParsed,
    required this.realEditableMathLiveReviewOpened,
    required this.reviewUiActuallyOpenedInsidePackage,
    required this.ocrCandidateAutoApproved,
    required this.realWorkspaceImportExecuted,
    required this.reviewBeforeImportRequired,
    required this.directWorkspaceImportBlocked,
    required this.directSolveGraphSolutionHistoryBlocked,
    required this.reviewBindingPassClaimed,
    required this.runtimeIntegrationPassClaimed,
    required this.ocrPassClaimed,
    required this.cameraOcrRuntimePassClaimed,
    required this.storeReadyPassClaimed,
    required this.releasePassClaimed,
    required this.changesRuntimeBehavior,
    required this.keyboardLayoutChanged,
    required this.moreTemplateTrayChanged,
    required this.longPressListsChanged,
    required this.graphSolutionHistoryChanged,
    required this.mathLiveProductionRouteChanged,
    required this.mathLiveBridgeChanged,
    required this.cameraShellRuntimeChanged,
    required this.workspaceRuntimeChanged,
    required this.solverEvaluatorChanged,
    required this.splashIconChanged,
    required this.cameraDependencyChanged,
    required this.androidToolchainChanged,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String reviewUiBindingFeatureFlag;
  final String reviewUiBindingMode;
  final String readinessState;
  final GaussOcrCandidateEditableMathLiveReviewUiBindingGateDecision decision;
  final bool contractStaticReady;
  final List<String> rejectionReasons;
  final List<String> requiredBeforeReviewUiBinding;
  final List<String> reviewDraftEnvelopeFields;
  final List<String> reviewStates;
  final List<String> errorCodes;
  final List<String> protectedSurfaceMarkers;
  final List<String> forbiddenActions;
  final bool reviewUiBindingGateDefined;
  final bool reviewUiBindingDefaultOff;
  final bool q310ImageToLatexInferenceGatePresent;
  final bool q310RealImageToLatexInferenceEvidencePresent;
  final bool q310NativeLatexCandidateEnvelopePresent;
  final bool candidateLatexSanitized;
  final bool candidateAlternativesPreserved;
  final bool candidateConfidenceRecorded;
  final bool cropPreprocessMetadataPreserved;
  final bool editableMathLiveReviewSurfacePresent;
  final bool mathLiveReviewDraftCreatedFromCandidate;
  final bool userEditCapabilityRequired;
  final bool explicitUserApprovalRequired;
  final bool realAndroidDeviceReviewUiLogRequired;
  final bool reviewUiTimeoutPolicyPresent;
  final bool reviewUiRollbackPolicyPresent;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool nativeRuntimeDependencyAdded;
  final bool methodChannelRuntimeBoundInsidePackage;
  final bool jniNativeHandlerImplementedInsidePackage;
  final bool productionDownloadEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool realPrivateArtifactLoaded;
  final bool realRuntimeStartupExecuted;
  final bool realDummyInputRuntimeCallExecuted;
  final bool cameraImageSentToRuntime;
  final bool realImageToLatexInferenceExecuted;
  final bool runtimeLatexResponseParsed;
  final bool realEditableMathLiveReviewOpened;
  final bool reviewUiActuallyOpenedInsidePackage;
  final bool ocrCandidateAutoApproved;
  final bool realWorkspaceImportExecuted;
  final bool reviewBeforeImportRequired;
  final bool directWorkspaceImportBlocked;
  final bool directSolveGraphSolutionHistoryBlocked;
  final bool reviewBindingPassClaimed;
  final bool runtimeIntegrationPassClaimed;
  final bool ocrPassClaimed;
  final bool cameraOcrRuntimePassClaimed;
  final bool storeReadyPassClaimed;
  final bool releasePassClaimed;
  final bool changesRuntimeBehavior;
  final bool keyboardLayoutChanged;
  final bool moreTemplateTrayChanged;
  final bool longPressListsChanged;
  final bool graphSolutionHistoryChanged;
  final bool mathLiveProductionRouteChanged;
  final bool mathLiveBridgeChanged;
  final bool cameraShellRuntimeChanged;
  final bool workspaceRuntimeChanged;
  final bool solverEvaluatorChanged;
  final bool splashIconChanged;
  final bool cameraDependencyChanged;
  final bool androidToolchainChanged;
}

class GaussOcrCandidateEditableMathLiveReviewUiBindingGate {
  const GaussOcrCandidateEditableMathLiveReviewUiBindingGate._();

  static GaussOcrCandidateEditableMathLiveReviewUiBindingGateResult evaluate(
    GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput input,
  ) {
    final rejectionReasons = <String>[];

    if (!input.q310ImageToLatexInferenceGatePresent ||
        input.q310RealImageToLatexInferenceEvidencePresent ||
        input.q310NativeLatexCandidateEnvelopePresent ||
        input.mathLiveReviewDraftCreatedFromCandidate) {
      rejectionReasons.add(
        'q311-must-not-accept-complete-review-binding-evidence-inside-static-package',
      );
    }

    if (!input.candidateLatexSanitized ||
        !input.candidateAlternativesPreserved ||
        !input.candidateConfidenceRecorded ||
        !input.cropPreprocessMetadataPreserved ||
        !input.editableMathLiveReviewSurfacePresent ||
        !input.userEditCapabilityRequired ||
        !input.explicitUserApprovalRequired ||
        !input.defaultOffFeatureFlagPresent ||
        !input.realAndroidDeviceReviewUiLogRequired ||
        !input.reviewUiTimeoutPolicyPresent ||
        !input.reviewUiRollbackPolicyPresent) {
      rejectionReasons.add('q311-static-review-ui-binding-requirement-missing');
    }

    if (!input.keyboardLayoutProtected ||
        !input.moreTemplateTrayProtected ||
        !input.longPressListsProtected ||
        !input.mathLiveProductionRouteProtected ||
        !input.mathLiveBridgeProtected ||
        !input.graphSolutionHistoryProtected ||
        !input.appShellWorkspaceProtected ||
        !input.androidManifestMainActivityProtected ||
        !input.cameraShellRuntimeProtected ||
        !input.splashIconProtected) {
      rejectionReasons.add('protected-surface-regression-forbidden');
    }

    if (input.pubspecChanged ||
        input.androidManifestChanged ||
        input.mainActivityChanged ||
        input.nativeRuntimeDependencyAdded ||
        input.methodChannelRuntimeBoundInsidePackage ||
        input.jniNativeHandlerImplementedInsidePackage ||
        input.realPrivateArtifactLoaded ||
        input.realRuntimeStartupExecuted ||
        input.realDummyInputRuntimeCallExecuted ||
        input.cameraImageSentToRuntime ||
        input.realImageToLatexInferenceExecuted ||
        input.runtimeLatexResponseParsed ||
        input.realEditableMathLiveReviewOpened ||
        input.reviewUiActuallyOpenedInsidePackage ||
        input.ocrCandidateAutoApproved ||
        input.realWorkspaceImportExecuted) {
      rejectionReasons.add('review-ui-binding-or-runtime-mutation-forbidden-in-q311');
    }

    if (input.productionDownloadEnabled || input.modelBinaryBundledInBaseApp) {
      rejectionReasons.add('model-download-or-binary-bundling-forbidden-in-q311');
    }

    if (input.reviewBindingPassClaimed ||
        input.runtimeIntegrationPassClaimed ||
        input.ocrPassClaimed ||
        input.cameraOcrRuntimePassClaimed ||
        input.storeReadyPassClaimed ||
        input.releasePassClaimed) {
      rejectionReasons.add('fake-pass-claim-forbidden');
    }

    final decision = rejectionReasons.isEmpty
        ? GaussOcrCandidateEditableMathLiveReviewUiBindingGateDecision
            .reviewUiBindingGateDefinedDefaultOff
        : rejectionReasons.contains('fake-pass-claim-forbidden')
            ? GaussOcrCandidateEditableMathLiveReviewUiBindingGateDecision
                .blockedFakePassClaim
            : rejectionReasons.contains(
                    'review-ui-binding-or-runtime-mutation-forbidden-in-q311')
                ? GaussOcrCandidateEditableMathLiveReviewUiBindingGateDecision
                    .blockedReviewUiMutationAttempt
                : rejectionReasons.contains('protected-surface-regression-forbidden')
                    ? GaussOcrCandidateEditableMathLiveReviewUiBindingGateDecision
                        .blockedProtectedSurfaceRegression
                    : GaussOcrCandidateEditableMathLiveReviewUiBindingGateDecision
                        .blockedMissingQ310InferenceEvidence;

    return GaussOcrCandidateEditableMathLiveReviewUiBindingGateResult(
      phase: GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.phase,
      sourcePhase:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.sourcePhase,
      selectedEngineLabel:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.selectedEngineLabel,
      reviewUiBindingFeatureFlag:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.reviewUiBindingFeatureFlag,
      reviewUiBindingMode:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.reviewUiBindingMode,
      readinessState:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.readinessState,
      decision: decision,
      contractStaticReady: rejectionReasons.isEmpty,
      rejectionReasons: List<String>.unmodifiable(rejectionReasons),
      requiredBeforeReviewUiBinding:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy
              .requiredBeforeReviewUiBinding,
      reviewDraftEnvelopeFields:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy
              .reviewDraftEnvelopeFields,
      reviewStates:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.reviewStates,
      errorCodes:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.errorCodes,
      protectedSurfaceMarkers:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy
              .protectedSurfaceMarkers,
      forbiddenActions:
          GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.forbiddenActions,
      reviewUiBindingGateDefined: true,
      reviewUiBindingDefaultOff: input.defaultOffFeatureFlagPresent,
      q310ImageToLatexInferenceGatePresent: input.q310ImageToLatexInferenceGatePresent,
      q310RealImageToLatexInferenceEvidencePresent:
          input.q310RealImageToLatexInferenceEvidencePresent,
      q310NativeLatexCandidateEnvelopePresent:
          input.q310NativeLatexCandidateEnvelopePresent,
      candidateLatexSanitized: input.candidateLatexSanitized,
      candidateAlternativesPreserved: input.candidateAlternativesPreserved,
      candidateConfidenceRecorded: input.candidateConfidenceRecorded,
      cropPreprocessMetadataPreserved: input.cropPreprocessMetadataPreserved,
      editableMathLiveReviewSurfacePresent:
          input.editableMathLiveReviewSurfacePresent,
      mathLiveReviewDraftCreatedFromCandidate:
          input.mathLiveReviewDraftCreatedFromCandidate,
      userEditCapabilityRequired: input.userEditCapabilityRequired,
      explicitUserApprovalRequired: input.explicitUserApprovalRequired,
      realAndroidDeviceReviewUiLogRequired: input.realAndroidDeviceReviewUiLogRequired,
      reviewUiTimeoutPolicyPresent: input.reviewUiTimeoutPolicyPresent,
      reviewUiRollbackPolicyPresent: input.reviewUiRollbackPolicyPresent,
      pubspecChanged: input.pubspecChanged,
      androidManifestChanged: input.androidManifestChanged,
      mainActivityChanged: input.mainActivityChanged,
      nativeRuntimeDependencyAdded: input.nativeRuntimeDependencyAdded,
      methodChannelRuntimeBoundInsidePackage:
          input.methodChannelRuntimeBoundInsidePackage,
      jniNativeHandlerImplementedInsidePackage:
          input.jniNativeHandlerImplementedInsidePackage,
      productionDownloadEnabled: input.productionDownloadEnabled,
      modelBinaryBundledInBaseApp: input.modelBinaryBundledInBaseApp,
      realPrivateArtifactLoaded: input.realPrivateArtifactLoaded,
      realRuntimeStartupExecuted: input.realRuntimeStartupExecuted,
      realDummyInputRuntimeCallExecuted: input.realDummyInputRuntimeCallExecuted,
      cameraImageSentToRuntime: input.cameraImageSentToRuntime,
      realImageToLatexInferenceExecuted: input.realImageToLatexInferenceExecuted,
      runtimeLatexResponseParsed: input.runtimeLatexResponseParsed,
      realEditableMathLiveReviewOpened: input.realEditableMathLiveReviewOpened,
      reviewUiActuallyOpenedInsidePackage: input.reviewUiActuallyOpenedInsidePackage,
      ocrCandidateAutoApproved: input.ocrCandidateAutoApproved,
      realWorkspaceImportExecuted: input.realWorkspaceImportExecuted,
      reviewBeforeImportRequired: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      reviewBindingPassClaimed: input.reviewBindingPassClaimed,
      runtimeIntegrationPassClaimed: input.runtimeIntegrationPassClaimed,
      ocrPassClaimed: input.ocrPassClaimed,
      cameraOcrRuntimePassClaimed: input.cameraOcrRuntimePassClaimed,
      storeReadyPassClaimed: input.storeReadyPassClaimed,
      releasePassClaimed: input.releasePassClaimed,
      changesRuntimeBehavior: false,
      keyboardLayoutChanged: false,
      moreTemplateTrayChanged: false,
      longPressListsChanged: false,
      graphSolutionHistoryChanged: false,
      mathLiveProductionRouteChanged: false,
      mathLiveBridgeChanged: false,
      cameraShellRuntimeChanged: false,
      workspaceRuntimeChanged: false,
      solverEvaluatorChanged: false,
      splashIconChanged: false,
      cameraDependencyChanged: false,
      androidToolchainChanged: false,
    );
  }
}
