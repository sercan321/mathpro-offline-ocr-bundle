import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';

void main() {
  group('V172-Q150 MathPro popup premium fit', () {
    test('is visual-fit only and forbids source/order mutation claims', () {
      expect(PremiumPopupFitPolicy.phase, 'V172-Q150');
      expect(PremiumPopupFitPolicy.visualFitOnly, isTrue);
      expect(PremiumPopupFitPolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(PremiumPopupFitPolicy.longPressOrderMutationAllowed, isFalse);
      expect(PremiumPopupFitPolicy.moreCategoryMutationAllowed, isFalse);
      expect(PremiumPopupFitPolicy.mathLiveTemplateMutationAllowed, isFalse);
      expect(PremiumPopupFitPolicy.realDevicePassClaimed, isFalse);
      expect(PremiumPopupFitPolicy.photomathLevelClaimed, isFalse);
    });

    test('tightens long-press and MORE popup dimensions for phone fit', () {
      expect(PremiumPopupFitPolicy.testContractRepairPhase, 'V172-Q153');
      expect(PremiumPopupFitPolicy.longPressPanelMaxHeight, lessThanOrEqualTo(120));
      expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
      expect(PremiumPopupFitPolicy.longPressChipHeight, inInclusiveRange(44, 56));
      expect(PremiumPopupFitPolicy.longPressChipGap, lessThanOrEqualTo(8));
      expect(PremiumPopupFitPolicy.moreTrayChipHeightRegular, lessThanOrEqualTo(32));
      expect(PremiumPopupFitPolicy.moreTrayCategoryHeightRegular, lessThanOrEqualTo(26));
    });

    test('wires policy into popup surfaces without key source mutation', () {
      final longPress = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
      final tray = File('lib/features/workspace/template_tray.dart').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();

      expect(longPress, contains('mathpro-long-press-plus99-floating-segment-menu'));
      expect(longPress, contains('PremiumPopupFitPolicy.longPressChipWidthFor'));
      expect(tray, contains('PremiumPopupFitPolicy.moreChipMaxWidth'));
      expect(tray, contains('PremiumPopupFitPolicy.moreTrayChipHeightRegular'));
      expect(keyConfig, contains('longPressMap'));
      expect(keyConfig, contains("['MORE', '0', '.', 'Ans']"));
    });
  });
}
