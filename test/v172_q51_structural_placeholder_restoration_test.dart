import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/node_factory.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/editor/editor_commands.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_placeholder_restoration_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q51 structural placeholder restoration repair', () {
    test('metadata advances to Q51 without claiming Q52 caret rail or device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageVersions, contains('0.172.80+172'));
      expect(MathProPackageContract.cursorLineageVersions, contains('0.172.82+172'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q51 Structural Placeholder Restoration Repair'));
      expect(MathProPackageContract.q51RepairRule, contains('sin()'));
      expect(MathProPackageContract.q51RepairRule, contains('Q52 owns'));
    });

    test('policy restores half-template strings after deletion', () {
      expect(StructuralPlaceholderRestorationPolicy.structuralPlaceholderRestorationAvailable, isTrue);
      expect(StructuralPlaceholderRestorationPolicy.halfTemplateStringsAllowed, isFalse);
      expect(StructuralPlaceholderRestorationPolicy.caretLeadingRailHandledByQ52, isTrue);
      expect(StructuralPlaceholderRestorationPolicy.realDevicePlus95PassClaimed, isFalse);

      expect(EditorCommands.restoreStructuralPlaceholders('sin()'), 'sin(□)');
      expect(EditorCommands.restoreStructuralPlaceholders('cos()'), 'cos(□)');
      expect(EditorCommands.restoreStructuralPlaceholders('ln()'), 'ln(□)');
      expect(EditorCommands.restoreStructuralPlaceholders('log()'), 'log(□)');
      expect(EditorCommands.restoreStructuralPlaceholders('√()'), '√(□)');
      expect(EditorCommands.restoreStructuralPlaceholders('9⁄'), '9⁄□');
      expect(EditorCommands.restoreStructuralPlaceholders('9/'), '9⁄□');
      expect(EditorCommands.restoreStructuralPlaceholders('/6'), '□⁄6');
      expect(EditorCommands.restoreStructuralPlaceholders('9/6'), '9⁄6');
      expect(EditorCommands.restoreStructuralPlaceholders('∫(□)d'), '∫(□)d□');
      expect(EditorCommands.restoreStructuralPlaceholders('log₍₎()'), 'log₍□₎(□)');
    });

    test('restoration preserves derivative slash tokens and restores parseable function slots', () {
      expect(EditorCommands.restoreStructuralPlaceholders('d/dx(□)'), 'd/dx(□)');
      expect(EditorCommands.restoreStructuralPlaceholders('∂/∂x(□)'), '∂/∂x(□)');

      final root = NodeFactory.rootFromExpression(EditorCommands.restoreStructuralPlaceholders('sin()'));
      final registry = SlotRegistry.fromRoot(root);
      expect(registry.entries.map((entry) => entry.role), contains('functionArgument'));
    });

    test('Q51 source contract stays inside allowed editor/formula-engine areas', () {
      expect(StructuralPlaceholderRestorationPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(StructuralPlaceholderRestorationPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(StructuralPlaceholderRestorationPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(StructuralPlaceholderRestorationPolicy.appShellMutationAllowed, isFalse);
      expect(StructuralPlaceholderRestorationPolicy.graphHistorySolutionMutationAllowed, isFalse);
    });
  });
}
