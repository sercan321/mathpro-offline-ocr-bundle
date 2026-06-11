import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_gate_policy.dart';

void main() {
  group('V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', () {
    const approvedInput = GaussApprovedOcrWorkspaceImportInput(
      q274OcrResultMathLiveReviewBindingPresent: true,
      q274StillNoRealInferenceNoRuntime: true,
      editableMathLiveReviewDraftRequired: true,
      reviewDraftMayBeEditedBeforeApproval: true,
      explicitUserApprovalRequired: true,
      approvedLatexDraft: r'\int_0^1 x^2\,dx',
      workspaceImportPreparedOnlyAfterUserApproval: true,
      workspaceImportMayUseApprovedLatexDraft: true,
      autoEvaluateAfterImport: false,
      autoSolveAfterImport: false,
      autoGraphAfterImport: false,
      autoSolutionAfterImport: false,
      autoHistoryAfterImport: false,
      directWorkspaceImportWithoutApprovalBlocked: true,
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
      workspaceImportRuntimePassClaimed: false,
      ocrPassClaimed: false,
      importLabel: 'Q275 approved OCR workspace import gate only',
    );

    test('prepares workspace import only after editable review and explicit approval', () {
      final result = GaussApprovedOcrWorkspaceImportGate.evaluate(approvedInput);
      expect(result.decision, GaussApprovedOcrWorkspaceImportDecision.readyForFutureApprovedWorkspaceImportOnly);
      expect(result.workspaceImportGateStaticReady, isTrue);
      expect(result.phase, GaussApprovedOcrWorkspaceImportGatePolicy.phase);
      expect(result.sourcePhase, GaussApprovedOcrWorkspaceImportGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.workspaceImportMode, contains('no-auto-solve'));
      expect(result.requiredWorkspaceImportGates, contains('explicitUserApprovalRequired'));
      expect(result.requiredWorkspaceImportGates, contains('importDoesNotAutoSolve'));
      expect(result.workspaceImportEnvelopeFields, contains('approvedLatexDraft'));
      expect(result.workspaceImportEnvelopeFields, contains('explicitUserApproved'));
      expect(result.workspaceImportFailureCodes, contains('autoSolveRiskDetected'));
      expect(result.forbiddenActions, contains('autoSolveCameraOutputAfterImport'));
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
      expect(result.workspaceImportRuntimePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canPrepareWorkspaceImportAfterApprovalInQ275, isTrue);
      expect(result.canImportWithoutUserApproval, isFalse);
      expect(result.canAutoEvaluateAfterImport, isFalse);
      expect(result.canAutoSolveAfterImport, isFalse);
      expect(result.canAutoGraphSolutionHistoryAfterImport, isFalse);
      expect(result.canClaimOcrPassInQ275, isFalse);
    });

    test('rejects empty latex, missing approval, or auto-solve risks', () {
      final unsafe = GaussApprovedOcrWorkspaceImportGate.evaluate(
        const GaussApprovedOcrWorkspaceImportInput(
          q274OcrResultMathLiveReviewBindingPresent: true,
          q274StillNoRealInferenceNoRuntime: true,
          editableMathLiveReviewDraftRequired: true,
          reviewDraftMayBeEditedBeforeApproval: true,
          explicitUserApprovalRequired: false,
          approvedLatexDraft: '',
          workspaceImportPreparedOnlyAfterUserApproval: false,
          workspaceImportMayUseApprovedLatexDraft: true,
          autoEvaluateAfterImport: true,
          autoSolveAfterImport: true,
          autoGraphAfterImport: true,
          autoSolutionAfterImport: true,
          autoHistoryAfterImport: true,
          directWorkspaceImportWithoutApprovalBlocked: false,
          directSolveBlocked: false,
          directGraphSolutionHistoryBlocked: false,
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
          workspaceImportRuntimePassClaimed: true,
          ocrPassClaimed: true,
          importLabel: 'unsafe import',
        ),
      );
      expect(unsafe.workspaceImportGateStaticReady, isFalse);
      expect(unsafe.canClaimOcrPassInQ275, isFalse);
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
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q275 must not add $forbidden');
      }
    });
  });
}
