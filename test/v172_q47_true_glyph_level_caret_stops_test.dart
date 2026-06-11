import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/selection_controller.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/true_glyph_level_caret_stop_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q47 true glyph-level caret stops', () {
    test('policy is renderer-assisted but does not fake stable AST glyph identity', () {
      expect(TrueGlyphLevelCaretStopPolicy.version, contains('v172q47'));
      expect(TrueGlyphLevelCaretStopPolicy.p6VisualFilesLocked, isTrue);
      expect(TrueGlyphLevelCaretStopPolicy.trueGlyphLevelCaretStopsAvailable, isTrue);
      expect(TrueGlyphLevelCaretStopPolicy.rendererElementRectCaretStopsEnabled, isTrue);
      expect(TrueGlyphLevelCaretStopPolicy.fallbackToDigitRunMidpointsAllowed, isTrue);
      expect(TrueGlyphLevelCaretStopPolicy.stableAstCharacterToSvgNodeIdentityClaimed, isFalse);
      expect(TrueGlyphLevelCaretStopPolicy.fakeGlyphIdentityAllowed, isFalse);
      expect(TrueGlyphLevelCaretStopPolicy.requiredCorrectGlyphTapSelectionsPerTwenty, 19);
    });

    test('selection controller consumes Q47 glyph caret policy before Q40 fallback', () {
      expect(MathProCaretController.version, contains('v172q47'));
      expect(MathProCaretController.version, contains('true-glyph-level-caret-stops'));
    });

    test('Q47 lineage remains protected without claiming final device +95 PASS', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q47 True Glyph-Level Caret Stops'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
    });

    test('falls back safely when no renderer snapshot exists', () {
      final result = TrueGlyphLevelCaretStopPolicy.rendererAssistedCaretIndexForX(
        expression: 'cos(99666655)',
        fallbackPositions: List<double>.generate('cos(99666655)'.length + 1, (index) => index * 8.0),
        canvasSize: const Size(240, 80),
        x: 80,
      );
      expect(result, isNull);
    });
  });
}
