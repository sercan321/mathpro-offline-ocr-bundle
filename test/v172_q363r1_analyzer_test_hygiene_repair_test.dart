import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r1_analyzer_test_hygiene_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r1_analyzer_test_hygiene_repair_policy.dart';

void main() {
  test('q363r1 repairs analyzer and test hygiene while preserving q363 as active product gate', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q363r1 = manifest['v172Q363R1AnalyzerTestHygieneRepair'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussQ363R1AnalyzerTestHygieneRepairPolicy.sourcePhase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussQ363R1AnalyzerTestHygieneRepairPolicy.sourcePhase);
    expect(manifest['q363R1AnalyzerTestHygieneRepairLatestPhase'], GaussQ363R1AnalyzerTestHygieneRepairPolicy.phase);
    expect(q363r1['phase'], GaussQ363R1AnalyzerTestHygieneRepairPolicy.phase);
    expect(q363r1['sourcePhase'], GaussQ363R1AnalyzerTestHygieneRepairPolicy.sourcePhase);
    expect(q363r1['repairsSuccessorAwarenessTests'], isTrue);
    expect(q363r1['repairsAnalyzerCompilationErrors'], isTrue);
    expect(q363r1['repairsMalformedWindowsPathEscape'], isTrue);
    expect(q363r1['modifiesRuntimeBridge'], isFalse);
    expect(q363r1['modifiesUiRedlines'], isFalse);
    expect(q363r1['ocrPassClaimed'], isFalse);

    final result = GaussQ363R1AnalyzerTestHygieneRepair.evaluate();
    expect(result.phase, GaussQ363R1AnalyzerTestHygieneRepairPolicy.phase);
    expect(result.sourcePhase, GaussQ363R1AnalyzerTestHygieneRepairPolicy.sourcePhase);
    expect(result.preservesQ363AsActiveProductPhase, isTrue);
    expect(result.repairsAnalyzerCompilationErrors, isTrue);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q363r1 does not mutate runtime or protected UI surfaces', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));
    expect(mainActivity, contains('private val q361FeatureEnabled = false'));
    expect(mainActivity, isNot(contains('q363r1')));

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
