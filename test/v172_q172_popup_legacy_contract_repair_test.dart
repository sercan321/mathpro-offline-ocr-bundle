import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/long_press_popup.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_legacy_contract_repair_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/premium_editor_performance_policy.dart';

void main() {
  test('V172-Q172 restores legacy no-clip long-press popup envelope after Q171', () {
    expect(PremiumPopupLegacyContractRepairPolicy.phase, 'V172-Q172');
    expect(PremiumPopupLegacyContractRepairPolicy.visualEnvelopeOnly, isTrue);
    expect(PremiumPopupLegacyContractRepairPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(PremiumPopupLegacyContractRepairPolicy.longPressOrderMutationAllowed, isFalse);
    expect(PremiumPopupLegacyContractRepairPolicy.moreOrderMutationAllowed, isFalse);
    expect(PremiumPopupLegacyContractRepairPolicy.realDevicePremiumPassClaimed, isFalse);

    expect(PremiumPopupFitPolicy.legacyPopupContractRepairPhase, 'V172-Q172');
    expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
    expect(PremiumPopupFitPolicy.longPressPanelMinHeight, 60.0);
    expect(PremiumPopupFitPolicy.longPressPanelMaxHeight, 64.0);
    expect(PremiumPopupFitPolicy.longPressChipHeight, 48.0);

    expect(LongPressPopup.panelMinHeight, greaterThanOrEqualTo(58.0));
    expect(LongPressPopup.panelMaxHeight, greaterThanOrEqualTo(LongPressPopup.panelMinHeight));
    expect(LongPressPopup.chipHeight, lessThan(PremiumEditorPerformancePolicy.longPressChipHeight));
  });
}
