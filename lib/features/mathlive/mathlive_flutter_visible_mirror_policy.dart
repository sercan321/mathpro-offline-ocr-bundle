/// V172-Q160 — Flutter visible input mirror fallback.
///
/// Real-device evidence after Q159 showed MathPro keyboard taps were still not
/// appearing in the editor. Q160 keeps the MathLive WebView engine path, but it
/// adds a non-interactive Flutter math mirror over the same editor card so a
/// pressed key cannot disappear behind a failed Android WebView/JS paint path.
/// Retired by V172-Q161 as a production display path; this is kept only as a historical policy record: keyboard layout, key order, MORE,
/// long-press order, MathLive template mappings, Graph, History, Solution, and
/// solver behavior remain unchanged.
class MathLiveFlutterVisibleMirrorPolicy {
  const MathLiveFlutterVisibleMirrorPolicy._();

  static const String phase = 'V172-Q160';
  static const bool enabled = false;
  static const bool usesFlutterMathFallback = false;
  static const bool mirrorIsNonInteractive = true;
  static const bool preservesMathLiveWebViewPath = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool mathLiveMappingMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;
}

// V172-Q161: mirror retired; native MathLive render ownership is mandatory.
