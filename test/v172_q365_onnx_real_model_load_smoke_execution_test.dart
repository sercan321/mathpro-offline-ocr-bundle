import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_real_model_load_smoke_execution_q365.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_real_model_load_smoke_execution_q365_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q365 prepares explicit ONNX model-load smoke execution without auto OCR', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q365 = manifest['v172Q365OnnxRealModelLoadSmokeExecution'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['onnxRealModelLoadSmokeExecutionLatestPhase'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.phase);
    expect(q365['phase'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.phase);
    expect(q365['sourcePhase'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.sourcePhase);
    expect(q365['status'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.status);
    expect(q365['bridgeChannel'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.bridgeChannel);
    expect(q365['bridgeMethod'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.bridgeMethod);
    expect(q365['selectedDependencyCoordinate'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.selectedDependencyCoordinate);
    expect(q365['expectedOnnxArtifactSha256'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.expectedOnnxArtifactSha256);
    expect(q365['expectedOnnxArtifactSizeBytes'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.expectedOnnxArtifactSizeBytes);
    expect(q365['expectedPrivateStorageRelativePath'], GaussOnnxRealModelLoadSmokeExecutionQ365Policy.expectedPrivateStorageRelativePath);

    for (final key in <String>[
      'realModelLoadSmokeBridgePrepared',
      'explicitBridgeInvocationRequired',
      'privateStorageModelRequired',
      'sizeVerificationRequiredBeforeLoad',
      'sha256VerificationRequiredBeforeLoad',
      'dependencyClassProbeRequired',
      'ortEnvironmentSessionPolicyPrepared',
      'sessionClosePolicyPrepared',
      'inputOutputNameCapturePrepared',
      'startupModelLoadBlocked',
      'cameraFlowModelLoadBlocked',
      'workspaceFlowModelLoadBlocked',
      'solveGraphSolutionHistoryModelLoadBlocked',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q365[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'onnxModelBundledIntoFlutterProject',
      'onnxModelAutoCopiedAtStartup',
      'modelLoadAutoExecuted',
      'modelLoadAttemptedByPackage',
      'modelLoadExecutedByPackage',
      'modelLoadPassClaimedByPackage',
      'dummyRuntimeCallExecuted',
      'imageToLatexInferenceExecuted',
      'editableMathLiveReviewOpened',
      'workspaceImportExecuted',
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
      expect(q365[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussOnnxRealModelLoadSmokeExecutionQ365.evaluate();
    expect(result.phase, GaussOnnxRealModelLoadSmokeExecutionQ365Policy.phase);
    expect(result.realModelLoadSmokeBridgePrepared, isTrue);
    expect(result.explicitBridgeInvocationRequired, isTrue);
    expect(result.modelLoadAutoExecuted, isFalse);
    expect(result.modelLoadAttemptedByPackage, isFalse);
    expect(result.modelLoadPassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
