import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_android_camera2_compatibility_policy.dart';

void main() {
  group('V172-Q244R4 camera Android Camera2 compatibility repair', () {
    test('policy records Camera2 opt-in without broad Android build upgrades', () {
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.phase,
          'V172-Q244R4-CAMERA-ANDROID-CAMERA2-COMPATIBILITY-REPAIR');
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.triggeredByUserSideKotlinMetadataFailure, isTrue);
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.projectAndroidGradlePluginVersion, '8.3.2');
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.projectKotlinPluginVersion, '1.9.22');
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.cameraPackagePinned, '0.11.0');
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.cameraAndroidImplementationPinned, '0.10.8+18');
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.cameraXImplementationAllowed, isFalse);
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.avoidsCameraXKotlin21Artifacts, isTrue);
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.avoidsAgp860Upgrade, isTrue);
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.avoidsKotlin210Upgrade, isTrue);
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraAndroidCamera2CompatibilityPolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('pubspec opts back into camera_android Camera2 implementation', () {
      final pubspec = File('${Directory.current.path}/pubspec.yaml').readAsStringSync();
      expect(pubspec, contains(RegExp(r'^\s*camera:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android:\s*(0\.10\.8\+18|0\.10\.9\+3)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('dependency_overrides:')));
      expect(pubspec, isNot(contains('com.android.application version "8.6.0"')));
      expect(pubspec, isNot(contains("org.jetbrains.kotlin.android' version '2.1.0")));
    });

    test('repair remains build-compatibility hygiene only', () {
      final cameraShell = File('${Directory.current.path}/lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final pubspec = File('${Directory.current.path}/pubspec.yaml').readAsStringSync();
      expect(cameraShell, contains('CameraController('));
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'onnxruntime',
        'paddle',
        'pix2text',
        'flutter_downloader',
      ]) {
        expect(pubspec.toLowerCase(), isNot(contains(forbidden)));
      }
    });
  });
}
