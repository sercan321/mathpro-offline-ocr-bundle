import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/selection_controller.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/deterministic_slot_geometry_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/digit_level_caret_stop_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q40 digit-level caret stops', () {
    test('Q40 lineage remains protected after later Q48 repairs without final +95 PASS claim', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q40 Digit-Level Caret Stops'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.auditTitle, contains('Closure'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.nextPhase, contains('Native SlotBox Painter'));
    });

    test('policy declares digit-gap precision without fake renderer-glyph identity', () {
      expect(DigitLevelCaretStopPolicy.version, contains('v172q40'));
      expect(DigitLevelCaretStopPolicy.p6VisualFilesLocked, isTrue);
      expect(DigitLevelCaretStopPolicy.digitLevelCaretStopsAvailable, isTrue);
      expect(DigitLevelCaretStopPolicy.digitRunMidpointSelectionEnabled, isTrue);
      expect(DigitLevelCaretStopPolicy.structuralBoundarySnapSuppressedInsideDigitRuns, isTrue);
      expect(DigitLevelCaretStopPolicy.rendererGlyphIdentityClaimed, isFalse);
      expect(DigitLevelCaretStopPolicy.requiredCorrectDigitTapSelectionsPerTwenty, 19);
    });

    test('numeric runs expose caret gaps for long filled arguments', () {
      final runs = DigitLevelCaretStopPolicy.numericRuns('cos(99666655)+sin(300)');
      expect(runs.map((r) => '${r.start}-${r.end}'), contains('4-12'));
      expect(runs.map((r) => '${r.start}-${r.end}'), contains('18-21'));
    });

    test('caret controller prefers digit run gaps inside cos(99666655)', () {
      const expression = 'cos(99666655)';
      const canvasSize = Size(420, 160);
      final positions = MathProCaretController.linearCaretPositionsForExpression(
        expression: expression,
        canvasSize: canvasSize,
      );
      final betweenSecondAndThirdDigit = (positions[6] + positions[7]) / 2;
      final index = MathProCaretController.closestLinearCaretIndex(
        expression: expression,
        canvasSize: canvasSize,
        point: Offset(betweenSecondAndThirdDigit, 70),
      );
      expect(index, 6);
    });

    test('deterministic geometry registry advertises Q40 digit caret availability', () {
      expect(DeterministicSlotGeometryRegistry.version, contains('v172q40'));
      expect(DeterministicSlotGeometryRegistry.digitLevelCaretStopsAvailable, isTrue);
      expect(DeterministicSlotGeometryRegistry.digitRunMidpointSelectionEnabled, isTrue);
      expect(DeterministicSlotGeometryRegistry.structuralBoundarySnapSuppressedInsideDigitRuns, isTrue);
    });
  });
}
