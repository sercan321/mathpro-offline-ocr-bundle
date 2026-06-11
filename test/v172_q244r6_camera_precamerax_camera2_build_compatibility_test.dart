import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_precamerax_camera2_build_compatibility_policy.dart';

void main() {
  group('V172-Q244R6 camera pre-CameraX Camera2 build compatibility repair', () {
    test('policy records the user-side Registrar failure repair without broad Android upgrades', () {
      expect(
        GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.phase,
        'V172-Q244R6-CAMERA-PRE-CAMERAX-CAMERA2-BUILD-COMPATIBILITY-REPAIR',
      );
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.triggeredByUserSideCameraAndroidRegistrarFailure, isTrue);
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.rejectedQ244R5CameraPackage, '0.11.0');
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.rejectedQ244R5CameraAndroidImplementation, '0.10.8+18');
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.cameraPackagePinned, '0.10.6');
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.cameraAndroidImplementationPinned, '0.10.9+3');
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.avoidsCameraAndroidCameraxTransitiveBuild, isTrue);
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.avoidsPluginRegistryRegistrarFailure, isTrue);
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.avoidsBroadAndroidBuildUpgrade, isTrue);
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraPreCameraXCamera2BuildCompatibilityPolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('pubspec pins the pre-CameraX camera line and post-Registrar Camera2 implementation', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera: 0.11.0')));
      expect(pubspec, isNot(contains('camera_android: 0.10.8+18')));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('dependency_overrides:')));
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'onnxruntime',
        'paddleocr',
        'pix2text',
        'flutter_downloader',
      ]) {
        expect(pubspec.toLowerCase(), isNot(contains(forbidden)));
      }
    });
  });
}
