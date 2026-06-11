import 'gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';
import 'gauss_paddle_lite_nb_download_install_binding_q387r2.dart';
import 'gauss_paddle_lite_nb_production_source_binding_q387r4.dart';

/// V172-Q387R5 — external Paddle Lite .nb artifact intake closure.
///
/// Q387R4 rejects placeholder and mutable production-source claims. Q387R5 is
/// the next surgical handoff: it accepts an externally produced or hosted
/// Paddle Lite `.nb` candidate only when the source is immutable, reviewer
/// approved, size/SHA evidence is present, and the Q387R4 production binding
/// gate can turn it into the Q387R2 download/install source. It still does not
/// bundle a model binary, fabricate a URL/SHA, or claim camera OCR success.
class GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy {
  const GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy._();

  static const String phase = 'V172-Q387R5-PADDLE-LITE-NB-EXTERNAL-ARTIFACT-INTAKE-CLOSURE';
  static const String sourcePhase = 'V172-Q387R4-PADDLE-LITE-NB-PRODUCTION-SOURCE-BINDING-GATE';
  static const String status = 'EXTERNAL_NB_ARTIFACT_INTAKE_READY_BUT_PRODUCTION_ARTIFACT_NOT_SUPPLIED';

  static const String targetModelId = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.targetModelId;
  static const String targetDisplayName = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.targetDisplayName;
  static const String requiredArtifactKind = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredOutputArtifactKind;
  static const String requiredOutputExtension = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredOutputExtension;
  static const String requiredConversionTool = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredConversionTool;
  static const String requiredAndroidTarget = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.requiredAndroidTarget;

  static const String externalArtifactRequiredBlockedReason = 'q387r5-external-nb-artifact-evidence-required';
  static const String explicitReviewerApprovalRequiredBlockedReason = 'q387r5-explicit-reviewer-approval-required';
  static const String immutableSourceRequiredBlockedReason = 'q387r5-immutable-source-revision-required';
  static const String mutableDownloadUrlRejectedBlockedReason = 'q387r5-mutable-download-url-rejected';
  static const String localFileDigestRequiredBlockedReason = 'q387r5-local-nb-file-sha-size-evidence-required';
  static const String localFileDigestMismatchBlockedReason = 'q387r5-local-nb-file-sha-size-mismatch';
  static const String q387R4BindingRejectedBlockedReason = 'q387r5-q387r4-production-binding-rejected';
  static const String q387R2SourceReadyStatus = 'q387r5-q387r2-source-ready-for-download-install-worker';

  static const int minimumImmutableRevisionHexLength = 12;

