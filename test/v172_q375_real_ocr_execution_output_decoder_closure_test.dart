import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_evidence_readiness_aggregator_q374_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q375 closes OCR output decoder boundary without direct import or fake pass', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q375 = manifest['v172Q375RealOcrExecutionOutputDecoderClosure'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['realOcrExecutionOutputDecoderClosureLatestPhase'], GaussRealOcrExecutionOutputDecoderClosureQ375Policy.phase);
    expect(q375['phase'], GaussRealOcrExecutionOutputDecoderClosureQ375Policy.phase);
    expect(q375['sourcePhase'], GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.phase);
    expect(q375['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q375['bridgeChannel'], GaussRealOcrExecutionOutputDecoderClosureQ375Policy.bridgeChannel);
    expect(q375['bridgeMethod'], GaussRealOcrExecutionOutputDecoderClosureQ375Policy.bridgeMethod);
    expect(q375['decoderVersion'], GaussRealOcrExecutionOutputDecoderClosureQ375Policy.decoderVersion);

    for (final key in <String>[
      'realOcrExecutionOutputDecoderClosurePrepared',
      'q367OutputDecoderClosureExtended',
      'outputDecoderImplemented',
      'outputDecoderDoesNotInventLatex',
      'decoderRequiresReadableModelOutputOrExplicitOverride',
      'candidateLatexMustBeNonEmptyBeforeReview',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'startupAutoExecutionBlocked',
      'cameraAutoExecutionBlocked',
      'workspaceAutoExecutionBlocked',
      'mainActivityChanged',
    ]) {
      expect(q375[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'workspaceImportExecuted',
      'approvedWorkspaceImportExecuted',
      'solveGraphSolutionHistoryTouched',
      'ocrPassClaimed',
      'imageToLatexPassClaimedByPackage',
      'androidPassClaimed',
      'storeReadyPassClaimed',
      'releaseReadyPassClaimed',
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
      expect(q375[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussRealOcrExecutionOutputDecoderClosureQ375.evaluate();
    expect(result.phase, GaussRealOcrExecutionOutputDecoderClosureQ375Policy.phase);
    expect(result.outputDecoderImplemented, isTrue);
    expect(result.outputDecoderDoesNotInventLatex, isTrue);
    expect(result.directOcrToWorkspaceImportBlocked, isTrue);
    expect(result.ocrPassClaimed, isFalse);

    final blocked = GaussRealOcrExecutionOutputDecoderClosureQ375.decodeEvidence(const <String, Object?>{});
    expect(blocked.candidateLatexDecoded, isFalse);
    expect(blocked.decoderBlockedReason, isNotEmpty);
    expect(blocked.directOcrToWorkspaceImportBlocked, isTrue);

    final decoded = GaussRealOcrExecutionOutputDecoderClosureQ375.decodeEvidence(const <String, Object?>{
      'imageEvidence': <String, Object?>{
        'candidateLatex': r'x+1',
      },
      'candidateConfidence': 0.83,
    });
    expect(decoded.candidateLatexDecoded, isTrue);
    expect(decoded.candidateLatex, r'x+1');
    expect(decoded.candidateConfidence, 0.83);
    expect(decoded.toJson()['ocrPassClaimed'], isFalse);
  });
}
