#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_diagnostic_contract_cleanup_v172_q164.mjs', retiredPhase: 'verify_mathlive_diagnostic_contract_cleanup_v172_q164', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.argv[2] ? path.resolve(process.argv[2]) : process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const blockers = [];
const requireFile = (p) => { if (!exists(p)) blockers.push(`missing file: ${p}`); };
const requireContains = (label, text, needle) => { if (!text.includes(needle)) blockers.push(`${label} missing: ${needle}`); };
const requireNotContains = (label, text, needle) => { if (text.includes(needle)) blockers.push(`${label} must not contain: ${needle}`); };

const files = [
  'lib/features/mathlive/mathlive_diagnostic_contract_cleanup_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/mathlive_bridge.js',
  'test/v172_q164_mathlive_diagnostic_contract_cleanup_test.dart',
  'docs/audit/V172_Q164_MATHLIVE_DIAGNOSTIC_CONTRACT_CLEANUP_AUDIT.md',
  'docs/audit/V172_Q164_MATHLIVE_DIAGNOSTIC_CONTRACT_CLEANUP_CHANGED_FILES.md'
];
for (const file of files) requireFile(file);

const policy = exists(files[0]) ? read(files[0]) : '';
const surface = exists(files[1]) ? read(files[1]) : '';
const bridge = exists(files[2]) ? read(files[2]) : '';
const manifest = exists('assets/mathlive/manifest.json') ? read('assets/mathlive/manifest.json') : '';

requireContains('policy', policy, "phase = 'V172-Q164'");
requireContains('policy', policy, 'analyzerInterpolationHygieneApplied = true');
requireContains('policy', policy, 'q140InsertIntoMathfieldCompatibilityRestored = true');
requireContains('policy', policy, 'q161VisibleFallbackContractMarkerRestored = true');
requireContains('policy', policy, 'q163DiagnosticBridgePreserved = true');
requireContains('policy', policy, 'keyboardLayoutMutationAllowed = false');
requireContains('policy', policy, 'realDevicePassClaimed = false');
requireContains('surface', surface, "diagnosticContractCleanupPhase = 'V172-Q164'");
requireContains('surface', surface, "_refreshRealDeviceDiagnostic('q163-after-key-command-$label')");
requireNotContains('surface', surface, "'q163-after-key-command-' + label");
requireContains('surface', surface, 'visibleFallbackMayRenderStructuralTemplates');
requireContains('surface', surface, 'mathpro-q163-diagnostic-overlay');
requireContains('bridge', bridge, 'function insertIntoMathfield');
requireContains('bridge', bridge, 'if (!insertIntoMathfield(latex))');
requireContains('bridge', bridge, "diagnosticContractCleanupPhase: 'V172-Q164'");
requireContains('bridge', bridge, 'getRealDeviceDiagnosticReport');
requireContains('bridge', bridge, 'runDirectDiagnosticProbe');
requireContains('manifest', manifest, 'v172Q164DiagnosticContractCleanup');

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
  'lib/features/history/history_panel.dart'
];
for (const file of protectedFiles) requireFile(file);

const report = {
  phase: 'V172-Q164',
  status: blockers.length === 0
    ? 'MATHLIVE_DIAGNOSTIC_CONTRACT_CLEANUP_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
    : 'BLOCKED_MATHLIVE_DIAGNOSTIC_CONTRACT_CLEANUP',
  blockers,
  packageSideReady: blockers.length === 0,
  repairs: {
    analyzerInterpolationHygieneApplied: true,
    q140InsertIntoMathfieldCompatibilityRestored: true,
    q161VisibleFallbackContractMarkerRestored: true,
    q163DiagnosticBridgePreserved: true,
    protectedKeyboardMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
console.log(JSON.stringify(report, null, 2));
process.exit(blockers.length === 0 ? 0 : 2);
