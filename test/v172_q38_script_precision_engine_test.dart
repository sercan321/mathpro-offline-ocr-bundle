import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/script_precision_cursor_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_hit_testing.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q38 script precision engine', () {
    test('Q38 lineage remains protected after later Q48 repairs without final +95 PASS claim', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q38 Script Precision Engine'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.auditTitle, contains('Closure'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.nextPhase, contains('Native SlotBox Painter'));
    });

    test('script policy keeps P6 UI locked and demands 19/20 tap precision', () {
      expect(ScriptPrecisionCursorPolicy.version, contains('v172q38'));
      expect(ScriptPrecisionCursorPolicy.p6VisualFilesLocked, isTrue);
      expect(ScriptPrecisionCursorPolicy.scriptPrecisionEngineAvailable, isTrue);
      expect(ScriptPrecisionCursorPolicy.exponentSubscriptLaneSplitEnabled, isTrue);
      expect(ScriptPrecisionCursorPolicy.scriptBaseCrossLaneSelectionAllowed, isFalse);
      expect(ScriptPrecisionCursorPolicy.requiredCorrectTapSelectionsPerTwenty, 19);
    });

    test('power exponent beats base when the tap lands in the upper-right script lane', () {
      final node = NodeFactory.power(baseText: 'x', exponent: NodeFactory.atom('12'));
      final registry = SlotRegistry.fromRoots(<MathNode>[node]);
      final base = registry.entries.firstWhere((entry) => entry.role == 'powerBase');
      final exponent = registry.entries.firstWhere((entry) => entry.role == 'powerExponent');

      final visualRects = <SlotEntry, Rect>{
        base: const Rect.fromLTWH(24, 46, 50, 38),
        exponent: const Rect.fromLTWH(70, 18, 34, 24),
      };
      final result = SlotHitTesting.hitTest(const Offset(88, 24), visualRects);
      expect(result, isNotNull);
      expect(result!.entry.role, 'powerExponent');
    });

    test('subscript beats base when the tap lands in the lower-right script lane', () {
      final node = NodeFactory.subscript(baseText: 'x', subscript: NodeFactory.atom('89'));
      final registry = SlotRegistry.fromRoots(<MathNode>[node]);
      final base = registry.entries.firstWhere((entry) => entry.role == 'subscriptBase');
      final subscript = registry.entries.firstWhere((entry) => entry.role == 'subscript');

      final visualRects = <SlotEntry, Rect>{
        base: const Rect.fromLTWH(24, 30, 50, 38),
        subscript: const Rect.fromLTWH(70, 66, 36, 24),
      };
      final result = SlotHitTesting.hitTest(const Offset(88, 80), visualRects);
      expect(result, isNotNull);
      expect(result!.entry.role, 'subscript');
    });
  });
}
