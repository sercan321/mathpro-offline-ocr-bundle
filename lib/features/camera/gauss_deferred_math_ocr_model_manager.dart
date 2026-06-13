import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gauss_camera_ocr_deferred_model_download_q384r1.dart';
import 'gauss_camera_ocr_download_compile_legacy_verifier_recovery_q385r2.dart';
import 'gauss_camera_ocr_download_session_recovery_retry_ux_hardening_q385r3.dart';
import 'gauss_camera_ocr_download_session_recovery_state_machine_q385r4.dart';
import 'gauss_deferred_math_ocr_model_manager_policy.dart';
import 'gauss_device_only_formula_ocr_bundle_q389r2_offline.dart';
import 'gauss_paddle_lite_nb_artifact_manifest_q387r1.dart';
import 'gauss_paddle_lite_nb_download_install_binding_q387r2.dart';
import 'gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';
import 'gauss_paddle_lite_nb_production_source_binding_q387r4.dart';
import 'gauss_paddle_lite_nb_external_artifact_intake_q387r5.dart';
import 'gauss_paddle_lite_nb_conversion_evidence_generator_q387r6.dart';
import 'gauss_paddle_lite_nb_user_side_conversion_protocol_q387r7.dart';

// Q387R1/Q384R2 successor verifier continuity: Android Paddle Lite OCR için ayrıca doğrulanmış .nb manifest kanıtı gerekir.
// Q384R2 successor verifier continuity: Kamera OCR inference için runtime/model-format binding Q384R2 preflight ile hizalanır.
/// Install state for the optional advanced math OCR model pack.
///
/// Q384R1 keeps OCR inference locked, but activates the user-initiated model
/// download, SHA256 verification, and app-private install chain.
enum GaussMathOcrModelInstallStatus {
  notInstalled,
  queued,
  downloading,
  verifying,
  ready,
  failed,
  updateAvailable,
  disabledByUser,
}

extension GaussMathOcrModelInstallStatusCopy on GaussMathOcrModelInstallStatus {
  String get storageValue => name;

  String get premiumLabel {
    switch (this) {
      case GaussMathOcrModelInstallStatus.notInstalled:
        return 'Hazır değil';
      case GaussMathOcrModelInstallStatus.queued:
        return 'İndirme kuyruğunda';
      case GaussMathOcrModelInstallStatus.downloading:
        return 'İndiriliyor';
      case GaussMathOcrModelInstallStatus.verifying:
        return 'Doğrulanıyor';
      case GaussMathOcrModelInstallStatus.ready:
        return 'Hazır';
      case GaussMathOcrModelInstallStatus.failed:
        return 'Tekrar gerekli';
      case GaussMathOcrModelInstallStatus.updateAvailable:
        return 'Güncelleme var';
      case GaussMathOcrModelInstallStatus.disabledByUser:
        return 'Kapalı';
    }
  }

  static GaussMathOcrModelInstallStatus fromStorage(String? value) {
    for (final status in GaussMathOcrModelInstallStatus.values) {
      if (status.storageValue == value) return status;
    }
    return GaussMathOcrModelInstallStatus.notInstalled;
  }
}

/// Static manifest for the future optional model pack.
///
/// There is intentionally no production URL in Q239D. The winning engine and
/// verified model artifact will be bound by a later benchmark/adapter phase.
class GaussDeferredMathOcrModelManifest {
  const GaussDeferredMathOcrModelManifest._();

