import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_dataset_lab_runner.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_dataset_lab_runner_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court.dart';

void main() {
  group('V172-Q240R1 OCR benchmark dataset and lab runner foundation', () {
    test('policy keeps the phase dataset-only and runtime-isolated', () {
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.phase, 'V172-Q240R1');
      expect(
        GaussOcrBenchmarkDatasetLabRunnerPolicy.fullPhase,
        'V172-Q240R1-OCR-BENCHMARK-DATASET-LAB-RUNNER-FOUNDATION',
      );
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.q240BenchmarkCourtPreserved, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.q239eMathLiveReviewSurfacePreserved, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.datasetManifestImplemented, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.canonicalCaseIdsImplemented, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.calculusCoverageRequired, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.structureCoverageRequired, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.captureRobustnessCoverageRequired, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.handwritingSmokeCoverageRequired, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.labRunnerDryRunContractImplemented, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.labRunnerCanInvokeRealEngines, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.labRunnerCanDownloadModels, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.labRunnerCanWriteProductionResults, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.appRuntimeIsolationRequired, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.mathLiveEditableReviewRemainsRequired, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.realOcrEngineAdded, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.textOcrFallbackAdded, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.pix2TextRuntimeAdded, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.onnxRuntimeAdded, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.realBenchmarkImageAssetsBundled, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunnerPolicy.importContract, contains('MathLive'));
    });

    test('canonical dataset covers calculus, structures, handwriting, and capture robustness', () {
      expect(GaussOcrBenchmarkDatasetLabRunner.phase, GaussOcrBenchmarkDatasetLabRunnerPolicy.fullPhase);
      expect(GaussOcrBenchmarkDatasetLabRunner.realImagesBundled, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunner.realEngineInvocationAllowed, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunner.productionResultWriteAllowed, isFalse);
      expect(GaussOcrBenchmarkDatasetLabRunner.mathLiveReviewRequired, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunner.hasMinimumCaseCoverage, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunner.hasUniqueCaseIds, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunner.hasCalculusCoverage, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunner.hasStructuralCoverage, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunner.hasCaptureRobustnessCoverage, isTrue);
      expect(GaussOcrBenchmarkDatasetLabRunner.hasHandwritingSmokeCoverage, isTrue);

      final structures = GaussOcrBenchmarkDatasetLabRunner.canonicalCases
          .expand((sample) => sample.expectedStructures)
          .toSet();
      expect(structures, contains(GaussOcrExpectedStructure.indefiniteIntegral));
      expect(structures, contains(GaussOcrExpectedStructure.definiteIntegral));
      expect(structures, contains(GaussOcrExpectedStructure.derivativePrime));
      expect(structures, contains(GaussOcrExpectedStructure.derivativeLeibniz));
      expect(structures, contains(GaussOcrExpectedStructure.fraction));
      expect(structures, contains(GaussOcrExpectedStructure.radical));
      expect(structures, contains(GaussOcrExpectedStructure.matrix));

      for (final sample in GaussOcrBenchmarkDatasetLabRunner.canonicalCases) {
        expect(sample.requiresEditableMathLiveReview, isTrue, reason: sample.id);
        expect(sample.directSolveAllowed, isFalse, reason: sample.id);
        expect(sample.futureFixtureName, endsWith('.png'), reason: sample.id);
      }
    });

    test('dry-run lab plan multiplies engines and cases without invoking engines', () {
      final plan = GaussOcrBenchmarkDatasetLabRunner.buildDryRunPlan();
      expect(plan.phase, GaussOcrBenchmarkDatasetLabRunnerPolicy.fullPhase);
      expect(plan.engineCount, GaussOcrEngineBenchmarkCourt.candidateEngines.length);
      expect(plan.caseCount, GaussOcrBenchmarkDatasetLabRunner.canonicalCases.length);
      expect(plan.taskCount, plan.engineCount * plan.caseCount);
      expect(plan.tasks, hasLength(plan.taskCount));
      expect(plan.canInvokeRealEngines, isFalse);
      expect(plan.canWriteProductionResults, isFalse);
      expect(plan.tasks.first.engineLabel, isNotEmpty);
      expect(plan.tasks.first.caseId, isNotEmpty);
      expect(plan.tasks.first.referenceLatex, isNotEmpty);
      expect(plan.tasks.first.requiredStructures, isNotEmpty);
    });

    test('Q240R1 does not add OCR runtimes, model assets, or production mutation paths', () {
      final dataset = File('lib/features/camera/gauss_ocr_benchmark_dataset_lab_runner.dart').readAsStringSync();
      final policy = File('lib/features/camera/gauss_ocr_benchmark_dataset_lab_runner_policy.dart').readAsStringSync();
      final cameraShell = File('lib/features/camera/gauss_camera_capture_shell.dart').readAsStringSync();
      final reviewSurface = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final combinedRuntime = '$cameraShell\n$reviewSurface';

      expect(dataset, contains('minimumCaseCount = 30'));
      expect(dataset, contains('buildDryRunPlan'));
      expect(dataset, contains('integral_def_001_clean_printed'));
      expect(dataset, contains('derivative_leibniz_001_clean_printed'));
      expect(policy, contains('labRunnerCanInvokeRealEngines = false'));
      expect(policy, contains('realBenchmarkImageAssetsBundled = false'));
      expect(combinedRuntime, isNot(contains('evaluateFromCamera')));
      expect(combinedRuntime, isNot(contains('solveFromCamera')));
      expect(combinedRuntime, isNot(contains('setLatex')));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*workmanager\s*:', multiLine: true))));
      expect(androidManifest, contains('INTERNET')); // Q384R1 deferred model download requires network permission.
      expect(androidManifest, isNot(contains('READ_MEDIA_IMAGES')));
    });
  });
}
