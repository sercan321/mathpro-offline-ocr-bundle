import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('V172-Q239D deferred math OCR model manager foundation', () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
    });

    test('policy records manager scope without OCR/runtime/direct solve', () {
      expect(GaussDeferredMathOcrModelManagerPolicy.phase, 'V172-Q239D');
      expect(GaussDeferredMathOcrModelManagerPolicy.q239cCropScanFramePreserved, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.modelManagerStateContractImplemented, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.modelManifestContractImplemented, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.modelStatusPersistenceImplemented, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.wifiOnlyDefaultPrepared, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.sha256VerificationRequiredByContract, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.privateStorageInstallRequiredByContract, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.optionalModelPackArchitecturePrepared, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.cameraShellModelStatusUiImplemented, isTrue);
      expect(GaussDeferredMathOcrModelManagerPolicy.productionDownloadUrlBound, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.ocrEngineAdded, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.textOcrFallbackAdded, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.pix2TextRuntimeAdded, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.mathLiveImportImplemented, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussDeferredMathOcrModelManagerPolicy.androidRealDeviceModelManagerPassClaimedByAssistant, isFalse);
    });

    test('snapshot persists deferred-download queue state without downloading bytes', () async {
      final initial = await GaussDeferredMathOcrModelManager.load();
      expect(initial.status, GaussMathOcrModelInstallStatus.notInstalled);
      expect(initial.wifiOnly, isFalse);
      expect(initial.canRunOffline, isFalse);
      expect(initial.progress, 0);
      expect(GaussDeferredMathOcrModelManifest.productionDownloadUrlBound, isTrue);
      expect(GaussDeferredMathOcrModelManifest.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussDeferredMathOcrModelManifest.requiresSha256BeforeReady, isTrue);
      expect(GaussDeferredMathOcrModelManifest.directSolveAllowed, isFalse);

      final queued = await GaussDeferredMathOcrModelManager.queueUserApprovedNetworkPreparation();
      expect(queued.status, GaussMathOcrModelInstallStatus.queued);
      expect(queued.wifiOnly, isFalse);
      expect(queued.progress, 0);
      expect(queued.offlineAvailable, isFalse);
      expect(queued.canRunOffline, isFalse);

      final loaded = await GaussDeferredMathOcrModelManager.load();
      expect(loaded.status, GaussMathOcrModelInstallStatus.queued);
      expect(loaded.productCopy, contains('indirme'));
      expect(loaded.productCopy, contains('doğrulanmadan OCR çalıştırılmayacak'));
    });

    test('camera shell exposes model status UI but does not bind OCR/runtime/import', () {
      final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final reviewSurface = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
      final combinedCameraReview = cameraShell + reviewSurface;
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(cameraShell, contains("import 'gauss_deferred_math_ocr_model_manager.dart';"));
      expect(cameraShell, contains('GaussDeferredMathOcrModelManager.load()'));
      expect(cameraShell, contains('_installDeferredMathOcrModel'));
      expect(cameraShell, contains('GaussDeferredMathOcrModelManager.load()'));
      expect(cameraShell, contains('GaussMathLiveOcrReviewSheet'));
      expect(reviewSurface, contains('class _DeferredModelStatusCard extends StatelessWidget'));
      expect(reviewSurface, contains('Gelişmiş model yöneticisi'));
      expect(File('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart').readAsStringSync(), contains('İndirme kuyruğunda'));
      expect(
        combinedCameraReview.contains('Gerçek OCR adayı gelmeden workspace aktarımı') ||
            combinedCameraReview.contains('OCR adayı henüz hazır değil. Workspace aktarımı, çözüm ve grafik kapalı kalır.') ||
            combinedCameraReview.contains('OCR adayı yok: workspace aktarımı, çözüm ve grafik kapalı'),
        isTrue,
      );
      expect(
        combinedCameraReview.contains('Fotoğraf doğrudan çözüme gönderilmedi') ||
            combinedCameraReview.contains('OCR review akışı başlar'),
        isTrue,
      );
      expect(combinedCameraReview, isNot(contains('google_mlkit_text_recognition')));
      expect(combinedCameraReview, isNot(contains('onnxruntime')));
      expect(combinedCameraReview, isNot(contains('setLatex')));
      expect(combinedCameraReview, isNot(contains('solveFromCamera')));
      expect(combinedCameraReview, isNot(contains('evaluateFromCamera')));

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, contains(RegExp(r'^\s*shared_preferences:\s*\^2\.5\.5\s*$', multiLine: true)));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(manifest, contains('<uses-permission android:name="android.permission.CAMERA" />'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
    });
  });
}
