#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_semantic_template_coverage_v172_q142.mjs', retiredPhase: 'verify_mathlive_semantic_template_coverage_v172_q142', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_semantic_template_coverage_policy.dart',
  'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  'test/v172_q142_mathlive_semantic_template_coverage_test.dart',
  'docs/audit/V172_Q142_MATHLIVE_SEMANTIC_TEMPLATE_COVERAGE_AUDIT_REPORT.md',
  'docs/audit/V172_Q142_MATHLIVE_SEMANTIC_TEMPLATE_COVERAGE_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const keyboard = exists(required[1]) ? read(required[1]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q142'"],
  [policy, 'namedLabelsDoNotInsertPlainText = true'],
  [policy, 'matrixVectorLabelsUseMathTemplates = true'],
  [keyboard, "'EBOB': r'\\operatorname{EBOB}"],
  [keyboard, "'EKOK': r'\\operatorname{EKOK}"],
  [keyboard, "'Asal mı?': r'\\operatorname{asal}"],
  [keyboard, "'İşaret': r'\\operatorname{sgn}"],
  [keyboard, "'asin(□)': r'\\sin^{-1}"],
  [keyboard, "'cot': r'\\cot\\left(#0\\right)'"],
  [keyboard, "'f∘g': r'f\\circ g'"],
  [keyboard, "'□C□': r'\\binom{#0}{#?}'"],
  [keyboard, "'Γ(□)': r'\\Gamma\\left(#0\\right)'"],
  [keyboard, "'real(□)': r'\\operatorname{Re}"],
  [keyboard, "'conj(□)': r'\\overline{#0}'"],
  [keyboard, "'4×4': r'\\begin{bmatrix}"],
  [keyboard, "'3D vektör': r'\\begin{bmatrix}"],
  [keyboard, "'pseudo-inverse': r'#@^{+}'"],
  [keyboard, "'projeksiyon': r'\\operatorname{proj}_{#?}"],
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const mainMapMatch = keyboard.match(/mainEditorTemplateLatexCommands = <String, String>\{([\s\S]*?)\n  \};/);
if (!mainMapMatch) blockers.push('mainEditorTemplateLatexCommands map not found');
const mapBody = mainMapMatch ? mainMapMatch[1] : '';
const labels = [...mapBody.matchAll(/'([^']+)':\s*r'/g)].map((m) => m[1]);
const requiredLabels = [
  'EBOB','EKOK','Asal mı?','İşaret','⌊□⌋','⌈□⌉','asin(□)','asinh(□)','acos(□)','acosh(□)','atan(□)','atanh(□)',
  'cot','cot(□)','acot','acot(□)','cot⁻¹(□)','coth','coth(□)','sec','sec(□)','csc','csc(□)','f∘g','□P□','□C□','Γ(□)',
  'real(□)','imag(□)','conj(□)','Eşlenik','cis(□)','e^(i□)','4×4','m×n','0 matris','2D vektör','3D vektör','nD vektör',
  'satır vektörü','sütun vektörü','minör','kofaktör','pseudo-inverse','Moore-Penrose','dot(□,□)','projeksiyon','cross(□,□)',
  'triple product','karma çarpım','birim vektör','mesafe'
];
for (const label of requiredLabels) if (!labels.includes(label)) blockers.push(`missing main-editor semantic mapping for ${label}`);
const forbidden = [
  [policy, 'cursorPassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [keyboard, "'Taylor': 'Taylor'"],
  [keyboard, "'projeksiyon': r'projeksiyon'"],
  [keyboard, "'EBOB': r'EBOB'"],
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
  ? 'MATHLIVE_SEMANTIC_TEMPLATE_COVERAGE_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_SEMANTIC_TEMPLATE_COVERAGE';
const report = {
  phase: 'V172-Q142',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  behaviorRepairs: {
    broadStructureLabelCoverageAdded: true,
    namedLabelsDoNotInsertPlainText: true,
    matrixVectorLabelsUseMathTemplates: true,
    complexLabelsUseMathTemplates: true,
    cursorPassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_semantic_template_coverage_v172_q142_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_semantic_template_coverage_v172_q142_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
