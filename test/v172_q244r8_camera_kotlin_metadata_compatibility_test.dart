import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_kotlin_metadata_compatibility_policy.dart';

void main() {
  group('V172-Q244R8 camera Kotlin metadata compatibility repair', () {
    test('upgrades only Kotlin Gradle plugin for 2.1 metadata while preserving camera and protected runtime surfaces', () {
      const policy = GaussCameraKotlinMetadataCompatibilityPolicy.phase;
      expect(policy, 'V172-Q244R8-CAMERA-KOTLIN-METADATA-COMPATIBILITY-REPAIR');
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.triggeredByUserSideKotlinMetadataFailure, isTrue);
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.activeKotlinPluginVersion, '2.1.0');
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.agpVersionPreserved, '8.3.2');
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.cameraPackagePreserved, '0.10.6');
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.cameraAndroidImplementationPreserved, '0.10.9+3');
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.agpUpgradePerformed, isFalse);
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraKotlinMetadataCompatibilityPolicy.flutterRunPassClaimedByAssistant, isFalse);

      final settings = File('android/settings.gradle').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(
        settings.contains("id 'com.android.application' version '8.3.2' apply false") ||
            settings.contains("id 'com.android.application' version '8.6.1' apply false"),
        isTrue,
      );
      expect(settings, isNot(contains("org.jetbrains.kotlin.android' version '1.9.22'")));
      expect(pubspec, contains(RegExp(r'^\s*camera:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(manifest, contains('android.permission.CAMERA'));
      expect(mainActivity, contains('releaseNativeSplash'));
      expect(mainActivity, isNot(contains('maxNativeSplashVisibleMs')));
    });
  });
}
