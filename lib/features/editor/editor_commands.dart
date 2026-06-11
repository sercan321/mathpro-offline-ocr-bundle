import 'math_node.dart';
import 'node_factory.dart';
import '../formula_engine/math_node_family_policy.dart';
import '../formula_engine/calculus_operator_policy.dart';
import '../formula_engine/structural_insert_delete_safety_policy.dart';
import '../formula_engine/structural_placeholder_restoration_policy.dart';

class AtomicBackspaceEdit {
  const AtomicBackspaceEdit({
    required this.expression,
    required this.caretIndex,
  });

  final String expression;
  final int caretIndex;
}

class StructuralSlotBackspaceEdit {
  const StructuralSlotBackspaceEdit({
    required this.expression,
    required this.caretIndex,
    required this.slotRole,
  });

  final String expression;
  final int caretIndex;
  final String slotRole;
}

class StructuralSlotInsertEdit {
  const StructuralSlotInsertEdit({
    required this.expression,
    required this.caretIndex,
    required this.slotRole,
  });

  final String expression;
  final int caretIndex;
  final String slotRole;
}

class LinkedSeriesSlotEdit {
  const LinkedSeriesSlotEdit({
    required this.expression,
    required this.filledOrdinal,
  });

  final String expression;
  final int filledOrdinal;
}

class _AtomicRange {
  const _AtomicRange(this.start, this.end);

  final int start;
  final int end;
}

class _SeriesLinkProfile {
  const _SeriesLinkProfile({
    required this.template,
    required this.groups,
  });

  final String template;
  final List<String> groups;
}

class _SeriesTemplateMatch {
  const _SeriesTemplateMatch({required this.openGroups});

  final List<String> openGroups;
}

class EditorCommands {
  const EditorCommands._();

  static const Set<String> _atomicFunctionNames = <String>{
    'sin', 'cos', 'tan', 'cot', 'sec', 'csc', 'sinh', 'cosh', 'tanh', 'coth',
    'asin', 'acos', 'atan', 'acot', 'asinh', 'acosh', 'atanh',
    'sin⁻¹', 'cos⁻¹', 'tan⁻¹', 'cot⁻¹', 'sinh⁻¹', 'cosh⁻¹', 'tanh⁻¹',
    'ln', 'log', 'log₁₀', 'log₂', 'log₍□₎', 'log_□', 'abs', 'floor', 'ceil',
    'Re', 'Im', 'arg', 'Arg', 'conj', 'cis', 'det', 'rank', 'rref',
    'round', 'sign', 'minor', 'cofactor', 'pinv', 'proj', 'triple',
    'unit', 'distance', 'EBOB', 'EKOK', 'asal?', 'solve', 'eig',
    'f', 'g', 'h', 'Γ', 'Taylor', 'Maclaurin', 'Geometrik', 'Binom',
    'eˣ serisi', 'sin serisi', 'cos serisi', 'ln serisi', 'arctan serisi',
    '√', '³√', '∛', 'ⁿ√', '∫', '∬', '∭', '∮',
    'd/dx', 'd²/dx²', 'd³/dx³', '∂/∂x', '∂²/∂x²',
    'lim', 'Σ', 'Π',
  };

  static const Set<String> _atomicBrokenFunctionPrefixes = <String>{
    'sin', 'cos', 'tan', 'cot', 'sec', 'csc', 'sinh', 'cosh', 'tanh', 'coth',
    'asin', 'acos', 'atan', 'acot', 'asinh', 'acosh', 'atanh',
    'ln', 'log', 'log₁₀', 'log₂', 'Re', 'Im', 'arg', 'Arg',
    'conj', 'cis', 'det', 'rank', 'rref', 'round', 'sign',
    'EBOB', 'EKOK', 'Γ', 'f', 'g', 'h',
  };

  static const Set<String> _basicOperators = <String>{'+', '-', '−', '×', '÷'};

  /// V153: operator replacement is now boundary-aware for primitive AST
  /// operator tokens without changing the frozen keyboard.  Commands and
  /// template labels stay outside this path; this only covers mathematical
  /// infix/comparison operators that should not accumulate as adjacent raw
  /// characters during phone editing.
  static const Set<String> _replaceableOperatorTokens = <String>{
    '+', '-', '−', '×', '÷', '%', '=', '<', '>', '≤', '≥', '≠', '≈', '≡',
  };

  static bool isReplaceableOperatorToken(String value) => _replaceableOperatorTokens.contains(value);

  static bool shouldReplacePreviousOperator(String previous, String inserted) =>
      isReplaceableOperatorToken(previous) && isReplaceableOperatorToken(inserted);

  static const List<_SeriesLinkProfile> _seriesLinkProfiles = <_SeriesLinkProfile>[
    _SeriesLinkProfile(
      template: 'f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□',
      groups: <String>['x', 'n', 'n', 'a', 'n', 'x', 'a', 'n'],
    ),
    _SeriesLinkProfile(
      template: 'f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□',
      groups: <String>['x', 'n', 'n', 'n', 'x', 'n'],
    ),
    _SeriesLinkProfile(
      template: 'Σ□₌₀∞□·□^□=□⁄(1-□)',
      groups: <String>['n', 'a', 'r', 'n', 'a', 'r'],
    ),
    _SeriesLinkProfile(
      template: '(1+□)^□=Σ□₌₀∞(□C□)□^□',
      groups: <String>['x', 'alpha', 'n', 'alpha', 'n', 'x', 'n'],
    ),
    _SeriesLinkProfile(
      template: 'e^□=Σ□₌₀∞□^□⁄□!',
      groups: <String>['x', 'n', 'x', 'n', 'n'],
    ),
    _SeriesLinkProfile(
      template: 'sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!',
      groups: <String>['x', 'n', 'n', 'x', 'n', 'n'],
    ),
    _SeriesLinkProfile(
      template: 'cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!',
      groups: <String>['x', 'n', 'n', 'x', 'n', 'n'],
    ),
    _SeriesLinkProfile(
      template: 'ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□',
      groups: <String>['x', 'n', 'n', 'x', 'n', 'n'],
    ),
    _SeriesLinkProfile(
      template: 'arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)',
      groups: <String>['x', 'n', 'n', 'x', 'n', 'n'],
    ),
  ];


  static const List<String> _atomicTypedPrimitiveTokens = <String>[
    'x₁', 'x₂', 'y₁', 'y₂', 'z₁', 'z₂',
    'A₁', 'A₂', 'B₁', 'B₂', 'I₂', 'I₃',
    'y‴', 'y″', 'y′', 'z̄', 'i²',
    '+∞', '−∞', '−i', 'dx', 'dy', 'dt', 'dθ',
  ];

