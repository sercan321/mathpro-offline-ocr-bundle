import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/long_press_popup.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_popup_envelope_final_rebalance_policy.dart';

void main() {
  group('V172-Q156 MathLive popup envelope final rebalance', () {
    test('policy is narrow and forbids protected surface drift', () {
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.phase, 'V172-Q156');
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.popupEnvelopeFinalRebalanced, isTrue);
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.boundedIntegralNoClipEnvelopeRestored, isTrue);
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.longPressOrderMutationAllowed, isFalse);
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.moreInventoryMutationAllowed, isFalse);
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.mathLiveTemplateMutationAllowed, isFalse);
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.realDevicePassClaimed, isFalse);
      expect(MathLivePopupEnvelopeFinalRebalancePolicy.photomathLevelClaimed, isFalse);
    });

    test('accepts Q231 compact popup successor while preserving bounded-integral fit', () {
      expect(PremiumPopupFitPolicy.envelopeFinalRebalancePhase, 'V172-Q156');
      expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
      expect(LongPressPopup.panelMinHeight, greaterThanOrEqualTo(58));
      expect(LongPressPopup.panelMaxHeight, greaterThanOrEqualTo(LongPressPopup.panelMinHeight));
      expect(LongPressPopup.chipHeight, inInclusiveRange(44, 56));
      expect(LongPressPopup.boundedIntegralChipWidth, greaterThanOrEqualTo(96));
      expect(PremiumPopupFitPolicy.longPressChipGap, lessThanOrEqualTo(8));
      expect(PremiumPopupFitPolicy.moreTrayChipHeightRegular, lessThanOrEqualTo(32));
    });

    test('does not mutate keyboard layout or template source of truth', () {
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final mathKeyboard = File('lib/features/keyboard/math_keyboard.dart').readAsStringSync();
      final popupPolicy = File('lib/features/keyboard/premium_popup_fit_policy.dart').readAsStringSync();

      expect(keyConfig, contains("['MORE', '0', '.', 'Ans']"));
      expect(keyConfig, contains('longPressMap'));
      expect(mathKeyboard, isNot(contains('V172-Q156')));
      expect(popupPolicy, contains('plus99FloatingSegmentMenuPhase'));
      expect(popupPolicy, contains('longPressPanelMinHeight = 60.0'));
      expect(popupPolicy, contains('longPressBoundedIntegralChipWidth = 98.0'));
    });
  });
}
