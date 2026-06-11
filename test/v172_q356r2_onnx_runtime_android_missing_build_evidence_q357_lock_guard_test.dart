import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_android_missing_build_evidence_q357_lock_guard_q356r2.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_android_missing_build_evidence_q357_lock_guard_q356r2_policy.dart';

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
  test('q356r2 locks q357 real model-load until user-side Android dependency logs exist', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q356r2 = manifest['v172Q356R2OnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuard'] as Map<String, dynamic>;

    expect(<String>{GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.phase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.phase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardLatestPhase'],
        GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.phase);
    if (manifest['cameraOcrLatestPhase'] == q357SuccessorPhase) {
      expect(manifest['onnxRealModelLoadSmokeBridgePreflightExecutionLatestPhase'], q357SuccessorPhase);
    }
    expect(manifest['onnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardLatestPhase'],
        GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.sourcePhase);
    expect(q356r2['phase'], GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.phase);
    expect(q356r2['sourcePhase'], GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.sourcePhase);
    expect(q356r2['selectedDependencyCoordinate'],
        GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.selectedDependencyCoordinate);
    expect(q356r2['userSideDependencyBuildEvidenceAccepted'], isFalse);
    expect(q356r2['q357RealModelLoadLocked'], isTrue);
    expect(q356r2['modelLoadUnlockGranted'], isFalse);
    expect(q356r2['realModelLoadSmokeMayStartNext'], isFalse);
    expect(q356r2['blockedBecauseUserSideBuildLogsMissing'], isTrue);
    expect(q356r2['onnxModelLoadAttempted'], isFalse);
    expect(q356r2['modelLoadPassClaimedByPackage'], isFalse);
    expect(q356r2['ocrPassClaimed'], isFalse);

    final result = GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2.evaluate();
    expect(result.phase, GaussOnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardQ356R2Policy.phase);
    expect(result.userSideDependencyBuildEvidenceAccepted, isFalse);
    expect(result.q357RealModelLoadLocked, isTrue);
    expect(result.modelLoadUnlockGranted, isFalse);
    expect(result.onnxModelLoadAttempted, isFalse);
    expect(result.modelLoadPassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q356r2 preserves dependency trial but adds no runtime bridge or model artifact', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;

    expect(buildGradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    expect(buildGradle.toLowerCase(), isNot(contains('onnxruntime-android')));
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
        expect(mainActivity, isNot(contains(forbidden)), reason: 'Q356R2 must not add runtime/model-load marker $forbidden');
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
