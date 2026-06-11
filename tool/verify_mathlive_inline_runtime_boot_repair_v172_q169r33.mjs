#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_inline_runtime_boot_repair_v172_q169r33.mjs', retiredPhase: 'verify_mathlive_inline_runtime_boot_repair_v172_q169r33', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const required = [
  ['assets/mathlive/main_editor.html', 'data-mathpro-inline-runtime="V172-Q169R33"'],
  ['assets/mathlive/main_editor.html', 'MathLive 0.109.2'],
  ['assets/mathlive/main_editor.html', 'inlineRuntimeExecuted = true'],
  ['assets/mathlive/main_editor.html', 'data-mathpro-external-runtime-fallback="V172-Q169R33"'],
  ['assets/mathlive/mathlive_bridge.js', "inlineRuntimeBootRepairPhase: 'V172-Q169R33'"],
  ['assets/mathlive/mathlive_bridge.js', 'q169r33-inline-runtime-executed'],
  ['assets/mathlive/mathlive_bridge.js', 'inline-runtime-executed-but-math-field-not-defined'],
  ['lib/features/mathlive/mathlive_inline_runtime_boot_repair_policy.dart', "phase = 'V172-Q169R33'"],
  ['test/v172_q169r33_inline_runtime_boot_repair_test.dart', 'MathProInlineRuntimeBootRepair'],
];
const failures = [];
for (const [file, marker] of required) {
  if (!fs.existsSync(file)) failures.push(`missing file: ${file}`);
  else if (!fs.readFileSync(file, 'utf8').includes(marker)) failures.push(`missing marker in ${file}: ${marker}`);
}
const forbidden = ['lib/features/keyboard/key_config.dart','lib/features/keyboard/math_keyboard.dart','lib/features/keyboard/bottom_dock.dart','lib/features/keyboard/long_press_popup.dart','lib/features/keyboard/premium_key.dart','lib/app/app_shell.dart','lib/features/graph/graph_card.dart','lib/features/history/history_panel.dart','lib/features/solution/solution_steps_panel.dart'];
for (const file of forbidden) {
  const text = fs.readFileSync(file, 'utf8');
  if (text.includes('V172-Q169R33')) failures.push(`protected file touched with Q169R33 marker: ${file}`);
}
if (failures.length) {
  console.error('MATHLIVE_INLINE_RUNTIME_BOOT_REPAIR_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_INLINE_RUNTIME_BOOT_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_RUNTIME_MOUNT_EVIDENCE_REQUIRED');
