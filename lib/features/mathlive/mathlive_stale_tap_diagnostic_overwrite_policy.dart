/// V172-Q169R10 — MathLive Stale Tap Diagnostic Overwrite Repair.
///
/// Real-device Q169R9 evidence still showed:
///   SEND:Bridge JS:fire MF:true ... FAIL:tap-before-bridge PATH:not-read
///
/// That combination is internally inconsistent: once a command has reached the
/// bridge/fire stage, the pre-bridge Flutter tap marker may not remain the final
/// diagnostic. Q169R10 does not claim native paint success; it makes the visible
/// diagnostic honest by overwriting stale tap-before-bridge with a post-bridge
/// state-refresh failure reason when JS/bridge result delivery still fails.
class MathLiveStaleTapDiagnosticOverwritePolicy {
  const MathLiveStaleTapDiagnosticOverwritePolicy._();

  static const String phase = 'V172-Q169R10';
  static const String repairName = 'MathLive Stale Tap Diagnostic Overwrite Repair';

  static const bool staleTapBeforeBridgeMayBeFinalAfterBridge = false;
  static const bool realDevicePassClaimed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;

  static const String bridgeAwaitingRefreshReason = 'bridge-dispatched-awaiting-state-refresh';
  static const String bridgeAwaitingRefreshPath = 'bridge-awaiting-state-read';
  static const String fireAwaitingRefreshReason = 'bridge-fire-awaiting-state-refresh';
  static const String fireAwaitingRefreshPath = 'post-fire-refresh-in-flight';

  static const String bridgeStateStaleReason = 'bridge-state-stale-after-dispatch';
  static const String bridgeStateStalePath = 'stale-tap-overwritten-after-bridge';
  static const String fireFinalRefreshNotDeliveredReason = 'state-refresh-timeout-after-js-fire';
  static const String fireFinalRefreshNotDeliveredPath = 'refresh-not-delivered-after-fire';


  static const String bridgeSentAwaitingRefreshReason = 'bridge-sent-awaiting-state-refresh';
  static const String bridgeSentAwaitingRefreshPath = 'awaiting-state-read';

  static bool isAwaitingStateRefreshReason(String failureReason) {
    final failure = failureReason.trim().toLowerCase();
    return failure == bridgeAwaitingRefreshReason ||
        failure == fireAwaitingRefreshReason ||
        failure == bridgeSentAwaitingRefreshReason ||
        failure == bridgeStateStaleReason;
  }

  static bool shouldPromoteBridgeFireAwaitingRefresh({
    required String sendState,
    required String jsStatus,
    required String failureReason,
  }) {
    final send = sendState.trim().toLowerCase();
    final js = jsStatus.trim().toLowerCase();
    if (send != 'bridge' && send != 'flush') return false;
    if (js != 'fire') return false;
    return isAwaitingStateRefreshReason(failureReason) ||
        failureReason.trim().toLowerCase() == 'tap-before-bridge';
  }

  static bool shouldTerminalizeAwaitingRefresh({
    required String sendState,
    required String jsStatus,
    required String failureReason,
    required bool valueNonEmpty,
  }) {
    if (valueNonEmpty) return false;
    final send = sendState.trim().toLowerCase();
    final js = jsStatus.trim().toLowerCase();
    if (send != 'bridge' && send != 'flush') return false;
    if (js != 'fire' && js != 'fire-no-state' && js != 'ok' && js != 'fail') return false;
    return isAwaitingStateRefreshReason(failureReason) ||
        failureReason.trim().toLowerCase() == 'tap-before-bridge';
  }

  static bool shouldOverwriteStaleTapBeforeBridge({
    required String sendState,
    required String jsStatus,
    required String failureReason,
  }) {
    final send = sendState.trim().toLowerCase();
    final js = jsStatus.trim().toLowerCase();
    final failure = failureReason.trim().toLowerCase();
    if (failure != 'tap-before-bridge') return false;
    if (send == 'flutter' || send == 'queued') return false;
    if (send == 'bridge' || send == 'flush') return true;
    return js == 'fire' || js == 'ok' || js == 'fail' || js == 'fire-no-state';
  }
}
