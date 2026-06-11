import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

import 'gauss_camera_ocr_download_compile_legacy_verifier_recovery_q385r2.dart';
import 'gauss_paddle_lite_nb_artifact_manifest_q387r1.dart';

/// V172-Q387R2 — real Paddle Lite .nb source intake / download-install binding.
///
/// Q387R1 made the `.nb` artifact evidence contract explicit. Q387R2 adds the
/// download/install worker that can only run when a real HTTPS `.nb` source,
/// SHA256, size, and conversion provenance are supplied. It deliberately keeps
/// production source binding disabled because no verified PP-FormulaNet-S `.nb`
/// artifact is present in the package, and it still never bundles a model or
/// fabricates OCR output.
class GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy {
  const GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy._();

  static const String phase = 'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING';
  static const String sourcePhase = 'V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE';
  static const String status = 'REAL_NB_DOWNLOAD_INSTALL_WORKER_READY_BUT_PRODUCTION_ARTIFACT_SOURCE_NOT_BOUND';

  static const String modelId = 'pp_formulanet_s';
  static const String modelDisplayName = 'PP-FormulaNet-S';
  static const String artifactKind = GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredArtifactKind;
  static const String installDirectoryName = 'ocr_models/PP-FormulaNet-S-PaddleLiteNb';
  // Native manifest file name literal: q387r1_paddle_lite_nb_manifest.json
  static const String nativeManifestFileName = GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredManifestFileName;
  static const String installManifestFileName = 'q387r2_paddle_lite_nb_install_manifest.json';

  static const String productionNbSourceMissingBlockedReason = 'q387r2-production-paddle-lite-nb-source-not-bound';
  static const String q387R1EvidenceRejectedBlockedReason = 'q387r2-q387r1-nb-evidence-rejected';
  static const String contentLengthTooSmallBlockedReason = 'q387r2-nb-content-length-too-small';
  static const String downloadedArtifactTooSmallBlockedReason = 'q387r2-nb-artifact-too-small';
  static const String sha256MismatchBlockedReason = 'q387r2-nb-sha256-mismatch';
  static const String installManifestWriteFailedBlockedReason = 'q387r2-install-manifest-write-failed';

  static const bool productionNbDownloadUrlBound = false;
  static const bool productionNbSha256Bound = false;
  static const bool productionNbSizeBound = false;
  static const bool downloadInstallWorkerImplemented = true;
  static const bool q387R1EvidenceGateRequiredBeforeDownload = true;
  static const bool writesQ387R1NativeManifest = true;
  static const bool writesQ387R2InstallManifest = true;
  static const bool legacyInferenceDirectoryDownloadPreservedForAuditOnly = true;
  static const bool legacyInferenceDirectoryPromotedToAndroidRuntime = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R2 = false;
  static const bool androidRealDevicePassClaimedByQ387R2 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussQ387R2PaddleLiteNbSource {
  const GaussQ387R2PaddleLiteNbSource({
    required this.fileName,
    required this.downloadUrl,
    required this.sha256,
    required this.sizeBytes,
    required this.conversionProvenance,
    this.sourceRevision,
  });

  final String fileName;
  final String downloadUrl;
  final String sha256;
  final int sizeBytes;
  final String conversionProvenance;
  final String? sourceRevision;

  GaussPaddleLiteNbArtifactCandidateQ387R1 toQ387R1Candidate() {
    return GaussPaddleLiteNbArtifactCandidateQ387R1(
      fileName: fileName,
      downloadUrl: downloadUrl,
      sha256: sha256,
      sizeBytes: sizeBytes,
      conversionProvenance: conversionProvenance,
      bundledInBaseApp: false,
    );
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'artifactKind': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.artifactKind,
        'fileName': fileName,
        'downloadUrl': downloadUrl,
        'sha256': sha256,
        'sizeBytes': sizeBytes,
        'conversionProvenance': conversionProvenance,
        'sourceRevision': sourceRevision,
      };
}

class GaussQ387R2PaddleLiteNbInstallEvidence {
  const GaussQ387R2PaddleLiteNbInstallEvidence({
    required this.phase,
    required this.installDirectoryPath,
    required this.nbModelPath,
    required this.q387R1NativeManifestPath,
    required this.q387R2InstallManifestPath,
    required this.sha256,
    required this.sizeBytes,
  });

  final String phase;
  final String installDirectoryPath;
  final String nbModelPath;
  final String q387R1NativeManifestPath;
  final String q387R2InstallManifestPath;
  final String sha256;
  final int sizeBytes;
}

class GaussQ387R2PaddleLiteNbDownloadInstallException implements Exception {
  const GaussQ387R2PaddleLiteNbDownloadInstallException(this.message);

