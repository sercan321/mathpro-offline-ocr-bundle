import '../features/keyboard/key_config.dart';
import '../features/keyboard/key_model.dart' show MathKeyCell;
import 'action_utils.dart';
import 'premium_math_key_specs.dart';
import 'premium_math_surface_policy.dart';
import 'math_template_contract_registry.dart';

class MathKeyAuditEntry {
  const MathKeyAuditEntry({
    required this.label,
    required this.sources,
    required this.behavior,
    required this.templateExpression,
    required this.focusRole,
  });

  final String label;
  final Set<String> sources;
  final KeyBehaviorType behavior;
  final String templateExpression;
  final String? focusRole;

  PremiumMathKeySpec? get premiumSpec => PremiumMathKeySpecs.specFor(label);
  MathTemplateContract? get templateContract => MathTemplateContractRegistry.contractFor(label);
  bool get isSpecBacked => premiumSpec != null || templateContract != null;
  bool get hasSpecSlotContract => templateContract?.requiresEditableSlot ?? (premiumSpec?.requiresEditableSlot ?? false);

  bool get isCommand => behavior == KeyBehaviorType.command;
  bool get isStructure => behavior == KeyBehaviorType.structureInsert || behavior == KeyBehaviorType.wrapper || behavior == KeyBehaviorType.postfix;
  bool get hasEditableSlot => templateExpression.contains('□');
  bool get exposesInternalProgrammerToken => MathKeyInventory.programmerTokenUiDenylist.contains(label);
}

class MathKeyInventory {
  const MathKeyInventory._();

  // These labels are kept only as legacy/internal parser aliases. They must not
  // appear in public keyboard rows, long-press options, or MORE chips.
  static const Set<String> programmerTokenUiDenylist = PremiumMathSurfacePolicy.internalProgrammerLabels;

  static const Set<String> commandLabels = <String>{'C', '⌫', 'MORE', 'Ans', '↵'};

  /// V136: every public keyboard, MORE and long-press label must be classified.
  /// Structural labels are covered by PremiumMathKeySpecs or the template
  /// contract registry.  The labels below are intentionally primitive text
  /// symbols/operators/constants and should keep text insertion semantics.
  /// V150 removes fixed subscripts, prime derivatives, overlines, fixed powers,
  /// differentials, signed infinities and signed imaginary atoms from this set;
  /// they are now spec-backed structural atoms.
  static const Set<String> primitiveTextLabels = <String>{
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    '.', ',', ';', '(', ')', '[', ']',
    '+', '−', '×', '÷', '%', '=', '≠', '<', '>', '≤', '≥', '≈', '≡',
    'x', 'y', 'z',
    'a', 'b', 'c', 'n', 'm', 'k',
    'A', 'B', 'I',
    'π', 'e', 'φ', 'i', 'θ', 'r', 'ρ', 'λ', 'μ',
    'rad', 'deg',
    '∞',
  };

  static Set<String> get keyboardLabels {
    final labels = <String>{};
    for (final tab in KeyConfig.tabs) {
      final sections = KeyConfig.buildKeyboardSections(tab);
      final rows = sections.expandedGridRows ?? sections.coreRows ?? const <List<MathKeyCell>>[];
      for (final row in rows) {
        for (final cell in row) {
          final label = cell.label;
          if (label != null && label.isNotEmpty) labels.add(label);
        }
      }
    }
    return labels;
  }

  static Set<String> get longPressLabels {
    final labels = <String>{};
    for (final entry in KeyConfig.longPressMap.entries) {
      labels.add(entry.key);
      labels.addAll(entry.value);
    }
    return labels;
  }

  static Set<String> get moreLabels => <String>{
        for (final category in ActionUtils.morePanelCategories) ...category.labels,
      };

  static Set<String> get publicUiLabels => <String>{
        ...keyboardLabels,
        ...longPressLabels,
        ...moreLabels,
      };

  static Set<String> get publicUiProgrammerTokenLeaks => publicUiLabels.intersection(programmerTokenUiDenylist);

  static Map<String, Set<String>> get labelSources {
    final sources = <String, Set<String>>{};
    void add(String label, String source) {
      sources.putIfAbsent(label, () => <String>{}).add(source);
    }

    for (final label in keyboardLabels) {
      add(label, 'keyboard');
    }
    for (final label in longPressLabels) {
      add(label, 'longPress');
    }
    for (final label in moreLabels) {
      add(label, 'MORE');
    }
    return sources;
  }

  static Set<String> get classifiedPublicUiLabels => <String>{
        ...commandLabels,
        ...primitiveTextLabels,
        for (final label in publicUiLabels)
          if (MathTemplateContractRegistry.contractFor(label) != null) label,
        for (final label in publicUiLabels)
          if (PremiumMathKeySpecs.specFor(label) != null) label,
      };

