#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_state_normalization.mjs', retiredPhase: 'verify_mathlive_state_normalization', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

/*
 * V172-Q102 MathLive State Normalization Hardening verifier.
 *
 * This verifier is offline and package-side only. It checks that deterministic
 * MathLive LaTeX normalization samples produce safe Graph / History / Solution /
 * evaluator candidate strings while keeping MathLive out of the main editor and
 * preserving protected UI surfaces. It does not install runtime files, author
 * canonical smoke evidence, or claim cursor/device PASS.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_state_normalization_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_state_normalization_report.md');

function rel(absolutePath) {
  return path.relative(projectRoot, absolutePath).replaceAll(path.sep, '/');
}

function readText(relativePath) {
  const absolutePath = path.join(projectRoot, relativePath);
  return existsSync(absolutePath) ? readFileSync(absolutePath, 'utf8') : '';
}

function canonicalLatex(value) {
  return String(value || '').replaceAll('\u00a0', ' ').replaceAll('−', '-').replace(/\s+/g, ' ').trim();
}

function normalizeLatexToExpression(value) {
  let out = canonicalLatex(value);
  if (!out) return '';
  out = out
    .replaceAll('\\left', '')
    .replaceAll('\\right', '')
    .replaceAll('\\,', '')
    .replaceAll('\\;', '')
    .replaceAll('\\:', '')
    .replaceAll('\\cdot', '*')
    .replaceAll('\\times', '*')
    .replaceAll('\\div', '/')
    .replaceAll('\\pi', 'pi')
    .replaceAll('π', 'pi')
    .replaceAll('\\theta', 'theta')
    .replaceAll('\\infty', 'infinity');
  out = out.replace(/\\operatorname\{([^{}]+)\}/g, '$1');
  let previous = '';
  while (previous !== out) {
    previous = out;
    out = out.replace(/\\frac\{([^{}]+)\}\{([^{}]+)\}/g, '($1)/($2)');
  }
  out = out.replace(/\\sqrt\[([^\[\]{}]+)\]\{([^{}]+)\}/g, 'root_$1($2)');
  previous = '';
  while (previous !== out) {
    previous = out;
    out = out.replace(/\\sqrt\{([^{}]+)\}/g, 'sqrt($1)');
  }
  out = out
    .replace(/\\log_\{([^{}]+)\}\(([^()]*)\)/g, 'log_$1($2)')
    .replace(/\\log_([^\\\s{}()]+)\(([^()]*)\)/g, 'log_$1($2)')
    .replace(/\\log_\{([^{}]+)\}\{([^{}]+)\}/g, 'log_$1($2)')
    .replaceAll('\\log', 'log')
    .replaceAll('\\sin', 'sin')
    .replaceAll('\\cos', 'cos')
    .replaceAll('\\tan', 'tan')
    .replaceAll('\\ln', 'ln')
    .replaceAll('\\exp', 'exp')
    .replace(/\^\{([^{}]+)\}/g, '^$1')
    .replace(/_\{([^{}]+)\}/g, '_$1')
    .replace(/\s+/g, '')
    .replaceAll('{', '')
    .replaceAll('}', '')
    .replaceAll('[', '(')
    .replaceAll(']', ')');
  return out;
}

function hasVariable(expression, variable) {
  return new RegExp(`(^|[^a-zA-Z])${variable}([^a-zA-Z]|$)`).test(expression.toLowerCase());
}

function graphIntent(expression) {
  const x = hasVariable(expression, 'x');
  const y = hasVariable(expression, 'y');
  if (!expression) return 'empty';
  if (/^y=/.test(expression) && x) return 'graphableExplicit';
  if (x && y && expression.includes('=')) return 'implicitPending';
  if (x && !y) return 'graphableExplicit';
  if (!x && !y && /^[0-9+\-*/().,^_a-zA-Z]+$/.test(expression) && !expression.includes('=')) return 'constantSuggestion';
  return 'notGraphable';
}

const samples = [
  { label: 'numeric-add', latex: '3+5', normalized: '3+5', graphIntent: 'constantSuggestion' },
  { label: 'explicit-x-power', latex: 'x^{2}', normalized: 'x^2', graphIntent: 'graphableExplicit' },
  { label: 'sin-x', latex: '\\sin\\left(x\\right)', normalized: 'sin(x)', graphIntent: 'graphableExplicit' },
  { label: 'log-base-two', latex: '\\log_{2}\\left(8\\right)', normalized: 'log_2(8)', graphIntent: 'constantSuggestion' },
  { label: 'fraction-sum', latex: '\\frac{1}{2}+\\frac{3}{4}', normalized: '(1)/(2)+(3)/(4)', graphIntent: 'constantSuggestion' },
  { label: 'sqrt-x', latex: '\\sqrt{x}', normalized: 'sqrt(x)', graphIntent: 'graphableExplicit' },
  { label: 'explicit-y-equals', latex: 'y=x^{2}', normalized: 'y=x^2', graphIntent: 'graphableExplicit' },
  { label: 'implicit-circle', latex: 'x^{2}+y^{2}=1', normalized: 'x^2+y^2=1', graphIntent: 'implicitPending' },
];

mkdirSync(reportDir, { recursive: true });
const blockers = [];
const requiredFiles = [
  'lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart',
  'test/v172_q102_mathlive_state_normalization_test.dart',
  'docs/audit/V172_Q102_MATHLIVE_STATE_NORMALIZATION_AUDIT_REPORT.md',
  'docs/audit/V172_Q102_CHANGED_FILES_MANIFEST.md',
  'assets/mathlive/manifest.json',
  'lib/logic/mathpro_package_contract.dart',
  'README.md',
];
for (const file of requiredFiles) {
  if (!existsSync(path.join(projectRoot, file))) blockers.push(`required Q102 file missing: ${file}`);
}

