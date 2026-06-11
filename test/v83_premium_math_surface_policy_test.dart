import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_key_specs.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_surface_policy.dart';

void main() {
  group('MathPro V83 premium math surface policy', () {
    test('centralizes public display labels for keyboard, long-press, and MORE surfaces', () {
      expect(PremiumMathSurfacePolicy.canonicalDisplayLabel('asin(□)'), 'sin⁻¹(□)');
      expect(PremiumMathSurfacePolicy.canonicalDisplayLabel('acos(□)'), 'cos⁻¹(□)');
      expect(PremiumMathSurfacePolicy.canonicalDisplayLabel('atan(□)'), 'tan⁻¹(□)');
      expect(PremiumMathSurfacePolicy.canonicalDisplayLabel('acot(□)'), 'cot⁻¹(□)');
      expect(PremiumMathSurfacePolicy.canonicalDisplayLabel('logₙ()'), 'log_□(□)');
      expect(PremiumMathSurfacePolicy.canonicalDisplayLabel('| |'), '|□|');
      expect(PremiumMathSurfacePolicy.canonicalDisplayLabel('frac'), '□/□');
    });

    test('has no programmer-token leaks in public keyboard, long-press, or MORE inventory', () {
      expect(MathKeyInventory.publicUiProgrammerTokenLeaks, isEmpty);
      for (final label in MathKeyInventory.publicUiLabels) {
        expect(PremiumMathSurfacePolicy.isInternalProgrammerLabel(label), isFalse, reason: label);
      }
    });

    test('classifies every spec-backed public label as a premium math surface', () {
      for (final entry in MathKeyInventory.specBackedPublicEntries) {
        expect(PremiumMathSurfacePolicy.isMathSurface(entry.label), isTrue, reason: entry.label);
        expect(PremiumMathSurfacePolicy.canonicalDisplayLabel(entry.label), isNot(contains('asin')), reason: entry.label);
        expect(PremiumMathSurfacePolicy.canonicalDisplayLabel(entry.label), isNot(contains('acos')), reason: entry.label);
        expect(PremiumMathSurfacePolicy.canonicalDisplayLabel(entry.label), isNot(contains('atan')), reason: entry.label);
      }
    });

    test('keeps critical visible surfaces in the math renderer path rather than plain text chips', () {
      const critical = <String>[
        'sin',
        'cos',
        'tan',
        'ln',
        'log',
        'log_□(□)',
        'sin⁻¹(□)',
        'x_□',
        '□/□',
        '√□',
        '∫□dx',
        '∫ₐᵇ',
        'd/dx(□)',
        'lim x→□',
        'Σ',
        'Π',
        '[□ □]',
        '[□]',
        'det(□)',
        '□·□',
        '□×□',
        '‖□‖',
      ];

      for (final label in critical) {
        expect(PremiumMathSurfacePolicy.isMathSurface(label), isTrue, reason: label);
        expect(PremiumMathSurfacePolicy.longPressChipWidth(label), greaterThanOrEqualTo(104));
      }
    });

    test('keeps MORE and long-press chip metrics wide enough for premium math notation', () {
      for (final label in <String>['log_□(□)', 'sin⁻¹(□)', 'cosh⁻¹(□)', 'd²/dx²(□)', '∂²/∂x²(□)', 'Maclaurin']) {
        expect(PremiumMathSurfacePolicy.longPressChipWidth(label), greaterThanOrEqualTo(118), reason: label);
      }
      for (final label in <String>['log_□(□)', 'lim sin(x)/x', '2×2 Matris', 'nD vektör']) {
        expect(PremiumMathSurfacePolicy.moreChipMinWidth(label, compact: false), greaterThanOrEqualTo(58), reason: label);
      }
    });

    test('does not alter frozen keyboard topology or long-press contracts', () {
      expect(KeyConfig.tabs, equals(<String>['Temel', 'Cebir', 'Kalkülüs', 'Kompleks', 'Lineer Cebir']));
      expect(KeyConfig.basicCoreKeyboard.last, equals(<String?>['MORE', '0', '.', 'Ans']));
      expect(KeyConfig.getLongPressOptions('√□', 'Temel'), equals(<String>['√□', '∛□', '□√□']));
      expect(KeyConfig.getLongPressOptions('∫□dx', 'Kalkülüs'), equals(<String>['∫□dx', '∫ₐᵇ', '∬', '∭', '∮']));
      expect(PremiumMathKeySpecs.duplicateLabels, isEmpty);
      expect(ActionUtils.morePanelCategories.map((category) => category.title), containsAll(<String>['Yapı', 'Fonksiyon', 'Trig', 'Kalkülüs', 'Ayrık', 'Kompleks', 'Lineer']));
    });
  });
}
