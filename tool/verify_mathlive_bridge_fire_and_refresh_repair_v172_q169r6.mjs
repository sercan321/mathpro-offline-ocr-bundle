#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_bridge_fire_and_refresh_repair_v172_q169r6.mjs', retiredPhase: 'verify_mathlive_bridge_fire_and_refresh_repair_v172_q169r6', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const required = [
  ['lib/features/mathlive/mathlive_bridge_fire_and_refresh_repair_policy.dart', "phase = 'V172-Q169R6'"],
  ['lib/features/mathlive/mathlive_bridge_fire_and_refresh_repair_policy.dart', 'returningResultMustNotBlockDispatch = true'],
  ['lib/features/mathlive/mathlive_bridge_fire_and_refresh_repair_policy.dart', 'fireAndRefreshAfterPendingAck = true'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'MathLiveBridgeFireAndRefreshRepairPolicy.returningResultAckTimeout'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', '_fireQ169R6CommandAndRefreshState'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'q169r6-fire-and-refresh-after-pending-ack'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'consumeAsyncChannelStateForDiagnostics'],
  ['assets/mathlive/manifest.json', 'v172Q169R6BridgeFireAndRefreshRepair'],
  ['README.md', 'V172-Q169R6 — MathLive Bridge Fire-and-Refresh Repair'],
  ['pubspec.yaml', 'V172-Q169R6 adds MathLive Bridge Fire-and-Refresh Repair'],
];

const failures = [];
for (const [file, marker] of required) {
  const text = fs.readFileSync(file, 'utf8');
  if (!text.includes(marker)) failures.push(`${file} missing marker: ${marker}`);
}

const forbiddenProtected = [
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
  'lib/app/app_shell.dart',
];
for (const file of forbiddenProtected) {
  if (!fs.existsSync(file)) failures.push(`protected file missing: ${file}`);
}

const pubspec = fs.readFileSync('pubspec.yaml', 'utf8');
const contract = fs.readFileSync('lib/logic/mathpro_package_contract.dart', 'utf8');
const match = contract.match(/pubspecDescription =\n\s*'([\s\S]*?)';/);
const description = match ? match[1].replace(/'\n\s*'/g, '') : '';
if (!description || !pubspec.includes(description)) failures.push('Historical MathProPackageContract.pubspecDescription must remain contiguous inside pubspec.yaml.');
if (description && pubspec.indexOf('V172-Q169R6 adds MathLive Bridge Fire-and-Refresh Repair') < pubspec.indexOf(description)) {
  failures.push('Q169R6 pubspec note must not interrupt or precede the historical package identity substring.');
}

if (failures.length) {
  console.error('MATHLIVE_BRIDGE_FIRE_AND_REFRESH_REPAIR_Q169R6_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_BRIDGE_FIRE_AND_REFRESH_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
