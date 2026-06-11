import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_accuracy_performance_multidevice_qa_guard_q362.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_accuracy_performance_multidevice_qa_guard_q362_policy.dart';

void main() {
  test('q362 prepares accuracy performance and multi-device QA guard without claiming runtime pass', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q362 = manifest['v172Q362AccuracyPerformanceMultideviceQaGuard'] as Map<String, dynamic>;

    expect(<String>[GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.phase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.phase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['accuracyPerformanceMultideviceQaGuardLatestPhase'], GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.phase);
    expect(manifest['cameraOcrRuntimeExecutionBridgeLatestPhase'], GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.sourcePhase);
    expect(q362['phase'], GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.phase);
    expect(q362['sourcePhase'], GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.sourcePhase);
    expect(q362['status'], GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.status);
    expect(q362['accuracyQaGuardPrepared'], isTrue);
    expect(q362['candidateRankingGuardPrepared'], isTrue);
    expect(q362['performanceQaGuardPrepared'], isTrue);
    expect(q362['multiDeviceQaGuardPrepared'], isTrue);
    expect(q362['requiresReviewedCandidateEnvelope'], isTrue);
    expect(q362['requiresEditableMathLiveReviewBeforeImport'], isTrue);
    expect(q362['requiresExplicitUserApprovalBeforeWorkspaceImport'], isTrue);
    expect(q362['requiresRealDeviceEvidenceBeforePass'], isTrue);
    expect(q362['requiresLatencyMemoryThermalEvidenceBeforePass'], isTrue);
    expect(q362['requiresMultiDeviceEvidenceBeforePass'], isTrue);
    expect(q362['featureFlagDefaultEnabled'], isFalse);
    expect(q362['cameraAutoExecutionBlocked'], isTrue);
    expect(q362['runtimeAutoExecutionBlocked'], isTrue);
    expect(q362['workspaceAutoImportBlocked'], isTrue);
    expect(q362['solveGraphSolutionHistoryAutoExecutionBlocked'], isTrue);
    expect(q362['modelLoadExecuted'], isFalse);
    expect(q362['dummyRuntimeCallExecuted'], isFalse);
    expect(q362['imageToLatexInferenceExecuted'], isFalse);
    expect(q362['ocrReviewOpened'], isFalse);
    expect(q362['workspaceImportExecuted'], isFalse);
    expect(q362['accuracyPassClaimed'], isFalse);
    expect(q362['performancePassClaimed'], isFalse);
    expect(q362['multiDevicePassClaimed'], isFalse);
    expect(q362['ocrPassClaimed'], isFalse);

    final result = GaussAccuracyPerformanceMultideviceQaGuardQ362.evaluate();
    expect(result.phase, GaussAccuracyPerformanceMultideviceQaGuardQ362Policy.phase);
    expect(result.accuracyQaGuardPrepared, isTrue);
    expect(result.performanceQaGuardPrepared, isTrue);
    expect(result.multiDeviceQaGuardPrepared, isTrue);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q362 keeps protected runtime and UI surfaces unchanged by QA guard', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(buildGradle.toLowerCase(), isNot(contains('onnxruntime-android')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));
    expect(mainActivity, contains('private val q361FeatureEnabled = false'));
    expect(mainActivity, contains('cameraOcrRuntimeExecutionBridge'));
    expect(mainActivity, isNot(contains('q362FeatureEnabled')));
    expect(mainActivity, isNot(contains('accuracyPerformanceMultideviceQa')));

    final modelArtifacts = Directory.current
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => !path.startsWith('build/') && !path.contains('/build/'))
        .where((path) => !path.startsWith('.dart_tool/') && !path.contains('/.dart_tool/'))
        .where((path) => !path.startsWith('docs/evidence/'))
        .where((path) => RegExp(r'\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$', caseSensitive: false).hasMatch(path))
        .toList();
    expect(modelArtifacts, isEmpty);
  });
}
