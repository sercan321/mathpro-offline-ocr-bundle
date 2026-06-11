import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_paddle_lite_nb_user_side_conversion_protocol_q387r7.dart';

void main() {
  const revision = '0572450e501be9eb1b1cdb7e00fccf4b22fab4df';

  List<String> validCommands() => const <String>[
        'Set-StrictMode -Version Latest',
        r"$ErrorActionPreference = 'Stop'",
        'paddle_lite_opt --model_dir C:/models/pp-formulanet-s --optimize_out C:/models/out/pp_formulanet_s_arm64 --valid_targets=arm --optimize_out_type=naive_buffer',
        'node tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs --source-dir C:/models/pp-formulanet-s --output-nb C:/models/out/pp_formulanet_s_arm64.nb --reviewer-approved --production-hosted',
        'node tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs tool/reports/q387r6_paddle_lite_nb_conversion_evidence.json C:/models/out/pp_formulanet_s_arm64.nb',
      ];

  GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput validInput() {
    return GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput(
      sourceModelRevision: revision,
      sourceDirectoryPath: r'C:\MathProOcr\PP-FormulaNet-S',
      paddleLiteOptPath: r'C:\PaddleLite\paddle_lite_opt.exe',
      outputDirectoryPath: r'C:\MathProOcr\out',
      outputNbFileName: 'pp_formulanet_s_arm64.nb',
      downloadUrl: 'https://models.examplecdn.com/releases/0572450e501be9eb1b1cdb7e00fccf4b22fab4df/pp_formulanet_s_arm64.nb',
      conversionToolVersion: '2.14',
      conversionProvenance: 'audited local conversion protocol',
      powerShellScriptPath: r'C:\MathProOcr\run_q387r7_paddle_lite_nb_conversion_protocol.ps1',
      evidenceJsonPath: r'C:\MathProFlutterPhase17\tool\reports\q387r6_paddle_lite_nb_conversion_evidence.json',
      commandSequence: validCommands(),
      explicitReviewerApproval: true,
      productionHostedSource: true,
      bundledInBaseApp: false,
    );
  }

  test('Q387R7 blocks missing protocol input', () {
    final result = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate(input: null);

    expect(result.canGeneratePowerShellProtocol, isFalse);
    expect(result.blockedReason, GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.protocolInputRequiredBlockedReason);
  });

  test('Q387R7 rejects mutable source revisions', () {
    final input = validInput();
    final result = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate(
      input: GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput(
        sourceModelRevision: 'main',
        sourceDirectoryPath: input.sourceDirectoryPath,
        paddleLiteOptPath: input.paddleLiteOptPath,
        outputDirectoryPath: input.outputDirectoryPath,
        outputNbFileName: input.outputNbFileName,
        downloadUrl: input.downloadUrl,
        conversionToolVersion: input.conversionToolVersion,
        conversionProvenance: input.conversionProvenance,
        powerShellScriptPath: input.powerShellScriptPath,
        evidenceJsonPath: input.evidenceJsonPath,
        commandSequence: input.commandSequence,
        explicitReviewerApproval: input.explicitReviewerApproval,
        productionHostedSource: input.productionHostedSource,
        bundledInBaseApp: input.bundledInBaseApp,
      ),
    );

    expect(result.blockedReason, GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.immutableRevisionRequiredBlockedReason);
  });

  test('Q387R7 rejects non-nb outputs', () {
    final input = validInput();
    final result = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate(
      input: GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput(
        sourceModelRevision: input.sourceModelRevision,
        sourceDirectoryPath: input.sourceDirectoryPath,
        paddleLiteOptPath: input.paddleLiteOptPath,
        outputDirectoryPath: input.outputDirectoryPath,
        outputNbFileName: 'pp_formulanet_s_arm64.pdiparams',
        downloadUrl: input.downloadUrl,
        conversionToolVersion: input.conversionToolVersion,
        conversionProvenance: input.conversionProvenance,
        powerShellScriptPath: input.powerShellScriptPath,
        evidenceJsonPath: input.evidenceJsonPath,
        commandSequence: input.commandSequence,
        explicitReviewerApproval: input.explicitReviewerApproval,
        productionHostedSource: input.productionHostedSource,
        bundledInBaseApp: input.bundledInBaseApp,
      ),
    );

    expect(result.blockedReason, GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.outputNbFileRequiredBlockedReason);
  });

  test('Q387R7 rejects command sequences without Q387R5 intake', () {
    final input = validInput();
    final result = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate(
      input: GaussQ387R7PaddleLiteNbUserSideConversionProtocolInput(
        sourceModelRevision: input.sourceModelRevision,
        sourceDirectoryPath: input.sourceDirectoryPath,
        paddleLiteOptPath: input.paddleLiteOptPath,
        outputDirectoryPath: input.outputDirectoryPath,
        outputNbFileName: input.outputNbFileName,
        downloadUrl: input.downloadUrl,
        conversionToolVersion: input.conversionToolVersion,
        conversionProvenance: input.conversionProvenance,
        powerShellScriptPath: input.powerShellScriptPath,
        evidenceJsonPath: input.evidenceJsonPath,
        commandSequence: const <String>['paddle_lite_opt --optimize_out out --valid_targets=arm'],
        explicitReviewerApproval: input.explicitReviewerApproval,
        productionHostedSource: input.productionHostedSource,
        bundledInBaseApp: input.bundledInBaseApp,
      ),
    );

    expect(result.blockedReason, GaussPaddleLiteNbUserSideConversionProtocolQ387R7Policy.commandSequenceRequiredBlockedReason);
  });

  test('Q387R7 accepts complete PowerShell conversion protocol package', () {
    final result = GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate(input: validInput());

    expect(result.canGeneratePowerShellProtocol, isTrue);
    expect(result.canProceedToUserSideConversion, isTrue);
    expect(result.blockedReason, isEmpty);
    expect(result.expectedNextGate, contains('Q387R6'));
  });
}
