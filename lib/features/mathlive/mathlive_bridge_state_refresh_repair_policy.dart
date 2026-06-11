/// V172-Q169R9 — MathLive Bridge State Refresh / Diagnostic Overwrite Repair.
///
/// Real-device Q169R8 evidence showed progress to SEND:Bridge JS:fire MF:true,
/// but the visible diagnostic could remain stuck at the pre-bridge Flutter tap
/// marker: FAIL:tap-before-bridge PATH:not-read. That means the bridge command
/// dispatch is no longer the blocker; the post-fire JS state/diagnostic report is
/// not reliably overwriting the initial Flutter tap state.
///
/// Q169R9 does not claim native paint success. It forces a post-bridge refresh
/// court after every fire path, consumes either getState() or the richer real
/// device diagnostic report, and if neither arrives it overwrites the stale
/// tap-before-bridge state with an honest state-refresh-timeout reason.
class MathLiveBridgeStateRefreshRepairPolicy {
  const MathLiveBridgeStateRefreshRepairPolicy._();

  static const String phase = 'V172-Q169R9';
  static const String repairName = 'MathLive Bridge State Refresh / Diagnostic Overwrite Repair';

  static const bool forcePostBridgeRefresh = true;
  static const bool staleTapBeforeBridgeMayBeFinal = false;
  static const bool realDevicePassClaimed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;

  static const Duration diagnosticReportTimeout = Duration(milliseconds: 500);
  static const Duration firstRefreshDelay = Duration(milliseconds: 45);
  static const Duration secondRefreshDelay = Duration(milliseconds: 140);
  static const Duration thirdRefreshDelay = Duration(milliseconds: 320);

  static const String finalRefreshFailureReason = 'state-refresh-timeout-after-js-fire';
  static const String finalRefreshFailurePath = 'refresh-not-delivered';
  static const String stateRefreshDeliveredReason = 'q169r9-post-bridge-state-refresh-delivered';
  static const String diagnosticRefreshDeliveredReason = 'q169r9-post-bridge-diagnostic-refresh-delivered';
}
