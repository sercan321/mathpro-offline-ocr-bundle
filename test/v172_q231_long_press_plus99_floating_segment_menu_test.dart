import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/long_press_plus99_floating_segment_menu_policy.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/long_press_popup.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';

void main() {
  test('V172-Q231 is visual/geometry-only and forbids protected behavior drift', () {
    expect(LongPressPlus99FloatingSegmentMenuPolicy.phase, 'V172-Q231');
    expect(LongPressPlus99FloatingSegmentMenuPolicy.visualRedesignOnly, isTrue);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.longPressOptionMutationAllowed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.longPressOrderMutationAllowed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.moreMutationAllowed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.mathLiveMutationAllowed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.workspaceMutationAllowed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.graphHistorySolutionMutationAllowed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.realDevicePassClaimed, isFalse);
    expect(LongPressPlus99FloatingSegmentMenuPolicy.plus99ClaimedWithoutScreenshot, isFalse);
  });

  test('V172-Q231 popup envelope is compact and keeps touch-safe chips', () {
    expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
    expect(LongPressPopup.panelMinHeight, 60.0);
    expect(LongPressPopup.panelMaxHeight, 64.0);
    expect(LongPressPopup.chipHeight, 48.0);
    expect(LongPressPopup.pointerHeight, 8.0);
    expect(PremiumPopupFitPolicy.longPressChipGap, lessThanOrEqualTo(2));
    expect(PremiumPopupFitPolicy.longPressBoundedIntegralChipWidth, greaterThanOrEqualTo(96));
  });

  test('V172-Q231 wires floating segment menu, pointer, animation and edge-safe placement', () {
    final popup = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
    expect(popup, contains('mathpro-long-press-plus99-floating-segment-menu'));
    expect(popup, contains('TweenAnimationBuilder<double>'));
    expect(popup, contains('_LongPressPointerPainter'));
    expect(popup, contains('_anchorLabelFor'));
    expect(popup, contains('_anchorFractionFor'));
    expect(popup, contains('panelLeft = (idealCenter - panelWidth / 2).clamp'));
    expect(popup, contains('pointerCenter = (idealCenter - panelLeft).clamp'));
    expect(popup, isNot(contains('MathProRadius.lg')));
  });

  test('V172-Q231 does not mutate long-press source map or keyboard layout source', () {
    final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
    final mathKeyboard = File('lib/features/keyboard/math_keyboard.dart').readAsStringSync();
    final bottomDock = File('lib/features/keyboard/bottom_dock.dart').readAsStringSync();
    expect(keyConfig, contains('static const Map<String, List<String>> longPressMap'));
    expect(keyConfig, contains("['MORE', '0', '.', 'Ans']"));
    expect(mathKeyboard, isNot(contains('V172-Q231')));
    expect(bottomDock, isNot(contains('V172-Q231')));
  });
}
