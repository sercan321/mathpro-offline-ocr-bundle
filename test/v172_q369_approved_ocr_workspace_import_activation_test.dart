import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_activation_q369.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_approved_ocr_workspace_import_activation_q369_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q369 prepares approved OCR workspace import activation without auto import or solve', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q369 = manifest['v172Q369ApprovedOcrWorkspaceImportActivation'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['approvedOcrWorkspaceImportActivationLatestPhase'], GaussApprovedOcrWorkspaceImportActivationQ369Policy.phase);
    expect(q369['phase'], GaussApprovedOcrWorkspaceImportActivationQ369Policy.phase);
    expect(q369['sourcePhase'], GaussApprovedOcrWorkspaceImportActivationQ369Policy.sourcePhase);
    expect(q369['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q369['status'], GaussApprovedOcrWorkspaceImportActivationQ369Policy.status);
    expect(q369['bridgeChannel'], GaussApprovedOcrWorkspaceImportActivationQ369Policy.bridgeChannel);
    expect(q369['bridgeMethod'], GaussApprovedOcrWorkspaceImportActivationQ369Policy.bridgeMethod);
    expect(q369['approvedImportEnvelopeVersion'], GaussApprovedOcrWorkspaceImportActivationQ369Policy.approvedImportEnvelopeVersion);

    for (final key in <String>[
      'approvedWorkspaceImportActivationPrepared',
      'explicitBridgeInvocationRequired',
      'requiresQ368EditableReviewHandoff',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'requiresNonEmptyApprovedLatex',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'mathLiveProductionRoutePreserved',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q369[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'workspaceImportAutoExecuted',
      'workspaceImportExecuted',
      'approvedWorkspaceImportExecuted',
      'solveGraphSolutionHistoryTouched',
      'reviewUiAutoOpened',
      'ocrPassClaimed',
      'workspaceImportPassClaimedByPackage',
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
      expect(q369[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussApprovedOcrWorkspaceImportActivationQ369.evaluate();
    expect(result.phase, GaussApprovedOcrWorkspaceImportActivationQ369Policy.phase);
    expect(result.approvedWorkspaceImportActivationPrepared, isTrue);
    expect(result.requiresQ368EditableReviewHandoff, isTrue);
    expect(result.requiresExplicitUserApprovalBeforeWorkspaceImport, isTrue);
    expect(result.workspaceImportAutoExecuted, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
