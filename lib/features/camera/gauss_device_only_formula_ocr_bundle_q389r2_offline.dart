import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

import 'gauss_paddle_lite_nb_artifact_manifest_q387r1.dart';
import 'gauss_paddle_lite_nb_download_install_binding_q387r2.dart';


/// V172-Q389R6B — ONNX Runtime Mobile download-only integration contract.
///
/// Q389R6A proved that PP-FormulaNet_plus-S can be exported from the official
/// Paddle JSON graph to ONNX and opened by ONNX Runtime. R6B keeps the same
/// offline-only product rules: no backend, no ML Kit, no text OCR fallback, no
/// model bytes in the APK, and no fake LaTeX. The only network action remains
/// the explicit user-tapped "Modeli indir" bundle installation.
class GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy {
  const GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy._();

  static const String phase = 'V172-Q389R6B-ONNX-RUNTIME-MOBILE-DOWNLOAD-ONLY-INTEGRATION';
  static const String sourcePhase = 'V172-Q389R6A-FORMULA-OCR-MOBILE-RUNTIME-REALITY-CHECK';
  static const String status = 'PP_FORMULANET_PLUS_S_ONNX_RUNTIME_MOBILE_DOWNLOAD_ONLY_BINDING_READY_REQUIRES_RELEASE_MANIFEST';
  static const String manifestFormatVersion = 'q389r6b-onnx-runtime-mobile-bundle-manifest-v1';

  static const String modelId = 'pp_formulanet_plus_s_onnx_mobile';
  static const String modelDisplayName = 'PP-FormulaNet_plus-S ONNX offline formula OCR';
  static const String primaryEngine = 'ONNX Runtime Mobile device-only FormulaRecognition / PP-FormulaNet_plus-S';
  static const String installDirectoryName = 'ocr_models/PP-FormulaNet_plus-S-ONNX';
  static const String primaryRuntimeArtifactKind = 'onnx-runtime-model';
  static const String primaryRuntimeModelFileName = 'pp_formulanet_plus_s.onnx';
  static const String nativeRuntimeManifestFileName = 'q389r6b_onnx_runtime_manifest.json';
  static const String bundleManifestFileName = 'q389r6b_onnx_formula_ocr_bundle_manifest.json';
  static const String installedBundleEvidenceFileName = 'q389r6b_onnx_formula_ocr_install_evidence.json';
  static const String expectedOnnxSha256 = '575353f72a804215329b128ed1b85e8de65fdb4b06730ac8e7954bae5c44e64d';
  static const int expectedOnnxSizeBytes = 333913240;
  static const int minimumAcceptedOnnxSizeBytes = 100 * 1024 * 1024;

  static const bool backendAllowed = false;
  static const bool mlKitAllowed = false;
  static const bool textOcrFallbackAllowed = false;
  static const bool modelBundledInBaseApp = false;
  static const bool downloadOnlyModelDelivery = true;
  static const bool offlineAfterInstallRequired = true;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool workspaceImportRequiresEditableReview = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool onnxRuntimeDependencyRequired = true;
  static const bool androidRealDevicePassClaimedByPackage = false;
}

/// V172-Q389R2_OFFLINE — device-only Formula OCR runtime bundle contract.
///
/// This is the offline-only successor of the discarded Q389R2 backend branch.
/// It never sends camera images to a backend, never uses ML Kit, and never
/// fabricates LaTeX. The only allowed network use is the user-approved
/// "Modeli indir" action that downloads a signed/hashed device runtime bundle
/// into app-private storage. Once installed, Q378/Q381 run the local ONNX
/// Runtime Mobile model path and return a MathLive review candidate only if
/// the native output decoder yields real LaTeX.
class GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy {
  const GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy._();

