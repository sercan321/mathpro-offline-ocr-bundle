import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_winner_engine_adapter.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_winner_engine_adapter_policy.dart';

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

void main() {
  group('V172-Q241 winner engine adapter foundation', () {
    test('policy keeps Q241 adapter foundation review-only', () {
      expect(GaussWinnerEngineAdapterPolicy.phase, 'V172-Q241');
      expect(GaussWinnerEngineAdapterPolicy.fullPhase, 'V172-Q241-WINNER-ENGINE-ADAPTER-FOUNDATION');
      expect(GaussWinnerEngineAdapterPolicy.q240r3ExternalLabIntakeGatePreserved, isTrue);
      expect(GaussWinnerEngineAdapterPolicy.winnerEngineAdapterContractImplemented, isTrue);
      expect(GaussWinnerEngineAdapterPolicy.adapterInputContractImplemented, isTrue);
      expect(GaussWinnerEngineAdapterPolicy.adapterCandidateContractImplemented, isTrue);
      expect(GaussWinnerEngineAdapterPolicy.mathLiveReviewOnlyRoutingImplemented, isTrue);
      expect(GaussWinnerEngineAdapterPolicy.adapterBlocksDirectSolve, isTrue);
      expect(GaussWinnerEngineAdapterPolicy.adapterBlocksDirectWorkspaceImport, isTrue);
      expect(GaussWinnerEngineAdapterPolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussWinnerEngineAdapterPolicy.realOcrEngineAdded, isFalse);
      expect(GaussWinnerEngineAdapterPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussWinnerEngineAdapterPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussWinnerEngineAdapterPolicy.productionMathLiveBridgeCalled, isFalse);
      expect(GaussWinnerEngineAdapterPolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussWinnerEngineAdapterPolicy.directSolveFromCameraAllowed, isFalse);
    });

    test('eligible Q240R3 report can create review-only adapter envelope', () {
      final intake = GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport(_validReport());
      const input = GaussWinnerEngineAdapterInput(
        capturePath: '/tmp/future-capture.png',
        rotationQuarterTurns: 1,
        sourcePhase: GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.fullPhase,
        externalReportSha256: 'report-sha-placeholder',
        fixtureManifestSha256: 'fixture-sha-placeholder',
      );
      const candidate = GaussWinnerEngineAdapterCandidate(
        rank: 1,
        latex: r'\int_0^1 x^2\,dx',
        confidence: 0.91,
        engineFamily: GaussOcrBenchmarkEngineFamily.ppFormulaNetS,
        engineLabel: 'PP-FormulaNet-S',
        warnings: <String>[],
      );
      final envelope = GaussWinnerEngineAdapterFoundation.createReviewOnlyEnvelope(
        input: input,
        intakeResult: intake,
        candidate: candidate,
      );

      expect(envelope.status, GaussWinnerEngineAdapterStatus.contractReady);
      expect(envelope.hasBlockingIssues, isFalse);
      expect(envelope.mayOpenMathLiveReviewOnly, isTrue);
      expect(envelope.mathLiveReviewRequired, isTrue);
      expect(envelope.directSolveAllowed, isFalse);
      expect(envelope.directWorkspaceImportAllowed, isFalse);
      expect(envelope.productionRuntimeBindingAllowed, isFalse);
      expect(envelope.benchmarkWinnerSelected, isFalse);
      expect(envelope.input.rotationDegrees, 90);
    });

    test('blocked Q240R3 intake cannot enter adapter review', () {
      final unsafe = _validReport()..['autoSolve'] = true;
      final intake = GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport(unsafe);
      final envelope = GaussWinnerEngineAdapterFoundation.createReviewOnlyEnvelope(
        input: const GaussWinnerEngineAdapterInput(
          capturePath: '/tmp/future-capture.png',
          rotationQuarterTurns: 0,
          sourcePhase: GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.fullPhase,
          externalReportSha256: 'report-sha-placeholder',
          fixtureManifestSha256: 'fixture-sha-placeholder',
        ),
        intakeResult: intake,
      );

      expect(envelope.status, GaussWinnerEngineAdapterStatus.blockedByIntakeGate);
      expect(envelope.hasBlockingIssues, isTrue);
      expect(envelope.mayOpenMathLiveReviewOnly, isFalse);
      expect(envelope.directSolveAllowed, isFalse);
      expect(envelope.productionRuntimeBindingAllowed, isFalse);
    });

    test('unsafe candidate shape is blocked before review', () {
      final intake = GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport(_validReport());
      final envelope = GaussWinnerEngineAdapterFoundation.createReviewOnlyEnvelope(
        input: const GaussWinnerEngineAdapterInput(
          capturePath: '/tmp/future-capture.png',
          rotationQuarterTurns: 0,
          sourcePhase: GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.fullPhase,
          externalReportSha256: 'report-sha-placeholder',
          fixtureManifestSha256: 'fixture-sha-placeholder',
        ),
        intakeResult: intake,
        candidate: const GaussWinnerEngineAdapterCandidate(
          rank: 1,
          latex: '',
          confidence: 1.4,
          engineFamily: GaussOcrBenchmarkEngineFamily.pix2TextMfrOnnx,
          engineLabel: 'Pix2Text MFR ONNX',
          warnings: <String>['empty latex candidate'],
        ),
      );

      expect(envelope.status, GaussWinnerEngineAdapterStatus.blockedUnsafeCandidate);
      expect(envelope.hasBlockingIssues, isTrue);
      expect(envelope.mayOpenMathLiveReviewOnly, isFalse);
    });

    test('foundation exposes explicit runtime block constants', () {
      expect(GaussWinnerEngineAdapterFoundation.phase, 'V172-Q241-WINNER-ENGINE-ADAPTER-FOUNDATION');
      expect(GaussWinnerEngineAdapterFoundation.realEngineInvocationAllowed, isFalse);
      expect(GaussWinnerEngineAdapterFoundation.productionRuntimeBindingAllowed, isFalse);
      expect(GaussWinnerEngineAdapterFoundation.benchmarkWinnerSelected, isFalse);
      expect(GaussWinnerEngineAdapterFoundation.directSolveAllowed, isFalse);
      expect(GaussWinnerEngineAdapterFoundation.directWorkspaceImportAllowed, isFalse);
      expect(GaussWinnerEngineAdapterFoundation.blocksUnsafeRuntimeBindings, isTrue);
      expect(GaussWinnerEngineAdapterFoundation.exposesReviewOnlyContract, isTrue);
      expect(GaussWinnerEngineAdapterFoundation.adapterSafetyStages, contains('q240r3IntakeDecisionGate'));
      expect(GaussWinnerEngineAdapterFoundation.adapterSafetyStages, contains('mathLiveReviewOnlyGate'));
      expect(GaussWinnerEngineAdapterFoundation.forbiddenRuntimeBindings, contains('setWorkspaceLatexWithoutReview'));
      expect(GaussWinnerEngineAdapterFoundation.forbiddenRuntimeBindings, contains('evaluateFromCamera'));
    });
  });
}
