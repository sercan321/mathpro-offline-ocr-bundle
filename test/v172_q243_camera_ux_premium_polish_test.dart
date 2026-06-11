import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ux_premium_polish.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ux_premium_polish_policy.dart';

void main() {
  group('V172-Q243 camera UX premium polish', () {
    test('policy records visual-only premium camera scope without OCR/math mutation', () {
      expect(GaussCameraUxPremiumPolishPolicy.phase, 'V172-Q243');
      expect(GaussCameraUxPremiumPolishPolicy.fullPhase, 'V172-Q243-CAMERA-UX-PREMIUM-POLISH');
      expect(GaussCameraUxPremiumPolishPolicy.q242OfflineModeGuardPreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.q241WinnerEngineAdapterPreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.q239eMathLiveReviewSurfacePreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.q239cCropScanFramePreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.cameraUxPremiumPolishImplemented, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.premiumFocusQualityRailImplemented, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.lowLightGuidanceCopyImplemented, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.blurGuidanceCopyImplemented, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.alignmentGuidanceCopyImplemented, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.cropReviewConfidenceCopyImplemented, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.captureControlHierarchyPreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.retakeRotateUseFrameControlsPreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.mathLiveReviewOnlyCopyPreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.noDirectCameraToMathActionPolicyPreserved, isTrue);
      expect(GaussCameraUxPremiumPolishPolicy.realOcrEngineAdded, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.textOcrFallbackAdded, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.pix2TextRuntimeAdded, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.productionMathLiveBridgeCalled, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussCameraUxPremiumPolishPolicy.androidRealDeviceCameraUxPassClaimedByAssistant, isFalse);
    });

    test('contract exposes premium guidance copy and blocks direct math actions', () {
      expect(GaussCameraUxPremiumPolishContract.phase, 'V172-Q243');
      expect(GaussCameraUxPremiumPolishContract.previewHeaderCopy, 'Formülü kadraja al');
      expect(GaussCameraUxPremiumPolishContract.cropHeaderCopy, 'Kalite kontrolü');
      expect(GaussCameraUxPremiumPolishContract.lowLightWarningCopy, contains('Işık'));
      expect(GaussCameraUxPremiumPolishContract.blurWarningCopy, contains('Bulanıklık'));
      expect(GaussCameraUxPremiumPolishContract.alignmentWarningCopy, contains('paralel'));
      expect(GaussCameraUxPremiumPolishContract.qualityRailLabels, contains('Netlik'));
      expect(GaussCameraUxPremiumPolishContract.qualityRailLabels, contains('Işık'));
      expect(GaussCameraUxPremiumPolishContract.qualityRailLabels, contains('Hizalama'));
      expect(GaussCameraUxPremiumPolishContract.exposesPremiumGuidanceOnly, isTrue);
      expect(GaussCameraUxPremiumPolishContract.blocksDirectMathActions, isTrue);
      expect(GaussCameraUxPremiumPolishContract.preservesMathLiveReviewOnlyFlow, isTrue);
      expect(GaussCameraUxPremiumPolishContract.keepsCameraRuntimeCaptureOnly, isTrue);
      expect(GaussCameraUxPremiumPolishContract.realOcrEngineAdded, isFalse);
      expect(GaussCameraUxPremiumPolishContract.directSolveFromCameraAllowed, isFalse);
    });

    test('camera shell has premium guidance widgets without OCR/runtime dependencies', () {
      final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final mathLiveProd = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();

      expect(cameraShell, contains("import 'gauss_camera_ux_premium_polish.dart';"));
      expect(cameraShell, contains('class _CameraUxQualityRail extends StatelessWidget'));
      expect(cameraShell, contains('class _CameraQualityChipRow extends StatelessWidget'));
      expect(cameraShell, contains('class _CameraQualityChip extends StatelessWidget'));
      expect(cameraShell, contains('class _CameraUxCompactQualityPill extends StatelessWidget'));
      expect(cameraShell, contains('GaussCameraUxPremiumPolishContract.previewHeaderCopy'));
      expect(cameraShell, contains('GaussCameraUxPremiumPolishContract.previewBodyCopy'));
      expect(cameraShell, contains('GaussCameraUxPremiumPolishContract.cropHeaderCopy'));
      expect(cameraShell, contains('GaussCameraUxPremiumPolishContract.cropBodyCopy'));
      expect(cameraShell, contains('qualityRailLabels'));
      expect(cameraShell, contains('qualityRailHints'));
      expect(
        cameraShell.contains('Formülü çerçeve içine al. Bu ekran sadece fotoğraf yakalar; OCR sonraki fazda.') ||
            cameraShell.contains('Formülü çerçeve içine al. Çerçeveyi kullanınca OCR review akışı başlar.'),
        isTrue,
      );
      expect(cameraShell, contains('GaussMathLiveOcrReviewSheet'));
      expect(cameraShell, isNot(contains('google_mlkit_text_recognition')));
      expect(cameraShell, isNot(contains('onnxruntime')));
      expect(cameraShell, isNot(contains('MathLiveProductionEditorSurface')));
      expect(cameraShell, isNot(contains('setLatex')));
      expect(cameraShell, isNot(contains('solveFromCamera')));

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, contains(RegExp(r'^\s*shared_preferences:\s*\^2\.5\.5\s*$', multiLine: true)));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*pix2text\s*:', multiLine: true))));
      expect(manifest, contains('<uses-permission android:name="android.permission.CAMERA" />'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
      expect(mathLiveProd, contains('class MathLiveProductionEditorSurface'));
    });
  });
}
