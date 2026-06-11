import 'package:flutter/material.dart';

/// Q382 — Workspace expression context menu / semantic math action intent shell.
///
/// This model is intentionally an intent contract, not a fake solver surface.
/// Selecting a [WorkspaceMathAction] never mutates the expression and never
/// fabricates a result. The selected action is only routed as metadata to the
/// existing solution flow.
enum WorkspaceExpressionKind {
  emptyExpression,
  numericExpression,
  algebraicExpression,
  polynomialExpression,
  polynomialEquation,
  higherDegreePolynomialEquation,
  rationalExpression,
  rationalEquation,
  trigonometricExpression,
  trigonometricEquation,
  logarithmicExpression,
  exponentialEquation,
  absoluteValueEquation,
  radicalEquation,
  complexNumberExpression,
  complexEquation,
  calculusDerivativeExpression,
  calculusIntegralExpression,
  limitExpression,
  linearSystem,
  matrixExpression,
  unsupported,
}

enum WorkspaceMathActionCategory { algebra, equation, calculus, complex, structure, generic }

enum WorkspaceMathActionKind { immediateEditorAction, mathIntentAction }

@immutable
class WorkspaceMathAction {
  const WorkspaceMathAction({
    required this.id,
    required this.label,
    required this.shortLabel,
    required this.category,
    required this.kind,
    required this.enabled,
    required this.priority,
    this.disabledReason,
    this.requiresVariable = false,
    this.requiresSolverHandler = false,
    this.supportedByCurrentEngine = false,
    this.icon = Icons.auto_awesome_rounded,
  });

  final String id;
  final String label;
  final String shortLabel;
  final WorkspaceMathActionCategory category;
  final WorkspaceMathActionKind kind;
  final bool enabled;
  final String? disabledReason;
  final bool requiresVariable;
  final bool requiresSolverHandler;
  final bool supportedByCurrentEngine;
  final int priority;
  final IconData icon;

  bool get isMathIntent => kind == WorkspaceMathActionKind.mathIntentAction;
  bool get isEditorAction => kind == WorkspaceMathActionKind.immediateEditorAction;

  WorkspaceMathAction disabled(String reason) => WorkspaceMathAction(
        id: id,
        label: label,
        shortLabel: shortLabel,
        category: category,
        kind: kind,
        enabled: false,
        disabledReason: reason,
        requiresVariable: requiresVariable,
        requiresSolverHandler: requiresSolverHandler,
        supportedByCurrentEngine: supportedByCurrentEngine,
        priority: priority,
        icon: icon,
      );
}

@immutable
class WorkspaceMathActionResolution {
  const WorkspaceMathActionResolution({
    required this.expression,
    required this.expressionKind,
    required this.actions,
    this.variable,
  });

  final String expression;
  final WorkspaceExpressionKind expressionKind;
  final List<WorkspaceMathAction> actions;
  final String? variable;

  bool get hasEnabledMathAction => actions.any((action) => action.isMathIntent && action.enabled);
}
