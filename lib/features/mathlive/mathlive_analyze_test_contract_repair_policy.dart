/// V172-Q169R1 — MathLive analyze/test contract repair.
///
/// This policy records the narrow package-side repair after Q169 user-side
/// verification found one analyzer warning and one stale Q164/Q163 marker test.
/// It does not change MathLive command semantics, keyboard layout, MORE,
/// long-press mappings, Graph, History, or Solution surfaces.
class MathLiveAnalyzeTestContractRepairPolicy {
  const MathLiveAnalyzeTestContractRepairPolicy._();

  static const String phase = 'V172-Q169R1';
  static const bool unusedSurfaceImportRemoved = true;
  static const bool q163DiagnosticCompatibilityMarkerPreserved = true;
  static const bool activeQ169DiagnosticMarkerPreserved = true;
  static const bool runtimeCommandSemanticsChanged = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
