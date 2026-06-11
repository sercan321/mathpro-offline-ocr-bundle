import fs from 'node:fs';
import path from 'node:path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_real_device_diagnostic_bridge_v172_q163.mjs', retiredPhase: 'verify_mathlive_real_device_diagnostic_bridge_v172_q163', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const required = [
  'lib/features/mathlive/mathlive_real_device_diagnostic_bridge_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'assets/mathlive/manifest.json',
];
for (const file of required) {
  if (!fs.existsSync(path.join(root, file))) throw new Error(`missing required Q163 file: ${file}`);
}
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const bridge = read('assets/mathlive/mathlive_bridge.js');
const html = read('assets/mathlive/main_editor.html');
const manifest = read('assets/mathlive/manifest.json');
const checks = [
  [surface, "realDeviceDiagnosticPhase = 'V172-Q163'", 'surface phase'],
  [surface, 'mathpro-q163-diagnostic-overlay', 'visible diagnostic overlay'],
  [surface, '_refreshRealDeviceDiagnostic', 'diagnostic refresh method'],
  [bridge, 'function getRealDeviceDiagnosticReport', 'bridge diagnostic report'],
  [bridge, 'function runDirectDiagnosticProbe', 'direct diagnostic probe'],
  [bridge, 'q163-real-device-focus-insert-paint-probe', 'diagnostic marker'],
  [bridge, 'lastMathfieldValueBefore', 'value before telemetry'],
  [bridge, 'lastMathfieldValueAfter', 'value after telemetry'],
  [html, 'data-q163-real-device-diagnostic="enabled"', 'html diagnostic host marker'],
  [manifest, 'v172Q163RealDeviceDiagnosticBridge', 'manifest Q163 envelope'],
];
for (const [text, needle, label] of checks) {
  if (!text.includes(needle)) throw new Error(`missing ${label}: ${needle}`);
}
const protectedForbidden = [
  ['lib/features/keyboard/key_config.dart', 'V172-Q163'],
  ['lib/features/keyboard/math_keyboard.dart', 'V172-Q163'],
  ['lib/features/graph/graph_card.dart', 'V172-Q163'],
  ['lib/features/history/history_panel.dart', 'V172-Q163'],
  ['lib/features/solution/solution_steps_panel.dart', 'V172-Q163'],
];
for (const [file, marker] of protectedForbidden) {
  const full = path.join(root, file);
  if (fs.existsSync(full) && fs.readFileSync(full, 'utf8').includes(marker)) {
    throw new Error(`Q163 leaked into protected UI file: ${file}`);
  }
}
console.log('MATHLIVE_REAL_DEVICE_DIAGNOSTIC_BRIDGE_PACKAGE_READY_BUT_DEVICE_REPORT_REQUIRED');
