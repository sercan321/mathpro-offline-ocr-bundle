sealed class CalculatorAction {
  const CalculatorAction();
}

final class InsertTextAction extends CalculatorAction {
  const InsertTextAction(this.text);
  final String text;
}

final class InsertTemplateAction extends CalculatorAction {
  const InsertTemplateAction(this.template);
  final String template;
}

final class BackspaceAction extends CalculatorAction {
  const BackspaceAction();
}

final class ClearAction extends CalculatorAction {
  const ClearAction();
}

final class InsertAnswerAction extends CalculatorAction {
  const InsertAnswerAction();
}

final class ToggleTemplateTrayAction extends CalculatorAction {
  const ToggleTemplateTrayAction();
}

final class EvaluateAction extends CalculatorAction {
  const EvaluateAction();
}
