#!/usr/bin/env node
import { readFileSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_mf_true_bridge_dispatch_repair_v172_q169r4.mjs', retiredPhase: 'verify_mathlive_mf_true_bridge_dispatch_repair_v172_q169r4', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const required = [
  ['lib/features/mathlive/mathlive_mf_true_bridge_dispatch_repair_policy.dart', "phase = 'V172-Q169R4'"],
  ['lib/features/mathlive/mathlive_mf_true_bridge_dispatch_repair_policy.dart', 'canDispatchBridgeCommand'],
  ['lib/features/mathlive/mathlive_mf_true_bridge_dispatch_repair_policy.dart', 'shouldForceFlushAfterMfTrue'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', "mfTrueBridgeDispatchRepairPhase = 'V172-Q169R4'"],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', '_q169R4CanDispatchBridgeCommand'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'MathLiveMfTrueBridgeDispatchRepairPolicy.canDispatchBridgeCommand'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'MathLiveMfTrueBridgeDispatchRepairPolicy.shouldForceFlushAfterMfTrue'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'if (controller == null || !_q169R4CanDispatchBridgeCommand) return false;'],
  ['assets/mathlive/manifest.json', 'v172Q169R4MfTrueBridgeDispatchRepair'],
  ['README.md', 'V172-Q169R4 — MathLive MF:true Bridge Dispatch Repair'],
];

const failures = [];
for (const [file, marker] of required) {
  const text = readFileSync(file, 'utf8');
  if (!text.includes(marker)) failures.push(`${file} missing marker: ${marker}`);
}

const protectedForbidden = [
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

const policy = readFileSync('lib/features/mathlive/mathlive_mf_true_bridge_dispatch_repair_policy.dart', 'utf8');
if (!policy.includes('realDevicePassClaimed = false')) failures.push('Q169R4 policy must not claim real-device PASS.');
if (!policy.includes('photomathLevelClaimed = false')) failures.push('Q169R4 policy must not claim Photomath level.');

if (failures.length) {
  console.error('MATHLIVE_MF_TRUE_BRIDGE_DISPATCH_REPAIR_Q169R4_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}

console.log('MATHLIVE_MF_TRUE_BRIDGE_DISPATCH_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
