import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_math_ocr_end_to_end_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_math_ocr_end_to_end_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_model_download_runtime.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_mathlive_review_import.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_runtime_adapter.dart';

// Q251 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3
void main() {
  group('V172-Q251 Camera Math OCR end-to-end court', () {
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

    const blockedEvidence = GaussDeferredModelArtifactEvidence(
      status: GaussDeferredModelDownloadStatus.notInstalled,
      expectedSha256: validHash,
      actualSha256: '',
      modelSizeBytes: 42 * 1024 * 1024,
      storedInPrivateAppStorage: true,
      offlineAfterInstall: false,
      mathLiveReviewRequired: true,
      directSolveAllowed: false,
      productionUrlBound: false,
      modelBinaryBundledInBaseApp: false,
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

    GaussOcrRuntimeAdapterInput inputWith(GaussDeferredModelArtifactEvidence evidence) {
      return GaussOcrRuntimeAdapterInput(
        capturePath: '/tmp/gauss-capture.png',
        cropFrameId: 'scan-frame-1',
        rotationQuarterTurns: 0,
        modelEvidence: evidence,
        preprocessProfile: 'q251-premium-crop-normalize',
        sourcePhase: GaussDeferredModelDownloadRuntime.phase,
      );
    }

    GaussCameraMathOcrEndToEndCourtInput courtInput({
      bool approved = false,
      String capturePath = '/tmp/gauss-capture.png',
      String cropFrameId = 'scan-frame-1',
      String realDeviceCaseId = 'q251-definite-integral-real-device-case',
      GaussDeferredModelArtifactEvidence? evidence,
    }) {
      final modelEvidence = evidence ?? readyEvidence;
      final adapterEnvelope = GaussOcrRuntimeAdapter.createReviewOnlyEnvelope(
        input: inputWith(modelEvidence),
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
      final reviewDraft = GaussOcrMathLiveReviewImport.createEditableReviewDraft(
        adapterEnvelope: adapterEnvelope,
        userApproved: approved,
        userEditedLatex: approved ? r'\int_{0}^{1} x^2\,dx' : null,
      );
      return GaussCameraMathOcrEndToEndCourtInput(
        capturePath: capturePath,
        cropFrameId: cropFrameId,
        adapterEnvelope: adapterEnvelope,
        reviewDraft: reviewDraft,
        realDeviceCaseId: realDeviceCaseId,
        sourcePhase: GaussOcrMathLiveReviewImport.phase,
      );
    }

    test('records Q251 as a court guard, not a real OCR or direct solve pass', () {
      expect(GaussCameraMathOcrEndToEndCourtPolicy.phase, 'V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT');
      expect(GaussCameraMathOcrEndToEndCourtPolicy.closesOverPhase, 'V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT');
      expect(GaussCameraMathOcrEndToEndCourtPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussCameraMathOcrEndToEndCourtPolicy.courtMode, contains('camera-crop-adapter-review-approval'));
      expect(GaussCameraMathOcrEndToEndCourtPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraMathOcrEndToEndCourtPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussCameraMathOcrEndToEndCourtPolicy.ppFormulaNetSModelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraMathOcrEndToEndCourtPolicy.realEndToEndOcrPassClaimed, isFalse);
      expect(GaussCameraMathOcrEndToEndCourt.allowsDirectWorkspaceImport, isFalse);
      expect(GaussCameraMathOcrEndToEndCourt.allowsDirectSolve, isFalse);
    });

    test('requires the complete camera/crop/model/adapter/review chain before review court is ready', () {
      final result = GaussCameraMathOcrEndToEndCourt.evaluate(input: courtInput());

      expect(result.decision, GaussCameraMathOcrEndToEndCourtDecision.editableReviewCourtReady);
      expect(result.canOpenEditableMathLiveReviewCourt, isTrue);
      expect(result.canPrepareWorkspaceImportCourtAfterUserApproval, isFalse);
      expect(result.canEvaluateBeforeUserApproval, isFalse);
      expect(result.canGraphBeforeUserApproval, isFalse);
      expect(result.canWriteSolutionBeforeUserApproval, isFalse);
      expect(result.canWriteHistoryBeforeUserApproval, isFalse);
    });

    test('prepares workspace import court only after explicit MathLive review approval', () {
      final result = GaussCameraMathOcrEndToEndCourt.evaluate(input: courtInput(approved: true));

      expect(result.decision, GaussCameraMathOcrEndToEndCourtDecision.workspaceImportCourtReadyAfterApproval);
      expect(result.canOpenEditableMathLiveReviewCourt, isFalse);
      expect(result.canPrepareWorkspaceImportCourtAfterUserApproval, isTrue);
      expect(result.directWorkspaceImportAllowed, isFalse);
      expect(result.directSolveAllowed, isFalse);
      expect(result.directGraphAllowed, isFalse);
      expect(result.directSolutionAllowed, isFalse);
      expect(result.directHistoryAllowed, isFalse);
    });

    test('blocks missing capture, missing crop, and not-ready model states', () {
      final missingCapture = GaussCameraMathOcrEndToEndCourt.evaluate(
        input: courtInput(capturePath: ''),
      );
      expect(missingCapture.decision, GaussCameraMathOcrEndToEndCourtDecision.blockedMissingCameraCapture);
      expect(missingCapture.canOpenEditableMathLiveReviewCourt, isFalse);

      final missingCrop = GaussCameraMathOcrEndToEndCourt.evaluate(
        input: courtInput(cropFrameId: ''),
      );
      expect(missingCrop.decision, GaussCameraMathOcrEndToEndCourtDecision.blockedMissingCropScanFrame);
      expect(missingCrop.canOpenEditableMathLiveReviewCourt, isFalse);

      final blockedModel = GaussCameraMathOcrEndToEndCourt.evaluate(
        input: courtInput(evidence: blockedEvidence),
      );
      expect(blockedModel.decision, GaussCameraMathOcrEndToEndCourtDecision.blockedModelNotReady);
      expect(blockedModel.canOpenEditableMathLiveReviewCourt, isFalse);
    });

    test('keeps required real-device court cases and blocked actions explicit', () {
      expect(GaussCameraMathOcrEndToEndCourtPolicy.requiredRealDeviceCourtCases, contains('definiteIntegral'));
      expect(GaussCameraMathOcrEndToEndCourtPolicy.requiredRealDeviceCourtCases, contains('leibnizDerivative'));
      expect(GaussCameraMathOcrEndToEndCourtPolicy.requiredRealDeviceCourtCases, contains('matrix'));
      expect(GaussCameraMathOcrEndToEndCourtPolicy.requiredRealDeviceCourtCases, contains('lowLight'));
      expect(GaussCameraMathOcrEndToEndCourt.forbiddenEndToEndActions, contains('runPpFormulaNetSInference'));
      expect(GaussCameraMathOcrEndToEndCourt.forbiddenEndToEndActions, contains('setWorkspaceLatexWithoutUserApproval'));
      expect(GaussCameraMathOcrEndToEndCourt.forbiddenEndToEndActions, contains('evaluateFromCameraBeforeApproval'));
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
      expect(workspace, isNot(contains('evaluateFromCameraBeforeApproval')));
    });
  });
}
