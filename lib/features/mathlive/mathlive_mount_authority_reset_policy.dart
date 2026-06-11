/// V172-Q169R24 — MathLive Mount Authority Reset.
///
/// Q169R23 proved that the main surface can still fall back to the old
/// `Q169 KEY:... SEND:Flutter MF:false` path even while the app is supposed to
/// be under the single-source court. Q169R24 makes mount/readiness the first
/// authority: if MathLive is not mounted, the visible diagnostic must show a
/// mount/court state, not a fake Flutter expression or stale key diagnostic.
class MathLiveMountAuthorityResetPolicy {
  const MathLiveMountAuthorityResetPolicy._();

  static const String phase = 'V172-Q169R24';
  static const String initialSummary =
      'MATHLIVE_BOOT WEBVIEW:pending RUNTIME:pending ELEMENT:pending MF:pending CHANNEL:pending ROOT:boot-pending';
  static const String blockedBeforeBridgeRoot = 'mount-authority-blocked-before-bridge';
  static const String blockedBeforeBridgePath = 'runtime-mount-not-authoritative';
  static const String mountRetryReason = 'q169r24-mount-authority-retry-before-command';
  static const String mountBlockedSummaryPrefix = 'MATHLIVE_BOOT';

  static String readinessSummary({
    required bool webViewAttached,
    required bool pageLoaded,
    required bool runtimeMounted,
    required bool mathfieldExists,
    required bool channelCourtVisible,
    required String root,
  }) {
    final webView = webViewAttached ? 'ok' : 'missing';
    final page = pageLoaded ? 'ok' : 'pending';
    final runtime = runtimeMounted ? 'ok' : 'pending';
    final mf = mathfieldExists || runtimeMounted ? 'ok' : 'missing';
    final channel = channelCourtVisible ? 'court-visible' : 'pending';
    return '$mountBlockedSummaryPrefix WEBVIEW:$webView PAGE:$page RUNTIME:$runtime MF:$mf CHANNEL:$channel ROOT:$root';
  }
}
