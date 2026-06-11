import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'cursor_anchor.dart';
import 'slot_registry.dart';
import '../formula_engine/digit_level_caret_stop_policy.dart';
import '../formula_engine/true_glyph_level_caret_stop_policy.dart';

@immutable
class MathProSelectionState {
  const MathProSelectionState({
    this.activeSlotId,
    this.activeSlotRole,
    this.caretIndex = 0,
    this.lastHitSource = 'none',
    this.cursorAnchor,
  });

  final String? activeSlotId;
  final String? activeSlotRole;
  final int caretIndex;
  final String lastHitSource;
  final CursorAnchor? cursorAnchor;

  bool get isActive => activeSlotId != null;

  /// User-safe label. Never expose raw slot ids/roles such as sqrtValue.
  String get userLabel => isActive ? 'Aktif alan' : '';
}

class MathProSelectionController {
  const MathProSelectionController._();

  static const String version = 'mathpro-core-editor-selection-controller-v3-render-mapped-caret-aware';

  static MathProSelectionState select({
    required SlotEntry entry,
    required int caretIndex,
    required String source,
  }) {
    return MathProSelectionState(
      activeSlotId: entry.id,
      activeSlotRole: entry.role,
      caretIndex: _clampCaretForEntry(entry, caretIndex),
      lastHitSource: source,
      cursorAnchor: CursorAnchor.slot(entry: entry, offset: _clampCaretForEntry(entry, caretIndex), source: source),
    );
  }

  static MathProSelectionState normalize(MathProSelectionState selection, SlotRegistry registry) {
    final entry = registry.byId(selection.activeSlotId);
    if (entry == null) {
      return const MathProSelectionState(lastHitSource: 'selection-normalized-stale-slot');
    }
    final safeCaret = _clampCaretForEntry(entry, selection.caretIndex);
    return MathProSelectionState(
      activeSlotId: entry.id,
      activeSlotRole: entry.role,
      caretIndex: safeCaret,
      lastHitSource: selection.lastHitSource,
      cursorAnchor: CursorAnchor.slot(entry: entry, offset: safeCaret, source: selection.lastHitSource),
    );
  }

  static int _clampCaretForEntry(SlotEntry entry, int caretIndex) {
    final safe = caretIndex < 0 ? 0 : caretIndex;
    // Most placeholder-only slots have two logical edges and must stay clamped
    // to 0/1 so stale or oversized selection state never creates giant, invalid
    // caret offsets. Filled slot payloads are routed through hit-test or editor
    // commands with explicit child counts; these roles may keep local offsets.
    return switch (entry.role) {
      'fractionNumerator' ||
      'fractionDenominator' ||
      'powerExponent' ||
      'subscript' ||
      'logBase' ||
      'functionArgument' ||
      'functionArgument2' ||
      'functionArgument3' => safe.clamp(0, 32).toInt(),
      _ => safe.clamp(0, 1).toInt(),
    };
  }
}

class MathProCaretController {
  const MathProCaretController._();

  static const String version = 'mathpro-core-editor-caret-controller-v10-phase6-token-aware-v172e-log-root-nested-slots-v172q40-digit-level-caret-stops-v172q47-true-glyph-level-caret-stops';
  static const double inlineCaretWidth = 2.6;
  static const double phase6MinimumBaselineLift = 10.0;
  static const double phase6FunctionBoundarySnapRadius = 24.0;
  static const double precisionStructuralSnapRadius = 4.0;

