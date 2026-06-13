import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_android_dependency_abi_build_trial_q354.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_android_dependency_abi_build_trial_q354_policy.dart';

const q355SuccessorPhase = 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION';
const q356SuccessorPhase = 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const q356r1SuccessorPhase = 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD';
const q356r2SuccessorPhase = 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD';
const q357SuccessorPhase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
const q358SuccessorPhase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
const q359SuccessorPhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const q360SuccessorPhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const q361SuccessorPhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q362SuccessorPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';

const q357OrLaterOnnxBridgeActivePhases = <String>{
  q357SuccessorPhase,
  q358SuccessorPhase,
  q359SuccessorPhase,
  q360SuccessorPhase,
  q361SuccessorPhase,
  q362SuccessorPhase,
  q363SuccessorPhase,
};

void main() {
  test('q354 advances active phase and records selected ONNX Runtime Android dependency', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q354 = manifest['v172Q354OnnxRuntimeAndroidDependencyAbiBuildTrial'] as Map<String, dynamic>;

    expect(<String>{GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.phase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.phase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase},
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxRuntimeAndroidDependencyAbiBuildTrialLatestPhase'],
        GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.phase);
    expect(q354['phase'], GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.phase);
    expect(q354['sourcePhase'], GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.sourcePhase);
    expect(q354['selectedDependencyCoordinate'],
        GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.selectedDependencyCoordinate);
    expect(q354['dependencyCoordinateSelected'], isTrue);
    expect(q354['onnxRuntimeDependencyAdded'], isTrue);
    expect(q354['gradleChanged'], isTrue);
    expect(q354['androidAbiBuildTrialPrepared'], isTrue);
    expect(q354['assistantSideAndroidBuildExecuted'], isFalse);
    expect(q354['userSideAndroidBuildEvidenceRequired'], isTrue);
  });

  test('q354 Dart contract keeps runtime/model/OCR actions blocked', () {
    final result = GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354.evaluate();

    expect(result.phase, GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.phase);
    expect(result.sourcePhase, GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.sourcePhase);
    expect(result.selectedDependencyCoordinate,
        GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.selectedDependencyCoordinate);
    expect(result.q353FeasibilityGateAccepted, isTrue);
    expect(result.gradleChanged, isTrue);
    expect(result.onnxRuntimeDependencyAdded, isTrue);
    expect(result.dependencyCoordinateSelected, isTrue);
    expect(result.androidAbiBuildTrialPrepared, isTrue);
    expect(result.assistantSideAndroidBuildExecuted, isFalse);
    expect(result.onnxArtifactSha256,
        GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.externalOnnxArtifactSha256);
    expect(result.onnxArtifactSizeBytes,
        GaussOnnxRuntimeAndroidDependencyAbiBuildTrialQ354Policy.externalOnnxArtifactSizeBytes);
    expect(result.onnxModelBundledIntoFlutterProject, isFalse);
    expect(result.onnxModelCopiedToAppPrivateStorage, isFalse);
    expect(result.onnxModelLoadAttempted, isFalse);
    expect(result.dummyRuntimeCallExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.editableMathLiveReviewOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.solveGraphSolutionHistoryTouched, isFalse);
    expect(result.mainActivityChanged, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q354 changes only Gradle dependency surface and still bundles no model artifacts', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;

    expect(buildGradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    expect(pubspec, isNot(contains('onnxruntime')));
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('OrtEnvironment')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('OnnxTensor')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('pp_formulanet_s.onnx')));
    }
    expect(androidManifest, isNot(contains('ONNX')));

    final modelArtifacts = Directory.current
        .listSync(recursive: true)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => !path.contains('/docs/evidence/'))
        .where((path) => RegExp(r'\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$', caseSensitive: false).hasMatch(path))
        .toList();
    expect(modelArtifacts, isEmpty);
  });
}
