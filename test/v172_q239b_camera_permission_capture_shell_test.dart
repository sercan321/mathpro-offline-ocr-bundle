import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_permission_capture_shell_policy.dart';

void main() {
  group('V172-Q239B camera permission + capture shell', () {
    test('policy records capture-only camera scope without fake PASS claims', () {
      expect(GaussCameraPermissionCaptureShellPolicy.phase, 'V172-Q239B');
      expect(GaussCameraPermissionCaptureShellPolicy.workspaceCameraButtonRoutesToCaptureShell, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.q239aTopActionSlotPreserved, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.premiumCameraShellImplemented, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.officialFlutterCameraPackageDeclared, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.androidCameraPermissionDeclared, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.androidCameraFeatureOptional, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.cameraPreviewImplemented, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.stillPhotoCaptureImplemented, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.captureResultHeldForFutureReviewOnly, isTrue);
      expect(GaussCameraPermissionCaptureShellPolicy.cropImplemented, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.ocrEngineAdded, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.textOcrFallbackAdded, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.paddleOcrAdded, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.pix2TextAdded, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.deferredModelDownloadImplemented, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.mathLiveImportImplemented, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussCameraPermissionCaptureShellPolicy.androidRealDeviceCameraPassClaimedByAssistant, isFalse);
    });

    test('workspace button opens capture shell and no OCR/model dependency is introduced', () {
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
      final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(workspace, contains("ValueKey('mathpro-workspace-camera-entry-button')"));
      expect(workspace, contains('Icons.photo_camera_outlined'));
      expect(workspace, contains('GaussCameraCaptureShell'));
      expect(
        workspace.contains('_openCameraCaptureShell(context)') ||
            workspace.contains('_openCameraCaptureShell(\n            context,'),
        isTrue,
      );
      expect(workspace, isNot(contains("ValueKey('mathpro-more-placeholder-button')")));
      expect(
        !workspace.contains('Icons.more_horiz_rounded') ||
            workspace.contains("ValueKey('mathpro-q382-expression-context-menu-safe-hit-zone')"),
        isTrue,
      );

      expect(cameraShell, contains('class GaussCameraCaptureShell extends StatefulWidget'));
      expect(cameraShell, contains('availableCameras()'));
      expect(cameraShell, contains('CameraController('));
      expect(cameraShell, contains('CameraPreview(readyController)'));
      expect(cameraShell, contains('takePicture()'));
      expect(
        cameraShell.contains('Fotoğraf doğrudan çözüme gönderilmedi') ||
            cameraShell.contains('OCR review akışı başlar'),
        isTrue,
      );
      expect(cameraShell, isNot(contains('MathLiveProductionEditorSurface')));
      expect(cameraShell, isNot(contains('SolutionStepsPanel')));

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*pix2text\s*:', multiLine: true))));

      expect(manifest, contains('<uses-permission android:name="android.permission.CAMERA" />'));
      expect(manifest, contains('<uses-feature android:name="android.hardware.camera.any" android:required="false" />'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
    });
  });
}
