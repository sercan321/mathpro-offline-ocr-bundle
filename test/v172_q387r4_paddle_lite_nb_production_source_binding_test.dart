import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_production_source_binding_q387r4.dart';

const _completeEvidence = GaussQ387R3PaddleLiteNbAcquisitionEvidence(
  sourceModelId: 'pp_formulanet_s',
  sourceModelRevision: 'hf-0572450e501be9eb1b1cdb7e00fccf4b22fab4df',
  sourceInferenceFiles: <String>['config.json', 'inference.json', 'inference.yml', 'inference.pdiparams'],
  conversionTool: 'paddle_lite_opt',
  conversionToolVersion: '2.10-compatible-with-bundled-PaddlePredictor.jar',
  androidTarget: 'android-arm64-v8a',
  conversionCommand: 'paddle_lite_opt --model_dir PP-FormulaNet-S --valid_targets=arm --optimize_out pp_formulanet_s_arm64',
  conversionLogDigest: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  outputFileName: 'pp_formulanet_s_arm64.nb',
  outputSha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
  outputSizeBytes: 2 * 1024 * 1024,
  downloadUrl: 'https://models.mathpro.app/ocr/pp_formulanet_s_arm64.nb',
  conversionProvenance: 'paddle_lite_opt command, source revision, output SHA, conversion log digest, and production hosting ticket',
  bundledInBaseApp: false,
);

void main() {
  group('V172-Q387R4 Paddle Lite .nb production source binding gate', () {
    test('blocks production binding while no verified source evidence exists', () {
      final result = GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate(
        input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput(
          acquisitionEvidence: null,
          explicitReviewerApproval: true,
          productionHostedSource: true,
        ),
      );
      expect(result.phase, 'V172-Q387R4-PADDLE-LITE-NB-PRODUCTION-SOURCE-BINDING-GATE');
      expect(result.canBindToQ387R2ProductionSource, isFalse);
      expect(result.canProceedToQ388RealInference, isFalse);
      expect(result.verifiedSource, isNull);
      expect(result.blockedReason, 'q387r4-acquisition-evidence-required');
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.verifiedProductionNbSourceBoundInQ387R4, isFalse);
    });

    test('rejects complete-looking placeholder evidence from example.com before Q387R2 source construction', () {
      const placeholder = GaussQ387R3PaddleLiteNbAcquisitionEvidence(
        sourceModelId: 'pp_formulanet_s',
        sourceModelRevision: 'hf-0572450e501be9eb1b1cdb7e00fccf4b22fab4df',
        sourceInferenceFiles: <String>['config.json', 'inference.json', 'inference.yml', 'inference.pdiparams'],
        conversionTool: 'paddle_lite_opt',
        conversionToolVersion: '2.10-compatible-with-bundled-PaddlePredictor.jar',
        androidTarget: 'android-arm64-v8a',
        conversionCommand: 'paddle_lite_opt --model_dir PP-FormulaNet-S --valid_targets=arm --optimize_out pp_formulanet_s_arm64',
        conversionLogDigest: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        outputFileName: 'pp_formulanet_s_arm64.nb',
        outputSha256: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef',
        outputSizeBytes: 2 * 1024 * 1024,
        downloadUrl: 'https://example.com/models/pp_formulanet_s_arm64.nb',
        conversionProvenance: 'placeholder source must be rejected by Q387R4 even if Q387R3 accepts shape',
        bundledInBaseApp: false,
      );
      final result = GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate(
        input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput(
          acquisitionEvidence: placeholder,
          explicitReviewerApproval: true,
          productionHostedSource: true,
        ),
      );
      expect(result.canBindToQ387R2ProductionSource, isFalse);
      expect(result.blockedReason, 'q387r4-placeholder-domain-rejected');
    });

    test('requires explicit reviewer approval and production hosting before binding', () {
      final noApproval = GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate(
        input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput(
          acquisitionEvidence: _completeEvidence,
          explicitReviewerApproval: false,
          productionHostedSource: true,
        ),
      );
      expect(noApproval.blockedReason, 'q387r4-explicit-reviewer-approval-required');

      final notHosted = GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate(
        input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput(
          acquisitionEvidence: _completeEvidence,
          explicitReviewerApproval: true,
          productionHostedSource: false,
        ),
      );
      expect(notHosted.blockedReason, 'q387r4-production-hosting-required');
    });

    test('constructs a Q387R2 source only from verified production evidence', () {
      final result = GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate(
        input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput(
          acquisitionEvidence: _completeEvidence,
          explicitReviewerApproval: true,
          productionHostedSource: true,
        ),
      );
      expect(result.canBindToQ387R2ProductionSource, isTrue);
      expect(result.canProceedToQ388RealInference, isTrue);
      expect(result.blockedReason, isEmpty);
      expect(result.verifiedSource?.fileName, 'pp_formulanet_s_arm64.nb');
      expect(result.verifiedSource?.downloadUrl, 'https://models.mathpro.app/ocr/pp_formulanet_s_arm64.nb');
      expect(result.verifiedSource?.sha256, '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef');
    });

    test('preserves download-only, no fake OCR, and protected-scope claims', () {
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.q387R2ProductionSourceBindingAllowedWithoutEvidence, isFalse);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.q388RealInferenceAllowedWithoutBoundSource, isFalse);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.rejectsExampleDotComPlaceholderSource, isTrue);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.onnxRuntimeReintroducedInBaseApk, isFalse);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.productionInferencePassClaimedByQ387R4, isFalse);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.fakeLatexCandidateAllowed, isFalse);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.keyboardQ382Touched, isFalse);
      expect(GaussPaddleLiteNbProductionSourceBindingQ387R4Policy.graphHistorySolutionSolverTouched, isFalse);
    });
  });
}
