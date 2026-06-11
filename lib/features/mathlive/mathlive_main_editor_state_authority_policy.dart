/// V172-Q144 — MathLive Main Editor State Authority Policy.
///
/// Q144 closes the raw Flutter shadow-write hole introduced during the first
/// main-editor migration: MathPro keyboard labels may still be visible labels,
/// but the main editor expression is owned by the MathLive bridge snapshot.
/// This prevents named buttons such as Taylor / 3 Denklem from being echoed
/// back into the WebView as plain text after the semantic MathLive template was
/// inserted.
class MathLiveMainEditorStateAuthorityPolicy {
  const MathLiveMainEditorStateAuthorityPolicy._();

  static const String phase = 'V172-Q144';
  static const String snapshotSource = 'q144-mathlive-authoritative-snapshot';
  static const String clearSource = 'q144-mathlive-authoritative-clear';

  static const bool mathLiveSnapshotOwnsMainExpression = true;
  static const bool rawFlutterLabelShadowWritesAllowed = false;
  static const bool namedTemplateLabelsMayEnterControllerAsPlainText = false;
  static const bool mathfieldMayBeOverwrittenByRoutineKeyEcho = false;
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static String authoritativeExpression({
    required String normalizedExpression,
    required String normalizedLatex,
    required String plainText,
  }) {
    final normalized = normalizedExpression.trim();
    if (normalized.isNotEmpty) return normalized;
    final latex = normalizedLatex.trim();
    if (latex.isNotEmpty) return latex;
    return plainText.trim();
  }

  static bool mayAcceptExternalExpressionSync({
    required String incomingExpression,
    required String lastBridgeExpression,
  }) {
    final incoming = incomingExpression.trim();
    final bridge = lastBridgeExpression.trim();
    if (incoming.isEmpty) return bridge.isNotEmpty;
    if (incoming == bridge) return false;

    // Explicit restore/history/paste can still drive MathLive. Routine key
    // echo is suppressed by AppShell before it reaches this point.
    return true;
  }

  static bool isPlainNamedTemplateLeak(String expression) {
    final trimmed = expression.trim().toLowerCase();
    return trimmed == 'taylor' ||
        trimmed == 'maclaurin' ||
        trimmed == 'geometrik' ||
        trimmed == 'binom' ||
        trimmed == '3denklem' ||
        trimmed == '3 denklem' ||
        trimmed == 'n denklem';
  }
}
