import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r3_analyzer_syntax_regression_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r3_analyzer_syntax_regression_repair_policy.dart';

void main() {
  test('q363r3 records analyzer syntax regression repair without advancing product phase', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q363r3 = manifest['v172Q363R3AnalyzerSyntaxRegressionRepair'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy.sourcePhase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy.sourcePhase);
    expect(manifest['q363R3AnalyzerSyntaxRegressionRepairLatestPhase'],
        GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy.phase);
    expect(q363r3['phase'], GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy.phase);
    expect(q363r3['sourcePhase'], GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy.sourcePhase);
    expect(q363r3['repairsMalformedQ363R2DartInsertions'], isTrue);
    expect(q363r3['repairsLeadingCommaSyntaxErrors'], isTrue);
    expect(q363r3['repairsMalformedManifestIndexing'], isTrue);
    expect(q363r3['modifiesMainActivity'], isFalse);
    expect(q363r3['modifiesGradle'], isFalse);
    expect(q363r3['modelLoadAttempted'], isFalse);
    expect(q363r3['ocrPassClaimed'], isFalse);
  });

  test('q363r3 Dart contract exposes syntax repair only', () {
    final result = GaussQ363R3AnalyzerSyntaxRegressionRepair.evaluate();
    expect(result.phase, GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy.phase);
    expect(result.sourcePhase, GaussQ363R3AnalyzerSyntaxRegressionRepairPolicy.sourcePhase);
    expect(result.preservesQ363AsActiveProductPhase, isTrue);
    expect(result.repairsMalformedQ363R2DartInsertions, isTrue);
    expect(result.repairsLegacySuccessorAwarenessWithoutRuntimeChanges, isTrue);
    expect(result.modifiesRuntimeBridge, isFalse);
    expect(result.modifiesUiRedlines, isFalse);
    expect(result.modelBundled, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.storeReadyPassClaimed, isFalse);
    expect(result.releaseReadyPassClaimed, isFalse);
  });
}