  static const String phase = 'V172-Q389R2_OFFLINE-DEVICE-ONLY-FORMULA-OCR-FULL-CLOSURE';
  static const String sourcePhase = 'V172-Q389R1-FORMULA-OCR-PRIMARY-NO-TEXT-FALLBACK-CONTRACT';
  static const String status = 'DEVICE_ONLY_FORMULA_OCR_BUNDLE_INSTALLER_READY_PRODUCTION_BUNDLE_SOURCE_REQUIRED';

  static const String modelId = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.modelId;
  static const String modelDisplayName = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.modelDisplayName;
  static const String primaryEngine = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryEngine;
  static const String installDirectoryName = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.installDirectoryName;
  static const String bundleManifestFileName = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.bundleManifestFileName;
  // Native manifest literal required by Android bridge: q387r1_paddle_lite_nb_manifest.json
  static const String installedBundleEvidenceFileName = GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.installedBundleEvidenceFileName;
  static const String productionBundleManifestUrlDefineName = 'MATHPRO_OFFLINE_FORMULA_OCR_BUNDLE_MANIFEST_URL';
  static const String productionBundleManifestUrl = String.fromEnvironment(productionBundleManifestUrlDefineName, defaultValue: '');

  static const String productionBundleSourceNotBound = 'q389r2-offline-production-bundle-source-not-bound';
  static const String manifestDownloadFailed = 'q389r2-offline-bundle-manifest-download-failed';
  static const String manifestInvalid = 'q389r2-offline-bundle-manifest-invalid';
  static const String requiredFileMissing = 'q389r2-offline-required-file-missing';
  static const String sha256Mismatch = 'q389r2-offline-file-sha256-mismatch';
  static const String artifactTooSmall = 'q389r2-offline-file-too-small';

  static const bool backendAllowed = false;
  static const bool mlKitAllowed = false;
  static const bool textOcrFallbackAllowed = false;
  static const bool modelBundledInBaseApp = false;
  static const bool downloadOnlyModelDelivery = true;
  static const bool offlineAfterInstallRequired = true;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool workspaceImportRequiresEditableReview = true;
  static const bool explicitUserApprovalRequiredBeforeWorkspaceImport = true;
  static const bool directSolveGraphSolutionHistoryBlocked = true;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
  static const bool ocrPassClaimedByPackage = false;
  static const bool androidRealDevicePassClaimedByPackage = false;
}


/// V172-Q389R3_OFFLINE — real artifact production/download binding hardening.
///
/// This phase does not change the user-visible camera UI. It hardens the
/// already offline-only Q389R2 installer so the app can be considered
/// software-complete once a real hosted PP-FormulaNet_plus Paddle Lite `.nb`
/// bundle manifest is supplied. No backend, no ML Kit, no fake LaTeX.
class GaussDeviceOnlyFormulaOcrBundleQ389R3OfflinePolicy {
  const GaussDeviceOnlyFormulaOcrBundleQ389R3OfflinePolicy._();

  static const String phase = 'V172-Q389R3_OFFLINE-REAL-MODEL-ARTIFACT-DOWNLOAD-BINDING';
  static const String sourcePhase = GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.phase;
  static const String status = 'DEVICE_ONLY_FORMULA_OCR_REAL_ARTIFACT_BINDING_READY_REQUIRES_HOSTED_NB_BUNDLE';
  static const bool backendAllowed = false;
  static const bool mlKitAllowed = false;
  static const bool textOcrFallbackAllowed = false;
  static const bool modelBundledInBaseApp = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool modelDownloadButtonMustInstallCompleteBundle = true;
  static const bool offlineAfterVerifiedInstallRequired = true;
}



/// V172-Q389R4_OFFLINE — production bundle completeness closure.
///
/// This is the final app-side artifact gate before real device OCR evidence:
/// the bundle is accepted only when it contains the model, decoder sidecar,
/// preprocess metadata, provenance, SHA256 evidence, and no backend/text fallback
/// contract breach. It still does not bundle model bytes in the base app.
class GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy {
  const GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy._();

