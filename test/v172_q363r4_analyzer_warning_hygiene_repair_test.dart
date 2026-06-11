import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r4_analyzer_warning_hygiene_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r4_analyzer_warning_hygiene_repair_policy.dart';

void main() {
  test('q363r4 records analyzer warning hygiene repair without advancing product phase', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q363r4 = manifest['v172Q363R4AnalyzerWarningHygieneRepair'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussQ363R4AnalyzerWarningHygieneRepairPolicy.sourcePhase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussQ363R4AnalyzerWarningHygieneRepairPolicy.sourcePhase);
    expect(manifest['q363R4AnalyzerWarningHygieneRepairLatestPhase'],
        GaussQ363R4AnalyzerWarningHygieneRepairPolicy.phase);
    expect(q363r4['phase'], GaussQ363R4AnalyzerWarningHygieneRepairPolicy.phase);
    expect(q363r4['sourcePhase'], GaussQ363R4AnalyzerWarningHygieneRepairPolicy.sourcePhase);
    expect(q363r4['repairsDuplicateSetLiteralElements'], isTrue);
    expect(q363r4['removesDuplicateQ363LiteralWhereQ363ConstantAlreadyExists'], isTrue);
    expect(q363r4['repairsAnalyzerWarningsOnly'], isTrue);
    expect(q363r4['modifiesMainActivity'], isFalse);
    expect(q363r4['modifiesGradle'], isFalse);
    expect(q363r4['modelLoadAttempted'], isFalse);
    expect(q363r4['ocrPassClaimed'], isFalse);
  });

  test('q363r4 Dart contract exposes warning cleanup only', () {
    final result = GaussQ363R4AnalyzerWarningHygieneRepair.evaluate();
    expect(result.phase, GaussQ363R4AnalyzerWarningHygieneRepairPolicy.phase);
    expect(result.sourcePhase, GaussQ363R4AnalyzerWarningHygieneRepairPolicy.sourcePhase);
    expect(result.preservesQ363AsActiveProductPhase, isTrue);
    expect(result.repairsDuplicateSetLiteralElements, isTrue);
    expect(result.repairsAnalyzerWarningsOnly, isTrue);
    expect(result.repairsRuntimeBehavior, isFalse);
    expect(result.modifiesRuntimeBridge, isFalse);
    expect(result.modifiesUiRedlines, isFalse);
    expect(result.modelBundled, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.storeReadyPassClaimed, isFalse);
    expect(result.releaseReadyPassClaimed, isFalse);
  });
}
