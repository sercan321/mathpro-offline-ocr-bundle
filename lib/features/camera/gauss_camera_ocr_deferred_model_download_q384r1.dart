import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

import 'gauss_camera_ocr_download_compile_legacy_verifier_recovery_q385r2.dart';

/// V172-Q384R1 — real deferred model download activation.
///
/// This phase activates the user-initiated network download, SHA256 verification,
/// and app-private atomic install chain for the PP-FormulaNet-S artifact without
/// bundling any model binary in the base APK and without re-adding ONNX Runtime.
class GaussCameraOcrDeferredModelDownloadQ384R1Policy {
  const GaussCameraOcrDeferredModelDownloadQ384R1Policy._();

  static const String phase = 'V172-Q384R1-CAMERA-OCR-DEFERRED-MODEL-DOWNLOAD-ACTIVATION';
  static const String sourcePhase = 'V172-Q384-BASE-APK-OCR-RUNTIME-SLIMMING-DOWNLOAD-ONLY-CONTRACT';
  static const String modelId = 'pp_formulanet_s';
  static const String modelDisplayName = 'PP-FormulaNet-S';
  static const String engine = 'PaddleOCR FormulaRecognition / PP-FormulaNet-S';
  static const String artifactFormat = 'paddle-inference-directory';
  static const String hfRevision = '0572450e501be9eb1b1cdb7e00fccf4b22fab4df';
  static const String installDirectoryName = 'ocr_models/PP-FormulaNet-S';
  static const String primaryModelFileName = 'inference.pdiparams';
  static const String expectedPrimarySha256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
  static const int expectedPrimarySizeApproxBytes = 232 * 1024 * 1024;

  static const bool productionDownloadUrlBound = true;
  static const bool realNetworkDownloadWorkerImplemented = true;
  static const bool sha256VerificationImplemented = true;
  static const bool appPrivateStorageAtomicInstallImplemented = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferenceClaimedByQ384R1 = false;
  static const bool directSolveFromCameraAllowed = false;
  static const bool workspaceImportRequiresUserReviewApproval = true;

  static const List<String> requiredArtifactNames = <String>[
    'config.json',
    'inference.json',
    'inference.yml',
    primaryModelFileName,
  ];
}

class GaussCameraOcrDownloadGuardRepairQ385R1Policy {
  const GaussCameraOcrDownloadGuardRepairQ385R1Policy._();

  static const String phase = 'V172-Q385R1-PADDLE-RUNTIME-ABI-TRIM-TEST-AND-DOWNLOAD-GUARD-REPAIR';
  static const String sourcePhase = 'V172-Q385-PADDLE-RUNTIME-ABI-TRIM-AND-DELIVERY-GUARD';
  static const String networkPolicy = 'user-approved-internet-required-large-download';
  static const bool wifiOnlyClaimRemoved = true;
  static const bool realWifiGateImplemented = false;
  static const bool sidecarMinimumsRelaxedToAvoidFalseRejects = true;
  static const bool contentLengthSanityCheckImplemented = true;
  static const bool primaryArtifactShaLockPreserved = true;
  static const bool sidecarShaLockClaimed = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferenceClaimedByQ385R1 = false;
}

class GaussQ384R1DeferredModelArtifact {
  const GaussQ384R1DeferredModelArtifact({
    required this.fileName,
    required this.url,
    required this.minimumSizeBytes,
    this.expectedSha256,
    this.expectedSizeBytes,
    this.documentedSizeLabel,
  });

  final String fileName;
  final String url;
  final int minimumSizeBytes;
  final int? expectedSizeBytes;
  final String? expectedSha256;
  final String? documentedSizeLabel;

  bool get requiresSha256 => expectedSha256 != null && expectedSha256!.trim().isNotEmpty;

  Map<String, Object?> toManifestJson() => <String, Object?>{
        'fileName': fileName,
        'url': url,
        'minimumSizeBytes': minimumSizeBytes,
        'expectedSizeBytes': expectedSizeBytes,
        'expectedSha256': expectedSha256,
        'documentedSizeLabel': documentedSizeLabel,
        'requiresSha256': requiresSha256,
        'q385r2VerificationKind': requiresSha256 ? 'sha256' : 'size-and-presence',
      };
}

