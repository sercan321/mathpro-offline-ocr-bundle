import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_dummy_input_runtime_call_execution_q366.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_dummy_input_runtime_call_execution_q366_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q366 prepares explicit ONNX dummy input runtime call execution without auto OCR', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q366 = manifest['v172Q366OnnxDummyInputRuntimeCallExecution'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['onnxDummyInputRuntimeCallExecutionLatestPhase'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.phase);
    expect(q366['phase'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.phase);
    expect(q366['sourcePhase'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.sourcePhase);
    expect(q366['status'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.status);
    expect(q366['bridgeChannel'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.bridgeChannel);
    expect(q366['bridgeMethod'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.bridgeMethod);
    expect(q366['selectedDependencyCoordinate'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.selectedDependencyCoordinate);
    expect(q366['expectedOnnxArtifactSha256'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.expectedOnnxArtifactSha256);
    expect(q366['expectedOnnxArtifactSizeBytes'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.expectedOnnxArtifactSizeBytes);
    expect(q366['expectedPrivateStorageRelativePath'], GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.expectedPrivateStorageRelativePath);

    for (final key in <String>[
      'dummyInputRuntimeCallBridgePrepared',
      'explicitBridgeInvocationRequired',
      'requiresQ365ModelLoadSmoke',
      'privateStorageModelRequired',
      'sizeVerificationRequiredBeforeCall',
      'sha256VerificationRequiredBeforeCall',
      'dependencyClassProbeRequired',
      'dummyInputTensorShapePolicyPrepared',
      'resultClosePolicyPrepared',
      'tensorClosePolicyPrepared',
      'sessionClosePolicyPrepared',
      'startupDummyRuntimeCallBlocked',
      'cameraFlowDummyRuntimeCallBlocked',
      'workspaceFlowDummyRuntimeCallBlocked',
      'solveGraphSolutionHistoryDummyRuntimeCallBlocked',
      'requiresEditableMathLiveReviewBeforeImport',
      'requiresExplicitUserApprovalBeforeWorkspaceImport',
      'directOcrToWorkspaceImportBlocked',
      'directOcrToSolveGraphSolutionHistoryBlocked',
      'preservesQ363AsActiveProductPhase',
    ]) {
      expect(q366[key], isTrue, reason: '$key must stay true');
    }

    for (final key in <String>[
      'onnxModelBundledIntoFlutterProject',
      'onnxModelAutoCopiedAtStartup',
      'dummyRuntimeCallAutoExecuted',
      'dummyRuntimeCallAttemptedByPackage',
      'dummyRuntimeCallExecutedByPackage',
      'dummyRuntimeCallPassClaimedByPackage',
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
      expect(q366[key], isFalse, reason: '$key must stay false');
    }

    final result = GaussOnnxDummyInputRuntimeCallExecutionQ366.evaluate();
    expect(result.phase, GaussOnnxDummyInputRuntimeCallExecutionQ366Policy.phase);
    expect(result.dummyInputRuntimeCallBridgePrepared, isTrue);
    expect(result.explicitBridgeInvocationRequired, isTrue);
    expect(result.requiresQ365ModelLoadSmoke, isTrue);
    expect(result.dummyRuntimeCallAutoExecuted, isFalse);
    expect(result.dummyRuntimeCallAttemptedByPackage, isFalse);
    expect(result.dummyRuntimeCallPassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
