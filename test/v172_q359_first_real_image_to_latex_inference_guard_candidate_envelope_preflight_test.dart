import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_guard_candidate_envelope_preflight_q359.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_first_real_image_to_latex_inference_guard_candidate_envelope_preflight_q359_policy.dart';

void main() {
  test('q359 exposes default-off image-to-LaTeX candidate envelope guard without OCR/import claims', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q359 = manifest['v172Q359FirstRealImageToLatexInferenceGuardCandidateEnvelopePreflight'] as Map<String, dynamic>;

    expect(<String>[GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy.phase, 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy.phase, 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['firstRealImageToLatexInferenceGuardCandidateEnvelopePreflightLatestPhase'],
        GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy.phase);
    expect(q359['phase'], GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy.phase);
    expect(q359['sourcePhase'], GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy.sourcePhase);
    expect(q359['selectedDependencyCoordinate'],
        GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy.selectedDependencyCoordinate);
    expect(q359['defaultOffBridgePresent'], isTrue);
    expect(q359['mainActivityChangedForBridgeOnly'], isTrue);
    expect(q359['requiresExplicitBridgeInvocation'], isTrue);
    expect(q359['requiresQ358DummyRuntimeGuard'], isTrue);
    expect(q359['requiresEditableMathLiveReviewBeforeImport'], isTrue);
    expect(q359['requiresExplicitUserApprovalBeforeWorkspaceImport'], isTrue);
    expect(q359['candidateEnvelopePrepared'], isTrue);
    expect(q359['realImageToLatexInferenceAutoExecuted'], isFalse);
    expect(q359['realImageToLatexInferenceExecuted'], isFalse);
    expect(q359['editableMathLiveReviewOpened'], isFalse);
    expect(q359['workspaceImportExecuted'], isFalse);
    expect(q359['ocrPassClaimed'], isFalse);

    final result = GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359.evaluate();
    expect(result.phase, GaussFirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightQ359Policy.phase);
    expect(result.defaultOffBridgePresent, isTrue);
    expect(result.mainActivityChangedForBridgeOnly, isTrue);
    expect(result.requiresExplicitBridgeInvocation, isTrue);
    expect(result.requiresQ358DummyRuntimeGuard, isTrue);
    expect(result.requiresEditableMathLiveReviewBeforeImport, isTrue);
    expect(result.requiresExplicitUserApprovalBeforeWorkspaceImport, isTrue);
    expect(result.realImageToLatexInferenceAutoExecuted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.realImageToLatexInferencePassClaimedByPackage, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q359 mutates only the Android bridge and does not bundle model artifacts', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));
    expect(mainActivity, contains('private val q359FeatureEnabled = false'));
    expect(mainActivity, contains('"onnxFirstImageToLatexInferenceGuard" -> result.success(q359OnnxFirstImageToLatexInferenceGuard(call.method))'));
    expect(mainActivity, contains('private fun q359OnnxFirstImageToLatexInferenceGuard'));
    expect(mainActivity, contains('realImageToLatexInferenceAutoExecuted" to false'));
    expect(mainActivity, contains('realImageToLatexInferenceAttempted" to false'));
    expect(mainActivity, contains('realImageToLatexInferenceExecuted" to false'));
    expect(mainActivity, contains('editableMathLiveReviewOpened" to false'));
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
