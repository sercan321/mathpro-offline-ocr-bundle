import '../keyboard/key_config.dart';
import 'mathlive_keyboard_bridge_policy.dart';

/// V172-Q187 — Template Command Contract Freeze.
///
/// This phase freezes the production MathPro-key-label -> MathLive-template
/// contract after the Q184-Q186 minimal production surface/HTML/bridge split.
/// It does not change keyboard layout, key order, MORE inventory, long-press
/// order, Graph, History, Solution, solver behavior, or the production bridge
/// public API. It only makes the existing template command coverage auditable:
/// every structural/wrapper/postfix MathPro label must resolve to an explicit
/// main-editor MathLive template payload and must not fall through as raw text
/// such as `Taylor`, `{3 denklem`, `√□`, `Σ`, or `∫□dx`.
class MathLiveTemplateCommandContractFreezePolicy {
  const MathLiveTemplateCommandContractFreezePolicy._();

  static const String phase = 'V172-Q187';
  static const bool templateCommandContractFrozen = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool productionBridgePublicApiMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool rawNamedTemplateFallbackAllowed = false;
  static const bool rawStructuralGlyphFallbackAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePremiumPassClaimed = false;

  static const List<String> criticalTemplateLabels = <String>[
    '□/□',
    '√□',
    '□^□',
    '□!',
    '|□|',
    'sin',
    'cos',
    'tan',
    'ln',
    'log',
    'd/dx',
    '∫□dx',
    '∫ₐᵇ',
    'lim',
    'Σ',
    'Π',
    'Taylor',
    'Maclaurin',
    'Geometrik',
    'Binom',
    'eˣ serisi',
    'sin serisi',
    'cos serisi',
    'ln serisi',
    'arctan serisi',
    '{□=□',
    '{3 denklem',
    '{n denklem',
    '3 Denklem',
    'n Denklem',
    '[□ □]',
    '[□]',
    '2×2',
    '3×3',
    '4×4',
    'm×n',
    'det(□)',
    'RREF',
    'Rank',
    'Özdeğer',
    'Çöz',
  ];

  static const List<String> rawFallbackForbiddenLabels = <String>[
    'Taylor',
    'Maclaurin',
    'Geometrik',
    'Binom',
    'eˣ serisi',
    'sin serisi',
    'cos serisi',
    'ln serisi',
    'arctan serisi',
    '{3 denklem',
    '{n denklem',
    '3 Denklem',
    'n Denklem',
    'Kuadratik',
    'RREF',
    'Rank',
    'Özdeğer',
    'Çöz',
  ];

  static const List<String> rawStructuralGlyphForbiddenLabels = <String>[
    '□/□',
    '□⁄□',
    '√□',
    '∛□',
    '□√□',
    '□^□',
    '□!',
    '|□|',
    '‖□‖',
    '∫□dx',
    '∫ₐᵇ',
    'Σ',
    'Π',
    '[□ □]',
    '[□]',
  ];

  static Iterable<String> structuralKeyboardLabels() sync* {
    for (final entry in KeyConfig.keyBehaviorMap.entries) {
      final behavior = entry.value;
      if (behavior == KeyBehaviorType.structureInsert ||
          behavior == KeyBehaviorType.wrapper ||
          behavior == KeyBehaviorType.postfix) {
        yield entry.key;
      }
    }
  }

  static bool hasExplicitMainEditorTemplate(String label) {
    return MathLiveKeyboardBridgePolicy.mainEditorTemplateLatexCommands.containsKey(label);
  }

  static bool commandPayloadIsSemantic(String label, {String lastAnswer = ''}) {
    final command = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel(label, lastAnswer: lastAnswer);
    if (!command.accepted || command.action != 'insertLatex') return false;
    final latex = command.latex.trim();
    if (latex.isEmpty) return false;
    if (latex == label) return false;
    if (rawFallbackForbiddenLabels.contains(label) && latex.contains(label)) return false;
    if (rawStructuralGlyphForbiddenLabels.contains(label) && latex == label) return false;
    return true;
  }

  static List<String> missingExplicitTemplateLabels() {
    final missing = <String>[];
    for (final label in structuralKeyboardLabels()) {
      if (!hasExplicitMainEditorTemplate(label)) missing.add(label);
    }
    return List<String>.unmodifiable(missing);
  }

  static List<String> rawFallbackViolations() {
    final violations = <String>[];
    for (final label in structuralKeyboardLabels()) {
      if (!commandPayloadIsSemantic(label)) violations.add(label);
    }
    for (final label in criticalTemplateLabels) {
      if (!commandPayloadIsSemantic(label)) violations.add(label);
    }
    return List<String>.unmodifiable(violations.toSet().toList()..sort());
  }
}
