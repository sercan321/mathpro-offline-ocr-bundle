import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_editable_mathlive_review_real_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_editable_mathlive_review_real_runtime_policy.dart';

void main() {
  group('V172-Q296 OCR result editable MathLive review real runtime', () {
    const validSha = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
    const safeDraft = GaussEditableMathLiveReviewDraftEnvelope(
      reviewId: 'review-q296-001',
      sourceInferenceRequestId: 'inference-q295-001',
      captureId: 'capture-001',
      engineLabel: 'PP-FormulaNet-S',
      sourcePhase: 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE',
      editableLatexDraft: r'\frac{1}{2}',
      primaryLatexCandidate: r'\frac{1}{2}',
      alternativeLatexCandidates: <String>[r'\frac{1}{2}', r'1/2'],
      selectedCandidateIndex: 0,
      confidence: 0.82,
      warnings: <String>['review-required'],
      engineMetadata: <String, String>{'runtime': 'pp-formulanet-s', 'phase': 'q296'},
      cropMetadata: <String, String>{'crop': 'normalized', 'rotation': '0'},
      imageSha256: validSha,
      reviewOpenedAtIso8601: '2026-06-06T00:00:00Z',
      reviewFeatureFlagEnabled: false,
      userApprovalRequired: true,
      directWorkspaceMutationAttempted: false,
      solveGraphSolutionHistoryTriggered: false,
    );

    test('declares Q296 review contract while blocking real review binding and fake PASS claims', () {
      final result = GaussOcrResultEditableMathLiveReviewRealRuntime.evaluateContract();

      expect(result.phase, GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.phase);
      expect(result.sourcePhase, 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.reviewFeatureFlag, 'gauss.ppFormulaNetS.ocrResultEditableMathLiveReview.defaultOff');
      expect(result.reviewReadinessState, contains('BLOCKED_PENDING_Q295'));
      expect(result.decision, GaussOcrResultEditableMathLiveReviewRealRuntimeDecision.editableReviewContractReadyRealBindingBlocked);
      expect(result.editableReviewPreconditions, contains('editable-mathlive-review-required'));
      expect(result.reviewDraftEnvelopeFields, contains('editableLatexDraft'));
      expect(result.reviewErrorCodes, contains('noRealEditableMathLiveReviewOpenedInQ296'));
      expect(result.reviewFeatureFlagEnabledByDefault, isFalse);
      expect(result.realEditableMathLiveReviewOpened, isFalse);
      expect(result.realReviewDraftBoundToMathLive, isFalse);
      expect(result.realUserCorrectionCaptured, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.directWorkspaceImportEnabled, isFalse);
      expect(result.directSolveGraphSolutionHistoryEnabled, isFalse);
      expect(result.reviewBindingPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('validates review draft structure but keeps real MathLive opening blocked by default-off flag', () {
      expect(safeDraft.isReviewDraftStructurallySafe, isTrue);
      final blocked = GaussOcrResultEditableMathLiveReviewRealRuntime.openEditableReviewDraft(safeDraft);

      expect(blocked.status, 'blocked');
      expect(blocked.errorCode, 'reviewFeatureFlagOff');
      expect(blocked.reviewOpened, isFalse);
      expect(blocked.boundToMathLive, isFalse);
      expect(blocked.userCanEditBeforeApproval, isTrue);
      expect(blocked.canImportToWorkspace, isFalse);
      expect(blocked.directWorkspaceMutationAttempted, isFalse);
      expect(blocked.solveGraphSolutionHistoryTriggered, isFalse);
    });

    test('blocks direct workspace mutation and solve graph solution history side effects', () {
      const unsafeDraft = GaussEditableMathLiveReviewDraftEnvelope(
        reviewId: 'review-q296-unsafe',
        sourceInferenceRequestId: 'inference-q295-unsafe',
        captureId: 'capture-unsafe',
        engineLabel: 'PP-FormulaNet-S',
        sourcePhase: 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE',
        editableLatexDraft: r'x^2',
        primaryLatexCandidate: r'x^2',
        alternativeLatexCandidates: <String>[r'x^2'],
        selectedCandidateIndex: 0,
        confidence: 0.75,
        warnings: <String>['review-required'],
        engineMetadata: <String, String>{'runtime': 'pp-formulanet-s'},
        cropMetadata: <String, String>{'crop': 'normalized'},
        imageSha256: validSha,
        reviewOpenedAtIso8601: '2026-06-06T00:00:00Z',
        reviewFeatureFlagEnabled: true,
        userApprovalRequired: true,
        directWorkspaceMutationAttempted: true,
        solveGraphSolutionHistoryTriggered: true,
      );

      expect(unsafeDraft.blocksDirectSideEffects, isFalse);
      final blocked = GaussOcrResultEditableMathLiveReviewRealRuntime.openEditableReviewDraft(unsafeDraft);
      expect(blocked.errorCode, 'directWorkspaceMutationBlocked');
      expect(blocked.canImportToWorkspace, isFalse);
    });

    test('policy forbids runtime/model additions and all OCR/review PASS claims', () {
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.realEditableMathLiveReviewOpened, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.realReviewDraftBoundToMathLive, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.realImageToLatexInferenceExecuted, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.paddleRuntimeAdded, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.paddleOcrDependencyAdded, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.nativeRuntimeHandlerImplemented, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.jniBindingAdded, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.methodChannelRuntimeBindingAdded, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.productionDownloadEnabled, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.directWorkspaceImportEnabled, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.directSolveGraphSolutionHistoryBlocked, isTrue);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.reviewBindingPassClaimed, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.ocrPassClaimed, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.cameraOcrRuntimePassClaimed, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.releasePassClaimed, isFalse);
      expect(GaussOcrResultEditableMathLiveReviewRealRuntimePolicy.requiresUserSideRetest, contains('flutter test'));
    });
  });
}
