import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_candidate_editable_mathlive_review_ui_binding_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_candidate_editable_mathlive_review_ui_binding_gate_policy.dart';

void main() {
  test('q311-review-ui-binding-gate-is-static-default-off', () {
    final result = GaussOcrCandidateEditableMathLiveReviewUiBindingGate.evaluate(
      GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput.q311Default(),
    );

    expect(
      result.phase,
      GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.phase,
    );
    expect(
      result.sourcePhase,
      GaussOcrCandidateEditableMathLiveReviewUiBindingGatePolicy.sourcePhase,
    );
    expect(result.contractStaticReady, isTrue);
    expect(result.reviewUiBindingGateDefined, isTrue);
    expect(result.reviewUiBindingDefaultOff, isTrue);
    expect(result.q310ImageToLatexInferenceGatePresent, isTrue);
    expect(result.q310RealImageToLatexInferenceEvidencePresent, isFalse);
    expect(result.q310NativeLatexCandidateEnvelopePresent, isFalse);
    expect(result.editableMathLiveReviewSurfacePresent, isTrue);
    expect(result.mathLiveReviewDraftCreatedFromCandidate, isFalse);
    expect(result.realEditableMathLiveReviewOpened, isFalse);
    expect(result.reviewUiActuallyOpenedInsidePackage, isFalse);
    expect(result.realWorkspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.directSolveGraphSolutionHistoryBlocked, isTrue);
  });

  test('q311-must-not-accept-complete-review-binding-evidence-inside-static-package', () {
    final result = GaussOcrCandidateEditableMathLiveReviewUiBindingGate.evaluate(
      const GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput(
        q310ImageToLatexInferenceGatePresent: true,
        q310RealImageToLatexInferenceEvidencePresent: true,
        q310NativeLatexCandidateEnvelopePresent: true,
        candidateLatexSanitized: true,
        candidateAlternativesPreserved: true,
        candidateConfidenceRecorded: true,
        cropPreprocessMetadataPreserved: true,
        editableMathLiveReviewSurfacePresent: true,
        mathLiveReviewDraftCreatedFromCandidate: true,
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
        trialLabel: 'complete-review-binding-evidence-must-remain-external',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(
      result.rejectionReasons,
      contains('q311-must-not-accept-complete-review-binding-evidence-inside-static-package'),
    );
  });

  test('q311-blocks-review-ui-runtime-mutation-and-fake-pass-claims', () {
    final result = GaussOcrCandidateEditableMathLiveReviewUiBindingGate.evaluate(
      const GaussOcrCandidateEditableMathLiveReviewUiBindingGateInput(
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
        pubspecChanged: true,
        androidManifestChanged: false,
        mainActivityChanged: false,
        nativeRuntimeDependencyAdded: true,
        methodChannelRuntimeBoundInsidePackage: true,
        jniNativeHandlerImplementedInsidePackage: true,
        productionDownloadEnabled: false,
        modelBinaryBundledInBaseApp: false,
        realPrivateArtifactLoaded: false,
        realRuntimeStartupExecuted: true,
        realDummyInputRuntimeCallExecuted: true,
        cameraImageSentToRuntime: true,
        realImageToLatexInferenceExecuted: true,
        runtimeLatexResponseParsed: true,
        realEditableMathLiveReviewOpened: true,
        reviewUiActuallyOpenedInsidePackage: true,
        ocrCandidateAutoApproved: true,
        realWorkspaceImportExecuted: true,
        reviewBindingPassClaimed: true,
        runtimeIntegrationPassClaimed: true,
        ocrPassClaimed: true,
        cameraOcrRuntimePassClaimed: false,
        storeReadyPassClaimed: false,
        releasePassClaimed: false,
        trialLabel: 'forbidden-review-ui-runtime-mutation',
      ),
    );

    expect(result.contractStaticReady, isFalse);
    expect(
      result.rejectionReasons,
      contains('review-ui-binding-or-runtime-mutation-forbidden-in-q311'),
    );
    expect(result.rejectionReasons, contains('fake-pass-claim-forbidden'));
  });
}
