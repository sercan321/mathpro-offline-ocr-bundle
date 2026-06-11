import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_template_optical_correction_policy.dart';

void main() {
  test('V172-Q171 template optical correction is visual-only and does not claim device premium pass', () {
    expect(MathLiveTemplateOpticalCorrectionPolicy.phase, 'V172-Q171');
    expect(MathLiveTemplateOpticalCorrectionPolicy.visualOnly, isTrue);
    expect(MathLiveTemplateOpticalCorrectionPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveTemplateOpticalCorrectionPolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveTemplateOpticalCorrectionPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveTemplateOpticalCorrectionPolicy.appShellMutationAllowed, isFalse);
    expect(MathLiveTemplateOpticalCorrectionPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
    expect(MathLiveTemplateOpticalCorrectionPolicy.diagnosticOverlayAllowed, isFalse);
    expect(MathLiveTemplateOpticalCorrectionPolicy.realDevicePremiumPassClaimed, isFalse);
    expect(MathLiveTemplateOpticalCorrectionPolicy.opticalFamilies, containsAll(<String>['calculus', 'series', 'systems', 'matrix', 'long']));
  });

  test('V172-Q171 optical policy coexists with Q172 legacy popup no-clip repair', () {
    expect(PremiumPopupFitPolicy.templateOpticalCorrectionPhase, 'V172-Q171');
    expect(PremiumPopupFitPolicy.legacyPopupContractRepairPhase, 'V172-Q172');
    expect(PremiumPopupFitPolicy.visualFitOnly, isTrue);
    expect(PremiumPopupFitPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(PremiumPopupFitPolicy.longPressOrderMutationAllowed, isFalse);
    expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
    expect(PremiumPopupFitPolicy.longPressChipHeight, 48.0);
    expect(PremiumPopupFitPolicy.longPressPanelMinHeight, 60.0);
    expect(PremiumPopupFitPolicy.longPressPanelMaxHeight, 64.0);
  });
}
