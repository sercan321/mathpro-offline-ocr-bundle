import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';

void main() {
  group('V172-Q387R3 Paddle Lite .nb artifact acquisition protocol', () {
    test('blocks Q388 while no verified .nb acquisition evidence exists', () {
      final result = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate.evaluate(evidence: null);
      expect(result.phase, 'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL');
      expect(result.canBindToQ387R2ProductionSource, isFalse);
      expect(result.canProceedToQ388RealInference, isFalse);
      expect(result.blockedReason, 'q387r3-verified-paddle-lite-nb-artifact-not-acquired');
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.officialPreoptimizedNbArtifactFoundInQ387R3, isFalse);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.q388RealInferenceAllowedWithoutVerifiedNb, isFalse);
    });

    test('accepts only complete conversion evidence for Q387R2 production binding', () {
      const evidence = GaussQ387R3PaddleLiteNbAcquisitionEvidence(
        sourceModelId: 'pp_formulanet_s',
        sourceModelRevision: 'hf-0572450e501be9eb1b1cdb7e00fccf4b22fab4df',
        sourceInferenceFiles: <String>['config.json', 'inference.json', 'inference.yml', 'inference.pdiparams'],
        conversionTool: 'paddle_lite_opt',
        conversionToolVersion: '2.10-compatible-with-bundled-PaddlePredictor.jar',
        androidTarget: 'android-arm64-v8a',
        conversionCommand:
            'paddle_lite_opt --model_dir PP-FormulaNet-S --valid_targets=arm --optimize_out pp_formulanet_s_arm64',
        conversionLogDigest: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        outputFileName: 'pp_formulanet_s_arm64.nb',
        outputSha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
        outputSizeBytes: 2 * 1024 * 1024,
        downloadUrl: 'https://example.com/models/pp_formulanet_s_arm64.nb',
        conversionProvenance: 'paddle_lite_opt command, source revision, output SHA, and conversion log digest',
        bundledInBaseApp: false,
      );
      final result = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate.evaluate(evidence: evidence);
      expect(result.canBindToQ387R2ProductionSource, isTrue);
      expect(result.canProceedToQ388RealInference, isTrue);
      expect(result.blockedReason, isEmpty);
    });

    test('rejects incomplete conversion/source evidence', () {
      const evidence = GaussQ387R3PaddleLiteNbAcquisitionEvidence(
        sourceModelId: 'pp_formulanet_s',
        sourceModelRevision: 'hf-0572450e501be9eb1b1cdb7e00fccf4b22fab4df',
        sourceInferenceFiles: <String>['inference.pdiparams'],
        conversionTool: 'paddle_lite_opt',
        conversionToolVersion: '2.10-compatible-with-bundled-PaddlePredictor.jar',
        androidTarget: 'android-arm64-v8a',
        conversionCommand: 'paddle_lite_opt --optimize_out pp_formulanet_s_arm64',
        conversionLogDigest: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        outputFileName: 'pp_formulanet_s_arm64.nb',
        outputSha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
        outputSizeBytes: 2 * 1024 * 1024,
        downloadUrl: 'https://example.com/models/pp_formulanet_s_arm64.nb',
        conversionProvenance: 'incomplete source file set must be rejected',
        bundledInBaseApp: false,
      );
      final result = GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate.evaluate(evidence: evidence);
      expect(result.canBindToQ387R2ProductionSource, isFalse);
      expect(result.blockedReason, 'q387r3-source-inference-files-required');
    });

    test('preserves download-only, no fake OCR, and protected-scope claims', () {
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.conversionRunsOffDeviceOnly, isTrue);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.conversionOutputMustBeDownloadOnly, isTrue);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.q387R2ProductionSourceBindingAllowedWithoutEvidence, isFalse);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.productionInferencePassClaimedByQ387R3, isFalse);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.fakeLatexCandidateAllowed, isFalse);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.keyboardQ382Touched, isFalse);
      expect(GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Policy.graphHistorySolutionSolverTouched, isFalse);
    });
  });
}
