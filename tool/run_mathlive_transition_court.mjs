#!/usr/bin/env node
import { spawnSync } from 'node:child_process';
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_transition_court_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_transition_court_report.md');

const args = new Set(process.argv.slice(2));
const runFlutter = args.has('--run-flutter');
const runDevice = args.has('--run-device');

function runStep(name, command, commandArgs, options = {}) {
  const startedAt = new Date().toISOString();
  const executable = options.windowsCommand && process.platform === 'win32'
    ? options.windowsCommand
    : command;
  const result = spawnSync(executable, commandArgs, {
    cwd: projectRoot,
    encoding: 'utf8',
    shell: false,
    timeout: options.timeoutMs ?? 120000,
  });
  const stdout = result.stdout ?? '';
  const stderr = result.stderr ?? '';
  const exitCode = typeof result.status === 'number' ? result.status : null;
  const blocked = Boolean(result.error) || exitCode !== 0;
  return {
    name,
    command: [executable, ...commandArgs].join(' '),
    startedAt,
    finishedAt: new Date().toISOString(),
    exitCode,
    status: blocked ? 'BLOCKED' : 'PASS',
    error: result.error ? String(result.error.message || result.error) : '',
    stdout: stdout.slice(-6000),
    stderr: stderr.slice(-6000),
  };
}

function skippedStep(name, reason) {
  return {
    name,
    command: '',
    startedAt: new Date().toISOString(),
    finishedAt: new Date().toISOString(),
    exitCode: null,
    status: 'SKIPPED',
    error: '',
    stdout: '',
    stderr: reason,
  };
}

function reportFileStatus(name, relativePath, required) {
  const absolutePath = path.join(projectRoot, relativePath);
  return {
    name,
    path: relativePath,
    required,
    exists: existsSync(absolutePath),
    status: existsSync(absolutePath) ? 'PRESENT' : (required ? 'MISSING_REQUIRED' : 'MISSING_OPTIONAL'),
  };
}

function parseVerifierReport(relativePath) {
  const absolutePath = path.join(projectRoot, relativePath);
  if (!existsSync(absolutePath)) return null;
  try {
    return JSON.parse(readFileSync(absolutePath, 'utf8'));
  } catch (error) {
    return { parseError: String(error) };
  }
}

mkdirSync(reportDir, { recursive: true });

const steps = [];
steps.push(runStep('contract_verifier', 'python3', ['tool/verify_mathpro_contract.py'], {
  windowsCommand: 'python',
  timeoutMs: 120000,
}));
steps.push(runStep('mathlive_runtime_verifier', 'node', ['tool/verify_mathlive_runtime.mjs'], {
  windowsCommand: 'node',
  timeoutMs: 120000,
}));
steps.push(runStep('mathlive_smoke_evidence_writer', 'node', ['tool/write_mathlive_lab_smoke_evidence.mjs'], {
  windowsCommand: 'node',
  timeoutMs: 120000,
}));
steps.push(runStep('mathlive_smoke_evidence_verifier', 'node', ['tool/verify_mathlive_lab_smoke_evidence.mjs'], {
  windowsCommand: 'node',
  timeoutMs: 120000,
}));

if (runFlutter) {
  steps.push(runStep('flutter_pub_get', 'flutter', ['pub', 'get'], { windowsCommand: 'flutter', timeoutMs: 300000 }));
  steps.push(runStep('flutter_analyze', 'flutter', ['analyze'], { windowsCommand: 'flutter', timeoutMs: 300000 }));
  steps.push(runStep('flutter_test', 'flutter', ['test'], { windowsCommand: 'flutter', timeoutMs: 600000 }));
} else {
  steps.push(skippedStep('flutter_pub_get', 'skipped unless --run-flutter is passed'));
  steps.push(skippedStep('flutter_analyze', 'skipped unless --run-flutter is passed'));
  steps.push(skippedStep('flutter_test', 'skipped unless --run-flutter is passed'));
}