  static Rect caretRectForSlot(Rect slotRect, {required int caretIndex, int childCount = 1}) {
    // Legacy Phase-E tests use this public helper as an inside-the-visual-slot
    // contract. Q32+ role-aware production geometry may place empty-slot carets
    // just outside placeholders, so keep this compatibility helper clamped to
    // the visual slot while production overlay code calls roleAwareCaretRectForSlot
    // or the native LayoutBox layer directly.
    final safeChildCount = math.max(1, childCount);
    final clampedCaret = caretIndex.clamp(0, safeChildCount).toInt();
    final height = _caretHeightForRole('placeholder', slotRect);
    final top = (slotRect.center.dy - height / 2)
        .clamp(slotRect.top + 0.5, math.max(slotRect.top + 0.5, slotRect.bottom - height - 0.5))
        .toDouble();
    if (safeChildCount <= 1) {
      final left = clampedCaret <= 0 ? slotRect.left : slotRect.right - inlineCaretWidth;
      return Rect.fromLTWH(left, top, inlineCaretWidth, height);
    }
    final x = slotRect.left + slotRect.width * (clampedCaret / safeChildCount);
    final left = (x - inlineCaretWidth / 2)
        .clamp(slotRect.left, math.max(slotRect.left, slotRect.right - inlineCaretWidth))
        .toDouble();
    return Rect.fromLTWH(left, top, inlineCaretWidth, height);
  }

  /// Q32: production caret geometry must not sit inside the visible placeholder
  /// box. Empty structural slots are edited from their optical edge, while
  /// scripts/limits use a smaller caret so exponent, subscript and log-base
  /// focus does not look like a full-height main-line cursor.
  static Rect roleAwareCaretRectForSlot(
    Rect slotRect, {
    required String role,
    required int caretIndex,
    int childCount = 1,
  }) {
    final safeChildCount = math.max(1, childCount);
    final clampedCaret = caretIndex.clamp(0, safeChildCount).toInt();
    final isEmptySlot = safeChildCount <= 1;
    final edgeMargin = _slotEdgeMarginForRole(role);
    final x = isEmptySlot
        ? (clampedCaret <= 0 ? slotRect.left - edgeMargin : slotRect.right + edgeMargin)
        : slotRect.left + slotRect.width * (clampedCaret / safeChildCount);
    final height = _caretHeightForRole(role, slotRect);
    final top = (slotRect.center.dy - height / 2)
        .clamp(0.0, math.max(0.0, slotRect.bottom + 18.0 - height))
        .toDouble();
    return Rect.fromLTWH(x - inlineCaretWidth / 2, top, inlineCaretWidth, height);
  }

  static double _slotEdgeMarginForRole(String role) {
    return switch (role) {
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => 5.4,
      'subscript' || 'logBase' || 'integralLowerLimit' || 'integralUpperLimit' ||
      'sumLowerLimit' || 'sumUpperLimit' || 'productLowerLimit' || 'productUpperLimit' => 4.8,
      'fractionNumerator' || 'fractionDenominator' => 5.2,
      'sqrtValue' || 'functionArgument' || 'functionArgument2' || 'functionArgument3' => 6.0,
      _ => 5.6,
    };
  }

  static double _caretHeightForRole(String role, Rect slotRect) {
    final preferred = switch (role) {
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => slotRect.height * 0.44,
      'subscript' || 'logBase' => slotRect.height * 0.46,
      'integralLowerLimit' || 'integralUpperLimit' || 'sumLowerLimit' || 'sumUpperLimit' ||
      'productLowerLimit' || 'productUpperLimit' => slotRect.height * 0.50,
      'fractionNumerator' || 'fractionDenominator' => slotRect.height * 0.58,
      'matrixCell' || 'systemLeft' || 'systemRight' => slotRect.height * 0.62,
      'sqrtValue' || 'functionArgument' || 'functionArgument2' || 'functionArgument3' => slotRect.height * 0.66,
      _ => slotRect.height * 0.70,
    };
    final minHeight = switch (role) {
      'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'subscript' || 'logBase' => 12.0,
      'integralLowerLimit' || 'integralUpperLimit' || 'sumLowerLimit' || 'sumUpperLimit' ||
      'productLowerLimit' || 'productUpperLimit' => 13.0,
      _ => 18.0,
    };
    final maxHeight = switch (role) {
      'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'subscript' || 'logBase' => 20.0,
      'integralLowerLimit' || 'integralUpperLimit' || 'sumLowerLimit' || 'sumUpperLimit' ||
      'productLowerLimit' || 'productUpperLimit' => 22.0,
      'fractionNumerator' || 'fractionDenominator' => 26.0,
      _ => 36.0,
    };
    return preferred.clamp(minHeight, maxHeight).toDouble();
  }

