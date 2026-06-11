import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_real_model_load_smoke_bridge_preflight_execution_q357.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_real_model_load_smoke_bridge_preflight_execution_q357_policy.dart';

void main() {
  test('q357 exposes a default-off ONNX real model-load smoke bridge without OCR/import claims', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q357 = manifest['v172Q357OnnxRealModelLoadSmokeBridgePreflightExecution'] as Map<String, dynamic>;

    expect(<String>[GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.phase, 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT', 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.phase, 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT', 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxRealModelLoadSmokeBridgePreflightExecutionLatestPhase'],
        GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.phase);
    expect(q357['phase'], GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.phase);
    expect(q357['sourcePhase'], GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.sourcePhase);
    expect(q357['selectedDependencyCoordinate'],
        GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.selectedDependencyCoordinate);
    expect(q357['defaultOffBridgePresent'], isTrue);
    expect(q357['mainActivityChangedForBridgeOnly'], isTrue);
    expect(q357['requiresExplicitBridgeInvocation'], isTrue);
    expect(q357['modelLoadAutoExecuted'], isFalse);
    expect(q357['onnxModelBundledIntoFlutterProject'], isFalse);
    expect(q357['onnxModelCopiedToAppPrivateStorage'], isFalse);
    expect(q357['realImageToLatexInferenceExecuted'], isFalse);
    expect(q357['editableMathLiveReviewOpened'], isFalse);
    expect(q357['workspaceImportExecuted'], isFalse);
    expect(q357['modelLoadPassClaimedByPackage'], isFalse);
    expect(q357['ocrPassClaimed'], isFalse);

    final result = GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357.evaluate();
    expect(result.phase, GaussOnnxRealModelLoadSmokeBridgePreflightExecutionQ357Policy.phase);
    expect(result.defaultOffBridgePresent, isTrue);
    expect(result.mainActivityChangedForBridgeOnly, isTrue);
    expect(result.modelLoadAutoExecuted, isFalse);
    expect(result.modelLoadRequiresExplicitBridgeInvocation, isTrue);
    expect(result.modelLoadRequiresPrivateStorageArtifact, isTrue);
    expect(result.modelLoadRequiresExactSha256, isTrue);
    expect(result.modelLoadPassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q357 mutates only the Android bridge and does not bundle model artifacts', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(buildGradle.toLowerCase(), isNot(contains('onnxruntime-android')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));
    expect(mainActivity, isNot(contains('import ai.onnxruntime.OrtEnvironment')));
    expect(mainActivity, isNot(contains('import ai.onnxruntime.OrtSession')));
    expect(mainActivity, contains('"onnxRealModelLoadSmoke" -> result.success(q357OnnxRealModelLoadSmoke(call.method))'));
    expect(mainActivity, contains('private val q357FeatureEnabled = false'));
    expect(mainActivity, contains('private fun q357OnnxRealModelLoadSmoke'));
    expect(mainActivity, contains('q357ExpectedOnnxSha256'));
    expect(mainActivity, contains('q357ExpectedOnnxSizeBytes = 308743097L'));

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
