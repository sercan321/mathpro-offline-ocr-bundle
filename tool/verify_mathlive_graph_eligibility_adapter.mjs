#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_graph_eligibility_adapter.mjs', retiredPhase: 'verify_mathlive_graph_eligibility_adapter', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

/*
 * V172-Q103 Graph Eligibility Adapter Real Binding verifier.
 *
 * Offline/package-side only. It verifies that MathLive Q102 normalized samples
 * can be classified into GraphEligibility-style envelopes without mutating
 * graph_card.dart, switching the main editor, deleting legacy cursor files, or
 * claiming runtime/device PASS.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_graph_eligibility_adapter_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_graph_eligibility_adapter_report.md');

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

function formatConstant(value) {
  if (Math.abs(value - Math.round(value)) < 1e-10) return String(Math.round(value));
  return value.toFixed(6).replace(/0+$/, '').replace(/\.$/, '');
}

function tryEvaluateNumeric(expression) {
  const normalized = expression.replaceAll('^', '**');
  if (!/^[0-9+\-*/().\s*]+$/.test(normalized)) return { success: false, displayValue: '', unsupportedReason: 'non-basic-numeric-expression' };
  try {
    // The expression is regex-gated to a numeric subset before evaluation.
    const value = Function(`"use strict"; return (${normalized});`)();
    if (typeof value !== 'number' || !Number.isFinite(value)) return { success: false, displayValue: '', unsupportedReason: 'non-finite-result' };
    return { success: true, value, displayValue: formatConstant(value), unsupportedReason: '' };
  } catch {
    return { success: false, displayValue: '', unsupportedReason: 'numeric-parser-failed' };
  }
}

function classifyGraphEligibility(expression, result) {
  const cleanExpression = expression.trim().replaceAll('−', '-').replaceAll('×', '*').replaceAll('÷', '/');
  const cleanResult = String(result || '').trim().replace(/^=\s*/, '').replaceAll(',', '.');
  if (!cleanExpression) return { kind: 'notGraphable', normalizedExpression: '', constantValue: null };
  const lower = cleanExpression.toLowerCase();
  const hasX = hasVariable(lower, 'x');
  const hasY = hasVariable(lower, 'y');
  const hasEquality = cleanExpression.includes('=');
  const startsWithYEquals = /^\s*y\s*=/.test(lower);

  if (startsWithYEquals) {
    const rightSide = cleanExpression.split('=').slice(1).join('=').trim();
    const rightHasX = hasVariable(rightSide.toLowerCase(), 'x');
    const rightHasY = hasVariable(rightSide.toLowerCase(), 'y');
    const rightNumeric = Number(rightSide.replaceAll(',', '.'));
    if (rightHasX && !rightHasY) return { kind: 'graphableExplicit', normalizedExpression: rightSide, constantValue: null };
    if (!rightHasX && !rightHasY && Number.isFinite(rightNumeric)) return { kind: 'graphableExplicit', normalizedExpression: formatConstant(rightNumeric), constantValue: rightNumeric };
  }
  if (hasX && hasY && hasEquality) return { kind: 'implicitPending', normalizedExpression: '', constantValue: null };
  if (hasX && !hasY) return { kind: 'graphableExplicit', normalizedExpression: cleanExpression, constantValue: null };
  const numeric = cleanResult === '' ? Number.NaN : Number(cleanResult);
  if (!hasX && !hasY && Number.isFinite(numeric)) return { kind: 'constantSuggestion', normalizedExpression: formatConstant(numeric), constantValue: numeric };
  return { kind: 'notGraphable', normalizedExpression: '', constantValue: null };
}

function q102GraphIntent(expression) {
  const hasX = hasVariable(expression, 'x');
  const hasY = hasVariable(expression, 'y');
  if (!expression) return 'empty';
  if (/^y=/.test(expression) && hasX) return 'graphableExplicit';
  if (hasX && hasY && expression.includes('=')) return 'implicitPending';
  if (hasX && !hasY) return 'graphableExplicit';
  if (!hasX && !hasY && /^[0-9+\-*/().,^_a-zA-Z]+$/.test(expression) && !expression.includes('=')) return 'constantSuggestion';
  return 'notGraphable';
}

function classifyLatex(latex) {
  const normalizedExpression = normalizeLatexToExpression(latex);
  const evaluation = tryEvaluateNumeric(normalizedExpression);
  const eligibility = classifyGraphEligibility(normalizedExpression, evaluation.displayValue);
  const intent = q102GraphIntent(normalizedExpression);
  return {
    latex,
    normalizedExpression,
    q102GraphIntent: intent,
    evaluatorDisplayValue: evaluation.displayValue,
    evaluatorUnsupportedReason: evaluation.unsupportedReason,
    eligibilityKind: eligibility.kind,
    graphNormalizedExpression: eligibility.normalizedExpression,
    constantValue: eligibility.constantValue,
    fakeConstantSuggestionBlocked: intent === 'constantSuggestion' && eligibility.kind !== 'constantSuggestion' && !evaluation.success,
  };
}

