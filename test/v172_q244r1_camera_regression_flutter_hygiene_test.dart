import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_regression_flutter_hygiene_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_deferred_math_ocr_model_manager.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_engine_benchmark_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_winner_engine_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  group('V172-Q244R1 camera regression Flutter hygiene repair', () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, Object>{});
    });

    test('policy records only hygiene repair scope', () {
      expect(GaussCameraRegressionFlutterHygienePolicy.phase, 'V172-Q244R1');
      expect(GaussCameraRegressionFlutterHygienePolicy.repairsQ244UserSideFlutterAnalyzeErrors, isTrue);
      expect(GaussCameraRegressionFlutterHygienePolicy.repairsQ244UserSideFlutterTestFailures, isTrue);
      expect(GaussCameraRegressionFlutterHygienePolicy.ocrRuntimeAdded, isFalse);
      expect(GaussCameraRegressionFlutterHygienePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraRegressionFlutterHygienePolicy.keyboardMutationAllowed, isFalse);
      expect(GaussCameraRegressionFlutterHygienePolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussCameraRegressionFlutterHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(GaussCameraRegressionFlutterHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
    });

    test('Q244 regression court references the correct Q239A policy symbol', () {
      final court = File('lib/features/camera/gauss_camera_regression_court.dart').readAsStringSync();
      expect(court, contains('GaussWorkspaceCameraEntryButtonPolicy.replacesWorkspaceEllipsisAction'));
      expect(court, isNot(contains('GaussWorkspaceCameraEntryPolicy.')));
    });

    test('Q241 unsafe candidate status is case-insensitive and blocks before review', () {
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

    test('Q239D/Q385R1 deferred download queue copy stays review-only', () async {
      final queued = await GaussDeferredMathOcrModelManager.queueUserApprovedNetworkPreparation();
      expect(queued.productCopy, contains('indirme'));
      expect(queued.productCopy, contains('doğrulanmadan OCR çalıştırılmayacak'));
      expect(queued.canRunOffline, isFalse);
    });

    test('stale widget tests no longer expect removed ellipsis key', () {
      final widgetTest = File('test/widget_test.dart').readAsStringSync();
      expect(widgetTest, contains("ValueKey('mathpro-workspace-camera-entry-button')"));
      expect(widgetTest, isNot(contains("ValueKey('mathpro-more-placeholder-button')")));
    });
  });
}
