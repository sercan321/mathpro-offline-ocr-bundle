import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_download_session_recovery_state_machine_q385r4.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('V172-Q385R4 camera OCR download session recovery state machine', () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
    });

    test('policy records queued/download/verifying separation without OCR inference claims', () {
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.phase, 'V172-Q385R4-DOWNLOAD-SESSION-RECOVERY-TEST-AND-STATE-MACHINE-REPAIR');
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.standaloneQueuedStateSurvivesLoad, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.installSessionQueuedStateCanRecover, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.interruptedDownloadingVerifyingRecoverImmediately, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.installSessionIdPersisted, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.q239dQueuedLoadTestRepaired, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.reviewAsyncCallbackSignatureRepaired, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.reviewDownloadSemanticsMirrorsVisibleCopy, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.sidecarShaLockStillNotClaimed, isTrue);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.productionInferenceClaimedByQ385R4, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.keyboardQ382Touched, isFalse);
      expect(GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.graphHistorySolutionSolverTouched, isFalse);
    });

    test('standalone queued state survives load for Q239D successor compatibility', () async {
      final queued = await GaussDeferredMathOcrModelManager.queueUserApprovedNetworkPreparation();
      expect(queued.status, GaussMathOcrModelInstallStatus.queued);
      expect(queued.installSessionId, isNull);

      final loaded = await GaussDeferredMathOcrModelManager.load();
      expect(loaded.status, GaussMathOcrModelInstallStatus.queued);
      expect(loaded.installSessionId, isNull);
      expect(loaded.productCopy, contains('doğrulanmadan OCR çalıştırılmayacak'));
    });

    test('install-session queued snapshot recovers when the process-local worker is gone', () async {
      final interrupted = GaussMathOcrModelSnapshot.initial().copyWith(
        status: GaussMathOcrModelInstallStatus.queued,
        progress: 0,
        offlineAvailable: false,
        stateUpdatedAtIso: DateTime.now().toUtc().toIso8601String(),
        installSessionId: '${GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.installSessionIdPrefix}test-queued',
      );
      SharedPreferences.setMockInitialValues(<String, Object>{
        'gauss.mathOcrModel.snapshot.v172.q239d': interrupted.toJsonString(),
      });

      final loaded = await GaussDeferredMathOcrModelManager.load();
      expect(loaded.status, GaussMathOcrModelInstallStatus.failed);
      expect(loaded.canRetryDownload, isTrue);
      expect(loaded.failureMessage, contains('yarıda kaldı'));
    });

    test('downloading and verifying snapshots recover marker: downloading snapshot recovers to retryable failed state', () async {
      final interrupted = GaussMathOcrModelSnapshot.initial().copyWith(
        status: GaussMathOcrModelInstallStatus.downloading,
        progress: 0.41,
        offlineAvailable: false,
        stateUpdatedAtIso: DateTime.now().toUtc().toIso8601String(),
      );
      SharedPreferences.setMockInitialValues(<String, Object>{
        'gauss.mathOcrModel.snapshot.v172.q239d': interrupted.toJsonString(),
      });

      final loaded = await GaussDeferredMathOcrModelManager.load();
      expect(loaded.status, GaussMathOcrModelInstallStatus.failed);
      expect(loaded.isQueuedOrActive, isFalse);
      expect(loaded.downloadActionLabel, 'Tekrar indir');
    });

    test('downloading and verifying snapshots recover marker: verifying snapshot recovers to retryable failed state', () async {
      final interrupted = GaussMathOcrModelSnapshot.initial().copyWith(
        status: GaussMathOcrModelInstallStatus.verifying,
        progress: 0.997,
        offlineAvailable: false,
        stateUpdatedAtIso: DateTime.now().toUtc().toIso8601String(),
      );
      SharedPreferences.setMockInitialValues(<String, Object>{
        'gauss.mathOcrModel.snapshot.v172.q239d': interrupted.toJsonString(),
      });

      final loaded = await GaussDeferredMathOcrModelManager.load();
      expect(loaded.status, GaussMathOcrModelInstallStatus.failed);
      expect(loaded.isQueuedOrActive, isFalse);
      expect(loaded.downloadActionLabel, 'Tekrar indir');
    });
  });
}
