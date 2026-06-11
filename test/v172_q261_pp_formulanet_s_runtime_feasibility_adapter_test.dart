import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_feasibility_adapter.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_feasibility_adapter_policy.dart';

void main() {
  group('V172-Q261 PP-FormulaNet-S runtime feasibility adapter', () {
    const readyInput = GaussPpFormulaNetSRuntimeFeasibilityAdapterInput(
      q260RealModelDownloadIntegrationGatePresent: true,
      feasibilityState: 'runtimeFeasibilityBlockedUntilRealEvidence',
      allFeasibilityStatesRepresented: true,
      officialOnDeviceDeploymentEvidenceRequired: true,
      ppFormulaNetSModelFormatEvidenceRequired: true,
      androidRuntimePathEvidenceRequired: true,
      abiCompatibilityEvidenceRequired: true,
      nativeBridgePlanEvidenceRequired: true,
      modelArtifactPrivateStorageAccessRequired: true,
      latencyBudgetEvidenceRequired: true,
      peakMemoryBudgetEvidenceRequired: true,
      offlineAfterInstallEvidenceRequired: true,
      thermalAndBatteryRiskReviewRequired: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      runtimeFeasibilityPassClaimed: false,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      feasibilityLabel: 'Q261 runtime feasibility adapter gate only',
    );

    test('policy keeps Q261 as runtime feasibility gate only', () {
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.phase, 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER');
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.sourcePhase, 'V172-Q260-PP-FORMULANET-S-REAL-MODEL-DOWNLOAD-INTEGRATION-GATE');
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.feasibilityMode, 'runtime-feasibility-adapter-gate-only-no-paddle-runtime-no-inference');
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.runtimePathCandidates, contains('Paddle Lite / on-device Android shell feasibility'));
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.requiredFeasibilityGates, contains('officialOnDeviceDeploymentEvidence'));
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.blockedUntilRealEvidence, contains('realAndroidRuntimePrototypeLog'));
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.nativeBridgeAdded, isFalse);
      expect(GaussPpFormulaNetSRuntimeFeasibilityAdapterPolicy.productionInferenceAllowed, isFalse);
    });

    test('passes only when runtime evidence gates are required and unsafe binding remains absent', () {
      final result = GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.runtimeFeasibilityAdapterStaticReady);
      expect(result.runtimeFeasibilityAdapterStaticReady, isTrue);
      expect(result.feasibilityMode, 'runtime-feasibility-adapter-gate-only-no-paddle-runtime-no-inference');
      expect(result.runtimePathCandidates, contains('Paddle Lite / on-device Android shell feasibility'));
      expect(result.requiredFeasibilityGates, contains('abiCompatibilityEvidence'));
      expect(result.blockedUntilRealEvidence, contains('realDevicePeakMemoryMeasurement'));
      expect(result.forbiddenActions, contains('runPpFormulaNetSInferenceInQ261'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeFeasibilityPassClaimed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canAddPaddleRuntimeInQ261, isFalse);
      expect(result.canAddNativeBridgeInQ261, isFalse);
      expect(result.canClaimRuntimeFeasibilityPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing Q260, runtime path, model format, Android compatibility, performance, unsafe binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(q260RealModelDownloadIntegrationGatePresent: false)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingQ260IntegrationGate,
      );
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(androidRuntimePathEvidenceRequired: false)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingRuntimePathEvidence,
      );
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(ppFormulaNetSModelFormatEvidenceRequired: false)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingModelFormatEvidence,
      );
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(abiCompatibilityEvidenceRequired: false)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingAndroidCompatibilityEvidence,
      );
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(peakMemoryBudgetEvidenceRequired: false)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingLatencyOrMemoryBudget,
      );
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(noPaddleRuntimeDependencyAdded: false)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedUnsafeRuntimeOrInferenceBinding,
      );
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(runtimeFeasibilityPassClaimed: true)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedUnsafeRuntimeOrInferenceBinding,
      );
      expect(
        GaussPpFormulaNetSRuntimeFeasibilityAdapter.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSRuntimeFeasibilityAdapterDecision.blockedMissingMathLiveReviewSafety,
      );
    });

    test('keeps dependencies, bridge, and base APK free of runtime/model artifacts', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final prodBridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec.toLowerCase(), isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec.toLowerCase(), isNot(contains('paddleocr')));
      expect(pubspec.toLowerCase(), isNot(contains('paddle_flutter')));
      expect(pubspec.toLowerCase(), isNot(contains('onnxruntime')));
      expect(pubspec.toLowerCase(), isNot(contains('flutter_downloader')));
      expect(pubspec.toLowerCase(), isNot(contains('background_downloader')));
      expect(settings, contains("id 'com.android.application' version '8.6.1' apply false"));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(prodBridge, isNot(contains('FormulaRecognition(')));
      expect(prodBridge, isNot(contains('runPpFormulaNetSInference')));
      expect(prodBridge, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
      expect(prodBridge, isNot(contains('startRealNetworkDownloadInQ260')));
      expect(prodBridge, isNot(contains('addPaddleRuntimeInQ261')));

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

extension on GaussPpFormulaNetSRuntimeFeasibilityAdapterInput {
  GaussPpFormulaNetSRuntimeFeasibilityAdapterInput copyForTest({
    bool? q260RealModelDownloadIntegrationGatePresent,
    String? feasibilityState,
    bool? allFeasibilityStatesRepresented,
    bool? officialOnDeviceDeploymentEvidenceRequired,
    bool? ppFormulaNetSModelFormatEvidenceRequired,
    bool? androidRuntimePathEvidenceRequired,
    bool? abiCompatibilityEvidenceRequired,
    bool? nativeBridgePlanEvidenceRequired,
    bool? modelArtifactPrivateStorageAccessRequired,
    bool? latencyBudgetEvidenceRequired,
    bool? peakMemoryBudgetEvidenceRequired,
    bool? offlineAfterInstallEvidenceRequired,
    bool? thermalAndBatteryRiskReviewRequired,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noPaddleOcrDependencyAdded,
    bool? noNativeBridgeAdded,
    bool? noModelBinaryBundledInBaseApp,
    bool? noProductionModelUrlBound,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? productionDownloadEnabled,
    bool? noProductionInferenceAllowed,
    bool? runtimeFeasibilityPassClaimed,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? feasibilityLabel,
  }) {
    return GaussPpFormulaNetSRuntimeFeasibilityAdapterInput(
      q260RealModelDownloadIntegrationGatePresent: q260RealModelDownloadIntegrationGatePresent ?? this.q260RealModelDownloadIntegrationGatePresent,
      feasibilityState: feasibilityState ?? this.feasibilityState,
      allFeasibilityStatesRepresented: allFeasibilityStatesRepresented ?? this.allFeasibilityStatesRepresented,
      officialOnDeviceDeploymentEvidenceRequired: officialOnDeviceDeploymentEvidenceRequired ?? this.officialOnDeviceDeploymentEvidenceRequired,
      ppFormulaNetSModelFormatEvidenceRequired: ppFormulaNetSModelFormatEvidenceRequired ?? this.ppFormulaNetSModelFormatEvidenceRequired,
      androidRuntimePathEvidenceRequired: androidRuntimePathEvidenceRequired ?? this.androidRuntimePathEvidenceRequired,
      abiCompatibilityEvidenceRequired: abiCompatibilityEvidenceRequired ?? this.abiCompatibilityEvidenceRequired,
      nativeBridgePlanEvidenceRequired: nativeBridgePlanEvidenceRequired ?? this.nativeBridgePlanEvidenceRequired,
      modelArtifactPrivateStorageAccessRequired: modelArtifactPrivateStorageAccessRequired ?? this.modelArtifactPrivateStorageAccessRequired,
      latencyBudgetEvidenceRequired: latencyBudgetEvidenceRequired ?? this.latencyBudgetEvidenceRequired,
      peakMemoryBudgetEvidenceRequired: peakMemoryBudgetEvidenceRequired ?? this.peakMemoryBudgetEvidenceRequired,
      offlineAfterInstallEvidenceRequired: offlineAfterInstallEvidenceRequired ?? this.offlineAfterInstallEvidenceRequired,
      thermalAndBatteryRiskReviewRequired: thermalAndBatteryRiskReviewRequired ?? this.thermalAndBatteryRiskReviewRequired,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noPaddleOcrDependencyAdded: noPaddleOcrDependencyAdded ?? this.noPaddleOcrDependencyAdded,
      noNativeBridgeAdded: noNativeBridgeAdded ?? this.noNativeBridgeAdded,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      runtimeFeasibilityPassClaimed: runtimeFeasibilityPassClaimed ?? this.runtimeFeasibilityPassClaimed,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      feasibilityLabel: feasibilityLabel ?? this.feasibilityLabel,
    );
  }
}