  static const String phase = 'V172-Q389R4_OFFLINE-PRODUCTION-BUNDLE-COMPLETENESS-CLOSURE';
  static const String sourcePhase = GaussDeviceOnlyFormulaOcrBundleQ389R3OfflinePolicy.phase;
  static const String status = 'DEVICE_ONLY_FORMULA_OCR_PRODUCTION_BUNDLE_GATE_READY_REQUIRES_REAL_HOSTED_ARTIFACTS';
  static const String manifestFormatVersion = 'q389r4-offline-bundle-manifest-v1';
  static const String missingDecoderSidecar = 'q389r4-offline-decoder-sidecar-missing';
  static const String missingPreprocessMetadata = 'q389r4-offline-preprocess-metadata-missing';
  static const String unsafeBundleFileName = 'q389r4-offline-unsafe-bundle-file-name';
  static const String unsupportedModelFamily = 'q389r4-offline-unsupported-model-family';

  static const bool backendAllowed = false;
  static const bool mlKitAllowed = false;
  static const bool textOcrFallbackAllowed = false;
  static const bool modelBundledInBaseApp = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool requiresNbModel = true;
  static const bool requiresDecoderSidecar = true;
  static const bool requiresPreprocessMetadata = true;
  static const bool requiresExactSha256 = true;
  static const bool requiresExactSizeBytes = true;
  static const bool offlineAfterVerifiedInstallRequired = true;
}


class GaussQ389R2OfflineBundleFile {
  const GaussQ389R2OfflineBundleFile({
    required this.role,
    required this.fileName,
    required this.downloadUrl,
    required this.sha256,
    required this.sizeBytes,
    required this.required,
  });

  final String role;
  final String fileName;
  final String downloadUrl;
  final String sha256;
  final int sizeBytes;
  final bool required;

  bool get isNbModel => fileName.toLowerCase().endsWith('.nb') || role == 'paddle-lite-nb-model';
  bool get isOnnxModel {
    final lowerName = fileName.toLowerCase();
    final lowerRole = role.toLowerCase();
    return lowerName.endsWith('.onnx') || lowerRole == GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryRuntimeArtifactKind || lowerRole.contains('onnx');
  }

  bool get isRuntimeModel => isOnnxModel || isNbModel || role.toLowerCase().contains('runtime-model');
  bool get isDecoderSidecar {
    final lowerName = fileName.toLowerCase();
    final lowerRole = role.toLowerCase();
    return lowerRole.contains('decoder') || lowerRole.contains('token') || lowerRole.contains('vocab') || lowerName.contains('tokenizer') || lowerName.contains('tokens') || lowerName.contains('vocab');
  }

  bool get isPreprocessMetadata {
    final lowerName = fileName.toLowerCase();
    final lowerRole = role.toLowerCase();
    return lowerRole.contains('preprocess') || lowerRole.contains('metadata') || lowerName.contains('preprocess') || lowerName.contains('metadata') || lowerName.contains('shape');
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'role': role,
        'fileName': fileName,
        'downloadUrl': downloadUrl,
        'sha256': sha256,
        'sizeBytes': sizeBytes,
        'required': required,
      };
}

class GaussQ389R2OfflineBundleManifest {
  const GaussQ389R2OfflineBundleManifest({
    required this.modelId,
    required this.modelDisplayName,
    required this.sourceRevision,
    required this.conversionProvenance,
    required this.files,
  });

  final String modelId;
  final String modelDisplayName;
  final String sourceRevision;
  final String conversionProvenance;
  final List<GaussQ389R2OfflineBundleFile> files;

