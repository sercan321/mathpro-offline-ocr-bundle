/// V172-Q151 — MathLive Extended Template Court.
///
/// This phase closes the remaining package-side semantic gaps where visible
/// keyboard, MORE, or long-press labels could still fall through into the
/// MathLive main editor as raw display text. It is intentionally limited to the
/// main-editor bridge mapping and evidence files: it does not mutate keyboard
/// layout, key order, MORE category order, long-press order, Graph, History,
/// Solution, solver behavior, or the MathLive visual chrome contract.
class MathLiveExtendedTemplateCourtPolicy {
  const MathLiveExtendedTemplateCourtPolicy._();

  static const String phase = 'V172-Q151';
  static const bool realBehaviorRepair = true;
  static const bool mainEditorBridgeOnly = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool keyOrderMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool solverExpansionClaimed = false;
  static const bool cursorPassClaimed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const List<String> extendedCourtLabels = <String>[
    'Kuadratik',
    '(x+y)²',
    '∫₀¹ f(x)',
    'lim sin(x)/x',
    '2×2 Matris',
    'Mutlak',
    'Yuvarla',
    'Kalan',
    'RREF',
    'Rank',
    'Özdeğer',
    'Çöz',
    'A⁻¹',
    'Aᵀ',
    'B⁻¹',
    'Bᵀ',
    'z̄',
    '−i',
    'i²',
    '□ᴴ',
    '≠',
    '≤',
    '≥',
    '≈',
    '≡',
    '+∞',
    '−∞',
    'λ',
    'μ',
    'ρ',
    'φ',
  ];
}
