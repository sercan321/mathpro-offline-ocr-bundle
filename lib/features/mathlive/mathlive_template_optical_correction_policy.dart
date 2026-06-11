/// V172-Q171 — MathLive Template-by-Template Optical Correction Court.
///
/// Visual-only polish after Q170. This policy tightens calculus/system/series/
/// matrix rendering and popup fit without mutating the frozen MathPro keyboard
/// layout, key order, MORE inventory, long-press order, AppShell, Graph,
/// History, Solution, solver, or runtime envelopes.
class MathLiveTemplateOpticalCorrectionPolicy {
  const MathLiveTemplateOpticalCorrectionPolicy._();

  static const String phase = 'V172-Q171';
  static const bool visualOnly = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool diagnosticOverlayAllowed = false;
  static const bool nativeRendererRequired = true;
  static const bool realDevicePremiumPassClaimed = false;
  static const List<String> opticalFamilies = <String>[
    'plain',
    'radical',
    'function',
    'calculus',
    'series',
    'systems',
    'matrix',
    'long',
  ];
}
