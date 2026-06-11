import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_camera_ocr_user_flow_binding_q378.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_camera_ocr_user_flow_binding_q378_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_editable_review_approved_workspace_import_binding_q376.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q378 records real camera OCR user flow binding without static OCR pass claim', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q378 = manifest['v172Q378RealCameraOcrUserFlowBinding'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['realCameraOcrUserFlowBindingLatestPhase'], GaussRealCameraOcrUserFlowBindingQ378Policy.phase);
    expect(q378['phase'], GaussRealCameraOcrUserFlowBindingQ378Policy.phase);
    expect(q378['cameraCropAcceptInvokesOcrHarness'], isTrue);
    expect(q378['editableReviewReceivesDecodedCandidate'], isTrue);
    expect(q378['approvedReviewImportsToWorkspace'], isTrue);
    expect(q378['directOcrToWorkspaceImportBlockedBeforeReview'], isTrue);
    expect(q378['solveGraphSolutionHistoryAutoTriggerBlocked'], isTrue);
    expect(q378['ocrPassClaimedByPackage'], isFalse);
  });

  test('q378 approved import command is review-first and never auto-solves', () {
    final decoded = GaussRealOcrExecutionOutputDecoderClosureQ375.decodeEvidence(
      const <String, Object?>{
        'candidateLatex': r'x+1',
        'candidateConfidence': 0.84,
      },
    );
    final reviewDraft = GaussRealEditableReviewApprovedWorkspaceImportBindingQ376.prepareReviewDraft(decoded);
    final importResult = GaussRealCameraOcrUserFlowBindingQ378.prepareApprovedImport(
      reviewDraft: reviewDraft,
      approvedLatex: r'x+1',
      explicitUserApproval: true,
    );

    expect(reviewDraft.reviewReady, isTrue);
    expect(importResult.workspaceImportReady, isTrue);
    expect(importResult.command.approvedLatex, r'x+1');
    expect(importResult.command.autoSolveBlocked, isTrue);
    expect(importResult.command.autoGraphBlocked, isTrue);
    expect(importResult.command.autoSolutionHistoryBlocked, isTrue);
    expect(importResult.solveGraphSolutionHistoryTouched, isFalse);
  });

  test('q378 source files contain real camera flow markers', () {
    final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
    final reviewSurface = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final appShell = File('lib/app/app_shell.dart').readAsStringSync();
    final mathlive = File('lib/features/mathlive/mathlive_main_editor_surface.dart').readAsStringSync();

    expect(cameraShell, contains('GaussRealCameraOcrUserFlowBindingQ378.captureAndPrepareReview'));
    expect(cameraShell, contains('GaussMathLiveOcrReviewDraft.fromQ378Evidence'));
    expect(reviewSurface, contains('GaussRealCameraOcrUserFlowBindingQ378.prepareApprovedImport'));
    expect(reviewSurface, contains('Workspace’e aktar'));
    expect(workspace, contains('onApprovedOcrWorkspaceImport'));
    expect(appShell, contains('_handleApprovedOcrWorkspaceImport'));
    expect(appShell, contains('q378-approved-ocr-workspace-import'));
    expect(mathlive, contains('setLatexFromApprovedOcrImport'));
    expect(
      reviewSurface.contains('Solve/Graph/Solution/History otomatik çalışmaz') ||
          reviewSurface.contains('çözüm, grafik, Solution ve History otomatik çalışmaz'),
      isTrue,
    );
  });
}
