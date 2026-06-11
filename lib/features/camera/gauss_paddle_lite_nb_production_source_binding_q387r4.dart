import 'gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';
import 'gauss_paddle_lite_nb_download_install_binding_q387r2.dart';

/// V172-Q387R4 — verified Paddle Lite .nb production source binding gate.
///
/// Q387R3 defined what conversion/acquisition evidence must exist. Q387R4 is
/// the next surgical boundary: it turns accepted Q387R3 evidence into a Q387R2
/// download source only when the source is a real production HTTPS `.nb` URL,
/// has explicit reviewer approval, and is not a placeholder/test/local host.
///
/// This phase still does not bundle a model, invent a URL/SHA, or claim OCR
/// inference. If a verified source is unavailable, Q388 remains blocked.
class GaussPaddleLiteNbProductionSourceBindingQ387R4Policy {
  const GaussPaddleLiteNbProductionSourceBindingQ387R4Policy._();

  static const String phase = 'V172-Q387R4-PADDLE-LITE-NB-PRODUCTION-SOURCE-BINDING-GATE';
  static const String sourcePhase = 'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL';
  static const String status = 'PRODUCTION_NB_SOURCE_BINDING_GATE_READY_BUT_VERIFIED_SOURCE_NOT_BOUND';

  static const String targetModelId = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.targetModelId;
  static const String targetDisplayName = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.targetDisplayName;
  static const String requiredArtifactKind = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredOutputArtifactKind;
  static const String requiredOutputExtension = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredOutputExtension;
  static const String q387R2BindingTarget = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.q387R2BindingTarget;

  static const String productionNbSourceNotBoundBlockedReason = 'q387r4-production-nb-source-not-bound';
  static const String acquisitionEvidenceRequiredBlockedReason = 'q387r4-acquisition-evidence-required';
  static const String explicitReviewerApprovalRequiredBlockedReason = 'q387r4-explicit-reviewer-approval-required';
  static const String productionHostingRequiredBlockedReason = 'q387r4-production-hosting-required';
  static const String q387R3EvidenceRejectedBlockedReason = 'q387r4-q387r3-evidence-rejected';
  static const String nonHttpsProductionUrlRejectedBlockedReason = 'q387r4-non-https-production-url-rejected';
  static const String placeholderDomainRejectedBlockedReason = 'q387r4-placeholder-domain-rejected';
  static const String nbUrlExtensionRequiredBlockedReason = 'q387r4-download-url-must-end-with-nb';
  static const String q387R2SourceRejectedBlockedReason = 'q387r4-q387r2-source-rejected';

