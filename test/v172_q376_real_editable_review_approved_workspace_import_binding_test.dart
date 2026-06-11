import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_editable_review_approved_workspace_import_binding_q376.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_editable_review_approved_workspace_import_binding_q376_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q376 binds decoded OCR candidate to review-first approved workspace import contract', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q376 = manifest['v172Q376RealEditableReviewApprovedWorkspaceImportBinding'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['realEditableReviewApprovedWorkspaceImportBindingLatestPhase'], GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.phase);
    expect(q376['phase'], GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.phase);
    expect(q376['sourcePhase'], GaussRealOcrExecutionOutputDecoderClosureQ375Policy.phase);
    expect(q376['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q376['bindingVersion'], GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.bindingVersion);
    expect(q376['reviewTarget'], GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.reviewTarget);
    expect(q376['workspaceImportTarget'], GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.workspaceImportTarget);

    for (final key in <String>[
      'realEditableReviewBindingPrepared',
      'approvedWorkspaceImportBindingPrepared',
      'requiresQ375DecodedCandidate',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'requiresNonEmptyApprovedLatex',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'mathLiveProductionRoutePreserved',
      'workspaceUiPreserved',
    ]) {
      expect(q376[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'workspaceImportAutoExecuted',
      'approvedWorkspaceImportExecutedByPackage',
      'solveGraphSolutionHistoryTouched',
      'ocrPassClaimed',
      'androidPassClaimed',
      'storeReadyPassClaimed',
      'releaseReadyPassClaimed',
      'mainActivityChanged',
      'pubspecChanged',
      'gradleChanged',
      'androidManifestChanged',
      'keyboardChanged',
      'moreTemplateTrayChanged',
      'longPressChanged',
      'mathLiveProductionBridgeChanged',
      'workspaceChanged',
      'graphChanged',
      'solutionChanged',
      'historyChanged',
      'splashChanged',
      'iconChanged',
    ]) {
      expect(q376[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.evaluate();
    expect(result.phase, GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.phase);
    expect(result.realEditableReviewBindingPrepared, isTrue);
    expect(result.approvedWorkspaceImportBindingPrepared, isTrue);
    expect(result.directOcrToWorkspaceImportBlocked, isTrue);
    expect(result.approvedWorkspaceImportExecutedByPackage, isFalse);

    final blocked = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.prepareReviewDraft(
      const GaussRealOcrDecodedCandidateQ375(
        candidateLatex: '',
        candidateConfidence: 0.0,
        candidateSource: 'test-empty',
        candidateLatexDecoded: false,
        decoderBlockedReason: 'decoder-vocabulary-not-available-or-empty-model-output',
        requiresEditableMathLiveReviewBeforeImport: true,
        requiresExplicitUserApprovalBeforeWorkspaceImport: true,
        directOcrToWorkspaceImportBlocked: true,
      ),
    );
    expect(blocked.reviewReady, isFalse);
    expect(blocked.blockedReason, isNotEmpty);
    expect(blocked.toJson()['workspaceImportExecuted'], isFalse);

    final decoded = GaussRealOcrExecutionOutputDecoderClosureQ375.decodeEvidence(
      const <String, Object?>{
        'candidateLatex': r'\frac{1}{2}',
        'candidateConfidence': 0.91,
      },
    );
    final draft = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.prepareReviewDraft(
      decoded,
      editedLatex: r'\frac{1}{2}+x',
    );
    expect(draft.reviewReady, isTrue);
    expect(draft.reviewLatex, r'\frac{1}{2}+x');
    expect(draft.directOcrToWorkspaceImportBlocked, isTrue);

    final noApproval = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.buildApprovedWorkspaceImportCommand(
      reviewDraft: draft,
      reviewCompleted: true,
      explicitUserApproval: false,
    );
    expect(noApproval.approvedWorkspaceImportReady, isFalse);
    expect(noApproval.blockedReason, 'explicit-user-approval-missing');
    expect(noApproval.autoSolveBlocked, isTrue);
    expect(noApproval.autoGraphBlocked, isTrue);
    expect(noApproval.workspaceImportExecutedByPackage, isFalse);

    final approved = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.buildApprovedWorkspaceImportCommand(
      reviewDraft: draft,
      reviewCompleted: true,
      explicitUserApproval: true,
    );
    expect(approved.approvedWorkspaceImportReady, isTrue);
    expect(approved.approvedLatex, r'\frac{1}{2}+x');
    expect(approved.autoSolveBlocked, isTrue);
    expect(approved.autoGraphBlocked, isTrue);
    expect(approved.autoSolutionHistoryBlocked, isTrue);
    expect(approved.workspaceImportExecutedByPackage, isFalse);
    expect(approved.toJson()['ocrPassClaimed'], isFalse);
  });
}
