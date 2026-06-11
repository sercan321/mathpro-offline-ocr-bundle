import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_prototype_bridge_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_prototype_bridge_gate_policy.dart';

void main() {
  group('V172-Q262 PP-FormulaNet-S runtime prototype bridge gate', () {
    const readyInput = GaussPpFormulaNetSRuntimePrototypeBridgeGateInput(
      q261RuntimeFeasibilityAdapterPresent: true,
      prototypeBridgeState: 'prototypeBridgeProtocolDraftReadyButRuntimeDisabled',
      allPrototypeBridgeStatesRepresented: true,
      officialOnDeviceDeploymentEvidenceReviewed: true,
      androidAbiMatrixPrepared: true,
      modelFormatCompatibilityEvidenceRequired: true,
      privateArtifactPathContractRequired: true,
      bridgeInputEnvelopeRequired: true,
      bridgeOutputEnvelopeRequired: true,
      timeoutAndCancellationPolicyRequired: true,
      memoryPressurePolicyRequired: true,
      latencyBudgetPolicyRequired: true,
      bridgeErrorTaxonomyRequired: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      runtimePrototypePassClaimed: false,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      prototypeBridgeLabel: 'Q262 prototype bridge protocol gate only',
    );

    test('policy keeps Q262 as bridge protocol gate only', () {
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.phase, 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE');
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.sourcePhase, 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER');
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.prototypeBridgeMode, 'runtime-prototype-bridge-gate-only-no-native-runtime-no-inference');
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.bridgeProtocolCandidates, contains('isolated Android method-channel protocol candidate'));
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.requiredBridgeProtocolGates, contains('bridgeInputEnvelopeRequired'));
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.blockedUntilRealEvidence, contains('realBridgeInvocationSmokeLog'));
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.paddleRuntimeAdded, isFalse);
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.jniBindingAdded, isFalse);
      expect(GaussPpFormulaNetSRuntimePrototypeBridgeGatePolicy.productionInferenceAllowed, isFalse);
    });

    test('passes only when bridge protocol is drafted and runtime binding remains absent', () {
      final result = GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.runtimePrototypeBridgeGateStaticReady);
      expect(result.runtimePrototypeBridgeGateStaticReady, isTrue);
      expect(result.prototypeBridgeMode, 'runtime-prototype-bridge-gate-only-no-native-runtime-no-inference');
      expect(result.bridgeInputEnvelopeFields, contains('croppedImagePathInPrivateStorage'));
      expect(result.bridgeOutputEnvelopeFields, contains('primaryLatexCandidate'));
      expect(result.requiredBridgeProtocolGates, contains('timeoutAndCancellationPolicyRequired'));
      expect(result.forbiddenActions, contains('runPpFormulaNetSInferenceInQ262'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimePrototypePassClaimed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canAddPaddleRuntimeInQ262, isFalse);
      expect(result.canAddJniBindingInQ262, isFalse);
      expect(result.canBindRuntimeMethodChannelInQ262, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canClaimRuntimePrototypePass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing predecessor, bridge state, ABI/model, envelope, safety, unsafe binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(q261RuntimeFeasibilityAdapterPresent: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedMissingQ261FeasibilityAdapter,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(prototypeBridgeState: 'unknown')).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedMissingBridgeProtocolState,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(androidAbiMatrixPrepared: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedMissingAbiOrModelFormatEvidence,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(bridgeInputEnvelopeRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedMissingBridgeEnvelope,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(latencyBudgetPolicyRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedMissingPerformanceOrSafetyPolicy,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(noJniBindingAdded: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedUnsafeRuntimeBinding,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(runtimePrototypePassClaimed: true)).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedUnsafeRuntimeBinding,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeBridgeGate.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeBridgeGateDecision.blockedMissingMathLiveReviewSafety,
      );
    });

    test('keeps dependencies, production bridge, and base APK free of runtime/model artifacts', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final prodBridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec.toLowerCase(), isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec.toLowerCase(), isNot(contains('paddleocr')));
      expect(pubspec.toLowerCase(), isNot(contains('paddle_flutter')));
      expect(pubspec.toLowerCase(), isNot(contains('paddle_lite')));
      expect(pubspec.toLowerCase(), isNot(contains('onnxruntime')));
      expect(pubspec.toLowerCase(), isNot(contains('flutter_downloader')));
      expect(pubspec.toLowerCase(), isNot(contains('background_downloader')));
      expect(settings, contains("id 'com.android.application' version '8.6.1' apply false"));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(prodBridge, isNot(contains('FormulaRecognition(')));
      expect(prodBridge, isNot(contains('runPpFormulaNetSInference')));
      expect(prodBridge, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
      expect(prodBridge, isNot(contains('startRealNetworkDownloadInQ260')));
      expect(prodBridge, isNot(contains('addPaddleRuntimeInQ262')));

      final forbiddenModelExtensions = RegExp(r'\.(onnx|tflite|pt|pth|pdmodel|pdiparams|pdparams|safetensors|bin)$', caseSensitive: false);
      final modelFiles = Directory.current
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) {
            final normalizedPath = file.path.replaceAll('\\', '/');
            return !normalizedPath.contains('/build/') && !normalizedPath.contains('/.dart_tool/');
          })
          .where((file) => forbiddenModelExtensions.hasMatch(file.path))
          .toList();
      expect(modelFiles, isEmpty);
    });
  });
}