  static int closestLinearCaretIndex({
    required String expression,
    required Size canvasSize,
    required Offset point,
  }) {
    final metrics = _linearMetrics(expression, canvasSize);
    if (metrics.positions.isEmpty) return 0;

    // V172-Q40: filled number/function-argument editing must be digit-gap
    // aware.  The existing midpoint algorithm already gives a useful baseline,
    // but older structural anchors could still steal taps near numeric runs.
    // Prefer the numeric run's own caret gap first, then fall back to the
    // legacy structural anchor/midpoint behavior outside digit bands.
    final glyphIndex = TrueGlyphLevelCaretStopPolicy.rendererAssistedCaretIndexForX(
      expression: expression,
      fallbackPositions: metrics.positions,
      canvasSize: canvasSize,
      x: point.dx,
    );
    if (glyphIndex != null) {
      return glyphIndex.clamp(0, expression.length).toInt();
    }

    final digitIndex = DigitLevelCaretStopPolicy.digitCaretIndexForX(
      expression: expression,
      positions: metrics.positions,
      x: point.dx,
    );
    if (digitIndex != null) {
      return digitIndex.clamp(0, expression.length).toInt();
    }

    final midpointIndex = _caretIndexFromMidpoints(metrics.positions, point.dx);
    final structuralAnchor = _nearestStructuralCaretAnchor(
      expression: expression,
      positions: metrics.positions,
      x: point.dx,
    );
    final insideDigitRun = DigitLevelCaretStopPolicy.isInsideDigitRunBand(
      expression: expression,
      positions: metrics.positions,
      x: point.dx,
    );
    if (!insideDigitRun && structuralAnchor != null) {
      final anchorDistance = (point.dx - metrics.positions[structuralAnchor]).abs();
      final midpointDistance = (point.dx - metrics.positions[midpointIndex]).abs();
      if (anchorDistance <= precisionStructuralSnapRadius && anchorDistance < midpointDistance) {
        return structuralAnchor.clamp(0, expression.length).toInt();
      }
    }
    return midpointIndex.clamp(0, expression.length).toInt();
  }

  static List<double> linearCaretPositionsForExpression({
    required String expression,
    required Size canvasSize,
  }) {
    final metrics = _linearMetrics(expression, canvasSize);
    final glyphPositions = TrueGlyphLevelCaretStopPolicy.rendererAssistedCaretPositions(
      expression: expression,
      fallbackPositions: metrics.positions,
      canvasSize: canvasSize,
    );
    return List<double>.unmodifiable(glyphPositions ?? metrics.positions);
  }

  static List<int> placeholderCaretIndexes(String expression) {
    final indexes = <int>[];
    for (var i = 0; i < expression.length; i += 1) {
      if (expression[i] == '□') indexes.add(i);
    }
    return List<int>.unmodifiable(indexes);
  }

  static Rect inlineCaretRectForExpression({
    required String expression,
    required Size canvasSize,
    int? caretIndex,
  }) {
    final metrics = _linearMetrics(expression, canvasSize);
    final positions = TrueGlyphLevelCaretStopPolicy.rendererAssistedCaretPositions(
      expression: expression,
      fallbackPositions: metrics.positions,
      canvasSize: canvasSize,
    ) ?? metrics.positions;
    final safeIndex = (caretIndex ?? expression.length).clamp(0, math.max(0, expression.length)).toInt();
    final x = positions.isEmpty ? canvasSize.width / 2 : positions[safeIndex];
    final height = _inlineCaretHeight(canvasSize);
    final centerY = _inlineCaretCenterY(canvasSize);
    final top = (centerY - height / 2).clamp(2.0, math.max(2.0, canvasSize.height - height - 2.0)).toDouble();
    return Rect.fromLTWH(x - inlineCaretWidth / 2, top, inlineCaretWidth, height);
  }

