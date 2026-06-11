import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_evidence_capture_entry_q373_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_evidence_readiness_aggregator_q374.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_controlled_ocr_activation_evidence_readiness_aggregator_q374_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q374 classifies controlled OCR evidence without auto OCR import or solve', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q374 = manifest['v172Q374ControlledOcrActivationEvidenceReadinessAggregator'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['controlledOcrActivationEvidenceReadinessAggregatorLatestPhase'], GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.phase);
    expect(q374['phase'], GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.phase);
    expect(q374['sourcePhase'], GaussControlledOcrActivationEvidenceCaptureEntryQ373Policy.phase);
    expect(q374['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q374['aggregatorVersion'], GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.aggregatorVersion);
    expect(q374['expectedOnnxModelFileName'], GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.expectedOnnxModelFileName);
    expect(q374['expectedOnnxModelSizeBytes'], GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.expectedOnnxModelSizeBytes);
    expect(q374['expectedOnnxModelSha256'], GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.expectedOnnxModelSha256);

    for (final key in <String>[
      'aggregatorPrepared',
      'requiresQ373EvidenceCaptureEntry',
      'classifiesPrivateStorageReadiness',
      'classifiesModelLoadReadiness',
      'classifiesDummyRuntimeCallReadiness',
      'classifiesImageToLatexReadiness',
      'classifiesEditableMathLiveReviewReadiness',
      'classifiesApprovedWorkspaceImportReadiness',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'startupAutoExecutionBlocked',
      'cameraAutoExecutionBlocked',
      'workspaceAutoExecutionBlocked',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q374[key], isTrue, reason: '$key must stay true');
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
      expect(q374[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussControlledOcrActivationEvidenceReadinessAggregatorQ374.evaluate();
    expect(result.phase, GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.phase);
    expect(result.aggregatorPrepared, isTrue);
    expect(result.requiresQ373EvidenceCaptureEntry, isTrue);
    expect(result.cameraOcrUsableFlowReady, isFalse);
    expect(result.ocrPassClaimed, isFalse);

    final blocked = GaussControlledOcrActivationEvidenceReadinessAggregatorQ374.classifyEvidence(const <String, Object?>{});
    expect(blocked.cameraOcrUsableFlowReady, isFalse);
    expect(blocked.blockedReasons, contains('private-storage-not-ready'));
    expect(blocked.blockedReasons, contains('image-to-latex-candidate-not-ready'));

    final ready = GaussControlledOcrActivationEvidenceReadinessAggregatorQ374.classifyEvidence(const <String, Object?>{
      'privateStorageActivationEvidence': <String, Object?>{
        'targetReady': true,
        'sha256MatchesExpected': true,
      },
      'modelLoadSmokeEvidence': <String, Object?>{
        'modelLoaded': true,
        'blockedReason': '',
      },
      'dummyRuntimeCallEvidence': <String, Object?>{
        'dummyRuntimeCallSucceeded': true,
        'blockedReason': '',
      },
      'imageToLatexEvidence': <String, Object?>{
        'imageToLatexInferenceSucceeded': true,
        'candidateLatex': r'x+1',
      },
      'reviewHandoffEvidence': <String, Object?>{
        'reviewHandoffPrepared': true,
        'candidateLatex': r'x+1',
      },
      'approvedImportEvidence': <String, Object?>{
        'approvedWorkspaceImportEnvelopePrepared': true,
        'approvedLatex': r'x+1',
      },
    });
    expect(ready.cameraOcrUsableFlowReady, isTrue);
    expect(ready.blockedReasons, isEmpty);
    expect(ready.toJson()['directOcrToWorkspaceImportBlocked'], isTrue);
    expect(ready.toJson()['ocrPassClaimed'], isFalse);
  });
}