const samples = [
  { label: 'numeric-add', latex: '3+5', normalized: '3+5', kind: 'constantSuggestion', graphNormalized: '8', fakeConstantBlocked: false },
  { label: 'explicit-x-power', latex: 'x^{2}', normalized: 'x^2', kind: 'graphableExplicit', graphNormalized: 'x^2', fakeConstantBlocked: false },
  { label: 'sin-x', latex: '\\sin\\left(x\\right)', normalized: 'sin(x)', kind: 'graphableExplicit', graphNormalized: 'sin(x)', fakeConstantBlocked: false },
  { label: 'sqrt-x', latex: '\\sqrt{x}', normalized: 'sqrt(x)', kind: 'graphableExplicit', graphNormalized: 'sqrt(x)', fakeConstantBlocked: false },
  { label: 'explicit-y-equals', latex: 'y=x^{2}', normalized: 'y=x^2', kind: 'graphableExplicit', graphNormalized: 'x^2', fakeConstantBlocked: false },
  { label: 'implicit-circle', latex: 'x^{2}+y^{2}=1', normalized: 'x^2+y^2=1', kind: 'implicitPending', graphNormalized: '', fakeConstantBlocked: false },
  { label: 'fraction-sum', latex: '\\frac{1}{2}+\\frac{3}{4}', normalized: '(1)/(2)+(3)/(4)', kind: 'constantSuggestion', graphNormalized: '1.25', fakeConstantBlocked: false },
  { label: 'unsupported-log-base-two', latex: '\\log_{2}\\left(8\\right)', normalized: 'log_2(8)', kind: 'notGraphable', graphNormalized: '', fakeConstantBlocked: true },
];

mkdirSync(reportDir, { recursive: true });
const blockers = [];
const requiredFiles = [
  'lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart',
  'tool/verify_mathlive_graph_eligibility_adapter.mjs',
  'test/v172_q103_mathlive_graph_eligibility_adapter_test.dart',
  'docs/audit/V172_Q103_GRAPH_ELIGIBILITY_ADAPTER_AUDIT_REPORT.md',
  'docs/audit/V172_Q103_CHANGED_FILES_MANIFEST.md',
  'lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart',
  'lib/features/graph/graph_eligibility.dart',
  'lib/logic/mathpro_package_contract.dart',
  'assets/mathlive/manifest.json',
  'README.md',
];
for (const file of requiredFiles) {
  if (!existsSync(path.join(projectRoot, file))) blockers.push(`required Q103 file missing: ${file}`);
}

const policy = readText('lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart');
const q92 = readText('lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart');
const manifest = readText('assets/mathlive/manifest.json');
const contract = readText('lib/logic/mathpro_package_contract.dart');
const readme = readText('README.md');
const audit = readText('docs/audit/V172_Q103_GRAPH_ELIGIBILITY_ADAPTER_AUDIT_REPORT.md');
const changed = readText('docs/audit/V172_Q103_CHANGED_FILES_MANIFEST.md');

const requiredMarkers = [
  [policy, "phase = 'V172-Q103'"],
  [policy, 'packageSideGraphEligibilityAdapterImplemented = true'],
  [policy, 'q102StateNormalizationRequired = true'],
  [policy, 'q101LabSmokeEvidenceClosureRequiredForRuntimeActivation = true'],
  [policy, 'graphCardMutationAllowed = false'],
  [policy, 'fakeConstantGraphAllowed = false'],
  [q92, 'MathLiveGraphEligibilityAdapterPolicy.classifyNormalized'],
  [manifest, '"q103GraphEligibilityAdapterPhase": "V172-Q103"'],
  [manifest, '"q103MayMutateGraphCard": false'],
  [manifest, '"q103MaySwitchMainEditor": false'],
  [manifest, '"q103MayDeleteLegacyCursor": false'],
  [contract, 'q103GraphEligibilityAdapterRule'],
  [readme, 'V172-Q103 Graph Eligibility Adapter Real Binding'],
  [audit, 'Q103 adds MathLive normalized expression to GraphEligibility adapter binding'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) blockers.push(`missing marker: ${marker}`);
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'graphCardMutationAllowed = true',
  'graphUiMutationAllowed = true',
  'historyUiMutationAllowed = true',
  'solutionUiMutationAllowed = true',
  'keyboardMutationAllowed = true',
  'appShellMutationAllowed = true',
  'mainEditorSwitchAllowed = true',
  'mainEditorMountAllowed = true',
  'mathLiveEnabledByDefault = true',
  'legacyCursorDeletionAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'cursorPassClaimAllowed = true',
  'fakeConstantGraphAllowed = true',
  '"q103MayMutateGraphCard": true',
  '"q103MaySwitchMainEditor": true',
  '"q103MayMountMainEditor": true',
  '"q103MayEnableMathLiveByDefault": true',
  '"q103MayDeleteLegacyCursor": true',
  '"q103ProtectedUiSurfaceMutationAllowed": true',
  '"q103FakeConstantGraphAllowed": true',
];
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) blockers.push(`illegal Q103 enabling marker: ${marker}`);
}