  GaussQ389R2OfflineBundleFile get runtimeModelFile => files.firstWhere(
        (file) => file.isRuntimeModel,
        orElse: () => throw const GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:missing-runtime-model-file',
        ),
      );

  // Legacy alias preserved for older Q389/Q387 tests and manager code. In R6B it
  // points to the primary runtime model, which is ONNX rather than `.nb`.
  GaussQ389R2OfflineBundleFile get nbModelFile => runtimeModelFile;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.phase,
        'manifestFormatVersion': GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.manifestFormatVersion,
        'modelId': modelId,
        'modelDisplayName': modelDisplayName,
        'sourceRevision': sourceRevision,
        'conversionProvenance': conversionProvenance,
        'primaryRuntimeArtifactKind': GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryRuntimeArtifactKind,
        'primaryRuntimeModelFileName': GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryRuntimeModelFileName,
        'onnxRuntimeMobileRequired': true,
        'files': files.map((file) => file.toJson()).toList(growable: false),
        'backendAllowed': false,
        'mlKitAllowed': false,
        'textOcrFallbackAllowed': false,
        'modelBundledInBaseApp': false,
      };

  static GaussQ389R2OfflineBundleManifest parse(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:root-not-object',
      );
    }
    final filesJson = decoded['files'];
    if (filesJson is! List || filesJson.isEmpty) {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:files-empty',
      );
    }
    final files = <GaussQ389R2OfflineBundleFile>[];
    for (final item in filesJson) {
      if (item is! Map<String, dynamic>) {
        throw const GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:file-not-object',
        );
      }
      final role = (item['role'] as String? ?? '').trim();
      final fileName = (item['fileName'] as String? ?? '').trim();
      final downloadUrl = (item['downloadUrl'] as String? ?? item['url'] as String? ?? '').trim();
      final sha256 = (item['sha256'] as String? ?? '').trim().toLowerCase();
      final sizeBytes = item['sizeBytes'] is int ? item['sizeBytes'] as int : int.tryParse('${item['sizeBytes']}') ?? 0;
      final required = item['required'] != false;
      if (role.isEmpty || fileName.isEmpty || downloadUrl.isEmpty || !RegExp(r'^https://').hasMatch(downloadUrl)) {
        throw GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:bad-file-entry:$fileName',
        );
      }
      if (fileName.contains('/') || fileName.contains('\\') || fileName == '.' || fileName == '..' || fileName.contains('..')) {
        throw GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.unsafeBundleFileName}:$fileName',
        );
      }
      if (!RegExp(r'^[a-f0-9]{64}$').hasMatch(sha256) || sizeBytes <= 0) {
        throw GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:bad-evidence:$fileName',
        );
      }
      files.add(GaussQ389R2OfflineBundleFile(
        role: role,
        fileName: fileName,
        downloadUrl: downloadUrl,
        sha256: sha256,
        sizeBytes: sizeBytes,
        required: required,
      ));
    }
    final manifest = GaussQ389R2OfflineBundleManifest(
      modelId: (decoded['modelId'] as String? ?? GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.modelId).trim(),
      modelDisplayName: (decoded['modelDisplayName'] as String? ?? GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.modelDisplayName).trim(),
      sourceRevision: (decoded['sourceRevision'] as String? ?? '').trim(),
      conversionProvenance: (decoded['conversionProvenance'] as String? ?? '').trim(),
      files: files,
    );
    if (manifest.conversionProvenance.isEmpty || manifest.sourceRevision.isEmpty) {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:missing-provenance-or-revision',
      );
    }
    final modelIdLower = manifest.modelId.toLowerCase();
    final displayNameLower = manifest.modelDisplayName.toLowerCase();
    if (!modelIdLower.contains('formulanet') && !displayNameLower.contains('formulanet')) {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.unsupportedModelFamily,
      );
    }
    if (!manifest.files.any((file) => file.required && file.isDecoderSidecar)) {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.missingDecoderSidecar,
      );
    }
    if (!manifest.files.any((file) => file.required && file.isPreprocessMetadata)) {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.missingPreprocessMetadata,
      );
    }
    final runtimeModel = manifest.runtimeModelFile;
    if (runtimeModel.isOnnxModel) {
      if (runtimeModel.sizeBytes < GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.minimumAcceptedOnnxSizeBytes) {
        throw const GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:onnx-too-small',
        );
      }
    } else if (runtimeModel.isNbModel) {
      if (runtimeModel.sizeBytes < GaussPaddleLiteNbArtifactManifestQ387R1Policy.minimumAcceptedNbSizeBytes) {
        throw const GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:nb-too-small',
        );
      }
    } else {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestInvalid}:unsupported-runtime-model',
      );
    }
    return manifest;
  }
}

