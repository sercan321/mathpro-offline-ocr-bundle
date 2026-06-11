#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_mathfield_value_api_guard_v172_q169r7.mjs', retiredPhase: 'verify_mathlive_mathfield_value_api_guard_v172_q169r7', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const required = [
  ['lib/features/mathlive/mathlive_mathfield_value_api_guard_policy.dart', "phase = 'V172-Q169R7'"],
  ['lib/features/mathlive/mathlive_mathfield_value_api_guard_policy.dart', 'guardMathfieldGetValueVariants = true'],
  ['lib/features/mathlive/mathlive_mathfield_value_api_guard_policy.dart', 'forceDocumentCommitWhenPostInsertValueEmpty = true'],
  ['assets/mathlive/mathlive_bridge.js', "mathfieldValueApiGuardPhase: 'V172-Q169R7'"],
  ['assets/mathlive/mathlive_bridge.js', 'q169r7-mathfield-value-api-guarded'],
  ['assets/mathlive/mathlive_bridge.js', 'commitDocumentLatexToMathfield'],
  ['assets/mathlive/mathlive_bridge.js', 'q169r7-empty-after-insert-direct-value-commit'],
  ['assets/mathlive/mathlive_bridge.js', "markJsCommandStatus(inserted ? 'ok' : 'fail', 'q169-after-insert-mathfield q169r7-value-api-guard')"],
  ['test/v172_q169r7_mathlive_mathfield_value_api_guard_test.dart', 'V172-Q169R7 MathLive mathfield value API guard'],
  ['assets/mathlive/manifest.json', 'v172Q169R7MathfieldValueApiGuard'],
  ['README.md', 'V172-Q169R7 — MathLive Mathfield Value API Guard'],
  ['pubspec.yaml', 'V172-Q169R7 adds MathLive Mathfield Value API Guard'],
];

const failures = [];
for (const [file, marker] of required) {
  const text = fs.readFileSync(file, 'utf8');
  if (!text.includes(marker)) failures.push(`${file} missing marker: ${marker}`);
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
  if (!fs.existsSync(file)) failures.push(`protected file missing: ${file}`);
}

const pubspec = fs.readFileSync('pubspec.yaml', 'utf8');
const contract = fs.readFileSync('lib/logic/mathpro_package_contract.dart', 'utf8');
const match = contract.match(/pubspecDescription =\n\s*'([\s\S]*?)';/);
const description = match ? match[1].replace(/'\n\s*'/g, '') : '';
if (!description || !pubspec.includes(description)) failures.push('Historical MathProPackageContract.pubspecDescription must remain contiguous inside pubspec.yaml.');
if (description && pubspec.indexOf('V172-Q169R7 adds MathLive Mathfield Value API Guard') < pubspec.indexOf(description)) {
  failures.push('Q169R7 pubspec note must not interrupt or precede the historical package identity substring.');
}

if (failures.length) {
  console.error('MATHLIVE_MATHFIELD_VALUE_API_GUARD_Q169R7_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_MATHFIELD_VALUE_API_GUARD_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
