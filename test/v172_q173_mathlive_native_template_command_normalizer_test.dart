import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_native_template_command_normalizer_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_template_optical_correction_policy.dart';

void main() {
  test('V172-Q173 native template command normalizer is non-mutating and non-claiming', () {
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.phase, 'V172-Q173');
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.longPressOrderMutationAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.appShellMutationAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.solverMutationAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.diagnosticOverlayAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.mathLiveNativeRendererRequired, isTrue);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.repeatedEmptyTemplateNestingAllowed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.realDevicePremiumPassClaimed, isFalse);
    expect(MathLiveNativeTemplateCommandNormalizerPolicy.normalizedFamilies, containsAll(<String>['radical', 'function', 'calculus', 'series', 'systems']));
  });

  test('V172-Q173 keeps Q171 optical families and Q172 popup legacy envelope compatible', () {
    expect(MathLiveTemplateOpticalCorrectionPolicy.opticalFamilies, containsAll(<String>['radical', 'function', 'calculus', 'series', 'systems', 'matrix']));
    expect(PremiumPopupFitPolicy.templateOpticalCorrectionPhase, 'V172-Q171');
    expect(PremiumPopupFitPolicy.legacyPopupContractRepairPhase, 'V172-Q172');
    expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
    expect(PremiumPopupFitPolicy.longPressChipHeight, 48.0);
    expect(PremiumPopupFitPolicy.longPressPanelMinHeight, 60.0);
  });
}
