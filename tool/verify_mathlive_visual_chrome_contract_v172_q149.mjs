#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_visual_chrome_contract_v172_q149.mjs', retiredPhase: 'verify_mathlive_visual_chrome_contract_v172_q149', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_visual_chrome_contract_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'assets/mathlive/manifest.json',
  'test/v172_q149_mathlive_visual_chrome_contract_test.dart',
  'docs/audit/V172_Q149_MATHLIVE_VISUAL_CHROME_CONTRACT_AUDIT_REPORT.md',
  'docs/audit/V172_Q149_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const surface = exists(required[1]) ? read(required[1]) : '';
const bridge = exists(required[2]) ? read(required[2]) : '';
const html = exists(required[3]) ? read(required[3]) : '';
const manifest = exists(required[4]) ? read(required[4]) : '';
const test = exists(required[5]) ? read(required[5]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q149'"],
  [policy, 'visibleMathLiveBrandingAllowed = false'],
  [policy, 'visibleVirtualKeyboardToggleAllowed = false'],
  [policy, 'visibleMenuToggleAllowed = false'],
  [policy, 'debugBadgeAllowedInMainEditor = false'],
  [policy, 'nativeKeyboardChromeAllowed = false'],
  [policy, 'photomathLevelClaimed = false'],
  [bridge, "visualChromeContractPhase: 'V172-Q149'"],
  [bridge, 'suppressVisibleMathLiveBranding'],
  [bridge, 'visibleMathLiveBrandingAllowed: false'],
  [bridge, 'mathLiveChromeVisible: false'],
  [bridge, 'data-mathpro-visible-chrome'],
  [html, 'V172-Q149: final visible chrome sweep'],
  [html, 'data-mathpro-visible-chrome="suppressed"'],
  [html, '[data-mathpro-hidden-chrome="true"]'],
  [surface, "visualChromeContractPhase = 'V172-Q149'"],
  [surface, '_suppressMathLiveVisibleChrome'],
  [manifest, 'v172Q149VisualChromeContract'],
  [manifest, 'visibleMathLiveBrandingAllowed'],
  [test, 'MathLiveVisualChromeContractPolicy.phase']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'visibleMathLiveBrandingAllowed = true'],
  [policy, 'visibleVirtualKeyboardToggleAllowed = true'],
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [html, '>MathLive runtime bekleniyor'],
  [html, '>MathLive runtime'],
  [bridge, 'MathLive runtime eksik — node tool/install_mathlive_runtime.mjs'],
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
  ? 'MATHLIVE_VISUAL_CHROME_CONTRACT_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_VISUAL_CHROME_CONTRACT';
const report = {
  phase: 'V172-Q149',
  status,
  blockers,
  visualChromeContract: {
    visibleMathLiveBrandingAllowed: false,
    visibleVirtualKeyboardToggleAllowed: false,
    visibleMenuToggleAllowed: false,
    debugBadgeAllowedInMainEditor: false,
    nativeKeyboardChromeAllowed: false,
    protectedKeyboardMutationAllowed: false,
    protectedLongPressMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_visual_chrome_contract_v172_q149_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_visual_chrome_contract_v172_q149_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
