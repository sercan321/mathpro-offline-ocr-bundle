import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/log_root_precision_cursor_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q39 log/root precision engine', () {
    test('Q39 lineage remains protected after later Q48 repairs without final +95 PASS claim', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q39 Log Root Precision Engine'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.auditTitle, contains('Closure'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.nextPhase, contains('Native SlotBox Painter'));
    });

    test('policy declares log/root split without cross-lane selection', () {
      expect(LogRootPrecisionCursorPolicy.version, contains('v172q39'));
      expect(LogRootPrecisionCursorPolicy.p6VisualFilesLocked, isTrue);
      expect(LogRootPrecisionCursorPolicy.logRootPrecisionEngineAvailable, isTrue);
      expect(LogRootPrecisionCursorPolicy.logBaseArgumentLaneSplitEnabled, isTrue);
      expect(LogRootPrecisionCursorPolicy.rootIndexRadicandLaneSplitEnabled, isTrue);
      expect(LogRootPrecisionCursorPolicy.logBaseArgumentCrossLaneSelectionAllowed, isFalse);
      expect(LogRootPrecisionCursorPolicy.rootIndexRadicandCrossLaneSelectionAllowed, isFalse);
      expect(LogRootPrecisionCursorPolicy.requiredCorrectTapSelectionsPerTwenty, 19);
    });

    test('slot hit-test and registry are wired through Q39 without touching P6 UI files', () {
      final slotHit = File('lib/features/formula_engine/slot_hit_testing.dart').readAsStringSync();
      final registry = File('lib/features/formula_engine/deterministic_slot_geometry_registry.dart').readAsStringSync();
      expect(slotHit, contains('LogRootPrecisionCursorPolicy.decideLaneForPoint'));
      expect(slotHit, contains('LogRootPrecisionCursorPolicy.laneAwareHitRect'));
      expect(slotHit, contains('_logRootLaneFilteredCandidates'));
      expect(registry, contains('logRootPrecisionEngineAvailable = true'));
      expect(registry, contains('logBaseArgumentLaneSplitEnabled = true'));
      expect(registry, contains('rootIndexRadicandLaneSplitEnabled = true'));
    });
  });
}
