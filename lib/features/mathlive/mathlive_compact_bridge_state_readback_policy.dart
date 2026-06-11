/// V172-Q169R16 — MathLive compact bridge state readback policy.
///
/// Q169R15 real-device evidence showed `SEND:Bridge JS:fire MF:true` with
/// `FAIL:state-refresh-timeout-after-js-fire`, which means the command is fired
/// but the large bridge state/diagnostic payload is not reliably returned to
/// Flutter. Q169R16 adds a tiny readback endpoint so post-fire diagnostics can
/// read only the fields needed for INSERT / VALUE / PAINT state, without relying
/// on the full getState() payload or async channel delivery.
class MathLiveCompactBridgeStateReadbackPolicy {
  const MathLiveCompactBridgeStateReadbackPolicy._();

  static const String phase = 'V172-Q169R16';
  static const String compactReadbackReason = 'q169r16-compact-bridge-state-readback';
  static const String compactReadbackDeliveredReason = 'q169r16-compact-state-delivered';
  static const String compactReadbackUnavailableReason = 'q169r16-compact-state-unavailable';

  static const Duration compactStateTimeout = Duration(milliseconds: 260);
  static const bool preferCompactReadbackAfterJsFire = true;
}
