import 'gauss_real_ocr_artifact_source_intake_policy.dart';

/// V172-Q288 — Real OCR Artifact Source Intake.
///
/// This phase records official PP-FormulaNet-S source candidates and the hard
/// acceptance requirements for a future runtime. It intentionally does not add
/// Paddle/PaddleOCR runtime code, download workers, model binaries, native
/// handlers, MethodChannel runtime binding, or image-to-LaTeX inference.
enum GaussRealOcrArtifactSourceIntakeDecision {
  sourceCandidateRecordedButShaPending,
  blockedIfRuntimeOrPassClaimAdded,
}

class GaussRealOcrArtifactSourceIntakeResult {
  const GaussRealOcrArtifactSourceIntakeResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.primaryOfficialSourceLocator,
    required this.officialMirrorInferenceArtifactLocator,
    required this.expectedSha256,
    required this.recordedLicense,
    required this.artifactAcceptanceRequirements,
    required this.decision,
    required this.artifactSha256Verified,
    required this.artifactAcceptedForRuntime,
    required this.realOcrRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.productionDownloadEnabled,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String primaryOfficialSourceLocator;
  final String officialMirrorInferenceArtifactLocator;
  final String expectedSha256;
  final String recordedLicense;
  final List<String> artifactAcceptanceRequirements;
  final GaussRealOcrArtifactSourceIntakeDecision decision;
  final bool artifactSha256Verified;
  final bool artifactAcceptedForRuntime;
  final bool realOcrRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool productionDownloadEnabled;
  final bool ocrPassClaimed;
}

class GaussRealOcrArtifactSourceIntake {
  const GaussRealOcrArtifactSourceIntake._();

  static GaussRealOcrArtifactSourceIntakeResult evaluate() {
    const blocked = GaussRealOcrArtifactSourceIntakePolicy.realOcrRuntimeAdded ||
        GaussRealOcrArtifactSourceIntakePolicy.modelBinaryBundledInBaseApp ||
        GaussRealOcrArtifactSourceIntakePolicy.productionDownloadEnabled ||
        GaussRealOcrArtifactSourceIntakePolicy.ocrPassClaimed ||
        GaussRealOcrArtifactSourceIntakePolicy.cameraOcrRuntimePassClaimed ||
        GaussRealOcrArtifactSourceIntakePolicy.releasePassClaimed;

    return const GaussRealOcrArtifactSourceIntakeResult(
      phase: GaussRealOcrArtifactSourceIntakePolicy.phase,
      sourcePhase: GaussRealOcrArtifactSourceIntakePolicy.sourcePhase,
      selectedEngineLabel: GaussRealOcrArtifactSourceIntakePolicy.selectedEngineLabel,
      primaryOfficialSourceLocator: GaussRealOcrArtifactSourceIntakePolicy.primaryOfficialSourceLocator,
      officialMirrorInferenceArtifactLocator: GaussRealOcrArtifactSourceIntakePolicy.officialMirrorInferenceArtifactLocator,
      expectedSha256: GaussRealOcrArtifactSourceIntakePolicy.expectedSha256,
      recordedLicense: GaussRealOcrArtifactSourceIntakePolicy.recordedLicense,
      artifactAcceptanceRequirements: GaussRealOcrArtifactSourceIntakePolicy.artifactAcceptanceRequirements,
      decision: blocked
          ? GaussRealOcrArtifactSourceIntakeDecision.blockedIfRuntimeOrPassClaimAdded
          : GaussRealOcrArtifactSourceIntakeDecision.sourceCandidateRecordedButShaPending,
      artifactSha256Verified: GaussRealOcrArtifactSourceIntakePolicy.artifactSha256Verified,
      artifactAcceptedForRuntime: GaussRealOcrArtifactSourceIntakePolicy.artifactAcceptedForRuntime,
      realOcrRuntimeAdded: GaussRealOcrArtifactSourceIntakePolicy.realOcrRuntimeAdded,
      modelBinaryBundledInBaseApp: GaussRealOcrArtifactSourceIntakePolicy.modelBinaryBundledInBaseApp,
      productionDownloadEnabled: GaussRealOcrArtifactSourceIntakePolicy.productionDownloadEnabled,
      ocrPassClaimed: GaussRealOcrArtifactSourceIntakePolicy.ocrPassClaimed,
    );
  }
}
