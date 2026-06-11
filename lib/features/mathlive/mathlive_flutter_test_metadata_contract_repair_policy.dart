/// V172-Q155 — Flutter test metadata and evolved template contract repair.
///
/// This is a package/test-contract repair phase after user-side Q154 logs. It
/// does not change the frozen keyboard layout, MORE inventory, long-press
/// order, Graph/History/Solution UI, solver behavior, or MathLive runtime
/// behavior. It removes the active package version from the stale-version list
/// and updates old static tests to accept the later Q145 compact `\textstyle`
/// MathLive sum template while preserving semantic `\sum` structure.
class MathLiveFlutterTestMetadataContractRepairPolicy {
  const MathLiveFlutterTestMetadataContractRepairPolicy._();

  static const String phase = 'V172-Q155';
  static const bool packageMetadataStaleVersionSelfReferenceRemoved = true;
  static const bool q140SigmaContractAcceptsQ145Textstyle = true;
  static const bool q140SigmaSemanticSumPreserved = true;
  static const bool pubspecVersionChanged = false;
  static const bool verifyMathProContractLegacyVersionCompatibilityPreserved = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool keyOrderMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool solverExpansionClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePassClaimed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;
}
