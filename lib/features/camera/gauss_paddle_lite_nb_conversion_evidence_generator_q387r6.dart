import 'gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';

/// V172-Q387R6 — Paddle Lite .nb conversion evidence generator protocol.
///
/// Q387R5 can intake an externally produced `.nb` artifact, but it still
/// depends on a trustworthy conversion/build evidence bundle. Q387R6 defines
/// that bundle and the user-side generation protocol. It does not run Paddle
/// Lite in-app, does not bundle `.nb`, does not invent URL/SHA values, and does
/// not claim OCR/device success.
class GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy {
  const GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy._();

  static const String phase = 'V172-Q387R6-PADDLE-LITE-NB-CONVERSION-EVIDENCE-GENERATOR';
  static const String sourcePhase = 'V172-Q387R5-PADDLE-LITE-NB-EXTERNAL-ARTIFACT-INTAKE-CLOSURE';
  static const String status = 'CONVERSION_EVIDENCE_GENERATOR_READY_BUT_REAL_NB_BINARY_STILL_EXTERNAL';

  static const String targetModelId = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.targetModelId;
  static const String targetDisplayName = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.targetDisplayName;
  static const String requiredConversionTool = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredConversionTool;
  static const String requiredAndroidTarget = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredAndroidTarget;
  static const String requiredOutputExtension = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredOutputExtension;
  static const List<String> requiredSourceInferenceFiles = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredSourceInferenceFiles;

  static const String conversionEvidenceRequiredBlockedReason = 'q387r6-conversion-evidence-required';
  static const String sourceModelRevisionRequiredBlockedReason = 'q387r6-source-model-revision-required';
  static const String sourceInferenceFilesDigestRequiredBlockedReason = 'q387r6-source-inference-files-digest-required';
  static const String conversionToolRequiredBlockedReason = 'q387r6-paddle-lite-opt-tool-required';
  static const String conversionCommandRequiredBlockedReason = 'q387r6-conversion-command-required';
  static const String conversionLogDigestRequiredBlockedReason = 'q387r6-conversion-log-digest-required';
  static const String nbOutputDigestRequiredBlockedReason = 'q387r6-nb-output-sha-size-required';
  static const String downloadUrlRequiredBlockedReason = 'q387r6-immutable-https-nb-download-url-required';
  static const String provenanceRequiredBlockedReason = 'q387r6-conversion-provenance-required';
  static const String baseBundleRejectedBlockedReason = 'q387r6-base-apk-model-bundling-rejected';
  static const String q387R3EvidenceRejectedBlockedReason = 'q387r6-q387r3-evidence-rejected';
  static const String q387R5IntakeTargetStatus = 'q387r6-q387r5-intake-evidence-json-ready';

  static const int minimumImmutableRevisionHexLength = 12;
  static const int minimumAcceptedNbSizeBytes = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.minimumAcceptedNbSizeBytes;

