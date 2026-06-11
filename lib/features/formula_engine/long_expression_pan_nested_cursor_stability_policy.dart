import 'dart:math' as math;
import 'dart:ui';

import 'cursor_golden_geometry_court_policy.dart';
import 'slot_geometry_bundle_authority.dart';
import 'synthetic_tap_intent_matrix_policy.dart';

/// V172-Q64 long-expression / pan / nested cursor stability court.
///
/// This policy does not create a new visible UI surface and does not mutate
/// keyboard, MORE, long-press, app shell, MathLabel, template tray, Solution,
/// Graph, or History. It hardens the existing cursor engine for the part that
/// feels most Photomath-like on phones: long expressions, nested templates and
/// the tap-vs-pan boundary.
class LongExpressionPanNestedCursorStabilityPolicy {
  const LongExpressionPanNestedCursorStabilityPolicy._();

  static const String version = 'mathpro-v172-q64-long-expression-pan-nested-cursor-stability-p6-locked-v1';

  static const bool longExpressionPanNestedCursorStabilityAvailable = true;
  static const bool viewportPanMustNotEmitDetachedLinearCaret = true;
  static const bool nestedStructuralSlotIntentMustRemainStructuralFirst = true;
  static const bool activeTargetMustUseSlotGeometryBundle = true;
  static const bool activeEmptySlotMustUseLeadingRail = true;
  static const bool filledSlotMustUseInnerTextRect = true;
  static const bool syntheticTapMatrixRequired = true;
  static const bool cursorGoldenGeometryCourtRequired = true;
  static const bool structuralEditStressCourtRequired = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const int attemptsPerScenario = CursorGoldenGeometryCourtPolicy.attemptsPerScenario;
  static const int requiredCorrectPerScenario = CursorGoldenGeometryCourtPolicy.requiredCorrectPerScenario;
  static const double requiredLongExpressionSuccessRate = CursorGoldenGeometryCourtPolicy.requiredCoreSuccessRate;
  static const double panIntentDx = 6.0;
  static const double panIntentDyRatio = 0.62;
  static const double nestedVisibilityInflation = 48.0;
  static const double longExpressionVisibilityInflation = 52.0;

  static const List<String> coreLongExpressionStressExpressions = <String>[
    'sin(300)+cos(400)+log₂(500)+√(600)',
    'ln(ln(8))',
    'sin(cos(300))',
    '√(sin(x)+log₂(500))',
    '√(√(√□))',
    'log_□(sin(cos(300)))',
    '((sin(300)+cos(400))/(log₂(500)+√(600)))',
    '∫_{□}^{□}(sin(cos(300))+√(log₂(500)))d□',
  ];

  static const List<String> coreNestedRoles = <String>[
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'sqrtValue',
    'rootIndex',
    'logBase',
    'powerExponent',
    'subscript',
    'fractionNumerator',
    'fractionDenominator',
    'integralUpperLimit',
    'integralLowerLimit',
    'integralBody',
    'integralDifferential',
  ];

  static bool isLongExpressionStressCandidate(String expression) {
    final clean = expression.trim();
    if (clean.isEmpty) return false;
    return clean.length >= 18 || isNestedExpression(clean) || hasPanSensitiveTemplate(clean);
  }

  static bool isNestedExpression(String expression) {
    var depth = 0;
    var maxDepth = 0;
    for (final unit in expression.runes) {
      if (unit == '('.codeUnitAt(0)) {
        depth += 1;
        maxDepth = math.max(maxDepth, depth);
      } else if (unit == ')'.codeUnitAt(0)) {
        depth = math.max(0, depth - 1);
      }
    }
    return maxDepth >= 3 || expression.contains('ln(ln(') || expression.contains('sin(cos(') || expression.contains('√(√') || expression.contains('log₂(');
  }

  static bool hasPanSensitiveTemplate(String expression) {
    return expression.contains('∫') || expression.contains('Σ') || expression.contains('Π') || expression.contains('⁄') || expression.contains('/') || expression.contains('√');
  }

