import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_download_orchestrator_ui_guard.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_download_orchestrator_ui_guard_policy.dart';

// Q257 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3, AGP: 8.6.1
void main() {
  group('V172-Q257 PP-FormulaNet-S download orchestrator UI guard', () {
    const readyInput = GaussPpFormulaNetSDownloadOrchestratorUiInput(
      q256ArtifactManifestShaGatePresent: true,
      installState: 'notInstalled',
      allInstallStatesRepresentedInUi: true,
      modelNotInstalledCopyPresent: true,
      downloadConsentCopyPresent: true,
      wifiOrNetworkPolicyCopyPresent: true,
      progressAndVerifyingCopyPresent: true,
      checksumMismatchErrorCopyPresent: true,
      failedRetryCopyPresent: true,
      readyButReviewRequiredCopyPresent: true,
      productionDownloadEnabled: false,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      noModelBinaryBundledInBaseApp: true,
      noPaddleRuntimeDependencyAdded: true,
      noProductionInferenceAllowed: true,
      userConsentRequiredBeforeDownload: true,
      wifiOrUnmeteredNetworkPolicyVisible: true,
      checksumMismatchBlocksReadyState: true,
      failedStateNeverPretendsReady: true,
      readyStateDoesNotClaimOcrPass: true,
      modelUnavailableBlocksScanToOcr: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      orchestratorLabel: 'q257-download-orchestrator-ui-guard',
    );

    test('records download orchestrator UI guard without production download or inference', () {
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.phase, 'V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD');
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.sourcePhase, 'V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK');
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.fallbackEngineLabel, 'PP-FormulaNet_plus-L');
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.productionDownloadEnabled, isFalse);
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.realNetworkDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.productionInferenceAllowed, isFalse);
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.guardedInstallStates, contains('verifying'));
      expect(GaussPpFormulaNetSDownloadOrchestratorUiGuardPolicy.requiredUiCopyBlocks, contains('checksumMismatchErrorCopy'));
    });

    test('passes only when UI states, consent, network, checksum, and review guards are intact', () {
      final result = GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSDownloadOrchestratorUiDecision.downloadOrchestratorUiGuardStaticReady);
      expect(result.downloadOrchestratorUiGuardStaticReady, isTrue);
      expect(result.guardedInstallStates, contains('notInstalled'));
      expect(result.guardedInstallStates, contains('ready'));
      expect(result.requiredUiCopyBlocks, contains('readyButReviewRequiredCopy'));
      expect(result.requiredOrchestratorSafetyGates, contains('modelUnavailableBlocksScanToOcr'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canClaimModelDownloadPass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canEnableProductionDownloadInQ257, isFalse);
      expect(result.canStartScanToOcrWhenModelUnavailable, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing Q256 gate, unknown states, missing copy, production download, unsafe binding, and review regressions', () {
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(q256ArtifactManifestShaGatePresent: false)).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingQ256ArtifactShaGate,
      );
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(installState: 'mystery')).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedUnknownInstallState,
      );
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(checksumMismatchErrorCopyPresent: false)).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingUiCopy,
      );
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(productionDownloadEnabled: true)).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedProductionDownloadEnabled,
      );
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(noProductionModelUrlBound: false)).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedUnsafeRuntimeBindingAttempt,
      );
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(userConsentRequiredBeforeDownload: false)).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingNetworkOrConsentPolicy,
      );
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(modelUnavailableBlocksScanToOcr: false)).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingChecksumOrReadySafety,
      );
      expect(
        GaussPpFormulaNetSDownloadOrchestratorUiGuard.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSDownloadOrchestratorUiDecision.blockedMissingMathLiveReviewSafety,
      );
    });

    test('keeps dependencies, production bridge, and base APK free of real OCR/runtime/download artifacts', () {
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

extension on GaussPpFormulaNetSDownloadOrchestratorUiInput {
  GaussPpFormulaNetSDownloadOrchestratorUiInput copyForTest({
    bool? q256ArtifactManifestShaGatePresent,
    String? installState,
    bool? allInstallStatesRepresentedInUi,
    bool? modelNotInstalledCopyPresent,
    bool? downloadConsentCopyPresent,
    bool? wifiOrNetworkPolicyCopyPresent,
    bool? progressAndVerifyingCopyPresent,
    bool? checksumMismatchErrorCopyPresent,
    bool? failedRetryCopyPresent,
    bool? readyButReviewRequiredCopyPresent,
    bool? productionDownloadEnabled,
    bool? noProductionModelUrlBound,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? noModelBinaryBundledInBaseApp,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noProductionInferenceAllowed,
    bool? userConsentRequiredBeforeDownload,
    bool? wifiOrUnmeteredNetworkPolicyVisible,
    bool? checksumMismatchBlocksReadyState,
    bool? failedStateNeverPretendsReady,
    bool? readyStateDoesNotClaimOcrPass,
    bool? modelUnavailableBlocksScanToOcr,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? orchestratorLabel,
  }) {
    return GaussPpFormulaNetSDownloadOrchestratorUiInput(
      q256ArtifactManifestShaGatePresent: q256ArtifactManifestShaGatePresent ?? this.q256ArtifactManifestShaGatePresent,
      installState: installState ?? this.installState,
      allInstallStatesRepresentedInUi: allInstallStatesRepresentedInUi ?? this.allInstallStatesRepresentedInUi,
      modelNotInstalledCopyPresent: modelNotInstalledCopyPresent ?? this.modelNotInstalledCopyPresent,
      downloadConsentCopyPresent: downloadConsentCopyPresent ?? this.downloadConsentCopyPresent,
      wifiOrNetworkPolicyCopyPresent: wifiOrNetworkPolicyCopyPresent ?? this.wifiOrNetworkPolicyCopyPresent,
      progressAndVerifyingCopyPresent: progressAndVerifyingCopyPresent ?? this.progressAndVerifyingCopyPresent,
      checksumMismatchErrorCopyPresent: checksumMismatchErrorCopyPresent ?? this.checksumMismatchErrorCopyPresent,
      failedRetryCopyPresent: failedRetryCopyPresent ?? this.failedRetryCopyPresent,
      readyButReviewRequiredCopyPresent: readyButReviewRequiredCopyPresent ?? this.readyButReviewRequiredCopyPresent,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      userConsentRequiredBeforeDownload: userConsentRequiredBeforeDownload ?? this.userConsentRequiredBeforeDownload,
      wifiOrUnmeteredNetworkPolicyVisible: wifiOrUnmeteredNetworkPolicyVisible ?? this.wifiOrUnmeteredNetworkPolicyVisible,
      checksumMismatchBlocksReadyState: checksumMismatchBlocksReadyState ?? this.checksumMismatchBlocksReadyState,
      failedStateNeverPretendsReady: failedStateNeverPretendsReady ?? this.failedStateNeverPretendsReady,
      readyStateDoesNotClaimOcrPass: readyStateDoesNotClaimOcrPass ?? this.readyStateDoesNotClaimOcrPass,
      modelUnavailableBlocksScanToOcr: modelUnavailableBlocksScanToOcr ?? this.modelUnavailableBlocksScanToOcr,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      orchestratorLabel: orchestratorLabel ?? this.orchestratorLabel,
    );
  }
}
