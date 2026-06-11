import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_evidence_capture_entry_q373.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_evidence_capture_entry_q373_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_flutter_evidence_harness_q372_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q373 prepares explicit evidence capture entry without auto OCR import or solve', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q373 = manifest['v172Q373ControlledOcrActivationEvidenceCaptureEntry'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['controlledOcrActivationEvidenceCaptureEntryLatestPhase'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.phase);
    expect(q373['phase'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.phase);
    expect(q373['sourcePhase'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.sourcePhase);
    expect(q373['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q373['requiresQ372FlutterHarnessPhase'], GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.phase);
    expect(q373['bridgeChannel'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.bridgeChannel);
    expect(q373['nativeBridgeMethod'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.nativeBridgeMethod);
    expect(q373['entryVersion'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.entryVersion);
    expect(q373['expectedOnnxModelFileName'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.expectedOnnxModelFileName);
    expect(q373['expectedOnnxModelSizeBytes'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.expectedOnnxModelSizeBytes);
    expect(q373['expectedOnnxModelSha256'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.expectedOnnxModelSha256);

    for (final key in <String>[
      'entryPrepared',
      'explicitUserInvocationRequired',
      'requiresModelSourcePath',
      'requiresImagePath',
      'requiresQ372FlutterHarness',
      'canRequestPrivateStorageActivation',
      'canRequestModelLoadSmoke',
      'canRequestDummyRuntimeCall',
      'canRequestImageToLatexInference',
      'canRequestReviewHandoff',
      'canRequestApprovedImportEnvelope',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'startupAutoExecutionBlocked',
      'cameraAutoExecutionBlocked',
      'workspaceAutoExecutionBlocked',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q373[key], isTrue, reason: '$key must stay true');
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
      expect(q373[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussControlledOcrActivationEvidenceCaptureEntryQ373.evaluate();
    expect(result.phase, GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.phase);
    expect(result.entryPrepared, isTrue);
    expect(result.explicitUserInvocationRequired, isTrue);
    expect(result.requiresQ372FlutterHarness, isTrue);
    expect(result.directOcrToWorkspaceImportBlocked, isTrue);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);

    const request = GaussControlledOcrActivationEvidenceCaptureEntryQ373Request(
      modelSourcePath: r'C:\MathProOcrArtifacts\pp_formulanet_s.onnx',
      imagePath: r'C:\MathProOcrFixtures\sample.png',
      candidateLatex: r'x+1',
      approvedLatex: r'x+1',
      candidateConfidence: 0.5,
      enablePrivateStorageActivation: true,
      enableModelLoadSmoke: true,
      enableDummyRuntimeCall: true,
      enableImageToLatex: true,
      enableReviewHandoff: true,
      enableApprovedImport: true,
      reviewCompleted: true,
      userApproved: true,
    );
    expect(request.hasRequiredEvidenceInputs, isTrue);
    expect(request.approvedImportMayBeRequested, isTrue);

    final args = GaussControlledOcrActivationEvidenceCaptureEntryQ373.buildEvidenceArguments(request);
    expect(args['modelSourcePath'], r'C:\MathProOcrArtifacts\pp_formulanet_s.onnx');
    expect(args['imagePath'], r'C:\MathProOcrFixtures\sample.png');
    expect(args['executePrivateStorageActivation'], isTrue);
    expect(args['executeModelLoadSmoke'], isTrue);
    expect(args['executeDummyRuntimeCall'], isTrue);
    expect(args['executeImageToLatex'], isTrue);
    expect(args['prepareReviewHandoff'], isTrue);
    expect(args['prepareApprovedImport'], isTrue);
    expect(args['reviewCompleted'], isTrue);
    expect(args['userApproved'], isTrue);
    expect(args['explicitUserApproval'], isTrue);
    expect(args['q373EntryVersion'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.entryVersion);
    expect(args['q373HasRequiredEvidenceInputs'], isTrue);
    expect(args['q373ApprovedImportMayBeRequested'], isTrue);
    expect(args['q373DirectOcrToWorkspaceImportBlocked'], isTrue);
  });
}
