#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_queue_flush_native_paint_commit_v172_q169.mjs', retiredPhase: 'verify_mathlive_queue_flush_native_paint_commit_v172_q169', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const failures = [];
const requireContains = (label, source, needle) => {
  if (!source.includes(needle)) failures.push(`${label} missing ${needle}`);
};

const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const bridge = read('assets/mathlive/mathlive_bridge.js');
const policy = read('lib/features/mathlive/mathlive_queue_flush_native_paint_commit_policy.dart');
const manifest = read('assets/mathlive/manifest.json');
const pubspec = read('pubspec.yaml');

requireContains('policy', policy, "phase = 'V172-Q169'");
requireContains('policy', policy, 'rawInsertTokensMayBeUserVisible = false');
requireContains('policy', policy, 'flutterFallbackMayPretendNativePaint = false');
requireContains('policy', policy, 'realDevicePassClaimed = false');
requireContains('policy', policy, 'photomathLevelClaimed = false');

requireContains('surface', surface, "queueFlushNativePaintCommitPhase = 'V172-Q169'");
requireContains('surface', surface, 'MathLiveQueueFlushNativePaintCommitPolicy');
requireContains('surface', surface, '_q169MayFlushQueuedCommands');
requireContains('surface', surface, 'q169-diagnostic-mf-true-flush');
requireContains('surface', surface, 'q169-command-state-mf-true-flush');
requireContains('surface', surface, 'Q169 KEY:');
requireContains('surface', surface, 'JS:');
requireContains('surface', surface, 'INSERT:');
requireContains('surface', surface, 'VALUE:');
requireContains('surface', surface, 'PAINT:');
requireContains('surface', surface, 'shouldDemoteFallback');
requireContains('surface', surface, 'Q167 KEY:');
requireContains('surface', surface, 'Q165 KEY:');

requireContains('bridge', bridge, "queueFlushNativePaintCommitPhase: 'V172-Q169'");
requireContains('bridge', bridge, 'updateNativePaintCommitState');
requireContains('bridge', bridge, 'markJsCommandStatus');
requireContains('bridge', bridge, 'lastInsertCommitted');
requireContains('bridge', bridge, 'lastValueNonEmpty');
requireContains('bridge', bridge, 'lastJsCommandStatus');
requireContains('bridge', bridge, 'nativePaintState');
requireContains('bridge', bridge, 'nativePaintLikelyVisible');
requireContains('bridge', bridge, "phase: 'V172-Q169'");
requireContains('bridge', bridge, 'q169-queue-flush-native-paint-commit-probe');
requireContains('bridge', bridge, 'q169-queue-flush-native-paint-commit SEND:Bridge JS:ok MF:true INSERT:true VALUE:non-empty PAINT:ok');
requireContains('bridge', bridge, 'rawInsertTokensMayBeUserVisible: false');

requireContains('manifest', manifest, 'v172Q169QueueFlushNativePaintCommit');
requireContains('manifest', manifest, 'v172Q169CurrentRuntimeTruth');
requireContains('manifest', manifest, 'nativePaintCommitStillRequiresRealDeviceConfirmation');
requireContains('manifest', manifest, 'rawInsertTokensMayBeUserVisible');
requireContains('pubspec', pubspec, 'version: 0.172.112+172');

const protectedNeedles = [
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
for (const rel of protectedNeedles) {
  if (!fs.existsSync(path.join(root, rel))) failures.push(`protected file missing ${rel}`);
}

if (failures.length) {
  console.error('MATHLIVE_QUEUE_FLUSH_NATIVE_PAINT_COMMIT_Q169_FAILED');
  for (const failure of failures) console.error(' - ' + failure);
  process.exit(1);
}

console.log('MATHLIVE_QUEUE_FLUSH_NATIVE_PAINT_COMMIT_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
