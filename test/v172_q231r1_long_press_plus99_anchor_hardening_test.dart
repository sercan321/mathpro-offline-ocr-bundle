import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/long_press_plus99_anchor_hardening_policy.dart';

void main() {
  test('V172-Q231R1 requires actual key geometry and keeps behavior contracts frozen', () {
    expect(LongPressPlus99AnchorHardeningPolicy.phase, 'V172-Q231R1');
    expect(LongPressPlus99AnchorHardeningPolicy.visualAndGeometryOnly, isTrue);
    expect(LongPressPlus99AnchorHardeningPolicy.actualKeyGeometryRequired, isTrue);
    expect(LongPressPlus99AnchorHardeningPolicy.estimatedKeyAnchorAllowedOnlyAsFallback, isTrue);
    expect(LongPressPlus99AnchorHardeningPolicy.pointerClampsToActualKeyCenter, isTrue);
    expect(LongPressPlus99AnchorHardeningPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(LongPressPlus99AnchorHardeningPolicy.longPressOptionMutationAllowed, isFalse);
    expect(LongPressPlus99AnchorHardeningPolicy.longPressOrderMutationAllowed, isFalse);
    expect(LongPressPlus99AnchorHardeningPolicy.mathLiveMutationAllowed, isFalse);
    expect(LongPressPlus99AnchorHardeningPolicy.graphBehaviorMutationAllowed, isFalse);
    expect(LongPressPlus99AnchorHardeningPolicy.plus99PassClaimedWithoutDeviceScreenshots, isFalse);
  });

  test('V172-Q231R1 wires measured PremiumKey center through BottomDock to LongPressPopup', () {
    final anchor = File('lib/features/keyboard/keyboard_long_press_anchor.dart').readAsStringSync();
    final premiumKey = File('lib/features/keyboard/premium_key.dart').readAsStringSync();
    final mathKeyboard = File('lib/features/keyboard/math_keyboard.dart').readAsStringSync();
    final bottomDock = File('lib/features/keyboard/bottom_dock.dart').readAsStringSync();
    final popup = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();

    expect(anchor, contains('class KeyboardLongPressAnchor'));
    expect(anchor, contains('globalCenter'));
    expect(premiumKey, contains('context.findRenderObject()'));
    expect(premiumKey, contains('localToGlobal(Offset(size.width / 2, size.height / 2))'));
    expect(mathKeyboard, contains('ValueChanged<KeyboardLongPressAnchor> onKeyLongPressed'));
    expect(bottomDock, contains('_localAnchorCenterXFor(KeyboardLongPressAnchor anchor)'));
    expect(bottomDock, contains('globalToLocal(anchor.globalCenter).dx'));
    expect(bottomDock, contains('anchorCenterX: _longPressAnchorCenterX'));
    expect(popup, contains('final double? anchorCenterX;'));
    expect(
      popup,
      anyOf(
        contains('final actualKeyCenterX = anchorCenterX == null ? null : anchorCenterX!'),
        contains('final actualKeyCenterX = anchorCenterX?.clamp'),
      ),
    );
    expect(popup, contains('final idealCenter = actualKeyCenterX ?? estimatedCenter;'));
  });

  test('V172-Q231R1 keeps edge-safe dismissal, fade affordance and zero-size hidden identity', () {
    final popup = File('lib/features/keyboard/long_press_popup.dart').readAsStringSync();
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    expect(popup, contains('onTap: onDismissed'));
    expect(popup, contains('_PremiumSegmentScrollFrame'));
    expect(popup, contains('ShaderMask'));
    expect(popup, contains('_ScrollEdgeRail'));
    expect(popup, contains('SizedBox.shrink('));
    expect(popup, contains('pointerCenter = (idealCenter - panelLeft).clamp'));
    expect(graphCard, isNot(contains("import 'graph_painter.dart';")));
    expect(graphCard, contains("import 'graph_curve_painter.dart';"));
  });
}
