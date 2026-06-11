import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart' as legacy_tex;
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_key_specs.dart';

void main() {
  group('MathPro V81 premium MathKeySpec core migration', () {
    test('keeps the frozen keyboard shell while moving math semantics behind it', () {
      expect(KeyConfig.tabs, equals(<String>['Temel', 'Cebir', 'Kalkülüs', 'Kompleks', 'Lineer Cebir']));
      expect(KeyConfig.basicCoreKeyboard.last, equals(<String?>['MORE', '0', '.', 'Ans']));
      expect(KeyConfig.getLongPressOptions('√□', 'Temel'), equals(<String>['√□', '∛□', '□√□']));
      expect(KeyConfig.getLongPressOptions('∫□dx', 'Kalkülüs'), equals(<String>['∫□dx', '∫ₐᵇ', '∬', '∭', '∮']));
    });

    test('has a duplicate-free PremiumMathKeySpec source of truth for risky math surfaces', () {
      expect(PremiumMathKeySpecs.duplicateLabels, isEmpty);
      expect(PremiumMathKeySpecs.labels, containsAll(<String>{
        'x_□',
        'log_□(□)',
        'sin⁻¹(□)',
        'cos⁻¹(□)',
        'tan⁻¹(□)',
        '√□',
        '□/□',
        '∫ₐᵇ',
        '2×2',
        '3D vektör',
      }));
      expect(MathKeyInventory.publicUiProgrammerTokenLeaks, isEmpty);
      expect(MathKeyInventory.specBackedPublicEntries.length, greaterThan(50));
      final missingCritical = MathKeyInventory.protectedSurfaceEntriesWithoutSpecs
          .where((entry) => <String>{'x_□', 'y_□', 'I_□', 'log_□(□)', 'sin⁻¹(□)', 'cos⁻¹(□)', 'tan⁻¹(□)', '√□', '□/□', '∫ₐᵇ'}.contains(entry.label))
          .map((entry) => entry.label)
          .toList();
      expect(missingCritical, isEmpty);
    });

    test('routes spec-backed public labels through canonical template specs', () {
      for (final entry in MathKeyInventory.specBackedPublicEntries) {
        final spec = PremiumMathKeySpecs.specFor(entry.label)!;
        final actionSpec = ActionUtils.templateSpecForStructure(entry.label);
        expect(actionSpec.expression, spec.expression, reason: entry.label);
        expect(actionSpec.focusRole, spec.focusRole, reason: entry.label);
        expect(actionSpec.expression, isNot(contains('asin(')), reason: entry.label);
        expect(actionSpec.expression, isNot(contains('acos(')), reason: entry.label);
        expect(actionSpec.expression, isNot(contains('atan(')), reason: entry.label);
      }
    });

    test('parses high-risk specs as real nodes with real editable slots', () {
      final cases = <String, MathNodeKind>{
        'x_□': MathNodeKind.subscript,
        'y_□': MathNodeKind.subscript,
        'I_□': MathNodeKind.subscript,
        '□⁄□': MathNodeKind.fraction,
        '√(□)': MathNodeKind.sqrt,
        '³√(□)': MathNodeKind.indexedRoot,
        '□√(□)': MathNodeKind.indexedRoot,
        '□^(□)': MathNodeKind.power,
        '|□|': MathNodeKind.functionCall,
        '‖□‖': MathNodeKind.functionCall,
        '⌊□⌋': MathNodeKind.functionCall,
        '⌈□⌉': MathNodeKind.functionCall,
        'sin⁻¹(□)': MathNodeKind.functionCall,
        'cos⁻¹(□)': MathNodeKind.functionCall,
        'tan⁻¹(□)': MathNodeKind.functionCall,
        'cot⁻¹(□)': MathNodeKind.functionCall,
        'log(□)': MathNodeKind.functionCall,
        'log₁₀(□)': MathNodeKind.logBase,
        'log₂(□)': MathNodeKind.logBase,
        'log₍□₎(□)': MathNodeKind.logBase,
        'd/dx(□)': MathNodeKind.derivative,
        '∫(□)dx': MathNodeKind.integral,
        '∫_{□}^{□}(□)d□': MathNodeKind.integral,
        'limₓ→□(□)': MathNodeKind.limit,
        'limₓ→∞(□)': MathNodeKind.limit,
        'Σ(□)': MathNodeKind.bigOperator,
        'Π(□)': MathNodeKind.bigOperator,
        '[□ □; □ □]': MathNodeKind.matrix,
        '[□ □ □; □ □ □; □ □ □]': MathNodeKind.matrix,
        '[□; □; □]': MathNodeKind.vector,
        'f(□,□)': MathNodeKind.functionCall,
        'det(□)': MathNodeKind.functionCall,
        'rref(□)': MathNodeKind.functionCall,
      };

      for (final item in cases.entries) {
        final root = NodeFactory.rootFromExpression(item.key);
        expect(root.children, isNotEmpty, reason: item.key);
        expect(root.children.first.kind, item.value, reason: item.key);
        expect(SlotRegistry.build(root).entries, isNotEmpty, reason: item.key);
        final tex = EditorTexSerializer.serialize(root);
        expect(tex, isNot(contains('asin')), reason: item.key);
        expect(tex, isNot(contains('acos')), reason: item.key);
        expect(tex, isNot(contains('atan')), reason: item.key);
      }
    });

    test('legacy renderer still displays public math notation, never programmer tokens', () {
      expect(legacy_tex.MathTexSerializer.toTex('log(□)'), r'\log\left(\Box\right)');
      expect(legacy_tex.MathTexSerializer.toTex('sin⁻¹(□)'), r'\sin^{-1}\left(\Box\right)');
      expect(legacy_tex.MathTexSerializer.toTex('cot⁻¹(□)'), r'\cot^{-1}\left(\Box\right)');
      expect(legacy_tex.MathTexSerializer.toTex('⌊□⌋'), r'\left\lfloor \Box\right\rfloor');
      expect(legacy_tex.MathTexSerializer.toTex('⌈□⌉'), r'\left\lceil \Box\right\rceil');
    });

    test('slot routing metadata is preserved for premium specs with required roles', () {
      for (final spec in PremiumMathKeySpecs.all.where((spec) => spec.requiresEditableSlot && !spec.legacyAlias)) {
        final root = NodeFactory.rootFromExpression(spec.expression);
        final registry = SlotRegistry.build(root);
        expect(registry.entries, isNotEmpty, reason: spec.label);
        final roles = registry.entries.map((entry) => entry.role).toSet();
        for (final requiredRole in spec.slotRoles) {
          expect(roles, contains(requiredRole), reason: '${spec.label} should expose $requiredRole via ${spec.expression}');
        }
      }
    });
  });
}