  static Set<String> get unclassifiedPublicUiLabels =>
      publicUiLabels.difference(classifiedPublicUiLabels);

  static Set<String> get primitiveLabelsOutsidePublicUi =>
      primitiveTextLabels.difference(publicUiLabels);

  static List<MathKeyAuditEntry> get entries {
    final sources = labelSources;
    final labels = sources.keys.toList()..sort();
    return <MathKeyAuditEntry>[
      for (final label in labels)
        MathKeyAuditEntry(
          label: label,
          sources: sources[label]!,
          behavior: KeyConfig.getKeyBehavior(label),
          templateExpression: ActionUtils.templateSpecForStructure(label).expression,
          focusRole: ActionUtils.templateSpecForStructure(label).focusRole,
        ),
    ];
  }

  static List<MathKeyAuditEntry> get structuralEntries => entries.where((entry) {
        if (entry.isCommand) return false;
        if (entry.isStructure) return true;
        if (entry.sources.contains('MORE')) return true;
        if (entry.label.contains('□')) return true;
        if (entry.label.contains('∫') || entry.label.contains('Σ') || entry.label.contains('Π')) return true;
        if (entry.label.contains('√') || entry.label.contains('⁄')) return true;
        if (entry.label.contains('⁻') || entry.label.contains('ᵀ') || entry.label.contains('ᴴ')) return true;
        return false;
      }).toList(growable: false);

  static List<MathKeyAuditEntry> get structuralEntriesWithoutSlots => structuralEntries.where((entry) {
        // Fixed postfix labels such as x⁻¹ do not introduce a new open slot,
        // while slot-backed postfix templates such as □! must keep their
        // postfixTarget slot contract visible to tests and editor routing.
        if (entry.behavior == KeyBehaviorType.postfix && !entry.label.contains('□')) return false;
        if (entry.label == '=' || entry.label == '≠' || entry.label == '<' || entry.label == '>' || entry.label == '≤' || entry.label == '≥' || entry.label == '≈' || entry.label == '≡') return false;
        if (entry.label == 'deg' || entry.label == 'rad') return false;
        return !entry.hasEditableSlot;
      }).toList(growable: false);

  static List<MathKeyAuditEntry> get structuralEntriesWithLeakedProgrammerTokens => structuralEntries.where((entry) {
        final expression = entry.templateExpression;
        return expression.contains('asin(') ||
            expression.contains('acos(') ||
            expression.contains('atan(') ||
            expression.contains('asinh(') ||
            expression.contains('acosh(') ||
            expression.contains('atanh(') ||
            expression.contains('acot(');
      }).toList(growable: false);



  /// Phase-04: every public label in this set must be backed by a
  /// PremiumMathKeySpec. This is intentionally broader than the first risk
  /// families; it covers the visible keyboard, long-press and MORE surfaces
  /// that users perceive as mathematical objects rather than plain text.
  static const Set<String> phase04RequiredSpecLabels = <String>{
    'x_□', 'y_□', 'I_□', 'y⁽□⁾', '□/□', '□^□', '√□', '∛□', '□√□', '|□|', '‖□‖',
    'sin', 'cos', 'tan', 'sin⁻¹(□)', 'cos⁻¹(□)', 'tan⁻¹(□)', 'sinh(□)', 'cosh(□)', 'tanh(□)',
    'sinh⁻¹(□)', 'cosh⁻¹(□)', 'tanh⁻¹(□)', 'cot', 'cot(□)', 'acot', 'acot(□)', 'cot⁻¹(□)', 'coth', 'coth(□)', 'sec', 'sec(□)', 'csc', 'csc(□)',
    'ln', 'ln(□)', 'log', 'log₁₀(□)', 'log₂(□)', 'log_□(□)', 'Re(□)', 'real(□)', 'Im(□)', 'imag(□)', 'arg(□)', 'Arg(□)', 'cis(□)', 'e^(i□)',
    'd/dx', 'd/dx(□)', 'd²/dx²(□)', 'd³/dx³(□)', '∂/∂x(□)', '∂²/∂x²(□)', 'dy/dx', 'd²y/dx²',
    '∫□dx', '∫ₐᵇ', '∬', '∭', '∮', '∫₀¹ f(x)', 'lim', 'lim x→□', 'lim x→∞', 'lim x→0⁺', 'lim x→0⁻', 'lim sin(x)/x',
    'Σ', 'Π', 'Taylor', 'Maclaurin', 'Geometrik', 'Binom', 'eˣ serisi', 'sin serisi', 'cos serisi', 'ln serisi', 'arctan serisi',
    '[□ □]', '[□]', '2×2', '2×2 Matris', '3×3', '4×4', 'm×n', '2D vektör', '3D vektör', 'nD vektör', 'satır vektörü', 'sütun vektörü',
    'det(□)', 'RREF', 'Rank', 'Özdeğer', 'Çöz', '□⁻¹', '□ᵀ', '□ᴴ', '□·□', 'dot(□,□)', '□×□', 'cross(□,□)', '0 matris',
    'f(□)', 'g(□)', 'h(□)', 'f(□,□)', 'f∘g', 'Kuadratik', '(x+y)²', 'Euler', '{□=□', '{3 denklem', '{n denklem', '{≤ sistem',
    '□!', '□P□', '□C□', 'Γ(□)', 'Kalan', 'EBOB', 'EKOK', 'Asal mı?', '⌊□⌋', '⌈□⌉', 'Yuvarla', 'İşaret',
    'minör', 'kofaktör', 'pseudo-inverse', 'Moore-Penrose', 'projeksiyon', 'karma çarpım', 'triple product', 'birim vektör', 'mesafe',
  };

