/// V172-Q141 — MathLive Premium Visual Refinement policy.
///
/// This phase continues the real MathLive main-editor repair without changing
/// the protected MathPro keyboard contract. It focuses on premium visual
/// geometry: no visible MathLive badge/chrome, less clipping for radicals,
/// fractions, integrals, limits and sums, smoother pointer/caret ownership, and
/// more vertical breathing room for the MathLive expression surface.
class MathLivePremiumVisualRefinementPolicy {
  const MathLivePremiumVisualRefinementPolicy._();

  static const String phase = 'V172-Q141';
  static const bool realBehaviorRepair = true;
  static const bool mathLiveBadgeMustRemainHidden = true;
  static const bool mathLiveChromeShadowDomKillSwitch = true;
  static const bool pointerDownDoesNotStealMathLiveSelection = true;
  static const bool clickAndPointerUpStateSyncAdded = true;
  static const bool keyboardCommandFocusRestorePreserved = true;
  static const bool mathFieldHeightUsesAutoLayout = true;
  static const bool structuralMathClippingReliefAdded = true;
  static const bool placeholderVisualWeightReduced = true;
  static const bool mathLiveExpressionGetsMoreWorkspaceHeight = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
}
