import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';

void main() {
  group('MathPro V79 premium math editor engine phase 01', () {
    test('long-press and MORE expose inverse trig as math notation, not programmer tokens', () {
      expect(KeyConfig.getLongPressOptions('sin', 'Temel'), equals(<String>['sin(□)', 'sin⁻¹(□)', 'sinh(□)', 'sinh⁻¹(□)']));
      expect(KeyConfig.getLongPressOptions('cos', 'Temel'), equals(<String>['cos(□)', 'cos⁻¹(□)', 'cosh(□)', 'cosh⁻¹(□)']));
      expect(KeyConfig.getLongPressOptions('tan', 'Temel'), equals(<String>['tan(□)', 'tan⁻¹(□)', 'tanh(□)', 'tanh⁻¹(□)']));

      final trig = ActionUtils.morePanelCategories.firstWhere((category) => category.title == 'Trig').labels;
      expect(trig, containsAll(<String>['sin⁻¹(□)', 'cos⁻¹(□)', 'tan⁻¹(□)', 'sinh⁻¹(□)', 'cosh⁻¹(□)', 'tanh⁻¹(□)']));
      expect(trig, isNot(contains('asin(□)')));
      expect(trig, isNot(contains('acos(□)')));
      expect(trig, isNot(contains('atan(□)')));
    });

    test('subscript templates are structural nodes with editable subscript slots', () {
      final root = NodeFactory.rootFromExpression('x_□');
      final subscript = root.children.single;
      expect(subscript.kind, MathNodeKind.subscript);
      expect(SlotRegistry.build(root).entries.map((entry) => entry.role), contains('subscript'));
      expect(EditorTexSerializer.serialize(root), r'{x}_{\Box}');
    });

    test('log templates are structural log-base nodes with base and argument slots', () {
      final root = NodeFactory.rootFromExpression('log_□(□)');
      final log = root.children.single;
      expect(log.kind, MathNodeKind.logBase);
      final roles = SlotRegistry.build(root).entries.map((entry) => entry.role).toSet();
      expect(roles, containsAll(<String>{'logBase', 'functionArgument'}));
      expect(EditorTexSerializer.serialize(root), r'\log_{\Box}\left(\Box\right)');
    });

    test('inverse trig templates are structural FunctionNode display forms', () {
      final root = NodeFactory.rootFromExpression('sin⁻¹(□)+cos⁻¹(□)+tan⁻¹(□)');
      final functionNodes = root.children.where((node) => node.kind == MathNodeKind.functionCall).toList();
      expect(functionNodes.map((node) => node.operator), equals(<String>['sin⁻¹', 'cos⁻¹', 'tan⁻¹']));
      final tex = EditorTexSerializer.serialize(root);
      expect(tex, contains(r'\sin^{-1}\left(\Box\right)'));
      expect(tex, contains(r'\cos^{-1}\left(\Box\right)'));
      expect(tex, contains(r'\tan^{-1}\left(\Box\right)'));
    });
  });
}
