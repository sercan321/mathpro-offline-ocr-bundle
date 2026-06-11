import 'package:flutter/material.dart';

import 'workspace_math_action.dart';
import 'workspace_math_action_classifier.dart';

/// Q382 resolver: produces semantic intent candidates only. Unsupported or
/// unimplemented handlers are hidden/disabled and never generate fake results.
class WorkspaceMathActionResolver {
  const WorkspaceMathActionResolver._();

  static WorkspaceMathActionResolution resolve(String expression) {
    final kind = WorkspaceMathActionClassifier.classify(expression);
    final variable = WorkspaceMathActionClassifier.variableFor(expression);
    final actions = <WorkspaceMathAction>[..._actionsFor(kind)]..sort((a, b) => a.priority.compareTo(b.priority));
    return WorkspaceMathActionResolution(
      expression: expression,
      expressionKind: kind,
      variable: variable,
      actions: actions,
    );
  }

  static List<WorkspaceMathAction> _actionsFor(WorkspaceExpressionKind kind) {
    switch (kind) {
      case WorkspaceExpressionKind.emptyExpression:
        return const <WorkspaceMathAction>[];
      case WorkspaceExpressionKind.numericExpression:
        return <WorkspaceMathAction>[
          _intent('simplify', 'Sadeleştir', 'Sadeleştir', WorkspaceMathActionCategory.generic, Icons.auto_fix_high_rounded, 10),
        ];
      case WorkspaceExpressionKind.polynomialExpression:
        return <WorkspaceMathAction>[
          _intent('simplify', 'Sadeleştir', 'Sadeleştir', WorkspaceMathActionCategory.algebra, Icons.auto_fix_high_rounded, 10),
          _intent('factor', 'Çarpanlarına Ayır', 'Çarpanlarına Ayır', WorkspaceMathActionCategory.algebra, Icons.call_split_rounded, 12),
          _intent('expand', 'Genişlet', 'Genişlet', WorkspaceMathActionCategory.algebra, Icons.open_in_full_rounded, 14),
          _intent('roots', 'Kökleri Bul', 'Kökleri Bul', WorkspaceMathActionCategory.equation, Icons.scatter_plot_rounded, 16).disabled('Q382 shell: gerçek kök handler kanıtlanmadan aktif değil.'),
          _intent('degree', 'Dereceyi Bul', 'Derece', WorkspaceMathActionCategory.algebra, Icons.stacked_line_chart_rounded, 22).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.polynomialEquation:
        return <WorkspaceMathAction>[
          _intent('solveForX', 'x için çöz', 'x için çöz', WorkspaceMathActionCategory.equation, Icons.rule_rounded, 10),
          _intent('roots', 'Kökleri Bul', 'Kökleri Bul', WorkspaceMathActionCategory.equation, Icons.scatter_plot_rounded, 12),
          _intent('factor', 'Çarpanlarına Ayır', 'Çarpanlarına Ayır', WorkspaceMathActionCategory.algebra, Icons.call_split_rounded, 16),
          _intent('solutionSet', 'Çözüm Kümesi', 'Çözüm Kümesi', WorkspaceMathActionCategory.equation, Icons.data_array_rounded, 20).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.higherDegreePolynomialEquation:
        return <WorkspaceMathAction>[
          _intent('roots', 'Kökleri Bul', 'Kökleri Bul', WorkspaceMathActionCategory.equation, Icons.scatter_plot_rounded, 10),
          _intent('realRoots', 'Gerçek Kökler', 'Gerçek Kökler', WorkspaceMathActionCategory.equation, Icons.timeline_rounded, 12).disabled('Yakında'),
          _intent('complexRoots', 'Kompleks Kökler', 'Kompleks Kökler', WorkspaceMathActionCategory.complex, Icons.hub_rounded, 14).disabled('Kompleks kök handler kanıtlanmadan aktif değil.'),
          _intent('factor', 'Çarpanlarına Ayır', 'Çarpanlarına Ayır', WorkspaceMathActionCategory.algebra, Icons.call_split_rounded, 16),
        ];
      case WorkspaceExpressionKind.rationalExpression:
      case WorkspaceExpressionKind.rationalEquation:
        return <WorkspaceMathAction>[
          _intent('simplify', 'Sadeleştir', 'Sadeleştir', WorkspaceMathActionCategory.algebra, Icons.auto_fix_high_rounded, 10),
          _intent('commonDenominator', 'Ortak Payda', 'Ortak Payda', WorkspaceMathActionCategory.algebra, Icons.merge_type_rounded, 12).disabled('Yakında'),
          _intent('domain', 'Tanım Kümesi', 'Tanım Kümesi', WorkspaceMathActionCategory.structure, Icons.domain_rounded, 14).disabled('Yakında'),
          _intent('partialFractions', 'Kısmi Kesirlere Ayır', 'Kısmi Kesir', WorkspaceMathActionCategory.algebra, Icons.account_tree_rounded, 18).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.trigonometricExpression:
      case WorkspaceExpressionKind.trigonometricEquation:
        return <WorkspaceMathAction>[
          _intent('trigSimplify', 'Trigonometrik Sadeleştir', 'Trig Sadeleştir', WorkspaceMathActionCategory.algebra, Icons.waves_rounded, 10).disabled('Trig handler kanıtlanmadan aktif değil.'),
          _intent('trigSolve', 'Trigonometrik Çöz', 'Trig Çöz', WorkspaceMathActionCategory.equation, Icons.functions_rounded, 12).disabled('Yakında'),
          _intent('generalSolution', 'Genel Çözüm', 'Genel Çözüm', WorkspaceMathActionCategory.equation, Icons.all_inclusive_rounded, 14).disabled('Yakında'),
          _intent('applyIdentities', 'Kimlikleri Uygula', 'Kimlikler', WorkspaceMathActionCategory.algebra, Icons.auto_awesome_rounded, 18).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.logarithmicExpression:
      case WorkspaceExpressionKind.exponentialEquation:
        return <WorkspaceMathAction>[
          _intent('logSolve', 'Logaritmik Çöz', 'Log Çöz', WorkspaceMathActionCategory.equation, Icons.functions_rounded, 10).disabled('Yakında'),
          _intent('domain', 'Tanım Koşulu', 'Tanım Koşulu', WorkspaceMathActionCategory.structure, Icons.domain_rounded, 12).disabled('Yakında'),
          _intent('combineLogs', 'Birleştir', 'Birleştir', WorkspaceMathActionCategory.algebra, Icons.merge_rounded, 14).disabled('Yakında'),
          _intent('approximate', 'Yaklaşık Değer', 'Yaklaşık', WorkspaceMathActionCategory.generic, Icons.speed_rounded, 18).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.absoluteValueEquation:
        return <WorkspaceMathAction>[
          _intent('absoluteValueSolve', 'Mutlak Değer Çöz', 'Mutlak Çöz', WorkspaceMathActionCategory.equation, Icons.open_with_rounded, 10).disabled('Yakında'),
          _intent('piecewiseSolve', 'Parçalı Çöz', 'Parçalı Çöz', WorkspaceMathActionCategory.structure, Icons.call_split_rounded, 12).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.radicalEquation:
        return <WorkspaceMathAction>[
          _intent('radicalSolve', 'Kökten Kurtar', 'Kökten Kurtar', WorkspaceMathActionCategory.equation, Icons.square_foot_rounded, 10).disabled('Yakında'),
          _intent('domain', 'Tanım Koşulu', 'Tanım Koşulu', WorkspaceMathActionCategory.structure, Icons.domain_rounded, 12).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.complexNumberExpression:
      case WorkspaceExpressionKind.complexEquation:
        return <WorkspaceMathAction>[
          _intent('realImaginary', 'Re/Im Ayır', 'Re/Im', WorkspaceMathActionCategory.complex, Icons.splitscreen_rounded, 10).disabled('Yakında'),
          _intent('modulus', 'Modül Bul', 'Modül', WorkspaceMathActionCategory.complex, Icons.radio_button_checked_rounded, 12).disabled('Yakında'),
          _intent('argument', 'Argüman Bul', 'Argüman', WorkspaceMathActionCategory.complex, Icons.explore_rounded, 14).disabled('Yakında'),
          _intent('polarForm', 'Kutupsal Forma Çevir', 'Kutupsal', WorkspaceMathActionCategory.complex, Icons.adjust_rounded, 16).disabled('Yakında'),
          _intent('complexRoots', 'Kompleks Kökler', 'Kompleks Kökler', WorkspaceMathActionCategory.complex, Icons.hub_rounded, 18).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.calculusDerivativeExpression:
        return <WorkspaceMathAction>[
          _intent('differentiate', 'Türev Al', 'Türev Al', WorkspaceMathActionCategory.calculus, Icons.trending_up_rounded, 10).disabled('Türev handler kanıtlanmadan aktif değil.'),
          _intent('simplify', 'Sadeleştir', 'Sadeleştir', WorkspaceMathActionCategory.generic, Icons.auto_fix_high_rounded, 12),
        ];
      case WorkspaceExpressionKind.calculusIntegralExpression:
        return <WorkspaceMathAction>[
          _intent('integrate', 'İntegral Al', 'İntegral Al', WorkspaceMathActionCategory.calculus, Icons.area_chart_rounded, 10).disabled('İntegral handler kanıtlanmadan aktif değil.'),
          _intent('simplify', 'Sadeleştir', 'Sadeleştir', WorkspaceMathActionCategory.generic, Icons.auto_fix_high_rounded, 12),
        ];
      case WorkspaceExpressionKind.limitExpression:
        return <WorkspaceMathAction>[
          _intent('limit', 'Limit Al', 'Limit Al', WorkspaceMathActionCategory.calculus, Icons.arrow_right_alt_rounded, 10).disabled('Limit handler kanıtlanmadan aktif değil.'),
          _intent('leftLimit', 'Soldan Limit', 'Soldan', WorkspaceMathActionCategory.calculus, Icons.keyboard_double_arrow_left_rounded, 12).disabled('Yakında'),
          _intent('rightLimit', 'Sağdan Limit', 'Sağdan', WorkspaceMathActionCategory.calculus, Icons.keyboard_double_arrow_right_rounded, 14).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.linearSystem:
        return <WorkspaceMathAction>[
          _intent('solveSystem', 'Sistem Çöz', 'Sistem Çöz', WorkspaceMathActionCategory.equation, Icons.view_agenda_rounded, 10).disabled('Sistem solver kanıtlanmadan aktif değil.'),
          _intent('matrixForm', 'Matris Formu', 'Matris Formu', WorkspaceMathActionCategory.structure, Icons.grid_on_rounded, 12).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.matrixExpression:
        return <WorkspaceMathAction>[
          _intent('determinant', 'Determinant', 'Determinant', WorkspaceMathActionCategory.structure, Icons.grid_3x3_rounded, 10).disabled('Yakında'),
          _intent('inverseMatrix', 'Ters Matris', 'Ters Matris', WorkspaceMathActionCategory.structure, Icons.flip_to_back_rounded, 12).disabled('Yakında'),
          _intent('transpose', 'Transpoz', 'Transpoz', WorkspaceMathActionCategory.structure, Icons.swap_horiz_rounded, 14).disabled('Yakında'),
        ];
      case WorkspaceExpressionKind.algebraicExpression:
      case WorkspaceExpressionKind.unsupported:
        return <WorkspaceMathAction>[
          _intent('simplify', 'Sadeleştir', 'Sadeleştir', WorkspaceMathActionCategory.generic, Icons.auto_fix_high_rounded, 10).disabled('Bu ifade için güvenli handler kanıtlanmadı.'),
        ];
    }
  }

  static WorkspaceMathAction _intent(
    String id,
    String label,
    String shortLabel,
    WorkspaceMathActionCategory category,
    IconData icon,
    int priority,
  ) => WorkspaceMathAction(
        id: id,
        label: label,
        shortLabel: shortLabel,
        category: category,
        kind: WorkspaceMathActionKind.mathIntentAction,
        enabled: false,
        disabledReason: 'Gerçek handler kanıtlanmadan aktif değil.',
        priority: priority,
        supportedByCurrentEngine: false,
        requiresSolverHandler: true,
        icon: icon,
      );
}