  static _AtomicRange? _typedPrimitiveRangeEndingAt(String source, int caretIndex) {
    if (caretIndex <= 0 || caretIndex > source.length) return null;
    final prefix = source.substring(0, caretIndex);
    for (final token in _atomicTypedPrimitiveTokens) {
      if (prefix.endsWith(token)) return _AtomicRange(caretIndex - token.length, caretIndex);
    }
    return null;
  }

  static bool isAtomicTypedPrimitiveToken(String value) => _atomicTypedPrimitiveTokens.contains(value);

  static bool isBasicOperator(String value) => _basicOperators.contains(value);

  static String normalizeVisiblePercent(String value) => value == '%' ? r'\%' : value;

  static AtomicBackspaceEdit? atomicBackspaceAt(
    String expression, {
    required int caretIndex,
    String? activeSlotId,
  }) {
    if (expression.isEmpty) return null;
    final safeCaret = caretIndex.clamp(0, expression.length).toInt();

    if (activeSlotId != null && expression.contains('□')) {
      final slotOrdinal = placeholderOrdinalForSlot(expression, activeSlotId: activeSlotId);
      final slotIndex = slotOrdinal == null ? -1 : _indexOfNthBox(expression, slotOrdinal);
      if (slotIndex >= 0) {
        final range = _atomicRangeContainingIndex(expression, slotIndex);
        if (range != null) {
          return _removeRange(expression, range);
        }
      }
    }

    final endingRange = _atomicRangeEndingAt(expression, safeCaret);
    if (endingRange != null) {
      return _removeRange(expression, endingRange);
    }

    if (safeCaret > 0) {
      final containingRange = _atomicRangeContainingIndex(expression, safeCaret - 1);
      if (containingRange != null && containingRange.end == safeCaret) {
        return _removeRange(expression, containingRange);
      }
    }

    return null;
  }

  static AtomicBackspaceEdit _removeRange(String expression, _AtomicRange range) {
    final start = range.start.clamp(0, expression.length).toInt();
    final end = range.end.clamp(start, expression.length).toInt();
    final nextExpression = expression.replaceRange(start, end, '');
    return AtomicBackspaceEdit(
      expression: nextExpression,
      caretIndex: start.clamp(0, nextExpression.length).toInt(),
    );
  }

  static _AtomicRange? _atomicRangeEndingAt(String source, int caretIndex) {
    if (caretIndex <= 0 || caretIndex > source.length) return null;

    final typedPrimitive = _typedPrimitiveRangeEndingAt(source, caretIndex);
    if (typedPrimitive != null) return typedPrimitive;

    final broken = _brokenFunctionRangeEndingAt(source, caretIndex);
    if (broken != null) return broken;

    final postfix = _postfixRangeEndingAt(source, caretIndex);
    if (postfix != null) return postfix;

    final previous = source[caretIndex - 1];
    if (previous == ')') {
      final openIndex = _matchingOpenParen(source, caretIndex - 1);
      if (openIndex != null) {
        final prefixed = _atomicRangeForCallAtOpenParen(source, openIndex);
        if (prefixed != null && prefixed.end == caretIndex) return prefixed;
      }
    }

    if (previous == ']' || previous == '}' || previous == '|' || previous == '‖' || previous == '⌋' || previous == '⌉') {
      final wrapped = _balancedWrapperRangeEndingAt(source, caretIndex);
      if (wrapped != null) return wrapped;
    }

    return null;
  }

  static _AtomicRange? _atomicRangeContainingIndex(String source, int index) {
    if (index < 0 || index >= source.length) return null;

    final functionRange = _functionRangeContainingIndex(source, index);
    if (functionRange != null) return functionRange;

    final compactRange = _compactTemplateRangeContainingIndex(source, index);
    if (compactRange != null) return compactRange;

    final wrapperRange = _wrapperRangeContainingIndex(source, index);
    if (wrapperRange != null) return wrapperRange;

    return null;
  }

  static _AtomicRange? _functionRangeContainingIndex(String source, int index) {
    for (var open = index; open >= 0; open -= 1) {
      if (source[open] != '(') continue;
      final close = _matchingCloseParen(source, open);
      if (close == null || close < index) continue;
      final range = _atomicRangeForCallAtOpenParen(source, open);
      if (range != null && range.start <= index && index < range.end) return range;
    }
    return null;
  }

  static _AtomicRange? _atomicRangeForCallAtOpenParen(String source, int openIndex) {
    final operatorRange = _readAtomicOperatorBefore(source, openIndex);
    if (operatorRange == null) return null;
    final closeIndex = _matchingCloseParen(source, openIndex);
    if (closeIndex == null) return null;
    var end = closeIndex + 1;

    // Integral templates carry the differential after the body group:
    // ∫(□)dx, ∫_{□}^{□}(□)d□, ∫₀¹(□)dx.
    if (operatorRange.name.startsWith('∫')) {
      final differential = RegExp(r'^d[A-Za-z0-9πθλ□]+').firstMatch(source.substring(end));
      if (differential != null) end += differential.group(0)!.length;
    }

    return _AtomicRange(operatorRange.start, end);
  }

  static ({int start, String name})? _readAtomicOperatorBefore(String source, int openIndex) {
    if (openIndex <= 0) return null;
    var start = openIndex;
    while (start > 0 && _isAtomicOperatorChar(source[start - 1])) {
      start -= 1;
    }
    final rawName = source.substring(start, openIndex);
    if (rawName.isEmpty) return null;
    if (_atomicFunctionNames.contains(rawName)) return (start: start, name: rawName);
    final names = _atomicFunctionNames.toList(growable: false)
      ..sort((left, right) => right.length.compareTo(left.length));
    for (final name in names) {
      if (rawName.endsWith(name)) {
        return (start: openIndex - name.length, name: name);
      }
    }

    // Definite integral shorthand such as ∫_{□}^{□}(□)d□ has a rich prefix.
    final integralStart = source.lastIndexOf('∫', openIndex);
    if (integralStart >= 0 && integralStart < openIndex) {
      final between = source.substring(integralStart, openIndex);
      if (between.startsWith('∫') && (between.contains('}^{') || between.contains('₀¹') || between.contains('ₐᵇ'))) {
        return (start: integralStart, name: '∫');
      }
    }

    return null;
  }

  static bool _isAtomicOperatorChar(String value) {
    return RegExp(r'[A-Za-z0-9πθλ₀₁₂₃₄₅₆₇₈₉₍₎ᵃᵇ⁰¹²³⁴⁵⁶⁷⁸⁹⁻⁺⁽⁾ⁿ²³∂∫√ΓΣΠ/]').hasMatch(value);
  }

