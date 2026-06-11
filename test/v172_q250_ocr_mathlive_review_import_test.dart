import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_model_download_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_mathlive_ocr_review_surface.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_mathlive_review_import.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_mathlive_review_import_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_runtime_adapter.dart';

// Q250 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3
void main() {
  group('V172-Q250 OCR to MathLive review import contract', () {
    const validHash = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';

    const readyEvidence = GaussDeferredModelArtifactEvidence(
      status: GaussDeferredModelDownloadStatus.ready,
      expectedSha256: validHash,
      actualSha256: validHash,
      modelSizeBytes: 42 * 1024 * 1024,
      storedInPrivateAppStorage: true,
      offlineAfterInstall: true,
      mathLiveReviewRequired: true,
      directSolveAllowed: false,
      productionUrlBound: false,
      modelBinaryBundledInBaseApp: false,
    );

    const validInput = GaussOcrRuntimeAdapterInput(
      capturePath: '/tmp/gauss-capture.png',
      cropFrameId: 'scan-frame-1',
      rotationQuarterTurns: 0,
      modelEvidence: readyEvidence,
      preprocessProfile: 'q250-premium-crop-normalize',
      sourcePhase: GaussDeferredModelDownloadRuntime.phase,
    );

    const validCandidate = GaussOcrRuntimeLatexCandidate(
      rank: 1,
      latex: r'\int_0^1 x^2\,dx',
      confidence: 0.88,
      engineLabel: 'PP-FormulaNet-S',
      warningCodes: <GaussOcrRuntimeWarningCode>[
        GaussOcrRuntimeWarningCode.possibleIntegralLimitAmbiguity,
      ],
      reviewOnly: true,
    );

    test('records Q250 as editable MathLive review-first import, not direct import or solve', () {
      expect(GaussOcrMathLiveReviewImportPolicy.phase, 'V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT');
      expect(GaussOcrMathLiveReviewImportPolicy.closesOverPhase, 'V172-Q249-OCR-RUNTIME-ADAPTER');
      expect(GaussOcrMathLiveReviewImportPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussOcrMathLiveReviewImportPolicy.reviewImportMode, 'editable-mathlive-review-first-import-contract');
      expect(GaussOcrMathLiveReviewImportPolicy.q249AdapterEnvelopeRequired, isTrue);
      expect(GaussOcrMathLiveReviewImportPolicy.editableMathLiveReviewDraftImplemented, isTrue);
      expect(GaussOcrMathLiveReviewImportPolicy.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(GaussOcrMathLiveReviewImportPolicy.directWorkspaceImportAllowed, isFalse);
      expect(GaussOcrMathLiveReviewImportPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussOcrMathLiveReviewImport.callsProductionMathLiveBridge, isFalse);
    });

    test('blocks MathLive review import until the Q249 adapter envelope is review-ready', () {
      final blockedEnvelope = GaussOcrRuntimeAdapter.createReviewOnlyEnvelope(
        input: validInput,
      );

      final draft = GaussOcrMathLiveReviewImport.createEditableReviewDraft(
        adapterEnvelope: blockedEnvelope,
      );

      expect(draft.decision, GaussOcrMathLiveReviewImportDecision.blockedMissingPrimaryCandidate);
      expect(draft.canOpenEditableMathLiveReview, isFalse);
      expect(draft.canImportToWorkspaceAfterUserApproval, isFalse);
      expect(draft.directSolveAllowed, isFalse);
    });

    test('opens editable MathLive review but still blocks workspace import before user approval', () {
      final envelope = GaussOcrRuntimeAdapter.createReviewOnlyEnvelope(
        input: validInput,
        primaryCandidate: validCandidate,
        alternativeCandidates: const <GaussOcrRuntimeLatexCandidate>[
          GaussOcrRuntimeLatexCandidate(
            rank: 2,
            latex: r'\int_0^1 x^2 dx',
            confidence: 0.79,
            engineLabel: 'PP-FormulaNet-S',
            warningCodes: <GaussOcrRuntimeWarningCode>[],
            reviewOnly: true,
          ),
        ],
      );

      final draft = GaussOcrMathLiveReviewImport.createEditableReviewDraft(
        adapterEnvelope: envelope,
      );

      expect(draft.decision, GaussOcrMathLiveReviewImportDecision.editableReviewDraftReady);
      expect(draft.canOpenEditableMathLiveReview, isTrue);
      expect(draft.canImportToWorkspaceAfterUserApproval, isFalse);
      expect(draft.primaryCandidate!.editableLatex, r'\int_0^1 x^2\,dx');
      expect(draft.alternativeCandidates, hasLength(1));
      expect(draft.canEvaluateBeforeApproval, isFalse);
      expect(draft.canGraphBeforeApproval, isFalse);
      expect(draft.canWriteSolutionBeforeApproval, isFalse);
      expect(draft.canWriteHistoryBeforeApproval, isFalse);
    });

    test('prepares workspace import only after explicit user approval of edited MathLive LaTeX', () {
      final envelope = GaussOcrRuntimeAdapter.createReviewOnlyEnvelope(
        input: validInput,
        primaryCandidate: validCandidate,
      );

      final approvedDraft = GaussOcrMathLiveReviewImport.createEditableReviewDraft(
        adapterEnvelope: envelope,
        userApproved: true,
        userEditedLatex: r'\int_{0}^{1} x^2\,dx',
      );

      expect(approvedDraft.decision, GaussOcrMathLiveReviewImportDecision.workspaceImportReadyAfterUserApproval);
      expect(approvedDraft.canOpenEditableMathLiveReview, isFalse);
      expect(approvedDraft.canImportToWorkspaceAfterUserApproval, isTrue);
      expect(approvedDraft.primaryCandidate!.editedByUser, isTrue);
      expect(approvedDraft.directWorkspaceImportAllowed, isFalse);
      expect(approvedDraft.directSolveAllowed, isFalse);

      final reviewDraft = GaussMathLiveOcrReviewDraft.fromQ250Import(
        capturePath: '/tmp/gauss-capture.png',
        rotationQuarterTurns: 0,
        importDraft: approvedDraft,
      );
      expect(reviewDraft.hasRealOcrCandidate, isTrue);
      expect(reviewDraft.userApprovedForWorkspaceImport, isTrue);
      expect(reviewDraft.canImportToWorkspace, isTrue);
      expect(reviewDraft.canEvaluate, isFalse);
      expect(reviewDraft.canGraph, isFalse);
      expect(reviewDraft.canWriteHistory, isFalse);
    });

    test('keeps dependencies, Android toolchain, and production runtime surfaces untouched', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec, isNot(contains('paddleocr')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(
        settings.contains("id 'com.android.application' version '8.3.2' apply false") ||
            settings.contains("id 'com.android.application' version '8.6.1' apply false"),
        isTrue,
      );
      expect(manifest, contains('android.permission.CAMERA'));
      expect(bridge, isNot(contains('runPpFormulaNetSInference')));
      expect(bridge, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
      expect(workspace, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
    });
  });
}
