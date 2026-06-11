import 'gauss_paddle_lite_nb_conversion_evidence_generator_q387r6.dart';

/// V172-Q387R7 — user-side Paddle Lite .nb conversion command package.
///
/// Q387R7 packages a deterministic PowerShell protocol for producing the
/// Q387R6 evidence JSON and Q387R5 intake check from a real externally built
/// `.nb` file. It does not run conversion inside Flutter, does not bundle a
/// model, does not invent URL/SHA values, and does not claim OCR/device PASS.
class GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy {
  const GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy._();

  static const String phase = 'V172-Q387R7-PADDLE-LITE-NB-USER-SIDE-CONVERSION-PROTOCOL';
  static const String sourcePhase = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.phase;
  static const String status = 'USER_SIDE_CONVERSION_PROTOCOL_READY_BUT_NOT_EXECUTED_IN_APP';

  static const String targetModelId = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.targetModelId;
  static const String requiredConversionTool = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredConversionTool;
  static const String requiredAndroidTarget = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredAndroidTarget;
  static const String requiredOutputExtension = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.requiredOutputExtension;
  static const String q387R6GeneratorTool = 'tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs';
  static const String q387R5IntakeTool = 'tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs';
  static const String q387R7ProtocolGeneratorTool = 'tool/generate_q387r7_paddle_lite_nb_user_conversion_protocol.mjs';
  static const String defaultPowerShellScriptName = 'run_q387r7_paddle_lite_nb_conversion_protocol.ps1';

  static const String protocolInputRequiredBlockedReason = 'q387r7-user-side-conversion-protocol-input-required';
  static const String immutableRevisionRequiredBlockedReason = 'q387r7-immutable-source-revision-required';
  static const String pathsRequiredBlockedReason = 'q387r7-user-side-paths-required';
  static const String scriptPathRequiredBlockedReason = 'q387r7-powershell-script-path-required';
  static const String outputNbFileRequiredBlockedReason = 'q387r7-output-nb-file-required';
  static const String immutableDownloadUrlRequiredBlockedReason = 'q387r7-immutable-https-nb-download-url-required';
  static const String approvalRequiredBlockedReason = 'q387r7-reviewer-and-production-hosting-approval-required';
  static const String commandSequenceRequiredBlockedReason = 'q387r7-conversion-command-sequence-required';
  static const String baseBundleRejectedBlockedReason = 'q387r7-base-apk-model-bundling-rejected';

  static const List<String> requiredPowerShellMarkers = <String>[
    'Set-StrictMode -Version Latest',
    r"$ErrorActionPreference = 'Stop'",
    'paddle_lite_opt',
    '--valid_targets=arm',
    '--optimize_out',
    'generate_q387r6_paddle_lite_nb_conversion_evidence.mjs',
    'intake_q387r5_paddle_lite_nb_external_artifact.mjs',
  ];

