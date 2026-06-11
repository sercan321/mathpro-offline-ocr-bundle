import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_flutter_evidence_harness_q372.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_flutter_evidence_harness_q372_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q372 prepares explicit Flutter evidence harness without auto OCR import or solve', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q372 = manifest['v172Q372ControlledOcrActivationFlutterEvidenceHarness'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['controlledOcrActivationFlutterEvidenceHarnessLatestPhase'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.phase);
    expect(q372['phase'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.phase);
    expect(q372['sourcePhase'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.sourcePhase);
    expect(q372['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q372['bridgeChannel'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.bridgeChannel);
    expect(q372['nativeBridgeMethod'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.nativeBridgeMethod);
    expect(q372['harnessVersion'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.harnessVersion);
    expect(q372['expectedOnnxModelFileName'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.expectedOnnxModelFileName);
    expect(q372['expectedOnnxModelSizeBytes'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.expectedOnnxModelSizeBytes);
    expect(q372['expectedOnnxModelSha256'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.expectedOnnxModelSha256);

    for (final key in <String>[
      'flutterHarnessPrepared',
      'explicitUserInvocationRequired',
      'requiresQ371NativeEvidenceCapture',
      'canRequestQ364PrivateStorageActivation',
      'canRequestQ365ModelLoadSmoke',
      'canRequestQ366DummyRuntimeCall',
      'canRequestQ367ImageToLatexInference',
      'canRequestQ368EditableMathLiveReview',
      'canRequestQ369ApprovedWorkspaceImport',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'startupAutoExecutionBlocked',
      'cameraAutoExecutionBlocked',
      'workspaceAutoExecutionBlocked',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q372[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'workspaceImportExecuted',
      'approvedWorkspaceImportExecuted',
      'solveGraphSolutionHistoryTouched',
      'ocrPassClaimed',
      'androidPassClaimed',
      'storeReadyPassClaimed',
      'releaseReadyPassClaimed',
      'mainActivityChanged',
      'pubspecChanged',
      'gradleChanged',
      'androidManifestChanged',
      'keyboardChanged',
      'moreTemplateTrayChanged',
      'longPressChanged',
      'mathLiveProductionBridgeChanged',
      'workspaceChanged',
      'graphChanged',
      'solutionChanged',
      'historyChanged',
      'splashChanged',
      'iconChanged',
    ]) {
      expect(q372[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussControlledOcrActivationFlutterEvidenceHarnessQ372.evaluate();
    expect(result.phase, GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.phase);
    expect(result.flutterHarnessPrepared, isTrue);
    expect(result.explicitUserInvocationRequired, isTrue);
    expect(result.requiresQ371NativeEvidenceCapture, isTrue);
    expect(result.directOcrToWorkspaceImportBlocked, isTrue);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);

    const request = GaussControlledOcrActivationFlutterEvidenceHarnessQ372Request(
      modelSourcePath: r'C:\MathProOcrArtifacts\pp_formulanet_s.onnx',
      imagePath: r'C:\MathProOcrFixtures\sample.png',
      candidateLatex: r'x+1',
      approvedLatex: r'x+1',
      candidateConfidence: 0.5,
      executePrivateStorageActivation: true,
      executeModelLoadSmoke: true,
      executeDummyRuntimeCall: true,
      executeImageToLatex: true,
      prepareReviewHandoff: true,
      prepareApprovedImport: true,
      reviewCompleted: true,
      userApproved: true,
    );
    final args = GaussControlledOcrActivationFlutterEvidenceHarnessQ372.buildArguments(request);
    expect(args['modelSourcePath'], r'C:\MathProOcrArtifacts\pp_formulanet_s.onnx');
    expect(args['sourcePath'], args['modelSourcePath']);
    expect(args['imagePath'], r'C:\MathProOcrFixtures\sample.png');
    expect(args['sourceImagePath'], args['imagePath']);
    expect(args['executePrivateStorageActivation'], isTrue);
    expect(args['executeModelLoadSmoke'], isTrue);
    expect(args['executeDummyRuntimeCall'], isTrue);
    expect(args['executeImageToLatex'], isTrue);
    expect(args['reviewCompleted'], isTrue);
    expect(args['userApproved'], isTrue);
    expect(args['explicitUserApproval'], isTrue);
    expect(args['q372HarnessVersion'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.harnessVersion);
  });
}
