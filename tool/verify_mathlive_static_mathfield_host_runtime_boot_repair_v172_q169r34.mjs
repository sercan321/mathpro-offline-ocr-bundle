#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_static_mathfield_host_runtime_boot_repair_v172_q169r34.mjs', retiredPhase: 'verify_mathlive_static_mathfield_host_runtime_boot_repair_v172_q169r34', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const required = [
  ['assets/mathlive/main_editor.html', 'data-q169r34-static-mathfield-host="true"'],
  ['assets/mathlive/main_editor.html', '<math-field id="mathlive-field"'],
  ['assets/mathlive/main_editor.html', 'data-mathpro-static-mathfield="V172-Q169R34"'],
  ['assets/mathlive/main_editor.html', 'MathProStaticMathfieldHostRepair'],
  ['assets/mathlive/mathlive_bridge.js', "staticMathfieldHostRepairPhase: 'V172-Q169R34'"],
  ['assets/mathlive/mathlive_bridge.js', "node.querySelector('math-field')"],
  ['assets/mathlive/mathlive_bridge.js', 'staticMathfieldHostAdopted'],
  ['assets/mathlive/mathlive_bridge.js', 'runtimeUsableByDefinedCustomElement'],
  ['lib/features/mathlive/mathlive_static_mathfield_host_runtime_boot_repair_policy.dart', "phase = 'V172-Q169R34'"],
  ['test/v172_q169r34_static_mathfield_host_runtime_boot_repair_test.dart', 'MathLiveStaticMathfieldHostRuntimeBootRepairPolicy'],
];
const failures = [];
for (const [file, marker] of required) {
  if (!fs.existsSync(file)) failures.push(`missing file: ${file}`);
  else if (!fs.readFileSync(file, 'utf8').includes(marker)) failures.push(`missing marker in ${file}: ${marker}`);
}
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
  if (!fs.existsSync(file)) failures.push(`missing protected file: ${file}`);
  else if (fs.readFileSync(file, 'utf8').includes('V172-Q169R34')) failures.push(`protected file touched with Q169R34 marker: ${file}`);
}
if (failures.length) {
  console.error('MATHLIVE_STATIC_MATHFIELD_HOST_RUNTIME_BOOT_REPAIR_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_STATIC_MATHFIELD_HOST_RUNTIME_BOOT_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_RUNTIME_MOUNT_EVIDENCE_REQUIRED');