class GaussQ384R1DeferredModelInstallEvidence {
  const GaussQ384R1DeferredModelInstallEvidence({
    required this.phase,
    required this.installDirectoryPath,
    required this.primaryModelPath,
    required this.installManifestPath,
    required this.installedFiles,
    required this.primarySha256,
    required this.totalInstalledBytes,
  });

  final String phase;
  final String installDirectoryPath;
  final String primaryModelPath;
  final String installManifestPath;
  final List<String> installedFiles;
  final String primarySha256;
  final int totalInstalledBytes;
}

class GaussQ384R1DeferredModelDownloadException implements Exception {
  const GaussQ384R1DeferredModelDownloadException(this.message);

  final String message;

  @override
  String toString() => message;
}

class GaussQ384R1DeferredModelDownloadWorker {
  const GaussQ384R1DeferredModelDownloadWorker._();

  static const String _baseResolveUrl = 'https://huggingface.co/PaddlePaddle/PP-FormulaNet-S/resolve/${GaussCameraOcrDeferredModelDownloadQ384R1Policy.hfRevision}';

  static const List<GaussQ384R1DeferredModelArtifact> artifacts = <GaussQ384R1DeferredModelArtifact>[
    GaussQ384R1DeferredModelArtifact(
      fileName: 'config.json',
      url: '$_baseResolveUrl/config.json?download=true',
      minimumSizeBytes: 64 * 1024,
      expectedSizeBytes: 3950 * 1024,
      documentedSizeLabel: '3.95 MB',
    ),
    GaussQ384R1DeferredModelArtifact(
      fileName: 'inference.json',
      url: '$_baseResolveUrl/inference.json?download=true',
      minimumSizeBytes: 32 * 1024,
      expectedSizeBytes: 505 * 1024,
      documentedSizeLabel: '505 kB',
    ),
    GaussQ384R1DeferredModelArtifact(
      fileName: 'inference.yml',
      url: '$_baseResolveUrl/inference.yml?download=true',
      minimumSizeBytes: 128 * 1024,
      expectedSizeBytes: 2240 * 1024,
      documentedSizeLabel: '2.24 MB',
    ),
    GaussQ384R1DeferredModelArtifact(
      fileName: GaussCameraOcrDeferredModelDownloadQ384R1Policy.primaryModelFileName,
      url: '$_baseResolveUrl/${GaussCameraOcrDeferredModelDownloadQ384R1Policy.primaryModelFileName}?download=true',
      minimumSizeBytes: 200 * 1024 * 1024,
      expectedSizeBytes: GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySizeApproxBytes,
      expectedSha256: GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySha256,
      documentedSizeLabel: '232 MB',
    ),
  ];

  static int get _estimatedTotalBytes => artifacts.fold<int>(0, (sum, artifact) => sum + (artifact.expectedSizeBytes ?? artifact.minimumSizeBytes));