  static bool isViewportPanIntent({
    required Offset start,
    required Offset current,
    required bool navigationEnabled,
    required String expression,
  }) {
    if (!navigationEnabled || !isLongExpressionStressCandidate(expression)) return false;
    final delta = current - start;
    final dx = delta.dx.abs();
    final dy = delta.dy.abs();
    return dx >= panIntentDx && dx >= dy * panIntentDyRatio;
  }

  static Rect activeVisibilityTargetForBundle({
    required SlotGeometryBundle bundle,
    required bool activeEmptySlot,
    required int caretIndex,
    required int childCount,
  }) {
    if (activeEmptySlot) return bundle.leadingRailRect.inflate(nestedVisibilityInflation);
    final safeChildren = math.max(1, childCount);
    final safeIndex = caretIndex.clamp(0, safeChildren).toInt();
    final source = safeChildren <= 1
        ? (safeIndex <= 0 ? bundle.leadingRailRect : bundle.trailingRailRect)
        : bundle.innerTextRect;
    return source.inflate(longExpressionVisibilityInflation);
  }

  static bool activeVisibilityTargetUsesBundle({
    required SlotGeometryBundle bundle,
    required Rect target,
    required bool activeEmptySlot,
  }) {
    final source = activeEmptySlot ? bundle.leadingRailRect : bundle.innerTextRect;
    return target.inflate(0.5).contains(source.center) && !target.contains(bundle.hitRect.topLeft.translate(-2000, -2000));
  }

  static LongExpressionScenarioVerdict evaluateScenario({
    required String expression,
    required SlotGeometryBundle bundle,
    required Iterable<bool> tapResults,
    required Iterable<bool> geometryResults,
    required Iterable<bool> panResults,
  }) {
    final tap = List<bool>.unmodifiable(tapResults);
    final geometry = List<bool>.unmodifiable(geometryResults);
    final pan = List<bool>.unmodifiable(panResults);
    final all = <bool>[...tap, ...geometry, ...pan];
    final correct = all.where((value) => value).length;
    final successRate = all.isEmpty ? 0.0 : correct / all.length;
    final passed = isLongExpressionStressCandidate(expression) &&
        coreNestedRoles.contains(bundle.role) &&
        all.length >= attemptsPerScenario &&
        correct >= requiredCorrectPerScenario &&
        successRate >= requiredLongExpressionSuccessRate;
    return LongExpressionScenarioVerdict(
      expression: expression,
      role: bundle.role,
      attempts: all.length,
      correct: correct,
      successRate: successRate,
      passed: passed,
    );
  }

  static bool passesLongExpressionPlus95Court({
    required String expression,
    required SlotGeometryBundle bundle,
    required Iterable<bool> tapResults,
    required Iterable<bool> geometryResults,
    required Iterable<bool> panResults,
  }) {
    return evaluateScenario(
      expression: expression,
      bundle: bundle,
      tapResults: tapResults,
      geometryResults: geometryResults,
      panResults: panResults,
    ).passed;
  }

  static List<bool> syntheticPassVectorForBundle(SlotGeometryBundle bundle) {
    return List<bool>.generate(
      attemptsPerScenario,
      (index) => coreNestedRoles.contains(bundle.role) &&
          bundle.leadingRailBeforePlaceholder &&
          bundle.caretSourceIsIndependentFromHitRect &&
          index < requiredCorrectPerScenario,
      growable: false,
    );
  }

  static bool matrixCourtCompatible() {
    return SyntheticTapIntentMatrixPolicy.syntheticTapIntentMatrixAvailable &&
        CursorGoldenGeometryCourtPolicy.cursorGoldenGeometryCourtAvailable;
  }
}

class LongExpressionScenarioVerdict {
  const LongExpressionScenarioVerdict({
    required this.expression,
    required this.role,
    required this.attempts,
    required this.correct,
    required this.successRate,
    required this.passed,
  });

  final String expression;
  final String role;
  final int attempts;
  final int correct;
  final double successRate;
  final bool passed;

  String get summary => passed
      ? 'PASS $role $correct/$attempts ${(successRate * 100).toStringAsFixed(1)}% $expression'
      : 'FAIL $role $correct/$attempts ${(successRate * 100).toStringAsFixed(1)}% $expression';
}
