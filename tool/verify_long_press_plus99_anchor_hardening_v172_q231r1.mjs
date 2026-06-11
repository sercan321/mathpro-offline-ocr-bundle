#!/usr/bin/env node
import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const fail = (message) => {
  console.error(`LONG_PRESS_PLUS99_ANCHOR_HARDENING_Q231R1_FAILED: ${message}`);
  process.exit(1);
};

const popup = read('lib/features/keyboard/long_press_popup.dart');
const premiumKey = read('lib/features/keyboard/premium_key.dart');
const mathKeyboard = read('lib/features/keyboard/math_keyboard.dart');
const bottomDock = read('lib/features/keyboard/bottom_dock.dart');
const graphCard = read('lib/features/graph/graph_card.dart');
const keyConfig = read('lib/features/keyboard/key_config.dart');

for (const needle of [
  'class KeyboardLongPressAnchor',
  'globalCenter',
]) {
  if (!read('lib/features/keyboard/keyboard_long_press_anchor.dart').includes(needle)) fail(`missing anchor model marker ${needle}`);
}

for (const needle of [
  'context.findRenderObject()',
  'localToGlobal(Offset(size.width / 2, size.height / 2))',
  'ValueChanged<KeyboardLongPressAnchor>? onLongPressed',
]) {
  if (!premiumKey.includes(needle)) fail(`premium key no measured geometry marker ${needle}`);
}

if (!mathKeyboard.includes('ValueChanged<KeyboardLongPressAnchor> onKeyLongPressed')) fail('math keyboard does not forward measured anchor payload');
if (!bottomDock.includes('globalToLocal(anchor.globalCenter).dx')) fail('bottom dock does not convert global key center to popup layer coordinates');
if (!bottomDock.includes('anchorCenterX: _longPressAnchorCenterX')) fail('bottom dock does not pass actual anchor center into popup');

for (const needle of [
  'final double? anchorCenterX;',
  'final idealCenter = actualKeyCenterX ?? estimatedCenter;',
  'pointerCenter = (idealCenter - panelLeft).clamp',
  'onTap: onDismissed',
  '_PremiumSegmentScrollFrame',
  'ShaderMask',
  '_ScrollEdgeRail',
  'SizedBox.shrink(',
]) {
  if (!popup.includes(needle)) fail(`popup missing Q231R1 marker ${needle}`);
}

if (popup.includes('child: MathLabel(\n              label: mathLabelIdentity') && !popup.includes('SizedBox.shrink(')) {
  fail('hidden MathLabel may still influence visible chip layout');
}
if (graphCard.includes("import 'graph_painter.dart';")) fail('graph_card still imports graph_painter.dart directly');
if (!graphCard.includes("import 'graph_curve_painter.dart';")) fail('graph_card missing graph_curve_painter export import');

// Long-press source inventory/order must remain present and untouched in kind.
for (const needle of [
  "'Σ': ['Σ', 'Π', 'Taylor', 'Maclaurin'",
  "'y': ['y', 'y₁', 'y₂', 'y_□'",
  "'=': ['=', '≠', '<', '>', '≤', '≥', '≈', '≡']",
]) {
  if (!keyConfig.includes(needle)) fail(`long-press source contract drift: ${needle}`);
}

console.log('LONG_PRESS_PLUS99_ANCHOR_HARDENING_Q231R1_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_LONG_PRESS_SCREENSHOT_QA_REQUIRED');