  static _AtomicRange? _postfixRangeEndingAt(String source, int caretIndex) {
    if (caretIndex <= 0 || caretIndex > source.length) return null;
    final prefix = source.substring(0, caretIndex);
    const postfixes = <String>['⁻¹', 'ᵀ', 'ᴴ', '!'];
    for (final postfix in postfixes) {
      if (!prefix.endsWith(postfix)) continue;
      final targetEnd = caretIndex - postfix.length;
      if (targetEnd <= 0) return null;

      if (source[targetEnd - 1] == ')') {
        final open = _matchingOpenParen(source, targetEnd - 1);
        if (open != null) return _AtomicRange(open, caretIndex);
      }

      var start = targetEnd;
      while (start > 0 && _isPostfixTargetChar(source[start - 1])) {
        start -= 1;
      }
      if (start < targetEnd) return _AtomicRange(start, caretIndex);
    }
    return null;
  }

  static bool _isPostfixTargetChar(String value) {
    return RegExp(r'[A-Za-z0-9πθλμρφ∞□₀₁₂₃₄₅₆₇₈₉ₙᵢⱼ]').hasMatch(value);
  }

  static _AtomicRange? _compactTemplateRangeContainingIndex(String source, int index) {
    final exactTemplates = <String>[
      '□⁄□', '□/□', '□!', '□⁻¹', '□ᵀ', '□ᴴ', 'A⁻¹', 'Aᵀ', 'B⁻¹', 'Bᵀ', '□P□', '□C□', '□^(□)', 'x_□', 'y_□', 'I_□', '√(□)', '√□', '³√(□)', '∛□', '□√(□)',
      'log₁₀(□)', 'log₂(□)', 'log_□(□)', 'log₍□₎(□)', 'sin⁻¹(□)', 'cos⁻¹(□)', 'tan⁻¹(□)', 'sinh⁻¹(□)', 'cosh⁻¹(□)', 'tanh⁻¹(□)',
      'e^(□)', '10^(□)', 'e^(i□)', 'Σ(□)', 'Π(□)', 'limₓ→□(□)', 'limₓ→0(□)',
      '{□=□;□=□}', '{□=□;□=□;□=□}', '[□ □]', '[□ □; □ □]', '[□]', '‖□‖', '|□|',
    ]..sort((left, right) => right.length.compareTo(left.length));
    for (final template in exactTemplates) {
      var start = source.indexOf(template);
      while (start >= 0) {
        final end = start + template.length;
        if (start <= index && index < end) return _AtomicRange(start, end);
        start = source.indexOf(template, start + 1);
      }
    }
    return null;
  }

  static _AtomicRange? _wrapperRangeContainingIndex(String source, int index) {
    final pairs = <({String open, String close})>[
      (open: '|', close: '|'),
      (open: '‖', close: '‖'),
      (open: '⌊', close: '⌋'),
      (open: '⌈', close: '⌉'),
    ];
    for (final pair in pairs) {
      final start = source.lastIndexOf(pair.open, index);
      if (start < 0) continue;
      final end = source.indexOf(pair.close, start + 1);
      if (end >= index && end > start) return _AtomicRange(start, end + 1);
    }
    return null;
  }

  static _AtomicRange? _balancedWrapperRangeEndingAt(String source, int caretIndex) {
    if (caretIndex <= 1) return null;
    final close = source[caretIndex - 1];
    final open = switch (close) {
      '|' => '|',
      '‖' => '‖',
      '⌋' => '⌊',
      '⌉' => '⌈',
      ']' => '[',
      '}' => '{',
      _ => '',
    };
    if (open.isEmpty) return null;
    final start = source.lastIndexOf(open, caretIndex - 2);
    if (start < 0) return null;
    return _AtomicRange(start, caretIndex);
  }

  static _AtomicRange? _brokenFunctionRangeEndingAt(String source, int caretIndex) {
    final prefix = source.substring(0, caretIndex);
    final names = _atomicBrokenFunctionPrefixes.toList(growable: false)
      ..sort((left, right) => right.length.compareTo(left.length));
    for (final name in names) {
      for (final candidate in <String>['$name(', name]) {
        if (prefix.endsWith(candidate)) {
          return _AtomicRange(caretIndex - candidate.length, caretIndex);
        }
      }
    }
    return null;
  }

  static int _indexOfNthBox(String source, int targetIndex) {
    var seen = 0;
    for (var i = 0; i < source.length; i += 1) {
      if (source[i] != '□') continue;
      if (seen == targetIndex) return i;
      seen += 1;
    }
    return -1;
  }

  static int? _matchingOpenParen(String source, int closeIndex) {
    var depth = 0;
    for (var i = closeIndex; i >= 0; i -= 1) {
      final char = source[i];
      if (char == ')') depth += 1;
      if (char == '(') {
        depth -= 1;
        if (depth == 0) return i;
      }
    }
    return null;
  }

  static int? _matchingCloseParen(String source, int openIndex) {
    var depth = 0;
    for (var i = openIndex; i < source.length; i += 1) {
      final char = source[i];
      if (char == '(') depth += 1;
      if (char == ')') {
        depth -= 1;
        if (depth == 0) return i;
      }
    }
    return null;
  }



  static LinkedSeriesSlotEdit? replaceLinkedSeriesSlot(
    String expression,
    String insertedText, {
    String? activeSlotId,
  }) {
    final normalized = insertedText.trim();
    if (normalized.isEmpty || !expression.contains('□')) return null;

    for (final profile in _seriesLinkProfiles) {
      final match = _matchSeriesTemplate(expression, profile);
      if (match == null) continue;

      final linkedOpenOrdinals = _firstLinkedSeriesOpenOrdinals(match.openGroups);
      if (linkedOpenOrdinals.length <= 1) return null;

      final nextExpression = _replaceOpenBoxesByOrdinal(expression, linkedOpenOrdinals.toSet(), normalized);
      return LinkedSeriesSlotEdit(
        expression: nextExpression,
        filledOrdinal: linkedOpenOrdinals.first,
      );
    }
    return null;
  }

