import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_mathlive_real_review_binding.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_result_mathlive_real_review_binding_policy.dart';

void main() {
  group('V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', () {
    const approvedInput = GaussOcrResultMathLiveRealReviewBindingInput(
      q273ImageToLatexPrototypeGatePresent: true,
      q273StillNoRealInferenceNoRuntime: true,
      candidateEnvelopeAccepted: true,
      primaryLatexCandidatePreserved: true,
      alternativeCandidatesPreserved: true,
      confidenceWarningsEngineMetadataPreserved: true,
      imageHashCropBoundsPreprocessMetadataPreserved: true,
      editableMathLiveReviewRequired: true,
      reviewDraftMayBeEditedBeforeImport: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      workspaceImportPreparedOnlyAfterUserApproval: true,
      directWorkspaceImportBlocked: true,
      directSolveBlocked: true,
      directGraphSolutionHistoryBlocked: true,
      noPaddleRuntimeAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      noRealImageToLatexInferenceExecuted: true,
      reviewBindingPassClaimed: false,
      ocrPassClaimed: false,
      bindingLabel: 'Q274 ready for future editable MathLive review binding only',
    );

    test('binds OCR candidate envelope to editable MathLive review without direct import', () {
      final result = GaussOcrResultMathLiveRealReviewBinding.evaluate(approvedInput);
      expect(result.decision, GaussOcrResultMathLiveRealReviewBindingDecision.readyForFutureMathLiveReviewBindingOnly);
      expect(result.reviewBindingStaticReady, isTrue);
      expect(result.phase, GaussOcrResultMathLiveRealReviewBindingPolicy.phase);
      expect(result.sourcePhase, GaussOcrResultMathLiveRealReviewBindingPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.reviewBindingMode, contains('no-real-inference'));
      expect(result.requiredReviewBindingGates, contains('candidateEnvelopeAccepted'));
      expect(result.requiredReviewBindingGates, contains('workspaceImportPreparedOnlyAfterUserApproval'));
      expect(result.reviewDraftEnvelopeFields, contains('editableLatexDraft'));
      expect(result.reviewDraftEnvelopeFields, contains('workspaceImportPrepared'));
      expect(result.reviewBindingFailureCodes, contains('directWorkspaceImportRiskDetected'));
      expect(result.forbiddenActions, contains('importCameraOutputWithoutUserApproval'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeImplementationAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeFeatureFlagDefaultOff, isTrue);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.reviewBindingPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canBindToMathLiveReviewInQ274, isTrue);
      expect(result.canImportWorkspaceWithoutUserApproval, isFalse);
      expect(result.canClaimOcrPassInQ274, isFalse);
    });

    test('rejects direct workspace import or unsafe OCR pass claims', () {
      final unsafe = GaussOcrResultMathLiveRealReviewBinding.evaluate(
        const GaussOcrResultMathLiveRealReviewBindingInput(
          q273ImageToLatexPrototypeGatePresent: true,
          q273StillNoRealInferenceNoRuntime: true,
          candidateEnvelopeAccepted: true,
          primaryLatexCandidatePreserved: true,
          alternativeCandidatesPreserved: true,
          confidenceWarningsEngineMetadataPreserved: true,
          imageHashCropBoundsPreprocessMetadataPreserved: true,
          editableMathLiveReviewRequired: true,
          reviewDraftMayBeEditedBeforeImport: true,
          userApprovalRequiredBeforeWorkspaceImport: true,
          workspaceImportPreparedOnlyAfterUserApproval: false,
          directWorkspaceImportBlocked: false,
          directSolveBlocked: true,
          directGraphSolutionHistoryBlocked: true,
          noPaddleRuntimeAdded: true,
          noPaddleOcrDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noRealNetworkDownloadWorkerImplemented: true,
          productionDownloadEnabled: false,
          noProductionInferenceAllowed: true,
          noRealImageToLatexInferenceExecuted: true,
          reviewBindingPassClaimed: true,
          ocrPassClaimed: true,
          bindingLabel: 'unsafe direct import claim',
        ),
      );
      expect(unsafe.reviewBindingStaticReady, isFalse);
      expect(unsafe.canClaimOcrPassInQ274, isFalse);
    });

    test('keeps runtime dependencies out of the package', () {
      final pubspec = String.fromCharCodes(File('pubspec.yaml').readAsBytesSync()).toLowerCase();
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'paddleocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'tesseract',
        'pix2text',
        'flutter_downloader',
        'background_downloader',
        'dio',
      ]) {
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q274 must not add $forbidden');
      }
    });
  });
}
