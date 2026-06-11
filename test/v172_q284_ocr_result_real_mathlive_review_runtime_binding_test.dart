import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding_policy.dart';

void main() {
  group('V172-Q284 OCR result real MathLive review runtime binding', () {
    const readyInput = GaussOcrResultRealMathLiveReviewRuntimeBindingInput(
      q283FirstRealImageToLatexInferenceCourtPresent: true,
      acceptedQ283ImageToLatexCandidateEvidence: true,
      q282FirstRealRuntimeSmokeOnDevicePresent: true,
      q281PrivateArtifactLoadSmokePresent: true,
      q280NativeRuntimeBridgePresent: true,
      q279DependencyTrialPresent: true,
      q278EvidenceLockPresent: true,
      runtimeCandidateEnvelopeAccepted: true,
      primaryLatexCandidatePreserved: true,
      alternativeCandidatesPreserved: true,
      confidenceWarningsEngineMetadataPreserved: true,
      imageInputMetadataPreserved: true,
      editableLatexDraftRequired: true,
      editableMathLiveReviewRequired: true,
      reviewDraftMayBeEditedBeforeImport: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      workspaceImportPreparedOnlyAfterUserApproval: true,
      directWorkspaceImportBlocked: true,
      directSolveGraphSolutionHistoryBlocked: true,
      noRealMathLiveReviewRuntimeBindingExecutedInQ284: true,
      noRealImageToLatexInferenceExecutedInQ284: true,
      noRealRuntimeInvocationExecutedInQ284: true,
      noNativeRuntimeBridgeInvokedInQ284: true,
      noPaddleRuntimeAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeHandlerImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noRuntimeDependencyAddedToPubspec: true,
      noGradleNativeRuntimeDependencyAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noProductionDownloadEnabled: true,
      noRealNetworkDownloadWorkerImplemented: true,
      reviewBindingPassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      bindingLabel: 'q284-static-review-runtime-binding-court',
    );

    test('keeps review binding as static court only and prepares Q285 boundary', () {
      final result = GaussOcrResultRealMathLiveReviewRuntimeBinding.evaluate(readyInput);

      expect(result.phase, GaussOcrResultRealMathLiveReviewRuntimeBindingPolicy.phase);
      expect(result.sourcePhase, 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.reviewRuntimeBindingStaticReady, isTrue);
      expect(result.readyForQ285ApprovedWorkspaceImportRuntimeCourtOnly, isTrue);
      expect(result.decision, GaussOcrResultRealMathLiveReviewRuntimeBindingDecision.readyForQ285ApprovedWorkspaceImportRuntimeCourtOnly);
      expect(result.canOpenEditableMathLiveReviewInQ284, isTrue);
      expect(result.canImportWorkspaceWithoutUserApproval, isFalse);
      expect(result.canEvaluate, isFalse);
      expect(result.canGraph, isFalse);
      expect(result.canWriteSolutionOrHistory, isFalse);
      expect(result.canClaimReviewBindingPassInQ284, isFalse);
      expect(result.canClaimOcrPassInQ284, isFalse);
      expect(result.realMathLiveReviewRuntimeBindingExecutedInQ284, isFalse);
      expect(result.realImageToLatexInferenceExecutedInQ284, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.requiredReviewRuntimeBindingGates, contains('editableLatexDraftRequired'));
      expect(result.blockedUntilRealEvidence, contains('realEditableMathLiveReviewDraftEvidence'));
      expect(result.forbiddenActions, contains('importCameraOutputWithoutUserApproval'));
    });

    test('blocks missing Q283 image-to-LaTeX candidate evidence', () {
      final result = GaussOcrResultRealMathLiveReviewRuntimeBinding.evaluate(
        const GaussOcrResultRealMathLiveReviewRuntimeBindingInput(
          q283FirstRealImageToLatexInferenceCourtPresent: false,
          acceptedQ283ImageToLatexCandidateEvidence: false,
          q282FirstRealRuntimeSmokeOnDevicePresent: true,
          q281PrivateArtifactLoadSmokePresent: true,
          q280NativeRuntimeBridgePresent: true,
          q279DependencyTrialPresent: true,
          q278EvidenceLockPresent: true,
          runtimeCandidateEnvelopeAccepted: true,
          primaryLatexCandidatePreserved: true,
          alternativeCandidatesPreserved: true,
          confidenceWarningsEngineMetadataPreserved: true,
          imageInputMetadataPreserved: true,
          editableLatexDraftRequired: true,
          editableMathLiveReviewRequired: true,
          reviewDraftMayBeEditedBeforeImport: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          workspaceImportPreparedOnlyAfterUserApproval: true,
          directWorkspaceImportBlocked: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noRealMathLiveReviewRuntimeBindingExecutedInQ284: true,
          noRealImageToLatexInferenceExecutedInQ284: true,
          noRealRuntimeInvocationExecutedInQ284: true,
          noNativeRuntimeBridgeInvokedInQ284: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeHandlerImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noRuntimeDependencyAddedToPubspec: true,
          noGradleNativeRuntimeDependencyAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          reviewBindingPassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          bindingLabel: 'missing-q283',
        ),
      );

      expect(result.reviewRuntimeBindingStaticReady, isFalse);
      expect(result.decision, GaussOcrResultRealMathLiveReviewRuntimeBindingDecision.blockedMissingQ283ImageToLatexInferenceCourt);
      expect(result.canOpenEditableMathLiveReviewInQ284, isFalse);
    });

    test('blocks unsafe runtime/inference/pass claims', () {
      final result = GaussOcrResultRealMathLiveReviewRuntimeBinding.evaluate(
        const GaussOcrResultRealMathLiveReviewRuntimeBindingInput(
          q283FirstRealImageToLatexInferenceCourtPresent: true,
          acceptedQ283ImageToLatexCandidateEvidence: true,
          q282FirstRealRuntimeSmokeOnDevicePresent: true,
          q281PrivateArtifactLoadSmokePresent: true,
          q280NativeRuntimeBridgePresent: true,
          q279DependencyTrialPresent: true,
          q278EvidenceLockPresent: true,
          runtimeCandidateEnvelopeAccepted: true,
          primaryLatexCandidatePreserved: true,
          alternativeCandidatesPreserved: true,
          confidenceWarningsEngineMetadataPreserved: true,
          imageInputMetadataPreserved: true,
          editableLatexDraftRequired: true,
          editableMathLiveReviewRequired: true,
          reviewDraftMayBeEditedBeforeImport: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          workspaceImportPreparedOnlyAfterUserApproval: true,
          directWorkspaceImportBlocked: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noRealMathLiveReviewRuntimeBindingExecutedInQ284: true,
          noRealImageToLatexInferenceExecutedInQ284: false,
          noRealRuntimeInvocationExecutedInQ284: true,
          noNativeRuntimeBridgeInvokedInQ284: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeHandlerImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noRuntimeDependencyAddedToPubspec: true,
          noGradleNativeRuntimeDependencyAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          reviewBindingPassClaimed: false,
          ocrPassClaimed: true,
          releasePassClaimed: false,
          bindingLabel: 'unsafe-pass-claim',
        ),
      );

      expect(result.reviewRuntimeBindingStaticReady, isFalse);
      expect(result.decision, GaussOcrResultRealMathLiveReviewRuntimeBindingDecision.blockedUnsafeRuntimeInferenceOrPassClaim);
      expect(result.canClaimOcrPassInQ284, isFalse);
    });

    test('guarded review draft remains editable but cannot import, solve, graph, or write history', () {
      final candidate = GaussImageToLatexCandidateEnvelope.blockedNoRealInference('q284-request');
      final blocked = GaussOcrResultRealMathLiveReviewRuntimeBinding.guardedReviewDraftBinding(
        reviewRuntimeBindingFeatureFlagEnabled: false,
        captureId: 'capture-001',
        candidate: candidate,
        imageInputMetadata: const <String, String>{'crop': 'normalized'},
      );

      expect(blocked.errorCode, 'reviewRuntimeBindingFeatureFlagOff');
      expect(blocked.canOpenEditableMathLiveReview, isTrue);
      expect(blocked.canImportToWorkspace, isFalse);
      expect(blocked.canEvaluate, isFalse);
      expect(blocked.canGraph, isFalse);
      expect(blocked.canWriteSolutionOrHistory, isFalse);
      expect(blocked.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(blocked.workspaceImportPrepared, isFalse);

      final draft = GaussOcrResultRealMathLiveReviewRuntimeBinding.guardedReviewDraftBinding(
        reviewRuntimeBindingFeatureFlagEnabled: true,
        captureId: 'capture-002',
        candidate: candidate,
        imageInputMetadata: const <String, String>{'crop': 'normalized'},
      );
      expect(draft.sourcePhase, 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT');
      expect(draft.canOpenEditableMathLiveReview, isTrue);
      expect(draft.canImportToWorkspace, isFalse);
      expect(draft.directWorkspaceMutationAttempted, isFalse);
      expect(draft.directSolveGraphSolutionHistoryAttempted, isFalse);
    });
  });
}