  static const bool officialPreoptimizedNbArtifactFoundInQ387R4 = false;
  static const bool verifiedProductionNbSourceBoundInQ387R4 = false;
  static const bool q387R2SourceConstructionImplemented = true;
  static const bool q387R2ProductionSourceBindingAllowedWithoutEvidence = false;
  static const bool q388RealInferenceAllowedWithoutBoundSource = false;
  static const bool rejectsExampleDotComPlaceholderSource = true;
  static const bool rejectsLocalhostSource = true;
  static const bool rejectsHttpSource = true;
  static const bool requiresExplicitReviewerApproval = true;
  static const bool requiresProductionHosting = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R4 = false;
  static const bool androidRealDevicePassClaimedByQ387R4 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussQ387R4PaddleLiteNbProductionSourceBindingInput {
  const GaussQ387R4PaddleLiteNbProductionSourceBindingInput({
    required this.acquisitionEvidence,
    required this.explicitReviewerApproval,
    required this.productionHostedSource,
  });

  final GaussQ387R3PaddleLiteNbAcquisitionEvidence? acquisitionEvidence;
  final bool explicitReviewerApproval;
  final bool productionHostedSource;
}

class GaussQ387R4PaddleLiteNbProductionSourceBindingResult {
  const GaussQ387R4PaddleLiteNbProductionSourceBindingResult({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.blockedReason,
    required this.canBindToQ387R2ProductionSource,
    required this.canProceedToQ388RealInference,
    required this.verifiedSource,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String blockedReason;
  final bool canBindToQ387R2ProductionSource;
  final bool canProceedToQ388RealInference;
  final GaussQ387R2PaddleLiteNbSource? verifiedSource;
}

// Verifier marker: GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate
class GaussPaddleLiteNbProductionSourceBindingQ387R4Gate {
  const GaussPaddleLiteNbProductionSourceBindingQ387R4Gate._();

  static GaussQ387R4PaddleLiteNbProductionSourceBindingResult evaluate({
    required GaussQ387R4PaddleLiteNbProductionSourceBindingInput input,
  }) {
    final evidence = input.acquisitionEvidence;
    if (evidence == null) {
      return _blocked(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.acquisitionEvidenceRequiredBlockedReason);
    }
    if (!input.explicitReviewerApproval) {
      return _blocked(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.explicitReviewerApprovalRequiredBlockedReason);
    }
    if (!input.productionHostedSource) {
      return _blocked(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.productionHostingRequiredBlockedReason);
    }

    final q387R3 = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate.evaluate(evidence: evidence);
    if (!q387R3.canBindToQ387R2ProductionSource) {
      return _blocked('${GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.q387R3EvidenceRejectedBlockedReason}:${q387R3.blockedReason}');
    }

    final sourceUrlBlockedReason = _downloadUrlBlockedReason(evidence.downloadUrl);
    if (sourceUrlBlockedReason.isNotEmpty) {
      return _blocked(sourceUrlBlockedReason);
    }

    final source = GaussQ387R2PaddleLiteNbSource(
      fileName: evidence.outputFileName.trim(),
      downloadUrl: evidence.downloadUrl.trim(),
      sha256: evidence.outputSha256.trim().toLowerCase(),
      sizeBytes: evidence.outputSizeBytes,
      conversionProvenance: evidence.conversionProvenance.trim(),
      sourceRevision: evidence.sourceModelRevision.trim(),
    );

    final q387R2Ready = source.fileName.toLowerCase().endsWith(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.requiredOutputExtension) &&
        source.downloadUrl.startsWith('https://') &&
        RegExp(r'^[a-f0-9]{64}$').hasMatch(source.sha256) &&
        source.sizeBytes >= GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.minimumAcceptedNbSizeBytes &&
        source.conversionProvenance.isNotEmpty;
    if (!q387R2Ready) {
      return _blocked(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.q387R2SourceRejectedBlockedReason);
    }

    return GaussQ387R4PaddleLiteNbProductionSourceBindingResult(
      phase: GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.phase,
      sourcePhase: GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.sourcePhase,
      status: GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.status,
      blockedReason: '',
      canBindToQ387R2ProductionSource: true,
      canProceedToQ388RealInference: true,
      verifiedSource: source,
    );
  }

  static GaussQ387R4PaddleLiteNbProductionSourceBindingResult _blocked(String reason) {
    return GaussQ387R4PaddleLiteNbProductionSourceBindingResult(
      phase: GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.phase,
      sourcePhase: GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.sourcePhase,
      status: GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.status,
      blockedReason: reason,
      canBindToQ387R2ProductionSource: false,
      canProceedToQ388RealInference: false,
      verifiedSource: null,
    );
  }

  static String _downloadUrlBlockedReason(String rawUrl) {
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri == null || uri.scheme.toLowerCase() != 'https' || uri.host.trim().isEmpty) {
      return GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.nonHttpsProductionUrlRejectedBlockedReason;
    }
    if (!uri.path.toLowerCase().endsWith(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.requiredOutputExtension)) {
      return GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.nbUrlExtensionRequiredBlockedReason;
    }
    final host = uri.host.toLowerCase();
    final placeholderHost = host == 'example.com' ||
        host.endsWith('.example.com') ||
        host == 'localhost' ||
        host == '127.0.0.1' ||
        host == '0.0.0.0' ||
        host.endsWith('.invalid') ||
        host.endsWith('.test') ||
        host.endsWith('.local');
    if (placeholderHost) {
      return GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.placeholderDomainRejectedBlockedReason;
    }
    return '';
  }
}
