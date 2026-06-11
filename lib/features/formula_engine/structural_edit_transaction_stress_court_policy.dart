import 'structural_edit_transaction_engine_policy.dart';

/// Q63 — Structural Edit Transaction Stress Court.
///
/// Q60 introduced the transaction normalizer. Q63 turns that normalizer into a
/// stress court: every insert/delete/clear/replace style edit must leave a safe
/// structural expression. This file deliberately stays outside keyboard, MORE,
/// long-press, app shell, MathLabel, Graph, History and Solution surfaces.
class StructuralEditTransactionStressCourtPolicy {
  const StructuralEditTransactionStressCourtPolicy._();

  static const bool structuralEditTransactionStressCourtAvailable = true;
  static const bool halfTemplateStressFailureAllowed = false;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const int attemptsPerScenario = 20;
  static const int requiredCorrectPerScenario = 20;
  static const double requiredStressSuccessRate = 1.0;
  static const String version = 'mathpro-v172-q63-structural-edit-transaction-stress-court';

  static const List<StructuralEditStressCase> coreCases = <StructuralEditStressCase>[
    StructuralEditStressCase(
      label: 'fraction-denominator-empty-after-backspace',
      before: '9⁄6',
      after: '9⁄',
      source: 'backspaceTransaction',
      expected: '9⁄□',
      forbidden: <String>['9⁄', '9/'],
    ),
    StructuralEditStressCase(
      label: 'fraction-numerator-empty-after-delete',
      before: '9⁄6',
      after: '⁄6',
      source: 'deleteTransaction',
      expected: '□⁄6',
      forbidden: <String>['⁄6', '/6'],
    ),
    StructuralEditStressCase(
      label: 'ascii-fraction-denominator-empty',
      before: '9/6',
      after: '9/',
      source: 'backspaceTransaction',
      expected: '9⁄□',
      forbidden: <String>['9/'],
    ),
    StructuralEditStressCase(
      label: 'sin-argument-cleared',
      before: 'sin(300)',
      after: 'sin()',
      source: 'clearSlotTransaction',
      expected: 'sin(□)',
      forbidden: <String>['sin()'],
    ),
    StructuralEditStressCase(
      label: 'cos-argument-cleared',
      before: 'cos(400)',
      after: 'cos()',
      source: 'clearSlotTransaction',
      expected: 'cos(□)',
      forbidden: <String>['cos()'],
    ),
    StructuralEditStressCase(
      label: 'ln-argument-cleared',
      before: 'ln(123456)',
      after: 'ln()',
      source: 'clearSlotTransaction',
      expected: 'ln(□)',
      forbidden: <String>['ln()'],
    ),
    StructuralEditStressCase(
      label: 'log-argument-cleared',
      before: 'log(5)',
      after: 'log()',
      source: 'clearSlotTransaction',
      expected: 'log(□)',
      forbidden: <String>['log()'],
    ),
    StructuralEditStressCase(
      label: 'sqrt-radicand-cleared',
      before: '√(8)',
      after: '√()',
      source: 'clearSlotTransaction',
      expected: '√(□)',
      forbidden: <String>['√()'],
    ),
    StructuralEditStressCase(
      label: 'cube-root-radicand-cleared',
      before: '³√(27)',
      after: '³√()',
      source: 'clearSlotTransaction',
      expected: '³√(□)',
      forbidden: <String>['³√()'],
    ),
    StructuralEditStressCase(
      label: 'integral-differential-cleared',
      before: '∫(9)d𝑥',
      after: '∫(9)d',
      source: 'backspaceTransaction',
      expected: '∫(9)d□',
      forbidden: <String>['∫(9)d'],
    ),
    StructuralEditStressCase(
      label: 'integral-body-cleared',
      before: '∫(9)d𝑥',
      after: '∫()d𝑥',
      source: 'clearSlotTransaction',
      expected: '∫(□)d𝑥',
      forbidden: <String>['∫()'],
    ),
    StructuralEditStressCase(
      label: 'log-base-cleared',
      before: 'log₍2₎(5)',
      after: 'log₍₎(5)',
      source: 'clearSlotTransaction',
      expected: 'log₍□₎(5)',
      forbidden: <String>['log₍₎'],
    ),
    StructuralEditStressCase(
      label: 'log-body-cleared',
      before: 'log₍2₎(5)',
      after: 'log₍2₎()',
      source: 'clearSlotTransaction',
      expected: 'log₍2₎(□)',
      forbidden: <String>['log₍2₎()'],
    ),
    StructuralEditStressCase(
      label: 'nested-function-inner-cleared',
      before: 'sin(cos(300))',
      after: 'sin(cos())',
      source: 'clearSlotTransaction',
      expected: 'sin(cos(□))',
      forbidden: <String>['cos()'],
    ),
    StructuralEditStressCase(
      label: 'mixed-expression-fraction-cleared',
      before: 'sin(300)+9⁄6+√(8)',
      after: 'sin(300)+9⁄+√(8)',
      source: 'backspaceTransaction',
      expected: 'sin(300)+9⁄□+√(8)',
      forbidden: <String>['9⁄+'],
    ),
  ];

