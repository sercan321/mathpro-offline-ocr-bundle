import 'mathlive_awaiting_state_refresh_terminalization_policy.dart';

/// V172-Q169R13 — MathLive Final Refresh Failure Path Hard Binding.
///
/// Q169R12 imported and used the awaiting-state terminalization policy, but one
/// direct refresh-failure branch still wrote the older Q169R9 path
/// `refresh-not-delivered`. On real-device diagnostics this weakens the
/// post-`JS:fire` distinction we need. Q169R13 hard-binds every post-fire
/// terminal refresh failure to the single explicit terminal pair:
///
/// FAIL:state-refresh-timeout-after-js-fire
/// PATH:refresh-not-delivered-after-fire
///
/// This is a diagnostic contract repair only. It does not claim native paint
/// success and does not mutate protected keyboard, MORE, long-press, AppShell,
/// Graph, History, Solution, or solver behavior.
class MathLiveFinalRefreshFailurePathHardBindingPolicy {
  const MathLiveFinalRefreshFailurePathHardBindingPolicy._();

  static const String phase = 'V172-Q169R13';
  static const bool nativePaintPassClaimed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;

  static const String prohibitedLegacyPath = 'refresh-not-delivered';
  static const String requiredTerminalFailure =
      MathLiveAwaitingStateRefreshTerminalizationPolicy.requiredTerminalFailure;
  static const String requiredTerminalPath =
      MathLiveAwaitingStateRefreshTerminalizationPolicy.requiredTerminalPath;

  static ({String failureReason, String valueApiPath}) terminalFailureForPostFireRefresh() {
    return (
      failureReason: requiredTerminalFailure,
      valueApiPath: requiredTerminalPath,
    );
  }
}
