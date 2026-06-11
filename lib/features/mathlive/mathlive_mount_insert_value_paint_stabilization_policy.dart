/// V172-Q169R32 — MathLive Mount/Insert/Value/Paint Stabilization.
///
/// Q169R31 prebundled the official runtime files, but the next target is to
/// make the main editor repeatedly stabilize the full native chain before Q170:
/// MOUNT -> INSERT -> VALUE -> CHANNEL -> PAINT. This policy is deliberately
/// package-side and evidence-gated: it adds boot/command stabilization hooks,
/// but it does not claim real-device PAINT:ok without a phone screenshot/log.
class MathLiveMountInsertValuePaintStabilizationPolicy {
  const MathLiveMountInsertValuePaintStabilizationPolicy._();

  static const String phase = 'V172-Q169R32';
  static const bool scheduledBootStabilizationEnabled = true;
  static const bool commandPreflightNativeReadyCheckEnabled = true;
  static const bool customElementWhenDefinedHookEnabled = true;
  static const bool finalCourtRunsAfterMountedBootStabilization = true;
  static const bool q170PremiumPolishAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool assistantFlutterAnalyzePassClaimed = false;
  static const bool assistantFlutterTestPassClaimed = false;
  static const bool assistantFlutterRunPassClaimed = false;
  static const bool realDevicePaintPassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const Duration bootStabilizationAckTimeout = Duration(milliseconds: 520);

  static const String requiredTarget =
      'COURT_SINGLE_SOURCE MOUNT:ok INSERT:ok VALUE:ok CHANNEL:ok PAINT:ok ROOT:none';
}
