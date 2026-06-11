/// V172-Q173 — MathLive Native Template Command Normalizer.
///
/// This is the semantic bridge layer after Q170/Q171 visual polish. It keeps
/// the frozen MathPro keyboard vocabulary intact, but normalizes runtime
/// MathLive insert commands so structural templates use MathLive's native
/// editable renderer instead of becoming nested, raw, or visually fake text.
class MathLiveNativeTemplateCommandNormalizerPolicy {
  const MathLiveNativeTemplateCommandNormalizerPolicy._();

  static const String phase = 'V172-Q173';
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool diagnosticOverlayAllowed = false;
  static const bool mathLiveNativeRendererRequired = true;
  static const bool repeatedEmptyTemplateNestingAllowed = false;
  static const bool realDevicePremiumPassClaimed = false;

  static const List<String> normalizedFamilies = <String>[
    'radical',
    'fraction',
    'power',
    'function',
    'calculus',
    'series',
    'systems',
    'matrix',
  ];
}
