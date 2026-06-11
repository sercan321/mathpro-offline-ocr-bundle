import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_successor_test_metadata_hygiene_policy.dart';

void main() {
  group('V172-Q244R7 camera successor test metadata hygiene repair', () {
    test('policy records stale camera test expectation repair without runtime mutation', () {
      expect(
        GaussCameraSuccessorTestMetadataHygienePolicy.phase,
        'V172-Q244R7-CAMERA-SUCCESSOR-TEST-METADATA-HYGIENE-REPAIR',
      );
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.triggeredByUserSideFlutterTestStaleCameraExpectation, isTrue);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.staleExpectedCameraPackage, '0.11.0');
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.activeCameraPackage, '0.10.6');
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.activeCameraAndroidImplementation, '0.10.9+3');
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.acceptsQ239CameraFoundationOriginalPackage, isTrue);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.acceptsQ244R6PreCameraXSuccessorPackage, isTrue);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.forbidsCameraAndroidCamerax, isTrue);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.runtimeCameraShellChanged, isFalse);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.pubspecChanged, isFalse);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.androidBuildFilesChanged, isFalse);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraSuccessorTestMetadataHygienePolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('stale tests accept the Q244R6 pre-CameraX successor package and block CameraX', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final testFiles = <String>[
        'test/v172_q239a_workspace_camera_entry_button_test.dart',
        'test/v172_q239b_camera_permission_capture_shell_test.dart',
        'test/v172_q239c_formula_crop_scan_frame_test.dart',
        'test/v172_q239d_deferred_math_ocr_model_manager_test.dart',
        'test/v172_q239e_mathlive_ocr_review_surface_test.dart',
        'test/v172_q240_ocr_engine_benchmark_court_test.dart',
        'test/v172_q243_camera_ux_premium_polish_test.dart',
      ];

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      for (final rel in testFiles) {
        final source = File(rel).readAsStringSync();
        expect(source, contains('0\\.11\\.0|0\\.10\\.6'), reason: rel);
        expect(source, contains("isNot(contains('camera_android_camerax'))"), reason: rel);
        expect(source, isNot(contains("RegExp(r'^\\s*camera:\\s*\\^?0\\.11\\.0\\s*'")), reason: rel);
      }
    });
  });
}
