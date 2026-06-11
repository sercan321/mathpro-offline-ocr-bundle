/// V172-Q387R1 — Paddle Lite .nb artifact manifest / evidence gate.
///
/// Q387 proved that the current Android Paddle Lite line must not blindly load
/// the downloaded Paddle inference-directory (`inference.pdiparams`). Q387R1
/// does not invent or bundle a model. It defines the exact evidence contract a
/// real download-only Paddle Lite optimized `.nb` artifact must satisfy before
/// Q387R2 is allowed to replace the legacy inference-directory download path.
class GaussPaddleLiteNbArtifactManifestQ387R1Policy {
  const GaussPaddleLiteNbArtifactManifestQ387R1Policy._();

  static const String phase = 'V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE';
  static const String sourcePhase = 'V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE';
  static const String status = 'REAL_PADDLE_LITE_NB_ARTIFACT_REQUIRED_DOWNLOAD_ONLY_MANIFEST_BLOCKED_PENDING_URL_SHA_SIZE_PROVENANCE';

  static const String requiredArtifactKind = 'paddle-lite-optimized-nb';
  static const String requiredFileExtension = '.nb';
  static const String requiredLoadMethod = 'MobileConfig.setModelFromFile(.nb)';
  static const String requiredManifestFileName = 'q387r1_paddle_lite_nb_manifest.json';
  static const String targetModelId = 'pp_formulanet_s';
  static const String targetDisplayName = 'PP-FormulaNet-S';

  static const String realNbArtifactEvidenceRequiredBlockedReason = 'q387r1-real-paddle-lite-nb-artifact-evidence-required';
  static const String nbFileNameRequiredBlockedReason = 'q387r1-nb-file-name-required';
  static const String nbFileExtensionRequiredBlockedReason = 'q387r1-nb-file-extension-required';
  static const String nbDownloadUrlRequiredBlockedReason = 'q387r1-nb-download-url-required';
  static const String nbSha256RequiredBlockedReason = 'q387r1-nb-sha256-required';
  static const String nbSizeRequiredBlockedReason = 'q387r1-nb-size-required';
  static const String conversionProvenanceRequiredBlockedReason = 'q387r1-conversion-provenance-required';
  static const String baseAppBundleForbiddenBlockedReason = 'q387r1-nb-must-not-be-bundled-in-base-app';

  static const int minimumAcceptedNbSizeBytes = 1024 * 1024;

  static const bool productionNbDownloadUrlBound = false;
  static const bool productionNbSha256Bound = false;
  static const bool productionNbSizeBound = false;
  static const bool productionNbArtifactBundledInBaseApp = false;
  static const bool legacyInferenceDirectoryPromotedToAndroidRuntime = false;
  static const bool onnxRuntimeReintroducedInBaseApk = false;
  static const bool productionInferencePassClaimedByQ387R1 = false;
  static const bool androidRealDevicePassClaimedByQ387R1 = false;
  static const bool fakeLatexCandidateAllowed = false;
  static const bool keyboardQ382Touched = false;
  static const bool graphHistorySolutionSolverTouched = false;
}

class GaussPaddleLiteNbArtifactCandidateQ387R1 {
  const GaussPaddleLiteNbArtifactCandidateQ387R1({
    required this.fileName,
    required this.downloadUrl,
    required this.sha256,
    required this.sizeBytes,
    required this.conversionProvenance,
    required this.bundledInBaseApp,
  });

  final String fileName;
  final String downloadUrl;
  final String sha256;
  final int? sizeBytes;
  final String conversionProvenance;
  final bool bundledInBaseApp;

  bool get hasHttpsDownloadUrl => downloadUrl.trim().startsWith('https://');
  bool get hasValidSha256 => RegExp(r'^[a-fA-F0-9]{64}$').hasMatch(sha256.trim());
  bool get hasNbExtension => fileName.trim().toLowerCase().endsWith(GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredFileExtension);
  bool get hasEnoughSize => (sizeBytes ?? 0) >= GaussPaddleLiteNbArtifactManifestQ387R1Policy.minimumAcceptedNbSizeBytes;
  bool get hasConversionProvenance => conversionProvenance.trim().isNotEmpty;
}

class GaussPaddleLiteNbArtifactManifestQ387R1Result {
  const GaussPaddleLiteNbArtifactManifestQ387R1Result({
    required this.phase,
    required this.sourcePhase,
    required this.requiredArtifactKind,
    required this.requiredManifestFileName,
    required this.candidateAcceptedForDownloadManifest,
    required this.blockedReason,
    required this.canProceedToQ387R2DownloadInstall,
  });

  final String phase;
  final String sourcePhase;
  final String requiredArtifactKind;
  final String requiredManifestFileName;
  final bool candidateAcceptedForDownloadManifest;
  final String blockedReason;
  final bool canProceedToQ387R2DownloadInstall;
}

class GaussPaddleLiteNbArtifactManifestQ387R1Gate {
  const GaussPaddleLiteNbArtifactManifestQ387R1Gate._();

  static GaussPaddleLiteNbArtifactManifestQ387R1Result evaluate({
    required GaussPaddleLiteNbArtifactCandidateQ387R1? candidate,
  }) {
    final String blockedReason;
    if (candidate == null) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.realNbArtifactEvidenceRequiredBlockedReason;
    } else if (candidate.fileName.trim().isEmpty) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbFileNameRequiredBlockedReason;
    } else if (!candidate.hasNbExtension) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbFileExtensionRequiredBlockedReason;
    } else if (!candidate.hasHttpsDownloadUrl) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbDownloadUrlRequiredBlockedReason;
    } else if (!candidate.hasValidSha256) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbSha256RequiredBlockedReason;
    } else if (!candidate.hasEnoughSize) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbSizeRequiredBlockedReason;
    } else if (!candidate.hasConversionProvenance) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.conversionProvenanceRequiredBlockedReason;
    } else if (candidate.bundledInBaseApp) {
      blockedReason = GaussPaddleLiteNbArtifactManifestQ387R1Policy.baseAppBundleForbiddenBlockedReason;
    } else {
      blockedReason = '';
    }

    final accepted = blockedReason.isEmpty;
    return GaussPaddleLiteNbArtifactManifestQ387R1Result(
      phase: GaussPaddleLiteNbArtifactManifestQ387R1Policy.phase,
      sourcePhase: GaussPaddleLiteNbArtifactManifestQ387R1Policy.sourcePhase,
      requiredArtifactKind: GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredArtifactKind,
      requiredManifestFileName: GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredManifestFileName,
      candidateAcceptedForDownloadManifest: accepted,
      blockedReason: blockedReason,
      canProceedToQ387R2DownloadInstall: accepted,
    );
  }
}
