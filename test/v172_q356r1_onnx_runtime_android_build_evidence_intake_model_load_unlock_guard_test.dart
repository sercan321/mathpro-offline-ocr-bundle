import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_android_build_evidence_intake_model_load_unlock_guard_q356r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_android_build_evidence_intake_model_load_unlock_guard_q356r1_policy.dart';

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
  test('q356r1 advances active phase but keeps model-load unlock blocked pending user logs', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q356r1 = manifest['v172Q356R1OnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuard'] as Map<String, dynamic>;

    expect(<String>{GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.phase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.phase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardLatestPhase'],
        GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.phase);
    expect(manifest['onnxRealModelLoadSmokeEvidenceBlockedLatestPhase'],
        GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.sourcePhase);
    expect(q356r1['phase'], GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.phase);
    expect(q356r1['sourcePhase'], GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.sourcePhase);
    expect(q356r1['selectedDependencyCoordinate'],
        GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.selectedDependencyCoordinate);
    expect(q356r1['userSideDependencyBuildEvidenceAccepted'], isFalse);
    expect(q356r1['modelLoadUnlockGranted'], isFalse);
    expect(q356r1['realModelLoadSmokeMayStartNext'], isFalse);
    expect(q356r1['blockedBecauseUserSideBuildLogsMissing'], isTrue);
    expect(q356r1['onnxModelLoadAttempted'], isFalse);
    expect(q356r1['ocrPassClaimed'], isFalse);

    final result = GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1.evaluate();
    expect(result.phase, GaussOnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardQ356R1Policy.phase);
    expect(result.userSideDependencyBuildEvidenceAccepted, isFalse);
    expect(result.modelLoadUnlockGranted, isFalse);
    expect(result.onnxModelLoadAttempted, isFalse);
    expect(result.modelLoadPassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q356r1 preserves dependency trial but adds no runtime bridge or model artifact', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;

    expect(buildGradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));

    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      for (final forbidden in <String>[
      'OrtEnvironment',
      'OnnxTensor',
      'OnnxValue',
      'ai.onnxruntime',
      'setModelFromFile',
      'loadModel(',
      'runInference(',
      'pp_formulanet_s.onnx',
      ]) {
        expect(mainActivity, isNot(contains(forbidden)), reason: 'Q356R1 must not add runtime/model-load marker $forbidden');
      }
    }

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
