#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs', retiredPhase: 'verify_mathlive_solution_evaluator_candidate_adapter', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

/*
 * V172-Q105 Solution/Evaluator Candidate Adapter verifier.
 *
 * Offline/package-side only. It verifies that MathLive normalized samples can
 * produce deterministic Solution/Evaluator candidate envelopes without mutating
 * solution_steps_panel.dart, protected UI surfaces, switching the main editor,
 * writing fake Solution state, or deleting legacy cursor files.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_solution_evaluator_candidate_adapter_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_solution_evaluator_candidate_adapter_report.md');

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
  if (!/^[0-9+\-*/().\s*]+$/.test(normalized)) {
    return { success: false, displayValue: '', semanticType: semanticKind(expression), unsupportedReason: semanticDescription(expression) };
  }
  try {
    const value = Function(`"use strict"; return (${normalized});`)();
    if (typeof value !== 'number' || !Number.isFinite(value)) {
      return { success: false, displayValue: '', semanticType: 'numeric', unsupportedReason: 'Sayısal sonuç sonlu değil.' };
    }
    return { success: true, value, displayValue: formatConstant(value), semanticType: 'numeric', unsupportedReason: '' };
  } catch {
    return { success: false, displayValue: '', semanticType: 'numeric', unsupportedReason: 'Bu ifade henüz temel değerlendirici kapsamının dışında.' };
  }
}

function semanticKind(expression) {
  const lower = expression.toLowerCase();
  if (!expression.trim()) return 'empty';
  if (lower.includes('=') && lower.includes('x') && lower.includes('y')) return 'implicitEquation';
  if (lower.includes('=')) return 'equation';
  if (/[xyz]/.test(lower)) return 'algebraicExpression';
  if (lower.includes('log_')) return 'unsupported';
  return 'unsupported';
}

function semanticTitle(kind) {
  const map = {
    empty: 'İfade bekleniyor',
    implicitEquation: 'İmplicit denklem algılandı',
    equation: 'Denklem algılandı',
    algebraicExpression: 'Cebirsel ifade algılandı',
    numeric: 'Sayısal aritmetik',
    unsupported: 'İleri ifade algılandı',
  };
  return map[kind] || 'İleri ifade algılandı';
}

function semanticDescription(expression) {
  const kind = semanticKind(expression);
  if (kind === 'implicitEquation') return 'x ve y içeren denklemler graph/implicit curve bridge için işaretlenir; kapalı form çözüm ileri solver gerektirir.';
  if (kind === 'equation') return 'Denklem yapısı korunur; cebirsel çözüm adımları ileri solver bridge ile üretilecek.';
  if (kind === 'algebraicExpression') return 'Değişken içeren ifade parser hattında korunur; grafik uygunluğu ve ileri cebir işlemleri için hazır hale getirilir.';
  if (kind === 'empty') return 'Klavye ile ifade yazıldığında MathPro parser hattı devreye girer.';
  return 'Bu ifade MathPro editöründe korunur; gerçek çözüm için ilgili sembolik/nümerik solver bridge gerekir. Sahte çözüm üretilmiyor.';
}

function classifyGraphEligibility(expression, result) {
  const cleanExpression = expression.trim().replaceAll('−', '-').replaceAll('×', '*').replaceAll('÷', '/');
  const cleanResult = String(result || '').trim().replace(/^=\s*/, '').replaceAll(',', '.');
  if (!cleanExpression) return { kind: 'notGraphable', normalizedExpression: '' };
  const lower = cleanExpression.toLowerCase();
  const hasX = hasVariable(lower, 'x');
  const hasY = hasVariable(lower, 'y');
  const hasEquality = cleanExpression.includes('=');
  if (/^\s*y\s*=/.test(lower)) {
    const rightSide = cleanExpression.split('=').slice(1).join('=').trim();
    const rightHasX = hasVariable(rightSide.toLowerCase(), 'x');
    const rightHasY = hasVariable(rightSide.toLowerCase(), 'y');
    const rightNumeric = Number(rightSide.replaceAll(',', '.'));
    if (rightHasX && !rightHasY) return { kind: 'graphableExplicit', normalizedExpression: rightSide };
    if (!rightHasX && !rightHasY && Number.isFinite(rightNumeric)) return { kind: 'graphableExplicit', normalizedExpression: formatConstant(rightNumeric) };
  }
  if (hasX && hasY && hasEquality) return { kind: 'implicitPending', normalizedExpression: '' };
  if (hasX && !hasY) return { kind: 'graphableExplicit', normalizedExpression: cleanExpression };
  const numeric = cleanResult === '' ? Number.NaN : Number(cleanResult);
  if (!hasX && !hasY && Number.isFinite(numeric)) return { kind: 'constantSuggestion', normalizedExpression: formatConstant(numeric) };
  return { kind: 'notGraphable', normalizedExpression: '' };
}

