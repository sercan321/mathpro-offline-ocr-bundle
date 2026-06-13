import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_dummy_input_runtime_call_guard_preflight_q358.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_onnx_dummy_input_runtime_call_guard_preflight_q358_policy.dart';

void main() {
  test('q358 exposes default-off dummy input runtime call guard without OCR/import claims', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q358 = manifest['v172Q358OnnxDummyInputRuntimeCallGuardPreflight'] as Map<String, dynamic>;

    expect(<String>[GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.phase, 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.phase, 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['onnxDummyInputRuntimeCallGuardPreflightLatestPhase'],
        GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.phase);
    expect(q358['phase'], GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.phase);
    expect(q358['sourcePhase'], GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.sourcePhase);
    expect(q358['selectedDependencyCoordinate'],
        GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.selectedDependencyCoordinate);
    expect(q358['defaultOffBridgePresent'], isTrue);
    expect(q358['mainActivityChangedForBridgeOnly'], isTrue);
    expect(q358['requiresExplicitBridgeInvocation'], isTrue);
    expect(q358['dummyRuntimeCallAutoExecuted'], isFalse);
    expect(q358['dummyRuntimeCallExecuted'], isFalse);
    expect(q358['onnxModelBundledIntoFlutterProject'], isFalse);
    expect(q358['onnxModelCopiedToAppPrivateStorage'], isFalse);
    expect(q358['realImageToLatexInferenceExecuted'], isFalse);
    expect(q358['editableMathLiveReviewOpened'], isFalse);
    expect(q358['workspaceImportExecuted'], isFalse);
    expect(q358['dummyRuntimeCallPassClaimedByPackage'], isFalse);
    expect(q358['ocrPassClaimed'], isFalse);

    final result = GaussOnnxDummyInputRuntimeCallGuardPreflightQ358.evaluate();
    expect(result.phase, GaussOnnxDummyInputRuntimeCallGuardPreflightQ358Policy.phase);
    expect(result.defaultOffBridgePresent, isTrue);
    expect(result.mainActivityChangedForBridgeOnly, isTrue);
    expect(result.dummyRuntimeCallAutoExecuted, isFalse);
    expect(result.dummyRuntimeCallRequiresExplicitBridgeInvocation, isTrue);
    expect(result.dummyRuntimeCallRequiresModelLoadGuard, isTrue);
    expect(result.dummyRuntimeCallRequiresPrivateStorageArtifact, isTrue);
    expect(result.dummyRuntimeCallRequiresExactSha256, isTrue);
    expect(result.dummyRuntimeCallPassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q358 mutates only the Android bridge and does not bundle model artifacts', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));
    expect(mainActivity, contains('private val q358FeatureEnabled = false'));
    expect(mainActivity, contains('"onnxDummyInputRuntimeCall" -> result.success(q358OnnxDummyInputRuntimeCall(call.method))'));
    expect(mainActivity, contains('private fun q358OnnxDummyInputRuntimeCall'));
    expect(mainActivity, contains('dummyRuntimeCallAutoExecuted" to false'));
    expect(mainActivity, contains('realImageToLatexInferenceExecuted" to false'));
    expect(mainActivity, contains('workspaceImportExecuted" to false'));
    expect(mainActivity, contains('ocrPassClaimed" to false'));

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
