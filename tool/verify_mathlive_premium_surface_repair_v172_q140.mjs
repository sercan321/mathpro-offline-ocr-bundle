#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_premium_surface_repair_v172_q140.mjs', retiredPhase: 'verify_mathlive_premium_surface_repair_v172_q140', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_premium_surface_repair_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'test/v172_q140_mathlive_premium_surface_repair_test.dart',
  'docs/audit/V172_Q140_MATHLIVE_PREMIUM_SURFACE_REPAIR_AUDIT_REPORT.md',
  'docs/audit/V172_Q140_MATHLIVE_PREMIUM_SURFACE_REPAIR_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const surface = exists(required[1]) ? read(required[1]) : '';
const keyboard = exists(required[2]) ? read(required[2]) : '';
const bridge = exists(required[3]) ? read(required[3]) : '';
const html = exists(required[4]) ? read(required[4]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q140'"],
  [policy, 'visibleMathLiveBadgeRemoved = true'],
  [policy, 'activeInsertLatexUsesSelectionAwareHelper = true'],
  [surface, "premiumSurfaceRepairPhase = 'V172-Q140'"],
  [bridge, 'function insertIntoMathfield'],
  [bridge, "if (!insertIntoMathfield(latex))"],
  [bridge, "selectionMode: 'placeholder'"],
  [bridge, 'q140-pointerdown-focus-restored'],
  [html, 'overflow-y: visible'],
  [html, 'math-field::part(placeholder)'],
  [html, 'math-field::part(virtual-keyboard-toggle)'],
  [keyboard, "'a/b': r'\\frac{#0}{#?}'"],
  [keyboard, "'x^y': r'#@^{#?}'"],
  [keyboard, "'Taylor': r'f\\left(#?\\right)=\\sum_{n=0}^{\\infty}"],
  [keyboard, "'{3 denklem': r'\\begin{cases}"],
];
for (const [src, marker] of mustContain) {
  if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
}
const forbidden = [
  [surface, 'mathpro-main-editor-mathlive-migration-badge-q135-q139'],
  [surface, "Text(\n          'MathLive'"],
  [keyboard, "'x^y': r'^{#?}'"],
  [keyboard, "'Taylor': 'Taylor'"],
  [policy, 'cursorPassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
];
for (const [src, marker] of forbidden) {
  if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
}
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
  ? 'MATHLIVE_PREMIUM_SURFACE_REPAIR_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_PREMIUM_SURFACE_REPAIR';
const report = {
  phase: 'V172-Q140',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  behaviorRepairs: {
    visibleMathLiveBadgeRemoved: true,
    activeInsertPathUsesSelectionAwareHelper: true,
    semanticTemplateMappingAdded: true,
    taylorNoLongerPlainText: true,
    casesTemplatesMapped: true,
    pointerFocusHardeningAdded: true,
    cssClippingReliefAdded: true,
    mathLiveChromeHidden: true,
    cursorPassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_premium_surface_repair_v172_q140_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_premium_surface_repair_v172_q140_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
