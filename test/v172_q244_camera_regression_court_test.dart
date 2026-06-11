import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_regression_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_regression_court_policy.dart';

void main() {
  group('V172-Q244 camera regression court', () {
    test('policy records regression-only camera scope without OCR/runtime mutation', () {
      expect(GaussCameraRegressionCourtPolicy.phase, 'V172-Q244');
      expect(GaussCameraRegressionCourtPolicy.fullPhase, 'V172-Q244-CAMERA-REGRESSION-COURT');
      expect(GaussCameraRegressionCourtPolicy.q243CameraUxPremiumPolishPreserved, isTrue);
      expect(GaussCameraRegressionCourtPolicy.q242OfflineModeGuardPreserved, isTrue);
      expect(GaussCameraRegressionCourtPolicy.q241WinnerEngineAdapterPreserved, isTrue);
      expect(GaussCameraRegressionCourtPolicy.q239aWorkspaceCameraButtonPreserved, isTrue);
      expect(GaussCameraRegressionCourtPolicy.regressionCourtImplemented, isTrue);
      expect(GaussCameraRegressionCourtPolicy.cameraPipelineBoundaryLocked, isTrue);
      expect(GaussCameraRegressionCourtPolicy.noDirectCameraMathActionCourtImplemented, isTrue);
      expect(GaussCameraRegressionCourtPolicy.redLineSurfaceCourtImplemented, isTrue);
      expect(GaussCameraRegressionCourtPolicy.dependencyAndAssetCourtImplemented, isTrue);
      expect(GaussCameraRegressionCourtPolicy.realOcrEngineAdded, isFalse);
      expect(GaussCameraRegressionCourtPolicy.textOcrFallbackAdded, isFalse);
      expect(GaussCameraRegressionCourtPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussCameraRegressionCourtPolicy.pix2TextRuntimeAdded, isFalse);
      expect(GaussCameraRegressionCourtPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussCameraRegressionCourtPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraRegressionCourtPolicy.productionModelUrlBound, isFalse);
      expect(GaussCameraRegressionCourtPolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussCameraRegressionCourtPolicy.productionMathLiveBridgeCalled, isFalse);
      expect(GaussCameraRegressionCourtPolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussCameraRegressionCourtPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.graphFromCameraAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.historyWriteFromCameraAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.solutionFromCameraAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.splashMutationAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussCameraRegressionCourtPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(GaussCameraRegressionCourtPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(GaussCameraRegressionCourtPolicy.flutterRunPassClaimedByAssistant, isFalse);
    });

    test('static court passes all package-side camera foundation checkpoints', () {
      final verdict = GaussCameraRegressionCourt.runStaticCourt();

      expect(verdict.phase, GaussCameraRegressionCourtPolicy.fullPhase);
      expect(verdict.staticCourtPassed, isTrue);
      expect(verdict.hasBlockingFailure, isFalse);
      expect(verdict.blockingFailureCodes, isEmpty);
      expect(verdict.realFlutterAndAndroidRetestRequired, isTrue);
      expect(verdict.realOcrEngineRuntimeBound, isFalse);
      expect(verdict.directCameraMathActionAllowed, isFalse);
      expect(verdict.checkpoints.length, greaterThanOrEqualTo(15));
    });

    test('source files keep Q244 regression markers and no forbidden runtime dependency', () {
      final root = Directory.current;
      final policy = File('${root.path}/lib/features/camera/gauss_camera_regression_court_policy.dart').readAsStringSync();
      final court = File('${root.path}/lib/features/camera/gauss_camera_regression_court.dart').readAsStringSync();
      final pubspec = File('${root.path}/pubspec.yaml').readAsStringSync();
      final androidManifest = File('${root.path}/android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(policy, contains('V172-Q244-CAMERA-REGRESSION-COURT'));
      expect(policy, contains('forbiddenCameraRegressionActions'));
      expect(court, contains('runStaticCourt'));
      expect(court, contains('redLineSurfacesLocked'));
      expect(court, contains('noRuntimeEngineOrModelAdded'));
      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(pubspec, isNot(contains('flutter_downloader')));
      expect(androidManifest, contains('<uses-permission android:name="android.permission.CAMERA" />'));
      expect(androidManifest, contains('android.permission.INTERNET')); // Q384R1 download-only model installer requires user-tapped network access.
    });
  });
}