  static const String phase = GaussDeferredMathOcrModelManagerPolicy.fullPhase;
  static const String modelName = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.modelDisplayName;
  static const String modelVersion = 'q389r6b-paddle2onnx-opset19-plus-s';
  static const String engine = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryEngine;
  static const String installMode = 'deferred-after-install';
  static const String storagePolicy = 'app-private-storage';
  // Q385R1 network policy: user-approved-internet-required-large-download
  static const String networkPolicy = GaussCameraOcrDownloadGuardRepairQ385R1Policy.networkPolicy;
  static const String sha256 = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.expectedOnnxSha256;
  static const int sizeBytes = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.expectedOnnxSizeBytes;
  static const String androidRuntimeRequiredArtifactKind = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryRuntimeArtifactKind;
  static const String androidRuntimeRequiredManifestFileName = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.nativeRuntimeManifestFileName;
  static const String androidRuntimeNbEvidenceBlockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.realNbArtifactEvidenceRequiredBlockedReason;
  static const String androidRuntimeNbDownloadInstallPhase = GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.phase;
  static const String androidRuntimeNbProductionSourceBlockedReason = GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.productionNbSourceMissingBlockedReason;
  static const String androidRuntimeNbAcquisitionProtocolPhase = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.phase;
  static const String androidRuntimeNbAcquisitionBlockedReason = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.q387R2ProductionBindingBlockedReason;
  static const String androidRuntimeNbProductionSourceBindingPhase = GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.phase;
  static const String androidRuntimeNbProductionSourceBindingBlockedReason = GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.productionNbSourceNotBoundBlockedReason;
  static const String androidRuntimeNbExternalArtifactIntakePhase = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.phase;
  static const String androidRuntimeNbExternalArtifactIntakeBlockedReason = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.externalArtifactRequiredBlockedReason;
  static const String androidRuntimeNbConversionEvidencePhase = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.phase;
  static const String androidRuntimeNbConversionEvidenceBlockedReason = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionEvidenceRequiredBlockedReason;
  static const String androidRuntimeNbUserSideConversionProtocolPhase = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.phase;
  static const String androidRuntimeNbUserSideConversionProtocolBlockedReason = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.protocolInputRequiredBlockedReason;

  static const bool productionDownloadUrlBound = true;
  static const bool productionPaddleLiteNbDownloadUrlBound = GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.productionNbDownloadUrlBound;
  static const bool productionPaddleLiteNbAcquiredForAndroidRuntime = false;
  static const bool productionPaddleLiteNbSourceBoundForAndroidRuntime = false;
  static const bool productionOnnxRuntimeMobileModelBoundForAndroidRuntime = true;
  static const bool externalPaddleLiteNbArtifactIntakeReadyForAndroidRuntime = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.externalArtifactIntakeImplemented;
  static const bool paddleLiteNbConversionEvidenceGeneratorReadyForAndroidRuntime = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionEvidenceGeneratorImplemented;
  static const bool paddleLiteNbUserSideConversionProtocolReadyForAndroidRuntime = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.protocolGeneratorImplemented;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool requiresSha256BeforeReady = true;
  static const bool supportsOfflineAfterInstall = true;
  static const bool directSolveAllowed = false;
}

/// Persisted snapshot exposed to the camera shell and future download worker.
/// Sonraki fazlarda Q384/Q385 gerçek download'a geçti; Q385R2 eski aktif
/// indirme state'lerini kurtarır ve eski Q239 verifier'larını successor-aware yapar.
class GaussMathOcrModelSnapshot {
  const GaussMathOcrModelSnapshot({
    required this.status,
    required this.progress,
    required this.wifiOnly,
    required this.modelName,
    required this.modelVersion,
    required this.engine,
    required this.offlineAvailable,
    this.sizeBytes,
    this.sha256,
    this.installPath,
    this.downloadedAtIso,
    this.stateUpdatedAtIso,
    this.installSessionId,
    this.failureMessage,
  });

  factory GaussMathOcrModelSnapshot.initial() {
    return const GaussMathOcrModelSnapshot(
      status: GaussMathOcrModelInstallStatus.notInstalled,
      progress: 0,
      wifiOnly: false,
      modelName: GaussDeferredMathOcrModelManifest.modelName,
      modelVersion: GaussDeferredMathOcrModelManifest.modelVersion,
      engine: GaussDeferredMathOcrModelManifest.engine,
      offlineAvailable: false,
      sizeBytes: GaussDeferredMathOcrModelManifest.sizeBytes,
      sha256: GaussDeferredMathOcrModelManifest.sha256,
    );
  }

