/// V172-Q169R31 — Prebundled Runtime Boot Consolidation.
///
/// Q169R29/Q169R30 real-device evidence proved the keyboard was blocked before
/// insert: WEBVIEW was alive and the JS channel could show a court, but the
/// official MathLive runtime still reported RUNTIME:pending / MF:missing. This
/// phase moves the official runtime bootstrap assets into the package before
/// Android build time and adds a JS-side runtime recovery loader so PAGE/channel
/// readiness cannot leave the editor permanently mounted on the neutral host box.
class MathLivePrebundledRuntimeBootRepairPolicy {
  const MathLivePrebundledRuntimeBootRepairPolicy._();

  static const String phase = 'V172-Q169R31';
  static const String evidence = 'WEBVIEW:ok PAGE:pending RUNTIME:pending MF:missing CHANNEL:court-visible';
  static const String runtimeRecoveryScriptPath = 'assets/mathlive/vendor/mathlive/mathlive.min.js';
  static const String runtimeRecoveryReason = 'q169r31-prebundled-runtime-recovery';
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool premiumVisualPolishAllowed = false;
  static const bool realDevicePaintPassClaimed = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool officialRuntimeBootstrapAssetsIncluded = true;

  static bool blocksQ170PolishWithoutNativePaint({
    required bool mountOk,
    required bool valueOk,
    required bool paintOk,
  }) {
    return !(mountOk && valueOk && paintOk);
  }
}
