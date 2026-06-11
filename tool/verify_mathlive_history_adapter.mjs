#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_history_adapter.mjs', retiredPhase: 'verify_mathlive_history_adapter', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

/*
 * V172-Q104 History Adapter Real Binding verifier.
 *
 * Offline/package-side only. It verifies that MathLive normalized samples can
 * produce deterministic History entry envelopes without mutating
 * history_controller.dart, history_panel.dart, protected UI surfaces, switching
 * the main editor, writing fake runtime History records, or deleting legacy
 * cursor files.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_history_adapter_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_history_adapter_report.md');

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

function stableSeed(value) {
  let hash = 0x811c9dc5;
  for (const char of value) {
    hash ^= char.charCodeAt(0);
    hash = Math.imul(hash, 0x01000193) >>> 0;
  }
  return hash.toString(16).padStart(8, '0');
}

function buildHistoryEnvelope(sample) {
  const normalizedExpression = normalizeLatexToExpression(sample.latex);
  const evaluation = tryEvaluateNumeric(normalizedExpression);
  const graph = classifyGraphEligibility(normalizedExpression, evaluation.displayValue);
  const createdAtIso8601 = '1970-01-01T00:00:00.000Z';
  return {
    label: sample.label,
    phase: 'V172-Q104',
    id: `mathlive-history-${stableSeed(`${sample.latex}|${normalizedExpression}|${createdAtIso8601}`)}`,
    inputEngine: 'mathlive',
    sourceLatex: sample.latex,
    normalizedExpression,
    inputExpression: normalizedExpression,
    displayExpression: normalizedExpression,
    plainText: sample.plainText || normalizedExpression,
    mathJson: sample.mathJson || null,
    evaluateRequested: Boolean(sample.evaluateRequested),
    graphEligibilityKind: graph.kind,
    graphNormalizedExpression: graph.normalizedExpression,
    graphCandidateAvailable: ['graphableExplicit', 'constantSuggestion', 'implicitPending'].includes(graph.kind),
    solutionCandidateExpression: normalizedExpression,
    evaluatorDisplayValue: evaluation.displayValue,
    evaluatorUnsupportedReason: evaluation.unsupportedReason,
    createdAtIso8601,
    pinned: false,
    runtimeWriteAllowed: false,
    historyControllerMutationAllowed: false,
    historyPanelMutationAllowed: false,
    mainEditorSwitchAllowed: false,
    legacyCursorDeletionAllowed: false,
  };
}

const samples = [
  { label: 'numeric-add', latex: '3+5', kind: 'constantSuggestion', input: '3+5', graph: '8', evaluator: '8' },
  { label: 'explicit-x-power', latex: 'x^{2}', kind: 'graphableExplicit', input: 'x^2', graph: 'x^2', evaluator: '' },
  { label: 'sin-x', latex: '\\sin\\left(x\\right)', kind: 'graphableExplicit', input: 'sin(x)', graph: 'sin(x)', evaluator: '' },
  { label: 'sqrt-x', latex: '\\sqrt{x}', kind: 'graphableExplicit', input: 'sqrt(x)', graph: 'sqrt(x)', evaluator: '' },
  { label: 'explicit-y-equals', latex: 'y=x^{2}', kind: 'graphableExplicit', input: 'y=x^2', graph: 'x^2', evaluator: '' },
  { label: 'implicit-circle', latex: 'x^{2}+y^{2}=1', kind: 'implicitPending', input: 'x^2+y^2=1', graph: '', evaluator: '' },
  { label: 'fraction-sum', latex: '\\frac{1}{2}+\\frac{3}{4}', kind: 'constantSuggestion', input: '(1)/(2)+(3)/(4)', graph: '1.25', evaluator: '1.25' },
  { label: 'unsupported-log-base-two', latex: '\\log_{2}\\left(8\\right)', kind: 'notGraphable', input: 'log_2(8)', graph: '', evaluator: '' },
];

mkdirSync(reportDir, { recursive: true });
const blockers = [];
const requiredFiles = [
  'lib/features/mathlive/mathlive_history_adapter_policy.dart',
  'tool/verify_mathlive_history_adapter.mjs',
  'test/v172_q104_mathlive_history_adapter_test.dart',
  'docs/audit/V172_Q104_HISTORY_ADAPTER_AUDIT_REPORT.md',
  'docs/audit/V172_Q104_CHANGED_FILES_MANIFEST.md',
  'lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart',
  'lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart',
  'lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart',
  'lib/logic/mathpro_package_contract.dart',
  'assets/mathlive/manifest.json',
  'README.md',
];
for (const file of requiredFiles) {
  if (!existsSync(path.join(projectRoot, file))) blockers.push(`missing required file: ${file}`);
}

const policy = readText('lib/features/mathlive/mathlive_history_adapter_policy.dart');
const q92 = readText('lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart');
const manifest = readText('assets/mathlive/manifest.json');
const contract = readText('lib/logic/mathpro_package_contract.dart');
const readme = readText('README.md');
const audit = readText('docs/audit/V172_Q104_HISTORY_ADAPTER_AUDIT_REPORT.md');
const changed = readText('docs/audit/V172_Q104_CHANGED_FILES_MANIFEST.md');
const historyController = readText('lib/features/history/history_controller.dart');
const historyPanel = readText('lib/features/history/history_panel.dart');

const requiredMarkers = [
  [policy, "phase = 'V172-Q104'"],
  [policy, 'packageSideHistoryAdapterImplemented = true'],
  [policy, 'q102StateNormalizationRequired = true'],
  [policy, 'q103GraphEligibilityAdapterRequired = true'],
  [policy, 'historyControllerMutationAllowed = false'],
  [policy, 'historyPanelMutationAllowed = false'],
  [policy, "inputEngine = 'mathlive'"],
  [q92, 'MathLiveHistoryAdapterPolicy.buildEntryEnvelope'],
  [manifest, '"q104HistoryAdapterPhase": "V172-Q104"'],
  [manifest, '"q104MayMutateHistoryController": false'],
  [manifest, '"q104MayMutateHistoryPanel": false'],
  [manifest, '"q104MayWriteHistoryAtRuntime": false'],
  [manifest, '"q104MaySwitchMainEditor": false'],
  [manifest, '"q104MayDeleteLegacyCursor": false'],
  [contract, 'q104HistoryAdapterRule'],
  [readme, 'V172-Q104 History Adapter Real Binding'],
  [audit, 'Q104 adds MathLive normalized expression to History entry envelope binding'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) blockers.push(`missing marker: ${marker}`);
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'historyControllerMutationAllowed = true',
  'historyPanelMutationAllowed = true',
  'historyUiMutationAllowed = true',
  'graphUiMutationAllowed = true',
  'solutionUiMutationAllowed = true',
  'keyboardMutationAllowed = true',
  'appShellMutationAllowed = true',
  'mainEditorSwitchAllowed = true',
  'mainEditorMountAllowed = true',
  'mathLiveEnabledByDefault = true',
  'legacyCursorDeletionAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'cursorPassClaimAllowed = true',
  'fakeHistoryWriteAllowed = true',
  'runtimeWriteAllowed: true',
  'mayWriteHistoryAtRuntime: true',
  '"q104MayMutateHistoryController": true',
  '"q104MayMutateHistoryPanel": true',
  '"q104MayWriteHistoryAtRuntime": true',
  '"q104MaySwitchMainEditor": true',
  '"q104MayMountMainEditor": true',
  '"q104MayDeleteLegacyCursor": true',
  '"q104ProtectedUiSurfaceMutationAllowed": true',
];
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) blockers.push(`forbidden enabled marker present: ${marker}`);
}
if (historyController.includes('V172-Q104')) blockers.push('Q104 marker found in protected history_controller.dart');
if (historyPanel.includes('V172-Q104')) blockers.push('Q104 marker found in protected history_panel.dart');

const envelopes = samples.map(buildHistoryEnvelope);
for (const sample of samples) {
  const env = envelopes.find((item) => item.label === sample.label);
  if (!env) {
    blockers.push(`missing sample envelope: ${sample.label}`);
    continue;
  }
  if (env.phase !== 'V172-Q104') blockers.push(`${sample.label}: phase mismatch`);
  if (env.inputEngine !== 'mathlive') blockers.push(`${sample.label}: inputEngine must be mathlive`);
  if (env.inputExpression !== sample.input) blockers.push(`${sample.label}: inputExpression expected ${sample.input} but got ${env.inputExpression}`);
  if (env.graphEligibilityKind !== sample.kind) blockers.push(`${sample.label}: graph kind expected ${sample.kind} but got ${env.graphEligibilityKind}`);
  if (env.graphNormalizedExpression !== sample.graph) blockers.push(`${sample.label}: graph expression expected ${sample.graph} but got ${env.graphNormalizedExpression}`);
  if (env.evaluatorDisplayValue !== sample.evaluator) blockers.push(`${sample.label}: evaluator expected ${sample.evaluator} but got ${env.evaluatorDisplayValue}`);
  if (env.runtimeWriteAllowed !== false) blockers.push(`${sample.label}: runtime write must remain false`);
  if (env.historyControllerMutationAllowed !== false) blockers.push(`${sample.label}: history controller mutation must remain false`);
  if (env.historyPanelMutationAllowed !== false) blockers.push(`${sample.label}: history panel mutation must remain false`);
  if (env.mainEditorSwitchAllowed !== false) blockers.push(`${sample.label}: main editor switch must remain false`);
  if (env.legacyCursorDeletionAllowed !== false) blockers.push(`${sample.label}: legacy deletion must remain false`);
}

const q101EvidenceClosed = false;
const deterministicHistorySamplesPass = blockers.length === 0;
if (!q101EvidenceClosed) blockers.push('Q101 Lab smoke evidence closure has not passed; Q104 remains package-side only');

const packageReady = deterministicHistorySamplesPass;
const runtimeReady = packageReady && q101EvidenceClosed;
const status = runtimeReady
  ? 'MATHLIVE_HISTORY_ADAPTER_READY_FOR_RUNTIME_BINDING'
  : packageReady
    ? 'MATHLIVE_HISTORY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
    : 'BLOCKED_MATHLIVE_HISTORY_ADAPTER';

const report = {
  phase: 'V172-Q104',
  status,
  generatedAt: new Date().toISOString(),
  packageSideHistorySamplesPass: deterministicHistorySamplesPass,
  q101LabSmokeEvidenceClosed: q101EvidenceClosed,
  mayProceedToRuntimeHistoryBinding: runtimeReady,
  mayWriteHistoryAtRuntime: runtimeReady,
  maySwitchMainEditor: false,
  mayMountMainEditor: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  mayMutateHistoryController: false,
  mayMutateHistoryPanel: false,
  samples: envelopes,
  blockers,
};
writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(mdReportPath, `# V172-Q104 History Adapter Real Binding Report\n\n- Status: ${status}\n- Package-side history samples pass: ${deterministicHistorySamplesPass}\n- Q101 Lab smoke evidence closed: ${q101EvidenceClosed}\n- Runtime History write allowed: ${runtimeReady}\n- Main editor switch allowed: false\n- Legacy cursor deletion allowed: false\n- History controller mutation allowed: false\n- History panel mutation allowed: false\n\n## Blockers\n${blockers.map((item) => `- ${item}`).join('\n')}\n\n## Samples\n${envelopes.map((item) => `- ${item.label}: ${item.inputExpression} → ${item.graphEligibilityKind}`).join('\n')}\n`);
console.log(JSON.stringify(report, null, 2));
process.exit(runtimeReady ? 0 : 2);