  static Future<GaussQ384R1DeferredModelInstallEvidence> install({
    required Directory appFilesDirectory,
    FutureOr<void> Function(double progress)? onProgress,
  }) async {
    final installDir = Directory('${appFilesDirectory.path}/${GaussCameraOcrDeferredModelDownloadQ384R1Policy.installDirectoryName}');
    final tempDir = Directory('${installDir.path}/.q384r1_tmp');
    await installDir.create(recursive: true);
    await tempDir.create(recursive: true);

    final client = http.Client();
    var completedEstimateBytes = 0;
    final installedFiles = <String>[];
    try {
      for (final artifact in artifacts) {
        final target = File('${installDir.path}/${artifact.fileName}');
        if (await _existingArtifactIsValid(target, artifact)) {
          installedFiles.add(artifact.fileName);
          completedEstimateBytes += artifact.expectedSizeBytes ?? artifact.minimumSizeBytes;
          await Future<void>.value(onProgress?.call(_normalizedProgress(completedEstimateBytes / _estimatedTotalBytes)));
          continue;
        }

        final artifactProgressBase = completedEstimateBytes;
        await _downloadAndVerifyArtifact(
          client: client,
          artifact: artifact,
          target: target,
          tempFile: File('${tempDir.path}/${artifact.fileName}.part'),
          onArtifactProgress: (downloadedBytes) async {
            final artifactEstimate = artifact.expectedSizeBytes ?? artifact.minimumSizeBytes;
            final weighted = artifactProgressBase + downloadedBytes.clamp(0, artifactEstimate);
            await Future<void>.value(onProgress?.call(_normalizedProgress(weighted / _estimatedTotalBytes)));
          },
        );
        installedFiles.add(artifact.fileName);
        completedEstimateBytes += artifact.expectedSizeBytes ?? artifact.minimumSizeBytes;
        await Future<void>.value(onProgress?.call(_normalizedProgress(completedEstimateBytes / _estimatedTotalBytes)));
      }

      final primary = File('${installDir.path}/${GaussCameraOcrDeferredModelDownloadQ384R1Policy.primaryModelFileName}');
      if (!await primary.exists()) {
        throw const GaussQ384R1DeferredModelDownloadException('q384r1-primary-model-file-missing-after-install');
      }
      final primarySha = await _sha256OfFile(primary);
      if (primarySha != GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySha256) {
        throw GaussQ384R1DeferredModelDownloadException('q384r1-primary-sha256-mismatch:$primarySha');
      }

      final totalBytes = await _directoryFileBytes(installDir);
      final manifest = File('${installDir.path}/q384r1_install_manifest.json');
      await _writeAtomicText(
        manifest,
        const JsonEncoder.withIndent('  ').convert(<String, Object?>{
          'phase': GaussCameraOcrDeferredModelDownloadQ384R1Policy.phase,
          'sourcePhase': GaussCameraOcrDeferredModelDownloadQ384R1Policy.sourcePhase,
          'modelId': GaussCameraOcrDeferredModelDownloadQ384R1Policy.modelId,
          'modelDisplayName': GaussCameraOcrDeferredModelDownloadQ384R1Policy.modelDisplayName,
          'engine': GaussCameraOcrDeferredModelDownloadQ384R1Policy.engine,
          'artifactFormat': GaussCameraOcrDeferredModelDownloadQ384R1Policy.artifactFormat,
          'revision': GaussCameraOcrDeferredModelDownloadQ384R1Policy.hfRevision,
          'primaryModelFileName': GaussCameraOcrDeferredModelDownloadQ384R1Policy.primaryModelFileName,
          'primaryModelPath': primary.path,
          'primarySha256': primarySha,
          'installedFiles': installedFiles,
          'artifacts': artifacts.map((artifact) => artifact.toManifestJson()).toList(growable: false),
          'q385r2VerificationCopy': GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.sidecarVerificationCopy,
          'primarySha256Verified': true,
          'sidecarShaLockClaimed': false,
          'totalInstalledBytes': totalBytes,
          'modelBinaryBundledInBaseApp': GaussCameraOcrDeferredModelDownloadQ384R1Policy.modelBinaryBundledInBaseApp,
          'onnxRuntimeReintroducedInBaseApk': GaussCameraOcrDeferredModelDownloadQ384R1Policy.onnxRuntimeReintroducedInBaseApk,
          'productionInferenceClaimedByQ384R1': GaussCameraOcrDeferredModelDownloadQ384R1Policy.productionInferenceClaimedByQ384R1,
          'installedAtIso': DateTime.now().toUtc().toIso8601String(),
        }),
      );
      await Future<void>.value(onProgress?.call(1));
      return GaussQ384R1DeferredModelInstallEvidence(
        phase: GaussCameraOcrDeferredModelDownloadQ384R1Policy.phase,
        installDirectoryPath: installDir.path,
        primaryModelPath: primary.path,
        installManifestPath: manifest.path,
        installedFiles: List<String>.unmodifiable(installedFiles),
        primarySha256: primarySha,
        totalInstalledBytes: totalBytes,
      );
    } finally {
      client.close();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }

  static Future<void> _downloadAndVerifyArtifact({
    required http.Client client,
    required GaussQ384R1DeferredModelArtifact artifact,
    required File target,
    required File tempFile,
    required FutureOr<void> Function(int downloadedBytes) onArtifactProgress,
  }) async {
    if (await tempFile.exists()) await tempFile.delete();
    await tempFile.parent.create(recursive: true);

    final request = http.Request('GET', Uri.parse(artifact.url));
    request.followRedirects = true;
    final response = await client.send(request).timeout(
      GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.requestTimeout,
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw GaussQ384R1DeferredModelDownloadException('q384r1-http-${response.statusCode}:${artifact.fileName}');
    }
    final contentLength = response.contentLength;
    if (contentLength != null && contentLength > 0 && contentLength < artifact.minimumSizeBytes) {
      throw GaussQ384R1DeferredModelDownloadException('q385r1-content-length-too-small:${artifact.fileName}:$contentLength');
    }

    final digestSink = _GaussQ385R2DigestCaptureSink();
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
        await Future<void>.value(onArtifactProgress(downloaded));
      }
    } finally {
      await output.close();
      byteSink.close();
    }