function stableSeed(value) {
  let hash = 0x811c9dc5;
  for (const char of value) {
    hash ^= char.charCodeAt(0);
    hash = Math.imul(hash, 0x01000193) >>> 0;
  }
  return hash.toString(16).padStart(8, '0');
}

function buildCandidateEnvelope(sample) {
  const normalizedExpression = normalizeLatexToExpression(sample.latex);
  const evaluation = tryEvaluateNumeric(normalizedExpression);
  const kind = evaluation.success ? 'numeric' : semanticKind(normalizedExpression);
  const graph = classifyGraphEligibility(normalizedExpression, evaluation.displayValue);
  const createdAtIso8601 = '1970-01-01T00:00:00.000Z';
  const unsupportedReason = evaluation.unsupportedReason || '';
  const hasEvaluatorResult = evaluation.success && !unsupportedReason;
  return {
    label: sample.label,
    phase: 'V172-Q105',
    id: `mathlive-solution-${stableSeed(`${sample.latex}|${normalizedExpression}|${createdAtIso8601}`)}`,
    inputEngine: 'mathlive',
    sourceLatex: sample.latex,
    normalizedExpression,
    evaluatorCandidateExpression: normalizedExpression,
    solutionCandidateExpression: normalizedExpression,
    evaluateRequested: Boolean(sample.evaluateRequested),
    semanticKind: kind,
    semanticTitle: semanticTitle(kind),
    semanticDescription: evaluation.success ? 'Temel sayısal ifade güvenli değerlendirici tarafından hesaplanabilir.' : semanticDescription(normalizedExpression),
    evaluatorDisplayValue: evaluation.displayValue,
    evaluatorSemanticType: evaluation.semanticType || kind,
    evaluatorUnsupportedReason: unsupportedReason,
    hasEvaluatorResult,
    hasNumericResult: hasEvaluatorResult && typeof evaluation.value === 'number',
    hasSymbolicResult: false,
    requiresAdvancedSolver: !hasEvaluatorResult || ['implicitEquation', 'equation', 'algebraicExpression', 'unsupported'].includes(kind),
    graphEligibilityKind: graph.kind,
    graphNormalizedExpression: graph.normalizedExpression,
    historyEntryId: `mathlive-history-${stableSeed(`${sample.latex}|${normalizedExpression}|${createdAtIso8601}`)}`,
    createdAtIso8601,
    fakeSolutionGenerated: false,
    runtimeSolutionWriteAllowed: false,
    solutionStepsPanelMutationAllowed: false,
    mainEditorSwitchAllowed: false,
    legacyCursorDeletionAllowed: false,
  };
}

const samples = [
  { label: 'numeric-add', latex: '3+5', expression: '3+5', semanticKind: 'numeric', evaluator: '8', graph: 'constantSuggestion', advanced: false },
  { label: 'fraction-sum', latex: '\\frac{1}{2}+\\frac{3}{4}', expression: '(1)/(2)+(3)/(4)', semanticKind: 'numeric', evaluator: '1.25', graph: 'constantSuggestion', advanced: false },
  { label: 'explicit-x-power', latex: 'x^{2}', expression: 'x^2', semanticKind: 'algebraicExpression', evaluator: '', graph: 'graphableExplicit', advanced: true },
  { label: 'implicit-circle', latex: 'x^{2}+y^{2}=1', expression: 'x^2+y^2=1', semanticKind: 'implicitEquation', evaluator: '', graph: 'implicitPending', advanced: true },
  { label: 'unsupported-log-base-two', latex: '\\log_{2}\\left(8\\right)', expression: 'log_2(8)', semanticKind: 'unsupported', evaluator: '', graph: 'notGraphable', advanced: true },
];

