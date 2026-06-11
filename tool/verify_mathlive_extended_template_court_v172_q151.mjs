#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_extended_template_court_v172_q151.mjs', retiredPhase: 'verify_mathlive_extended_template_court_v172_q151', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_extended_template_court_policy.dart',
  'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  'test/v172_q151_mathlive_extended_template_court_test.dart',
  'assets/mathlive/manifest.json',
  'docs/audit/V172_Q151_MATHLIVE_EXTENDED_TEMPLATE_COURT_AUDIT_REPORT.md',
  'docs/audit/V172_Q151_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const keyboard = exists(required[1]) ? read(required[1]) : '';
const test = exists(required[2]) ? read(required[2]) : '';
const manifest = exists(required[3]) ? read(required[3]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q151'"],
  [policy, 'realBehaviorRepair = true'],
  [policy, 'mainEditorBridgeOnly = true'],
  [policy, 'keyboardLayoutMutationAllowed = false'],
  [policy, 'longPressOrderMutationAllowed = false'],
  [policy, 'moreInventoryMutationAllowed = false'],
  [policy, 'photomathLevelClaimed = false'],
  [keyboard, "mainEditorExtendedTemplateCourtPhase = 'V172-Q151'"],
  [keyboard, "'Kuadratik': r'x=\\frac{-b\\pm\\sqrt"],
  [keyboard, "'∫₀¹ f(x)': r'\\int_{0}^{1} #0\\,dx'"],
  [keyboard, "'lim sin(x)/x': r'\\textstyle\\lim_{x\\to 0}"],
  [keyboard, "'RREF': r'\\operatorname{rref}"],
  [keyboard, "'Rank': r'\\operatorname{rank}"],
  [keyboard, "'Özdeğer': r'\\operatorname{eig}"],
  [keyboard, "'Çöz': r'\\operatorname{solve}"],
  [keyboard, "'A⁻¹': r'A^{-1}'"],
  [keyboard, "'Bᵀ': r'B^{T}'"],
  [keyboard, "'□ᴴ': r'#@^{H}'"],
  [keyboard, "'z̄': r'\\overline{z}'"],
  [keyboard, "'≠': r'\\ne "],
  [keyboard, "'≤': r'\\le "],
  [keyboard, "'≥': r'\\ge "],
  [keyboard, "'≈': r'\\approx "],
  [keyboard, "'λ': r'\\lambda "],
  [keyboard, "'μ': r'\\mu "],
  [manifest, 'v172Q151MathLiveExtendedTemplateCourt'],
  [test, 'MathLiveExtendedTemplateCourtPolicy.phase']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'keyboardLayoutMutationAllowed = true'],
  [policy, 'longPressOrderMutationAllowed = true'],
  [policy, 'moreInventoryMutationAllowed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [policy, 'realDevicePassClaimed = true'],
  [keyboard, "'Kuadratik': r'Kuadratik'"],
  [keyboard, "'RREF': r'RREF'"],
  [keyboard, "'Özdeğer': r'Özdeğer'"],
  [keyboard, "'Çöz': r'Çöz'"],
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
const mainMapMatch = keyboard.match(/mainEditorTemplateLatexCommands = <String, String>\{([\s\S]*?)\n  \};/);
if (!mainMapMatch) blockers.push('mainEditorTemplateLatexCommands map not found');
const labels = mainMapMatch ? [...mainMapMatch[1].matchAll(/'([^']+)':\s*r["']/g)].map((m) => m[1]) : [];
const requiredLabels = [
  'Kuadratik','(x+y)²','∫₀¹ f(x)','lim sin(x)/x','2×2 Matris','Mutlak','Yuvarla','Kalan',
  'RREF','Rank','Özdeğer','Çöz','A','A₁','A₂','A⁻¹','Aᵀ','B','B₁','B₂','B⁻¹','Bᵀ',
  'I','□ᴴ','z̄','−i','i²','≠','≤','≥','≈','≡','+∞','−∞','λ','μ','ρ','φ','rad','deg'
];
for (const label of requiredLabels) if (!labels.includes(label)) blockers.push(`missing Q151 main-editor mapping for ${label}`);
const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart'
];
for (const rel of protectedFiles) {
  if (!exists(rel)) blockers.push(`protected file missing: ${rel}`);
  else if (read(rel).includes('V172-Q151')) blockers.push(`protected file contains Q151 mutation marker: ${rel}`);
}
const status = blockers.length === 0
  ? 'MATHLIVE_EXTENDED_TEMPLATE_COURT_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_EXTENDED_TEMPLATE_COURT';
const report = {
  phase: 'V172-Q151',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  behaviorRepairs: {
    extendedVisibleLabelCoverageAdded: true,
    mainEditorBridgeOnly: true,
    labelsDoNotFallThroughAsRawText: blockers.length === 0,
    protectedKeyboardLayoutUnchangedByPolicy: true,
    solverExpansionClaimed: false,
    cursorPassClaimed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_extended_template_court_v172_q151_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_extended_template_court_v172_q151_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
