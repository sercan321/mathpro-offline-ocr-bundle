import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/math_template_contract_registry.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';

void main() {
  group('V132 central template registry foundation', () {
    test('high-risk public labels resolve through the central contract registry first', () {
      const labels = <String>[
        '□!',
        '□ᵀ',
        '□⁻¹',
        '□ᴴ',
        '□C□',
        '□P□',
        'f(□,□)',
        'f∘g',
        'sin⁻¹(□)',
        'cos⁻¹(□)',
        'tan⁻¹(□)',
        'lim',
        '∫□dx',
        '∫ₐᵇ',
        'Σ',
        'Π',
        'Taylor',
      ];

      for (final label in labels) {
        final contract = MathTemplateContractRegistry.contractFor(label);
        expect(contract, isNotNull, reason: '$label must be backed by the central registry');
        final actionSpec = ActionUtils.templateSpecForStructure(label);
        expect(actionSpec.expression, contract!.expression, reason: '$label must use the registry expression');
        expect(actionSpec.focusRole, contract.focusRole, reason: '$label must use the registry focus role');
      }
    });

    test('slot-backed postfix and binary templates expose real slot roles after parsing', () {
      final samples = <String, Set<String>>{
        '□!': <String>{'postfixTarget'},
        '□ᵀ': <String>{'postfixTarget'},
        '□⁻¹': <String>{'postfixTarget'},
        '□ᴴ': <String>{'postfixTarget'},
        '□C□': <String>{'functionArgument', 'functionArgument2'},
        '□P□': <String>{'functionArgument', 'functionArgument2'},
      };

      for (final entry in samples.entries) {
        final root = NodeFactory.rootFromExpression(ActionUtils.templateForStructure(entry.key));
        final registry = SlotRegistry.fromRoot(root);
        final roles = registry.entries.map((slot) => slot.role).toSet();
        expect(roles.containsAll(entry.value), isTrue, reason: '${entry.key} roles: $roles');
      }
    });

    test('function composition and multi-argument functions are structural function calls', () {
      final twoArg = NodeFactory.rootFromExpression(ActionUtils.templateForStructure('f(□,□)'));
      final twoArgFunction = twoArg.children.singleWhere((node) => node.kind == MathNodeKind.functionCall);
      expect(twoArgFunction.operator, 'f');
      expect(twoArgFunction.slots.keys.toSet(), containsAll(<String>{'arg_0', 'arg_1'}));
      expect(SlotRegistry.fromRoot(twoArg).entries.map((slot) => slot.role).toSet(), containsAll(<String>{'functionArgument', 'functionArgument2'}));

      final composition = NodeFactory.rootFromExpression(ActionUtils.templateForStructure('f∘g'));
      final compositionFunction = composition.children.singleWhere((node) => node.kind == MathNodeKind.functionCall);
      expect(compositionFunction.operator, 'f∘g');
      expect(SlotRegistry.fromRoot(composition).entries.map((slot) => slot.role).toSet(), contains('functionArgument'));
      expect(TexSerializer.serialize(composition), contains(r'\circ'));
      expect(MathTexSerializer.toTex(ActionUtils.templateForStructure('f∘g')), contains(r'\circ'));
    });

    test('inventory treats registry-backed public labels as spec-backed rather than stale gaps', () {
      final labels = MathKeyInventory.contractBackedPublicEntries.map((entry) => entry.label).toSet();
      expect(labels, contains('f∘g'));
      expect(labels, contains('□!'));
      expect(labels, contains('lim'));
      expect(labels, contains('Taylor'));
      expect(MathKeyInventory.missingPhase04RequiredSpecLabels, isNot(contains('f∘g')));
      expect(MathKeyInventory.missingPhase04RequiredSpecLabels, isNot(contains('□C□')));
    });
  });
}
