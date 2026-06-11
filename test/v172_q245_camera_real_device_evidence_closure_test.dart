import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_real_device_evidence_closure_policy.dart';

void main() {
  group('V172-Q245 camera real device evidence closure', () {
    test('records Q244R8 user-side device evidence without claiming assistant-side Flutter or Android PASS', () {
      expect(
        GaussCameraRealDeviceEvidenceClosurePolicy.phase,
        'V172-Q245-CAMERA-REAL-DEVICE-EVIDENCE-CLOSURE',
      );
      expect(
        GaussCameraRealDeviceEvidenceClosurePolicy.closesOverPackagePhase,
        'V172-Q244R8-CAMERA-KOTLIN-METADATA-COMPATIBILITY-REPAIR',
      );
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.expectedSourcePackageSha256, hasLength(64));
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.userReportedFlutterRunOpenedApp, isTrue);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.userReportedDeviceId, '23106RN0DA');
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.userReportedCameraButtonVisible, isTrue);
      expect(
        GaussCameraRealDeviceEvidenceClosurePolicy.userReportedKeyboardMoreLongPressGraphSolutionHistoryIntact,
        isTrue,
      );
      expect(
        GaussCameraRealDeviceEvidenceClosurePolicy.userReportedCameraPermissionPreviewCaptureCropReviewFoundationWorking,
        isTrue,
      );
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.assistantVerifiedFlutterAnalyzePass, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.assistantVerifiedFlutterTestPass, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.assistantVerifiedFlutterRunPass, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.assistantVerifiedAndroidRealDeviceCameraPass, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.assistantVerifiedOcrPass, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.evidenceClosureOnly, isTrue);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.runtimeBehaviorChanged, isFalse);
    });

    test('preserves Q244R8 camera dependency/toolchain state and keeps OCR/direct-solve gates closed', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*paddle', multiLine: true))));
      expect(pubspec, isNot(contains('pix2text')));

      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(
        settings.contains("id 'com.android.application' version '8.3.2' apply false") ||
            settings.contains("id 'com.android.application' version '8.6.1' apply false"),
        isTrue,
      );
      expect(manifest, contains('android.permission.CAMERA'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
      expect(mainActivity, contains('releaseNativeSplash'));
      expect(mainActivity, isNot(contains('maxNativeSplashVisibleMs')));

      expect(GaussCameraRealDeviceEvidenceClosurePolicy.cameraDependencyChanged, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.androidSettingsGradleChanged, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.textOcrFallbackRuntimeAdded, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.mathLiveProductionBridgeCalled, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.mathLiveEditableReviewRequiredBeforeImport, isTrue);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.q239aVerifierSuccessorHygieneOnly, isTrue);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.q239aVerifierRuntimeBehaviorChanged, isFalse);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.q240BenchmarkVerifierSuccessorHygieneOnly, isTrue);
      expect(GaussCameraRealDeviceEvidenceClosurePolicy.q240BenchmarkVerifierRuntimeBehaviorChanged, isFalse);
    });
  });
}
