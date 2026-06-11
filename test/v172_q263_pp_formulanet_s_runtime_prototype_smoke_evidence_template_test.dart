import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_prototype_smoke_evidence_template.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_prototype_smoke_evidence_template_policy.dart';

void main() {
  group('V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE', () {
    const readyInput = GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateInput(
      q262RuntimePrototypeBridgeGatePresent: true,
      smokeEvidenceState: 'smokeEvidenceTemplateReadyButRuntimeDisabled',
      allSmokeEvidenceStatesRepresented: true,
      realDeviceIdentityTemplateRequired: true,
      androidAbiMatrixCaptureRequired: true,
      privateArtifactLoadSmokeTemplateRequired: true,
      modelFormatProbeTemplateRequired: true,
      bridgeInputEnvelopeTemplateRequired: true,
      bridgeOutputEnvelopeTemplateRequired: true,
      bridgeInvocationSmokeTemplateRequired: true,
      latencyMeasurementTemplateRequired: true,
      peakMemoryMeasurementTemplateRequired: true,
      timeoutCancellationEvidenceTemplateRequired: true,
      memoryPressureEvidenceTemplateRequired: true,
      bridgeErrorTaxonomyEvidenceTemplateRequired: true,
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
      runtimeSmokePassClaimed: false,
      ocrPassClaimed: false,
      mathLiveReviewEvidenceTemplateRequired: true,
      noDirectSolveGraphSolutionHistoryEvidenceRequired: true,
      smokeEvidenceLabel: 'Q263 real-device smoke evidence template only',
    );

    test('declares Q263 smoke evidence template without adding runtime or inference', () {
      final result = GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.runtimePrototypeSmokeEvidenceTemplateStaticReady);
      expect(result.runtimePrototypeSmokeEvidenceTemplateStaticReady, isTrue);
      expect(result.phase, GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplatePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(result.smokeEvidenceMode, 'runtime-prototype-smoke-evidence-template-only-no-runtime-no-inference');
      expect(result.requiredSmokeEvidenceFields, contains('latencyMs'));
      expect(result.requiredSmokeEvidenceFields, contains('mathLiveReviewOpened'));
      expect(result.requiredTemplateGates, contains('noOcrPassWithoutRealInferenceEvidence'));
      expect(result.blockedUntilRealEvidence, contains('realDeviceRuntimeSmokeJson'));
      expect(result.forbiddenActions, contains('runPpFormulaNetSInferenceInQ263'));
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
      expect(result.runtimeSmokePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canAddPaddleRuntimeInQ263, isFalse);
      expect(result.canAddNativeBridgeInQ263, isFalse);
      expect(result.canBindRuntimeMethodChannelInQ263, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canClaimRuntimeSmokePass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks predecessor, evidence-template, performance, unsafe binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(q262RuntimePrototypeBridgeGatePresent: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedMissingQ262BridgeGate,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(smokeEvidenceState: 'unknown')).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedMissingSmokeEvidenceState,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(androidAbiMatrixCaptureRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedMissingDeviceAndAbiTemplate,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(modelFormatProbeTemplateRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedMissingArtifactLoadTemplate,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(bridgeOutputEnvelopeTemplateRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedMissingBridgeInvocationTemplate,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(peakMemoryMeasurementTemplateRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedMissingPerformanceTemplate,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(noMethodChannelRuntimeBindingAdded: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedUnsafeRuntimeBinding,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(runtimeSmokePassClaimed: true)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedUnsafeRuntimeBinding,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(ocrPassClaimed: true)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedUnsafeRuntimeBinding,
      );
      expect(
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplate.evaluate(readyInput.copyForTest(mathLiveReviewEvidenceTemplateRequired: false)).decision,
        GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateDecision.blockedMissingReviewSafetyEvidence,
      );
    });

    test('keeps dependencies, production bridge, and base APK free of runtime/model artifacts', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final prodBridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'paddleocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'flutter_downloader',
        'background_downloader',
      ]) {
        expect(pubspec.toLowerCase(), isNot(contains(forbidden)));
      }
      expect(settings, contains("id 'com.android.application' version '8.6.1' apply false"));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(prodBridge, isNot(contains('FormulaRecognition(')));
      expect(prodBridge, isNot(contains('runPpFormulaNetSInference')));
      expect(prodBridge, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
      expect(prodBridge, isNot(contains('bindRuntimeMethodChannelInQ263')));
      expect(prodBridge, isNot(contains('claimRuntimeSmokePassWithoutRealDeviceEvidence')));

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

extension on GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateInput {
  GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateInput copyForTest({
    bool? q262RuntimePrototypeBridgeGatePresent,
    String? smokeEvidenceState,
    bool? allSmokeEvidenceStatesRepresented,
    bool? realDeviceIdentityTemplateRequired,
    bool? androidAbiMatrixCaptureRequired,
    bool? privateArtifactLoadSmokeTemplateRequired,
    bool? modelFormatProbeTemplateRequired,
    bool? bridgeInputEnvelopeTemplateRequired,
    bool? bridgeOutputEnvelopeTemplateRequired,
    bool? bridgeInvocationSmokeTemplateRequired,
    bool? latencyMeasurementTemplateRequired,
    bool? peakMemoryMeasurementTemplateRequired,
    bool? timeoutCancellationEvidenceTemplateRequired,
    bool? memoryPressureEvidenceTemplateRequired,
    bool? bridgeErrorTaxonomyEvidenceTemplateRequired,
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
    bool? runtimeSmokePassClaimed,
    bool? ocrPassClaimed,
    bool? mathLiveReviewEvidenceTemplateRequired,
    bool? noDirectSolveGraphSolutionHistoryEvidenceRequired,
    String? smokeEvidenceLabel,
  }) {
    return GaussPpFormulaNetSRuntimePrototypeSmokeEvidenceTemplateInput(
      q262RuntimePrototypeBridgeGatePresent: q262RuntimePrototypeBridgeGatePresent ?? this.q262RuntimePrototypeBridgeGatePresent,
      smokeEvidenceState: smokeEvidenceState ?? this.smokeEvidenceState,
      allSmokeEvidenceStatesRepresented: allSmokeEvidenceStatesRepresented ?? this.allSmokeEvidenceStatesRepresented,
      realDeviceIdentityTemplateRequired: realDeviceIdentityTemplateRequired ?? this.realDeviceIdentityTemplateRequired,
      androidAbiMatrixCaptureRequired: androidAbiMatrixCaptureRequired ?? this.androidAbiMatrixCaptureRequired,
      privateArtifactLoadSmokeTemplateRequired: privateArtifactLoadSmokeTemplateRequired ?? this.privateArtifactLoadSmokeTemplateRequired,
      modelFormatProbeTemplateRequired: modelFormatProbeTemplateRequired ?? this.modelFormatProbeTemplateRequired,
      bridgeInputEnvelopeTemplateRequired: bridgeInputEnvelopeTemplateRequired ?? this.bridgeInputEnvelopeTemplateRequired,
      bridgeOutputEnvelopeTemplateRequired: bridgeOutputEnvelopeTemplateRequired ?? this.bridgeOutputEnvelopeTemplateRequired,
      bridgeInvocationSmokeTemplateRequired: bridgeInvocationSmokeTemplateRequired ?? this.bridgeInvocationSmokeTemplateRequired,
      latencyMeasurementTemplateRequired: latencyMeasurementTemplateRequired ?? this.latencyMeasurementTemplateRequired,
      peakMemoryMeasurementTemplateRequired: peakMemoryMeasurementTemplateRequired ?? this.peakMemoryMeasurementTemplateRequired,
      timeoutCancellationEvidenceTemplateRequired: timeoutCancellationEvidenceTemplateRequired ?? this.timeoutCancellationEvidenceTemplateRequired,
      memoryPressureEvidenceTemplateRequired: memoryPressureEvidenceTemplateRequired ?? this.memoryPressureEvidenceTemplateRequired,
      bridgeErrorTaxonomyEvidenceTemplateRequired: bridgeErrorTaxonomyEvidenceTemplateRequired ?? this.bridgeErrorTaxonomyEvidenceTemplateRequired,
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
      runtimeSmokePassClaimed: runtimeSmokePassClaimed ?? this.runtimeSmokePassClaimed,
      ocrPassClaimed: ocrPassClaimed ?? this.ocrPassClaimed,
      mathLiveReviewEvidenceTemplateRequired: mathLiveReviewEvidenceTemplateRequired ?? this.mathLiveReviewEvidenceTemplateRequired,
      noDirectSolveGraphSolutionHistoryEvidenceRequired: noDirectSolveGraphSolutionHistoryEvidenceRequired ?? this.noDirectSolveGraphSolutionHistoryEvidenceRequired,
      smokeEvidenceLabel: smokeEvidenceLabel ?? this.smokeEvidenceLabel,
    );
  }
}
