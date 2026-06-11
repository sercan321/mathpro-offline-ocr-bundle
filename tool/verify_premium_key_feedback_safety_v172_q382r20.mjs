#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (msg) => { console.error(`[FAIL] ${msg}`); process.exit(1); };
const must = (text, needle, label) => { if (!text.includes(needle)) fail(`missing ${label}: ${needle}`); };
const mustNot = (text, needle, label) => { if (text.includes(needle)) fail(`forbidden ${label}: ${needle}`); };

const premiumKey = read('lib/features/keyboard/premium_key.dart');
const policy = read('lib/features/keyboard/premium_key_feedback_safety_q382r20_policy.dart');
const bridge = read('assets/mathlive/mathlive_prod_bridge.js');

must(policy, "static const String phase = 'V172-Q382R20'", 'Q382R20 policy phase');
must(policy, 'commandDispatchRemainsOnTap = true', 'command remains onTap policy');
must(policy, 'animatedContainerRemovedFromPremiumKeyHotPath = true', 'animated container removal policy');
must(policy, 'pressedScaleDuration = Duration(milliseconds: 48)', 'fast scale duration policy');
must(policy, 'longPressContractPreserved = true', 'long press preservation policy');
must(policy, 'keyboardLayoutPreserved = true', 'keyboard layout preservation policy');

must(premiumKey, "import 'premium_key_feedback_safety_q382r20_policy.dart';", 'PremiumKey Q382R20 policy import');
must(premiumKey, 'duration: PremiumKeyFeedbackSafetyQ382R20Policy.pressedScaleDuration', 'PremiumKey fast scale duration');
must(premiumKey, 'child: Container(', 'PremiumKey static container hot path');
mustNot(premiumKey, 'child: AnimatedContainer(', 'AnimatedContainer in PremiumKey hot path');
must(premiumKey, 'onTapDown: _handleTapDown', 'tap down handler remains');
must(premiumKey, 'onTap: _handleTap', 'tap handler remains');
const q382r24PolicyExists = exists('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart');
if (q382r24PolicyExists) {
  must(premiumKey, "import 'keyboard_latency_closure_q382r24_policy.dart';", 'Q382R24 latency closure import');
  must(premiumKey, 'KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown', 'Q382R24 guarded tap-down dispatch');
  must(premiumKey, 'if (_tapDownDispatched) {', 'Q382R24 double-insert guard');
  must(premiumKey, '_tapDownDispatched = false;', 'Q382R24 tap-down dispatch reset');
} else {
  must(premiumKey, 'void _handleTapDown(TapDownDetails _) {\n    _setPressed(true);\n    HapticsService.lightImpact();\n  }', 'tap down remains feedback-only');
  must(premiumKey, 'void _handleTap() {\n    widget.onPressed?.call(widget.label);\n  }', 'command still dispatched by tap');
}
must(premiumKey, 'onLongPressStart: widget.onLongPressed == null ? null : _handleLongPressStart', 'long press start preserved');
must(premiumKey, 'onLongPressEnd: widget.onLongPressed == null ? null : _handleLongPressEnd', 'long press end preserved');
must(premiumKey, 'onLongPress: widget.onLongPressed == null ? null : _handleLongPress', 'long press action preserved');

// Q382R20 must not regress MathLive insertion budget or reintroduce pan experiments.
must(bridge, "const KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE = 'V172-Q382R19'", 'Q382R19 insertion budget preserved');
for (const forbidden of ['q382R13', 'q382R14', 'q382R16', 'direct-pan', 'host-scrollport-force', 'document-capture']) {
  mustNot(bridge, forbidden, `old pan marker ${forbidden}`);
}
for (const rel of [
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r13_policy.dart',
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r14_policy.dart',
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r16_policy.dart',
]) {
  if (exists(rel)) fail(`pan experiment policy must not exist: ${rel}`);
}

console.log('PASS verify_premium_key_feedback_safety_v172_q382r20');
