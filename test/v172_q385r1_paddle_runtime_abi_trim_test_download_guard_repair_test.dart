import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_runtime_abi_trim_test_download_guard_repair_q385r1.dart';

void main() {
  group('V172-Q385R1 Paddle runtime ABI trim test and download guard repair', () {
    test('policy records the surgical repair scope and protected boundaries', () {
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.phase, 'V172-Q385R1-PADDLE-RUNTIME-ABI-TRIM-TEST-AND-DOWNLOAD-GUARD-REPAIR');
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.sourcePhase, 'V172-Q385-PADDLE-RUNTIME-ABI-TRIM-AND-DELIVERY-GUARD');
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.q384r1MinimumSizeFlutterTestRepaired, isTrue);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.wifiOnlyClaimRemoved, isTrue);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.actualWifiGateImplemented, isFalse);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.contentLengthSanityCheckImplemented, isTrue);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.productionInferenceClaimedByQ385R1, isFalse);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.keyboardQ382Touched, isFalse);
      expect(GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy.graphHistorySolutionSolverTouched, isFalse);
    });

    test('download guard metadata is aligned with the real network behavior', () {
      expect(GaussDeferredMathOcrModelManifest.networkPolicy, 'user-approved-internet-required-large-download');
      expect(GaussCameraOcrDownloadGuardRepairQ385R1Policy.networkPolicy, GaussDeferredMathOcrModelManifest.networkPolicy);
      expect(GaussMathOcrModelInstallStatus.queued.premiumLabel, 'İndirme kuyruğunda');
      expect(GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'config.json').documentedSizeLabel, '3.95 MB');
      expect(GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'inference.json').documentedSizeLabel, '505 kB');
      expect(GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'inference.yml').documentedSizeLabel, '2.24 MB');
      final primary = GaussQ384R1DeferredModelDownloadWorker.artifacts.singleWhere((artifact) => artifact.fileName == 'inference.pdiparams');
      expect(primary.minimumSizeBytes, greaterThanOrEqualTo(200 * 1024 * 1024));
      expect(primary.expectedSha256, GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySha256);
    });
  });
}