const policy = readText('lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart');
const q92 = readText('lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart');
const manifest = readText('assets/mathlive/manifest.json');
const contract = readText('lib/logic/mathpro_package_contract.dart');
const readme = readText('README.md');
const forbidden = [
  'mainEditorSwitchAllowed = true',
  'mainEditorMountAllowed = true',
  'mathLiveEnabledByDefault = true',
  'legacyCursorDeletionAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'cursorPassClaimAllowed = true',
  'photomathWolframClaimAllowed = true',
  'writesCanonicalSmokeEvidence = true',
  'installsRuntimeFiles = true',
  'graphUiMutationAllowed = true',
  'historyUiMutationAllowed = true',
  'solutionUiMutationAllowed = true',
  '"q102MaySwitchMainEditor": true',
  '"q102MayDeleteLegacyCursor": true',
  '"q102ProtectedUiSurfaceMutationAllowed": true',
];
const requiredMarkers = [
  [policy, "phase = 'V172-Q102'"],
  [policy, 'packageSideNormalizerImplemented = true'],
  [policy, 'q101LabSmokeEvidenceClosureRequiredForActivation = true'],
  [policy, 'mainEditorSwitchAllowed = false'],
  [policy, 'legacyCursorDeletionAllowed = false'],
  [q92, 'MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro'],
  [manifest, '"q102MathLiveStateNormalizationPhase": "V172-Q102"'],
  [manifest, '"q102MaySwitchMainEditor": false'],
  [manifest, '"q102MayDeleteLegacyCursor": false'],
  [contract, 'q102MathLiveStateNormalizationHardeningRule'],
  [readme, 'V172-Q102 MathLive State Normalization Hardening'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) blockers.push(`missing marker: ${marker}`);
}
const combined = [policy, manifest, contract, readme].join('\n');
for (const marker of forbidden) {
  if (combined.includes(marker)) blockers.push(`illegal Q102 enabling marker: ${marker}`);
}

const sampleResults = samples.map(sample => {
  const normalized = normalizeLatexToExpression(sample.latex);
  const intent = graphIntent(normalized);
  const pass = normalized === sample.normalized && intent === sample.graphIntent;
  if (!pass) blockers.push(`sample ${sample.label} expected ${sample.normalized}/${sample.graphIntent} but got ${normalized}/${intent}`);
  return { ...sample, actualNormalized: normalized, actualGraphIntent: intent, pass };
});

const deterministicSampleSuitePasses = sampleResults.every(s => s.pass);
const q101ClosureReport = (() => {
  const file = path.join(projectRoot, 'tool', 'reports', 'mathlive_lab_smoke_evidence_closure_report.json');
  if (!existsSync(file)) return null;
  try { return JSON.parse(readFileSync(file, 'utf8')); } catch { return null; }
})();
const q101Closed = q101ClosureReport?.labSmokeEvidenceClosed === true;
const packageReady = blockers.length === 0 || (blockers.length === 1 && blockers[0].includes('Q101 Lab'));
if (!q101Closed) blockers.push('Q101 Lab smoke evidence closure has not passed; Q102 remains package-side only');

const status = deterministicSampleSuitePasses && requiredFiles.every(file => existsSync(path.join(projectRoot, file))) && !combined.includes('mainEditorSwitchAllowed = true')
  ? (q101Closed ? 'MATHLIVE_STATE_NORMALIZATION_READY_FOR_Q103_BINDING' : 'MATHLIVE_STATE_NORMALIZATION_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED')
  : 'BLOCKED_MATHLIVE_STATE_NORMALIZATION_HARDENING';

const report = {
  phase: 'V172-Q102',
  status,
  generatedAt: new Date().toISOString(),
  packageSideNormalizationReady: status !== 'BLOCKED_MATHLIVE_STATE_NORMALIZATION_HARDENING',
  q101LabSmokeEvidenceClosed: q101Closed,
  mayProceedToQ103Binding: status === 'MATHLIVE_STATE_NORMALIZATION_READY_FOR_Q103_BINDING',
  maySwitchMainEditor: false,
  mayMountMainEditor: false,
  mayEnableMathLiveByDefault: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  protectedUiSurfaceMutationAllowed: false,
  graphHistorySolutionUiMutationAllowed: false,
  deterministicSampleSuitePasses,
  samples: sampleResults,
  blockers,
};
writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q102 MathLive State Normalization Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- packageSideNormalizationReady: ${String(report.packageSideNormalizationReady)}`,
  `- q101LabSmokeEvidenceClosed: ${String(q101Closed)}`,
  '- maySwitchMainEditor: false',
  '- mayMountMainEditor: false',
  '- mayEnableMathLiveByDefault: false',
  '- mayDeleteLegacyCursor: false',
  '',
  '## Samples',
  ...sampleResults.map(s => `- ${s.label}: ${s.pass ? 'PASS' : 'FAIL'} → ${s.actualNormalized} / ${s.actualGraphIntent}`),
  '',
  '## Blockers',
  ...(blockers.length ? blockers.map(item => `- ${item}`) : ['- none']),
  '',
].join('\n');
writeFileSync(mdReportPath, md, 'utf8');
console.log(JSON.stringify({
  phase: report.phase,
  status: report.status,
  jsonReportPath: rel(jsonReportPath),
  mdReportPath: rel(mdReportPath),
  blockers: blockers.length,
  deterministicSampleSuitePasses,
  mayProceedToQ103Binding: report.mayProceedToQ103Binding,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
}, null, 2));
process.exit(status === 'BLOCKED_MATHLIVE_STATE_NORMALIZATION_HARDENING' ? 2 : 0);
