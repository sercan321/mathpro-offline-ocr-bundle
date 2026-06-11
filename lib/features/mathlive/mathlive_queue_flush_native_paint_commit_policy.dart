/// V172-Q169 — MathLive Queue Flush / Native Paint Commit Repair.
///
/// This policy is intentionally narrow: it may only harden the MathLive command
/// queue, bridge acknowledgement, value commit, and native paint diagnostics.
/// It does not mutate the protected MathPro keyboard layout, MORE inventory,
/// long-press source of truth, Graph, History, or Solution UI surfaces.
class MathLiveQueueFlushNativePaintCommitPolicy {
  const MathLiveQueueFlushNativePaintCommitPolicy._();

  static const String phase = 'V172-Q169';
  static const String target = 'queue-flush-native-paint-commit';

  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedLongPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool rawInsertTokensMayBeUserVisible = false;
  static const bool flutterFallbackMayPretendNativePaint = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const String expectedDiagnosticShape =
      'Q169 KEY:<label> SEND:Bridge JS:ok MF:true INSERT:true VALUE:non-empty PAINT:ok';

  static bool shouldFlushQueuedCommands({
    required bool pageLoaded,
    required bool mathfieldExists,
    required bool mathfieldMounted,
  }) {
    if (!pageLoaded) return false;
    return mathfieldExists || mathfieldMounted || pageLoaded;
  }

  static bool shouldDemoteFallback({
    required String nativePaintState,
    required bool valueNonEmpty,
  }) {
    return valueNonEmpty && nativePaintState == 'ok';
  }
}