  static Set<String> get missingPhase04RequiredSpecLabels {
    final publicRequired = phase04RequiredSpecLabels.intersection(publicUiLabels);
    return publicRequired.difference(<String>{...PremiumMathKeySpecs.labels, ...MathTemplateContractRegistry.labels});
  }

  static List<MathKeyAuditEntry> get phase04RequiredSpecEntries => entries.where((entry) => phase04RequiredSpecLabels.contains(entry.label)).toList(growable: false);

  static List<MathKeyAuditEntry> get phase04RequiredSpecEntriesWithoutSpecs => phase04RequiredSpecEntries.where((entry) => !entry.isSpecBacked).toList(growable: false);

  static List<MathKeyAuditEntry> get protectedSurfaceEntries => entries.where((entry) {
        final label = entry.label;
        if (entry.isCommand) return false;
        if (entry.isStructure) return true;
        if (PremiumMathKeySpecs.labels.contains(label) || MathTemplateContractRegistry.labels.contains(label)) return true;
        if (label.contains('□')) return true;
        if (label.contains('√') || label.contains('∫') || label.contains('Σ') || label.contains('Π')) return true;
        if (label.contains('⁻¹') || label.contains('⁄') || label.contains('⌊') || label.contains('⌈')) return true;
        return false;
      }).toList(growable: false);

  static List<MathKeyAuditEntry> get protectedSurfaceEntriesWithoutSpecs => protectedSurfaceEntries.where((entry) {
        // Plain relation signs and unit toggles are text/operator controls, not
        // structural math templates. They stay outside the MathKeySpec contract.
        if (entry.behavior == KeyBehaviorType.textInsert && !entry.label.contains('□')) return false;
        if (entry.behavior == KeyBehaviorType.postfix) return false;
        return !entry.isSpecBacked;
      }).toList(growable: false);

  static List<MathKeyAuditEntry> get specBackedPublicEntries => entries.where((entry) => entry.isSpecBacked).toList(growable: false);

  static List<MathKeyAuditEntry> get contractBackedPublicEntries => entries.where((entry) => entry.templateContract != null).toList(growable: false);

  /// V138: high-risk visible templates that must survive the full
  /// label → action → template expression → node → slot → TeX path without
  /// falling back to raw text or programmer-token MathJax.  This list is
  /// intentionally sourced from actual public labels only, so the audit cannot
  /// pass by checking templates that are not exposed in the keyboard, MORE, or
  /// long-press surfaces.
  static Set<String> get highRiskParserSerializerLabels => <String>{
        for (final label in publicUiLabels)
          if (_isHighRiskParserSerializerLabel(label)) label,
      };

  static bool _isHighRiskParserSerializerLabel(String label) {
    if (commandLabels.contains(label) || primitiveTextLabels.contains(label)) return false;
    if (PremiumMathKeySpecs.specFor(label) == null && MathTemplateContractRegistry.contractFor(label) == null) return false;
    return label.contains('□') ||
        label.contains('lim') ||
        label.contains('∫') ||
        label.contains('Σ') ||
        label.contains('Π') ||
        label.contains('serisi') ||
        label == 'Taylor' ||
        label == 'Maclaurin' ||
        label == 'Geometrik' ||
        label == 'Binom' ||
        label.contains('⁻¹') ||
        label.contains('ᵀ') ||
        label.contains('ᴴ') ||
        label.contains('√') ||
        label.contains('⁄') ||
        label.contains('C□') ||
        label.contains('P□') ||
        label.contains('∘');
  }
}
