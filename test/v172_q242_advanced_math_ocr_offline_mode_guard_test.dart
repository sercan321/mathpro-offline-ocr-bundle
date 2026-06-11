import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_advanced_math_ocr_offline_mode_guard.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_advanced_math_ocr_offline_mode_guard_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_winner_engine_adapter.dart';

Map<String, Object?> _validSample(int index) => <String, Object?>{
      'caseId': 'case_${index.toString().padLeft(2, '0')}',
      'fixtureName': 'case_${index.toString().padLeft(2, '0')}.png',
      'referenceLatex': r'\int_0^1 x^2\,dx',
      'predictedLatex': r'\int_0^1 x^2\,dx',
      'candidateLatex': <String>[r'\int_0^1 x^2\,dx'],
      'confidence': 0.91,
      'processingTimeMs': 420,
      'outcome': 'exactLatex',
      'matchedStructures': <String>['definiteIntegral', 'power'],
      'mathLiveReviewRequired': true,
      'directSolveAllowed': false,
      'fixtureSha256': 'fixture-sha-placeholder-$index',
    };

Map<String, Object?> _validReport() => <String, Object?>{
      'schemaVersion': GaussOcrBenchmarkExternalLabIntakeValidationGate.schemaVersion,
      'phase': 'V172-Q240R2',
      'engineFamily': 'ppFormulaNetS',
      'engineLabel': 'PP-FormulaNet-S',
      'engineVersion': 'external-lab-only',
      'modelVersion': 'external-lab-only',
      'modelSizeBytes': 224000000,
      'peakMemoryMb': 512,
      'offlineAfterInstall': true,
      'licenseClearedForDistribution': true,
      'deviceProfile': <String, Object?>{
        'deviceLabel': 'external-lab-placeholder',
        'androidVersion': 'unset',
        'runtimeTarget': 'external-lab',
        'offlineMode': true,
        'cpuOrAccelerator': 'unset',
      },
      'sampleResults': List<Map<String, Object?>>.generate(30, _validSample),
      'mathLiveReviewRequired': true,
      'directSolveAllowed': false,
      'reportSha256': 'report-sha-placeholder',
      'fixtureManifestSha256': 'fixture-manifest-sha-placeholder',
      'createdAtUtc': '1970-01-01T00:00:00Z',
    };

GaussWinnerEngineAdapterEnvelope _safeAdapterEnvelope() {
  final intake = GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport(_validReport());
  const input = GaussWinnerEngineAdapterInput(
    capturePath: '/tmp/future-capture.png',
    rotationQuarterTurns: 0,
    sourcePhase: GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.fullPhase,
    externalReportSha256: 'report-sha-placeholder',
    fixtureManifestSha256: 'fixture-manifest-sha-placeholder',
  );
  const candidate = GaussWinnerEngineAdapterCandidate(
    rank: 1,
    latex: r'\int_0^1 x^2\,dx',
    confidence: 0.91,
    engineFamily: GaussOcrBenchmarkEngineFamily.ppFormulaNetS,
    engineLabel: 'PP-FormulaNet-S',
    warnings: <String>[],
  );
  return GaussWinnerEngineAdapterFoundation.createReviewOnlyEnvelope(
    input: input,
    intakeResult: intake,
    candidate: candidate,
  );
}

GaussMathOcrModelSnapshot _readyOfflineSnapshot() {
  return GaussMathOcrModelSnapshot.initial().copyWith(
    status: GaussMathOcrModelInstallStatus.ready,
    progress: 1,
    offlineAvailable: true,
    sizeBytes: 224000000,
    sha256: 'verified-model-sha-placeholder',
    installPath: '/app-private/gauss_math_ocr/model.onnx',
    downloadedAtIso: '1970-01-01T00:00:00Z',
    clearFailureMessage: true,
  );
}