if (runDevice) {
  steps.push(runStep('flutter_run_mathlive_lab_device', 'flutter', ['run', '-t', 'lib/main_mathlive_lab.dart', '-d', '23106RN0DA'], { windowsCommand: 'flutter', timeoutMs: 900000 }));
  steps.push(runStep('flutter_run_main_app_device', 'flutter', ['run', '-d', '23106RN0DA'], { windowsCommand: 'flutter', timeoutMs: 900000 }));
} else {
  steps.push(skippedStep('flutter_run_mathlive_lab_device', 'skipped unless --run-device is passed'));
  steps.push(skippedStep('flutter_run_main_app_device', 'skipped unless --run-device is passed'));
}

const requiredFiles = [
  reportFileStatus('official MathLive runtime script', 'assets/mathlive/vendor/mathlive/mathlive.min.js', true),
  reportFileStatus('official MathLive runtime manifest', 'assets/mathlive/vendor/mathlive/runtime_manifest.json', true),
  reportFileStatus('canonical Q90R5 smoke evidence', 'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json', true),
  reportFileStatus('Lab capture input', 'tool/mathlive_lab_runtime_smoke_capture.json', false),
  reportFileStatus('Q90R4 runtime verifier report', 'tool/verify_mathlive_runtime_report.json', false),
  reportFileStatus('Q90R5 smoke verifier report', 'tool/verify_mathlive_lab_smoke_evidence_report.json', false),
];

const blockers = [];
for (const step of steps) {
  if (step.status === 'BLOCKED') blockers.push(`${step.name}: ${step.stderr || step.error || 'blocked'}`.slice(0, 900));
  if (step.status === 'SKIPPED' && (step.name.startsWith('flutter_'))) blockers.push(`${step.name}: ${step.stderr}`);
}
for (const file of requiredFiles) {
  if (file.required && !file.exists) blockers.push(`${file.name} missing at ${file.path}`);
}

const protectedMutationsAllowed = false;
const mainEditorSwitchAllowed = false;
const legacyDeletionAllowed = false;
const report = {
  phase: 'V172-Q98',
  status: blockers.length === 0
    ? 'MATHLIVE_TRANSITION_EVIDENCE_LEDGER_READY_FOR_FINAL_REVIEW'
    : 'BLOCKED_MATHLIVE_TRANSITION_EVIDENCE_ORCHESTRATOR',
  generatedAt: new Date().toISOString(),
  runFlutter,
  runDevice,
  protectedMutationsAllowed,
  mainEditorSwitchAllowed,
  legacyDeletionAllowed,
  mayClaimRealDevicePass: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
  blockers,
  steps,
  files: requiredFiles,
  verifierReports: {
    mathproContract: parseVerifierReport('tool/verify_mathpro_contract_report.json'),
    runtime: parseVerifierReport('tool/verify_mathlive_runtime_report.json'),
    smokeEvidence: parseVerifierReport('tool/verify_mathlive_lab_smoke_evidence_report.json'),
    smokeWriter: parseVerifierReport('tool/write_mathlive_lab_smoke_evidence_report.json'),
  },
};

writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q98 MathLive Transition Court Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- runFlutter: ${runFlutter}`,
  `- runDevice: ${runDevice}`,
  '- mayClaimRealDevicePass: false',
  '- maySwitchMainEditor: false',
  '- mayDeleteLegacyCursor: false',
  '',
  '## Blockers',
  ...(blockers.length ? blockers.map((item) => `- ${item}`) : ['- none']),
  '',
  '## Steps',
  ...steps.map((step) => `- ${step.name}: ${step.status} (${step.command || step.stderr})`),
  '',
  '## Required files',
  ...requiredFiles.map((file) => `- ${file.path}: ${file.status}`),
  '',
].join('\n');
writeFileSync(mdReportPath, md, 'utf8');

console.log(JSON.stringify({
  phase: report.phase,
  status: report.status,
  jsonReportPath: path.relative(projectRoot, jsonReportPath),
  mdReportPath: path.relative(projectRoot, mdReportPath),
  blockers: blockers.length,
  mayClaimRealDevicePass: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
}, null, 2));

process.exit(blockers.length === 0 ? 0 : 2);
