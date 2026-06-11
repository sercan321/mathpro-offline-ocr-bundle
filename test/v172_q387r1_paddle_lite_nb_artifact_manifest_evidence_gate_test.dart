import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_artifact_manifest_q387r1.dart';

void main() {
  test('Q387R1 blocks until a real .nb URL SHA size provenance candidate exists', () {
    final result = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(candidate: null);

    expect(result.phase, GaussPaddleLiteNbArtifactManifestQ387R1Policy.phase);
    expect(result.blockedReason, GaussPaddleLiteNbArtifactManifestQ387R1Policy.realNbArtifactEvidenceRequiredBlockedReason);
    expect(result.candidateAcceptedForDownloadManifest, isFalse);
    expect(result.canProceedToQ387R2DownloadInstall, isFalse);
  });

  test('Q387R1 rejects non-nb files and non-https placeholder URLs', () {
    final wrongExtension = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(
      candidate: const GaussPaddleLiteNbArtifactCandidateQ387R1(
        fileName: 'inference.pdiparams',
        downloadUrl: 'https://example.invalid/model/inference.pdiparams',
        sha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        sizeBytes: 10 * 1024 * 1024,
        conversionProvenance: 'paddle_lite_opt conversion evidence',
        bundledInBaseApp: false,
      ),
    );
    expect(wrongExtension.blockedReason, GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbFileExtensionRequiredBlockedReason);

    final wrongUrl = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(
      candidate: const GaussPaddleLiteNbArtifactCandidateQ387R1(
        fileName: 'pp_formulanet_s.nb',
        downloadUrl: 'file:///tmp/pp_formulanet_s.nb',
        sha256: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        sizeBytes: 10 * 1024 * 1024,
        conversionProvenance: 'paddle_lite_opt conversion evidence',
        bundledInBaseApp: false,
      ),
    );
    expect(wrongUrl.blockedReason, GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbDownloadUrlRequiredBlockedReason);
  });

  test('Q387R1 accepts only download-only .nb manifest candidates with SHA and provenance', () {
    final result = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(
      candidate: const GaussPaddleLiteNbArtifactCandidateQ387R1(
        fileName: 'pp_formulanet_s_arm64.nb',
        downloadUrl: 'https://models.example.invalid/mathpro/pp_formulanet_s_arm64.nb',
        sha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
        sizeBytes: 182 * 1024 * 1024,
        conversionProvenance: 'paddle_lite_opt --model_file inference.json --param_file inference.pdiparams --valid_targets=arm',
        bundledInBaseApp: false,
      ),
    );

    expect(result.blockedReason, isEmpty);
    expect(result.candidateAcceptedForDownloadManifest, isTrue);
    expect(result.canProceedToQ387R2DownloadInstall, isTrue);
  });

  test('Q387R1 policy preserves download-only and no fake OCR claims', () {
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.requiredArtifactKind, 'paddle-lite-optimized-nb');
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.productionNbDownloadUrlBound, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.productionNbSha256Bound, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.productionNbArtifactBundledInBaseApp, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.legacyInferenceDirectoryPromotedToAndroidRuntime, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.productionInferencePassClaimedByQ387R1, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.androidRealDevicePassClaimedByQ387R1, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.fakeLatexCandidateAllowed, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.keyboardQ382Touched, isFalse);
    expect(GaussPaddleLiteNbArtifactManifestQ387R1Policy.graphHistorySolutionSolverTouched, isFalse);
  });
}
