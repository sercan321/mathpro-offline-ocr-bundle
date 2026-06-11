/// V172-Q184 — Production MathLive Cutover Surface policy.
///
/// This phase stops patching the legacy diagnostic-heavy main editor surface for
/// production use. The legacy surface stays in the package for static verifier
/// compatibility and rollback, while the active workspace may render a minimal
/// production MathLive surface backed by `main_editor_prod.html` and
/// `mathlive_prod_bridge.js`.
class MathLiveProductionCutoverSurfacePolicy {
  const MathLiveProductionCutoverSurfacePolicy._();

  static const String phase = 'V172-Q184';
  static const bool productionSurfaceUsesMinimalHtml = true;
  static const bool productionSurfaceUsesMinimalBridge = true;
  static const bool diagnosticCourtEnabledInProduction = false;
  static const bool legacySurfaceKeptForRollback = true;
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedWorkspaceChromeMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePremiumPassClaimed = false;
}
