/// V172-Q387R3 — real Paddle Lite .nb artifact acquisition / conversion protocol.
///
/// Q387 proved the Android bridge must not load `inference.pdiparams` as a
/// Paddle Lite model. Q387R1 defined the evidence contract and Q387R2 added the
/// guarded download/install worker. Q387R3 is the missing production handoff:
/// it defines the exact conversion/acquisition evidence that must exist before
/// a production `.nb` source may be bound into Q387R2. It intentionally does not
/// invent a URL, SHA256, or conversion result.
class GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy {
  const GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy._();

  static const String phase = 'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL';
  static const String sourcePhase = 'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING';
  static const String status = 'REAL_NB_ARTIFACT_ACQUISITION_PROTOCOL_READY_BUT_VERIFIED_NB_BINARY_NOT_ACQUIRED';

  static const String targetModelId = 'pp_formulanet_s';
  static const String targetDisplayName = 'PP-FormulaNet-S';
  static const String sourceArtifactKind = 'paddle-inference-directory';
  static const String requiredOutputArtifactKind = 'paddle-lite-optimized-nb';
  static const String requiredOutputExtension = '.nb';
  static const String requiredConversionTool = 'paddle_lite_opt';
  static const String requiredAndroidTarget = 'android-arm64-v8a';
  static const String requiredRuntimeLoadMethod = 'MobileConfig.setModelFromFile(.nb)';
  static const String q387R2BindingTarget = 'GaussQ387R2PaddleLiteNbSource';

  static const String verifiedNbArtifactNotAcquiredBlockedReason = 'q387r3-verified-paddle-lite-nb-artifact-not-acquired';
  static const String conversionToolEvidenceRequiredBlockedReason = 'q387r3-conversion-tool-evidence-required';
  static const String conversionCommandRequiredBlockedReason = 'q387r3-conversion-command-required';
  static const String sourceModelRevisionRequiredBlockedReason = 'q387r3-source-model-revision-required';
  static const String sourceInferenceFilesRequiredBlockedReason = 'q387r3-source-inference-files-required';
  static const String nbOutputFileRequiredBlockedReason = 'q387r3-nb-output-file-required';
  static const String nbOutputShaRequiredBlockedReason = 'q387r3-nb-output-sha256-required';
  static const String nbOutputSizeRequiredBlockedReason = 'q387r3-nb-output-size-required';
  static const String conversionLogRequiredBlockedReason = 'q387r3-conversion-log-required';
  static const String q387R2ProductionBindingBlockedReason = 'q387r3-q387r2-production-binding-blocked-until-real-nb-evidence';

  static const int minimumAcceptedNbSizeBytes = 1024 * 1024;
  static const List<String> requiredSourceInferenceFiles = <String>[
    'config.json',
    'inference.json',
    'inference.yml',
    'inference.pdiparams',
  ];

  static const bool officialPreoptimizedNbArtifactFoundInQ387R3 = false;
  static const bool conversionProtocolRequired = true;
  static const bool conversionRunsOffDeviceOnly = true;
  static const bool conversionOutputMustBeDownloadOnly = true;
  static const bool q387R2ProductionSourceBindingAllowedWithoutEvidence = false;
  static const bool q388RealInferenceAllowedWithoutVerifiedNb = false;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R3 = false;
  static const bool androidRealDevicePassClaimedByQ387R3 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussQ387R3PaddleLiteNbAcquisitionEvidence {
  const GaussQ387R3PaddleLiteNbAcquisitionEvidence({
    required this.sourceModelId,
    required this.sourceModelRevision,
    required this.sourceInferenceFiles,
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
  final List<String> sourceInferenceFiles;
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

  bool get hasValidSourceModel => sourceModelId.trim() == GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.targetModelId;
  bool get hasSourceRevision => sourceModelRevision.trim().isNotEmpty;
  bool get hasRequiredSourceFiles {
    final normalized = sourceInferenceFiles.map((file) => file.trim()).where((file) => file.isNotEmpty).toSet();
    return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredSourceInferenceFiles.every(normalized.contains);
  }

  bool get hasConversionTool => conversionTool.trim() == GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredConversionTool;
  bool get hasConversionToolVersion => conversionToolVersion.trim().isNotEmpty;
  bool get hasAndroidTarget => androidTarget.trim() == GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredAndroidTarget;
  bool get hasConversionCommand {
    final command = conversionCommand.trim();
    return command.contains(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredConversionTool) &&
        command.contains('--optimize_out') &&
        (command.contains('--model_dir') || (command.contains('--model_file') && command.contains('--param_file')));
  }

  bool get hasConversionLogDigest => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(conversionLogDigest.trim());
  bool get hasNbOutputFileName => outputFileName.trim().toLowerCase().endsWith(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredOutputExtension);
  bool get hasValidOutputSha => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(outputSha256.trim());
  bool get hasEnoughOutputSize => outputSizeBytes >= GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.minimumAcceptedNbSizeBytes;
  bool get hasHttpsDownloadUrl => downloadUrl.trim().startsWith('https://');
  bool get hasConversionProvenance => conversionProvenance.trim().isNotEmpty;
}

class GaussQ387R3PaddleLiteNbAcquisitionResult {
  const GaussQ387R3PaddleLiteNbAcquisitionResult({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.blockedReason,
    required this.canBindToQ387R2ProductionSource,
    required this.canProceedToQ388RealInference,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String blockedReason;
  final bool canBindToQ387R2ProductionSource;
  final bool canProceedToQ388RealInference;
}

// Verifier marker: GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate.evaluate
class GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate {
  const GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate._();

  static GaussQ387R3PaddleLiteNbAcquisitionResult evaluate({
    required GaussQ387R3PaddleLiteNbAcquisitionEvidence? evidence,
  }) {
    final blockedReason = _blockedReasonFor(evidence);
    final accepted = blockedReason.isEmpty;
    return GaussQ387R3PaddleLiteNbAcquisitionResult(
      phase: GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.phase,
      sourcePhase: GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.sourcePhase,
      status: GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.status,
      blockedReason: accepted
          ? ''
          : blockedReason,
      canBindToQ387R2ProductionSource: accepted,
      canProceedToQ388RealInference: accepted,
    );
  }

  static String _blockedReasonFor(GaussQ387R3PaddleLiteNbAcquisitionEvidence? evidence) {
    if (evidence == null) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.verifiedNbArtifactNotAcquiredBlockedReason;
    }
    if (!evidence.hasSourceRevision || !evidence.hasValidSourceModel) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.sourceModelRevisionRequiredBlockedReason;
    }
    if (!evidence.hasRequiredSourceFiles) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.sourceInferenceFilesRequiredBlockedReason;
    }
    if (!evidence.hasConversionTool || !evidence.hasConversionToolVersion || !evidence.hasAndroidTarget) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.conversionToolEvidenceRequiredBlockedReason;
    }
    if (!evidence.hasConversionCommand) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.conversionCommandRequiredBlockedReason;
    }
    if (!evidence.hasConversionLogDigest) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.conversionLogRequiredBlockedReason;
    }
    if (!evidence.hasNbOutputFileName || !evidence.hasHttpsDownloadUrl || !evidence.hasConversionProvenance) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.nbOutputFileRequiredBlockedReason;
    }
    if (!evidence.hasValidOutputSha) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.nbOutputShaRequiredBlockedReason;
    }
    if (!evidence.hasEnoughOutputSize || evidence.bundledInBaseApp) {
      return GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.nbOutputSizeRequiredBlockedReason;
    }
    return '';
  }
}
