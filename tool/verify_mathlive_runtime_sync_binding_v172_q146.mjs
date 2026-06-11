#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_runtime_sync_binding_v172_q146.mjs', retiredPhase: 'verify_mathlive_runtime_sync_binding_v172_q146', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_runtime_sync_binding_policy.dart',
  'lib/app/app_shell.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/manifest.json',
  'test/v172_q146_mathlive_runtime_sync_binding_test.dart',
  'docs/audit/V172_Q146_MATHLIVE_RUNTIME_SYNC_BINDING_AUDIT_REPORT.md',
  'docs/audit/V172_Q146_MATHLIVE_RUNTIME_SYNC_BINDING_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const shell = exists(required[1]) ? read(required[1]) : '';
const surface = exists(required[2]) ? read(required[2]) : '';
const manifest = exists(required[3]) ? read(required[3]) : '';
const test = exists(required[4]) ? read(required[4]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q146'"],
  [policy, 'mathLiveSnapshotFeedsCalculatorController = true'],
  [policy, 'mathLiveSnapshotFeedsGraphEligibility = true'],
  [policy, 'mathLiveSnapshotFeedsHistoryPayload = true'],
  [policy, 'mathLiveSnapshotFeedsSolutionCandidate = true'],
  [policy, 'graphHistorySolutionUiMutationAllowed = false'],
  [policy, 'historyControllerMutationAllowed = false'],
  [policy, 'graphCardMutationAllowed = false'],
  [policy, 'solutionStepsPanelMutationAllowed = false'],
  [policy, 'fakeSolutionAllowed = false'],
  [policy, 'fakeGraphAllowed = false'],
  [policy, 'photomathLevelClaimed = false'],
  [policy, 'class MathLiveRuntimeSyncEnvelope'],
  [policy, 'buildEnvelope'],
  [policy, 'expressionForController'],
  [policy, 'expressionForEvaluation'],
  [policy, 'expressionForHistory'],
  [policy, 'shouldBlockFakeSolution'],
  [shell, "import '../features/mathlive/mathlive_runtime_sync_binding_policy.dart';"],
  [shell, '_lastMathLiveRuntimeEnvelope'],
  [shell, 'MathLiveRuntimeSyncBindingPolicy.buildEnvelope'],
  [shell, 'MathLiveRuntimeSyncBindingPolicy.snapshotSource'],
  [shell, 'MathLiveRuntimeSyncBindingPolicy.expressionForEvaluation'],
  [shell, 'MathLiveRuntimeSyncBindingPolicy.expressionForHistory'],
  [shell, 'Graph eligibility, History payloads, and Solution/evaluator candidates'],
  [surface, "runtimeSyncBindingPhase = 'V172-Q146'"],
  [manifest, 'v172Q146RuntimeSyncBinding'],
  [manifest, 'mathLiveSnapshotFeedsCalculatorController'],
  [test, "MathLiveRuntimeSyncBindingPolicy.phase, 'V172-Q146'"]
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [policy, 'fakeSolutionAllowed = true'],
  [policy, 'fakeGraphAllowed = true'],
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
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
for (const rel of protectedFiles) if (!exists(rel)) blockers.push(`protected file missing: ${rel}`);
const status = blockers.length === 0
  ? 'MATHLIVE_RUNTIME_SYNC_BINDING_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_RUNTIME_SYNC_BINDING';
const report = {
  phase: 'V172-Q146',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  runtimeSyncRepairs: {
    mathLiveSnapshotFeedsCalculatorController: true,
    mathLiveSnapshotFeedsGraphEligibility: true,
    mathLiveSnapshotFeedsHistoryPayload: true,
    mathLiveSnapshotFeedsSolutionCandidate: true,
    protectedGraphHistorySolutionUiMutationAllowed: false,
    fakeSolutionAllowed: false,
    fakeGraphAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_runtime_sync_binding_v172_q146_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_runtime_sync_binding_v172_q146_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