class GaussQ389R2OfflineFormulaOcrInstallEvidence {
  const GaussQ389R2OfflineFormulaOcrInstallEvidence({
    required this.installDirectoryPath,
    required this.nbModelPath,
    required this.nbSha256,
    required this.nbSizeBytes,
    required this.installedFiles,
  });

  final String installDirectoryPath;
  final String nbModelPath;
  final String nbSha256;
  final int nbSizeBytes;
  final List<String> installedFiles;
}

class GaussQ389R2OfflineFormulaOcrBundleException implements Exception {
  const GaussQ389R2OfflineFormulaOcrBundleException(this.message);
  final String message;
  @override
  String toString() => message;
}

class GaussQ389R2OfflineFormulaOcrBundleInstaller {
  const GaussQ389R2OfflineFormulaOcrBundleInstaller._();

  static Future<GaussQ389R2OfflineFormulaOcrInstallEvidence> installProductionBundle({
    required Directory appFilesDirectory,
    FutureOr<void> Function(double progress)? onProgress,
  }) async {
    final manifestUrl = GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.productionBundleManifestUrl.trim();
    if (manifestUrl.isEmpty || !manifestUrl.startsWith('https://')) {
      throw const GaussQ389R2OfflineFormulaOcrBundleException(
        GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.productionBundleSourceNotBound,
      );
    }
    final client = http.Client();
    try {
      final manifestResponse = await client.get(Uri.parse(manifestUrl)).timeout(const Duration(seconds: 45));
      if (manifestResponse.statusCode < 200 || manifestResponse.statusCode >= 300) {
        throw GaussQ389R2OfflineFormulaOcrBundleException(
          '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.manifestDownloadFailed}:http-${manifestResponse.statusCode}',
        );
      }
      final manifest = GaussQ389R2OfflineBundleManifest.parse(manifestResponse.body);
      // Q389R6Y: keep the HTTP client alive until the complete manifest-driven
      // model bundle download has finished. Returning the Future directly lets
      // the finally block close the client before the large ONNX file request.
      return await installVerifiedBundleManifest(
        appFilesDirectory: appFilesDirectory,
        manifest: manifest,
        client: client,
        onProgress: onProgress,
      );
    } finally {
      client.close();
    }
  }

