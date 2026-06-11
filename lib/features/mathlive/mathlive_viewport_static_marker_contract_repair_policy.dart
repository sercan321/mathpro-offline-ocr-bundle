/// V172-Q177 viewport static marker contract repair.
///
/// This policy is intentionally package-side only. It restores the legacy
/// Q148 HTML marker expected by existing Flutter/static tests while preserving
/// Q175's default MathLive renderer purity target. It does not claim Flutter or
/// real-device visual PASS.
class MathLiveViewportStaticMarkerContractRepairPolicy {
  static const String phase = 'V172-Q177';
  static const String repairedMarker = 'V172-Q148: premium viewport fit';
  static const bool q148ViewportMarkerRestored = true;
  static const bool defaultRendererPurityPreserved = true;
  static const bool keyboardLayoutMutated = false;
  static const bool appShellMutated = false;
  static const bool graphHistorySolutionMutated = false;
  static const bool flutterPassClaimedByAssistant = false;
  static const bool realDevicePremiumPassClaimed = false;
}
