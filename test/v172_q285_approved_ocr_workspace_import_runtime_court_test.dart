import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_runtime_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_runtime_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding.dart';

void main() {
  group('V172-Q285 Approved OCR workspace import runtime court', () {
    const readyInput = GaussApprovedOcrWorkspaceImportRuntimeCourtInput(
      q284RealMathLiveReviewRuntimeBindingPresent: true,
      acceptedEditableMathLiveReviewDraftEvidence: true,
      editableReviewDraftPresent: true,
      reviewDraftMayBeEditedBeforeApproval: true,
      explicitUserApprovalReceived: true,
      approvedLatexDraft: r'x^2+1',
      workspaceImportPreparedOnlyAfterUserApproval: true,
      workspaceImportEnvelopePreservesReviewMetadata: true,
      workspaceImportEnvelopePreservesEngineMetadata: true,
      workspaceImportEnvelopePreservesImageInputMetadata: true,
      workspaceMutationRuntimeExecutionAttemptedInQ285: false,
      autoEvaluateAfterImport: false,
      autoSolveAfterImport: false,
      autoGraphAfterImport: false,
      autoSolutionAfterImport: false,
      autoHistoryAfterImport: false,
      manualSolveGraphAfterImportOnly: true,
      noRealWorkspaceImportRuntimeExecutedInQ285: true,
      noRealMathLiveReviewRuntimeBindingExecutedInQ285: true,
      noRealImageToLatexInferenceExecutedInQ285: true,
      noRealRuntimeInvocationExecutedInQ285: true,
      noNativeRuntimeBridgeInvokedInQ285: true,
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
      workspaceImportRuntimePassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      importLabel: 'q285-approved-workspace-import-runtime-court',
    );

    test('prepares only an approved import envelope and blocks automatic actions', () {
      final result = GaussApprovedOcrWorkspaceImportRuntimeCourt.evaluate(readyInput);

      expect(result.phase, GaussApprovedOcrWorkspaceImportRuntimeCourtPolicy.phase);
      expect(result.sourcePhase, 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.workspaceImportRuntimeCourtStaticReady, isTrue);
      expect(result.readyForFutureRuntimeWorkspaceImportOnly, isTrue);
      expect(result.decision, GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.readyForFutureRuntimeWorkspaceImportOnly);
      expect(result.canPrepareWorkspaceImportEnvelopeAfterApproval, isTrue);
      expect(result.canMutateWorkspaceInQ285, isFalse);
      expect(result.canEvaluate, isFalse);
      expect(result.canSolve, isFalse);
      expect(result.canGraph, isFalse);
      expect(result.canWriteSolutionOrHistory, isFalse);
      expect(result.canClaimWorkspaceImportRuntimePassInQ285, isFalse);
      expect(result.canClaimOcrPassInQ285, isFalse);
      expect(result.realWorkspaceImportRuntimeExecutedInQ285, isFalse);
      expect(result.realImageToLatexInferenceExecutedInQ285, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.requiredWorkspaceImportRuntimeCourtGates, contains('explicitUserApprovalReceivedBeforeWorkspaceImport'));
      expect(result.blockedUntilRealEvidence, contains('realWorkspaceImportEnvelopeEvidence'));
      expect(result.forbiddenActions, contains('autoSolveApprovedCameraOutput'));
    });

    test('blocks missing user approval before workspace import preparation', () {
      final result = GaussApprovedOcrWorkspaceImportRuntimeCourt.evaluate(
        const GaussApprovedOcrWorkspaceImportRuntimeCourtInput(
          q284RealMathLiveReviewRuntimeBindingPresent: true,
          acceptedEditableMathLiveReviewDraftEvidence: true,
          editableReviewDraftPresent: true,
          reviewDraftMayBeEditedBeforeApproval: true,
          explicitUserApprovalReceived: false,
          approvedLatexDraft: r'x^2+1',
          workspaceImportPreparedOnlyAfterUserApproval: true,
          workspaceImportEnvelopePreservesReviewMetadata: true,
          workspaceImportEnvelopePreservesEngineMetadata: true,
          workspaceImportEnvelopePreservesImageInputMetadata: true,
          workspaceMutationRuntimeExecutionAttemptedInQ285: false,
          autoEvaluateAfterImport: false,
          autoSolveAfterImport: false,
          autoGraphAfterImport: false,
          autoSolutionAfterImport: false,
          autoHistoryAfterImport: false,
          manualSolveGraphAfterImportOnly: true,
          noRealWorkspaceImportRuntimeExecutedInQ285: true,
          noRealMathLiveReviewRuntimeBindingExecutedInQ285: true,
          noRealImageToLatexInferenceExecutedInQ285: true,
          noRealRuntimeInvocationExecutedInQ285: true,
          noNativeRuntimeBridgeInvokedInQ285: true,
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
          workspaceImportRuntimePassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          importLabel: 'missing-approval',
        ),
      );

      expect(result.workspaceImportRuntimeCourtStaticReady, isFalse);
      expect(result.decision, GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedMissingExplicitUserApproval);
      expect(result.canPrepareWorkspaceImportEnvelopeAfterApproval, isFalse);
    });

    test('blocks automatic evaluate, solve, graph, solution, and history actions', () {
      final result = GaussApprovedOcrWorkspaceImportRuntimeCourt.evaluate(
        const GaussApprovedOcrWorkspaceImportRuntimeCourtInput(
          q284RealMathLiveReviewRuntimeBindingPresent: true,
          acceptedEditableMathLiveReviewDraftEvidence: true,
          editableReviewDraftPresent: true,
          reviewDraftMayBeEditedBeforeApproval: true,
          explicitUserApprovalReceived: true,
          approvedLatexDraft: r'\frac{1}{2}',
          workspaceImportPreparedOnlyAfterUserApproval: true,
          workspaceImportEnvelopePreservesReviewMetadata: true,
          workspaceImportEnvelopePreservesEngineMetadata: true,
          workspaceImportEnvelopePreservesImageInputMetadata: true,
          workspaceMutationRuntimeExecutionAttemptedInQ285: false,
          autoEvaluateAfterImport: false,
          autoSolveAfterImport: true,
          autoGraphAfterImport: true,
          autoSolutionAfterImport: false,
          autoHistoryAfterImport: false,
          manualSolveGraphAfterImportOnly: false,
          noRealWorkspaceImportRuntimeExecutedInQ285: true,
          noRealMathLiveReviewRuntimeBindingExecutedInQ285: true,
          noRealImageToLatexInferenceExecutedInQ285: true,
          noRealRuntimeInvocationExecutedInQ285: true,
          noNativeRuntimeBridgeInvokedInQ285: true,
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
          workspaceImportRuntimePassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          importLabel: 'auto-action-risk',
        ),
      );

      expect(result.workspaceImportRuntimeCourtStaticReady, isFalse);
      expect(result.decision, GaussApprovedOcrWorkspaceImportRuntimeCourtDecision.blockedAutoSolveGraphSolutionHistoryRisk);
      expect(result.canSolve, isFalse);
      expect(result.canGraph, isFalse);
    });

    test('creates an import envelope only after editable review and explicit approval', () {
      final candidate = GaussImageToLatexCandidateEnvelope.blockedNoRealInference('q285-request');
      final reviewDraft = GaussRealMathLiveReviewDraftEnvelope.fromQ283Candidate(
        captureId: 'capture-q285',
        candidate: candidate,
        imageInputMetadata: const <String, String>{'crop': 'normalized'},
      );

      final blocked = GaussApprovedOcrWorkspaceImportEnvelope.fromApprovedReviewDraft(
        workspaceImportRuntimeCourtFeatureFlagEnabled: false,
        reviewDraft: reviewDraft,
        userApprovedForWorkspaceImport: true,
        approvedLatexDraft: r'x^2+1',
      );
      expect(blocked.errorCode, 'workspaceImportRuntimeCourtFeatureFlagOff');
      expect(blocked.canPrepareWorkspaceImportEnvelope, isFalse);
      expect(blocked.canMutateWorkspaceInQ285, isFalse);
      expect(blocked.canEvaluate, isFalse);
      expect(blocked.canSolve, isFalse);
      expect(blocked.canGraph, isFalse);
      expect(blocked.canWriteSolutionOrHistory, isFalse);

      final approved = GaussApprovedOcrWorkspaceImportEnvelope.fromApprovedReviewDraft(
        workspaceImportRuntimeCourtFeatureFlagEnabled: true,
        reviewDraft: reviewDraft,
        userApprovedForWorkspaceImport: true,
        approvedLatexDraft: r'x^2+1',
        reviewMetadata: const <String, String>{'review': 'editable'},
      );
      expect(approved.canPrepareWorkspaceImportEnvelope, isTrue);
      expect(approved.workspaceExpressionCandidate, r'x^2+1');
      expect(approved.workspaceImportRuntimeExecuted, isFalse);
      expect(approved.manualSolveGraphAfterImportOnly, isTrue);
      expect(approved.directEvaluateAttempted, isFalse);
      expect(approved.directSolveGraphSolutionHistoryAttempted, isFalse);
    });
  });
}
