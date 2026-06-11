import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_external_artifact_intake_q387r5.dart';

const _sha = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
const _logDigest = 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';

GaussQ387R3PaddleLiteNbAcquisitionEvidence _evidence({
  String sourceModelRevision = '0572450e501be9eb1b1cdb7e00fccf4b22fab4df',
  String downloadUrl = 'https://models.mathpro.example-cdn.net/pp-formulanet-s/0572450e501be9eb1b1cdb7e00fccf4b22fab4df/pp_formulanet_s_arm64.nb',
  String outputSha256 = _sha,
  int outputSizeBytes = 4 * 1024 * 1024,
  bool bundledInBaseApp = false,
}) {
  return GaussQ387R3PaddleLiteNbAcquisitionEvidence(
    sourceModelId: 'pp_formulanet_s',
    sourceModelRevision: sourceModelRevision,
    sourceInferenceFiles: const <String>[
      'config.json',
      'inference.json',
      'inference.yml',
      'inference.pdiparams',
    ],
    conversionTool: 'paddle_lite_opt',
    conversionToolVersion: '2.13.0',
    androidTarget: 'android-arm64-v8a',
    conversionCommand: 'paddle_lite_opt --model_dir ./PP-FormulaNet-S --valid_targets=arm --optimize_out ./pp_formulanet_s_arm64',
    conversionLogDigest: _logDigest,
    outputFileName: 'pp_formulanet_s_arm64.nb',
    outputSha256: outputSha256,
    outputSizeBytes: outputSizeBytes,
    downloadUrl: downloadUrl,
    conversionProvenance: 'external conversion log reviewed and hosted as immutable artifact',
    bundledInBaseApp: bundledInBaseApp,
  );
}

void main() {
  test('Q387R5 blocks missing external artifact evidence', () {
    final result = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate(
      input: const GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput(
        acquisitionEvidence: null,
        explicitReviewerApproval: false,
        productionHostedSource: false,
        localFileSha256: null,
        localFileSizeBytes: null,
      ),
    );

    expect(result.canBindToQ387R2ProductionSource, isFalse);
    expect(result.blockedReason, GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.externalArtifactRequiredBlockedReason);
  });

  test('Q387R5 rejects mutable branch URLs even if Q387R4 would see an https .nb path', () {
    final result = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate(
      input: GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput(
        acquisitionEvidence: _evidence(
          downloadUrl: 'https://huggingface.co/acme/pp-formulanet-s/resolve/main/pp_formulanet_s_arm64.nb',
        ),
        explicitReviewerApproval: true,
        productionHostedSource: true,
        localFileSha256: null,
        localFileSizeBytes: null,
      ),
    );

    expect(result.canBindToQ387R2ProductionSource, isFalse);
    expect(result.blockedReason, GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.mutableDownloadUrlRejectedBlockedReason);
  });

  test('Q387R5 rejects non-immutable source revisions', () {
    final result = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate(
      input: GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput(
        acquisitionEvidence: _evidence(sourceModelRevision: 'main'),
        explicitReviewerApproval: true,
        productionHostedSource: true,
        localFileSha256: null,
        localFileSizeBytes: null,
      ),
    );

    expect(result.canProceedToQ388RealInference, isFalse);
    expect(result.blockedReason, GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.immutableSourceRequiredBlockedReason);
  });

  test('Q387R5 verifies optional local file SHA/size evidence before source handoff', () {
    final result = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate(
      input: GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput(
        acquisitionEvidence: _evidence(),
        explicitReviewerApproval: true,
        productionHostedSource: true,
        localFileSha256: _sha,
        localFileSizeBytes: 4 * 1024 * 1024,
      ),
    );

    expect(result.canBindToQ387R2ProductionSource, isTrue);
    expect(result.q387R2Source, isNotNull);
    expect(result.q387R2Source!.sha256, _sha);
  });

  test('Q387R5 rejects local file SHA/size mismatch', () {
    final result = GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate(
      input: GaussQ387R5PaddleLiteNbExternalArtifactIntakeInput(
        acquisitionEvidence: _evidence(),
        explicitReviewerApproval: true,
        productionHostedSource: true,
        localFileSha256: 'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc',
        localFileSizeBytes: 4 * 1024 * 1024,
      ),
    );

    expect(result.canBindToQ387R2ProductionSource, isFalse);
    expect(result.blockedReason, GaussPaddleLiteNbExternalArtifactIntakeQ387R5Policy.localFileDigestMismatchBlockedReason);
  });
}