  static _SeriesTemplateMatch? _matchSeriesTemplate(String expression, _SeriesLinkProfile profile) {
    final fragments = profile.template.split('□');
    if (fragments.length != profile.groups.length + 1) return null;

    var cursor = 0;
    final openGroups = <String>[];

    for (var placeholderIndex = 0; placeholderIndex < profile.groups.length; placeholderIndex += 1) {
      final before = fragments[placeholderIndex];
      if (!expression.startsWith(before, cursor)) return null;
      cursor += before.length;

      if (cursor < expression.length && expression[cursor] == '□') {
        openGroups.add(profile.groups[placeholderIndex]);
        cursor += 1;
        continue;
      }

      final nextLiteral = fragments[placeholderIndex + 1];
      if (nextLiteral.isEmpty) {
        if (placeholderIndex == profile.groups.length - 1) {
          cursor = expression.length;
          continue;
        }
        return null;
      }

      final nextIndex = expression.indexOf(nextLiteral, cursor);
      if (nextIndex < 0) return null;
      if (nextIndex == cursor) return null;
      cursor = nextIndex;
    }

    final tail = fragments.last;
    if (!expression.startsWith(tail, cursor)) return null;
    cursor += tail.length;
    if (cursor != expression.length) return null;
    return _SeriesTemplateMatch(openGroups: openGroups);
  }


  static List<int> _firstLinkedSeriesOpenOrdinals(List<String> openGroups) {
    final counts = <String, int>{};
    for (final group in openGroups) {
      counts[group] = (counts[group] ?? 0) + 1;
    }
    for (var index = 0; index < openGroups.length; index += 1) {
      final group = openGroups[index];
      if ((counts[group] ?? 0) <= 1) continue;
      return <int>[
        for (var candidate = 0; candidate < openGroups.length; candidate += 1)
          if (openGroups[candidate] == group) candidate,
      ];
    }
    return const <int>[];
  }

  static String _replaceOpenBoxesByOrdinal(String source, Set<int> ordinals, String replacement) {
    var seen = 0;
    final buffer = StringBuffer();
    for (var i = 0; i < source.length; i += 1) {
      final char = source[i];
      if (char == '□') {
        buffer.write(ordinals.contains(seen) ? replacement : char);
        seen += 1;
      } else {
        buffer.write(char);
      }
    }
    return buffer.toString();
  }

  static String? replaceDerivativeOrderSlot(
    String expression,
    String insertedText, {
    String? activeSlotId,
  }) {
    final normalized = insertedText.trim();
    if (!RegExp(r'^\d+$').hasMatch(normalized)) return null;
    final order = int.tryParse(normalized);
    if (order == null || order < 1 || order > 9) return null;
    if (!expression.contains('y⁽□⁾')) return null;

    final targetSlotIndex = _slotIndexFromId(activeSlotId, expression);
    final templatePattern = RegExp('y⁽□⁾');
    for (final match in templatePattern.allMatches(expression)) {
      final placeholdersBefore = '□'.allMatches(expression.substring(0, match.start)).length;
      if (placeholdersBefore != targetSlotIndex) continue;
      final primeMarks = List.filled(order, "'").join();
      return expression.replaceRange(match.start, match.end, 'y$primeMarks');
    }
    return null;
  }

  /// Replaces the currently selected structural slot, including filled slots.
  /// This is the real-device Phase 18 repair path for structures that no longer
  /// contain an open □, such as `3⁄4`, `log(2)(5)`, and filled limit templates.
  /// Inserts text into the active filled structural slot at the scoped caret
  /// position. V172-Q43 keeps edits such as sin(3|00)+5 -> sin(3500),
  /// log₍2₎(5|00)+9 -> log₍2₎(5900), x^(1|2)+3 -> x^(132), and
  /// 12⁄3|45+9 -> 12⁄3945 inside their selected slot instead of replacing
  /// the whole structural payload.
  static StructuralSlotInsertEdit? insertIntoSelectedSlotPayload(
    String expression,
    String insertedText, {
    String? activeSlotId,
    required int caretIndex,
  }) {
    if (activeSlotId == null || expression.trim().isEmpty) return null;
    final normalized = insertedText.trim();
    if (normalized.isEmpty) return null;

    final canonicalExpression = _canonicalEditorExpression(expression);
    final tree = NodeFactory.rootFromExpression(canonicalExpression);
    final slot = _selectedSlotNodeFromTree(tree, activeSlotId);
    if (slot == null || _isOpenPlaceholder(slot)) return null;

    final role = _roleForSelectedSlot(tree, activeSlotId, slot);
    final payload = _plainSerialize(slot);
    if (!StructuralInsertDeleteSafetyPolicy.shouldInsertInsideFilledSlot(
      slotRole: role,
      payload: payload,
      insertedText: normalized,
    )) {
      return null;
    }

    final safeCaret = StructuralInsertDeleteSafetyPolicy.safePayloadCaretIndex(payload, caretIndex);
    final nextPayload = payload.replaceRange(safeCaret, safeCaret, normalized);
    final replacement = NodeFactory.box(children: _parseReplacement(nextPayload));
    final replaced = _replaceSlotInTree(tree, activeSlotId, replacement);
    if (replaced == null) return null;

    final nextExpression = restoreStructuralPlaceholders(_plainSerialize(replaced));
    if (StructuralInsertDeleteSafetyPolicy.containsBrokenAtomicTail(nextExpression)) return null;
    return StructuralSlotInsertEdit(
      expression: nextExpression,
      caretIndex: (safeCaret + normalized.length).clamp(0, nextPayload.length).toInt(),
      slotRole: role,
    );
  }

  static String? replaceSelectedSlot(String expression, String insertedText, {String? activeSlotId}) {
    final normalized = insertedText.trim();
    if (activeSlotId == null || normalized.isEmpty || expression.trim().isEmpty) return null;
    final canonicalExpression = _canonicalEditorExpression(expression);
    final tree = NodeFactory.rootFromExpression(canonicalExpression);
    final replacement = NodeFactory.box(children: _parseReplacement(normalized));
    final replaced = _replaceSlotInTree(tree, activeSlotId, replacement);
    if (replaced == null) return null;
    return restoreStructuralPlaceholders(_plainSerialize(replaced));
  }

