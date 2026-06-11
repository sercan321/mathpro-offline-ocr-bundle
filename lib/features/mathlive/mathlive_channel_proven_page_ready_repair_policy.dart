/// V172-Q169R30 — Channel-Proven Page Ready Repair.
///
/// Real-device Q169R29 evidence showed a contradictory boot state:
/// WEBVIEW:ok PAGE:pending RUNTIME:pending MF:missing CHANNEL:court-visible.
/// A visible court channel push can only arrive after the HTML page and
/// MathPro JS bridge are alive, so the PAGE:pending flag was stale and blocked
/// queued MathPro keyboard commands before the mount probe could run.
class MathLiveChannelProvenPageReadyRepairPolicy {
  const MathLiveChannelProvenPageReadyRepairPolicy._();

  static const String phase = 'V172-Q169R30';
  static const String evidence =
      'WEBVIEW:ok PAGE:pending RUNTIME:pending MF:missing CHANNEL:court-visible';
  static const String channelProvenPageReadyRoot =
      'q169r30-channel-proven-page-ready-recovered-before-mount';
  static const String channelProvenPageReadyReason =
      'q169r30-channel-proven-page-ready-bridge-boot-probe';
  static const String channelProvenQueueFlushReason =
      'q169r30-channel-proven-page-ready-queue-flush';

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool premiumVisualPolishAllowed = false;
  static const bool realDevicePaintPassClaimed = false;

  static bool channelMessageProvesPageReady({
    required bool webViewAttached,
    required bool pageLoaded,
    required bool channelCourtVisible,
  }) {
    return webViewAttached && (!pageLoaded || channelCourtVisible);
  }
}
