import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_android_camera2_published_version_hygiene_policy.dart';

void main() {
  group('V172-Q244R5 camera Android Camera2 published version hygiene repair', () {
    test('policy records the user-side pub version solve repair without broad Android upgrades', () {
      expect(
        GaussCameraAndroidCamera2PublishedVersionHygienePolicy.phase,
        'V172-Q244R5-CAMERA-ANDROID-CAMERA2-PUBLISHED-VERSION-HYGIENE-REPAIR',
      );
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.triggeredByUserSidePubVersionSolveFailure, isTrue);
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.invalidCameraAndroidVersionRejected, '0.10.8+11');
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.cameraPackagePinned, '0.11.0');
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.cameraAndroidImplementationPinned, '0.10.8+18');
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.cameraXImplementationAllowed, isFalse);
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.dependencyOverridesAllowed, isFalse);
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.agpUpgradePerformed, isFalse);
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.kotlinUpgradePerformed, isFalse);
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.ocrRuntimeAdded, isFalse);
      expect(GaussCameraAndroidCamera2PublishedVersionHygienePolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('pubspec uses the published Camera2 implementation version and rejects the invalid Q244R4 version', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*(0\.10\.8\+18|0\.10\.9\+3)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android: 0.10.8+11')));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('dependency_overrides:')));
      expect(pubspec.toLowerCase(), isNot(contains('paddleocr')));
      expect(pubspec.toLowerCase(), isNot(contains('pix2text')));
      expect(pubspec.toLowerCase(), isNot(contains('onnxruntime')));
      expect(pubspec.toLowerCase(), isNot(contains('google_mlkit_text_recognition')));
    });
  });
}
