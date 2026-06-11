import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_androidx_agp_compatibility_policy.dart';

void main() {
  group('V172-Q244R3 camera AndroidX AGP compatibility repair', () {
    test('policy records AGP 8.3.2 safe dependency pinning without OCR runtime', () {
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.phase,
          'V172-Q244R3-CAMERA-ANDROIDX-AGP-COMPATIBILITY-REPAIR');
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.triggeredByUserSideAarMetadataFailure, isTrue);
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.projectAndroidGradlePluginVersion, '8.3.2');
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.cameraPackagePinned, '0.11.0');
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.cameraAndroidCameraXOverridePinned, '0.6.5+2');
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.avoidsAndroidxCamera153, isTrue);
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.avoidsAgp860Upgrade, isTrue);
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraAndroidxAgpCompatibilityPolicy.requiresUserSideFlutterRetest, isTrue);
    });

    test('pubspec pins camera dependencies to avoid CameraX 1.5.3 AAR metadata failure', () {
      final pubspec = File('${Directory.current.path}/pubspec.yaml').readAsStringSync();
      expect(pubspec, contains(RegExp(r'^\s*camera:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android:\s*(0\.10\.8\+18|0\.10\.9\+3)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('dependency_overrides:')));
      expect(pubspec, isNot(contains('com.android.application version "8.6.0"')));
    });

    test('repair remains camera dependency hygiene only', () {
      final cameraShell = File('${Directory.current.path}/lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final pubspec = File('${Directory.current.path}/pubspec.yaml').readAsStringSync();

      expect(cameraShell, contains('CameraController('));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(pubspec, isNot(contains('paddle')));
      expect(pubspec, isNot(contains('pix2text')));
    });
  });
}
