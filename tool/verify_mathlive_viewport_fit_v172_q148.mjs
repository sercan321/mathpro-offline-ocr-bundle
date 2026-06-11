#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_viewport_fit_v172_q148.mjs', retiredPhase: 'verify_mathlive_viewport_fit_v172_q148', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_viewport_fit_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'assets/mathlive/manifest.json',
  'test/v172_q148_mathlive_viewport_fit_test.dart',
  'docs/audit/V172_Q148_MATHLIVE_VIEWPORT_FIT_AUDIT_REPORT.md',
  'docs/audit/V172_Q148_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const surface = exists(required[1]) ? read(required[1]) : '';
const bridge = exists(required[2]) ? read(required[2]) : '';
const html = exists(required[3]) ? read(required[3]) : '';
const manifest = exists(required[4]) ? read(required[4]) : '';
const test = exists(required[5]) ? read(required[5]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q148'"],
  [policy, 'viewportFitRunsAfterRuntimeMount = true'],
  [policy, 'viewportFitRunsAfterKeyboardCommand = true'],
  [policy, 'viewportFitRunsAfterExternalSync = true'],
  [policy, 'legacyFlutterCursorOverlayMayReturn = false'],
  [policy, 'photomathLevelClaimed = false'],
  [surface, "viewportFitPhase = 'V172-Q148'"],
  [surface, 'MathLiveViewportFitPolicy.viewportFitRunsAfterKeyboardCommand'],
  [surface, '_keepMathLiveCaretVisible'],
  [bridge, "viewportFitPhase: 'V172-Q148'"],
  [bridge, 'viewportFitClassForLatex'],
  [bridge, 'applyViewportFit'],
  [bridge, 'keepCaretVisible'],
  [bridge, 'scheduleViewportFit'],
  [bridge, 'q148-insert-latex-caret-follow'],
  [bridge, 'q148-after-keyboard-command-caret-visible'],
  [html, 'V172-Q148: premium viewport fit'],
  [html, 'mathpro-fit-normal'],
  [html, 'mathpro-fit-compact'],
  [html, 'mathpro-fit-dense'],
  [html, 'mathpro-fit-micro'],
  [manifest, 'v172Q148ViewportFit'],
  [manifest, 'viewportFitClasses'],
  [test, "MathLiveViewportFitPolicy.phase, 'V172-Q148'"]
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [policy, 'legacyFlutterCursorOverlayMayReturn = true'],
  [bridge, 'MathLive V172-Q']
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
  ? 'MATHLIVE_VIEWPORT_FIT_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_VIEWPORT_FIT';
const report = {
  phase: 'V172-Q148',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  viewportFitRepairs: {
    adaptiveFitClasses: ['mathpro-fit-normal','mathpro-fit-compact','mathpro-fit-dense','mathpro-fit-micro'],
    runsAfterRuntimeMount: true,
    runsAfterKeyboardCommand: true,
    runsAfterExternalSync: true,
    caretFollowUsesMathLiveSurface: true,
    legacyFlutterCursorOverlayMayReturn: false,
    protectedKeyboardMutationAllowed: false,
    protectedLongPressMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_viewport_fit_v172_q148_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_viewport_fit_v172_q148_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
