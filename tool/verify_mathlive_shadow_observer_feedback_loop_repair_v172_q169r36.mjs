#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_shadow_observer_feedback_loop_repair_v172_q169r36.mjs', retiredPhase: 'verify_mathlive_shadow_observer_feedback_loop_repair_v172_q169r36', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const failures = [];
function read(file) {
  if (!fs.existsSync(file)) {
    failures.push(`missing file: ${file}`);
    return '';
  }
  return fs.readFileSync(file, 'utf8');
}
function has(file, marker) {
  const text = read(file);
  if (!text.includes(marker)) failures.push(`missing marker in ${file}: ${marker}`);
}
function notHas(file, marker) {
  const text = read(file);
  if (text.includes(marker)) failures.push(`forbidden marker in ${file}: ${marker}`);
}

has('assets/mathlive/mathlive_bridge.js', "shadowObserverFeedbackLoopRepairPhase: 'V172-Q169R36'");
has('assets/mathlive/mathlive_bridge.js', 'function q169R36ScheduleChromeSuppression');
has('assets/mathlive/mathlive_bridge.js', 'function q169R36InstallShadowChromeObserver');
has('assets/mathlive/mathlive_bridge.js', 'q169R36ChromeObserverFields');
has('assets/mathlive/mathlive_bridge.js', 'q169R36ChromeSuppressionScheduled');
has('assets/mathlive/mathlive_bridge.js', 'q169R36ChromeSuppressionRunning');
has('assets/mathlive/mathlive_bridge.js', "chromeObserver.observe(root, { childList: true, subtree: true })");
has('assets/mathlive/mathlive_bridge.js', "q169R36ScheduleChromeSuppression(field, 'q169r36-after-mathfield-mounted')");
notHas('assets/mathlive/mathlive_bridge.js', 'attributes: true');
notHas('assets/mathlive/mathlive_bridge.js', 'new MutationObserver(function () { hideMathLiveChrome(field); suppressVisibleMathLiveBranding(field); })');

has('assets/mathlive/main_editor.html', 'data-q169r36-shadow-observer-feedback-loop-repair="true"');
has('assets/mathlive/main_editor.html', "window.MathProShadowObserverFeedbackLoopRepair = { phase: 'V172-Q169R36'");
has('assets/mathlive/main_editor.html', "shadowObserverFeedbackLoopRepairPhase: 'V172-Q169R36'");
has('assets/mathlive/main_editor.html', "chromeObserver.observe(root, { childList: true, subtree: true })");
notHas('assets/mathlive/main_editor.html', 'chromeObserver.observe(field.shadowRoot, { childList: true, subtree: true, attributes: true })');
notHas('assets/mathlive/main_editor.html', 'new MutationObserver(function () { hideMathLiveChrome(field); suppressVisibleMathLiveBranding(field); })');

has('lib/features/mathlive/mathlive_shadow_observer_feedback_loop_repair_policy.dart', "phase = 'V172-Q169R36'");
has('test/v172_q169r36_shadow_observer_feedback_loop_repair_test.dart', 'MathLiveShadowObserverFeedbackLoopRepairPolicy');
has('assets/mathlive/manifest.json', 'v172Q169R36ShadowObserverFeedbackLoopRepair');

const protectedFiles = [
  'lib/app/app_shell.dart',
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/math_label.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
];
for (const file of protectedFiles) {
  const text = read(file);
  if (text.includes('V172-Q169R36')) failures.push(`protected file touched with Q169R36 marker: ${file}`);
}

if (failures.length) {
  console.error('MATHLIVE_SHADOW_OBSERVER_FEEDBACK_LOOP_REPAIR_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_SHADOW_OBSERVER_FEEDBACK_LOOP_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
