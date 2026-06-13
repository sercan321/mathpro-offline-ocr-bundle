import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_dataset_lab_runner.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_result_schema.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_result_schema_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court.dart';

void main() {
  group('V172-Q240R2 OCR benchmark external lab result schema', () {
    test('policy keeps the phase schema-only and runtime-isolated', () {
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.phase, 'V172-Q240R2');
      expect(
        GaussOcrBenchmarkExternalLabResultSchemaPolicy.fullPhase,
        'V172-Q240R2-OCR-BENCHMARK-FIXTURE-EXTERNAL-LAB-RESULT-SCHEMA',
      );
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.q240BenchmarkCourtPreserved, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.q240r1DatasetLabRunnerPreserved, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.fixtureManifestSchemaImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.externalLabResultSchemaImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.candidateResultSchemaImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.deviceProfileSchemaImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.reportIntakeGateImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.realOcrEngineAdded, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.textOcrFallbackAdded, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.pix2TextRuntimeAdded, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.realBenchmarkImageAssetsBundled, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.productionModelUrlBound, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchemaPolicy.importContract, contains('MathLive'));
    });

    test('schema exposes fixture, report, sample, scoring, and unsafe-action gates', () {
      expect(GaussOcrBenchmarkExternalLabResultSchema.phase, GaussOcrBenchmarkExternalLabResultSchemaPolicy.fullPhase);
      expect(GaussOcrBenchmarkExternalLabResultSchema.schemaVersion, 'gauss-ocr-benchmark-external-lab-v1');
      expect(GaussOcrBenchmarkExternalLabResultSchema.realEngineInvocationAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchema.realImageFixturesBundled, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchema.productionResultWriteAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchema.directSolveAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabResultSchema.mathLiveReviewRequired, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchema.minimumSampleCount, 30);
      expect(GaussOcrBenchmarkExternalLabResultSchema.schemaHasCoreReportKeys, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchema.schemaHasFixtureKeys, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchema.schemaBlocksUnsafeActions, isTrue);
      expect(GaussOcrBenchmarkExternalLabResultSchema.externalLabReportRequiredKeys, contains('engineFamily'));
      expect(GaussOcrBenchmarkExternalLabResultSchema.externalLabReportRequiredKeys, contains('sampleResults'));
      expect(GaussOcrBenchmarkExternalLabResultSchema.sampleResultRequiredKeys, contains('predictedLatex'));
      expect(GaussOcrBenchmarkExternalLabResultSchema.sampleResultRequiredKeys, contains('candidateLatex'));
      expect(GaussOcrBenchmarkExternalLabResultSchema.requiredScoringDimensions, contains('integralLimitPlacement'));
      expect(GaussOcrBenchmarkExternalLabResultSchema.requiredScoringDimensions, contains('derivativeNotationFidelity'));
      expect(GaussOcrBenchmarkExternalLabResultSchema.forbiddenReportKeys, contains('autoSolve'));
      expect(GaussOcrBenchmarkExternalLabResultSchema.forbiddenReportKeys, contains('cloudApiKey'));
    });

    test('external engine run remains review-gated and cannot auto-solve', () {
      const device = GaussOcrExternalLabDeviceProfile(
        deviceLabel: 'lab-device-placeholder',
        androidVersion: 'unset',
        runtimeTarget: 'external-lab',
        offlineMode: true,
        cpuOrAccelerator: 'unset',
      );
      const candidate = GaussOcrExternalLabCandidateResult(
        rank: 1,
        latex: r'\int_0^1 x^2\,dx',
        confidence: 0.0,
        warnings: <String>['placeholder-only'],
      );
      const sample = GaussOcrExternalLabSampleResult(
        caseId: 'integral_def_001_clean_printed',
        fixtureName: 'integral_def_001_clean_printed.png',
        referenceLatex: r'\int_0^1 x^2\,dx',
        predictedLatex: r'\int_0^1 x^2\,dx',
        outcome: GaussOcrExternalLabSampleOutcome.exactLatex,
        confidence: 0.0,
        processingTimeMs: 0,
        matchedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.definiteIntegral],
        candidates: <GaussOcrExternalLabCandidateResult>[candidate],
      );
      final samples = List<GaussOcrExternalLabSampleResult>.filled(30, sample);
      final run = GaussOcrExternalLabEngineRun(
        schemaVersion: GaussOcrBenchmarkExternalLabResultSchema.schemaVersion,
        engineFamily: GaussOcrBenchmarkEngineFamily.ppFormulaNetS,
        engineLabel: 'PP-FormulaNet-S',
        engineVersion: 'external-lab-only',
        modelVersion: 'external-lab-only',
        modelSizeBytes: 1,
        peakMemoryMb: 1,
        offlineAfterInstall: true,
        licenseClearedForDistribution: true,
        deviceProfile: device,
        sampleResults: samples,
      );

      expect(candidate.requiresEditableMathLiveReview, isTrue);
      expect(candidate.directSolveAllowed, isFalse);
      expect(sample.requiresEditableMathLiveReview, isTrue);
      expect(sample.directSolveAllowed, isFalse);
      expect(sample.hasCandidateList, isTrue);
      expect(sample.hasValidTiming, isTrue);
      expect(run.requiresMathLiveReview, isTrue);
      expect(run.directSolveAllowed, isFalse);
      expect(run.hasEnoughSampleCoverage, isTrue);
      expect(run.allSamplesBlockDirectSolve, isTrue);
      expect(run.allCandidatesRequireReview, isTrue);
      expect(run.mayBeConsideredForWinnerSelection, isTrue);
    });

    test('schema templates are JSON-readable and state no runtime/model binding', () {
      final fixtureTemplate = jsonDecode(
        File('docs/evidence/V172_Q240R2_OCR_BENCHMARK_FIXTURE_MANIFEST_TEMPLATE.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final reportSchema = jsonDecode(
        File('docs/evidence/V172_Q240R2_OCR_BENCHMARK_EXTERNAL_LAB_RESULT_SCHEMA.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(fixtureTemplate['phase'], 'V172-Q240R2');
      expect(fixtureTemplate['realImagesBundledInBaseApp'], isFalse);
      expect(fixtureTemplate['mathLiveReviewRequired'], isTrue);
      expect(reportSchema['phase'], 'V172-Q240R2');
      expect(reportSchema['schemaVersion'], GaussOcrBenchmarkExternalLabResultSchema.schemaVersion);
      expect(reportSchema['realOcrEngineAdded'], isFalse);
      expect(reportSchema['modelBinaryBundledInBaseApp'], isFalse);
      expect(reportSchema['directSolveFromCameraAllowed'], isFalse);
      expect(reportSchema['mathLiveReviewRequired'], isTrue);
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*workmanager\s*:', multiLine: true))));
      expect(androidManifest, contains('INTERNET')); // Q384R1 deferred model download requires network permission.
      expect(androidManifest, isNot(contains('READ_MEDIA_IMAGES')));
    });
  });
}
