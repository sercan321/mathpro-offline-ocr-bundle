#!/usr/bin/env node
/*
 * V172-Q90R6 MathLive Lab smoke evidence authoring tool.
 *
 * This tool converts a copied report from the isolated MathLive Lab into the
 * canonical Q90R5 evidence JSON file only when Q90R4 runtime verification and
 * Q90R2 Lab smoke evidence are both present. It does not download anything,
 * does not switch the main editor, and does not claim cursor/Photomath PASS.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(scriptDir, '..');
const phase = 'V172-Q90R6';
const defaultCapturePath = 'tool/mathlive_lab_runtime_smoke_capture.json';
const defaultOutputPath = 'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json';
const runtimeVerificationReportPath = 'tool/verify_mathlive_runtime_report.json';
const authorReportPath = 'tool/write_mathlive_lab_smoke_evidence_report.json';

function argValue(name, fallback) {
  const index = process.argv.indexOf(name);
  return index >= 0 && process.argv[index + 1] ? process.argv[index + 1] : fallback;
}

const captureRelPath = argValue('--capture', defaultCapturePath);
const outputRelPath = argValue('--out', defaultOutputPath);
const capturePath = resolve(projectRoot, captureRelPath);
const outputPath = resolve(projectRoot, outputRelPath);
const runtimeReportPath = resolve(projectRoot, runtimeVerificationReportPath);
const reportPath = resolve(projectRoot, authorReportPath);

function writeJson(path, value) {
  mkdirSync(dirname(path), { recursive: true });
  writeFileSync(path, JSON.stringify(value, null, 2) + '\n', 'utf8');
}

function readJson(path, issues, label) {
  try {
    return JSON.parse(readFileSync(path, 'utf8'));
  } catch (error) {
    issues.push(`${label} could not be parsed: ${error.message}`);
    return null;
  }
}

function bool(value) {
  return value === true;
}

function numeric(value) {
  const number = Number(value ?? 0);
  return Number.isFinite(number) ? number : 0;
}

function unwrapCapture(raw) {
  if (!raw || typeof raw !== 'object') return {};
  if (raw.runtimeSmokeEvidenceReport && typeof raw.runtimeSmokeEvidenceReport === 'object') {
    return raw.runtimeSmokeEvidenceReport;
  }
  if (raw.evidence && typeof raw.evidence === 'object') return raw.evidence;
  if (raw.bridgeState && typeof raw.bridgeState === 'object') return raw.bridgeState;
  return raw;
}

const issues = [];
let runtimeReport = null;
if (!existsSync(runtimeReportPath)) {
  issues.push(`Q90R4 runtime verification report is missing: ${runtimeVerificationReportPath}`);
} else {
  runtimeReport = readJson(runtimeReportPath, issues, 'Q90R4 runtime verification report');
}

let captureRaw = null;
if (!existsSync(capturePath)) {
  issues.push(`MathLive Lab smoke capture input is missing: ${captureRelPath}`);
} else {
  captureRaw = readJson(capturePath, issues, 'MathLive Lab smoke capture input');
}

const capture = unwrapCapture(captureRaw);
const runtimeInstallVerified = bool(runtimeReport?.installVerified) || runtimeReport?.status === 'MATHLIVE_RUNTIME_INSTALL_VERIFIED_FOR_LAB_SMOKE';
const capturePhase = String(capture.evidencePhase || capture.runtimeSmokeEvidencePhase || capture.authoringPhase || '');
const capturePhaseAcceptable = capturePhase === 'V172-Q90R5' || capturePhase === 'V172-Q90R6';
const smokePasses = numeric(capture.smokeCommandPasses);
const smokeTotal = numeric(capture.smokeCommandTotal);

if (!runtimeInstallVerified) issues.push('Q90R4 runtime install verification has not passed');
if (!capturePhaseAcceptable) issues.push('capture input is not a Q90R5/Q90R6 MathLive Lab smoke evidence report');
if (capture.runtimeSmokePhase !== 'V172-Q90R2') issues.push('runtimeSmokePhase must be V172-Q90R2');
if (!bool(capture.officialRuntimeScriptLoaded)) issues.push('officialRuntimeScriptLoaded must be true');
if (!bool(capture.mathfieldElementDefined)) issues.push('mathfieldElementDefined must be true');
if (!bool(capture.mathfieldInstanceMounted)) issues.push('mathfieldInstanceMounted must be true');
if (!bool(capture.labRuntimeSmokePassed)) issues.push('labRuntimeSmokePassed must be true');
if (smokePasses < 6) issues.push('smokeCommandPasses must be at least 6');
if (smokeTotal < 6) issues.push('smokeCommandTotal must be at least 6');
if (!bool(capture.bridgeCanInsertLatex)) issues.push('bridgeCanInsertLatex must be true');
if (!bool(capture.bridgeCanDeleteBackward)) issues.push('bridgeCanDeleteBackward must be true');
if (!bool(capture.bridgeCanExportLatex)) issues.push('bridgeCanExportLatex must be true');
if (!bool(capture.stateAdapterAcceptedExport)) issues.push('stateAdapterAcceptedExport must be true');
if (capture.virtualKeyboardEnabled !== false) issues.push('MathLive virtual keyboard must be disabled');
if (capture.remoteScriptLoadingAllowed !== false) issues.push('remoteScriptLoadingAllowed must be false');
if (capture.mainEditorSwitchAllowed !== false) issues.push('mainEditorSwitchAllowed must remain false');
if (capture.activeMainEditorEngine !== 'legacyFlutterSlotEditor') issues.push('activeMainEditorEngine must remain legacyFlutterSlotEditor');
if (capture.protectedUiSurfacesUnchanged !== true) issues.push('protectedUiSurfacesUnchanged must be true');
if (capture.realDeviceCursorCourtPassClaimed === true) issues.push('Q90R6 authoring may not claim real-device cursor court PASS');
if (capture.photomathLevelClaimed === true) issues.push('Q90R6 authoring may not claim Photomath/Wolfram level');

const canWrite = issues.length === 0;
const report = {
  phase,
  status: canWrite
    ? 'MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORED_FOR_Q90R5_VERIFICATION'
    : 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORING',
  capturePath: captureRelPath,
  outputPath: outputRelPath,
  runtimeVerificationReport: runtimeVerificationReportPath,
  evidenceWritten: canWrite,
  q90r5VerifierMustRunAfterWriting: true,
  q87CursorCourtMayRun: false,
  mainEditorSwitchAllowed: false,
  mainEditorMountAllowed: false,
  legacyEngineRemainsDefault: true,
  legacyEngineRemainsRollback: true,
  physicalLegacyDeletionAllowed: false,
  diagnostic: canWrite
    ? 'q90r6-evidence-authored-run-q90r5-verifier-next-no-main-editor-switch'
    : 'q90r6-evidence-authoring-blocked-no-main-editor-switch',
  issues,
};

if (canWrite) {
  const evidence = {
    evidencePhase: 'V172-Q90R5',
    authoringPhase: 'V172-Q90R6',
    runtimeSmokePhase: 'V172-Q90R2',
    installVerificationPhase: 'V172-Q90R4',
    installVerified: true,
    officialRuntimeScriptLoaded: true,
    mathfieldElementDefined: true,
    mathfieldInstanceMounted: true,
    labRuntimeSmokePassed: true,
    smokeCommandPasses: smokePasses,
    smokeCommandTotal: smokeTotal,
    bridgeCanInsertLatex: true,
    bridgeCanDeleteBackward: true,
    bridgeCanExportLatex: true,
    stateAdapterAcceptedExport: true,
    virtualKeyboardEnabled: false,
    remoteScriptLoadingAllowed: false,
    mainEditorSwitchAllowed: false,
    activeMainEditorEngine: 'legacyFlutterSlotEditor',
    protectedUiSurfacesUnchanged: true,
    realDeviceCursorCourtPassClaimed: false,
    photomathLevelClaimed: false,
    notes: 'Authored by V172-Q90R6 from isolated MathLive Lab smoke capture. Run node tool/verify_mathlive_lab_smoke_evidence.mjs next. This evidence does not switch the main editor and does not claim cursor court PASS.'
  };
  writeJson(outputPath, evidence);
}

writeJson(reportPath, report);
console.log(JSON.stringify(report, null, 2));
process.exit(canWrite ? 0 : 2);