extension on GaussPpFormulaNetSRuntimePrototypeBridgeGateInput {
  GaussPpFormulaNetSRuntimePrototypeBridgeGateInput copyForTest({
    bool? q261RuntimeFeasibilityAdapterPresent,
    String? prototypeBridgeState,
    bool? allPrototypeBridgeStatesRepresented,
    bool? officialOnDeviceDeploymentEvidenceReviewed,
    bool? androidAbiMatrixPrepared,
    bool? modelFormatCompatibilityEvidenceRequired,
    bool? privateArtifactPathContractRequired,
    bool? bridgeInputEnvelopeRequired,
    bool? bridgeOutputEnvelopeRequired,
    bool? timeoutAndCancellationPolicyRequired,
    bool? memoryPressurePolicyRequired,
    bool? latencyBudgetPolicyRequired,
    bool? bridgeErrorTaxonomyRequired,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noPaddleOcrDependencyAdded,
    bool? noNativeBridgeAdded,
    bool? noJniBindingAdded,
    bool? noMethodChannelRuntimeBindingAdded,
    bool? noModelBinaryBundledInBaseApp,
    bool? noProductionModelUrlBound,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? productionDownloadEnabled,
    bool? noProductionInferenceAllowed,
    bool? runtimePrototypePassClaimed,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? prototypeBridgeLabel,
  }) {
    return GaussPpFormulaNetSRuntimePrototypeBridgeGateInput(
      q261RuntimeFeasibilityAdapterPresent: q261RuntimeFeasibilityAdapterPresent ?? this.q261RuntimeFeasibilityAdapterPresent,
      prototypeBridgeState: prototypeBridgeState ?? this.prototypeBridgeState,
      allPrototypeBridgeStatesRepresented: allPrototypeBridgeStatesRepresented ?? this.allPrototypeBridgeStatesRepresented,
      officialOnDeviceDeploymentEvidenceReviewed: officialOnDeviceDeploymentEvidenceReviewed ?? this.officialOnDeviceDeploymentEvidenceReviewed,
      androidAbiMatrixPrepared: androidAbiMatrixPrepared ?? this.androidAbiMatrixPrepared,
      modelFormatCompatibilityEvidenceRequired: modelFormatCompatibilityEvidenceRequired ?? this.modelFormatCompatibilityEvidenceRequired,
      privateArtifactPathContractRequired: privateArtifactPathContractRequired ?? this.privateArtifactPathContractRequired,
      bridgeInputEnvelopeRequired: bridgeInputEnvelopeRequired ?? this.bridgeInputEnvelopeRequired,
      bridgeOutputEnvelopeRequired: bridgeOutputEnvelopeRequired ?? this.bridgeOutputEnvelopeRequired,
      timeoutAndCancellationPolicyRequired: timeoutAndCancellationPolicyRequired ?? this.timeoutAndCancellationPolicyRequired,
      memoryPressurePolicyRequired: memoryPressurePolicyRequired ?? this.memoryPressurePolicyRequired,
      latencyBudgetPolicyRequired: latencyBudgetPolicyRequired ?? this.latencyBudgetPolicyRequired,
      bridgeErrorTaxonomyRequired: bridgeErrorTaxonomyRequired ?? this.bridgeErrorTaxonomyRequired,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noPaddleOcrDependencyAdded: noPaddleOcrDependencyAdded ?? this.noPaddleOcrDependencyAdded,
      noNativeBridgeAdded: noNativeBridgeAdded ?? this.noNativeBridgeAdded,
      noJniBindingAdded: noJniBindingAdded ?? this.noJniBindingAdded,
      noMethodChannelRuntimeBindingAdded: noMethodChannelRuntimeBindingAdded ?? this.noMethodChannelRuntimeBindingAdded,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      runtimePrototypePassClaimed: runtimePrototypePassClaimed ?? this.runtimePrototypePassClaimed,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      prototypeBridgeLabel: prototypeBridgeLabel ?? this.prototypeBridgeLabel,
    );
  }
}
