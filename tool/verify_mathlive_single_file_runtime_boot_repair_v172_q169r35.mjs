#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_single_file_runtime_boot_repair_v172_q169r35.mjs', retiredPhase: 'verify_mathlive_single_file_runtime_boot_repair_v172_q169r35', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const required = [
  ['assets/mathlive/main_editor.html', 'data-q169r35-single-file-runtime-boot="true"'],
  ['assets/mathlive/main_editor.html', 'data-mathpro-inline-runtime="V172-Q169R33"'],
  ['assets/mathlive/main_editor.html', 'data-mathpro-explicit-official-mathfield-registration="V172-Q169R35"'],
  ['assets/mathlive/main_editor.html', 'data-mathpro-inline-bridge="V172-Q169R35"'],
  ['assets/mathlive/main_editor.html', 'MathProSingleFileRuntimeBootRepair'],
  ['assets/mathlive/main_editor.html', "customElements.define('math-field', OfficialMathfieldElement)"],
  ['assets/mathlive/mathlive_bridge.js', "singleFileRuntimeBootRepairPhase: 'V172-Q169R35'"],
  ['assets/mathlive/mathlive_bridge.js', 'function q169R35EnsureOfficialMathfieldRegistration'],
  ['assets/mathlive/mathlive_bridge.js', 'q169r35-after-inline-runtime-executed'],
  ['assets/mathlive/mathlive_bridge.js', 'q169r35-initial-bridge-bootstrap'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', "import 'package:flutter/services.dart' show rootBundle;"],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'rootBundle.loadString(MathLiveMainEditorSurface.webViewAssetPath)'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'loadHtmlString(singleFileHtml)'],
  ['lib/features/mathlive/mathlive_single_file_runtime_boot_repair_policy.dart', "phase = 'V172-Q169R35'"],
  ['test/v172_q169r35_single_file_runtime_boot_repair_test.dart', 'MathLiveSingleFileRuntimeBootRepairPolicy'],
];
const failures = [];
for (const [file, marker] of required) {
  if (!fs.existsSync(file)) failures.push(`missing file: ${file}`);
  else if (!fs.readFileSync(file, 'utf8').includes(marker)) failures.push(`missing marker in ${file}: ${marker}`);
}
const html = fs.existsSync('assets/mathlive/main_editor.html') ? fs.readFileSync('assets/mathlive/main_editor.html', 'utf8') : '';
if (html.includes('<script src="mathlive_bridge.js"></script>')) failures.push('main_editor.html still depends on external mathlive_bridge.js for primary boot');
if (!html.includes('MathLive 0.109.2')) failures.push('main_editor.html does not contain the bundled official MathLive runtime payload');
if (!html.includes('window.MathProMathLiveOfflineBridge')) failures.push('main_editor.html does not contain the inlined bridge payload');
if (!html.includes('<math-field id="mathlive-field"')) failures.push('main_editor.html does not contain the static math-field host');
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
  else if (fs.readFileSync(file, 'utf8').includes('V172-Q169R35')) failures.push(`protected file touched with Q169R35 marker: ${file}`);
}
if (failures.length) {
  console.error('MATHLIVE_SINGLE_FILE_RUNTIME_BOOT_REPAIR_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_SINGLE_FILE_RUNTIME_BOOT_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
