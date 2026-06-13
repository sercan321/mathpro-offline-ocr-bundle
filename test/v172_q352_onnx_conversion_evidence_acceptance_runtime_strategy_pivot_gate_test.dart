import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_q352.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_q352_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

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
  test('q352 manifest accepts ONNX conversion evidence and pivots runtime strategy without model load or OCR', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q352 = manifest['v172Q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGate'] as Map<String, dynamic>;

    expect(<String>[GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.phase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.phase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateLatestPhase'],
        GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.phase);
    expect(q352['phase'], GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.phase);
    expect(q352['sourcePhase'], GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.sourcePhase);
    expect(q352['q351RealModelLoadUnlockGatePresent'], isTrue);
    expect(q352['q351R2FlutterRunKotlinBuildHelperRepairPresent'], isTrue);
    expect(q352['q344PaddleLiteBinaryBundlePreserved'], isTrue);
    expect(q352['officialPpFormulanetSModelDownloaded'], isTrue);
    expect(q352['onnxConversionEvidenceAccepted'], isTrue);
    expect(q352['onnxArtifactStoredOutsideProjectRoot'], isTrue);
    expect(q352['onnxArtifactFileName'], 'pp_formulanet_s.onnx');
    expect(q352['onnxArtifactSha256'],
        GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.externalOnnxArtifactSha256);
    expect(q352['onnxArtifactSizeBytes'],
        GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.externalOnnxArtifactSizeBytes);
    expect(q352['conversionPaddleVersion'], '3.0.0.dev20250426');
    expect(q352['conversionPaddle2OnnxVersion'], '2.1.0');
    expect(q352['conversionModelFilename'], 'inference.json');
    expect(q352['conversionParamsFilename'], 'inference.pdiparams');
    expect(q352['conversionRequestedOpset'], '11');
    expect(q352['conversionObservedOpset'], '18');
    expect(q352['paddleLiteNbArtifactAvailable'], isFalse);
    expect(q352['paddleLiteModelLoadStillBlocked'], isTrue);
    expect(q352['paddleLiteRuntimeParked'], isTrue);
    expect(q352['onnxRuntimeMobileCandidateOpened'], isTrue);
    expect(q352['onnxRuntimeDependencyAdded'], isFalse);
    expect(q352['onnxModelBundledIntoFlutterProject'], isFalse);
    expect(q352['onnxModelLoadAttempted'], isFalse);
    expect(q352['onnxModelLoaded'], isFalse);
    expect(q352['realImageToLatexInferenceExecuted'], isFalse);
    expect(q352['ocrPassClaimed'], isFalse);
  });

  test('q352 Dart contract exposes ONNX strategy pivot as default-off and non-runtime', () {
    final result = GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352.evaluate();

    expect(result.phase, GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.phase);
    expect(result.sourcePhase, GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.sourcePhase);
    expect(result.q351RealModelLoadUnlockGatePresent, isTrue);
    expect(result.officialPpFormulanetSModelDownloaded, isTrue);
    expect(result.onnxConversionEvidenceAccepted, isTrue);
    expect(result.onnxArtifactStoredOutsideProjectRoot, isTrue);
    expect(result.onnxArtifactSha256,
        GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.externalOnnxArtifactSha256);
    expect(result.onnxArtifactSizeBytes,
        GaussOnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateQ352Policy.externalOnnxArtifactSizeBytes);
    expect(result.paddleLiteNbArtifactAvailable, isFalse);
    expect(result.onnxRuntimeMobileCandidateOpened, isTrue);
    expect(result.onnxRuntimeDependencyAdded, isFalse);
    expect(result.onnxModelBundledIntoFlutterProject, isFalse);
    expect(result.onnxModelLoadAttempted, isFalse);
    expect(result.onnxModelLoaded, isFalse);
    expect(result.runtimeStartupExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q352 adds evidence and capture tooling only while preserving app runtime and UI red lines', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final gradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final manifestXml = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    expect(File('tool/capture_pp_formulanet_s_onnx_artifact_evidence_v172_q352.mjs').existsSync(), isTrue);
    expect(File('docs/evidence/V172_Q352_ONNX_CONVERSION_EVIDENCE.json').existsSync(), isTrue);
    expect(mainActivity, contains('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'));
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('OrtEnvironment')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('onnxruntime')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('OnnxTensor')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('pp_formulanet_s.onnx')));
    }
    if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {
      expect(mainActivity, isNot(contains('runInference(')));
    }
    expect(gradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    if (<String>{'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL', 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION', 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED', 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD', 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD', 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION', 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT', 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}.contains(manifest['cameraOcrLatestPhase'])) {
      expectQ389R6WOnnxRuntimeDependencySurface(gradle);
    } else {
      expect(gradle.toLowerCase(), isNot(contains('onnxruntime')));
    }
    final pubspecRuntimeSection = pubspec
        .split('\n')
        .where((line) => !line.trimLeft().startsWith('#'))
        .join('\n')
        .toLowerCase();
    expect(pubspecRuntimeSection, isNot(contains('onnxruntime')));
    expect(pubspecRuntimeSection, isNot(contains('onnxruntime-android')));
    expect(pubspecRuntimeSection, isNot(contains('onnx:')));
    expect(manifestXml, isNot(contains('ONNX')));
    expectNoNativeBinariesOrOnlyQ344ActualBundle();
    final projectModelFiles = Directory.current
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => !path.startsWith('build/') && !path.contains('/build/'))
        .where((path) => !path.startsWith('.dart_tool/') && !path.contains('/.dart_tool/'))
        .where((path) => !path.startsWith('docs/evidence/'))
        .where((path) => RegExp(r'\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$', caseSensitive: false).hasMatch(path))
        .toList();
    expect(projectModelFiles, isEmpty);
  });
}