const sampleResults = samples.map(sample => {
  const actual = classifyLatex(sample.latex);
  const pass = actual.normalizedExpression === sample.normalized &&
    actual.eligibilityKind === sample.kind &&
    actual.graphNormalizedExpression === sample.graphNormalized &&
    actual.fakeConstantSuggestionBlocked === sample.fakeConstantBlocked;
  if (!pass) {
    blockers.push(`sample ${sample.label} expected ${sample.normalized}/${sample.kind}/${sample.graphNormalized}/${sample.fakeConstantBlocked} but got ${actual.normalizedExpression}/${actual.eligibilityKind}/${actual.graphNormalizedExpression}/${actual.fakeConstantSuggestionBlocked}`);
  }
  return { ...sample, actual, pass };
});
const deterministicGraphEligibilitySamplesPass = sampleResults.every(s => s.pass);

const q102Report = (() => {
  const file = path.join(projectRoot, 'tool', 'reports', 'mathlive_state_normalization_report.json');
  if (!existsSync(file)) return null;
  try { return JSON.parse(readFileSync(file, 'utf8')); } catch { return null; }
})();
const q101Report = (() => {
  const file = path.join(projectRoot, 'tool', 'reports', 'mathlive_lab_smoke_evidence_closure_report.json');
  if (!existsSync(file)) return null;
  try { return JSON.parse(readFileSync(file, 'utf8')); } catch { return null; }
})();
const q102PackageReady = q102Report?.packageSideNormalizationReady === true || q102Report?.status === 'MATHLIVE_STATE_NORMALIZATION_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED' || q102Report?.status === 'MATHLIVE_STATE_NORMALIZATION_READY_FOR_Q103_BINDING';
const q101Closed = q101Report?.labSmokeEvidenceClosed === true;
if (!q102PackageReady) blockers.push('Q102 state normalization report is not package-ready; run node tool/verify_mathlive_state_normalization.mjs first');
if (!q101Closed) blockers.push('Q101 Lab smoke evidence closure has not passed; Q103 remains package-side only');

const hardBlocked = blockers.some(item => !item.includes('Q101 Lab smoke evidence closure has not passed'));
const packageReady = !hardBlocked && deterministicGraphEligibilitySamplesPass && q102PackageReady;
const status = packageReady
  ? (q101Closed ? 'MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_READY_FOR_RUNTIME_BINDING' : 'MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED')
  : 'BLOCKED_MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER';

const report = {
  phase: 'V172-Q103',
  status,
  generatedAt: new Date().toISOString(),
  packageSideGraphEligibilityReady: packageReady,
  q102StateNormalizationReady: q102PackageReady,
  q101LabSmokeEvidenceClosed: q101Closed,
  deterministicGraphEligibilitySamplesPass,
  mayProceedToRuntimeGraphBinding: status === 'MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_READY_FOR_RUNTIME_BINDING',
  maySwitchMainEditor: false,
  mayMountMainEditor: false,
  mayEnableMathLiveByDefault: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  mayMutateGraphCard: false,
  graphHistorySolutionUiMutationAllowed: false,
  fakeConstantGraphAllowed: false,
  samples: sampleResults,
  blockers,
};
writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q103 MathLive Graph Eligibility Adapter Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- packageSideGraphEligibilityReady: ${String(packageReady)}`,
  `- q102StateNormalizationReady: ${String(q102PackageReady)}`,
  `- q101LabSmokeEvidenceClosed: ${String(q101Closed)}`,
  '- mayMutateGraphCard: false',
  '- maySwitchMainEditor: false',
  '- mayDeleteLegacyCursor: false',
  '',
  '## Samples',
  ...sampleResults.map(s => `- ${s.label}: ${s.pass ? 'PASS' : 'FAIL'} → ${s.actual.normalizedExpression} / ${s.actual.eligibilityKind} / ${s.actual.graphNormalizedExpression || '∅'} / fakeConstantBlocked=${String(s.actual.fakeConstantSuggestionBlocked)}`),
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
  deterministicGraphEligibilitySamplesPass,
  mayProceedToRuntimeGraphBinding: report.mayProceedToRuntimeGraphBinding,
  mayMutateGraphCard: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
}, null, 2));
process.exit(status === 'BLOCKED_MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER' ? 2 : 0);