  static Future<GaussQ389R2OfflineFormulaOcrInstallEvidence> installVerifiedBundleManifest({
    required Directory appFilesDirectory,
    required GaussQ389R2OfflineBundleManifest manifest,
    required http.Client client,
    FutureOr<void> Function(double progress)? onProgress,
  }) async {
    final installDir = Directory('${appFilesDirectory.path}/${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.installDirectoryName}');
    final tempDir = Directory('${installDir.path}/.q389r2_offline_tmp');
    await installDir.create(recursive: true);
    await tempDir.create(recursive: true);
    final installed = <String>[];
    try {
      final requiredFiles = manifest.files.where((file) => file.required).toList(growable: false);
      for (var index = 0; index < manifest.files.length; index += 1) {
        final file = manifest.files[index];
        final target = File('${installDir.path}/${file.fileName}');
        if (!await _existingFileIsValid(target, file)) {
          await _downloadFile(client: client, source: file, target: target, tempFile: File('${tempDir.path}/${file.fileName}.part'));
        }
        if (!await _existingFileIsValid(target, file)) {
          if (file.required) {
            throw GaussQ389R2OfflineFormulaOcrBundleException(
              '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.requiredFileMissing}:${file.fileName}',
            );
          }
        } else {
          installed.add(file.fileName);
        }
        await Future<void>.value(onProgress?.call(((index + 1) / manifest.files.length).clamp(0, 0.995).toDouble()));
      }
      for (final file in requiredFiles) {
        if (!installed.contains(file.fileName)) {
          throw GaussQ389R2OfflineFormulaOcrBundleException(
            '${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.requiredFileMissing}:${file.fileName}',
          );
        }
      }
      final runtimeModel = manifest.runtimeModelFile;
      final runtimeModelPath = File('${installDir.path}/${runtimeModel.fileName}');
      final actualRuntimeSha = await _sha256OfFile(runtimeModelPath);
      final actualRuntimeSize = await runtimeModelPath.length();
      if (runtimeModel.isNbModel) {
        await _writeAtomicText(File('${installDir.path}/${GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.nativeManifestFileName}'), const JsonEncoder.withIndent('  ').convert(<String, Object?>{
          'phase': GaussPaddleLiteNbArtifactManifestQ387R1Policy.phase,
          'sourcePhase': GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy.phase,
          'artifactKind': GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredArtifactKind,
          'fileName': runtimeModel.fileName,
          'sha256': actualRuntimeSha,
          'sizeBytes': actualRuntimeSize,
          'conversionProvenance': manifest.conversionProvenance,
          'sourceRevision': manifest.sourceRevision,
          'modelId': manifest.modelId,
          'modelDisplayName': manifest.modelDisplayName,
          'modelBinaryBundledInBaseApp': false,
          'backendAllowed': false,
          'mlKitAllowed': false,
          'textOcrFallbackAllowed': false,
          'productionInferenceClaimed': false,
          'installedAtIso': DateTime.now().toUtc().toIso8601String(),
        }));
      }
      await _writeAtomicText(File('${installDir.path}/${GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.nativeRuntimeManifestFileName}'), const JsonEncoder.withIndent('  ').convert(<String, Object?>{
        'phase': GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.phase,
        'sourcePhase': GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.sourcePhase,
        'artifactKind': runtimeModel.isOnnxModel ? GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryRuntimeArtifactKind : GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredArtifactKind,
        'fileName': runtimeModel.fileName,
        'fileName': runtimeModel.fileName,
        'sha256': actualRuntimeSha,
        'sizeBytes': actualRuntimeSize,
        'conversionProvenance': manifest.conversionProvenance,
        'sourceRevision': manifest.sourceRevision,
        'modelId': manifest.modelId,
        'modelDisplayName': manifest.modelDisplayName,
        'runtimeEngine': runtimeModel.isOnnxModel ? GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryEngine : GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.primaryEngine,
        'modelBinaryBundledInBaseApp': false,
        'backendAllowed': false,
        'mlKitAllowed': false,
        'textOcrFallbackAllowed': false,
        'productionInferenceClaimed': false,
        'installedAtIso': DateTime.now().toUtc().toIso8601String(),
      }));
      await _writeAtomicText(File('${installDir.path}/${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.bundleManifestFileName}'), const JsonEncoder.withIndent('  ').convert(manifest.toJson()));
      await _writeAtomicText(File('${installDir.path}/${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.installedBundleEvidenceFileName}'), const JsonEncoder.withIndent('  ').convert(<String, Object?>{
        'phase': GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.phase,
        'installDirectoryPath': installDir.path,
        'runtimeModelPath': runtimeModelPath.path,
        'runtimeSha256': actualRuntimeSha,
        'runtimeSizeBytes': actualRuntimeSize,
        'runtimeArtifactKind': runtimeModel.isOnnxModel ? GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy.primaryRuntimeArtifactKind : GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredArtifactKind,
        'nbModelPath': runtimeModelPath.path,
        'nbSha256': actualRuntimeSha,
        'nbSizeBytes': actualRuntimeSize,
        'installedFiles': installed,
        'offlineAfterInstallRequired': true,
        'backendAllowed': false,
        'mlKitAllowed': false,
        'textOcrFallbackAllowed': false,
        'directSolveGraphSolutionHistoryBlocked': true,
        'q389r4ProductionBundleCompletenessVerified': true,
        'q389r6bOnnxRuntimeDownloadOnlyBinding': runtimeModel.isOnnxModel,
        'offlineFormulaOcrReadyAfterInstall': true,
        'installedAtIso': DateTime.now().toUtc().toIso8601String(),
      }));
      await Future<void>.value(onProgress?.call(1));
      return GaussQ389R2OfflineFormulaOcrInstallEvidence(
        installDirectoryPath: installDir.path,
        nbModelPath: runtimeModelPath.path,
        nbSha256: actualRuntimeSha,
        nbSizeBytes: actualRuntimeSize,
        installedFiles: installed,
      );
    } finally {
      if (await tempDir.exists()) await tempDir.delete(recursive: true);
    }
  }

