/// V172-Q169R17 — MathLive final self-test court policy.
///
/// This phase is not a premium visual PASS claim. It is a one-install
/// root-cause court for the real-device bridge path after Q169R16 still showed
/// JS:fire but no final INSERT/VALUE/PAINT state. The court runs a compact,
/// deterministic MathLive probe and reports MOUNT / INSERT / VALUE / CHANNEL /
/// PAINT / ROOT_CAUSE without mutating protected keyboard, MORE, long-press,
/// AppShell, Graph, History, or Solution surfaces.
class MathLiveFinalSelfTestCourtPolicy {
  const MathLiveFinalSelfTestCourtPolicy._();

  static const String phase = 'V172-Q169R17';
  static const String courtReason = 'q169r17-final-self-test-court';
  static const String courtDeliveredReason = 'q169r17-final-self-test-court-delivered';
  static const Duration courtTimeout = Duration(milliseconds: 420);
  static const bool runCourtAfterPostFireRefreshTimeout = true;
}