  static double linearCaretXForExpression({
    required String expression,
    required Size canvasSize,
    required int caretIndex,
  }) {
    final metrics = _linearMetrics(expression, canvasSize);
    final positions = TrueGlyphLevelCaretStopPolicy.rendererAssistedCaretPositions(
      expression: expression,
      fallbackPositions: metrics.positions,
      canvasSize: canvasSize,
    ) ?? metrics.positions;
    if (positions.isEmpty) return canvasSize.width / 2;
    final safeIndex = caretIndex.clamp(0, math.max(0, expression.length)).toInt();
    return positions[safeIndex];
  }

  static double _inlineCaretHeight(Size canvasSize) {
    return math.max(38.0, math.min(50.0, canvasSize.height * 0.30));
  }

  static double inlineExpressionCenterY(Size canvasSize) {
    // V66: the caret, slot focus ring and renderer band now share one
    // measured optical line. It intentionally stays slightly above exact
    // center to preserve the historic phase-6 baseline contract, but no
    // longer rides so high that digits look detached from the caret.
    if (canvasSize.height >= 160) return canvasSize.height * 0.39;
    if (canvasSize.height >= 132) return canvasSize.height * 0.42;
    if (canvasSize.height >= 96) return canvasSize.height * 0.45;
    return canvasSize.height * 0.47;
  }

  static double inlineRenderBandHeight(Size canvasSize) {
    final preferred = canvasSize.height * 0.66;
    return preferred.clamp(86.0, math.max(86.0, canvasSize.height * 0.82)).toDouble();
  }

  static Rect inlineRenderBandRect(Size canvasSize) {
    final height = inlineRenderBandHeight(canvasSize);
    final centerY = inlineExpressionCenterY(canvasSize);
    final top = (centerY - height / 2).clamp(0.0, math.max(0.0, canvasSize.height - height)).toDouble();
    return Rect.fromLTWH(0, top, canvasSize.width, height);
  }

  static double _inlineCaretCenterY(Size canvasSize) => inlineExpressionCenterY(canvasSize);

  static int _caretIndexFromMidpoints(List<double> positions, double x) {
    if (positions.length <= 1) return 0;
    if (x <= positions.first) return 0;
    for (var index = 0; index < positions.length - 1; index += 1) {
      final midpoint = (positions[index] + positions[index + 1]) / 2;
      if (x <= midpoint) return index;
    }
    return positions.length - 1;
  }

  static _LinearCaretMetrics _linearMetrics(String expression, Size canvasSize) {
    if (expression.isEmpty) {
      return _LinearCaretMetrics(<double>[canvasSize.width / 2]);
    }

    final widths = <double>[
      for (var index = 0; index < expression.length; index += 1) _estimatedGlyphWidthAt(expression, index),
    ];
    final totalWidth = widths.fold<double>(0, (sum, width) => sum + width);
    final maxReasonableWidth = math.max(160.0, canvasSize.width * 0.92);
    final scale = totalWidth > maxReasonableWidth ? maxReasonableWidth / totalWidth : 1.0;
    final visualWidth = totalWidth * scale;
    var cursor = canvasSize.width / 2 - visualWidth / 2;
    final positions = <double>[cursor];
    for (final width in widths) {
      cursor += width * scale;
      positions.add(cursor);
    }
    return _LinearCaretMetrics(positions);
  }

  static int? _nearestStructuralCaretAnchor({
    required String expression,
    required List<double> positions,
    required double x,
  }) {
    final anchors = _structuralCaretAnchors(expression);
    var bestIndex = -1;
    var bestDistance = double.infinity;
    for (final anchor in anchors) {
      if (anchor < 0 || anchor >= positions.length) continue;
      final distance = (x - positions[anchor]).abs();
      if (distance < bestDistance) {
        bestDistance = distance;
        bestIndex = anchor;
      }
    }
    if (bestIndex >= 0 && bestDistance <= precisionStructuralSnapRadius) {
      return bestIndex;
    }
    return null;
  }

