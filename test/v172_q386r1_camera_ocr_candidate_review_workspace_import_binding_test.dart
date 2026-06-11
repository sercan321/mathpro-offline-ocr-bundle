import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_candidate_review_workspace_import_binding_q386r1.dart';

void main() {
  group('V172-Q386R1 OCR candidate review workspace import binding', () {
    test('policy requires real candidate, editable review, explicit approval and callback', () {
      expect(
        GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.phase,
        'V172-Q386R1-OCR-CANDIDATE-REVIEW-WORKSPACE-IMPORT-BINDING',
      );
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.sourcePhase, 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE');
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.requiresRealDecodedCandidate, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.requiresEditableReviewDraft, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.requiresNonEmptyReviewedLatex, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.requiresExplicitUserApproval, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.requiresWorkspaceImportCallback, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.directCameraToWorkspaceImportBlocked, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.autoEvaluateBlocked, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.autoGraphBlocked, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.autoSolutionHistoryBlocked, isTrue);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.fakeOcrCandidateAllowed, isFalse);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.workspaceImportPassClaimedByQ386R1, isFalse);
      expect(GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.ocrPassClaimedByQ386R1, isFalse);
    });

    test('gate enables import only after reviewed non-empty candidate and callback', () {
      final blockedNoCandidate = GaussQ386R1WorkspaceImportGate.evaluate(
        hasRealOcrCandidate: false,
        hasEditableReviewDraft: true,
        workspaceImportCallbackAvailable: true,
        explicitUserApproval: true,
        approvedLatex: r'x+1',
      );
      expect(blockedNoCandidate.canSubmit, isFalse);
      expect(blockedNoCandidate.blockedReason, GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.blockedNoCandidate);

      final blockedEmptyLatex = GaussQ386R1WorkspaceImportGate.evaluate(
        hasRealOcrCandidate: true,
        hasEditableReviewDraft: true,
        workspaceImportCallbackAvailable: true,
        explicitUserApproval: true,
        approvedLatex: '   ',
      );
      expect(blockedEmptyLatex.canSubmit, isFalse);
      expect(blockedEmptyLatex.blockedReason, GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.blockedEmptyApprovedLatex);

      final ready = GaussQ386R1WorkspaceImportGate.evaluate(
        hasRealOcrCandidate: true,
        hasEditableReviewDraft: true,
        workspaceImportCallbackAvailable: true,
        explicitUserApproval: true,
        approvedLatex: r'  \frac{1}{2}  ',
      );
      expect(ready.canSubmit, isTrue);
      expect(ready.approvedLatex, r'\frac{1}{2}');
      expect(ready.blockedReason, GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.ready);
      expect(ready.directCameraToWorkspaceImportBlocked, isTrue);
      expect(ready.autoEvaluateBlocked, isTrue);
      expect(ready.autoGraphBlocked, isTrue);
      expect(ready.autoSolutionHistoryBlocked, isTrue);
    });

    test('review surface and AppShell route remain approval-first without auto solve/graph/history', () {
      final review = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      expect(review, contains('GaussQ386R1WorkspaceImportGate.evaluate'));
      expect(review, contains('_reviewTextHasContent'));
      expect(review, contains('widget.onApprovedLatexImport != null'));
      expect(review, contains('_q386r1WorkspaceImportGate.canSubmit'));
      expect(review, contains('Future<void> Function() onQueueModel'));
      expect(review, contains('semanticsLabel: downloadActionSemantics'));
      expect(appShell, contains('_handleApprovedOcrWorkspaceImport'));
      expect(appShell, contains('setLatexFromApprovedOcrImport'));
      expect(appShell, contains('_stepsPanelState = SolutionStepsPanelState.closed'));
      expect(appShell, contains('_graphPreviewVisible = false'));
    });

    test('manifest records Q386R1 without OCR/workspace PASS claim', () {
      final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
      expect(manifest['cameraOcrCandidateReviewWorkspaceImportBindingLatestPhase'], GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.phase);
      final q386r1 = manifest['v172Q386R1CameraOcrCandidateReviewWorkspaceImportBinding'] as Map<String, dynamic>;
      expect(q386r1['phase'], GaussCameraOcrCandidateReviewWorkspaceImportBindingQ386R1Policy.phase);
      expect(q386r1['requiresRealDecodedCandidate'], isTrue);
      expect(q386r1['requiresEditableReviewDraft'], isTrue);
      expect(q386r1['requiresWorkspaceImportCallback'], isTrue);
      expect(q386r1['directCameraToWorkspaceImportBlocked'], isTrue);
      expect(q386r1['autoEvaluateBlocked'], isTrue);
      expect(q386r1['autoGraphBlocked'], isTrue);
      expect(q386r1['autoSolutionHistoryBlocked'], isTrue);
      expect(q386r1['workspaceImportPassClaimedByPackage'], isFalse);
      expect(q386r1['ocrPassClaimedByPackage'], isFalse);
    });
  });
}
