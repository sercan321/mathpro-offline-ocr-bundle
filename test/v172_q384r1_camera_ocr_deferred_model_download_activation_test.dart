import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';

void main() {
  group('V172-Q384R1 camera OCR deferred model download activation', () {
    test('policy activates real user-tapped download without bundling model bytes or ONNX Runtime', () {
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.phase, 'V172-Q384R1-CAMERA-OCR-DEFERRED-MODEL-DOWNLOAD-ACTIVATION');
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.sourcePhase, 'V172-Q384-BASE-APK-OCR-RUNTIME-SLIMMING-DOWNLOAD-ONLY-CONTRACT');
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.productionDownloadUrlBound, isTrue);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.realNetworkDownloadWorkerImplemented, isTrue);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.sha256VerificationImplemented, isTrue);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.appPrivateStorageAtomicInstallImplemented, isTrue);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.productionInferenceClaimedByQ384R1, isFalse);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraOcrDeferredModelDownloadQ384R1Policy.workspaceImportRequiresUserReviewApproval, isTrue);
    });

    test('manifest locks legacy PP-FormulaNet-S primary artifact while latest deferred manifest may point to successor FormulaNet_plus', () {
      expect(GaussQ384R1DeferredModelDownloadWorker.artifacts.map((artifact) => artifact.fileName), containsAll(<String>[
        'config.json',
        'inference.json',
        'inference.yml',
        'inference.pdiparams',
      ]));
      final primary = GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'inference.pdiparams');
      expect(primary.url, contains('PaddlePaddle/PP-FormulaNet-S/resolve/'));
      expect(primary.url, contains(GaussCameraOcrDeferredModelDownloadQ384R1Policy.hfRevision));
      expect(primary.expectedSha256, GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySha256);
      expect(primary.requiresSha256, isTrue);
      expect(primary.minimumSizeBytes, greaterThanOrEqualTo(200 * 1024 * 1024));
      expect(GaussDeferredMathOcrModelManifest.modelName, contains('PP-FormulaNet'));
      expect(GaussDeferredMathOcrModelManifest.modelName, contains('plus'));
      expect(GaussDeferredMathOcrModelManifest.androidRuntimeRequiredArtifactKind, contains('nb'));
      expect(GaussDeferredMathOcrModelManifest.productionPaddleLiteNbAcquiredForAndroidRuntime, isFalse);
      expect(GaussDeferredMathOcrModelManifest.sha256, GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySha256);
      expect(GaussDeferredMathOcrModelManifest.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussDeferredMathOcrModelManifest.directSolveAllowed, isFalse);
    });


    test('Q385R1 keeps sidecar guards realistic and removes false Wi-Fi-only claim', () {
      final config = GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'config.json');
      final inferenceJson = GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'inference.json');
      final inferenceYml = GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'inference.yml');
      expect(config.minimumSizeBytes, lessThan(1024 * 1024));
      expect(config.expectedSizeBytes, isNotNull);
      expect(config.documentedSizeLabel, '3.95 MB');
      expect(inferenceJson.minimumSizeBytes, lessThan(128 * 1024));
      expect(inferenceJson.expectedSizeBytes, isNotNull);
      expect(inferenceJson.documentedSizeLabel, '505 kB');
      expect(inferenceYml.minimumSizeBytes, lessThan(512 * 1024));
      expect(inferenceYml.expectedSizeBytes, isNotNull);
      expect(inferenceYml.documentedSizeLabel, '2.24 MB');
      expect(GaussDeferredMathOcrModelManifest.networkPolicy, GaussCameraOcrDownloadGuardRepairQ385R1Policy.networkPolicy);
      expect(GaussCameraOcrDownloadGuardRepairQ385R1Policy.wifiOnlyClaimRemoved, isTrue);
      expect(GaussCameraOcrDownloadGuardRepairQ385R1Policy.contentLengthSanityCheckImplemented, isTrue);
      expect(GaussCameraOcrDownloadGuardRepairQ385R1Policy.sidecarShaLockClaimed, isFalse);
    });
  });
}
