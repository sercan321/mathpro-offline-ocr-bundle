import '../features/keyboard/key_config.dart';
import '../state/calculator_actions.dart';
import 'action_utils.dart';
import 'math_template_contract_registry.dart';
import 'premium_math_key_specs.dart';

class KeyHandlers {
  const KeyHandlers._();

  // V135: template routing must not depend only on MORE categories or a
  // hand-picked ActionUtils list.  Every label that has a central template
  // contract or premium spec must enter the structural InsertTemplateAction
  // path, including long-press-only labels such as Aᵀ/A⁻¹/Bᵀ/B⁻¹.  Plain
  // numeric/variable/operator labels still fall through to KeyConfig text
  // behavior so keyboard layout and command semantics remain frozen.
  static final Set<String> _templateActionLabels = <String>{
    for (final spec in ActionUtils.premiumTemplates) spec.label,
    ...PremiumMathKeySpecs.labels,
    ...MathTemplateContractRegistry.labels,
  };

  static CalculatorAction actionForLabel(String label) {
    if (_templateActionLabels.contains(label)) {
      return InsertTemplateAction(label);
    }

    switch (label) {
      case 'C':
        return const ClearAction();
      case '⌫':
        return const BackspaceAction();
      case 'Ans':
        return const InsertAnswerAction();
      case 'MORE':
        return const ToggleTemplateTrayAction();
      case '↵':
        return const EvaluateAction();
      default:
        final behavior = KeyConfig.getKeyBehavior(label);
        switch (behavior) {
          case KeyBehaviorType.structureInsert:
          case KeyBehaviorType.wrapper:
          case KeyBehaviorType.postfix:
            return InsertTemplateAction(label);
          case KeyBehaviorType.textInsert:
            return InsertTextAction(KeyConfig.getInsertText(label));
          case KeyBehaviorType.command:
            return InsertTextAction(KeyConfig.getInsertText(label));
        }
    }
  }
}
