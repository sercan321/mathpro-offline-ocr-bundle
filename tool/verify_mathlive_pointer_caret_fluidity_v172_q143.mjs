#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_pointer_caret_fluidity_v172_q143.mjs', retiredPhase: 'verify_mathlive_pointer_caret_fluidity_v172_q143', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_pointer_caret_fluidity_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'test/v172_q143_mathlive_pointer_caret_fluidity_test.dart',
  'docs/audit/V172_Q143_MATHLIVE_POINTER_CARET_FLUIDITY_AUDIT_REPORT.md',
  'docs/audit/V172_Q143_MATHLIVE_POINTER_CARET_FLUIDITY_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const surface = exists(required[1]) ? read(required[1]) : '';
const bridge = exists(required[2]) ? read(required[2]) : '';
const html = exists(required[3]) ? read(required[3]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q143'"],
  [policy, 'webViewUsesEagerGestureRecognizer = true'],
  [policy, 'pointerDownPrimesMathfieldFocus = true'],
  [policy, 'pointerSelectionStillOwnedByMathLive = true'],
  [policy, 'cursorPassClaimed = false'],
  [surface, "pointerCaretFluidityPhase = 'V172-Q143'"],
  [surface, "import 'package:flutter/gestures.dart';"],
  [surface, "import 'package:flutter/foundation.dart';"],
  [surface, 'gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>'],
  [surface, 'Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())'],
  [surface, '_primeMathLivePointerSurface'],
  [surface, 'q143-after-keyboard-command-pointer-surface-primed'],
  [bridge, 'function primeInteractiveMathfield'],
  [bridge, 'function syncSelectionAfterMathLiveSettles'],
  [bridge, 'function describeMathfieldSelection'],
  [bridge, 'q143-pointerdown-capture-focus-primed'],
  [bridge, 'q143-touchstart-capture-focus-primed'],
  [bridge, 'q143-click-selection-synced'],
  [bridge, 'q143-blur-focus-recovery-scheduled'],
  [bridge, 'selection-owned-by-mathlive'],
  [bridge, 'primeInteractiveMathfield: primeInteractiveMathfield'],
  [html, 'touch-action: auto'],
  [html, 'math-field::part(editable)'],
  [html, 'math-field::part(root)'],
  [html, 'math-field::part(caret)'],
  [html, 'min-height: 82px'],
  [html, 'line-height: 1.36']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'cursorPassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [bridge, 'preventDefault()'],
  [bridge, 'stopPropagation()'],
  [surface, 'mathpro-main-editor-mathlive-migration-badge-q135-q139']
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
  ? 'MATHLIVE_POINTER_CARET_FLUIDITY_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_POINTER_CARET_FLUIDITY';
const report = {
  phase: 'V172-Q143',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  behaviorRepairs: {
    webViewUsesEagerGestureRecognizer: true,
    pointerDownPrimesMathfieldFocus: true,
    pointerSelectionStillOwnedByMathLive: true,
    selectionStateSyncAfterTapSettles: true,
    blurRecoveryIsScoped: true,
    keyboardCommandPrimesPointerSurface: true,
    mathfieldTouchActionIsAuto: true,
    cursorPassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_pointer_caret_fluidity_v172_q143_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_pointer_caret_fluidity_v172_q143_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
