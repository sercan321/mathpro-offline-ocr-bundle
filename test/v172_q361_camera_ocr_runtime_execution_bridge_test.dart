import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_execution_bridge_q361.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_execution_bridge_q361_policy.dart';

void main() {
  test('q361 prepares camera OCR runtime execution bridge while staying default-off', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q361 = manifest['v172Q361CameraOcrRuntimeExecutionBridge'] as Map<String, dynamic>;

    expect(<String>[GaussCameraOcrRuntimeExecutionBridgeQ361Policy.phase, 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussCameraOcrRuntimeExecutionBridgeQ361Policy.phase, 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['cameraOcrRuntimeExecutionBridgeLatestPhase'], GaussCameraOcrRuntimeExecutionBridgeQ361Policy.phase);
    expect(q361['phase'], GaussCameraOcrRuntimeExecutionBridgeQ361Policy.phase);
    expect(q361['sourcePhase'], GaussCameraOcrRuntimeExecutionBridgeQ361Policy.sourcePhase);
    expect(q361['status'], GaussCameraOcrRuntimeExecutionBridgeQ361Policy.status);
    expect(q361['runtimeExecutionBridgePrepared'], isTrue);
    expect(q361['featureFlagDefaultEnabled'], isFalse);
    expect(q361['requiresExplicitBridgeInvocation'], isTrue);
    expect(q361['requiresQ357ModelLoadGuard'], isTrue);
    expect(q361['requiresQ358DummyRuntimeGuard'], isTrue);
    expect(q361['requiresQ359CandidateEnvelope'], isTrue);
    expect(q361['requiresQ360EditableReviewAndApprovedImportContract'], isTrue);
    expect(q361['cameraAutoExecutionBlocked'], isTrue);
    expect(q361['startupAutoExecutionBlocked'], isTrue);
    expect(q361['workspaceAutoExecutionBlocked'], isTrue);
    expect(q361['solveGraphSolutionHistoryAutoExecutionBlocked'], isTrue);
    expect(q361['requiresEditableMathLiveReviewBeforeImport'], isTrue);
    expect(q361['requiresExplicitUserApprovalBeforeWorkspaceImport'], isTrue);
    expect(q361['modelLoadAutoExecuted'], isFalse);
    expect(q361['dummyRuntimeCallAutoExecuted'], isFalse);
    expect(q361['imageToLatexInferenceAutoExecuted'], isFalse);
    expect(q361['editableMathLiveReviewAutoOpened'], isFalse);
    expect(q361['workspaceImportExecuted'], isFalse);
    expect(q361['ocrPassClaimed'], isFalse);

    final result = GaussCameraOcrRuntimeExecutionBridgeQ361.evaluate();
    expect(result.phase, GaussCameraOcrRuntimeExecutionBridgeQ361Policy.phase);
    expect(result.runtimeExecutionBridgePrepared, isTrue);
    expect(result.featureFlagDefaultEnabled, isFalse);
    expect(result.requiresQ360EditableReviewAndApprovedImportContract, isTrue);
    expect(result.cameraAutoExecutionBlocked, isTrue);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q361 keeps red-line surfaces and model artifacts protected', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));
    expect(mainActivity, contains('private val q361FeatureEnabled = false'));
    expect(mainActivity, contains('cameraOcrRuntimeExecutionBridge'));
    expect(mainActivity, contains('q361CameraOcrRuntimeExecutionBridge'));

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