  factory GaussMathOcrModelSnapshot.fromJsonString(String? raw) {
    if (raw == null || raw.trim().isEmpty) return GaussMathOcrModelSnapshot.initial();
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return GaussMathOcrModelSnapshot.initial();
      return GaussMathOcrModelSnapshot(
        status: GaussMathOcrModelInstallStatusCopy.fromStorage(decoded['status'] as String?),
        progress: _normalizedProgress(decoded['progress']),
        wifiOnly: decoded['wifiOnly'] == true,
        modelName: decoded['modelName'] as String? ?? GaussDeferredMathOcrModelManifest.modelName,
        modelVersion: decoded['modelVersion'] as String? ?? GaussDeferredMathOcrModelManifest.modelVersion,
        engine: decoded['engine'] as String? ?? GaussDeferredMathOcrModelManifest.engine,
        offlineAvailable: decoded['offlineAvailable'] == true,
        sizeBytes: decoded['sizeBytes'] is int ? decoded['sizeBytes'] as int : null,
        sha256: decoded['sha256'] as String? ?? GaussDeferredMathOcrModelManifest.sha256,
        installPath: decoded['installPath'] as String?,
        downloadedAtIso: decoded['downloadedAtIso'] as String?,
        stateUpdatedAtIso: decoded['stateUpdatedAtIso'] as String?,
        installSessionId: decoded['installSessionId'] as String?,
        failureMessage: decoded['failureMessage'] as String?,
      );
    } catch (_) {
      return GaussMathOcrModelSnapshot.initial();
    }
  }

  final GaussMathOcrModelInstallStatus status;
  final double progress;
  final bool wifiOnly;
  final String modelName;
  final String modelVersion;
  final String engine;
  final bool offlineAvailable;
  final int? sizeBytes;
  final String? sha256;
  final String? installPath;
  final String? downloadedAtIso;
  final String? stateUpdatedAtIso;
  final String? installSessionId;
  final String? failureMessage;

  bool get canRunOffline => status == GaussMathOcrModelInstallStatus.ready && offlineAvailable;
  bool get hasInstallSession => (installSessionId ?? '').trim().isNotEmpty;
  bool get isQueuedOrActive => status == GaussMathOcrModelInstallStatus.queued || status == GaussMathOcrModelInstallStatus.downloading || status == GaussMathOcrModelInstallStatus.verifying;
  bool get isInterruptedSessionRecoverable =>
      hasInstallSession &&
      (status == GaussMathOcrModelInstallStatus.queued ||
          status == GaussMathOcrModelInstallStatus.downloading ||
          status == GaussMathOcrModelInstallStatus.verifying);
  bool get canRetryDownload => !isQueuedOrActive;

  String get downloadActionLabel {
    if (isQueuedOrActive) {
      return GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.activeDownloadButtonCopy;
    }
    if (status == GaussMathOcrModelInstallStatus.failed) {
      return GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.retryButtonCopy;
    }
    return GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.defaultDownloadButtonCopy;
  }

  String get statusLabel => status.premiumLabel;

  String get productCopy {
    switch (status) {
      case GaussMathOcrModelInstallStatus.notInstalled:
        return "Offline Formula OCR paketi ana uygulamaya gömülü değil. Modeli indir butonu yalnızca doğrulanmış PP-FormulaNet_plus-S ONNX Runtime Mobile bundle manifestini kabul eder; backend, ML Kit ve düz metin OCR fallback yoktur.";
      case GaussMathOcrModelInstallStatus.queued:
        return "Model indirme isteği alındı. Model doğrulanmadan OCR çalıştırılmayacak; ONNX model dosyası, preprocess metadata ve decoder sidecar SHA/size kanıtı olmadan sahte kamera sonucu üretilmeyecek.";
      case GaussMathOcrModelInstallStatus.downloading:
        return 'Model paketi indiriliyor. Hazır olmadan OCR çalıştırılmayacak; gerçek ONNX Runtime Mobile download-install manifest kanıtı aranacak.';
      case GaussMathOcrModelInstallStatus.verifying:
        return 'Ana ONNX model dosyası SHA256 doğrulamasından geçiyor; preprocess ve decoder yan dosyaları varlık/boyut kontrolünden geçmeden hazır sayılmayacak.';
      case GaussMathOcrModelInstallStatus.ready:
        return 'Offline Formula OCR runtime paketi private storage içinde doğrulandı; ana model dosyası SHA256 kontrolünden geçti; ONNX runtime model doğrulaması aktif; yan dosyalar varlık ve boyut açısından doğrulandı. İnternet kapalıyken kamera yalnızca cihaz içi ONNX Runtime Mobile Formula OCR yolunu kullanır; sonuç varsa review içinde onayla workspace’e aktarılır.';
      case GaussMathOcrModelInstallStatus.failed:
        return failureMessage ?? 'Model hazırlığı başarısız oldu. Bozuk dosya kullanılmayacak.';
      case GaussMathOcrModelInstallStatus.updateAvailable:
        return 'Gelişmiş matematik okuma modeli için güncelleme mevcut.';
      case GaussMathOcrModelInstallStatus.disabledByUser:
        return 'Gelişmiş matematik okuma modeli kullanıcı tarafından kapatıldı.';
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status.storageValue,
      'progress': progress,
      'wifiOnly': wifiOnly,
      'modelName': modelName,
      'modelVersion': modelVersion,
      'engine': engine,
      'offlineAvailable': offlineAvailable,
      'sizeBytes': sizeBytes,
      'sha256': sha256,
      'installPath': installPath,
      'downloadedAtIso': downloadedAtIso,
      'stateUpdatedAtIso': stateUpdatedAtIso,
      'installSessionId': installSessionId,
      'failureMessage': failureMessage,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  GaussMathOcrModelSnapshot copyWith({
    GaussMathOcrModelInstallStatus? status,
    double? progress,
    bool? wifiOnly,
    String? modelName,
    String? modelVersion,
    String? engine,
    bool? offlineAvailable,
    int? sizeBytes,
    String? sha256,
    String? installPath,
    String? downloadedAtIso,
    String? stateUpdatedAtIso,
    String? installSessionId,
    String? failureMessage,
    bool clearFailureMessage = false,
  }) {
    return GaussMathOcrModelSnapshot(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      wifiOnly: wifiOnly ?? this.wifiOnly,
      modelName: modelName ?? this.modelName,
      modelVersion: modelVersion ?? this.modelVersion,
      engine: engine ?? this.engine,
      offlineAvailable: offlineAvailable ?? this.offlineAvailable,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      sha256: sha256 ?? this.sha256,
      installPath: installPath ?? this.installPath,
      downloadedAtIso: downloadedAtIso ?? this.downloadedAtIso,
      stateUpdatedAtIso: stateUpdatedAtIso ?? this.stateUpdatedAtIso,
      installSessionId: installSessionId ?? this.installSessionId,
      failureMessage: clearFailureMessage ? null : failureMessage ?? this.failureMessage,
    );
  }

  static double _normalizedProgress(Object? value) {
    if (value is num) return value.clamp(0, 1).toDouble();
    return 0;
  }
}

/// Persisted manager for the optional PP-FormulaNet-S model pack.
class GaussDeferredMathOcrModelManager {
  const GaussDeferredMathOcrModelManager._();

  static const String _snapshotKey = 'gauss.mathOcrModel.snapshot.v172.q239d';

  static bool _activeInstallRunning = false;
  static DateTime? _lastActiveProgressPersistedAt;

  static bool get debugActiveInstallRunningForQ385R3 => _activeInstallRunning;
  static bool get debugActiveInstallRunningForQ385R4 => _activeInstallRunning;

  static Future<GaussMathOcrModelSnapshot> load() async {
    final prefs = await SharedPreferences.getInstance();
    final snapshot = GaussMathOcrModelSnapshot.fromJsonString(prefs.getString(_snapshotKey));
    final recovered = _recoverStaleActiveSnapshot(snapshot);
    if (!identical(recovered, snapshot)) await _persist(recovered);
    return recovered;
  }

  static Future<GaussMathOcrModelSnapshot> queueUserApprovedNetworkPreparation({
    String? installSessionId,
  }) async {
    final current = await load();
    final next = current.copyWith(
      status: GaussMathOcrModelInstallStatus.queued,
      progress: 0,
      wifiOnly: false,
      offlineAvailable: false,
      stateUpdatedAtIso: _nowIso(),
      installSessionId: installSessionId,
      clearFailureMessage: true,
    );
    await _persist(next);
    return next;
  }


  @Deprecated('Use queueUserApprovedNetworkPreparation; Q385R1 removed the false Wi-Fi-only claim.')
  static Future<GaussMathOcrModelSnapshot> queueWifiOnlyPreparation() {
    return queueUserApprovedNetworkPreparation();
  }



  static GaussQ387R5PaddleLiteNbExternalArtifactIntakeResult evaluateExternalPaddleLiteNbArtifactQ387R5({
    required GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput input,
  }) {
    return GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate(input: input);
  }

  static GaussQ387R6PaddleLiteNbConversionEvidenceResult evaluatePaddleLiteNbConversionEvidenceQ387R6({
    required GaussQ387R6PaddleLiteNbConversionEvidenceInput input,
  }) {
    return GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate(input: input);
  }

  static GaussQ387R7PaddleLiteNbUserSideConversionProtocolResult evaluatePaddleLiteNbUserSideConversionProtocolQ387R7({
    required GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput input,
  }) {
    return GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate(input: input);
  }

  static Future<GaussMathOcrModelSnapshot> installVerifiedExternalPaddleLiteNbModelQ387R5({
    required GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput input,
    void Function(GaussMathOcrModelSnapshot snapshot)? onProgress,
  }) async {
    final intake = evaluateExternalPaddleLiteNbArtifactQ387R5(input: input);
    if (!intake.canBindToQ387R2ProductionSource || intake.q387R2Source == null) {
      final failed = (await load()).copyWith(
        status: GaussMathOcrModelInstallStatus.failed,
        progress: 0,
        offlineAvailable: false,
        stateUpdatedAtIso: _nowIso(),
        failureMessage: 'Android Paddle Lite .nb external artifact intake reddedildi: ${intake.blockedReason}',
      );
      await _persist(failed);
      onProgress?.call(failed);
      return failed;
    }
    return installVerifiedPaddleLiteNbModelQ387R2(
      source: intake.q387R2Source!,
      onProgress: onProgress,
    );
  }

  static Future<GaussMathOcrModelSnapshot> installVerifiedPaddleLiteNbModelQ387R2({
    required GaussQ387R2PaddleLiteNbSource source,
    void Function(GaussMathOcrModelSnapshot snapshot)? onProgress,
  }) async {
    if (_activeInstallRunning) {
      return load();
    }
    _activeInstallRunning = true;
    _lastActiveProgressPersistedAt = null;

    try {
      final gate = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(
        candidate: source.toQ387R1Candidate(),
      );
      if (!gate.canProceedToQ387R2DownloadInstall) {
        final failed = (await load()).copyWith(
          status: GaussMathOcrModelInstallStatus.failed,
          progress: 0,
          offlineAvailable: false,
          stateUpdatedAtIso: _nowIso(),
          failureMessage: 'Android Paddle Lite .nb kaynak kanıtı reddedildi: ${gate.blockedReason}',
        );
        await _persist(failed);
        onProgress?.call(failed);
        return failed;
      }

      final installSessionId = _newInstallSessionId();
      final queued = await queueUserApprovedNetworkPreparation(installSessionId: installSessionId);
      onProgress?.call(queued);

      final downloading = queued.copyWith(
        status: GaussMathOcrModelInstallStatus.downloading,
        progress: 0.01,
        wifiOnly: false,
        offlineAvailable: false,
        modelName: GaussDeferredMathOcrModelManifest.modelName,
        modelVersion: source.sourceRevision ?? GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.phase,
        engine: GaussDeferredMathOcrModelManifest.engine,
        sizeBytes: source.sizeBytes,
        sha256: source.sha256,
        stateUpdatedAtIso: _nowIso(),
        installSessionId: installSessionId,
        clearFailureMessage: true,
      );
      await _persist(downloading);
      onProgress?.call(downloading);

      try {
        final appFilesDirectory = await getApplicationSupportDirectory();
        final evidence = await GaussQ387R2PaddleLiteNbDownloadInstallWorker.installFromVerifiedSource(
          appFilesDirectory: appFilesDirectory,
          source: source,
          onProgress: (progress) async {
            final active = downloading.copyWith(
              status: progress >= 0.995 ? GaussMathOcrModelInstallStatus.verifying : GaussMathOcrModelInstallStatus.downloading,
              progress: progress.clamp(0, 0.995).toDouble(),
              offlineAvailable: false,
              stateUpdatedAtIso: _nowIso(),
              clearFailureMessage: true,
            );
            onProgress?.call(active);
            await _persistActiveProgressSnapshot(active);
          },
        );

        final ready = downloading.copyWith(
          status: GaussMathOcrModelInstallStatus.ready,
          progress: 1,
          offlineAvailable: true,
          sizeBytes: evidence.sizeBytes,
          sha256: evidence.sha256,
          installPath: evidence.nbModelPath,
          downloadedAtIso: _nowIso(),
          stateUpdatedAtIso: _nowIso(),
          clearFailureMessage: true,
        );
        await _persist(ready);
        onProgress?.call(ready);
        return ready;
      } catch (error) {
        final failed = downloading.copyWith(
          status: GaussMathOcrModelInstallStatus.failed,
          progress: 0,
          offlineAvailable: false,
          stateUpdatedAtIso: _nowIso(),
          failureMessage: _downloadFailureCopy(error),
        );
        await _persist(failed);
        onProgress?.call(failed);
        return failed;
      }
    } finally {
      _activeInstallRunning = false;
      _lastActiveProgressPersistedAt = null;
    }
  }


  static Future<GaussMathOcrModelSnapshot> installDeviceOnlyFormulaOcrBundleQ389R4Offline({
    void Function(GaussMathOcrModelSnapshot snapshot)? onProgress,
  }) async {
    if (_activeInstallRunning) {
      return load();
    }
    _activeInstallRunning = true;
    _lastActiveProgressPersistedAt = null;

    try {
      final installSessionId = _newInstallSessionId();
      final queued = await queueUserApprovedNetworkPreparation(installSessionId: installSessionId);
      onProgress?.call(queued);
      final downloading = queued.copyWith(
        status: GaussMathOcrModelInstallStatus.downloading,
        progress: 0.01,
        wifiOnly: false,
        offlineAvailable: false,
        modelName: GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.modelDisplayName,
        modelVersion: GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.phase,
        engine: GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.primaryEngine,
        stateUpdatedAtIso: _nowIso(),
        installSessionId: installSessionId,
        clearFailureMessage: true,
      );
      await _persist(downloading);
      onProgress?.call(downloading);

      try {
        final appFilesDirectory = await getApplicationSupportDirectory();
        final evidence = await GaussQ389R2OfflineFormulaOcrBundleInstaller.installProductionBundle(
          appFilesDirectory: appFilesDirectory,
          onProgress: (progress) async {
            final active = downloading.copyWith(
              status: progress >= 0.995 ? GaussMathOcrModelInstallStatus.verifying : GaussMathOcrModelInstallStatus.downloading,
              progress: progress.clamp(0, 0.995).toDouble(),
              offlineAvailable: false,
              stateUpdatedAtIso: _nowIso(),
              clearFailureMessage: true,
            );
            onProgress?.call(active);
            await _persistActiveProgressSnapshot(active);
          },
        );
        final ready = downloading.copyWith(
          status: GaussMathOcrModelInstallStatus.ready,
          progress: 1,
          offlineAvailable: true,
          sizeBytes: evidence.nbSizeBytes,
          sha256: evidence.nbSha256,
          installPath: evidence.nbModelPath,
          downloadedAtIso: _nowIso(),
          stateUpdatedAtIso: _nowIso(),
          clearFailureMessage: true,
        );
        await _persist(ready);
        onProgress?.call(ready);
        return ready;
      } catch (error) {
        final failed = downloading.copyWith(
          status: GaussMathOcrModelInstallStatus.failed,
          progress: 0,
          offlineAvailable: false,
          stateUpdatedAtIso: _nowIso(),
          failureMessage: _downloadFailureCopy(error),
        );
        await _persist(failed);
        onProgress?.call(failed);
        return failed;
      }
    } finally {
      _activeInstallRunning = false;
      _lastActiveProgressPersistedAt = null;
    }
  }

  @Deprecated('Use installDeviceOnlyFormulaOcrBundleQ389R4Offline; Q389R4 is the offline-only production bundle completeness closure phase.')
  static Future<GaussMathOcrModelSnapshot> installDeviceOnlyFormulaOcrBundleQ389R3Offline({
    void Function(GaussMathOcrModelSnapshot snapshot)? onProgress,
  }) {
    return installDeviceOnlyFormulaOcrBundleQ389R4Offline(onProgress: onProgress);
  }

  @Deprecated('Use installDeviceOnlyFormulaOcrBundleQ389R4Offline; Q389R4 is the offline-only production bundle completeness closure phase.')
  static Future<GaussMathOcrModelSnapshot> installDeviceOnlyFormulaOcrBundleQ389R2Offline({
    void Function(GaussMathOcrModelSnapshot snapshot)? onProgress,
  }) {
    return installDeviceOnlyFormulaOcrBundleQ389R4Offline(onProgress: onProgress);
  }


  static Future<GaussMathOcrModelSnapshot> installProductionModelQ384R1({
    void Function(GaussMathOcrModelSnapshot snapshot)? onProgress,
  }) async {
    if (_activeInstallRunning) {
      return load();
    }
    _activeInstallRunning = true;
    _lastActiveProgressPersistedAt = null;

    try {
      final installSessionId = _newInstallSessionId();
      final queued = await queueUserApprovedNetworkPreparation(installSessionId: installSessionId);
      onProgress?.call(queued);

      final downloading = queued.copyWith(
        status: GaussMathOcrModelInstallStatus.downloading,
        progress: 0.01,
        wifiOnly: false,
        offlineAvailable: false,
        modelName: GaussDeferredMathOcrModelManifest.modelName,
        modelVersion: GaussDeferredMathOcrModelManifest.modelVersion,
        engine: GaussDeferredMathOcrModelManifest.engine,
        sizeBytes: GaussDeferredMathOcrModelManifest.sizeBytes,
        sha256: GaussDeferredMathOcrModelManifest.sha256,
        stateUpdatedAtIso: _nowIso(),
        installSessionId: installSessionId,
        clearFailureMessage: true,
      );
      await _persist(downloading);
      onProgress?.call(downloading);

      try {
        final appFilesDirectory = await getApplicationSupportDirectory();
        final evidence = await GaussQ384R1DeferredModelDownloadWorker.install(
          appFilesDirectory: appFilesDirectory,
          onProgress: (progress) async {
            final active = downloading.copyWith(
              status: progress >= 0.995 ? GaussMathOcrModelInstallStatus.verifying : GaussMathOcrModelInstallStatus.downloading,
              progress: progress.clamp(0, 0.995).toDouble(),
              offlineAvailable: false,
              stateUpdatedAtIso: _nowIso(),
              clearFailureMessage: true,
            );
            onProgress?.call(active);
            await _persistActiveProgressSnapshot(active);
          },
        );

        final ready = downloading.copyWith(
          status: GaussMathOcrModelInstallStatus.ready,
          progress: 1,
          offlineAvailable: true,
          sizeBytes: evidence.totalInstalledBytes,
          sha256: evidence.primarySha256,
          installPath: evidence.primaryModelPath,
          downloadedAtIso: _nowIso(),
          stateUpdatedAtIso: _nowIso(),
          clearFailureMessage: true,
        );
        await _persist(ready);
        onProgress?.call(ready);
        return ready;
      } catch (error) {
        final failed = downloading.copyWith(
          status: GaussMathOcrModelInstallStatus.failed,
          progress: 0,
          offlineAvailable: false,
          stateUpdatedAtIso: _nowIso(),
          failureMessage: _downloadFailureCopy(error),
        );
        await _persist(failed);
        onProgress?.call(failed);
        return failed;
      }
    } finally {
      _activeInstallRunning = false;
      _lastActiveProgressPersistedAt = null;
    }
  }

  static String _downloadFailureCopy(Object error) {
    final text = error.toString();
    if (text.contains('q389r2-offline-production-bundle-source-not-bound')) {
      return 'Offline Formula OCR üretim paketi kaynağı henüz bağlı değil. Backend/ML Kit kullanılmayacak; gerçek PP-FormulaNet_plus-S ONNX bundle URL/SHA/manifest bağlanmadan kamera OCR açılmaz.';
    }
    if (text.contains('q389r2-offline-bundle-manifest-invalid') || text.contains('q389r2-offline-file-sha256-mismatch')) {
      return 'Offline Formula OCR paketi doğrulanamadı. Bozuk/yanlış model kullanılmayacak; manifest, SHA256 ve dosya boyutları kontrol edilmeli.';
    }
    if (text.contains('q387r2-production-paddle-lite-nb-source-not-bound')) {
      return 'Android ONNX Runtime Mobile için gerçek .onnx model kaynağı henüz bağlı değil. Sahte veya eski inference.pdiparams ile OCR açılmayacak.';
    }
    if (text.contains('q387r2-q387r1-nb-evidence-rejected')) {
      return 'Android ONNX Runtime Mobile model kanıtı reddedildi. URL, SHA256, boyut ve conversion provenance doğrulanmadan OCR açılmayacak.';
    }
    if (text.contains('sha256-mismatch')) {
      return 'Model doğrulanamadı. Bozuk veya yanlış dosya kullanılmayacak; tekrar indirmeyi dene.';
    }
    if (text.contains('artifact-too-small')) {
      return 'Model indirmesi eksik kaldı. Eksik dosya hazır sayılmadı; tekrar indirmeyi dene.';
    }
    if (error is TimeoutException || text.toLowerCase().contains('timeout')) {
      return 'Model indirmesi zaman aşımına uğradı. Eksik dosya hazır sayılmadı; tekrar indirmeyi dene.';
    }
    if (text.contains('content-length-too-small')) {
      return 'Model sunucusu beklenenden küçük dosya bildirdi. Eksik paket hazır sayılmadı; tekrar dene.';
    }
    if (text.contains('http-')) {
      return 'Model sunucusuna ulaşılamadı. İnternet bağlantısını kontrol edip tekrar dene.';
    }
    if (error is FileSystemException) {
      return 'Model private storage’a yazılamadı. Depolama alanını kontrol edip tekrar dene.';
    }
    return 'Model indirilemedi: $text';
  }

  static Future<GaussMathOcrModelSnapshot> markDisabledByUser() async {
    final current = await load();
    final next = current.copyWith(
      status: GaussMathOcrModelInstallStatus.disabledByUser,
      progress: 0,
      offlineAvailable: false,
      stateUpdatedAtIso: _nowIso(),
      clearFailureMessage: true,
    );
    await _persist(next);
    return next;
  }

  static Future<GaussMathOcrModelSnapshot> resetForDiagnostics() async {
    final next = GaussMathOcrModelSnapshot.initial();
    await _persist(next);
    return next;
  }


  // Q385R2 legacy marker preserved for successor-aware verifier continuity: Önceki model indirme oturumu tamamlanamadı.
  // Q385R3 successor marker retained: activeSnapshotWithoutRunningProcessRecoversImmediately / retryAfterInterruptedSessionCopy
  // Q385R4 state-machine repair: standalone queued state must survive load(),
  // while install-session queued/downloading/verifying states can recover if the
  // process-local worker is gone.
  static GaussMathOcrModelSnapshot _recoverStaleActiveSnapshot(GaussMathOcrModelSnapshot snapshot) {
    if (!snapshot.isQueuedOrActive) return snapshot;
    if (_activeInstallRunning) return snapshot;

    if (snapshot.status == GaussMathOcrModelInstallStatus.queued && !snapshot.hasInstallSession) {
      return snapshot;
    }

    final updatedAt = DateTime.tryParse(snapshot.stateUpdatedAtIso ?? '');
    final now = DateTime.now().toUtc();
    final legacyStale = updatedAt == null ||
        now.difference(updatedAt.toUtc()) >
            GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.staleActiveStateGracePeriod;
    final interruptedInstallSession =
        GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.interruptedDownloadingVerifyingRecoverImmediately &&
            (snapshot.status == GaussMathOcrModelInstallStatus.queued
                ? snapshot.hasInstallSession
                : (snapshot.status == GaussMathOcrModelInstallStatus.downloading ||
                    snapshot.status == GaussMathOcrModelInstallStatus.verifying));
    final interruptedSession = interruptedInstallSession || legacyStale;
    if (!interruptedSession) return snapshot;
    return snapshot.copyWith(
      status: GaussMathOcrModelInstallStatus.failed,
      progress: 0,
      offlineAvailable: false,
      stateUpdatedAtIso: now.toIso8601String(),
      failureMessage: GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.interruptedInstallSessionCopy,
    );
  }

  static Future<void> _persistActiveProgressSnapshot(GaussMathOcrModelSnapshot snapshot) async {
    final now = DateTime.now().toUtc();
    final last = _lastActiveProgressPersistedAt;
    if (last != null &&
        now.difference(last) <
            GaussCameraOcrDownloadSessionRecoveryRetryUxHardeningQ385R3Policy.activeProgressPersistCadence) {
      return;
    }
    _lastActiveProgressPersistedAt = now;
    await _persist(snapshot.copyWith(stateUpdatedAtIso: now.toIso8601String()));
  }

  static String _newInstallSessionId() =>
      '${GaussCameraOcrDownloadSessionRecoveryStateMachineQ385R4Policy.installSessionIdPrefix}${DateTime.now().toUtc().microsecondsSinceEpoch}';

  static String _nowIso() => DateTime.now().toUtc().toIso8601String();

  static Future<void> _persist(GaussMathOcrModelSnapshot snapshot) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_snapshotKey, snapshot.toJsonString());
  }
}
