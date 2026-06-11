/// V172-Q161 — Native MathLive Render Ownership Repair.
///
/// Real-device evidence after Q160 showed that the Flutter mirror made input
/// visible but exposed raw MathLive insert payloads such as `\\sqrt{#0}`. This
/// phase retires the mirror as a production display path and makes the official
/// MathLive `<math-field>` the only structural renderer. Insert-control tokens
/// may exist only in `mathfield.insert(...)` payloads; they must never be written
/// into visible fallback text, controller mirror state, or WebView host text.
class MathLiveNativeRenderOwnershipPolicy {
  const MathLiveNativeRenderOwnershipPolicy._();

  static const String phase = 'V172-Q161';
  static const bool mathFieldIsOnlyStructuralRenderer = true;
  static const bool flutterVisibleMirrorEnabled = false;
  static const bool rawInsertTokensMayBeUserVisible = false;
  static const bool rawInsertTokensMayEnterSetLatex = false;
  static const bool structuralTemplateFallbackMayShowRawLatex = false;
  static const bool visibleFallbackMayRenderStructuralTemplates = false;
  static const bool queueFlushMustBeSinglePass = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool mathLiveMappingMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static bool containsRawInsertToken(String latex) {
    return latex.contains('#0') || latex.contains('#?') || latex.contains('#@');
  }

  static bool looksStructuralTemplate(String latex) {
    final value = latex.trim();
    return value.contains(r'\frac') ||
        value.contains(r'\sqrt') ||
        value.contains(r'\int') ||
        value.contains(r'\sum') ||
        value.contains(r'\prod') ||
        value.contains(r'\lim') ||
        value.contains(r'\begin{cases}') ||
        value.contains(r'\begin{bmatrix}') ||
        value.contains('^') ||
        value.contains('_');
  }

  static String documentLatexFromInsertPayload(String latex) {
    return latex
        .replaceAll('#@', r'\placeholder{}')
        .replaceAll('#0', r'\placeholder{}')
        .replaceAll('#?', r'\placeholder{}')
        .replaceAll(RegExp(r'\\textstyle\s+\\textstyle\s+'), r'\textstyle ')
        .trim();
  }
}