  static const bool protocolGeneratorImplemented = true;
  static const bool writesPowerShellProtocol = true;
  static const bool writesQ387R6GeneratorInvocation = true;
  static const bool writesQ387R5IntakeInvocation = true;
  static const bool runsPaddleLiteOptInsideFlutterApp = false;
  static const bool conversionRunsOutsideFlutterApp = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R7 = false;
  static const bool androidRealDevicePassClaimedByQ387R7 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput {
  const GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput({
    required this.sourceModelRevision,
    required this.sourceDirectoryPath,
    required this.paddleLiteOptPath,
    required this.outputDirectoryPath,
    required this.outputNbFileName,
    required this.downloadUrl,
    required this.conversionToolVersion,
    required this.conversionProvenance,
    required this.powerShellScriptPath,
    required this.evidenceJsonPath,
    required this.commandSequence,
    required this.explicitReviewerApproval,
    required this.productionHostedSource,
    required this.bundledInBaseApp,
  });

  final String sourceModelRevision;
  final String sourceDirectoryPath;
  final String paddleLiteOptPath;
  final String outputDirectoryPath;
  final String outputNbFileName;
  final String downloadUrl;
  final String conversionToolVersion;
  final String conversionProvenance;
  final String powerShellScriptPath;
  final String evidenceJsonPath;
  final List<String> commandSequence;
  final bool explicitReviewerApproval;
  final bool productionHostedSource;
  final bool bundledInBaseApp;
}

class GaussQ387R7PaddleLiteNbUserSideConversionProtocolResult {
  const GaussQ387R7PaddleLiteNbUserSideConversionProtocolResult({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.blockedReason,
    required this.canGeneratePowerShellProtocol,
    required this.canProceedToUserSideConversion,
    required this.expectedNextGate,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String blockedReason;
  final bool canGeneratePowerShellProtocol;
  final bool canProceedToUserSideConversion;
  final String expectedNextGate;
}

// Verifier marker: GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate
class GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate {
  const GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate._();

  static GaussQ387R7PaddleLiteNbUserSideConversionProtocolResult evaluate({
    required GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput? input,
  }) {
    if (input == null) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.protocolInputRequiredBlockedReason);
    }
    if (!_hasImmutableRevision(input.sourceModelRevision)) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.immutableRevisionRequiredBlockedReason);
    }
    if (!_hasRequiredPaths(input)) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.pathsRequiredBlockedReason);
    }
    if (!input.powerShellScriptPath.trim().toLowerCase().endsWith('.ps1')) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.scriptPathRequiredBlockedReason);
    }
    if (!input.outputNbFileName.trim().toLowerCase().endsWith(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.requiredOutputExtension)) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.outputNbFileRequiredBlockedReason);
    }
    if (!_isImmutableHttpsNbUrl(input.downloadUrl)) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.immutableDownloadUrlRequiredBlockedReason);
    }
    if (!input.explicitReviewerApproval || !input.productionHostedSource) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.approvalRequiredBlockedReason);
    }
    if (input.bundledInBaseApp) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.baseBundleRejectedBlockedReason);
    }
    if (!_hasCommandSequence(input.commandSequence)) {
      return _blocked(GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.commandSequenceRequiredBlockedReason);
    }

    return const GaussQ387R7PaddleLiteNbUserSideConversionProtocolResult(
      phase: GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.phase,
      sourcePhase: GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.sourcePhase,
      status: 'Q387R6_AND_Q387R5_USER_SIDE_PROTOCOL_READY_STATIC_ONLY',
      blockedReason: '',
      canGeneratePowerShellProtocol: true,
      canProceedToUserSideConversion: true,
      expectedNextGate: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.phase,
    );
  }

  static GaussQ387R7PaddleLiteNbUserSideConversionProtocolResult _blocked(String reason) {
    return GaussQ387R7PaddleLiteNbUserSideConversionProtocolResult(
      phase: GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.phase,
      sourcePhase: GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.sourcePhase,
      status: GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.status,
      blockedReason: reason,
      canGeneratePowerShellProtocol: false,
      canProceedToUserSideConversion: false,
      expectedNextGate: GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.phase,
    );
  }

  static bool _hasRequiredPaths(GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput input) {
    return input.sourceDirectoryPath.trim().isNotEmpty &&
        input.paddleLiteOptPath.trim().isNotEmpty &&
        input.outputDirectoryPath.trim().isNotEmpty &&
        input.evidenceJsonPath.trim().isNotEmpty &&
        input.conversionToolVersion.trim().isNotEmpty &&
        input.conversionProvenance.trim().isNotEmpty;
  }

  static bool _hasCommandSequence(List<String> commands) {
    final combined = commands.join('\n');
    for (final marker in GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.requiredPowerShellMarkers) {
      if (!combined.contains(marker)) return false;
    }
    return true;
  }

  static bool _hasImmutableRevision(String rawRevision) {
    final revision = rawRevision.trim().toLowerCase();
    if (revision.isEmpty || revision == 'main' || revision == 'master' || revision == 'latest' || revision == 'head') {
      return false;
    }
    final hexOnly = revision.startsWith('hf-') ? revision.substring(3) : revision;
    return RegExp(r'^[a-f0-9]{12,64}$').hasMatch(hexOnly) && hexOnly.length >= 12;
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
}
