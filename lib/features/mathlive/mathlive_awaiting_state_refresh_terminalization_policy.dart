/// V172-Q169R11 — MathLive Awaiting State Refresh Terminalization Policy.
///
/// This is a diagnostic/state-contract repair only. It does not mutate the
/// protected keyboard, MORE inventory, long-press order, AppShell, Graph,
/// History, Solution, or solver behavior.
///
/// Q169R10 successfully removed stale `tap-before-bridge` from the real-device
/// screenshot, but the final visible diagnostic could still remain stuck at an
/// intermediate `bridge-dispatched-awaiting-state-refresh` state even after
/// `SEND:Bridge JS:fire MF:true`. Q169R11 makes that intermediate state
/// terminal-safe: if final state refresh is not delivered, the diagnostic must
/// say `state-refresh-timeout-after-js-fire / refresh-not-delivered-after-fire`.
class MathLiveAwaitingStateRefreshTerminalizationPolicy {
  static const String phase = 'V172-Q169R11';
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool nativePaintPassClaimed = false;

  static const String hardBindingPhase = 'V172-Q169R12';
  static const String blockedIntermediateFailure = 'bridge-dispatched-awaiting-state-refresh';
  static const String blockedFireIntermediateFailure = 'bridge-fire-awaiting-state-refresh';
  static const String blockedBridgeSentIntermediateFailure = 'bridge-sent-awaiting-state-refresh';
  static const String blockedBridgeStateStaleFailure = 'bridge-state-stale-after-dispatch';
  static const String blockedTapBeforeBridgeFailure = 'tap-before-bridge';
  static const String requiredTerminalFailure = 'state-refresh-timeout-after-js-fire';
  static const String requiredTerminalPath = 'refresh-not-delivered-after-fire';

  static bool isBlockedIntermediateFailure(String failureReason) {
    final failure = failureReason.trim().toLowerCase();
    return failure == blockedIntermediateFailure ||
        failure == blockedFireIntermediateFailure ||
        failure == blockedBridgeSentIntermediateFailure ||
        failure == blockedBridgeStateStaleFailure ||
        failure == blockedTapBeforeBridgeFailure;
  }

  static bool shouldTerminalize({
    required String sendState,
    required String jsStatus,
    required String failureReason,
    required bool valueNonEmpty,
  }) {
    if (valueNonEmpty) return false;
    final send = sendState.trim().toLowerCase();
    final js = jsStatus.trim().toLowerCase();
    if (send != 'bridge' && send != 'flush') return false;
    if (js != 'fire' &&
        js != 'fire-no-state' &&
        js != 'fire-no-final-state' &&
        js != 'ok' &&
        js != 'fail') {
      return false;
    }
    return isBlockedIntermediateFailure(failureReason);
  }

  static ({String failureReason, String valueApiPath}) terminalizeIfRequired({
    required String sendState,
    required String jsStatus,
    required String failureReason,
    required String valueApiPath,
    required bool valueNonEmpty,
  }) {
    if (!shouldTerminalize(
      sendState: sendState,
      jsStatus: jsStatus,
      failureReason: failureReason,
      valueNonEmpty: valueNonEmpty,
    )) {
      return (failureReason: failureReason, valueApiPath: valueApiPath);
    }
    return (
      failureReason: requiredTerminalFailure,
      valueApiPath: requiredTerminalPath,
    );
  }
}