  final String message;

  @override
  String toString() => message;
}

class GaussQ387R2PaddleLiteNbDownloadInstallWorker {
  const GaussQ387R2PaddleLiteNbDownloadInstallWorker._();

  static Future<GaussQ387R2PaddleLiteNbInstallEvidence> installFromVerifiedSource({
    required Directory appFilesDirectory,
    required GaussQ387R2PaddleLiteNbSource source,
    FutureOr<void> Function(double progress)? onProgress,
  }) async {
    final q387R1Gate = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(
      candidate: source.toQ387R1Candidate(),
    );
    if (!q387R1Gate.canProceedToQ387R2DownloadInstall) {
      throw GaussQ387R2PaddleLiteNbDownloadInstallException(
        '${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.q387R1EvidenceRejectedBlockedReason}:${q387R1Gate.blockedReason}',
      );
    }

    final installDir = Directory('${appFilesDirectory.path}/${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.installDirectoryName}');
    final tempDir = Directory('${installDir.path}/.q387r2_tmp');
    await installDir.create(recursive: true);
    await tempDir.create(recursive: true);

    final target = File('${installDir.path}/${source.fileName}');
    final tempFile = File('${tempDir.path}/${source.fileName}.part');
    final client = http.Client();
    try {
      if (!await _existingNbArtifactIsValid(target, source)) {
        await _downloadAndVerifyNbArtifact(
          client: client,
          source: source,
          target: target,
          tempFile: tempFile,
          onProgress: onProgress,
        );
      }

      final actualSha = await _sha256OfFile(target);
      final actualSize = await target.length();
      if (actualSha.toLowerCase() != source.sha256.toLowerCase()) {
        throw GaussQ387R2PaddleLiteNbDownloadInstallException(
          '${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.sha256MismatchBlockedReason}:$actualSha',
        );
      }
      if (actualSize < GaussPaddleLiteNbArtifactManifestQ387R1Policy.minimumAcceptedNbSizeBytes || actualSize < source.sizeBytes) {
        throw GaussQ387R2PaddleLiteNbDownloadInstallException(
          '${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.downloadedArtifactTooSmallBlockedReason}:$actualSize',
        );
      }

      final q387R1Manifest = File('${installDir.path}/${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.nativeManifestFileName}');
      final q387R2Manifest = File('${installDir.path}/${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.installManifestFileName}');
      await _writeAtomicText(
        q387R1Manifest,
        const JsonEncoder.withIndent('  ').convert(<String, Object?>{
          'phase': GaussPaddleLiteNbArtifactManifestQ387R1Policy.phase,
          'sourcePhase': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.phase,
          'artifactKind': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.artifactKind,
          'fileName': source.fileName,
          'sha256': actualSha,
          'sizeBytes': actualSize,
          'conversionProvenance': source.conversionProvenance,
          'downloadUrl': source.downloadUrl,
          'sourceRevision': source.sourceRevision,
          'modelId': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.modelId,
          'modelDisplayName': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.modelDisplayName,
          'modelBinaryBundledInBaseApp': false,
          'onnxRuntimeReintroducedInBaseApk': false,
          'productionInferenceClaimed': false,
          'installedAtIso': DateTime.now().toUtc().toIso8601String(),
        }),
      );
      await _writeAtomicText(
        q387R2Manifest,
        const JsonEncoder.withIndent('  ').convert(<String, Object?>{
          'phase': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.phase,
          'sourcePhase': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.sourcePhase,
          'status': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.status,
          'q387R1NativeManifestPath': q387R1Manifest.path,
          'nbModelPath': target.path,
          'sha256': actualSha,
          'sizeBytes': actualSize,
          'source': source.toJson(),
          'downloadInstallWorkerImplemented': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.downloadInstallWorkerImplemented,
          'writesQ387R1NativeManifest': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.writesQ387R1NativeManifest,
          'writesQ387R2InstallManifest': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.writesQ387R2InstallManifest,
          'modelBinaryBundledInBaseApp': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.modelBinaryBundledInBaseApp,
          'onnxRuntimeReintroducedInBaseApk': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.onnxRuntimeReintroducedInBaseApk,
          'productionInferencePassClaimedByQ387R2': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.productionInferencePassClaimedByQ387R2,
          'androidRealDevicePassClaimedByQ387R2': GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.androidRealDevicePassClaimedByQ387R2,
          'installedAtIso': DateTime.now().toUtc().toIso8601String(),
        }),
      );
      await Future<void>.value(onProgress?.call(1));
      return GaussQ387R2PaddleLiteNbInstallEvidence(
        phase: GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.phase,
        installDirectoryPath: installDir.path,
        nbModelPath: target.path,
        q387R1NativeManifestPath: q387R1Manifest.path,
        q387R2InstallManifestPath: q387R2Manifest.path,
        sha256: actualSha,
        sizeBytes: actualSize,
      );
    } finally {
      client.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }

  static Future<void> _downloadAndVerifyNbArtifact({
    required http.Client client,
    required GaussQ387R2PaddleLiteNbSource source,
    required File target,
    required File tempFile,
    required FutureOr<void> Function(double progress)? onProgress,
  }) async {
    if (await tempFile.exists()) await tempFile.delete();
    await tempFile.parent.create(recursive: true);

    final request = http.Request('GET', Uri.parse(source.downloadUrl));
    request.followRedirects = true;
    final response = await client.send(request).timeout(
      GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.requestTimeout,
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw GaussQ387R2PaddleLiteNbDownloadInstallException('q387r2-http-${response.statusCode}:${source.fileName}');
    }
    final contentLength = response.contentLength;
    if (contentLength != null && contentLength > 0 && contentLength < source.sizeBytes) {
      throw GaussQ387R2PaddleLiteNbDownloadInstallException(
        '${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.contentLengthTooSmallBlockedReason}:${source.fileName}:$contentLength',
      );
    }

    final digestSink = _GaussQ387R2DigestCaptureSink();
    final byteSink = crypto.sha256.startChunkedConversion(digestSink);
    final output = tempFile.openWrite();
    var downloaded = 0;
    try {
      await for (final chunk in response.stream.timeout(
        GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.streamIdleTimeout,
      )) {
        downloaded += chunk.length;
        byteSink.add(chunk);
        output.add(chunk);
        await Future<void>.value(onProgress?.call((downloaded / source.sizeBytes).clamp(0, 0.995).toDouble()));
      }
    } finally {
      await output.close();
      byteSink.close();
    }

    if (downloaded < source.sizeBytes || downloaded < GaussPaddleLiteNbArtifactManifestQ387R1Policy.minimumAcceptedNbSizeBytes) {
      await _safeDelete(tempFile);
      throw GaussQ387R2PaddleLiteNbDownloadInstallException(
        '${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.downloadedArtifactTooSmallBlockedReason}:${source.fileName}:$downloaded',
      );
    }

    final actualSha = digestSink.valueOrThrow('q387r2-download-digest-missing:${source.fileName}').toString();
    if (source.sha256.toLowerCase() != actualSha.toLowerCase()) {
      await _safeDelete(tempFile);
      throw GaussQ387R2PaddleLiteNbDownloadInstallException(
        '${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.sha256MismatchBlockedReason}:${source.fileName}:$actualSha',
      );
    }

    if (await target.exists()) await target.delete();
    await tempFile.rename(target.path);
  }

  static Future<bool> _existingNbArtifactIsValid(File file, GaussQ387R2PaddleLiteNbSource source) async {
    if (!await file.exists()) return false;
    final length = await file.length();
    if (length < source.sizeBytes || length < GaussPaddleLiteNbArtifactManifestQ387R1Policy.minimumAcceptedNbSizeBytes) return false;
    final actual = await _sha256OfFile(file);
    return actual.toLowerCase() == source.sha256.toLowerCase();
  }

  static Future<String> _sha256OfFile(File file) async {
    final digestSink = _GaussQ387R2DigestCaptureSink();
    final byteSink = crypto.sha256.startChunkedConversion(digestSink);
    await for (final chunk in file.openRead()) {
      byteSink.add(chunk);
    }
    byteSink.close();
    return digestSink.valueOrThrow('q387r2-file-digest-missing:${file.path}').toString();
  }

  static Future<void> _writeAtomicText(File target, String text) async {
    try {
      final tmp = File('${target.path}.tmp');
      await tmp.writeAsString(text, flush: true);
      if (await target.exists()) await target.delete();
      await tmp.rename(target.path);
    } catch (error) {
      throw GaussQ387R2PaddleLiteNbDownloadInstallException(
        '${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.installManifestWriteFailedBlockedReason}:$error',
      );
    }
  }

  static Future<void> _safeDelete(File file) async {
    if (await file.exists()) await file.delete();
  }
}

class _GaussQ387R2DigestCaptureSink implements Sink<crypto.Digest> {
  crypto.Digest? _digest;

  @override
  void add(crypto.Digest data) {
    _digest = data;
  }

  @override
  void close() {}

  crypto.Digest valueOrThrow(String message) {
    final value = _digest;
    if (value == null) throw GaussQ387R2PaddleLiteNbDownloadInstallException(message);
    return value;
  }
}
