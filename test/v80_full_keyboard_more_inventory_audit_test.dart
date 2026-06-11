import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/editor/render/math_tex_serializer.dart' as render_tex;
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';
import 'package:mathpro_flutter_phase17/logic/key_handlers.dart';
import 'package:mathpro_flutter_phase17/state/calculator_actions.dart';

void main() {
  group('MathPro V80 full keyboard + MORE inventory audit', () {
    test('audits every public keyboard, long-press, and MORE label without programmer-token leaks', () {
      expect(MathKeyInventory.keyboardLabels, containsAll(<String>{'MORE', 'Ans', '↵', '=', 'sin', 'cos', 'tan', 'log'}));
      expect(MathKeyInventory.longPressLabels, containsAll(<String>{'√□', '∛□', '□√□', '∫□dx', '∫ₐᵇ', 'sin⁻¹(□)', 'cos⁻¹(□)', 'tan⁻¹(□)'}));
      expect(MathKeyInventory.moreLabels, containsAll(<String>{'log₁₀(□)', 'log₂(□)', 'log_□(□)', 'cot(□)', 'cot⁻¹(□)', 'sec(□)', 'csc(□)'}));
      expect(MathKeyInventory.publicUiLabels.length, greaterThan(120));
      expect(MathKeyInventory.publicUiProgrammerTokenLeaks, isEmpty);
      expect(MathKeyInventory.structuralEntriesWithLeakedProgrammerTokens, isEmpty);
    });

    test('keeps frozen keyboard envelopes while expanding the audit surface', () {
      expect(KeyConfig.tabs, equals(<String>['Temel', 'Cebir', 'Kalkülüs', 'Kompleks', 'Lineer Cebir']));
      expect(KeyConfig.basicCoreKeyboard.last, equals(<String?>['MORE', '0', '.', 'Ans']));
      expect(KeyConfig.getLongPressOptions('√□', 'Cebir'), equals(<String>['√□', '∛□', '□√□']));
      expect(KeyConfig.getLongPressOptions('∫□dx', 'Kalkülüs'), equals(<String>['∫□dx', '∫ₐᵇ', '∬', '∭', '∮']));
    });

    test('MORE trig labels use mathematical notation and structural template actions', () {
      final trigLabels = ActionUtils.morePanelCategories.firstWhere((category) => category.title == 'Trig').labels;
      expect(trigLabels, containsAll(<String>[
        'sin⁻¹(□)',
        'cos⁻¹(□)',
        'tan⁻¹(□)',
        'cot(□)',
        'cot⁻¹(□)',
        'sec(□)',
        'csc(□)',
        'coth(□)',
      ]));
      expect(trigLabels, isNot(contains('asin(□)')));
      expect(trigLabels, isNot(contains('acos(□)')));
      expect(trigLabels, isNot(contains('atan(□)')));
      expect(trigLabels, isNot(contains('acot')));

      for (final label in trigLabels.where((label) => label.contains('□') || label.contains('⁻¹'))) {
        expect(KeyHandlers.actionForLabel(label), isA<InsertTemplateAction>(), reason: label);
        final spec = ActionUtils.templateSpecForStructure(label);
        expect(spec.expression, contains('□'), reason: label);
        expect(spec.focusRole, 'functionArgument', reason: label);
      }
    });

    test('high-risk visible templates parse to real nodes and slots instead of raw labels', () {
      final expectations = <String, MathNodeKind>{
        'x_□': MathNodeKind.subscript,
        'y_□': MathNodeKind.subscript,
        'I_□': MathNodeKind.subscript,
        'log₁₀(□)': MathNodeKind.logBase,
        'log₂(□)': MathNodeKind.logBase,
        'log₍□₎(□)': MathNodeKind.logBase,
        'sin⁻¹(□)': MathNodeKind.functionCall,
        'cos⁻¹(□)': MathNodeKind.functionCall,
        'tan⁻¹(□)': MathNodeKind.functionCall,
        'cot⁻¹(□)': MathNodeKind.functionCall,
        'sec(□)': MathNodeKind.functionCall,
        'csc(□)': MathNodeKind.functionCall,
        '√(□)': MathNodeKind.sqrt,
        '□⁄□': MathNodeKind.fraction,
        '[□ □; □ □]': MathNodeKind.matrix,
        '[□; □; □]': MathNodeKind.vector,
      };

      for (final item in expectations.entries) {
        final root = NodeFactory.rootFromExpression(item.key);
        expect(root.children, isNotEmpty, reason: item.key);
        expect(root.children.first.kind, item.value, reason: item.key);
        final registry = SlotRegistry.build(root);
        expect(registry.entries, isNotEmpty, reason: item.key);
        expect(EditorTexSerializer.serialize(root), isNot(contains('asin')), reason: item.key);
        expect(EditorTexSerializer.serialize(root), isNot(contains('acos')), reason: item.key);
        expect(EditorTexSerializer.serialize(root), isNot(contains('atan')), reason: item.key);
      }
    });



    test('legacy string renderer also preserves inverse trig display notation before superscript cleanup', () {
      expect(render_tex.MathTexSerializer.toTex('sin⁻¹(□)'), r'\sin^{-1}\left(\Box\right)');
      expect(render_tex.MathTexSerializer.toTex('cot⁻¹(□)'), r'\cot^{-1}\left(\Box\right)');
      expect(render_tex.MathTexSerializer.toTex('sec(□)'), r'\sec\left(\Box\right)');
    });
    test('all public placeholder labels route to editable-slot template expressions unless they are postfix operators', () {
      final problematic = <String>[];
      for (final entry in MathKeyInventory.entries) {
        final visiblePlaceholder = entry.label.contains('□');
        if (!visiblePlaceholder) continue;
        if (entry.behavior == KeyBehaviorType.postfix) continue;
        if (!entry.templateExpression.contains('□')) {
          problematic.add('${entry.label} -> ${entry.templateExpression} from ${entry.sources.join(',')}');
        }
      }
      expect(problematic, isEmpty);
    });
  });
}
