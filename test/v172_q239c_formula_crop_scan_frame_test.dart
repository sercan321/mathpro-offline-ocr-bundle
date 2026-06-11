import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_formula_crop_scan_frame_policy.dart';

void main() {
  group('V172-Q239C formula crop / scan frame shell', () {
    test('policy records crop review scope without OCR/model/solver mutation', () {
      expect(GaussFormulaCropScanFramePolicy.phase, 'V172-Q239C');
      expect(GaussFormulaCropScanFramePolicy.q239bCaptureShellPreserved, isTrue);
      expect(GaussFormulaCropScanFramePolicy.premiumFormulaCropReviewImplemented, isTrue);
      expect(GaussFormulaCropScanFramePolicy.capturedPhotoPreviewImplemented, isTrue);
      expect(GaussFormulaCropScanFramePolicy.boundedFormulaScanFrameImplemented, isTrue);
      expect(GaussFormulaCropScanFramePolicy.retakeControlImplemented, isTrue);
      expect(GaussFormulaCropScanFramePolicy.rotateControlImplemented, isTrue);
      expect(GaussFormulaCropScanFramePolicy.useFrameControlImplemented, isTrue);
      expect(GaussFormulaCropScanFramePolicy.cropMetadataPreparedForFuturePreprocess, isTrue);
      expect(GaussFormulaCropScanFramePolicy.actualImageCropFileWritten, isFalse);
      expect(GaussFormulaCropScanFramePolicy.galleryImportImplemented, isFalse);
      expect(GaussFormulaCropScanFramePolicy.normalizedFrameWidth, 0.78);
      expect(GaussFormulaCropScanFramePolicy.normalizedFrameHeight, 0.34);
      expect(GaussFormulaCropScanFramePolicy.ocrEngineAdded, isFalse);
      expect(GaussFormulaCropScanFramePolicy.textOcrFallbackAdded, isFalse);
      expect(GaussFormulaCropScanFramePolicy.paddleOcrAdded, isFalse);
      expect(GaussFormulaCropScanFramePolicy.pix2TextAdded, isFalse);
      expect(GaussFormulaCropScanFramePolicy.onnxRuntimeAdded, isFalse);
      expect(GaussFormulaCropScanFramePolicy.deferredModelDownloadImplemented, isFalse);
      expect(GaussFormulaCropScanFramePolicy.mathLiveImportImplemented, isFalse);
      expect(GaussFormulaCropScanFramePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussFormulaCropScanFramePolicy.keyboardMutationAllowed, isFalse);
      expect(GaussFormulaCropScanFramePolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussFormulaCropScanFramePolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussFormulaCropScanFramePolicy.androidRealDeviceCropPassClaimedByAssistant, isFalse);
    });

    test('capture shell opens a crop review surface after taking a photo', () {
      final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final reviewSurface = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
      final combinedCameraReview = cameraShell + reviewSurface;
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(cameraShell, contains("import 'dart:io';"));
      expect(cameraShell, contains('GaussFormulaCropScanFramePolicy'));
      expect(cameraShell, contains("ValueKey('mathpro-formula-crop-review-card')"));
      expect(cameraShell, contains('class _FormulaCropReviewCard extends StatelessWidget'));
      expect(cameraShell, contains('Image.file('));
      expect(cameraShell, contains('File(capturePath)'));
      expect(cameraShell, contains('class _FormulaCropFrameOverlay extends StatelessWidget'));
      expect(cameraShell, contains('GaussFormulaCropScanFramePolicy.normalizedFrameWidth'));
      expect(cameraShell, contains('GaussFormulaCropScanFramePolicy.normalizedFrameHeight'));
      expect(cameraShell, contains('class _FormulaCropReviewControls extends StatelessWidget'));
      expect(cameraShell, contains("tooltip: 'Tekrar çek'"));
      expect(cameraShell, contains("tooltip: 'Döndür'"));
      expect(cameraShell, contains("label: 'Kırpma çerçevesini kullan'"));
      expect(cameraShell, contains('GaussMathLiveOcrReviewSheet'));
      expect(
        combinedCameraReview.contains('MathLive review hazırlandı') ||
            combinedCameraReview.contains('MathLive OCR review'),
        isTrue,
      );
      expect(
        combinedCameraReview.contains('Fotoğraf doğrudan çözüme gönderilmedi') ||
            combinedCameraReview.contains('OCR review akışı başlar'),
        isTrue,
      );
      expect(
        combinedCameraReview.contains('OCR sonraki fazda') ||
            combinedCameraReview.contains('OCR review akışı başlar') ||
            combinedCameraReview.contains('OCR adayı henüz hazır değil') ||
            combinedCameraReview.contains('OCR adayı yok: workspace aktarımı, çözüm ve grafik kapalı'),
        isTrue,
      );
      expect(
        combinedCameraReview.contains('MathLive düzenleme adayı') ||
            combinedCameraReview.contains('Düzenlenebilir OCR adayı'),
        isTrue,
      );
      expect(combinedCameraReview, isNot(contains('google_mlkit_text_recognition')));
      expect(combinedCameraReview, isNot(contains('MathLiveProductionEditorSurface')));
      expect(combinedCameraReview, isNot(contains('SolutionStepsPanel')));

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*pix2text\s*:', multiLine: true))));
      expect(manifest, contains('<uses-permission android:name="android.permission.CAMERA" />'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
    });
  });
}
