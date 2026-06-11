import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_conversion_evidence_generator_q387r6.dart';

void main() {
  const sha = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
  const revision = '0572450e501be9eb1b1cdb7e00fccf4b22fab4df';

  GaussQ387R6PaddleLiteNbConversionEvidenceInput validInput() {
    return const GaussQ387R6PaddleLiteNbConversionEvidenceInput(
      sourceModelId: 'pp_formulanet_s',
      sourceModelRevision: revision,
      sourceInferenceFileSha256: <String, String>{
        'config.json': sha,
        'inference.json': sha,
        'inference.yml': sha,
        'inference.pdiparams': sha,
      },
      sourceInferenceFileSizeBytes: <String, int>{
        'config.json': 2048,
        'inference.json': 4096,
        'inference.yml': 4096,
        'inference.pdiparams': 232000000,
      },
      conversionTool: 'paddle_lite_opt',
      conversionToolVersion: '2.14',
      androidTarget: 'android-arm64-v8a',
      conversionCommand: 'paddle_lite_opt --model_file=inference.pdmodel --param_file=inference.pdiparams --optimize_out=pp_formulanet_s_arm64 --valid_targets=arm --optimize_out_type=naive_buffer',
      conversionLogDigest: sha,
      outputFileName: 'pp_formulanet_s_arm64.nb',
      outputSha256: sha,
      outputSizeBytes: 64000000,
      downloadUrl: 'https://models.examplecdn.com/releases/0572450e501be9eb1b1cdb7e00fccf4b22fab4df/pp_formulanet_s_arm64.nb',
      conversionProvenance: 'local audited paddle_lite_opt conversion from PP-FormulaNet-S pinned revision',
      bundledInBaseApp: false,
    );
  }

  test('Q387R6 blocks missing conversion evidence', () {
    final result = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate(input: null);

    expect(result.canWriteQ387R5EvidenceJson, isFalse);
    expect(result.blockedReason, GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionEvidenceRequiredBlockedReason);
  });

  test('Q387R6 rejects mutable source revisions', () {
    final input = validInput();
    final result = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate(
      input: GaussQ387R6PaddleLiteNbConversionEvidenceInput(
        sourceModelId: input.sourceModelId,
        sourceModelRevision: 'main',
        sourceInferenceFileSha256: input.sourceInferenceFileSha256,
        sourceInferenceFileSizeBytes: input.sourceInferenceFileSizeBytes,
        conversionTool: input.conversionTool,
        conversionToolVersion: input.conversionToolVersion,
        androidTarget: input.androidTarget,
        conversionCommand: input.conversionCommand,
        conversionLogDigest: input.conversionLogDigest,
        outputFileName: input.outputFileName,
        outputSha256: input.outputSha256,
        outputSizeBytes: input.outputSizeBytes,
        downloadUrl: input.downloadUrl,
        conversionProvenance: input.conversionProvenance,
        bundledInBaseApp: input.bundledInBaseApp,
      ),
    );

    expect(result.blockedReason, GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.sourceModelRevisionRequiredBlockedReason);
  });

  test('Q387R6 requires every source inference file digest and size', () {
    final input = validInput();
    final result = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate(
      input: GaussQ387R6PaddleLiteNbConversionEvidenceInput(
        sourceModelId: input.sourceModelId,
        sourceModelRevision: input.sourceModelRevision,
        sourceInferenceFileSha256: const <String, String>{'config.json': sha},
        sourceInferenceFileSizeBytes: const <String, int>{'config.json': 2048},
        conversionTool: input.conversionTool,
        conversionToolVersion: input.conversionToolVersion,
        androidTarget: input.androidTarget,
        conversionCommand: input.conversionCommand,
        conversionLogDigest: input.conversionLogDigest,
        outputFileName: input.outputFileName,
        outputSha256: input.outputSha256,
        outputSizeBytes: input.outputSizeBytes,
        downloadUrl: input.downloadUrl,
        conversionProvenance: input.conversionProvenance,
        bundledInBaseApp: input.bundledInBaseApp,
      ),
    );

    expect(result.blockedReason, GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.sourceInferenceFilesDigestRequiredBlockedReason);
  });

  test('Q387R6 rejects unsafe conversion commands without arm target', () {
    final input = validInput();
    final result = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate(
      input: GaussQ387R6PaddleLiteNbConversionEvidenceInput(
        sourceModelId: input.sourceModelId,
        sourceModelRevision: input.sourceModelRevision,
        sourceInferenceFileSha256: input.sourceInferenceFileSha256,
        sourceInferenceFileSizeBytes: input.sourceInferenceFileSizeBytes,
        conversionTool: input.conversionTool,
        conversionToolVersion: input.conversionToolVersion,
        androidTarget: input.androidTarget,
        conversionCommand: 'paddle_lite_opt --model_file=inference.pdmodel --param_file=inference.pdiparams --optimize_out=pp_formulanet_s_arm64',
        conversionLogDigest: input.conversionLogDigest,
        outputFileName: input.outputFileName,
        outputSha256: input.outputSha256,
        outputSizeBytes: input.outputSizeBytes,
        downloadUrl: input.downloadUrl,
        conversionProvenance: input.conversionProvenance,
        bundledInBaseApp: input.bundledInBaseApp,
      ),
    );

    expect(result.blockedReason, GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.conversionCommandRequiredBlockedReason);
  });

  test('Q387R6 rejects mutable hosted .nb URLs', () {
    final input = validInput();
    final result = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate(
      input: GaussQ387R6PaddleLiteNbConversionEvidenceInput(
        sourceModelId: input.sourceModelId,
        sourceModelRevision: input.sourceModelRevision,
        sourceInferenceFileSha256: input.sourceInferenceFileSha256,
        sourceInferenceFileSizeBytes: input.sourceInferenceFileSizeBytes,
        conversionTool: input.conversionTool,
        conversionToolVersion: input.conversionToolVersion,
        androidTarget: input.androidTarget,
        conversionCommand: input.conversionCommand,
        conversionLogDigest: input.conversionLogDigest,
        outputFileName: input.outputFileName,
        outputSha256: input.outputSha256,
        outputSizeBytes: input.outputSizeBytes,
        downloadUrl: 'https://huggingface.co/org/repo/resolve/main/pp_formulanet_s_arm64.nb',
        conversionProvenance: input.conversionProvenance,
        bundledInBaseApp: input.bundledInBaseApp,
      ),
    );

    expect(result.blockedReason, GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Policy.downloadUrlRequiredBlockedReason);
  });

  test('Q387R6 emits Q387R3 acquisition evidence for Q387R5 intake when complete', () {
    final result = GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate(input: validInput());

    expect(result.canWriteQ387R5EvidenceJson, isTrue);
    expect(result.canProceedToQ387R5Intake, isTrue);
    expect(result.blockedReason, isEmpty);
    expect(result.acquisitionEvidence?.outputFileName, 'pp_formulanet_s_arm64.nb');
    expect(result.acquisitionEvidence?.bundledInBaseApp, isFalse);
  });
}