  static const bool officialPreoptimizedNbArtifactFoundInQ387R5 = false;
  static const bool externalArtifactIntakeImplemented = true;
  static const bool requiresImmutableSourceRevision = true;
  static const bool rejectsMutableBranchUrls = true;
  static const bool requiresLocalShaSizeEvidenceWhenLocalFileProvided = true;
  static const bool canConstructQ387R2SourceAfterEvidence = true;
  static const bool modelBinaryBundledInBaseApp = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R5 = false;
  static const bool androidRealDevicePassClaimedByQ387R5 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput {
  const GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput({
    required this.acquisitionEvidence,
    required this.explicitReviewerApproval,
    required this.productionHostedSource,
    required this.localFileSha256,
    required this.localFileSizeBytes,
  });

  final GaussQ387R3PaddleLiteNbAcquisitionEvidence? acquisitionEvidence;
  final bool explicitReviewerApproval;
  final bool productionHostedSource;

  /// Optional evidence from an externally produced `.nb` file on the auditor's
  /// machine. If one of these is provided, both must match the acquisition
  /// evidence exactly before the Q387R2 source can be emitted.
  final String? localFileSha256;
  final int? localFileSizeBytes;
}

class GaussQ387R5PaddleLiteNbExternalArtifactIntakeResult {
  const GaussQ387R5PaddleLiteNbExternalArtifactIntakeResult({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.blockedReason,
    required this.canBindToQ387R2ProductionSource,
    required this.canProceedToQ388RealInference,
    required this.q387R2Source,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String blockedReason;
  final bool canBindToQ387R2ProductionSource;
  final bool canProceedToQ388RealInference;
  final GaussQ387R2PaddleLiteNbSource? q387R2Source;
}

// Verifier marker: GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate
class GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate {
  const GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate._();

  static GaussQ387R5PaddleLiteNbExternalArtifactIntakeResult evaluate({
    required GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput input,
  }) {
    final evidence = input.acquisitionEvidence;
    if (evidence == null) {
      return _blocked(GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.externalArtifactRequiredBlockedReason);
    }
    if (!input.explicitReviewerApproval) {
      return _blocked(GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.explicitReviewerApprovalRequiredBlockedReason);
    }
    if (!_hasImmutableRevision(evidence.sourceModelRevision)) {
      return _blocked(GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.immutableSourceRequiredBlockedReason);
    }
    if (_downloadUrlLooksMutable(evidence.downloadUrl)) {
      return _blocked(GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.mutableDownloadUrlRejectedBlockedReason);
    }

    final localSha = input.localFileSha256;
    final localSize = input.localFileSizeBytes;
    if ((localSha != null && localSha.trim().isNotEmpty) || localSize != null) {
      if (localSha == null || localSha.trim().isEmpty || localSize == null) {
        return _blocked(GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.localFileDigestRequiredBlockedReason);
      }
      final expectedSha = evidence.outputSha256.trim().toLowerCase();
      if (localSha.trim().toLowerCase() != expectedSha || localSize != evidence.outputSizeBytes) {
        return _blocked(GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.localFileDigestMismatchBlockedReason);
      }
    }

    final q387R4 = GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate(
      input: GaussQ387R4PaddleLiteNbProductionSourceBindingInput(
        acquisitionEvidence: evidence,
        explicitReviewerApproval: input.explicitReviewerApproval,
        productionHostedSource: input.productionHostedSource,
      ),
    );
    if (!q387R4.canBindToQ387R2ProductionSource || q387R4.verifiedSource == null) {
      return _blocked('${GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.q387R4BindingRejectedBlockedReason}:${q387R4.blockedReason}');
    }

    return GaussQ387R5PaddleLiteNbExternalArtifactIntakeResult(
      phase: GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.phase,
      sourcePhase: GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.sourcePhase,
      status: GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.q387R2SourceReadyStatus,
      blockedReason: '',
      canBindToQ387R2ProductionSource: true,
      canProceedToQ388RealInference: true,
      q387R2Source: q387R4.verifiedSource,
    );
  }

  static GaussQ387R5PaddleLiteNbExternalArtifactIntakeResult _blocked(String reason) {
    return GaussQ387R5PaddleLiteNbExternalArtifactIntakeResult(
      phase: GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.phase,
      sourcePhase: GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.sourcePhase,
      status: GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.status,
      blockedReason: reason,
      canBindToQ387R2ProductionSource: false,
      canProceedToQ388RealInference: false,
      q387R2Source: null,
    );
  }

  static bool _hasImmutableRevision(String rawRevision) {
    final revision = rawRevision.trim().toLowerCase();
    if (revision.isEmpty || revision == 'main' || revision == 'master' || revision == 'latest' || revision == 'head') {
      return false;
    }
    final hexOnly = revision.startsWith('hf-') ? revision.substring(3) : revision;
    return RegExp(r'^[a-f0-9]{12,64}$').hasMatch(hexOnly) &&
        hexOnly.length >= GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.minimumImmutableRevisionHexLength;
  }

  static bool _downloadUrlLooksMutable(String rawUrl) {
    final uri = Uri.tryParse(rawUrl.trim());
    if (uri == null) return true;
    final normalizedPath = uri.path.toLowerCase();
    const mutableSegments = <String>[
      '/resolve/main/',
      '/resolve/master/',
      '/resolve/latest/',
      '/raw/main/',
      '/raw/master/',
      '/releases/latest/',
    ];
    if (mutableSegments.any(normalizedPath.contains)) return true;
    final ref = uri.queryParameters['ref']?.toLowerCase();
    if (ref == 'main' || ref == 'master' || ref == 'latest' || ref == 'head') return true;
    return false;
  }
}