  static const bool conversionEvidenceGeneratorImplemented = true;
  static const bool conversionRunsOutsideFlutterApp = true;
  static const bool userSideBuildProtocolProvided = true;
  static const bool writesQ387R5CompatibleEvidenceJson = true;
  static const bool runsPaddleLiteOptInsideApp = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R6 = false;
  static const bool androidRealDevicePassClaimedByQ387R6 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussQ387R6PaddleLiteNbConversionEvidenceInput {
  const GaussQ387R6PaddleLiteNbConversionEvidenceInput({
    required this.sourceModelId,
    required this.sourceModelRevision,
    required this.sourceInferenceFileSha256,
    required this.sourceInferenceFileSizeBytes,
    required this.conversionTool,
    required this.conversionToolVersion,
    required this.androidTarget,
    required this.conversionCommand,
    required this.conversionLogDigest,
    required this.outputFileName,
    required this.outputSha256,
    required this.outputSizeBytes,
    required this.downloadUrl,
    required this.conversionProvenance,
    required this.bundledInBaseApp,
  });

  final String sourceModelId;
  final String sourceModelRevision;
  final Map<String, String> sourceInferenceFileSha256;
  final Map<String, int> sourceInferenceFileSizeBytes;
  final String conversionTool;
  final String conversionToolVersion;
  final String androidTarget;
  final String conversionCommand;
  final String conversionLogDigest;
  final String outputFileName;
  final String outputSha256;
  final int outputSizeBytes;
  final String downloadUrl;
  final String conversionProvenance;
  final bool bundledInBaseApp;
}

class GaussQ387R6PaddleLiteNbConversionEvidenceResult {
  const GaussQ387R6PaddleLiteNbConversionEvidenceResult({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.blockedReason,
    required this.canWriteQ387R5EvidenceJson,
    required this.canProceedToQ387R5Intake,
    required this.acquisitionEvidence,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String blockedReason;
  final bool canWriteQ387R5EvidenceJson;
  final bool canProceedToQ387R5Intake;
  final GaussQ387R3PaddleLiteNbAcquisitionEvidence? acquisitionEvidence;
}

// Verifier marker: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate
class GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate {
  const GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate._();

  static GaussQ387R6PaddleLiteNbConversionEvidenceResult evaluate({
    required GaussQ387R6PaddleLiteNbConversionEvidenceInput? input,
  }) {
    if (input == null) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionEvidenceRequiredBlockedReason);
    }
    if (input.sourceModelId.trim() != GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.targetModelId || !_hasImmutableRevision(input.sourceModelRevision)) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.sourceModelRevisionRequiredBlockedReason);
    }
    if (!_hasRequiredSourceFileEvidence(input)) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.sourceInferenceFilesDigestRequiredBlockedReason);
    }
    if (input.conversionTool.trim() != GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredConversionTool ||
        input.conversionToolVersion.trim().isEmpty ||
        input.androidTarget.trim() != GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredAndroidTarget) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionToolRequiredBlockedReason);
    }
    if (!_hasValidConversionCommand(input.conversionCommand)) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionCommandRequiredBlockedReason);
    }
    if (!_is64Hex(input.conversionLogDigest)) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionLogDigestRequiredBlockedReason);
    }
    if (!input.outputFileName.trim().toLowerCase().endsWith(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredOutputExtension) ||
        !_is64Hex(input.outputSha256) ||
        input.outputSizeBytes < GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.minimumAcceptedNbSizeBytes) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.nbOutputDigestRequiredBlockedReason);
    }
    if (!_isImmutableHttpsNbUrl(input.downloadUrl)) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.downloadUrlRequiredBlockedReason);
    }
    if (input.conversionProvenance.trim().isEmpty) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.provenanceRequiredBlockedReason);
    }
    if (input.bundledInBaseApp) {
      return _blocked(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.baseBundleRejectedBlockedReason);
    }

    final evidence = GaussQ387R3PaddleLiteNbAcquisitionEvidence(
      sourceModelId: input.sourceModelId.trim(),
      sourceModelRevision: input.sourceModelRevision.trim(),
      sourceInferenceFiles: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredSourceInferenceFiles,
      conversionTool: input.conversionTool.trim(),
      conversionToolVersion: input.conversionToolVersion.trim(),
      androidTarget: input.androidTarget.trim(),
      conversionCommand: input.conversionCommand.trim(),
      conversionLogDigest: input.conversionLogDigest.trim().toLowerCase(),
      outputFileName: input.outputFileName.trim(),
      outputSha256: input.outputSha256.trim().toLowerCase(),
      outputSizeBytes: input.outputSizeBytes,
      downloadUrl: input.downloadUrl.trim(),
      conversionProvenance: input.conversionProvenance.trim(),
      bundledInBaseApp: input.bundledInBaseApp,
    );

    final q387R3 = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate.evaluate(evidence: evidence);
    if (!q387R3.canBindToQ387R2ProductionSource) {
      return _blocked('${GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.q387R3EvidenceRejectedBlockedReason}:${q387R3.blockedReason}');
    }

    return GaussQ387R6PaddleLiteNbConversionEvidenceResult(
      phase: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.phase,
      sourcePhase: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.sourcePhase,
      status: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.q387R5IntakeTargetStatus,
      blockedReason: '',
      canWriteQ387R5EvidenceJson: true,
      canProceedToQ387R5Intake: true,
      acquisitionEvidence: evidence,
    );
  }

  static GaussQ387R6PaddleLiteNbConversionEvidenceResult _blocked(String reason) {
    return GaussQ387R6PaddleLiteNbConversionEvidenceResult(
      phase: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.phase,
      sourcePhase: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.sourcePhase,
      status: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.status,
      blockedReason: reason,
      canWriteQ387R5EvidenceJson: false,
      canProceedToQ387R5Intake: false,
      acquisitionEvidence: null,
    );
  }

  static bool _hasRequiredSourceFileEvidence(GaussQ387R6PaddleLiteNbConversionEvidenceInput input) {
    for (final file in GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredSourceInferenceFiles) {
      final sha = input.sourceInferenceFileSha256[file];
      final size = input.sourceInferenceFileSizeBytes[file];
      if (!_is64Hex(sha) || size == null || size <= 0) {
        return false;
      }
    }
    return true;
  }

  static bool _hasValidConversionCommand(String rawCommand) {
    final command = rawCommand.trim();
    return command.contains(GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredConversionTool) &&
        command.contains('--optimize_out') &&
        command.contains('--valid_targets=arm') &&
        (command.contains('--model_dir') || (command.contains('--model_file') && command.contains('--param_file')));
  }

  static bool _hasImmutableRevision(String rawRevision) {
    final revision = rawRevision.trim().toLowerCase();
    if (revision.isEmpty || revision == 'main' || revision == 'master' || revision == 'latest' || revision == 'head') {
      return false;
    }
    final hexOnly = revision.startsWith('hf-') ? revision.substring(3) : revision;
    return RegExp(r'^[a-f0-9]{12,64}$').hasMatch(hexOnly) &&
        hexOnly.length >= GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.minimumImmutableRevisionHexLength;
  }

  static bool _isImmutableHttpsNbUrl(String rawUrl) {
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri == null || uri.scheme.toLowerCase() != 'https' || !uri.path.toLowerCase().endsWith('.nb')) {
      return false;
    }
    final path = uri.path.toLowerCase();
    const mutableSegments = <String>['/resolve/main/', '/resolve/master/', '/resolve/latest/', '/raw/main/', '/raw/master/', '/releases/latest/'];
    if (mutableSegments.any(path.contains)) return false;
    final ref = uri.queryParameters['ref']?.toLowerCase();
    if (ref == 'main' || ref == 'master' || ref == 'latest' || ref == 'head') return false;
    return true;
  }

  static bool _is64Hex(String? value) {
    return value != null && RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(value.trim());
  }
}
