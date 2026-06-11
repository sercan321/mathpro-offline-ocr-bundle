import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/full_app_regression_court_guard_v172_q131_policy.dart';

void main() {
  test('V172-Q131 Full App Regression Court Guard remains guard-only and blocks unsafe progression', () {
    expect(FullAppRegressionCourtGuardV172Q131Policy.phase, 'V172-Q131');
    expect(FullAppRegressionCourtGuardV172Q131Policy.guardOnly, isTrue);
    expect(FullAppRegressionCourtGuardV172Q131Policy.packageSideBatchPhase, isTrue);
    expect(FullAppRegressionCourtGuardV172Q131Policy.legacyFlutterSlotEditorRemainsDefault, isTrue);
    expect(FullAppRegressionCourtGuardV172Q131Policy.mathLiveDefaultSwitchImplementedInThisPackage, isFalse);
    expect(FullAppRegressionCourtGuardV172Q131Policy.legacyCursorPhysicalDeletionImplementedInThisPackage, isFalse);
    expect(FullAppRegressionCourtGuardV172Q131Policy.releasePassClaimedInThisPackage, isFalse);
    expect(FullAppRegressionCourtGuardV172Q131Policy.cursorPassClaimedInThisPackage, isFalse);
    expect(FullAppRegressionCourtGuardV172Q131Policy.keyboardMutationAllowed, isFalse);
    expect(FullAppRegressionCourtGuardV172Q131Policy.graphHistorySolutionUiMutationAllowed, isFalse);
  });
}