mkdirSync(reportDir, { recursive: true });
const blockers = [];
const requiredFiles = [
  'lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart',
  'tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs',
  'test/v172_q105_solution_evaluator_candidate_adapter_test.dart',
  'docs/audit/V172_Q105_SOLUTION_EVALUATOR_CANDIDATE_ADAPTER_AUDIT_REPORT.md',
  'docs/audit/V172_Q105_CHANGED_FILES_MANIFEST.md',
  'lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart',
  'lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart',
  'lib/features/mathlive/mathlive_history_adapter_policy.dart',
  'lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart',
  'lib/logic/evaluator_bridge.dart',
  'lib/logic/mathpro_package_contract.dart',
  'assets/mathlive/manifest.json',
  'README.md',
];
for (const file of requiredFiles) {
  if (!existsSync(path.join(projectRoot, file))) blockers.push(`missing required file: ${file}`);
}

const policy = readText('lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart');
const q92 = readText('lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart');
const manifest = readText('assets/mathlive/manifest.json');
const contract = readText('lib/logic/mathpro_package_contract.dart');
const readme = readText('README.md');
const audit = readText('docs/audit/V172_Q105_SOLUTION_EVALUATOR_CANDIDATE_ADAPTER_AUDIT_REPORT.md');
const changed = readText('docs/audit/V172_Q105_CHANGED_FILES_MANIFEST.md');
const solutionPanel = readText('lib/features/solution/solution_steps_panel.dart');

const requiredMarkers = [
  [policy, "phase = 'V172-Q105'"],
  [policy, 'packageSideSolutionEvaluatorAdapterImplemented = true'],
  [policy, 'q102StateNormalizationRequired = true'],
  [policy, 'q103GraphEligibilityAdapterRequired = true'],
  [policy, 'q104HistoryAdapterRequired = true'],
  [policy, 'solutionStepsPanelMutationAllowed = false'],
  [policy, 'fakeSolutionAllowed = false'],
  [policy, 'runtimeSolutionWriteAllowed = false'],
  [q92, 'MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope'],
  [manifest, '"q105SolutionEvaluatorCandidateAdapterPhase": "V172-Q105"'],
  [manifest, '"q105MayMutateSolutionStepsPanel": false'],
  [manifest, '"q105MayWriteSolutionAtRuntime": false'],
  [manifest, '"q105MayGenerateFakeSolution": false'],
  [manifest, '"q105MaySwitchMainEditor": false'],
  [manifest, '"q105MayDeleteLegacyCursor": false'],
  [contract, 'q105SolutionEvaluatorCandidateAdapterRule'],
  [readme, 'V172-Q105 Solution/Evaluator Candidate Adapter'],
  [audit, 'Q105 adds MathLive normalized expression to Solution/Evaluator candidate envelope binding'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) blockers.push(`missing marker: ${marker}`);
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'solutionStepsPanelMutationAllowed = true',
  'solutionUiMutationAllowed = true',
  'graphUiMutationAllowed = true',
  'historyUiMutationAllowed = true',
  'keyboardMutationAllowed = true',
  'appShellMutationAllowed = true',
  'mainEditorSwitchAllowed = true',
  'mainEditorMountAllowed = true',
  'mathLiveEnabledByDefault = true',
  'legacyCursorDeletionAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'cursorPassClaimAllowed = true',
  'fakeSolutionAllowed = true',
  'runtimeSolutionWriteAllowed = true',
  'fakeSolutionGenerated: true',
  ['mayWriteSolutionAtRuntime', 'true'].join(': '),
  ['mayMutateSolutionStepsPanel', 'true'].join(': '),
  ['maySwitchMainEditor', 'true'].join(': '),
  ['mayDeleteLegacyCursor', 'true'].join(': '),
  '"q105MayMutateSolutionStepsPanel"' + ': true',
  '"q105MayWriteSolutionAtRuntime"' + ': true',
  '"q105MayGenerateFakeSolution"' + ': true',
  '"q105MaySwitchMainEditor"' + ': true',
  '"q105MayMountMainEditor"' + ': true',
  '"q105MayDeleteLegacyCursor"' + ': true',
];
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) blockers.push(`forbidden enabled marker present: ${marker}`);
}
if (solutionPanel.includes('V172-Q105')) blockers.push('Q105 marker found in protected solution_steps_panel.dart');

