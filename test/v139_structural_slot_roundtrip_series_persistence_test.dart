import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';
import 'package:mathpro_flutter_phase17/logic/action_utils.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V139 structural slot round-trip and series persistence audit', () {
    test('package metadata is current and stale V138 active markers are not authoritative', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final readmeHead = File('README.md').readAsStringSync().split('\n').take(8).join('\n');

      expect(MathProPackageContract.phase, startsWith('V')); // current package phase; V139 behavior stays tested below
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(readmeHead, contains(MathProPackageContract.readmeTitle));
      for (final stale in MathProPackageContract.staleVersionMarkers) {
        expect(pubspec, isNot(contains(stale)), reason: stale);
      }
    });

    test('multi-argument function slots round-trip without degrading to a raw single-arg call', () {
      const expression = 'f(□,□)';
      final root = NodeFactory.rootFromExpression(expression);
      final firstArg = SlotRegistry.build(root).entries.firstWhere((slot) => slot.role == 'functionArgument');

      final edited = EditorCommands.replaceSelectedSlot(expression, 'x', activeSlotId: firstArg.id);
      expect(edited, isNotNull);
      expect(edited, 'f(x,□)');

      final editedRoot = NodeFactory.rootFromExpression(edited!);
      final roles = SlotRegistry.build(editedRoot).entries.map((slot) => slot.role).toSet();
      expect(roles, contains('functionArgument'));
      expect(roles, contains('functionArgument2'));
      expect(EditorTexSerializer.serialize(editedRoot), r'f\left(x,\Box\right)');
    });

    test('composition call slot round-trips as function composition, not fog/raw text', () {
      const expression = '(f∘g)(□)';
      final root = NodeFactory.rootFromExpression(expression);
      final slot = SlotRegistry.build(root).entries.firstWhere((entry) => entry.role == 'functionArgument');

      final edited = EditorCommands.replaceSelectedSlot(expression, 'x', activeSlotId: slot.id);
      expect(edited, '(f∘g)(x)');

      final editedRoot = NodeFactory.rootFromExpression(edited!);
      expect(editedRoot.children.single.kind, MathNodeKind.functionCall);
      expect(EditorTexSerializer.serialize(editedRoot), contains(r'\circ'));
      expect(EditorTexSerializer.serialize(editedRoot), isNot(contains('fog')));
    });

    test('Taylor series slot edits remain semantic SeriesNode structures', () {
      final expression = ActionUtils.templateForStructure('Taylor');
      final root = NodeFactory.rootFromExpression(expression);
      expect(root.children.single.kind, MathNodeKind.series);
      final variableSlot = SlotRegistry.build(root).entries.firstWhere((slot) => slot.role == 'seriesVariable');

      final edited = EditorCommands.replaceSelectedSlot(expression, 'x', activeSlotId: variableSlot.id);
      expect(edited, isNotNull);
      expect(edited!, contains('f(x)='));

      final editedRoot = NodeFactory.rootFromExpression(edited);
      expect(editedRoot.children.single.kind, MathNodeKind.series);
      final roles = SlotRegistry.build(editedRoot).entries.map((slot) => slot.role).toSet();
      expect(roles, contains('seriesVariable'));
      expect(roles, contains('seriesIndex'));
      expect(roles, contains('seriesOrder'));
      final tex = EditorTexSerializer.serialize(editedRoot);
      expect(tex, contains(r'\sum_'));
      expect(tex, contains(r'\frac'));
    });

    test('Maclaurin and geometric series filled forms parse back as SeriesNode structures', () {
      final cases = <String, Set<String>>{
        'f(x)=Σn₌₀∞(f⁽n⁾(0)⁄n!)x^n': <String>{'seriesVariable', 'seriesIndex', 'seriesOrder', 'seriesFactorial'},
        'Σn₌₀∞a·r^n=a⁄(1-r)': <String>{'seriesIndex', 'seriesCoefficient', 'seriesRatio', 'seriesOrder'},
      };

      for (final entry in cases.entries) {
        final root = NodeFactory.rootFromExpression(entry.key);
        expect(root.children.single.kind, MathNodeKind.series, reason: entry.key);
        final roles = SlotRegistry.build(root).entries.map((slot) => slot.role).toSet();
        for (final role in entry.value) {
          expect(roles, contains(role), reason: '${entry.key} roles=$roles');
        }
        expect(EditorTexSerializer.serialize(root), contains(r'\sum_'), reason: entry.key);
      }
    });
  });
}