  static StructuralEditStressVerdict evaluateCase(StructuralEditStressCase testCase) {
    final normalized = StructuralEditTransactionEnginePolicy.finalizeExpression(
      before: testCase.before,
      after: testCase.after,
      source: testCase.source,
    );
    final expectedMatch = normalized == testCase.expected;
    final forbiddenLeak = testCase.forbidden.any((fragment) => normalized.trim() == fragment.trim());
    final safeFinal = StructuralEditTransactionEnginePolicy.isSafeFinalExpression(normalized);
    return StructuralEditStressVerdict(
      label: testCase.label,
      normalized: normalized,
      expected: testCase.expected,
      expectedMatch: expectedMatch,
      forbiddenLeak: forbiddenLeak,
      safeFinal: safeFinal,
    );
  }

  static StructuralEditStressScenario evaluateScenario(StructuralEditStressCase testCase) {
    final attempts = <StructuralEditStressVerdict>[];
    for (var index = 0; index < attemptsPerScenario; index += 1) {
      attempts.add(evaluateCase(testCase.copyWith(source: _sourceForAttempt(testCase.source, index))));
    }
    final correct = attempts.where((verdict) => verdict.passed).length;
    return StructuralEditStressScenario(
      label: testCase.label,
      correct: correct,
      attempts: attempts,
    );
  }

  static StructuralEditStressMatrix evaluateCoreMatrix() {
    final scenarios = coreCases.map(evaluateScenario).toList(growable: false);
    final totalAttempts = scenarios.fold<int>(0, (sum, scenario) => sum + scenario.total);
    final totalCorrect = scenarios.fold<int>(0, (sum, scenario) => sum + scenario.correct);
    return StructuralEditStressMatrix(
      scenarios: scenarios,
      totalAttempts: totalAttempts,
      totalCorrect: totalCorrect,
    );
  }

  static bool isForbiddenHalfTemplate(String expression) {
    return coreCases.expand((testCase) => testCase.forbidden).any((fragment) => expression.trim() == fragment.trim());
  }

  static String _sourceForAttempt(String source, int index) {
    const variants = <String>[
      'backspaceTransaction',
      'deleteTransaction',
      'clearSlotTransaction',
      'replaceSlotTransaction',
      'insertTextTransaction',
      'templateTransaction',
      'restoreTransaction',
      'cutTransaction',
      'pasteTransaction',
      'duplicateTransaction',
    ];
    final variant = variants[index % variants.length];
    if (source.toLowerCase().contains('backspace') && index.isEven) return source;
    if (source.toLowerCase().contains('clear') && index.isEven) return source;
    return variant;
  }
}

class StructuralEditStressCase {
  const StructuralEditStressCase({
    required this.label,
    required this.before,
    required this.after,
    required this.source,
    required this.expected,
    required this.forbidden,
  });

  final String label;
  final String before;
  final String after;
  final String source;
  final String expected;
  final List<String> forbidden;

  StructuralEditStressCase copyWith({String? source}) {
    return StructuralEditStressCase(
      label: label,
      before: before,
      after: after,
      source: source ?? this.source,
      expected: expected,
      forbidden: forbidden,
    );
  }
}

class StructuralEditStressVerdict {
  const StructuralEditStressVerdict({
    required this.label,
    required this.normalized,
    required this.expected,
    required this.expectedMatch,
    required this.forbiddenLeak,
    required this.safeFinal,
  });

  final String label;
  final String normalized;
  final String expected;
  final bool expectedMatch;
  final bool forbiddenLeak;
  final bool safeFinal;

  bool get passed => expectedMatch && !forbiddenLeak && safeFinal;

  String get summary => '$label => $normalized expected=$expected passed=$passed';
}

class StructuralEditStressScenario {
  const StructuralEditStressScenario({
    required this.label,
    required this.correct,
    required this.attempts,
  });

  final String label;
  final int correct;
  final List<StructuralEditStressVerdict> attempts;

  int get total => attempts.length;
  bool get passed => correct >= StructuralEditTransactionStressCourtPolicy.requiredCorrectPerScenario;
  String get summary => '$label: $correct/$total';
}

class StructuralEditStressMatrix {
  const StructuralEditStressMatrix({
    required this.scenarios,
    required this.totalAttempts,
    required this.totalCorrect,
  });

  final List<StructuralEditStressScenario> scenarios;
  final int totalAttempts;
  final int totalCorrect;

  int get scenarioCount => scenarios.length;
  double get successRate => totalAttempts == 0 ? 0.0 : totalCorrect / totalAttempts;
  bool get passed => scenarios.every((scenario) => scenario.passed) && successRate >= StructuralEditTransactionStressCourtPolicy.requiredStressSuccessRate;
  String get summary => scenarios.map((scenario) => scenario.summary).join('\n');
}
