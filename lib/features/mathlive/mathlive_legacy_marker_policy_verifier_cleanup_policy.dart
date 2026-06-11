/// V172-Q198 — Legacy marker / policy / verifier cleanup policy.
///
/// Active production source may not import historical lab, diagnostic, evidence,
/// or non-production command-court policy classes. Historical reports remain in
/// docs/audit as evidence; runtime code must depend on production policies only.
abstract final class MathLiveLegacyMarkerPolicyVerifierCleanupPolicy {
  static const String phase = 'V172-Q198';
  static const bool activeProductionSourceImportsHistoricalLabPolicy = false;
  static const bool activeProductionSourceImportsHistoricalDiagnosticPolicy = false;
  static const bool activeProductionSourceImportsHistoricalCourtPolicy = false;
  static const bool activeProductionSourceContainsHistoricalMarkerWall = false;
  static const bool compatibilityShimMayRenderFallback = false;
  static const bool compatibilityShimForwardsToProductionSurface = true;
  static const bool protectedUiMutationAllowed = false;
}
