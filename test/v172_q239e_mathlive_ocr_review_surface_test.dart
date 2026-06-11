import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_mathlive_ocr_review_surface.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_mathlive_ocr_review_surface_policy.dart';

void main() {
  group('V172-Q239E MathLive OCR review surface foundation', () {
    test('policy records review-only scope without OCR/import/direct solve', () {
      expect(GaussMathLiveOcrReviewSurfacePolicy.phase, 'V172-Q239E');
      expect(GaussMathLiveOcrReviewSurfacePolicy.q239dDeferredModelManagerPreserved, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.q239cCropScanFramePreserved, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.mathLiveOcrReviewSurfaceImplemented, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.ocrCandidateContractPrepared, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.candidateListPrepared, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.editableReviewRequiredBeforeWorkspaceImport, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.reviewSurfaceReceivesCaptureMetadata, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.reviewSurfaceShowsModelStatus, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.reviewSurfaceCanQueueDeferredModel, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.workspaceImportDeferredUntilRealCandidate, isTrue);
      expect(GaussMathLiveOcrReviewSurfacePolicy.realOcrEngineAdded, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.textOcrFallbackAdded, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.paddleRuntimeAdded, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.pix2TextRuntimeAdded, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.onnxRuntimeAdded, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.productionModelUrlBound, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.productionMathLiveBridgeCalled, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.mathLiveProductionFilesMutated, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.keyboardMutationAllowed, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.mathLiveProductionFilesMutated, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussMathLiveOcrReviewSurfacePolicy.androidRealDeviceReviewPassClaimedByAssistant, isFalse);
    });

    test('pending draft blocks workspace import, solve, graph, and history', () {
      final draft = GaussMathLiveOcrReviewDraft.pending(
        capturePath: '/tmp/gauss-camera-capture.jpg',
        rotationQuarterTurns: 1,
      );

      expect(draft.hasRealOcrCandidate, isFalse);
      expect(draft.primaryLatexCandidate, r'\text{OCR candidate pending}');
      expect(draft.alternativeLatexCandidates, isEmpty);
      expect(draft.canImportToWorkspace, isFalse);
      expect(draft.canEvaluate, isFalse);
      expect(draft.canGraph, isFalse);
      expect(draft.canWriteHistory, isFalse);
      expect(draft.rotationDegrees, 90);
    });

    test('camera crop flow opens review surface without adding OCR/runtime dependencies', () {
      final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final reviewSurface = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final mathLiveProd = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();

      expect(cameraShell, contains("import 'gauss_mathlive_ocr_review_surface.dart';"));
      expect(cameraShell, contains('GaussMathLiveOcrReviewSheet'));
      expect(cameraShell, contains('isScrollControlled: true'));
      expect(
        cameraShell.contains('Fotoğraf doğrudan çözüme gönderilmedi') ||
            cameraShell.contains('OCR review akışı başlar'),
        isTrue,
      );

      expect(
        reviewSurface.contains('class GaussMathLiveOcrReviewSheet extends StatelessWidget') ||
            reviewSurface.contains('class GaussMathLiveOcrReviewSheet extends StatefulWidget'),
        isTrue,
      );
      expect(reviewSurface, contains('class GaussMathLiveOcrReviewDraft'));
      expect(
        reviewSurface.contains('MathLive review hazırlandı') ||
            reviewSurface.contains('MathLive OCR review'),
        isTrue,
      );
      expect(
        reviewSurface.contains('MathLive düzenleme adayı') ||
            reviewSurface.contains('Düzenlenebilir OCR adayı'),
        isTrue,
      );
      expect(reviewSurface, contains('OCR candidate pending'));
      expect(
        reviewSurface.contains('Gerçek OCR adayı gelmeden workspace aktarımı') ||
            reviewSurface.contains('OCR adayı henüz hazır değil. Workspace aktarımı, çözüm ve grafik kapalı kalır.') ||
            reviewSurface.contains('OCR adayı yok: workspace aktarımı, çözüm ve grafik kapalı'),
        isTrue,
      );
      expect(reviewSurface, contains('Gelişmiş model yöneticisi'));
      expect(File('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart').readAsStringSync(), contains('İndirme kuyruğunda'));
      expect(reviewSurface, isNot(contains('MathLiveProductionEditorSurface')));
      expect(reviewSurface, isNot(contains('setLatex')));
      expect(reviewSurface, isNot(contains('evaluateFromCamera')));
      expect(reviewSurface, isNot(contains('solveFromCamera')));

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, contains(RegExp(r'^\s*shared_preferences:\s*\^2\.5\.5\s*$', multiLine: true)));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*pix2text\s*:', multiLine: true))));
      expect(manifest, contains('<uses-permission android:name="android.permission.CAMERA" />'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(mathLiveProd, contains('class MathLiveProductionEditorSurface'));
    });
  });
}
