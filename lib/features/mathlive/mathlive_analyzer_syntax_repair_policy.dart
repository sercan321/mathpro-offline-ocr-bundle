/// V172-Q166 — MathLive Analyzer Syntax Repair.
///
/// Q165 added real-device AppShell visible fallback diagnostics, but a generated
/// newline replacement string in `_prettyExpression()` became an unterminated
/// Dart literal on user-side `flutter analyze`. Q166 is a narrow analyzer/test
/// hygiene repair: it fixes the malformed string literal, keeps the Q165 visible
/// fallback behavior, and keeps the legacy Q153 simple-key helper reachable
/// without double-writing expressions.
class MathLiveAnalyzerSyntaxRepairPolicy {
  const MathLiveAnalyzerSyntaxRepairPolicy._();

  static const String phase = 'V172-Q166';
  static const bool malformedPrettyExpressionStringLiteralRepaired = true;
  static const bool q165VisibleFallbackPreserved = true;
  static const bool q153SimpleKeyFallbackReachableWithoutDuplicateWrites = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
