import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/tex_serializer.dart';

import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
void main() {
  group('V131 template contract cleanup and stale-regression repair', () {
    test('package metadata is current and not stale V129', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec, contains('version: ${MathProPackageContract.version}')); // current package version; V131 behavior stays tested below
      expect(pubspec, contains(MathProPackageContract.pubspecDescription.split(' - ').last)); // top README/pubspec metadata must not stay stale
      expect(pubspec, isNot(contains('version: 0.129.0+129')));
      expect(pubspec, isNot(contains('version: 0.131.0+131')));
      expect(pubspec, isNot(contains('version: 0.132.0+132')));
      expect(pubspec, isNot(contains('version: 0.133.0+133')));
    });

    test('inverse trig templates parse as structural function calls, not postfix fragments', () {
      final root = NodeFactory.rootFromExpression('sin⁻¹(□)+cos⁻¹(□)+tan⁻¹(□)');
      final functions = root.children.where((node) => node.kind == MathNodeKind.functionCall).toList();
      expect(functions.map((node) => node.operator), equals(<String>['sin⁻¹', 'cos⁻¹', 'tan⁻¹']));
      final roles = SlotRegistry.build(root).entries.map((entry) => entry.role).toSet();
      expect(roles, contains('functionArgument'));
      final tex = EditorTexSerializer.serialize(root);
      expect(tex, contains(r'\sin^{-1}\left(\Box\right)'));
      expect(tex, contains(r'\cos^{-1}\left(\Box\right)'));
      expect(tex, contains(r'\tan^{-1}\left(\Box\right)'));
    });

    test('postfix templates expose postfixTarget and serialize with the visible target box', () {
      for (final source in <String>['□!', '□⁻¹', '□ᵀ', '□ᴴ']) {
        final root = NodeFactory.rootFromExpression(source);
        expect(root.children.single.kind, MathNodeKind.postfix, reason: source);
        expect(SlotRegistry.build(root).entries.map((entry) => entry.role), contains('postfixTarget'), reason: source);
        expect(EditorTexSerializer.serialize(root), contains(r'\Box'), reason: source);
      }
    });

    test('log base repair survives function-before-postfix parsing', () {
      final root = NodeFactory.rootFromExpression('log(2)(5)');
      expect(root.children.single.kind, MathNodeKind.logBase);
      expect(EditorTexSerializer.serialize(root), r'\log_{2}\left(5\right)');
    });

    test('multi-argument functions retain separate editable argument slots', () {
      final root = NodeFactory.rootFromExpression('f(□,□)');
      expect(root.children.single.kind, MathNodeKind.functionCall);
      final roles = SlotRegistry.build(root).entries.map((entry) => entry.role).toSet();
      expect(roles, contains('functionArgument'));
      expect(roles, contains('functionArgument2'));
      expect(EditorTexSerializer.serialize(root), r'f\left(\Box,\Box\right)');
    });

    test('limit key glyph was normalized away from the heavy stale form', () {
      final source = File('lib/features/workspace/math_label.dart').readAsStringSync();
      expect(source, contains('class _LimitGlyph'));
      expect(source, contains('fontSize: isChip ? 16.2 : 12.2'));
      expect(source, contains('fontWeight: FontWeight.w500'));
      expect(source, isNot(contains('fontSize: isChip ? 18.5 : 14.2')));
    });
  });
}
