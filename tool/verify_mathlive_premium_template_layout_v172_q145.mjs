#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_premium_template_layout_v172_q145.mjs', retiredPhase: 'verify_mathlive_premium_template_layout_v172_q145', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_premium_template_layout_policy.dart',
  'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'assets/mathlive/manifest.json',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'test/v172_q145_mathlive_premium_template_layout_test.dart',
  'docs/audit/V172_Q145_MATHLIVE_PREMIUM_TEMPLATE_LAYOUT_AUDIT_REPORT.md',
  'docs/audit/V172_Q145_MATHLIVE_PREMIUM_TEMPLATE_LAYOUT_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const keyboard = exists(required[1]) ? read(required[1]) : '';
const bridge = exists(required[2]) ? read(required[2]) : '';
const html = exists(required[3]) ? read(required[3]) : '';
const manifest = exists(required[4]) ? read(required[4]) : '';
const surface = exists(required[5]) ? read(required[5]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q145'"],
  [policy, 'protectedKeyboardMutationAllowed = false'],
  [policy, 'protectedLongPressMutationAllowed = false'],
  [policy, 'namedTemplatesRenderAsMathematics = true'],
  [policy, 'compactLargeOperatorLayoutRequired = true'],
  [policy, 'rootFractionIntegralClippingAllowed = false'],
  [policy, 'photomathLevelClaimed = false'],
  [keyboard, "mainEditorPremiumTemplateLayoutPhase = 'V172-Q145'"],
  [keyboard, "'Taylor': r'\\textstyle"],
  [keyboard, "'Σ': r'\\textstyle\\sum"],
  [keyboard, "'Π': r'\\textstyle\\prod"],
  [keyboard, "'lim': r'\\textstyle\\lim"],
  [keyboard, "'3 Denklem': r'\\begin{cases}"],
  [bridge, 'premiumTemplateLayoutPhase'],
  [bridge, 'normalizeLatexForPremiumTemplateLayout'],
  [bridge, 'q145-premium-template-layout-normalized'],
  [html, 'V172-Q145: compact premium template court'],
  [html, '--q145-premium-template-layout: compact-no-wrap'],
  [html, 'white-space: nowrap'],
  [manifest, 'v172Q145PremiumTemplateLayout'],
  [surface, "templateLayoutPhase = 'V172-Q145'"]
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [keyboard, "'Taylor': 'Taylor'"],
  [keyboard, "'3 Denklem': '3 Denklem'"],
  [html, 'MathLive V172-Q']
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
  ? 'MATHLIVE_PREMIUM_TEMPLATE_LAYOUT_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_PREMIUM_TEMPLATE_LAYOUT';
const report = {
  phase: 'V172-Q145',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  visualTemplateRepairs: {
    compactLargeOperatorLayout: true,
    namedTemplatesRenderAsMathematics: true,
    mathLiveDebugBadgeVisible: false,
    mathLiveVirtualKeyboardVisible: false,
    protectedKeyboardMutationAllowed: false,
    protectedLongPressMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_premium_template_layout_v172_q145_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_premium_template_layout_v172_q145_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