  static Set<int> _structuralCaretAnchors(String expression) {
    final anchors = <int>{0, expression.length};
    for (var index = 0; index < expression.length; index += 1) {
      final char = expression[index];
      if (char == '(') {
        anchors.add(index);
        anchors.add(index + 1);
      } else if (char == ')') {
        anchors.add(index);
        anchors.add(index + 1);
      } else if ('+-−×÷=,'.contains(char)) {
        anchors.add(index);
        anchors.add(index + 1);
      }
    }

    for (final name in _functionNames) {
      var start = expression.indexOf(name);
      while (start >= 0) {
        final openParen = start + name.length;
        if (openParen < expression.length && expression[openParen] == '(') {
          anchors.add(start);
          anchors.add(openParen);
          anchors.add(openParen + 1);
        }
        start = expression.indexOf(name, start + 1);
      }
    }

    for (final range in _typedPrimitiveTokenRanges(expression)) {
      anchors.add(range.start);
      anchors.add(range.end);
    }
    for (final range in _numberLiteralRanges(expression)) {
      anchors.add(range.start);
      anchors.add(range.end);
    }
    return anchors.where((index) => index >= 0 && index <= expression.length).toSet();
  }

  static List<({int start, int end})> _typedPrimitiveTokenRanges(String expression) {
    const tokens = <String>[
      'x₁', 'x₂', 'y₁', 'y₂', 'z₁', 'z₂',
      'A₁', 'A₂', 'B₁', 'B₂', 'I₂', 'I₃',
      'y‴', 'y″', 'y′', 'z̄', 'i²', '+∞', '−∞', '−i',
      'dx', 'dy', 'dt', 'dθ',
    ];
    final ranges = <({int start, int end})>[];
    for (final token in tokens) {
      var start = expression.indexOf(token);
      while (start >= 0) {
        ranges.add((start: start, end: start + token.length));
        start = expression.indexOf(token, start + 1);
      }
    }
    return ranges;
  }

  static List<({int start, int end})> _numberLiteralRanges(String expression) {
    final ranges = <({int start, int end})>[];
    for (final match in RegExp(r'(?:\d+(?:\.\d*)?|\.\d+)').allMatches(expression)) {
      ranges.add((start: match.start, end: match.end));
    }
    return ranges;
  }

  static double _estimatedGlyphWidthAt(String expression, int index) {
    final char = expression[index];
    if (_startsFunctionName(expression, index)) return 18;
    if (_isInsideFunctionName(expression, index)) return 16;
    if (char == '(' || char == ')') return 15;
    return _estimatedGlyphWidth(char);
  }

  static bool _startsFunctionName(String expression, int index) {
    for (final name in _functionNames) {
      if (expression.startsWith(name, index)) {
        final openParen = index + name.length;
        if (openParen < expression.length && expression[openParen] == '(') return true;
      }
    }
    return false;
  }

  static bool _isInsideFunctionName(String expression, int index) {
    for (final name in _functionNames) {
      final start = expression.lastIndexOf(name, index);
      if (start < 0) continue;
      final end = start + name.length;
      if (index > start && index < end && end < expression.length && expression[end] == '(') return true;
    }
    return false;
  }

  static const List<String> _functionNames = <String>[
    'sin⁻¹', 'cos⁻¹', 'tan⁻¹', 'log₁₀', 'sinh', 'cosh', 'tanh',
    'sin', 'cos', 'tan', 'ln', 'log₂', 'arg', 'conj', 'cis', 'Re', 'Im',
  ];

  static double _estimatedGlyphWidth(String char) {
    if (char == ' ') return 8;
    if (char == '□') return 32;
    if ('()[]{}'.contains(char)) return 15;
    if ('+-−×÷=,'.contains(char)) return 18;
    if ('⁄/^'.contains(char)) return 17;
    if ('0123456789'.contains(char)) return 20;
    if ('sincotaglrhmdf'.contains(char)) return 17;
    if (char == '√' || char == '∫' || char == 'Σ' || char == 'Π') return 36;
    if ('πθλ∞'.contains(char)) return 22;
    if ('₀₁₂₃₄₅₆₇₈₉ₐᵦₓₙ'.contains(char)) return 13;
    if ('⁰¹²³⁴⁵⁶⁷⁸⁹ⁿ'.contains(char)) return 13;
    return 19;
  }
}

class _LinearCaretMetrics {
  const _LinearCaretMetrics(this.positions);

  final List<double> positions;
}
