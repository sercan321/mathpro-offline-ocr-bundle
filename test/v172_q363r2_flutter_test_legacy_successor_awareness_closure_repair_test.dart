import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r2_flutter_test_legacy_successor_awareness_closure_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_q363r2_flutter_test_legacy_successor_awareness_closure_repair_policy.dart';

void main() {
  test('q363r2 records legacy successor-awareness closure repair without advancing product phase', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q363r2 = manifest['v172Q363R2FlutterTestLegacySuccessorAwarenessClosureRepair'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepairPolicy.sourcePhase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepairPolicy.sourcePhase);
    expect(manifest['q363R2FlutterTestLegacySuccessorAwarenessClosureRepairLatestPhase'],
        GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepairPolicy.phase);
    expect(q363r2['phase'], GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepairPolicy.phase);
    expect(q363r2['sourcePhase'], GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepairPolicy.sourcePhase);
    expect(q363r2['repairsFlutterTestFailures'], isTrue);
    expect(q363r2['repairsLegacyQ322ToQ352SuccessorAwareness'], isTrue);
    expect(q363r2['repairsQ344ToQ351R2SuccessorAwareness'], isTrue);
    expect(q363r2['modifiesMainActivity'], isFalse);
    expect(q363r2['modifiesGradle'], isFalse);
    expect(q363r2['modelLoadAttempted'], isFalse);
    expect(q363r2['ocrPassClaimed'], isFalse);
  });

  test('q363r2 Dart contract exposes hygiene-only closure repair', () {
    final result = GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepair.evaluate();
    expect(result.phase, GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepairPolicy.phase);
    expect(result.sourcePhase, GaussQ363R2FlutterTestLegacySuccessorAwarenessClosureRepairPolicy.sourcePhase);
    expect(result.preservesQ363AsActiveProductPhase, isTrue);
    expect(result.repairsFlutterTestFailures, isTrue);
    expect(result.repairsStorePrivacyFinalReleaseGateAcceptance, isTrue);
    expect(result.modifiesRuntimeBridge, isFalse);
    expect(result.modifiesUiRedlines, isFalse);
    expect(result.modelBundled, isFalse);
    expect(result.ocrPassClaimed, isFalse);
    expect(result.storeReadyPassClaimed, isFalse);
    expect(result.releaseReadyPassClaimed, isFalse);
  });
}