  /// Deletes one character inside the selected filled structural slot before
  /// falling back to clearing the whole slot. V172-G keeps premium math editing
  /// scoped: Backspace inside `sin(300)`, `12⁄345`, `x^(12)`, `log₍2₎(5)`,
  /// or `√(123)` edits the active slot payload first instead of collapsing the
  /// entire node to `□`.
  static StructuralSlotBackspaceEdit? backspaceSelectedSlotPayload(
    String expression, {
    String? activeSlotId,
    required int caretIndex,
  }) {
    if (activeSlotId == null || expression.trim().isEmpty) return null;
    final canonicalExpression = _canonicalEditorExpression(expression);
    final tree = NodeFactory.rootFromExpression(canonicalExpression);
    final slot = _selectedSlotNodeFromTree(tree, activeSlotId);
    if (slot == null || _isOpenPlaceholder(slot)) return null;
    final role = _roleForSelectedSlot(tree, activeSlotId, slot);
    final payload = _plainSerialize(slot);
    if (payload.trim().isEmpty || payload.trim() == '□') return null;
    final safeCaret = caretIndex.clamp(0, payload.length).toInt();
    if (safeCaret <= 0) return null;

    final nextPayload = payload.replaceRange(safeCaret - 1, safeCaret, '');
    final replacement = nextPayload.trim().isEmpty
        ? NodeFactory.placeholder(role: role)
        : NodeFactory.box(children: _parseReplacement(nextPayload));
    final replaced = _replaceSlotInTree(tree, activeSlotId, replacement);
    if (replaced == null) return null;
    return StructuralSlotBackspaceEdit(
      expression: restoreStructuralPlaceholders(_plainSerialize(replaced)),
      caretIndex: (safeCaret - 1).clamp(0, nextPayload.length).toInt(),
      slotRole: role,
    );
  }

  /// Clears a selected structural slot back to a real editable placeholder.
  /// Unlike [clearFirstOpenSlot], this also works when numerator/denominator,
  /// log base/body, limit target/body, or Σ/Π slots are already filled.
  static String? clearSelectedSlot(String expression, {String? activeSlotId}) {
    if (activeSlotId == null || expression.trim().isEmpty) return null;
    final canonicalExpression = _canonicalEditorExpression(expression);
    final tree = NodeFactory.rootFromExpression(canonicalExpression);
    final slot = _selectedSlotNodeFromTree(tree, activeSlotId);
    final role = _roleForSelectedSlot(tree, activeSlotId, slot);
    final replaced = _replaceSlotInTree(tree, activeSlotId, NodeFactory.placeholder(role: role));
    if (replaced == null) return null;
    return restoreStructuralPlaceholders(_plainSerialize(replaced));
  }


  static String _canonicalEditorExpression(String expression) {
    final primary = MathNodeFamilyPolicy.canonicalDisplayForPrimaryFamilies(expression);
    return CalculusOperatorPolicy.canonicalDisplayForCalculusFamilies(primary);
  }

  static List<MathNode> _parseReplacement(String text) {
    return NodeFactory.rootFromExpression(text).children;
  }

  static String _roleForSelectedSlot(MathNode tree, String activeSlotId, MathNode? slot) {
    final metaRole = slot?.meta['role'] as String?;
    if (metaRole != null && metaRole.isNotEmpty) return metaRole;
    final separator = activeSlotId.lastIndexOf('.');
    if (separator < 0) return _roleFromSlotId(activeSlotId);
    final nodeId = activeSlotId.substring(0, separator);
    final slotKey = activeSlotId.substring(separator + 1);
    final owner = _findNodeById(tree, nodeId);
    if (owner == null) return _roleFromSlotId(activeSlotId);
    return _roleForOwnerSlot(owner, slotKey);
  }

  static String _roleForOwnerSlot(MathNode owner, String slotKey) {
    switch (owner.kind) {
      case MathNodeKind.postfix:
        if (slotKey == 'target') return 'postfixTarget';
        break;
      case MathNodeKind.limit:
        if (slotKey == 'variable') return 'limitVariable';
        if (slotKey == 'target') return 'limitTarget';
        if (slotKey == 'body') return 'limitBody';
        break;
      case MathNodeKind.integral:
        if (slotKey == 'upper') return 'integralUpperLimit';
        if (slotKey == 'lower') return 'integralLowerLimit';
        if (slotKey == 'body') return 'integralBody';
        if (slotKey == 'differential') return 'integralDifferential';
        break;
      case MathNodeKind.power:
        if (slotKey == 'base') return 'powerBase';
        if (slotKey == 'exponent') return 'powerExponent';
        break;
      case MathNodeKind.subscript:
        if (slotKey == 'base') return 'subscriptBase';
        if (slotKey == 'subscript') return 'subscript';
        break;
      case MathNodeKind.sqrt:
        if (slotKey == 'value') return 'sqrtValue';
        break;
      case MathNodeKind.indexedRoot:
        if (slotKey == 'index') return 'rootIndex';
        if (slotKey == 'value') return 'sqrtValue';
        break;
      case MathNodeKind.logBase:
        if (slotKey == 'base') return 'logBase';
        if (slotKey == 'arg') return 'functionArgument';
        break;
      case MathNodeKind.functionCall:
        if (slotKey == 'arg') return 'functionArgument';
        final argIndex = RegExp(r'^arg_(\d+)$').firstMatch(slotKey);
        if (argIndex != null) {
          final index = int.tryParse(argIndex.group(1) ?? '0') ?? 0;
          return index <= 0 ? 'functionArgument' : 'functionArgument${index + 1}';
        }
        break;
      case MathNodeKind.derivative:
        if (slotKey == 'body') return 'derivativeBody';
        if (slotKey == 'variable') return 'derivativeVariable';
        break;
      case MathNodeKind.matrix:
      case MathNodeKind.vector:
        if (slotKey.startsWith('cell_')) return 'matrixCell';
        break;
      case MathNodeKind.piecewise:
        if (slotKey.startsWith('left_')) return 'systemLeft';
        if (slotKey.startsWith('right_')) return 'systemRight';
        break;
      case MathNodeKind.bigOperator:
        if (owner.operator == 'Π') {
          if (slotKey == 'upper') return 'productUpperLimit';
          if (slotKey == 'lower') return 'productLowerLimit';
          if (slotKey == 'body') return 'productBody';
        }
        if (slotKey == 'upper') return 'sumUpperLimit';
        if (slotKey == 'lower') return 'sumLowerLimit';
        if (slotKey == 'body') return 'sumBody';
        break;
      default:
        break;
    }
    return _roleFromSlotId('${owner.id}.$slotKey');
  }

  static String _roleFromSlotId(String activeSlotId) {
    final key = activeSlotId.contains('.') ? activeSlotId.split('.').last : activeSlotId;
    if (key.startsWith('cell_')) return 'matrixCell';
    if (key.startsWith('left_')) return 'systemLeft';
    if (key.startsWith('right_')) return 'systemRight';
    return switch (key) {
      'numerator' => 'fractionNumerator',
      'denominator' => 'fractionDenominator',
      'base' => activeSlotId.contains('log') ? 'logBase' : 'powerBase',
      'index' => 'rootIndex',
      'value' => 'sqrtValue',
      'arg' => 'functionArgument',
      'target' => 'limitTarget',
      'variable' => 'limitVariable',
      'body' => 'body',
      'upper' => 'sumUpperLimit',
      'lower' => 'sumLowerLimit',
      'exponent' => 'powerExponent',
      'subscript' => 'subscript',
      _ => 'body',
    };
  }

