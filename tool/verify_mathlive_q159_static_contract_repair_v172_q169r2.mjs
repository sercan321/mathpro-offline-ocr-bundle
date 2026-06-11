#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_q159_static_contract_repair_v172_q169r2.mjs', retiredPhase: 'verify_mathlive_q159_static_contract_repair_v172_q169r2', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const failures = [];
const requireFile = (rel) => { if (!exists(rel)) failures.push(`missing ${rel}`); };
const requireContains = (label, text, needle) => { if (!text.includes(needle)) failures.push(`${label} missing ${needle}`); };
const requireNotContains = (label, text, needle) => { if (text.includes(needle)) failures.push(`${label} must not contain ${needle}`); };

const files = [
  'lib/features/mathlive/mathlive_q159_static_contract_repair_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'test/v172_q169r2_mathlive_q159_static_contract_repair_test.dart',
  'docs/audit/V172_Q169R2_MATHLIVE_Q159_STATIC_CONTRACT_REPAIR_AUDIT.md',
  'docs/audit/V172_Q169R2_MATHLIVE_Q159_STATIC_CONTRACT_REPAIR_CHANGED_FILES.md'
];
for (const file of files) requireFile(file);

const policy = exists(files[0]) ? read(files[0]) : '';
const surface = exists(files[1]) ? read(files[1]) : '';
const manifest = exists('assets/mathlive/manifest.json') ? read('assets/mathlive/manifest.json') : '';

requireContains('policy', policy, "phase = 'V172-Q169R2'");
requireContains('policy', policy, 'q159FlushCompatibilityMarkerPreserved = true');
requireContains('policy', policy, 'runtimeQueueFlushSemanticsChanged = false');
requireContains('policy', policy, 'q169NativePaintCommitSemanticsChanged = false');
requireContains('policy', policy, 'keyboardLayoutMutationAllowed = false');
requireContains('policy', policy, 'realDevicePassClaimed = false');
requireContains('surface', surface, "q159StaticContractRepairPhase = 'V172-Q169R2'");
requireContains('surface', surface, '_flushQueuedLabels(lastAnswer: widget.lastAnswer)');
requireContains('surface', surface, "_refreshRealDeviceDiagnostic('q169-after-key-command-$label')");
requireContains('surface', surface, "_refreshRealDeviceDiagnostic('q163-after-key-command-$label')");
requireContains('surface', surface, 'q169-command-state-mf-true-flush');
requireContains('surface', surface, 'q169-diagnostic-mf-true-flush');
requireContains('surface', surface, 'Q169 KEY:');
requireContains('surface', surface, 'PAINT:');
requireNotContains('surface', surface, "import 'mathlive_appshell_command_bus_hard_binding_policy.dart';");
requireContains('manifest', manifest, 'v172Q169R2Q159StaticContractRepair');

const protectedFiles = [
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
  'lib/app/app_shell.dart'
];
for (const rel of protectedFiles) requireFile(rel);

if (failures.length) {
  console.error('MATHLIVE_Q159_STATIC_CONTRACT_REPAIR_Q169R2_FAILED');
  for (const failure of failures) console.error(' - ' + failure);
  process.exit(1);
}
console.log('MATHLIVE_Q159_STATIC_CONTRACT_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
