import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_interaction_calibration_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/template_slot_navigation_policy.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_key_specs.dart';

void main() {
  group('MathPro V82 Phase-04 full surface slot audit', () {
    test('backs every Phase-04 public math surface with a PremiumMathKeySpec', () {
      expect(MathKeyInventory.publicUiProgrammerTokenLeaks, isEmpty);
      expect(PremiumMathKeySpecs.duplicateLabels, isEmpty);
      expect(MathKeyInventory.missingPhase04RequiredSpecLabels, isEmpty);
      expect(MathKeyInventory.phase04RequiredSpecEntriesWithoutSpecs, isEmpty);
    });

    test('routes Phase-04 spec-backed labels through canonical expressions instead of raw UI strings', () {
      for (final entry in MathKeyInventory.phase04RequiredSpecEntries) {
        final spec = PremiumMathKeySpecs.specFor(entry.label)!;
        final actionSpec = ActionUtils.templateSpecForStructure(entry.label);
        expect(actionSpec.expression, spec.expression, reason: entry.label);
        expect(actionSpec.focusRole, spec.focusRole, reason: entry.label);
        expect(actionSpec.expression, isNot(contains('asin(')), reason: entry.label);
        expect(actionSpec.expression, isNot(contains('acos(')), reason: entry.label);
        expect(actionSpec.expression, isNot(contains('atan(')), reason: entry.label);
        expect(actionSpec.expression, isNot(contains('acot(')), reason: entry.label);
      }
    });

    test('preserves real editable slot roles for all Phase-04 structural specs', () {
      final checked = <String>[];
      for (final spec in PremiumMathKeySpecs.all.where(
        (spec) => MathKeyInventory.phase04RequiredSpecLabels.contains(spec.label) && spec.requiresEditableSlot && !spec.legacyAlias,
      )) {
        final root = NodeFactory.rootFromExpression(spec.expression);
        final registry = SlotRegistry.build(root);
        expect(registry.entries, isNotEmpty, reason: spec.label);
        final roles = registry.entries.map((entry) => entry.role).toSet();
        for (final role in spec.slotRoles) {
          expect(roles, contains(role), reason: '${spec.label} should expose $role via ${spec.expression}');
        }
        checked.add(spec.label);
      }
      expect(checked, containsAll(<String>[
        'x_□',
        'log_□(□)',
        'sin⁻¹(□)',
        '□/□',
        '∫ₐᵇ',
        'Taylor',
        '2×2',
        '3D vektör',
        'projeksiyon',
      ]));
    });

    test('prioritizes tiny premium math slots for comfortable mobile hit-testing', () {
      const criticalRoles = <String>[
        'subscript',
        'logBase',
        'derivativeOrder',
        'powerExponent',
        'rootIndex',
        'integralUpperLimit',
        'integralLowerLimit',
        'fractionNumerator',
        'fractionDenominator',
        'matrixCell',
      ];

      for (final role in criticalRoles) {
        expect(
          SlotInteractionCalibrationPolicy.minTouchSizeForRole(role, 0),
          greaterThanOrEqualTo(role == 'matrixCell' ? 72.0 : 76.0),
          reason: role,
        );
        expect(SlotInteractionCalibrationPolicy.nearestFallbackRadiusForRole(role), greaterThanOrEqualTo(50.0), reason: role);
      }
    });

    test('orders visible slots by user intent for log, subscript, fraction, and integral templates', () {
      final logRoles = TemplateSlotNavigationPolicy
          .orderedSlots(SlotRegistry.build(NodeFactory.rootFromExpression('log₍□₎(□)')).entries)
          .map((slot) => slot.role)
          .toList();
      expect(logRoles.indexOf('logBase'), lessThan(logRoles.indexOf('functionArgument')));

      final subscriptRoles = TemplateSlotNavigationPolicy
          .orderedSlots(SlotRegistry.build(NodeFactory.rootFromExpression('x_□')).entries)
          .map((slot) => slot.role)
          .toList();
      expect(subscriptRoles.first, 'subscript');

      final fractionRoles = TemplateSlotNavigationPolicy
          .orderedSlots(SlotRegistry.build(NodeFactory.rootFromExpression('□⁄□')).entries)
          .map((slot) => slot.role)
          .toList();
      expect(fractionRoles.take(2).toList(growable: false), equals(<String>['fractionNumerator', 'fractionDenominator']));

      final integralRoles = TemplateSlotNavigationPolicy
          .orderedSlots(SlotRegistry.build(NodeFactory.rootFromExpression('∫_{□}^{□}(□)d□')).entries)
          .map((slot) => slot.role)
          .toList();
      expect(integralRoles, containsAll(<String>['integralLowerLimit', 'integralUpperLimit', 'integralBody', 'integralDifferential']));
    });
  });
}