const envelopes = samples.map(buildCandidateEnvelope);
for (const sample of samples) {
  const env = envelopes.find((item) => item.label === sample.label);
  if (!env) {
    blockers.push(`missing sample envelope: ${sample.label}`);
    continue;
  }
  if (env.phase !== 'V172-Q105') blockers.push(`${sample.label}: phase mismatch`);
  if (env.inputEngine !== 'mathlive') blockers.push(`${sample.label}: inputEngine must be mathlive`);
  if (env.solutionCandidateExpression !== sample.expression) blockers.push(`${sample.label}: solution candidate expected ${sample.expression} but got ${env.solutionCandidateExpression}`);
  if (env.evaluatorCandidateExpression !== sample.expression) blockers.push(`${sample.label}: evaluator candidate expected ${sample.expression} but got ${env.evaluatorCandidateExpression}`);
  if (env.semanticKind !== sample.semanticKind) blockers.push(`${sample.label}: semantic kind expected ${sample.semanticKind} but got ${env.semanticKind}`);
  if (env.evaluatorDisplayValue !== sample.evaluator) blockers.push(`${sample.label}: evaluator expected ${sample.evaluator} but got ${env.evaluatorDisplayValue}`);
  if (env.graphEligibilityKind !== sample.graph) blockers.push(`${sample.label}: graph kind expected ${sample.graph} but got ${env.graphEligibilityKind}`);
  if (env.requiresAdvancedSolver !== sample.advanced) blockers.push(`${sample.label}: advanced solver flag expected ${sample.advanced} but got ${env.requiresAdvancedSolver}`);
  if (env.fakeSolutionGenerated !== false) blockers.push(`${sample.label}: fake solution must remain false`);
  if (env.runtimeSolutionWriteAllowed !== false) blockers.push(`${sample.label}: runtime solution write must remain false`);
  if (env.solutionStepsPanelMutationAllowed !== false) blockers.push(`${sample.label}: solution panel mutation must remain false`);
  if (env.mainEditorSwitchAllowed !== false) blockers.push(`${sample.label}: main editor switch must remain false`);
  if (env.legacyCursorDeletionAllowed !== false) blockers.push(`${sample.label}: legacy deletion must remain false`);
}

const q101EvidenceClosed = false;
const deterministicSolutionSamplesPass = blockers.length === 0;
if (!q101EvidenceClosed) blockers.push('Q101 Lab smoke evidence closure has not passed; Q105 remains package-side only');

const packageReady = deterministicSolutionSamplesPass;
const runtimeReady = packageReady && q101EvidenceClosed;
const status = runtimeReady
  ? 'MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_READY_FOR_RUNTIME_BINDING'
  : packageReady
    ? 'MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
    : 'BLOCKED_MATHLIVE_SOLUTION_EVALUATOR_ADAPTER';

const report = {
  phase: 'V172-Q105',
  status,
  generatedAt: new Date().toISOString(),
  packageSideSolutionEvaluatorSamplesPass: deterministicSolutionSamplesPass,
  q101LabSmokeEvidenceClosed: q101EvidenceClosed,
  mayProceedToRuntimeSolutionBinding: runtimeReady,
  mayWriteSolutionAtRuntime: runtimeReady,
  maySwitchMainEditor: false,
  mayMountMainEditor: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  mayMutateSolutionStepsPanel: false,
  fakeSolutionGenerated: false,
  samples: envelopes,
  blockers,
};
writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q105 Solution/Evaluator Candidate Adapter Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- packageSideSolutionEvaluatorSamplesPass: ${String(deterministicSolutionSamplesPass)}`,
  `- q101LabSmokeEvidenceClosed: ${String(q101EvidenceClosed)}`,
  '- mayWriteSolutionAtRuntime: false',
  '- mayMutateSolutionStepsPanel: false',
  '- maySwitchMainEditor: false',
  '- mayDeleteLegacyCursor: false',
  '- fakeSolutionGenerated: false',
  '',
  '## Samples',
  ...envelopes.map(item => `- ${item.label}: ${item.solutionCandidateExpression} → evaluator=${item.evaluatorDisplayValue || '∅'} / semantic=${item.semanticKind} / advancedSolver=${String(item.requiresAdvancedSolver)}`),
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
  deterministicSolutionSamplesPass,
  mayProceedToRuntimeSolutionBinding: report.mayProceedToRuntimeSolutionBinding,
  mayWriteSolutionAtRuntime: false,
  mayMutateSolutionStepsPanel: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
}, null, 2));
process.exit(status === 'BLOCKED_MATHLIVE_SOLUTION_EVALUATOR_ADAPTER' ? 2 : 0);
