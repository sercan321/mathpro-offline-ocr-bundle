/// V172-Q174 — MathLive Native Renderer Purity Finalization.
///
/// This package-side policy documents the next premium step after Q173:
/// the user-facing expression must be owned by MathLive's native renderer,
/// while MathPro only supplies clean template intent and light container
/// styling. It intentionally avoids changing the frozen keyboard layout,
/// MORE inventory, long-press order, AppShell, Graph, History, and Solution
/// surfaces.
class MathLiveNativeRendererPurityFinalizationPolicy {
  const MathLiveNativeRendererPurityFinalizationPolicy._();

  static const String phase = 'V172-Q174';
  static const String previousTemplateNormalizerPhase = 'V172-Q173';
  static const bool nativeMathLiveRendererRemainsOwner = true;
  static const bool reduceCssMimicryOfMathLiveInternals = true;
  static const bool preserveNativeActivePlaceholderInsertion = true;
  static const bool suppressDuplicateEmptyTemplateRepeat = true;
  static const bool userFacingDiagnosticOverlayAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePremiumPassClaimed = false;
}
