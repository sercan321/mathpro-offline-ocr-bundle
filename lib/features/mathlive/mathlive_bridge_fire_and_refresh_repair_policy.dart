/// V172-Q169R6 — MathLive Bridge Fire-and-Refresh Repair.
///
/// Real-device Q169R5 evidence showed that the command had advanced from
/// SEND:Queued to SEND:Bridge, but the Android WebView returning-result ack
/// could remain at JS:pending while the visible surface stayed on fallback:
/// `SEND:Bridge JS:pending MF:true INSERT:false VALUE:empty PAINT:pending`.
///
/// Q169R6 keeps the richer returning-result path when it works, but prevents a
/// stuck WebView ack from blocking the real MathLive command. If the ack times
/// out or returns empty, the command is fired through the non-returning WebView
/// JS path, which still triggers the bridge's MathProMathLiveState channel and
/// is followed by short state refresh probes. This is a bridge dispatch repair,
/// not a visual polish phase and not a real-device PASS claim.
class MathLiveBridgeFireAndRefreshRepairPolicy {
  const MathLiveBridgeFireAndRefreshRepairPolicy._();

  static const String phase = 'V172-Q169R6';
  static const String repairName = 'MathLive Bridge Fire-and-Refresh Repair';

  static const bool returningResultMustNotBlockDispatch = true;
  static const bool fireAndRefreshAfterPendingAck = true;
  static const bool consumeAsyncChannelStateForDiagnostics = true;

  static const Duration returningResultAckTimeout = Duration(milliseconds: 700);
  static const Duration statePollTimeout = Duration(milliseconds: 450);
  static const Duration firstRefreshDelay = Duration(milliseconds: 70);
  static const Duration secondRefreshDelay = Duration(milliseconds: 160);

  static const String timeoutSentinel = '__q169r6_returning_result_timeout__';
  static const String fireAndRefreshMarker = 'q169r6-fire-and-refresh-after-pending-ack';
  static const String asyncChannelDiagnosticMarker = 'q169r6-async-channel-state-diagnostic-sync';
}
