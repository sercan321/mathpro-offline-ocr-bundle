import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_model_private_storage_sha_verification_q355.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_model_private_storage_sha_verification_q355_policy.dart';

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
  test('q355 advances active phase and prepares private-storage SHA verification gate only', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q355 = manifest['v172Q355OnnxModelPrivateStorageShaVerification'] as Map<String, dynamic>;

    expect(<String>{GaussOnnxModelPrivateStorageShaVerificationQ355Policy.phase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{GaussOnnxModelPrivateStorageShaVerificationQ355Policy.phase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxModelPrivateStorageShaVerificationLatestPhase'],
        GaussOnnxModelPrivateStorageShaVerificationQ355Policy.phase);
    expect(manifest['onnxRuntimeAndroidDependencyAbiBuildTrialLatestPhase'],
        GaussOnnxModelPrivateStorageShaVerificationQ355Policy.sourcePhase);
    expect(q355['phase'], GaussOnnxModelPrivateStorageShaVerificationQ355Policy.phase);
    expect(q355['sourcePhase'], GaussOnnxModelPrivateStorageShaVerificationQ355Policy.sourcePhase);
    expect(q355['privateStoragePolicyPrepared'], isTrue);
    expect(q355['shaVerificationPolicyPrepared'], isTrue);
    expect(q355['atomicCopyPolicyPrepared'], isTrue);
    expect(q355['userSideArtifactRequired'], isTrue);
    expect(q355['expectedOnnxArtifactSha256'],
        GaussOnnxModelPrivateStorageShaVerificationQ355Policy.expectedOnnxArtifactSha256);
    expect(q355['expectedOnnxArtifactSizeBytes'],
        GaussOnnxModelPrivateStorageShaVerificationQ355Policy.expectedOnnxArtifactSizeBytes);
  });

  test('q355 Dart contract keeps copy/load/runtime/OCR actions blocked', () {
    final result = GaussOnnxModelPrivateStorageShaVerificationQ355.evaluate();

    expect(result.phase, GaussOnnxModelPrivateStorageShaVerificationQ355Policy.phase);
    expect(result.sourcePhase, GaussOnnxModelPrivateStorageShaVerificationQ355Policy.sourcePhase);
    expect(result.q354OnnxRuntimeAndroidDependencyTrialPresent, isTrue);
    expect(result.privateStoragePolicyPrepared, isTrue);
    expect(result.shaVerificationPolicyPrepared, isTrue);
    expect(result.atomicCopyPolicyPrepared, isTrue);
    expect(result.userSideArtifactRequired, isTrue);
    expect(result.userSideFlutterBuildEvidenceRequired, isTrue);
    expect(result.onnxModelBundledIntoFlutterProject, isFalse);
    expect(result.onnxModelCopiedToAppPrivateStorage, isFalse);
    expect(result.onnxModelShaVerifiedOnDevice, isFalse);
    expect(result.onnxModelLoadAttempted, isFalse);
    expect(result.onnxModelLoaded, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.dummyRuntimeCallExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.editableMathLiveReviewOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.solveGraphSolutionHistoryTouched, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.mainActivityChanged, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.uiRuntimeChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q355 preserves Q354 dependency but adds no model artifact or runtime bridge', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;

    expect(buildGradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    expect(buildGradle.toLowerCase(), isNot(contains('onnxruntime-android')));
    expect(pubspec, isNot(contains('onnxruntime')));
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('OrtEnvironment')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('OnnxTensor')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('ai.onnxruntime')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('pp_formulanet_s.onnx')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('runInference(')));
    }
    expect(androidManifest, isNot(contains('ONNX')));

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
