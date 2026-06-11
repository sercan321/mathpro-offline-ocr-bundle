import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_download_session_recovery_retry_ux_hardening_q385r3.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('V172-Q385R3 camera OCR download session recovery and retry UX hardening', () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
    });

    test('policy records process-local active guard and retry boundaries', () {
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.phase, 'V172-Q385R3-CAMERA-OCR-DOWNLOAD-SESSION-RECOVERY-RETRY-UX-HARDENING');
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.processLocalActiveInstallGuardImplemented, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.activeSnapshotWithoutRunningProcessRecoversImmediately, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.activeProgressPersistenceImplemented, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.retryButtonCopyImplemented, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.generatedToolReportsDeclaredInAudit, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.sidecarShaLockStillNotClaimed, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.productionInferenceClaimedByQ385R3, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.keyboardQ382Touched, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.graphHistorySolutionSolverTouched, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.activeProgressPersistCadence.inSeconds, 2);
    });

    test('active persisted state recovers immediately when no process-local install is running', () async {
      final interrupted = GaussMathOcrModelSnapshot.initial().copyWith(
        status: GaussMathOcrModelInstallStatus.downloading,
        progress: 0.31,
        offlineAvailable: false,
        stateUpdatedAtIso: DateTime.now().toUtc().subtract(const Duration(minutes: 1)).toIso8601String(),
      );
      SharedPreferences.setMockInitialValues(<String, Object>{
        'gauss.mathOcrModel.snapshot.v172.q239d': interrupted.toJsonString(),
      });

      expect(GaussDeferredMathOcrModelManager.debugActiveInstallRunningForQ385R3, isFalse);
      final loaded = await GaussDeferredMathOcrModelManager.load();
      expect(loaded.status, GaussMathOcrModelInstallStatus.failed);
      expect(loaded.isQueuedOrActive, isFalse);
      expect(loaded.canRetryDownload, isTrue);
      expect(loaded.failureMessage, contains('yarıda kaldı'));
      expect(loaded.downloadActionLabel, GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.retryButtonCopy);
    });

    test('download action copy distinguishes initial, active, and retry states', () {
      expect(GaussMathOcrModelSnapshot.initial().downloadActionLabel, 'Modeli indir');
      expect(
        GaussMathOcrModelSnapshot.initial().copyWith(status: GaussMathOcrModelInstallStatus.downloading).downloadActionLabel,
        'İndiriliyor',
      );
      expect(
        GaussMathOcrModelSnapshot.initial().copyWith(status: GaussMathOcrModelInstallStatus.failed).downloadActionLabel,
        'Tekrar indir',
      );
    });
  });
}
