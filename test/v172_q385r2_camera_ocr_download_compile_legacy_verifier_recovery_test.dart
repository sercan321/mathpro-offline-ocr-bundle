import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_download_compile_legacy_verifier_recovery_q385r2.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('V172-Q385R2 camera OCR download compile and legacy verifier recovery', () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
    });

    test('policy records compile, timeout, stale-state, and copy honesty boundaries', () {
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.phase, 'V172-Q385R2-CAMERA-OCR-DOWNLOAD-COMPILE-LEGACY-VERIFIER-RECOVERY-REPAIR');
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.accumulatorSinkCompileRiskRepaired, isTrue);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.legacyCameraVerifiersMadeSuccessorAware, isTrue);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.staleQueuedDownloadRecoveryImplemented, isTrue);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.downloadRequestTimeoutImplemented, isTrue);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.downloadStreamIdleTimeoutImplemented, isTrue);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.primaryShaCopySeparatedFromSidecarSizeCopy, isTrue);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.sidecarShaLockStillNotClaimed, isTrue);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.productionInferenceClaimedByQ385R2, isFalse);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.keyboardQ382Touched, isFalse);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.graphHistorySolutionSolverTouched, isFalse);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.requestTimeout.inSeconds, 45);
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.streamIdleTimeout.inSeconds, 30);
    });

    test('snapshot recovers a stale active download state so the button can be retried', () async {
      final stale = GaussMathOcrModelSnapshot.initial().copyWith(
        status: GaussMathOcrModelInstallStatus.downloading,
        progress: 0.42,
        offlineAvailable: false,
        stateUpdatedAtIso: DateTime.now().toUtc().subtract(const Duration(hours: 2)).toIso8601String(),
      );
      SharedPreferences.setMockInitialValues(<String, Object>{
        'gauss.mathOcrModel.snapshot.v172.q239d': stale.toJsonString(),
      });

      final loaded = await GaussDeferredMathOcrModelManager.load();
      expect(loaded.status, GaussMathOcrModelInstallStatus.failed);
      expect(loaded.isQueuedOrActive, isFalse);
      expect(loaded.canRetryDownload, isTrue);
      expect(loaded.failureMessage, contains('Kilit temizlendi'));
    });

    test('ready copy distinguishes primary SHA verification from sidecar size checks', () {
      final ready = GaussMathOcrModelSnapshot.initial().copyWith(
        status: GaussMathOcrModelInstallStatus.ready,
        offlineAvailable: true,
        sha256: GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySha256,
      );
      expect(ready.productCopy, contains('ana model dosyası SHA256'));
      expect(ready.productCopy, contains('yan dosyalar varlık ve boyut'));
      expect(GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.sidecarVerificationCopy, 'primary-sha256-sidecars-size-and-presence-checked');
    });
  });
}
