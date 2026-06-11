#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_runtime_evidence_intake.mjs', retiredPhase: 'verify_mathlive_runtime_evidence_intake', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

/*
 * V172-Q99 MathLive runtime/evidence intake closure.
 *
 * This script aggregates the official runtime verifier, the smoke evidence
 * writer/verifier, and the Q98 transition-court ledger into one package-side
 * intake report. It never downloads MathLive, never fabricates evidence, never
 * switches the main editor, and never permits legacy cursor deletion.
 */
import { spawnSync } from 'node:child_process';
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_runtime_evidence_intake_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_runtime_evidence_intake_report.md');

const args = new Set(process.argv.slice(2));
const refreshReports = !args.has('--no-refresh');

function rel(absolutePath) {
  return path.relative(projectRoot, absolutePath).replaceAll(path.sep, '/');
}

function runStep(name, command, commandArgs, options = {}) {
  const executable = options.windowsCommand && process.platform === 'win32' ? options.windowsCommand : command;
  const result = spawnSync(executable, commandArgs, {
    cwd: projectRoot,
    encoding: 'utf8',
    shell: false,
    timeout: options.timeoutMs ?? 120000,
  });
  const exitCode = typeof result.status === 'number' ? result.status : null;
  const blocked = Boolean(result.error) || exitCode !== 0;
  return {
    name,
    command: [executable, ...commandArgs].join(' '),
    status: blocked ? 'BLOCKED' : 'PASS',
    exitCode,
    error: result.error ? String(result.error.message || result.error) : '',
    stdout: (result.stdout ?? '').slice(-5000),
    stderr: (result.stderr ?? '').slice(-5000),
  };
}

function skippedStep(name, reason) {
  return { name, command: '', status: 'SKIPPED', exitCode: null, error: '', stdout: '', stderr: reason };
}

function readJson(relativePath) {
  const absolutePath = path.join(projectRoot, relativePath);
  if (!existsSync(absolutePath)) return null;
  try {
    return JSON.parse(readFileSync(absolutePath, 'utf8'));
  } catch (error) {
    return { parseError: String(error.message || error) };
  }
}

function fileStatus(relativePath) {
  const absolutePath = path.join(projectRoot, relativePath);
  return { path: relativePath, exists: existsSync(absolutePath) };
}

mkdirSync(reportDir, { recursive: true });

const steps = [];
if (refreshReports) {
  steps.push(runStep('q90r4_runtime_verifier', 'node', ['tool/verify_mathlive_runtime.mjs'], { windowsCommand: 'node' }));
  steps.push(runStep('q90r6_smoke_evidence_writer', 'node', ['tool/write_mathlive_lab_smoke_evidence.mjs'], { windowsCommand: 'node' }));
  steps.push(runStep('q90r5_smoke_evidence_verifier', 'node', ['tool/verify_mathlive_lab_smoke_evidence.mjs'], { windowsCommand: 'node' }));
} else {
  steps.push(skippedStep('q90r4_runtime_verifier', 'skipped by --no-refresh'));
  steps.push(skippedStep('q90r6_smoke_evidence_writer', 'skipped by --no-refresh'));
  steps.push(skippedStep('q90r5_smoke_evidence_verifier', 'skipped by --no-refresh'));
}

const requiredRuntimeFiles = [
  'assets/mathlive/vendor/mathlive/mathlive.min.js',
  'assets/mathlive/vendor/mathlive/mathlive-fonts.css',
  'assets/mathlive/vendor/mathlive/mathlive-static.css',
  'assets/mathlive/vendor/mathlive/LICENSE.txt',
  'assets/mathlive/vendor/mathlive/package.json',
  'assets/mathlive/vendor/mathlive/runtime_manifest.json',
];
const runtimeFileStatuses = requiredRuntimeFiles.map(fileStatus);
const canonicalSmokeEvidence = fileStatus('docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json');
const q98CourtJson = fileStatus('tool/reports/mathlive_transition_court_report.json');
const runtimeReport = readJson('tool/verify_mathlive_runtime_report.json');
const smokeReport = readJson('tool/verify_mathlive_lab_smoke_evidence_report.json');
const writerReport = readJson('tool/write_mathlive_lab_smoke_evidence_report.json');
const q98CourtReport = readJson('tool/reports/mathlive_transition_court_report.json');

