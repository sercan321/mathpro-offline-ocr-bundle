import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_real_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_real_runtime_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_editable_mathlive_review_real_runtime.dart';

void main() {
  group('V172-Q297 approved OCR workspace import real runtime', () {
    const validSha = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
    const safeDraft = GaussEditableMathLiveReviewDraftEnvelope(
      reviewId: 'review-q297-001',
      sourceInferenceRequestId: 'inference-q295-001',
      captureId: 'capture-q297-001',
      engineLabel: 'PP-FormulaNet-S',
      sourcePhase: 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE',
      editableLatexDraft: r'\frac{1}{2}',
      primaryLatexCandidate: r'\frac{1}{2}',
      alternativeLatexCandidates: <String>[r'\frac{1}{2}', r'1/2'],
      selectedCandidateIndex: 0,
      confidence: 0.82,
      warnings: <String>['review-required'],
      engineMetadata: <String, String>{'runtime': 'pp-formulanet-s', 'phase': 'q297'},
      cropMetadata: <String, String>{'crop': 'normalized', 'rotation': '0'},
      imageSha256: validSha,
      reviewOpenedAtIso8601: '2026-06-06T00:00:00Z',
      reviewFeatureFlagEnabled: false,
      userApprovalRequired: true,
      directWorkspaceMutationAttempted: false,
      solveGraphSolutionHistoryTriggered: false,
    );

    test('declares Q297 workspace import contract while blocking real workspace mutation and fake PASS claims', () {
      final result = GaussApprovedOcrWorkspaceImportRealRuntime.evaluateContract();

      expect(result.phase, GaussApprovedOcrWorkspaceImportRealRuntimePolicy.phase);
      expect(result.sourcePhase, 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.workspaceImportFeatureFlag, 'gauss.ppFormulaNetS.approvedOcrWorkspaceImport.defaultOff');
      expect(result.workspaceImportReadinessState, contains('BLOCKED_PENDING_Q296'));
      expect(result.decision, GaussApprovedOcrWorkspaceImportRealRuntimeDecision.approvedWorkspaceImportContractReadyRealImportBlocked);
      expect(result.workspaceImportPreconditions, contains('explicit-user-approval-required-before-workspace-import'));
      expect(result.workspaceImportPreconditions, contains('direct-solve-graph-solution-history-remain-blocked'));
      expect(result.workspaceImportEnvelopeFields, contains('approvedLatexDraft'));
      expect(result.workspaceImportErrorCodes, contains('noRealWorkspaceImportExecutedInQ297'));
      expect(result.workspaceImportFeatureFlagEnabledByDefault, isFalse);
      expect(result.realWorkspaceImportRuntimeExecuted, isFalse);
      expect(result.realEditableMathLiveReviewOpened, isFalse);
      expect(result.realUserApprovalCaptured, isFalse);
      expect(result.directWorkspaceImportEnabled, isFalse);
      expect(result.autoEvaluateEnabled, isFalse);
      expect(result.autoSolveGraphSolutionHistoryEnabled, isFalse);
      expect(result.workspaceImportPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('keeps workspace import blocked by default-off flag even with approved review draft', () {
      final envelope = GaussApprovedOcrWorkspaceImportEnvelope.fromApprovedReviewDraft(
        workspaceImportFeatureFlagEnabled: false,
        reviewDraft: safeDraft,
        userApprovedForWorkspaceImport: true,
        approvedLatexDraft: r'\frac{1}{2}',
        reviewMetadata: const <String, String>{'reviewUi': 'editable-mathlive-review'},
      );

      expect(safeDraft.isReviewDraftStructurallySafe, isTrue);
      expect(envelope.errorCode, 'workspaceImportFeatureFlagOff');
      expect(envelope.workspaceImportPrepared, isFalse);
      expect(envelope.workspaceImportRuntimeExecuted, isFalse);
      expect(envelope.workspaceExpressionCandidate, isEmpty);
      expect(envelope.canMutateWorkspaceInQ297, isFalse);
      expect(envelope.canEvaluateInQ297, isFalse);
      expect(envelope.canSolveGraphSolutionHistoryInQ297, isFalse);
      expect(envelope.canClaimWorkspaceImportPass, isFalse);
    });

    test('requires explicit user approval and blocks auto evaluate solve graph solution history', () {
      final noApproval = GaussApprovedOcrWorkspaceImportEnvelope.fromApprovedReviewDraft(
        workspaceImportFeatureFlagEnabled: true,
        reviewDraft: safeDraft,
        userApprovedForWorkspaceImport: false,
        approvedLatexDraft: r'x^2',
        reviewMetadata: const <String, String>{'reviewUi': 'editable-mathlive-review'},
      );
      expect(noApproval.errorCode, 'missingExplicitUserApproval');
      expect(noApproval.workspaceImportPrepared, isFalse);

      final sideEffectAttempt = GaussApprovedOcrWorkspaceImportEnvelope.fromApprovedReviewDraft(
        workspaceImportFeatureFlagEnabled: true,
        reviewDraft: safeDraft,
        userApprovedForWorkspaceImport: true,
        approvedLatexDraft: r'x^2',
        reviewMetadata: const <String, String>{'reviewUi': 'editable-mathlive-review'},
        directEvaluateAttempted: true,
      );
      expect(sideEffectAttempt.errorCode, 'directEvaluateBlocked');
      expect(sideEffectAttempt.workspaceImportPrepared, isFalse);
      expect(sideEffectAttempt.canEvaluateInQ297, isFalse);
    });

    test('policy forbids runtime/model additions and all OCR workspace import PASS claims', () {
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportFeatureFlagEnabledByDefault, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.realWorkspaceImportRuntimeExecuted, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.realEditableMathLiveReviewOpened, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.realUserApprovalCaptured, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.paddleRuntimeAdded, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.paddleOcrDependencyAdded, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.nativeRuntimeHandlerImplemented, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.methodChannelRuntimeBindingAdded, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.productionDownloadEnabled, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.directWorkspaceImportEnabled, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.autoEvaluateEnabled, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.autoSolveGraphSolutionHistoryEnabled, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.workspaceImportPassClaimed, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.ocrPassClaimed, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.cameraOcrRuntimePassClaimed, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.releasePassClaimed, isFalse);
      expect(GaussApprovedOcrWorkspaceImportRealRuntimePolicy.requiresUserSideRetest, contains('flutter test'));
    });
  });
}