  static Future<void> _downloadFile({
    required http.Client client,
    required GaussQ389R2OfflineBundleFile source,
    required File target,
    required File tempFile,
  }) async {
    await tempFile.parent.create(recursive: true);
    if (await tempFile.exists()) await tempFile.delete();
    final response = await client.send(http.Request('GET', Uri.parse(source.downloadUrl))..followRedirects = true).timeout(const Duration(minutes: 5));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw GaussQ389R2OfflineFormulaOcrBundleException('q389r2-offline-http-${response.statusCode}:${source.fileName}');
    }
    final output = tempFile.openWrite();
    final digestSink = _Q389R2DigestSink();
    final byteSink = crypto.sha256.startChunkedConversion(digestSink);
    var downloaded = 0;
    try {
      await for (final chunk in response.stream.timeout(const Duration(seconds: 45))) {
        downloaded += chunk.length;
        byteSink.add(chunk);
        output.add(chunk);
      }
    } finally {
      await output.close();
      byteSink.close();
    }
    if (downloaded != source.sizeBytes) {
      await _safeDelete(tempFile);
      throw GaussQ389R2OfflineFormulaOcrBundleException('${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.artifactTooSmall}:${source.fileName}:$downloaded');
    }
    final digest = digestSink.valueOrThrow('q389r2-offline-digest-missing:${source.fileName}').toString();
    if (digest.toLowerCase() != source.sha256.toLowerCase()) {
      await _safeDelete(tempFile);
      throw GaussQ389R2OfflineFormulaOcrBundleException('${GaussDeviceOnlyFormulaOcrBundleQ389R2OfflinePolicy.sha256Mismatch}:${source.fileName}:$digest');
    }
    if (await target.exists()) await target.delete();
    await tempFile.rename(target.path);
  }

  static Future<bool> _existingFileIsValid(File file, GaussQ389R2OfflineBundleFile source) async {
    if (!await file.exists()) return false;
    final length = await file.length();
    if (length != source.sizeBytes) return false;
    final digest = await _sha256OfFile(file);
    return digest.toLowerCase() == source.sha256.toLowerCase();
  }

  static Future<String> _sha256OfFile(File file) async {
    final digestSink = _Q389R2DigestSink();
    final byteSink = crypto.sha256.startChunkedConversion(digestSink);
    await for (final chunk in file.openRead()) {
      byteSink.add(chunk);
    }
    byteSink.close();
    return digestSink.valueOrThrow('q389r2-offline-file-digest-missing:${file.path}').toString();
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
}

class _Q389R2DigestSink implements Sink<crypto.Digest> {
  crypto.Digest? _digest;
  @override
  void add(crypto.Digest data) => _digest = data;
  @override
  void close() {}
  crypto.Digest valueOrThrow(String message) {
    final digest = _digest;
    if (digest == null) throw GaussQ389R2OfflineFormulaOcrBundleException(message);
    return digest;
  }
}