const blockers = [];
for (const step of steps) {
  if (step.status === 'BLOCKED') blockers.push(`${step.name}: ${step.stderr || step.error || 'blocked'}`.slice(0, 900));
}
for (const file of runtimeFileStatuses) {
  if (!file.exists) blockers.push(`official runtime file missing: ${file.path}`);
}
if (!canonicalSmokeEvidence.exists) blockers.push(`canonical smoke evidence missing: ${canonicalSmokeEvidence.path}`);
if (!q98CourtJson.exists) blockers.push(`Q98 transition court report missing: ${q98CourtJson.path}`);
if (!runtimeReport || runtimeReport.installVerified !== true) blockers.push('Q90R4 runtime report is not verified');
if (!smokeReport || smokeReport.evidenceVerified !== true) blockers.push('Q90R5 smoke evidence report is not verified');
if (runtimeReport?.mainEditorSwitchAllowed === true) blockers.push('runtime report illegally allows main editor switch');
if (smokeReport?.mainEditorSwitchAllowed === true) blockers.push('smoke evidence report illegally allows main editor switch');
if (smokeReport?.physicalLegacyDeletionAllowed === true) blockers.push('smoke evidence report illegally allows legacy deletion');
if (q98CourtReport?.maySwitchMainEditor === true) blockers.push('Q98 court illegally allows main editor switch');
if (q98CourtReport?.mayDeleteLegacyCursor === true) blockers.push('Q98 court illegally allows legacy cursor deletion');

const ready = blockers.length === 0;
const report = {
  phase: 'V172-Q99',
  status: ready
    ? 'MATHLIVE_RUNTIME_EVIDENCE_INTAKE_READY_FOR_Q92_REVIEW'
    : 'BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_INTAKE',
  generatedAt: new Date().toISOString(),
  refreshReports,
  runtimeEvidenceIntakeReady: ready,
  mayStartQ92AdapterReview: ready,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayEnableMathLiveByDefault: false,
  mayDeleteLegacyCursor: false,
  protectedUiSurfaceMutationAllowed: false,
  graphHistorySolutionUiMutationAllowed: false,
  realDeviceCourtStillRequired: true,
  blockers,
  steps,
  files: {
    runtime: runtimeFileStatuses,
    canonicalSmokeEvidence,
    q98CourtJson,
  },
  reports: {
    runtime: runtimeReport,
    smokeEvidence: smokeReport,
    smokeWriter: writerReport,
    q98Court: q98CourtReport,
  },
};

writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q99 MathLive Runtime Evidence Intake Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- runtimeEvidenceIntakeReady: ${ready}`,
  '- mayClaimCursorPass: false',
  '- maySwitchMainEditor: false',
  '- mayEnableMathLiveByDefault: false',
  '- mayDeleteLegacyCursor: false',
  '- realDeviceCourtStillRequired: true',
  '',
  '## Blockers',
  ...(blockers.length ? blockers.map(item => `- ${item}`) : ['- none']),
  '',
  '## Runtime files',
  ...runtimeFileStatuses.map(file => `- ${file.path}: ${file.exists ? 'PRESENT' : 'MISSING'}`),
  '',
  `- ${canonicalSmokeEvidence.path}: ${canonicalSmokeEvidence.exists ? 'PRESENT' : 'MISSING'}`,
  `- ${q98CourtJson.path}: ${q98CourtJson.exists ? 'PRESENT' : 'MISSING'}`,
  '',
].join('\n');
writeFileSync(mdReportPath, md, 'utf8');

console.log(JSON.stringify({
  phase: report.phase,
  status: report.status,
  jsonReportPath: rel(jsonReportPath),
  mdReportPath: rel(mdReportPath),
  blockers: blockers.length,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
}, null, 2));

process.exit(ready ? 0 : 2);
