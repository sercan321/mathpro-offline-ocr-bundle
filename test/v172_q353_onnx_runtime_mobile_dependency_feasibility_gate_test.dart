import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_mobile_dependency_feasibility_gate_q353.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_runtime_mobile_dependency_feasibility_gate_q353_policy.dart';

const q354SuccessorPhase = 'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
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
  test('q353 advances active OCR/product phase to feasibility gate without runtime dependency', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q353 = manifest['v172Q353OnnxRuntimeMobileDependencyFeasibilityGate'] as Map<String, dynamic>;

    expect(<String>{GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.phase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.phase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase},
        contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxRuntimeMobileDependencyFeasibilityGateLatestPhase'],
        GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.phase);
    expect(q353['phase'], GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.phase);
    expect(q353['sourcePhase'], GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.sourcePhase);
    expect(q353['hygieneSourcePhase'], GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.hygieneSourcePhase);
    expect(q353['q352OnnxConversionEvidenceAccepted'], isTrue);
    expect(q353['q352R1LegacyVerifierHygienePresent'], isTrue);
    expect(q353['onnxRuntimeMobileFeasibilityGateOpened'], isTrue);
    expect(q353['dependencyOptionsDocumented'], isTrue);
    expect(q353['dependencyCoordinateSelected'], isFalse);
    expect(q353['onnxRuntimeDependencyAdded'], isFalse);
    expect(q353['q354BuildTrialAllowedWithoutExplicitApproval'], isFalse);
    expect(q353['onnxModelBundledIntoFlutterProject'], isFalse);
    expect(q353['onnxModelLoadAttempted'], isFalse);
    expect(q353['realImageToLatexInferenceExecuted'], isFalse);
    expect(q353['editableMathLiveReviewOpened'], isFalse);
    expect(q353['workspaceImportExecuted'], isFalse);
    expect(q353['ocrPassClaimed'], isFalse);
  });

  test('q353 Dart contract remains feasibility-only and blocks Q354 without explicit approval', () {
    final result = GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353.evaluate();

    expect(result.phase, GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.phase);
    expect(result.sourcePhase, GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.sourcePhase);
    expect(result.q352OnnxConversionEvidenceAccepted, isTrue);
    expect(result.q352R1LegacyVerifierHygienePresent, isTrue);
    expect(result.onnxRuntimeMobileFeasibilityGateOpened, isTrue);
    expect(result.dependencyOptionsDocumented, isTrue);
    expect(result.dependencyCoordinateSelected, isFalse);
    expect(result.onnxRuntimeDependencyAdded, isFalse);
    expect(result.q354BuildTrialAllowedWithoutExplicitApproval, isFalse);
    expect(result.onnxArtifactSha256, GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.externalOnnxArtifactSha256);
    expect(result.onnxArtifactSizeBytes, GaussOnnxRuntimeMobileDependencyFeasibilityGateQ353Policy.externalOnnxArtifactSizeBytes);
    expect(result.onnxModelBundledIntoFlutterProject, isFalse);
    expect(result.onnxModelCopiedToAppPrivateStorage, isFalse);
    expect(result.onnxModelLoadAttempted, isFalse);
    expect(result.dummyRuntimeCallExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.solveGraphSolutionHistoryTouched, isFalse);
    expect(result.mainActivityChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q353 does not add ONNX Runtime dependency or bundle model artifacts', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync().toLowerCase();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q354Active = <String>{'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL', 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION', 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED', 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD', 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD', 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION', 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT', 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}.contains(manifest['cameraOcrLatestPhase']);
    if (q354Active) {
      expect(buildGradle.toLowerCase(), isNot(contains('onnxruntime-android')));
    } else {
      expect(buildGradle, isNot(contains('onnxruntime')));
    }
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(pubspec, isNot(contains('onnx:')));
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
