import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_artifact_manifest_q387r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_download_install_binding_q387r2.dart';

void main() {
  group('V172-Q387R2 Paddle Lite .nb source download/install binding', () {
    test('keeps production .nb source unbound until real URL SHA size provenance exists', () {
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.phase,
          'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING');
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.productionNbDownloadUrlBound, isFalse);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.productionNbSha256Bound, isFalse);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.productionNbSizeBound, isFalse);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.productionNbSourceMissingBlockedReason,
          'q387r2-production-paddle-lite-nb-source-not-bound');
    });

    test('binds only sources that satisfy the Q387R1 evidence gate', () {
      const accepted = GaussQ387R2PaddleLiteNbSource(
        fileName: 'pp_formulanet_s_arm64.nb',
        downloadUrl: 'https://example.com/models/pp_formulanet_s_arm64.nb',
        sha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
        sizeBytes: 2 * 1024 * 1024,
        conversionProvenance: 'paddle_lite_opt evidence hash and source inference model revision',
      );
      final result = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(
        candidate: accepted.toQ387R1Candidate(),
      );
      expect(result.canProceedToQ387R2DownloadInstall, isTrue);
      expect(result.blockedReason, isEmpty);
    });

    test('rejects placeholder or non-nb sources before download is allowed', () {
      const rejected = GaussQ387R2PaddleLiteNbSource(
        fileName: 'inference.pdiparams',
        downloadUrl: 'http://example.com/inference.pdiparams',
        sha256: 'not-a-sha',
        sizeBytes: 12,
        conversionProvenance: '',
      );
      final result = GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate(
        candidate: rejected.toQ387R1Candidate(),
      );
      expect(result.canProceedToQ387R2DownloadInstall, isFalse);
      expect(result.blockedReason, GaussPaddleLiteNbArtifactManifestQ387R1Policy.nbFileExtensionRequiredBlockedReason);
    });

    test('preserves download-only, no fake OCR, and protected-scope claims', () {
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.downloadInstallWorkerImplemented, isTrue);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.q387R1EvidenceGateRequiredBeforeDownload, isTrue);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.writesQ387R1NativeManifest, isTrue);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.fakeLatexCandidateAllowed, isFalse);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.keyboardQ382Touched, isFalse);
      expect(GaussPaddleLiteNbDownloadInstallBindingQ387R2Policy.graphHistorySolutionSolverTouched, isFalse);
    });
  });
}
