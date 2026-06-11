import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_end_to_end_final_device_closure_q377.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_end_to_end_final_device_closure_q377_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_editable_review_approved_workspace_import_binding_q376_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q377 records camera OCR end-to-end final device closure without claiming static OCR pass', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q377 = manifest['v172Q377CameraOcrEndToEndFinalDeviceClosure'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['cameraOcrEndToEndFinalDeviceClosureLatestPhase'], GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.phase);
    expect(q377['phase'], GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.phase);
    expect(q377['sourcePhase'], GaussRealEditableReviewApprovedWorkspaceImportBindingQ376Policy.phase);
    expect(q377['activeProductGatePreservedPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q377['closureVersion'], GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.closureVersion);
    expect(q377['evidenceChain'], GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.evidenceChain);

    for (final key in <String>[
      'finalClosureContractPrepared',
      'requiresFinalUserSideEvidence',
      'requiresFlutterAnalyzePass',
      'requiresFlutterTestPass',
      'requiresFlutterRunPass',
      'requiresPrivateStorageEvidence',
      'requiresModelLoadSmokeEvidence',
      'requiresDummyRuntimeCallEvidence',
      'requiresImageToLatexEvidence',
      'requiresEditableMathLiveReviewEvidence',
      'requiresApprovedWorkspaceImportEvidence',
      'directOcrToWorkspaceBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'keyboardProtected',
      'mathLiveProductionRouteProtected',
      'workspaceUiProtected',
    ]) {
      expect(q377[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'workspaceImportAutoExecuted',
      'solveGraphSolutionHistoryTouched',
      'ocrPassClaimedByPackage',
      'androidPassClaimedByPackage',
      'storeReadyPassClaimedByPackage',
      'releaseReadyPassClaimedByPackage',
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
      expect(q377[key], isFalse, reason: '$key must stay false');
    }

    final blocked = GaussCameraOcrEndToEndFinalDeviceClosureQ377.evaluate();
    expect(blocked.phase, GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy.phase);
    expect(blocked.cameraOcrEndToEndEvidenceComplete, isFalse);
    expect(blocked.cameraOcrUsableFlowReady, isFalse);
    expect(blocked.blockedReasons, contains('flutter-analyze-evidence-missing'));
    expect(blocked.blockedReasons, contains('q364-private-storage-evidence-missing'));
    expect(blocked.ocrPassClaimedByPackage, isFalse);
    expect(blocked.workspaceImportAutoExecuted, isFalse);

    final complete = GaussCameraOcrEndToEndFinalDeviceClosureQ377.evaluate(
      evidence: const GaussCameraOcrEndToEndEvidenceQ377(
        flutterAnalyzePass: true,
        flutterTestPass: true,
        flutterRunRealDevicePass: true,
        privateStorageReady: true,
        modelLoadSmokePass: true,
        dummyRuntimeCallPass: true,
        imageToLatexCandidatePass: true,
        editableMathLiveReviewPass: true,
        approvedWorkspaceImportEnvelopePass: true,
        reviewFirstApprovedImportBindingPass: true,
      ),
    );
    expect(complete.cameraOcrEndToEndEvidenceComplete, isTrue);
    expect(complete.cameraOcrUsableFlowReady, isTrue);
    expect(complete.blockedReasons, isEmpty);
    expect(complete.directOcrToWorkspaceBlocked, isTrue);
    expect(complete.directOcrToSolveGraphSolutionHistoryBlocked, isTrue);
    expect(complete.ocrPassClaimedByPackage, isFalse);
    expect(complete.toJson()['releaseReadyPassClaimedByPackage'], isFalse);
  });
}
