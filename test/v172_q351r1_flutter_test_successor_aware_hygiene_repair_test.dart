import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q351_flutter_test_successor_aware_hygiene_repair_q351r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q351_flutter_test_successor_aware_hygiene_repair_q351r1_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q351r1 records Flutter test hygiene repair while preserving active Q351 product gate', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q351r1 = manifest['v172Q351R1FlutterTestSuccessorAwareHygieneRepair'] as Map<String, dynamic>;

    expect(manifest['q351R1FlutterTestSuccessorAwareHygieneRepairLatestPhase'],
        GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.phase);
    expect(<String>{
      q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
      q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}, contains(manifest['cameraOcrLatestPhase']));
    expect(<String>{
      q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase,
      q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGatePhase,
    'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',}, contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(q351r1['phase'], GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.phase);
    expect(q351r1['sourcePhase'], GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.sourcePhase);
    expect(q351r1['successorAwarenessRepair'], isTrue);
    expect(q351r1['runtimeMarkerExpectationRepair'], isTrue);
    expect(q351r1['generatedBuildArtifactExclusionRepair'], isTrue);
    expect(q351r1['modelLoadAttempted'], isFalse);
    expect(q351r1['ocrPassClaimed'], isFalse);
  });

  test('q351r1 Dart contract exposes hygiene-only repair', () {
    final result = GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1.evaluate();
    expect(result.phase, GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.phase);
    expect(result.sourcePhase, GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.sourcePhase);
    expect(result.preservedCameraOcrLatestPhase, q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase);
    expect(result.successorAwarenessRepair, isTrue);
    expect(result.generatedBuildArtifactExclusionRepair, isTrue);
    expect(result.runtimeMarkerExpectationRepair, isTrue);
    expect(result.mainActivityChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.modelLoadAttempted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
