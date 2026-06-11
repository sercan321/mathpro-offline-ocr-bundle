/// V172-Q169R4 — MathLive MF:true Bridge Dispatch Repair.
///
/// Real-device Q169 evidence showed `MF:true` while the Flutter diagnostic still
/// reported `SEND:Queued JS:queued INSERT:false VALUE:empty PAINT:pending`.
/// That means the old dispatch gate could remain stale even after the WebView
/// had proven that a `<math-field>` existed. This policy keeps the repair narrow:
/// it only promotes a proven math-field existence/mount signal into bridge
/// dispatch/queue-flush readiness. It does not mutate keyboard layout, MORE,
/// long-press, Graph, History, Solution, or solver behavior.
class MathLiveMfTrueBridgeDispatchRepairPolicy {
  const MathLiveMfTrueBridgeDispatchRepairPolicy._();

  static const String phase = 'V172-Q169R4';
  static const String target = 'mf-true-bridge-dispatch-repair';

  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedLongPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool rawInsertTokensMayBeUserVisible = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static bool canDispatchBridgeCommand({
    required bool webViewControllerAttached,
    required bool pageLoaded,
    required bool mathfieldExists,
    required bool mathfieldMounted,
  }) {
    if (!webViewControllerAttached) return false;
    return pageLoaded || mathfieldExists || mathfieldMounted;
  }

  static bool shouldForceFlushAfterMfTrue({
    required bool webViewControllerAttached,
    required bool mathfieldExists,
    required bool mathfieldMounted,
  }) {
    return webViewControllerAttached && (mathfieldExists || mathfieldMounted);
  }
}
