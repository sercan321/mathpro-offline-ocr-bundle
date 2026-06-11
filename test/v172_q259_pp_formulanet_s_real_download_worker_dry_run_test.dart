import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_real_download_worker_dry_run.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_real_download_worker_dry_run_policy.dart';

void main() {
  group('V172-Q259 PP-FormulaNet-S real download worker dry-run', () {
    const readyInput = GaussPpFormulaNetSRealDownloadWorkerDryRunInput(
      q258ProductionArtifactResolverGatePresent: true,
      dryRunState: 'dryRunChecksumMismatch',
      allDryRunStatesRepresented: true,
      productionDownloadEnabled: false,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      noProductionDownloadWorkerImplemented: true,
      noModelBinaryBundledInBaseApp: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noProductionInferenceAllowed: true,
      privateTemporaryAppStorageOnly: true,
      temporaryFileDryRunPrepared: true,
      partialDownloadCleanupDryRun: true,
      checksumMismatchSimulationPresent: true,
      checksumMismatchBlocksReadyState: true,
      checksumPassRequiredBeforeAtomicMove: true,
      atomicMoveSimulationOnly: true,
      readyStateOnlyAfterVerifiedMove: true,
      failedRetryStateSimulationPresent: true,
      modelUnavailableBlocksScanToOcr: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      dryRunLabel: 'Q259 dry-run worker court',
    );

    test('policy keeps Q259 dry-run only, with PP-FormulaNet-S selected and production download disabled', () {
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.phase, 'V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN');
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.sourcePhase, 'V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE');
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.productionDownloadEnabled, isFalse);
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.productionModelUrlBound, isFalse);
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.realNetworkDownloadWorkerImplemented, isFalse);
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.dryRunWorkerContractImplemented, isTrue);
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.guardedDryRunStates, contains('dryRunChecksumMismatch'));
      expect(GaussPpFormulaNetSRealDownloadWorkerDryRunPolicy.requiredDryRunSafetyGates, contains('checksumPassRequiredBeforeAtomicMove'));
    });

    test('passes only when dry-run storage, cleanup, checksum, atomic move, retry, and review guards are intact', () {
      final result = GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.realDownloadWorkerDryRunStaticReady);
      expect(result.realDownloadWorkerDryRunStaticReady, isTrue);
      expect(result.dryRunMode, 'real-download-worker-dry-run-no-production-network');
      expect(result.guardedDryRunStates, contains('dryRunAtomicMovePrepared'));
      expect(result.requiredDryRunEvidence, contains('checksumMismatchNeverMarksReady'));
      expect(result.forbiddenActions, contains('startProductionNetworkDownloadInQ259'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.editableMathLiveReviewRequired, isTrue);
      expect(result.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(result.canStartProductionNetworkDownload, isFalse);
      expect(result.canBindProductionModelUrl, isFalse);
      expect(result.canClaimModelDownloadPass, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canRunPpFormulaNetSInference, isFalse);
      expect(result.canMarkReadyAfterChecksumMismatch, isFalse);
      expect(result.canAtomicMoveBeforeChecksumPass, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks missing Q258 gate, unknown state, production download, runtime binding, storage, cleanup, checksum, atomic move, retry, and review regressions', () {
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(q258ProductionArtifactResolverGatePresent: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingQ258ResolverGate,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(dryRunState: 'unknown')).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedUnknownDryRunState,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(productionDownloadEnabled: true)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedProductionDownloadEnabled,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(noRealNetworkDownloadWorkerImplemented: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedUnsafeNetworkOrRuntimeBinding,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(privateTemporaryAppStorageOnly: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingPrivateStorageSafety,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(partialDownloadCleanupDryRun: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingPartialCleanupSafety,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(checksumMismatchBlocksReadyState: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingChecksumSimulation,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(atomicMoveSimulationOnly: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingAtomicMoveSafety,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(failedRetryStateSimulationPresent: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingRetryOrOfflineSafety,
      );
      expect(
        GaussPpFormulaNetSRealDownloadWorkerDryRun.evaluate(readyInput.copyForTest(mathLiveReviewAndUserApprovalRequired: false)).decision,
        GaussPpFormulaNetSRealDownloadWorkerDryRunDecision.blockedMissingMathLiveReviewSafety,
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
      expect(prodBridge, isNot(contains('startProductionNetworkDownloadInQ259')));

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

extension on GaussPpFormulaNetSRealDownloadWorkerDryRunInput {
  GaussPpFormulaNetSRealDownloadWorkerDryRunInput copyForTest({
    bool? q258ProductionArtifactResolverGatePresent,
    String? dryRunState,
    bool? allDryRunStatesRepresented,
    bool? productionDownloadEnabled,
    bool? noProductionModelUrlBound,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? noProductionDownloadWorkerImplemented,
    bool? noModelBinaryBundledInBaseApp,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noPaddleOcrDependencyAdded,
    bool? noProductionInferenceAllowed,
    bool? privateTemporaryAppStorageOnly,
    bool? temporaryFileDryRunPrepared,
    bool? partialDownloadCleanupDryRun,
    bool? checksumMismatchSimulationPresent,
    bool? checksumMismatchBlocksReadyState,
    bool? checksumPassRequiredBeforeAtomicMove,
    bool? atomicMoveSimulationOnly,
    bool? readyStateOnlyAfterVerifiedMove,
    bool? failedRetryStateSimulationPresent,
    bool? modelUnavailableBlocksScanToOcr,
    bool? mathLiveReviewAndUserApprovalRequired,
    bool? noDirectSolveGraphSolutionHistoryFromCamera,
    String? dryRunLabel,
  }) {
    return GaussPpFormulaNetSRealDownloadWorkerDryRunInput(
      q258ProductionArtifactResolverGatePresent: q258ProductionArtifactResolverGatePresent ?? this.q258ProductionArtifactResolverGatePresent,
      dryRunState: dryRunState ?? this.dryRunState,
      allDryRunStatesRepresented: allDryRunStatesRepresented ?? this.allDryRunStatesRepresented,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      noProductionDownloadWorkerImplemented: noProductionDownloadWorkerImplemented ?? this.noProductionDownloadWorkerImplemented,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noPaddleOcrDependencyAdded: noPaddleOcrDependencyAdded ?? this.noPaddleOcrDependencyAdded,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      privateTemporaryAppStorageOnly: privateTemporaryAppStorageOnly ?? this.privateTemporaryAppStorageOnly,
      temporaryFileDryRunPrepared: temporaryFileDryRunPrepared ?? this.temporaryFileDryRunPrepared,
      partialDownloadCleanupDryRun: partialDownloadCleanupDryRun ?? this.partialDownloadCleanupDryRun,
      checksumMismatchSimulationPresent: checksumMismatchSimulationPresent ?? this.checksumMismatchSimulationPresent,
      checksumMismatchBlocksReadyState: checksumMismatchBlocksReadyState ?? this.checksumMismatchBlocksReadyState,
      checksumPassRequiredBeforeAtomicMove: checksumPassRequiredBeforeAtomicMove ?? this.checksumPassRequiredBeforeAtomicMove,
      atomicMoveSimulationOnly: atomicMoveSimulationOnly ?? this.atomicMoveSimulationOnly,
      readyStateOnlyAfterVerifiedMove: readyStateOnlyAfterVerifiedMove ?? this.readyStateOnlyAfterVerifiedMove,
      failedRetryStateSimulationPresent: failedRetryStateSimulationPresent ?? this.failedRetryStateSimulationPresent,
      modelUnavailableBlocksScanToOcr: modelUnavailableBlocksScanToOcr ?? this.modelUnavailableBlocksScanToOcr,
      mathLiveReviewAndUserApprovalRequired: mathLiveReviewAndUserApprovalRequired ?? this.mathLiveReviewAndUserApprovalRequired,
      noDirectSolveGraphSolutionHistoryFromCamera: noDirectSolveGraphSolutionHistoryFromCamera ?? this.noDirectSolveGraphSolutionHistoryFromCamera,
      dryRunLabel: dryRunLabel ?? this.dryRunLabel,
    );
  }
}
