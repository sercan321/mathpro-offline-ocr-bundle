import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_editable_mathlive_ocr_review_activation_q368.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_editable_mathlive_ocr_review_activation_q368_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q368 prepares editable MathLive OCR review activation without direct import or solve', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q368 = manifest['v172Q368EditableMathLiveOcrReviewActivation'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['editableMathLiveOcrReviewActivationLatestPhase'], GaussEditableMathLiveOcrReviewActivationQ368Policy.phase);
    expect(q368['phase'], GaussEditableMathLiveOcrReviewActivationQ368Policy.phase);
    expect(q368['sourcePhase'], GaussEditableMathLiveOcrReviewActivationQ368Policy.sourcePhase);
    expect(q368['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q368['status'], GaussEditableMathLiveOcrReviewActivationQ368Policy.status);
    expect(q368['bridgeChannel'], GaussEditableMathLiveOcrReviewActivationQ368Policy.bridgeChannel);
    expect(q368['bridgeMethod'], GaussEditableMathLiveOcrReviewActivationQ368Policy.bridgeMethod);
    expect(q368['candidateEnvelopeVersion'], GaussEditableMathLiveOcrReviewActivationQ368Policy.candidateEnvelopeVersion);

    for (final key in <String>[
      'editableMathLiveReviewActivationPrepared',
      'explicitBridgeInvocationRequired',
      'requiresQ367CandidateEnvelope',
      'requiresNonEmptyCandidateLatex',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'mathLiveProductionRoutePreserved',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q368[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'reviewUiAutoOpened',
      'workspaceImportExecuted',
      'approvedWorkspaceImportExecuted',
      'solveGraphSolutionHistoryTouched',
      'ocrPassClaimed',
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
      expect(q368[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussEditableMathLiveOcrReviewActivationQ368.evaluate();
    expect(result.phase, GaussEditableMathLiveOcrReviewActivationQ368Policy.phase);
    expect(result.editableMathLiveReviewActivationPrepared, isTrue);
    expect(result.requiresQ367CandidateEnvelope, isTrue);
    expect(result.requiresExplicitUserApprovalBeforeWorkspaceImport, isTrue);
    expect(result.reviewUiAutoOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
