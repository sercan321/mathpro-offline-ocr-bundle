import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_result_schema.dart';

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
  group('V172-Q240R3 OCR benchmark external lab intake validation gate', () {
    test('policy keeps the phase validation-only and runtime-isolated', () {
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.phase, 'V172-Q240R3');
      expect(
        GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.fullPhase,
        'V172-Q240R3-OCR-BENCHMARK-EXTERNAL-LAB-INTAKE-VALIDATION-GATE',
      );
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.q240r2ExternalLabSchemaPreserved, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.externalLabIntakeValidatorImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.requiredKeyValidationImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.forbiddenUnsafeActionValidationImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.sampleCoverageValidationImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.licenseValidationImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.offlineInstallValidationImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.mathLiveReviewGateValidationImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.directSolveBlockValidationImplemented, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.realOcrEngineAdded, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.onnxRuntimeAdded, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.backgroundDownloadWorkerImplemented, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.directWorkspaceImportImplemented, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.benchmarkWinnerSelected, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.winnerEngineAdapterImplemented, isFalse);
    });

    test('valid external report may only enter winner adapter review', () {
      final result = GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport(_validReport());
      expect(result.decision, GaussOcrExternalLabIntakeDecision.eligibleForWinnerAdapterReview);
      expect(result.hasBlockingIssues, isFalse);
      expect(result.sampleCount, 30);
      expect(result.mathLiveReviewRequired, isTrue);
      expect(result.directSolveAllowed, isFalse);
      expect(result.productionRuntimeBindingAllowed, isFalse);
      expect(result.mayEnterWinnerAdapterReview, isTrue);
    });

    test('unsafe report is blocked before any winner or runtime binding', () {
      final unsafe = _validReport()
        ..['autoSolve'] = true
        ..['directSolveAllowed'] = true
        ..['mathLiveReviewRequired'] = false;
      final result = GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport(unsafe);
      expect(result.decision, GaussOcrExternalLabIntakeDecision.unsafeActionBlocked);
      expect(result.hasBlockingIssues, isTrue);
      expect(result.mayEnterWinnerAdapterReview, isFalse);
      expect(result.productionRuntimeBindingAllowed, isFalse);
    });

    test('coverage, license, and offline gates block weak evidence', () {
      final weak = _validReport()
        ..['sampleResults'] = <Map<String, Object?>>[_validSample(1)]
        ..['licenseClearedForDistribution'] = false
        ..['offlineAfterInstall'] = false;
      final result = GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport(weak);
      expect(result.hasBlockingIssues, isTrue);
      expect(result.mayEnterWinnerAdapterReview, isFalse);
      expect(
        <GaussOcrExternalLabIntakeDecision>[
          GaussOcrExternalLabIntakeDecision.licenseBlocked,
          GaussOcrExternalLabIntakeDecision.offlineBlocked,
          GaussOcrExternalLabIntakeDecision.insufficientCoverage,
        ],
        contains(result.decision),
      );
    });

    test('evidence templates and package remain runtime-free', () {
      final intakeTemplate = jsonDecode(
        File('docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_TEMPLATE.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final blockedSample = jsonDecode(
        File('docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_BLOCKED_SAMPLE.json').readAsStringSync(),
      ) as Map<String, dynamic>;
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(intakeTemplate['phase'], 'V172-Q240R3');
      expect(intakeTemplate['productionRuntimeBindingAllowed'], isFalse);
      expect(intakeTemplate['winnerSelectionAllowed'], isFalse);
      expect(intakeTemplate['directSolveAllowed'], isFalse);
      expect(intakeTemplate['mathLiveReviewRequired'], isTrue);
      expect(blockedSample['expectedDecision'], 'unsafeActionBlocked');
      expect(blockedSample['containsForbiddenUnsafeKeys'], isTrue);
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*workmanager\s*:', multiLine: true))));
      expect(androidManifest, contains('android.permission.INTERNET')); // Q384R1 download-only model installer requires user-tapped network access.
      expect(androidManifest, isNot(contains('READ_MEDIA_IMAGES')));
    });

    test('gate exposes schema-linked safety constants', () {
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.phase, contains('Q240R3'));
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.schemaVersion, GaussOcrBenchmarkExternalLabResultSchema.schemaVersion);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.realEngineInvocationAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.productionRuntimeBindingAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.winnerSelectionAllowed, isFalse);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.blocksUnsafeActions, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.hasRequiredSafetyFlags, isTrue);
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.validationStages, contains('mathLiveReviewGate'));
      expect(GaussOcrBenchmarkExternalLabIntakeValidationGate.validationStages, contains('winnerAdapterReviewOnlyGate'));
    });
  });
}