    if (downloaded < artifact.minimumSizeBytes) {
      await _safeDelete(tempFile);
      throw GaussQ384R1DeferredModelDownloadException('q384r1-artifact-too-small:${artifact.fileName}:$downloaded');
    }

    final actualSha = digestSink.valueOrThrow('q385r2-download-digest-missing:${artifact.fileName}').toString();
    if (artifact.expectedSha256 != null && artifact.expectedSha256 != actualSha) {
      await _safeDelete(tempFile);
      throw GaussQ384R1DeferredModelDownloadException('q384r1-sha256-mismatch:${artifact.fileName}:$actualSha');
    }

    if (await target.exists()) await target.delete();
    await tempFile.rename(target.path);
  }

  static Future<bool> _existingArtifactIsValid(File file, GaussQ384R1DeferredModelArtifact artifact) async {
    if (!await file.exists()) return false;
    final length = await file.length();
    if (length < artifact.minimumSizeBytes) return false;
    if (artifact.expectedSha256 == null) return true;
    return _sha256OfFile(file).then((actual) => actual == artifact.expectedSha256);
  }

  static Future<String> _sha256OfFile(File file) async {
    final digestSink = _GaussQ385R2DigestCaptureSink();
    final byteSink = crypto.sha256.startChunkedConversion(digestSink);
    await for (final chunk in file.openRead()) {
      byteSink.add(chunk);
    }
    byteSink.close();
    return digestSink.valueOrThrow('q385r2-file-digest-missing:${file.path}').toString();
  }

  static Future<int> _directoryFileBytes(Directory directory) async {
    if (!await directory.exists()) return 0;
    var total = 0;
    await for (final entity in directory.list(recursive: true, followLinks: false)) {
      if (entity is File) total += await entity.length();
    }
    return total;
  }

  static Future<void> _writeAtomicText(File target, String text) async {
    final tmp = File('${target.path}.tmp');
    await tmp.writeAsString(text, flush: true);
    if (await target.exists()) await target.delete();
    await tmp.rename(target.path);
  }

  static Future<void> _safeDelete(File file) async {
    if (await file.exists()) await file.delete();
  }

  static double _normalizedProgress(num value) => value.clamp(0, 1).toDouble();
}


class _GaussQ385R2DigestCaptureSink implements Sink<crypto.Digest> {
  crypto.Digest? _digest;

  @override
  void add(crypto.Digest data) {
    _digest = data;
  }

  @override
  void close() {}

  crypto.Digest valueOrThrow(String message) {
    final value = _digest;
    if (value == null) throw GaussQ384R1DeferredModelDownloadException(message);
    return value;
  }
}
