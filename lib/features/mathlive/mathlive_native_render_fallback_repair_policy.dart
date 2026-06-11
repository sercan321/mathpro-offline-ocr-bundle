/// V172-Q162 — Native MathLive Render Fallback Repair.
///
/// Q161 correctly stopped raw MathLive insert payloads such as `\\sqrt{#0}` from
/// becoming user-visible. Real-device evidence then showed that when the
/// official `<math-field>` does not mount or does not paint, structural input
/// can become invisible again. Q162 restores a sanitized WebView-host fallback:
/// insert tokens are stripped first, then the host may show safe glyphs like
/// `√□` or `□⁄□`. This is not the retired Q160 Flutter mirror and it does not
/// change keyboard layout, MORE, long-press order, Graph, History, or Solution.
class MathLiveNativeRenderFallbackRepairPolicy {
  const MathLiveNativeRenderFallbackRepairPolicy._();

  static const String phase = 'V172-Q162';
  static const bool sanitizedStructuralFallbackAllowed = true;
  static const bool rawInsertTokenFallbackAllowed = false;
  static const bool flutterVisibleMirrorRevived = false;
  static const bool mathFieldStillPreferredRenderer = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