  static MathNode? _replaceSlotInTree(MathNode node, String activeSlotId, MathNode replacement) {
    final separator = activeSlotId.lastIndexOf('.');
    if (separator < 0) {
      if (node.id == activeSlotId) return replacement;
    } else {
      final nodeId = activeSlotId.substring(0, separator);
      final slotKey = activeSlotId.substring(separator + 1);
      if (node.id == nodeId && node.slots.containsKey(slotKey)) {
        return node.copyWith(slots: <String, MathNode>{...node.slots, slotKey: replacement});
      }
    }

    var changed = false;
    final nextChildren = <MathNode>[];
    for (final child in node.children) {
      final next = _replaceSlotInTree(child, activeSlotId, replacement);
      nextChildren.add(next ?? child);
      changed = changed || next != null;
    }

    final nextSlots = <String, MathNode>{};
    for (final item in node.slots.entries) {
      final next = _replaceSlotInTree(item.value, activeSlotId, replacement);
      nextSlots[item.key] = next ?? item.value;
      changed = changed || next != null;
    }

    if (!changed) return null;
    return node.copyWith(children: nextChildren, slots: nextSlots);
  }

  static String replaceFirstOpenSlot(String expression, String insertedText, {String? activeSlotId}) {
    if (insertedText.isEmpty) return expression;
    final source = expression.isEmpty ? '□' : expression;
    final slotIndex = _slotIndexFromId(activeSlotId, source);
    return _replaceNthBox(source, insertedText, slotIndex);
  }

  static String clearFirstOpenSlot(String expression, {String? activeSlotId}) {
    if (!expression.contains('□')) return expression;
    final slotIndex = _slotIndexFromId(activeSlotId, expression);
    return _replaceNthBox(expression, '□', slotIndex);
  }

  static bool hasAddressableOpenSlot(String expression, {String? activeSlotId}) {
    if (!expression.contains('□')) return false;
    final slotIndex = _slotIndexFromId(activeSlotId, expression);
    return slotIndex >= 0 && slotIndex < '□'.allMatches(expression).length;
  }


  /// Returns the visual placeholder ordinal for the currently active slot.
  /// This is used by the V64 template-slot navigation layer: after a slot is
  /// filled, focus should advance to the next visible open □ instead of jumping
  /// back to the first slot or leaving the user without a focus target.
  static int? placeholderOrdinalForSlot(String expression, {String? activeSlotId}) {
    if (!expression.contains('□') || activeSlotId == null) return null;
    final slotIndex = _slotIndexFromId(activeSlotId, expression);
    final count = '□'.allMatches(expression).length;
    if (slotIndex < 0 || slotIndex >= count) return null;
    return slotIndex;
  }

  static int openSlotCount(String expression) => '□'.allMatches(expression).length;

  static String restoreStructuralPlaceholders(String expression) =>
      StructuralPlaceholderRestorationPolicy.normalizeAfterEdit(expression);

  /// Returns a conservative payload for the current lightweight selection model.
  /// Empty/open slots intentionally return null so toolbar actions never destroy
  /// the whole expression just because a slot highlight is visible. Filled slots
  /// that the lightweight parser can identify, such as integral differential
  /// boxes, return their plain payload. Full rich selection remains a later
  /// renderer-bound editor feature.
  static String? selectedSlotPayload(String expression, {String? activeSlotId}) {
    if (activeSlotId == null || expression.trim().isEmpty) return null;
    final canonicalExpression = _canonicalEditorExpression(expression);
    final tree = NodeFactory.rootFromExpression(canonicalExpression);
    final slotNode = _selectedSlotNodeFromTree(tree, activeSlotId);
    if (slotNode == null) return null;
    final role = _roleForSelectedSlot(tree, activeSlotId, slotNode);
    if (_isOpenPlaceholder(slotNode)) {
      // V172-P5 real-log repair: editable subscript templates such as `x_□`
      // must expose the lower-index placeholder as the active payload so the
      // slot can be replaced without being mistaken for a fixed display atom
      // like `x₈`. Other open placeholders keep the older conservative null
      // behavior to avoid destructive toolbar actions on broad empty slots.
      return role == 'subscript' ? '□' : null;
    }
    final payload = _plainSerialize(slotNode).trim();
    if (payload.isEmpty) return null;
    if (payload == '□') return role == 'subscript' ? '□' : null;
    return payload;
  }


  static MathNode? _findNodeById(MathNode node, String id) {
    if (node.id == id) return node;
    for (final child in node.children) {
      final found = _findNodeById(child, id);
      if (found != null) return found;
    }
    for (final slot in node.slots.values) {
      final found = _findNodeById(slot, id);
      if (found != null) return found;
    }
    return null;
  }

  static bool _isOpenPlaceholder(MathNode node) {
    if (node.kind == MathNodeKind.placeholder) return true;
    if (node.kind == MathNodeKind.box && node.children.isEmpty) return true;
    return false;
  }

  static String _plainSlotValue(MathNode? node, {String fallback = '□'}) {
    if (node == null) return fallback;
    final value = _plainSerialize(node).trim();
    return value.isEmpty ? fallback : value;
  }