void main() {
  group('V172-Q242 advanced math OCR offline mode guard', () {
    test('policy keeps Q242 offline mode guard review-only', () {
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.phase, 'V172-Q242');
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.fullPhase, 'V172-Q242-ADVANCED-MATH-OCR-OFFLINE-MODE-GUARD');
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.q241WinnerEngineAdapterPreserved, isTrue);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.advancedOfflineModeGuardImplemented, isTrue);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.localModelReadyRequired, isTrue);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.localModelSha256VerificationRequired, isTrue);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.mathLiveReviewRequiredBeforeAnyAction, isTrue);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.realOcrEngineAdded, isFalse);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.offlineOcrExecutionAllowedInThisPhase, isFalse);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.productionMathLiveBridgeCalled, isFalse);
      expect(GaussAdvancedMathOcrOfflineModeGuardPolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('all future readiness gates prepare review path but still do not execute OCR in Q242', () {
      final decision = GaussAdvancedMathOcrOfflineModeGuard.evaluate(
        GaussAdvancedMathOcrOfflineModeRequest(
          modelSnapshot: _readyOfflineSnapshot(),
          adapterEnvelope: _safeAdapterEnvelope(),
          localModelSha256Verified: true,
          offlineRuntimeAvailable: true,
          croppedImageReady: true,
        ),
      );

      expect(decision.status, GaussAdvancedMathOcrOfflineModeStatus.contractReadyFutureOnly);
      expect(decision.hasBlockingIssues, isFalse);
      expect(decision.futureOfflineReviewPathPrepared, isTrue);
      expect(decision.offlineOcrExecutionAllowedInThisPhase, isFalse);
      expect(decision.mayExecuteOcrNow, isFalse);
      expect(decision.mathLiveReviewRequired, isTrue);
      expect(decision.directSolveAllowed, isFalse);
      expect(decision.directWorkspaceImportAllowed, isFalse);
      expect(decision.graphAllowedBeforeReview, isFalse);
      expect(decision.historyWriteAllowedBeforeReview, isFalse);
      expect(decision.solutionAllowedBeforeReview, isFalse);
    });

    test('not-ready model blocks future offline OCR review path', () {
      final decision = GaussAdvancedMathOcrOfflineModeGuard.evaluate(
        GaussAdvancedMathOcrOfflineModeRequest(
          modelSnapshot: GaussMathOcrModelSnapshot.initial(),
          adapterEnvelope: _safeAdapterEnvelope(),
          localModelSha256Verified: false,
          offlineRuntimeAvailable: true,
          croppedImageReady: true,
        ),
      );

      expect(decision.status, GaussAdvancedMathOcrOfflineModeStatus.blockedModelNotReady);
      expect(decision.hasBlockingIssues, isTrue);
      expect(decision.futureOfflineReviewPathPrepared, isFalse);
      expect(decision.mayExecuteOcrNow, isFalse);
    });

    test('direct solve/import attempt is blocked before any camera OCR action', () {
      final decision = GaussAdvancedMathOcrOfflineModeGuard.evaluate(
        GaussAdvancedMathOcrOfflineModeRequest(
          modelSnapshot: _readyOfflineSnapshot(),
          adapterEnvelope: _safeAdapterEnvelope(),
          localModelSha256Verified: true,
          offlineRuntimeAvailable: true,
          croppedImageReady: true,
          attemptedDirectSolve: true,
        ),
      );

      expect(decision.status, GaussAdvancedMathOcrOfflineModeStatus.blockedDirectActionAttempt);
      expect(decision.hasBlockingIssues, isTrue);
      expect(decision.futureOfflineReviewPathPrepared, isFalse);
      expect(decision.directSolveAllowed, isFalse);
      expect(decision.mayExecuteOcrNow, isFalse);
    });

    test('foundation exposes explicit offline safety gates', () {
      expect(GaussAdvancedMathOcrOfflineModeGuard.phase, 'V172-Q242-ADVANCED-MATH-OCR-OFFLINE-MODE-GUARD');
      expect(GaussAdvancedMathOcrOfflineModeGuard.realOcrEngineAdded, isFalse);
      expect(GaussAdvancedMathOcrOfflineModeGuard.offlineOcrExecutionAllowedInThisPhase, isFalse);
      expect(GaussAdvancedMathOcrOfflineModeGuard.blocksUnsafeOfflineActions, isTrue);
      expect(GaussAdvancedMathOcrOfflineModeGuard.exposesOfflineReviewOnlyContract, isTrue);
      expect(GaussAdvancedMathOcrOfflineModeGuard.offlineReadinessGates, contains('q239dModelSnapshotReadyGate'));
      expect(GaussAdvancedMathOcrOfflineModeGuard.offlineReadinessGates, contains('mathLiveReviewBeforeAnyActionGate'));
      expect(GaussAdvancedMathOcrOfflineModeGuard.forbiddenOfflineModeActions, contains('executeOcrInQ242'));
      expect(GaussAdvancedMathOcrOfflineModeGuard.forbiddenOfflineModeActions, contains('setWorkspaceLatexWithoutReview'));
      expect(GaussAdvancedMathOcrOfflineModeGuard.forbiddenOfflineModeActions, contains('evaluateFromCamera'));
    });
  });
}
