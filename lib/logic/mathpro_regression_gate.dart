import '../features/keyboard/key_config.dart';
import 'action_utils.dart';
import 'premium_math_key_specs.dart';

/// Release-facing regression gate for MathPro's sacred contracts.
///
/// This is not a solver and it does not alter keyboard mappings.  It centralizes
/// the non-negotiable checks that repeatedly caused real-device regressions:
/// sacred tab/core labels, visible programmer-token leakage, and preview labels
/// drifting away from the math display contract.
class MathProRegressionGate {
  const MathProRegressionGate._();

  static const String version = 'mathpro-v107-regression-contract-gate';

  static const List<String> expectedTabs = <String>[
    'Temel',
    'Cebir',
    'Kalkülüs',
    'Kompleks',
    'Lineer Cebir',
  ];

  static const List<List<String?>> expectedBasicCoreKeyboard = <List<String?>>[
    <String?>['C', '⌫', '%', '÷'],
    <String?>['7', '8', '9', '×'],
    <String?>['4', '5', '6', '−'],
    <String?>['1', '2', '3', '+'],
    <String?>['MORE', '0', '.', 'Ans'],
  ];

  static const Set<String> sacredVisibleLabels = <String>{
    'MORE',
    'Ans',
    '↵',
    '=',
    'Temel',
    'Cebir',
    'Kalkülüs',
    'Kompleks',
    'Lineer Cebir',
  };

  static const Map<String, String> _visibleLeakReplacements = <String, String>{
    'asin(': 'sin⁻¹(',
    'acos(': 'cos⁻¹(',
    'atan(': 'tan⁻¹(',
    'acot(': 'cot⁻¹(',
    'asinh(': 'sinh⁻¹(',
    'acosh(': 'cosh⁻¹(',
    'atanh(': 'tanh⁻¹(',
    'log_10': 'log₁₀',
    'log_2': 'log₂',
    'log_□(□)': 'log₍□₎(□)',
    'x_n': 'x_□',
    'y_n': 'y_□',
    'I_n': 'I_□',
  };

  /// Last-resort visible-label guard.  Render-specific canonicalizers may make
  /// richer transformations, but this gate blocks raw programmer syntax from
  /// escaping through compact labels, popups, MORE chips or fallbacks.
  static String guardVisibleLabel(String value) {
    var output = value.trim();
    if (output.isEmpty) return output;
    for (final entry in _visibleLeakReplacements.entries) {
      output = output.replaceAll(entry.key, entry.value);
    }
    output = output.replaceAllMapped(
      RegExp(r'\blog\(([^()]*)\)\(([^()]*)\)'),
      (match) => 'log₍${match.group(1)!.trim()}₎(${match.group(2)!.trim()})',
    );
    output = output.replaceAllMapped(
      RegExp(r'\blim_?([A-Za-zπθλ])\s*→\s*([^()]+)\(([^()]*)\)'),
      (match) => 'lim₍${match.group(1)!}→${match.group(2)!.trim()}₎(${match.group(3)!.trim()})',
    );
    return output;
  }

  static bool hasForbiddenVisibleToken(String value) {
    final raw = value.trim();
    final guarded = guardVisibleLabel(raw);
    return _containsForbiddenVisibleToken(raw) || _containsForbiddenVisibleToken(guarded);
  }

  static bool _containsForbiddenVisibleToken(String value) {
    return RegExp(r'\b(?:asin|acos|atan|asinh|acosh|atanh|acot)\s*\(').hasMatch(value) ||
        RegExp(r'\b(?:log_10|log_2|x_n|y_n|I_n)\b').hasMatch(value) ||
        RegExp(r'\blog\([^)]*\)\([^)]*\)').hasMatch(value) ||
        RegExp(r'\blim_?[A-Za-zπθλ]\s*→').hasMatch(value);
  }

  static List<String> visibleTokenLeaks(Iterable<String> labels) {
    final leaks = <String>[];
    for (final label in labels) {
      if (hasForbiddenVisibleToken(label)) leaks.add(label);
    }
    leaks.sort();
    return leaks;
  }

  static List<String> sacredCoreDriftFindings() {
    final findings = <String>[];
    if (!_listEquals(KeyConfig.tabs, expectedTabs)) {
      findings.add('tab-order-drift:${KeyConfig.tabs.join('|')}');
    }
    if (!_nestedListEquals(KeyConfig.basicCoreKeyboard, expectedBasicCoreKeyboard)) {
      findings.add('basic-core-keyboard-drift');
    }
    final flattenedCore = KeyConfig.basicCoreKeyboard.expand((row) => row.whereType<String>()).toSet();
    for (final label in const <String>['MORE', 'Ans']) {
      if (!flattenedCore.contains(label)) findings.add('missing-sacred-core-label:$label');
    }
    return findings;
  }

  static Set<String> knownVisibleLabels() {
    final labels = <String>{};
    labels.addAll(sacredVisibleLabels);
    labels.addAll(KeyConfig.tabs);
    labels.addAll(KeyConfig.basicCoreKeyboard.expand((row) => row.whereType<String>()));
    labels.addAll(KeyConfig.premiumSpecialtyRows.values.expand((rows) => rows.expand((row) => row.whereType<String>())));
    labels.addAll(KeyConfig.longPressMap.keys);
    labels.addAll(KeyConfig.longPressMap.values.expand((options) => options));
    labels.addAll(KeyConfig.keyInsertTextMap.keys);
    labels.addAll(ActionUtils.premiumTemplates.map((spec) => spec.label));
    labels.addAll(ActionUtils.premiumTemplates.map((spec) => spec.expression));
    labels.addAll(ActionUtils.morePanelCategories.map((category) => category.title));
    labels.addAll(ActionUtils.morePanelCategories.expand((category) => category.labels));
    labels.addAll(PremiumMathKeySpecs.all.map((spec) => spec.label));
    labels.addAll(PremiumMathKeySpecs.all.map((spec) => spec.expression));
    return labels;
  }

  static List<String> releaseGateFindings({Iterable<String>? visibleLabels}) {
    final findings = <String>[];
    findings.addAll(sacredCoreDriftFindings());
    final leaks = visibleTokenLeaks(visibleLabels ?? knownVisibleLabels());
    if (leaks.isNotEmpty) findings.add('visible-token-leaks:${leaks.join('|')}');
    return findings;
  }

  static bool _listEquals<T>(List<T> left, List<T> right) {
    if (left.length != right.length) return false;
    for (var index = 0; index < left.length; index++) {
      if (left[index] != right[index]) return false;
    }
    return true;
  }

  static bool _nestedListEquals<T>(List<List<T?>> left, List<List<T?>> right) {
    if (left.length != right.length) return false;
    for (var row = 0; row < left.length; row++) {
      if (!_listEquals(left[row], right[row])) return false;
    }
    return true;
  }
}