  static String _plainSerialize(MathNode node) {
    switch (node.kind) {
      case MathNodeKind.text:
      case MathNodeKind.number:
      case MathNodeKind.symbol:
      case MathNodeKind.constant:
      case MathNodeKind.operatorToken:
      case MathNodeKind.delimiter:
        return node.text ?? '';
      case MathNodeKind.box:
      case MathNodeKind.row:
        return node.children.map(_plainSerialize).join();
      case MathNodeKind.placeholder:
        return '□';
      case MathNodeKind.fraction:
        return '${_structuralSlotAtom(node.slots['numerator']!)}⁄${_structuralSlotAtom(node.slots['denominator']!)}';
      case MathNodeKind.sqrt:
        return '√(${_plainSlotValue(node.slots['value'])})';
      case MathNodeKind.indexedRoot:
        return '${_structuralSlotAtom(node.slots['index']!)}√(${_plainSlotValue(node.slots['value'])})';
      case MathNodeKind.power:
        return '${_structuralSlotAtom(node.slots['base']!)}^(${_plainSerialize(node.slots['exponent']!)})';
      case MathNodeKind.subscript:
        return '${_structuralSlotAtom(node.slots['base']!)}_${_structuralSlotAtom(node.slots['subscript']!)}';
      case MathNodeKind.integral:
        final lower = node.slots['lower'];
        final upper = node.slots['upper'];
        final body = _plainSlotValue(node.slots['body']);
        final differential = _plainSlotValue(node.slots['differential']);
        final differentialToken = differential.startsWith('d') ? differential : 'd$differential';
        if (lower != null && upper != null) {
          return '∫_{${_plainSlotValue(lower)}}^{${_plainSlotValue(upper)}}($body)$differentialToken';
        }
        return '∫($body)$differentialToken';
      case MathNodeKind.derivative:
        final operator = node.operator ?? 'd/dx';
        final body = node.slots['body'];
        if (operator == 'dy/dx' || operator == 'd²y/dx²') return operator;
        return '$operator(${_plainSlotValue(body)})';
      case MathNodeKind.bigOperator:
        final operator = node.operator ?? 'Σ';
        final lower = _plainSerialize(node.slots['lower'] ?? NodeFactory.placeholder(role: operator == 'Π' ? 'productLowerLimit' : 'sumLowerLimit'));
        final upper = _plainSerialize(node.slots['upper'] ?? NodeFactory.placeholder(role: operator == 'Π' ? 'productUpperLimit' : 'sumUpperLimit'));
        final body = _plainSerialize(node.slots['body'] ?? NodeFactory.placeholder(role: operator == 'Π' ? 'productBody' : 'sumBody'));
        return '${operator}_{$lower}^{$upper}($body)';
      case MathNodeKind.limit:
        final variable = _plainSerialize(node.slots['variable'] ?? NodeFactory.box(children: <MathNode>[NodeFactory.text('x')])).trim();
        final target = _plainSerialize(node.slots['target'] ?? NodeFactory.placeholder(role: 'limitTarget')).trim();
        final body = _plainSerialize(node.slots['body'] ?? NodeFactory.placeholder(role: 'limitBody')).trim();
        return 'lim₍${variable.isEmpty ? 'x' : variable}→${target.isEmpty ? '□' : target}₎(${body.isEmpty ? '□' : body})';
      case MathNodeKind.functionCall:
        return _plainSerializeFunctionCall(node);
      case MathNodeKind.matrix:
        return _plainSerializeMatrix(node);
      case MathNodeKind.vector:
        return _plainSerializeVector(node);
      case MathNodeKind.piecewise:
        return _plainSerializePiecewise(node);
      case MathNodeKind.series:
        return _plainSerializeSeries(node);
      case MathNodeKind.logBase:
        return 'log₍${_plainSlotValue(node.slots['base'])}₎(${_plainSlotValue(node.slots['arg'])})';
      case MathNodeKind.postfix:
        final target = _plainSerialize(node.slots['target'] ?? NodeFactory.placeholder(role: 'postfixTarget'));
        return '$target${node.operator ?? node.text ?? ''}';
      case MathNodeKind.unknown:
        return node.text ?? '';
    }
  }



  static String _plainSerializeFunctionCall(MathNode node) {
    final operator = node.operator ?? 'f';
    final argKeys = node.slots.keys.where((key) => RegExp(r'^arg_\d+$').hasMatch(key)).toList()..sort();
    if (argKeys.isNotEmpty) {
      final args = <String>[
        for (final key in argKeys) _plainSerialize(node.slots[key]!).trim().isEmpty ? '□' : _plainSerialize(node.slots[key]!),
      ];
      if (operator == 'combination' && args.length >= 2) return '${_structuralSlotAtom(node.slots[argKeys[0]]!)}C${_structuralSlotAtom(node.slots[argKeys[1]]!)}';
      if (operator == 'permutation' && args.length >= 2) return '${_structuralSlotAtom(node.slots[argKeys[0]]!)}P${_structuralSlotAtom(node.slots[argKeys[1]]!)}';
      return '$operator(${args.join(',')})';
    }

    final arg = node.slots['arg'];
    final body = _plainSlotValue(arg);
    if (operator.contains('∘')) return '($operator)($body)';
    return '$operator($body)';
  }

  static String _plainSerializeMatrix(MathNode node) {
    final rows = (node.meta['rows'] as int?) ?? 2;
    final columns = (node.meta['columns'] as int?) ?? 2;
    final shape = node.meta['shape'] as String?;
    String cell(int row, int column) {
      final slot = node.slots['cell_${row}_$column'];
      return slot == null ? '□' : _plainSerialize(slot);
    }

    if (shape == 'mnPreview') {
      final lastRow = (rows - 1).clamp(0, rows).toInt();
      final lastColumn = (columns - 1).clamp(0, columns).toInt();
      return '[${cell(0, 0)} … ${cell(0, lastColumn)}; … ; ${cell(lastRow, 0)} … ${cell(lastRow, lastColumn)}]';
    }

    final rowValues = <String>[];
    for (var row = 0; row < rows; row += 1) {
      final cells = <String>[];
      for (var column = 0; column < columns; column += 1) {
        cells.add(cell(row, column));
      }
      rowValues.add(cells.join(' '));
    }
    return '[${rowValues.join('; ')}]';
  }

  static String _plainSerializeVector(MathNode node) {
    final dimension = (node.meta['dimension'] as int?) ?? 2;
    final column = (node.meta['column'] as bool?) ?? true;
    final shape = node.meta['shape'] as String?;
    final cells = <String>[];
    for (var index = 0; index < dimension; index += 1) {
      final slot = node.slots['cell_$index'];
      if (slot == null && shape == 'nPreview') {
        cells.add('…');
      } else {
        cells.add(slot == null ? '□' : _plainSerialize(slot));
      }
    }
    return column ? '[${cells.join('; ')}]' : '[${cells.join(' ')}]';
  }

  static String _plainSerializePiecewise(MathNode node) {
    final rows = (node.meta['rows'] as int?) ?? 2;
    final shape = node.meta['shape'] as String?;
    final relationMeta = node.meta['relations'];
    final relationMap = relationMeta is Map ? relationMeta : const <Object?, Object?>{};
    final rowsText = <String>[];
    for (var row = 0; row < rows; row += 1) {
      if (shape == 'nPreview' && row == 1) {
        rowsText.add('…');
        continue;
      }
      final left = node.slots['left_$row'];
      final right = node.slots['right_$row'];
      if (left == null && right == null) continue;
      final relation = relationMap['row_$row']?.toString() ?? (node.meta['defaultRelation'] as String? ?? '=');
      rowsText.add('${left == null ? '□' : _plainSerialize(left)}$relation${right == null ? '□' : _plainSerialize(right)}');
    }
    return '{${rowsText.join(';')}}';
  }

