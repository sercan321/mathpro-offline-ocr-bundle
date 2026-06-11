/// V172-Q198 — Production command trace policy.
///
/// Replaces active-source references to the old command-bus court terminology.
/// The trace remains production-safe: no visual overlay, no public API expansion,
/// and no Android/Flutter PASS claim.
abstract final class MathLiveProductionCommandTracePolicy {
  static const String phase = 'V172-Q198';
  static const String replacesHistoricalCommandCourtPhase = 'V172-Q190R3';
  static const String traceScope = 'production-command-trace';

  static const bool visualDebugOverlayAllowed = false;
  static const bool productionPublicApiExpansionAllowed = false;
  static const bool traceStateIntoSelectionDescription = true;
  static const bool androidRealDevicePassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
}
