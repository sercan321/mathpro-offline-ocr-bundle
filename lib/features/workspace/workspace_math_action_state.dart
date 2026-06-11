import 'package:flutter/foundation.dart';

import 'workspace_math_action.dart';

/// Q382 selected action state. This is metadata only: it is not a result and it
/// must never trigger Solve/Graph/Solution/History by itself.
@immutable
class WorkspaceSelectedMathAction {
  const WorkspaceSelectedMathAction({
    required this.id,
    required this.label,
    required this.shortLabel,
    required this.expressionKind,
    required this.expressionFingerprint,
    this.variable,
    this.requiresSolverHandler = false,
    this.supportedByCurrentEngine = false,
  });

  final String id;
  final String label;
  final String shortLabel;
  final WorkspaceExpressionKind expressionKind;
  final String expressionFingerprint;
  final String? variable;
  final bool requiresSolverHandler;
  final bool supportedByCurrentEngine;

  bool get hasUnsupportedSolverHandler => requiresSolverHandler && !supportedByCurrentEngine;

  factory WorkspaceSelectedMathAction.fromAction({
    required WorkspaceMathAction action,
    required WorkspaceExpressionKind expressionKind,
    required String expression,
    String? variable,
  }) {
    return WorkspaceSelectedMathAction(
      id: action.id,
      label: action.label,
      shortLabel: action.shortLabel,
      expressionKind: expressionKind,
      expressionFingerprint: expression.trim(),
      variable: variable,
      requiresSolverHandler: action.requiresSolverHandler,
      supportedByCurrentEngine: action.supportedByCurrentEngine,
    );
  }

  bool isStillValidFor(String expression) => expression.trim() == expressionFingerprint;
}
