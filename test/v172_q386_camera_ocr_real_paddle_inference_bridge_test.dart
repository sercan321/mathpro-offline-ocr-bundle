import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_real_paddle_inference_bridge_q386.dart';

void main() {
  group('V172-Q386 real Paddle OCR inference bridge', () {
    test('policy opens native Paddle inference attempt but preserves review-first safety', () {
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.phase, 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE');
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.nativeBridgeMethod, 'realPaddleOcrInferenceBridgeQ386');
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.nativePaddleRuntimeLoadAttemptEnabled, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.paddlePredictorModelLoadAttemptEnabled, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.cameraImageDecodeAttemptEnabled, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.adaptiveTensorPreprocessAttemptEnabled, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.paddlePredictorRunAttemptEnabled, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.outputDecoderReuseQ380, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.reviewRequiredBeforeWorkspaceImport, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.explicitUserApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.directWorkspaceImportBlocked, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.directSolveGraphSolutionHistoryBlocked, isTrue);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.fakeLatexCandidateAllowed, isFalse);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.productionInferencePassClaimedByQ386, isFalse);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.androidRealDevicePassClaimedByQ386, isFalse);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.keyboardQ382Touched, isFalse);
      expect(GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.graphHistorySolutionSolverTouched, isFalse);
    });

    test('manifest records Q386 without claiming OCR pass', () {
      final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
      expect(manifest['cameraOcrRealPaddleInferenceBridgeLatestPhase'], GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.phase);
      final q386 = manifest['v172Q386CameraOcrRealPaddleInferenceBridge'] as Map<String, dynamic>;
      expect(q386['phase'], GaussCameraOcrRealPaddleInferenceBridgeQ386Policy.phase);
      expect(q386['nativePaddleRuntimeLoadAttemptEnabled'], isTrue);
      expect(q386['paddlePredictorRunAttemptEnabled'], isTrue);
      expect(q386['fakeLatexCandidateAllowed'], isFalse);
      expect(q386['directWorkspaceImportBlocked'], isTrue);
      expect(q386['ocrPassClaimedByPackage'], isFalse);
      expect(q386['androidRealDevicePassClaimedByPackage'], isFalse);
    });

    test('native bridge wires Q386 into Q380/Q381 review flow without ONNX or auto-import', () {
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
      expect(mainActivity, contains('q386RealPaddleOcrInferenceBridge'));
      expect(mainActivity, contains('realPaddleOcrInferenceBridgeQ386'));
      expect(mainActivity, contains('q380-q386-real-paddle-inference-bridge'));
      expect(mainActivity, contains('System.loadLibrary(q346PaddleLiteNativeLibraryName)'));
      expect(mainActivity, contains('setModelFromFile'));
      expect(mainActivity, contains('q380BuildImageTensorValues'));
      expect(mainActivity, contains('q380DecodeLogitOrTokenOutputs'));
      expect(mainActivity, contains('q386-paddle-lite-model-load-failed-or-artifact-format-incompatible'));
      expect(mainActivity, contains('productionInferenceClaimedByQ386" to false'));
      expect(mainActivity, contains('workspaceImportAutoExecuted" to false'));
      expect(mainActivity, contains('directOcrToSolveGraphSolutionHistoryBlocked" to true'));
    });
  });
}
