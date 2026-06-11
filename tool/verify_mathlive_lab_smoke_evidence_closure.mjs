#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_lab_smoke_evidence_closure.mjs', retiredPhase: 'verify_mathlive_lab_smoke_evidence_closure', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

/*
 * V172-Q101 Lab Smoke Evidence Closure verifier.
 *
 * This verifier consolidates Q100 official runtime bundle closure, Q90R6 smoke
 * evidence authoring, and Q90R5 canonical smoke evidence verification. It is
 * offline and non-authoring by default: it does not download MathLive, does not
 * create canonical smoke evidence, does not switch the main editor, and does not
 * delete legacy cursor files. Use --refresh only to run the existing verifier /
 * authoring scripts; those scripts still refuse to write evidence unless real
 * runtime and Lab capture inputs are present.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { spawnSync } from 'node:child_process';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_lab_smoke_evidence_closure_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_lab_smoke_evidence_closure_report.md');
const shouldRefresh = process.argv.includes('--refresh');

const paths = {
  q100Report: path.join(projectRoot, 'tool', 'reports', 'mathlive_official_runtime_bundle_report.json'),
  q90r6WriterReport: path.join(projectRoot, 'tool', 'write_mathlive_lab_smoke_evidence_report.json'),
  q90r5VerifierReport: path.join(projectRoot, 'tool', 'verify_mathlive_lab_smoke_evidence_report.json'),
  evidence: path.join(projectRoot, 'docs', 'evidence', 'V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json'),
};

function rel(absolutePath) {
  return path.relative(projectRoot, absolutePath).replaceAll(path.sep, '/');
}

function readJson(absolutePath, label, blockers) {
  if (!existsSync(absolutePath)) {
    blockers.push(`${label} is missing: ${rel(absolutePath)}`);
    return null;
  }
  try {
    return JSON.parse(readFileSync(absolutePath, 'utf8'));
  } catch (error) {
    blockers.push(`${label} is not readable JSON: ${error.message}`);
    return null;
  }
}

function sha256File(absolutePath) {
  const h = createHash('sha256');
  h.update(readFileSync(absolutePath));
  return h.digest('hex');
}

function runStep(name, command, args) {
  const startedAt = new Date().toISOString();
  const result = spawnSync(command, args, { cwd: projectRoot, encoding: 'utf8' });
  return {
    name,
    command: [command, ...args].join(' '),
    startedAt,
    finishedAt: new Date().toISOString(),
    exitCode: typeof result.status === 'number' ? result.status : 1,
    status: result.status === 0 ? 'PASS' : 'BLOCKED',
    stdout: result.stdout || '',
    stderr: result.stderr || '',
    error: result.error ? String(result.error.message || result.error) : '',
  };
}

mkdirSync(reportDir, { recursive: true });

const refreshSteps = [];
if (shouldRefresh) {
  refreshSteps.push(runStep('q100_official_runtime_bundle_closure', 'node', ['tool/verify_mathlive_official_runtime_bundle.mjs']));
  refreshSteps.push(runStep('q90r6_smoke_evidence_writer', 'node', ['tool/write_mathlive_lab_smoke_evidence.mjs']));
  refreshSteps.push(runStep('q90r5_smoke_evidence_verifier', 'node', ['tool/verify_mathlive_lab_smoke_evidence.mjs']));
}

const blockers = [];
const q100Report = readJson(paths.q100Report, 'Q100 official runtime bundle report', blockers);
const q90r6Report = readJson(paths.q90r6WriterReport, 'Q90R6 smoke evidence writer report', blockers);
const q90r5Report = readJson(paths.q90r5VerifierReport, 'Q90R5 smoke evidence verifier report', blockers);
const evidence = readJson(paths.evidence, 'canonical Q90R5 smoke evidence', blockers);

const q100Closed = q100Report?.officialRuntimeBundleClosed === true
  && q100Report?.status === 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSED_FOR_SMOKE_EVIDENCE';
const q90r6Authored = q90r6Report?.evidenceWritten === true
  && q90r6Report?.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORED_FOR_Q90R5_VERIFICATION';
const q90r5Verified = q90r5Report?.evidenceVerified === true
  && q90r5Report?.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_READY_FOR_Q87_CURSOR_COURT';

if (!q100Closed) blockers.push('Q100 official runtime bundle closure is not PASS');
if (!q90r6Authored) blockers.push('Q90R6 smoke evidence authoring report is not PASS');
if (!q90r5Verified) blockers.push('Q90R5 canonical smoke evidence verifier is not PASS');

const evidenceChecks = {
  present: existsSync(paths.evidence),
  jsonValid: Boolean(evidence),
  sha256: existsSync(paths.evidence) ? sha256File(paths.evidence) : null,
  evidencePhaseIsQ90R5: evidence?.evidencePhase === 'V172-Q90R5',
  runtimeSmokePhaseIsQ90R2: evidence?.runtimeSmokePhase === 'V172-Q90R2',
  installVerified: evidence?.installVerified === true,
  officialRuntimeScriptLoaded: evidence?.officialRuntimeScriptLoaded === true,
  mathfieldElementDefined: evidence?.mathfieldElementDefined === true,
  mathfieldInstanceMounted: evidence?.mathfieldInstanceMounted === true,
  labRuntimeSmokePassed: evidence?.labRuntimeSmokePassed === true,
  smokeCommandPasses: Number(evidence?.smokeCommandPasses ?? 0),
  smokeCommandTotal: Number(evidence?.smokeCommandTotal ?? 0),
  bridgeCanInsertLatex: evidence?.bridgeCanInsertLatex === true,
  bridgeCanDeleteBackward: evidence?.bridgeCanDeleteBackward === true,
  bridgeCanExportLatex: evidence?.bridgeCanExportLatex === true,
  stateAdapterAcceptedExport: evidence?.stateAdapterAcceptedExport === true,
  virtualKeyboardDisabled: evidence?.virtualKeyboardEnabled === false,
  remoteScriptsDisabled: evidence?.remoteScriptLoadingAllowed === false,
  mainEditorStillLegacy: evidence?.activeMainEditorEngine === 'legacyFlutterSlotEditor' && evidence?.mainEditorSwitchAllowed === false,
  protectedSurfacesUnchanged: evidence?.protectedUiSurfacesUnchanged === true,
  noCursorPassClaim: evidence?.realDeviceCursorCourtPassClaimed !== true,
  noPhotomathWolframClaim: evidence?.photomathLevelClaimed !== true,
};

if (!evidenceChecks.present) blockers.push(`canonical smoke evidence missing: ${rel(paths.evidence)}`);
if (!evidenceChecks.jsonValid) blockers.push('canonical smoke evidence JSON is not valid or not present');
if (evidence && !evidenceChecks.evidencePhaseIsQ90R5) blockers.push('canonical evidencePhase is not V172-Q90R5');
if (evidence && !evidenceChecks.runtimeSmokePhaseIsQ90R2) blockers.push('canonical runtimeSmokePhase is not V172-Q90R2');
if (evidence && !evidenceChecks.installVerified) blockers.push('canonical evidence does not prove installVerified true');
if (evidence && !evidenceChecks.officialRuntimeScriptLoaded) blockers.push('canonical evidence does not prove officialRuntimeScriptLoaded true');
if (evidence && !evidenceChecks.mathfieldElementDefined) blockers.push('canonical evidence does not prove mathfieldElementDefined true');
if (evidence && !evidenceChecks.mathfieldInstanceMounted) blockers.push('canonical evidence does not prove mathfieldInstanceMounted true');
if (evidence && !evidenceChecks.labRuntimeSmokePassed) blockers.push('canonical evidence does not prove labRuntimeSmokePassed true');
if (evidence && (evidenceChecks.smokeCommandPasses < 6 || evidenceChecks.smokeCommandTotal < 6)) blockers.push('canonical evidence has insufficient smoke command passes');
if (evidence && !evidenceChecks.bridgeCanInsertLatex) blockers.push('canonical evidence does not prove bridgeCanInsertLatex true');
if (evidence && !evidenceChecks.bridgeCanDeleteBackward) blockers.push('canonical evidence does not prove bridgeCanDeleteBackward true');
if (evidence && !evidenceChecks.bridgeCanExportLatex) blockers.push('canonical evidence does not prove bridgeCanExportLatex true');
if (evidence && !evidenceChecks.stateAdapterAcceptedExport) blockers.push('canonical evidence does not prove stateAdapterAcceptedExport true');
if (evidence && !evidenceChecks.virtualKeyboardDisabled) blockers.push('canonical evidence does not prove virtualKeyboardEnabled false');
if (evidence && !evidenceChecks.remoteScriptsDisabled) blockers.push('canonical evidence does not prove remoteScriptLoadingAllowed false');
if (evidence && !evidenceChecks.mainEditorStillLegacy) blockers.push('canonical evidence does not keep main editor legacy/default');
if (evidence && !evidenceChecks.protectedSurfacesUnchanged) blockers.push('canonical evidence does not prove protected UI surfaces unchanged');
if (evidence && !evidenceChecks.noCursorPassClaim) blockers.push('canonical evidence illegally claims real-device cursor PASS');
if (evidence && !evidenceChecks.noPhotomathWolframClaim) blockers.push('canonical evidence illegally claims Photomath/Wolfram level');

const closed = blockers.length === 0;
const report = {
  phase: 'V172-Q101',
  status: closed
    ? 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT'
    : 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE',
  generatedAt: new Date().toISOString(),
  refreshReports: shouldRefresh,
  refreshSteps,
  labSmokeEvidenceClosed: closed,
  mayRunQ87CursorCourt: closed,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayMountMainEditor: false,
  mayEnableMathLiveByDefault: false,
  mayDeleteLegacyCursor: false,
  protectedUiSurfaceMutationAllowed: false,
  graphHistorySolutionUiMutationAllowed: false,
  remoteScriptLoadingAllowed: false,
  mathLiveVirtualKeyboardEnabled: false,
  realDeviceCursorCourtStillRequired: true,
  blockers,
  inputs: {
    q100Report: rel(paths.q100Report),
    q90r6WriterReport: rel(paths.q90r6WriterReport),
    q90r5VerifierReport: rel(paths.q90r5VerifierReport),
    canonicalEvidence: rel(paths.evidence),
  },
  evidenceChecks,
  q100Summary: q100Report ? { phase: q100Report.phase, status: q100Report.status, officialRuntimeBundleClosed: q100Report.officialRuntimeBundleClosed === true } : null,
  q90r6Summary: q90r6Report ? { phase: q90r6Report.phase, status: q90r6Report.status, evidenceWritten: q90r6Report.evidenceWritten === true } : null,
  q90r5Summary: q90r5Report ? { phase: q90r5Report.phase, status: q90r5Report.status, evidenceVerified: q90r5Report.evidenceVerified === true } : null,
};

writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q101 MathLive Lab Smoke Evidence Closure Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- refreshReports: ${String(shouldRefresh)}`,
  `- labSmokeEvidenceClosed: ${String(closed)}`,
  '- mayRunQ87CursorCourt: ' + String(closed),
  '- mayClaimCursorPass: false',
  '- maySwitchMainEditor: false',
  '- mayMountMainEditor: false',
  '- mayEnableMathLiveByDefault: false',
  '- mayDeleteLegacyCursor: false',
  '',
  '## Blockers',
  ...(blockers.length ? blockers.map(item => `- ${item}`) : ['- none']),
  '',
  '## Inputs',
  `- Q100 report: ${report.inputs.q100Report}`,
  `- Q90R6 writer report: ${report.inputs.q90r6WriterReport}`,
  `- Q90R5 verifier report: ${report.inputs.q90r5VerifierReport}`,
  `- Canonical evidence: ${report.inputs.canonicalEvidence}`,
  '',
].join('\n');
writeFileSync(mdReportPath, md, 'utf8');

console.log(JSON.stringify({
  phase: report.phase,
  status: report.status,
  jsonReportPath: rel(jsonReportPath),
  mdReportPath: rel(mdReportPath),
  blockers: blockers.length,
  mayRunQ87CursorCourt: closed,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
}, null, 2));

process.exit(closed ? 0 : 2);
