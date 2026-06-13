import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_real_end_to_end_device_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_real_end_to_end_device_court_policy.dart';

void main() {
  group('V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', () {
    const validInput = GaussCameraOcrRealEndToEndDeviceCourtInput(
      q275ApprovedOcrWorkspaceImportGatePresent: true,
      cameraCaptureEvidenceAvailable: true,
      cropScanFrameEvidenceAvailable: true,
      q273ImageToLatexCandidateEnvelopeAvailable: true,
      q274MathLiveReviewBindingAvailable: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      autoEvaluateAfterImport: false,
      autoSolveAfterImport: false,
      autoGraphAfterImport: false,
      autoSolutionAfterImport: false,
      autoHistoryAfterImport: false,
      directCameraSolveBlocked: true,
      directCameraGraphSolutionHistoryBlocked: true,
      requiredCaseCount: 15,
      realOcrRuntimeAdded: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      nativeBridgeImplementationAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      realNetworkDownloadWorkerImplemented: false,
      productionDownloadEnabled: false,
      productionInferenceAllowed: false,
      realImageToLatexInferenceExecuted: false,
      realEndToEndDeviceCourtPassClaimed: false,
      ocrPassClaimed: false,
    );

    test('keeps the real device court as a gate-only package without OCR PASS', () {
      final result = GaussCameraOcrRealEndToEndDeviceCourt.evaluate(validInput);
      expect(result.decision, GaussCameraOcrRealEndToEndDeviceCourtDecision.readyForFutureRealDeviceCourtOnly);
      expect(result.staticReadyForFutureCourtOnly, isTrue);
      expect(result.phase, GaussCameraOcrRealEndToEndDeviceCourtPolicy.phase);
      expect(result.sourcePhase, GaussCameraOcrRealEndToEndDeviceCourtPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.requiredRealDeviceCourtCases, contains('definiteIntegral_zero_to_one_x_squared_dx'));
      expect(result.requiredRealDeviceCourtCases, contains('lowLightCapture'));
      expect(result.requiredRealDeviceCourtCases.length, greaterThanOrEqualTo(15));
      expect(result.requiredCourtGates, contains('directCameraSolveBlocked'));
      expect(result.courtEvidenceFields, contains('flutterRunLogReference'));
      expect(result.forbiddenActions, contains('claimOcrPassWithoutRealInferenceEvidence'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.realEndToEndDeviceCourtPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('blocks direct solve or auto action risks', () {
      final result = GaussCameraOcrRealEndToEndDeviceCourt.evaluate(const GaussCameraOcrRealEndToEndDeviceCourtInput(
        q275ApprovedOcrWorkspaceImportGatePresent: true,
        cameraCaptureEvidenceAvailable: true,
        cropScanFrameEvidenceAvailable: true,
        q273ImageToLatexCandidateEnvelopeAvailable: true,
        q274MathLiveReviewBindingAvailable: true,
        editableMathLiveReviewRequired: true,
        explicitUserApprovalRequiredBeforeWorkspaceImport: true,
        autoEvaluateAfterImport: false,
        autoSolveAfterImport: true,
        autoGraphAfterImport: false,
        autoSolutionAfterImport: false,
        autoHistoryAfterImport: false,
        directCameraSolveBlocked: true,
        directCameraGraphSolutionHistoryBlocked: true,
        requiredCaseCount: 15,
        realOcrRuntimeAdded: false,
        paddleRuntimeAdded: false,
        paddleOcrDependencyAdded: false,
        nativeBridgeImplementationAdded: false,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: false,
        modelBinaryBundledInBaseApp: false,
        productionModelUrlBound: false,
        realNetworkDownloadWorkerImplemented: false,
        productionDownloadEnabled: false,
        productionInferenceAllowed: false,
        realImageToLatexInferenceExecuted: false,
        realEndToEndDeviceCourtPassClaimed: false,
        ocrPassClaimed: false,
      ));
      expect(result.decision, GaussCameraOcrRealEndToEndDeviceCourtDecision.blockedAutoEvaluateSolveOrGraphRisk);
    });

    test('does not add forbidden runtime dependencies or bundled models', () {
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
      expect(pubspec.contains('paddle'), isFalse);
      expect(pubspec.contains('onnx'), isFalse);
      expect(pubspec.contains('google_mlkit_text_recognition'), isFalse);
      expect(pubspec.contains('tesseract'), isFalse);
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      expect(manifest, contains('V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT'));
      expect(manifest, contains('realEndToEndDeviceCourtPassClaimed'));
    });
  });
}