  static String _plainSerializeSeries(MathNode node) {
    final type = node.meta['type'] as String? ?? '';
    String slot(String key, {String fallback = '□'}) {
      final value = node.slots[key];
      if (value == null) return fallback;
      final serialized = _plainSerialize(value).trim();
      return serialized.isEmpty ? fallback : serialized;
    }

    switch (type) {
      case 'taylor':
        return 'f(${slot('variable')})=Σ${slot('index')}₌₀∞(f⁽${slot('order')}⁾(${slot('center')})⁄${slot('factorial')}!)(${slot('base')}-${slot('shift')})^${slot('exponent')}';
      case 'maclaurin':
        return 'f(${slot('variable')})=Σ${slot('index')}₌₀∞(f⁽${slot('order')}⁾(0)⁄${slot('factorial')}!)${slot('base')}^${slot('exponent')}';
      case 'geometric':
        return 'Σ${slot('index')}₌₀∞${slot('coefficient')}·${slot('ratio')}^${slot('exponent')}=${slot('numerator')}⁄(1-${slot('denominatorRatio')})';
      case 'binomial':
        return '(1+${slot('variable')})^${slot('parameter')}=Σ${slot('index')}₌₀∞(${slot('chooseTop')}C${slot('chooseBottom')})${slot('base')}^${slot('exponent')}';
      case 'e':
      case 'exp':
      case 'ePower':
        return 'e^${slot('variable')}=Σ${slot('index')}₌₀∞${slot('base')}^${slot('exponent')}⁄${slot('denominator')}!';
      case 'sin':
        return 'sin(${slot('variable')})=Σ${slot('index')}₌₀∞((-1)^${slot('signIndex')}·${slot('base')}^(2${slot('exponent')}+1))⁄(2${slot('denominator')}+1)!';
      case 'cos':
        return 'cos(${slot('variable')})=Σ${slot('index')}₌₀∞((-1)^${slot('signIndex')}·${slot('base')}^(2${slot('exponent')}))⁄(2${slot('denominator')})!';
      case 'ln':
        return 'ln(1+${slot('variable')})=Σ${slot('index')}₌₁∞((-1)^(${slot('signIndex')}+1)·${slot('base')}^${slot('exponent')})⁄${slot('denominator')}';
      case 'arctan':
        return 'arctan(${slot('variable')})=Σ${slot('index')}₌₀∞((-1)^${slot('signIndex')}·${slot('base')}^(2${slot('exponent')}+1))⁄(2${slot('denominator')}+1)';
      default:
        return node.slots.entries.map((entry) => _plainSerialize(entry.value)).join();
    }
  }


  static String _structuralSlotAtom(MathNode node) {
    final value = _plainSerialize(node).trim();
    if (value.isEmpty) return '□';
    if (value == '□') return value;
    final alreadyWrapped = value.startsWith('(') && value.endsWith(')');
    final needsGrouping = value.contains('+') || value.contains('−') || value.contains('×') || value.contains('÷') || value.contains('=') || value.contains(' ') || (value.contains('-') && !value.startsWith('-'));
    return needsGrouping && !alreadyWrapped ? '($value)' : value;
  }

  static int _slotIndexFromId(String? slotId, String expression) {
    if (slotId == null || expression.trim().isEmpty) return 0;

    final canonicalExpression = _canonicalEditorExpression(expression);
    final tree = NodeFactory.rootFromExpression(canonicalExpression);
    final selected = _selectedSlotNodeFromTree(tree, slotId);
    if (selected != null) {
      final resolved = _placeholderIndexForNode(tree, selected.id);
      if (resolved != null) return resolved;
    }

    // Conservative legacy fallback for expressions that have not yet been
    // promoted to a complete MathNode template. The structural path above is
    // the authority for Phase B and prevents false index mapping in fraction,
    // integral, power, and matrix templates.
    final slotKey = slotId.contains('.') ? slotId.split('.').last : slotId;
    final matrixMatch = RegExp(r'cell_(\d+)_(\d+)').firstMatch(slotKey);
    if (matrixMatch != null) {
      final row = int.tryParse(matrixMatch.group(1) ?? '0') ?? 0;
      final column = int.tryParse(matrixMatch.group(2) ?? '0') ?? 0;
      final placeholderCount = '□'.allMatches(expression).length;
      final columns = placeholderCount >= 9 ? 3 : 2;
      return row * columns + column;
    }

    return switch (slotKey) {
      'denominator' || 'exponent' || 'target' => 1,
      'differential' => 2,
      _ => 0,
    };
  }

  static MathNode? _selectedSlotNodeFromTree(MathNode tree, String activeSlotId) {
    final separator = activeSlotId.lastIndexOf('.');
    if (separator < 0) return _findNodeById(tree, activeSlotId);
    final nodeId = activeSlotId.substring(0, separator);
    final slotKey = activeSlotId.substring(separator + 1);
    final owner = _findNodeById(tree, nodeId);
    return owner?.slots[slotKey];
  }

  static int? _placeholderIndexForNode(MathNode tree, String targetNodeId) {
    var index = 0;
    int? found;

    void visit(MathNode node) {
      if (found != null) return;
      if (node.id == targetNodeId) {
        final offset = _firstPlaceholderOffset(node);
        if (offset != null) {
          found = index + offset;
          return;
        }
      }
      if (_isOpenPlaceholder(node)) {
        if (node.id == targetNodeId) {
          found = index;
          return;
        }
        index += 1;
        return;
      }
      for (final child in node.children) {
        visit(child);
        if (found != null) return;
      }
      for (final slot in node.slots.values) {
        visit(slot);
        if (found != null) return;
      }
    }

    visit(tree);
    return found;
  }

  static int? _firstPlaceholderOffset(MathNode node) {
    var offset = 0;
    int? found;

    void visit(MathNode current) {
      if (found != null) return;
      if (_isOpenPlaceholder(current)) {
        found = offset;
        return;
      }
      for (final child in current.children) {
        visit(child);
        if (found != null) return;
      }
      for (final slot in current.slots.values) {
        visit(slot);
        if (found != null) return;
      }
    }

    visit(node);
    return found;
  }

  static String _replaceNthBox(String source, String replacement, int targetIndex) {
    var seen = 0;
    final buffer = StringBuffer();
    for (var i = 0; i < source.length; i += 1) {
      final char = source[i];
      if (char == '□') {
        if (seen == targetIndex) {
          buffer.write(replacement);
        } else {
          buffer.write(char);
        }
        seen += 1;
      } else {
        buffer.write(char);
      }
    }
    if (seen == 0) return source + replacement;
    return buffer.toString();
  }
}
