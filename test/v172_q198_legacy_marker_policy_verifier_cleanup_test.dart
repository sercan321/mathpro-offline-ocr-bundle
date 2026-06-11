import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_legacy_marker_policy_verifier_cleanup_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_command_trace_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_platform_view_policy.dart';

void main() {
  test('V172-Q198 legacy marker policy verifier cleanup contract is locked', () {
    expect(MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.phase, 'V172-Q198');
    expect(MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.activeProductionSourceImportsHistoricalLabPolicy, isFalse);
    expect(MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.activeProductionSourceImportsHistoricalDiagnosticPolicy, isFalse);
    expect(MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.activeProductionSourceImportsHistoricalCourtPolicy, isFalse);
    expect(MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.activeProductionSourceContainsHistoricalMarkerWall, isFalse);
    expect(MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.compatibilityShimMayRenderFallback, isFalse);
    expect(MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.compatibilityShimForwardsToProductionSurface, isTrue);
    expect(MathLiveProductionPlatformViewPolicy.usesLabPolicyForProductionWebView, isFalse);
    expect(MathLiveProductionCommandTracePolicy.visualDebugOverlayAllowed, isFalse);
    expect(MathLiveProductionCommandTracePolicy.productionPublicApiExpansionAllowed, isFalse);
  });
}
