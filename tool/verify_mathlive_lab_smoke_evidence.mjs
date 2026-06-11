#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_lab_smoke_evidence.mjs', retiredPhase: 'verify_mathlive_lab_smoke_evidence', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const scriptDir = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(scriptDir, '..');
const phase = 'V172-Q90R5';
const defaultEvidencePath = 'docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json';
const evidenceArgIndex = process.argv.indexOf('--file');
const evidenceRelPath = evidenceArgIndex >= 0 && process.argv[evidenceArgIndex + 1]
  ? process.argv[evidenceArgIndex + 1]
  : defaultEvidencePath;
const evidencePath = resolve(projectRoot, evidenceRelPath);
const reportPath = resolve(projectRoot, 'tool/verify_mathlive_lab_smoke_evidence_report.json');

function writeReport(report) {
  mkdirSync(dirname(reportPath), { recursive: true });
  writeFileSync(reportPath, JSON.stringify(report, null, 2) + '\n', 'utf8');
}

function readJson(path) {
  return JSON.parse(readFileSync(path, 'utf8'));
}

const issues = [];
let evidence = null;
if (!existsSync(evidencePath)) {
  issues.push(`evidence file is missing: ${evidenceRelPath}`);
} else {
  try {
    evidence = readJson(evidencePath);
  } catch (error) {
    issues.push(`evidence JSON could not be parsed: ${error.message}`);
  }
}

if (evidence) {
  if (evidence.evidencePhase !== 'V172-Q90R5') issues.push('evidencePhase must be V172-Q90R5');
  if (evidence.runtimeSmokePhase !== 'V172-Q90R2') issues.push('runtimeSmokePhase must be V172-Q90R2');
  if (evidence.installVerified !== true) issues.push('Q90R4 installVerified must be true');
  if (evidence.officialRuntimeScriptLoaded !== true) issues.push('officialRuntimeScriptLoaded must be true');
  if (evidence.mathfieldElementDefined !== true) issues.push('mathfieldElementDefined must be true');
  if (evidence.mathfieldInstanceMounted !== true) issues.push('mathfieldInstanceMounted must be true');
  if (evidence.labRuntimeSmokePassed !== true) issues.push('labRuntimeSmokePassed must be true');
  if (Number(evidence.smokeCommandPasses || 0) < 6) issues.push('smokeCommandPasses must be at least 6');
  if (Number(evidence.smokeCommandTotal || 0) < 6) issues.push('smokeCommandTotal must be at least 6');
  if (evidence.bridgeCanInsertLatex !== true) issues.push('bridgeCanInsertLatex must be true');
  if (evidence.bridgeCanDeleteBackward !== true) issues.push('bridgeCanDeleteBackward must be true');
  if (evidence.bridgeCanExportLatex !== true) issues.push('bridgeCanExportLatex must be true');
  if (evidence.stateAdapterAcceptedExport !== true) issues.push('stateAdapterAcceptedExport must be true');
  if (evidence.virtualKeyboardEnabled !== false) issues.push('MathLive virtual keyboard must be disabled');
  if (evidence.remoteScriptLoadingAllowed !== false) issues.push('remoteScriptLoadingAllowed must be false');
  if (evidence.mainEditorSwitchAllowed !== false) issues.push('mainEditorSwitchAllowed must remain false');
  if (evidence.activeMainEditorEngine !== 'legacyFlutterSlotEditor') issues.push('activeMainEditorEngine must remain legacyFlutterSlotEditor');
  if (evidence.protectedUiSurfacesUnchanged !== true) issues.push('protectedUiSurfacesUnchanged must be true');
  if (evidence.realDeviceCursorCourtPassClaimed === true) issues.push('Q90R5 smoke evidence may not claim real-device cursor court PASS');
  if (evidence.photomathLevelClaimed === true) issues.push('Q90R5 smoke evidence may not claim Photomath/Wolfram level');
}

const passed = issues.length === 0;
const report = {
  phase,
  status: passed ? 'MATHLIVE_LAB_SMOKE_EVIDENCE_READY_FOR_Q87_CURSOR_COURT' : 'BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE',
  evidencePath: evidenceRelPath,
  evidenceVerified: passed,
  q87CursorCourtMayRun: passed,
  mainEditorSwitchAllowed: false,
  mainEditorMountAllowed: false,
  legacyEngineRemainsDefault: true,
  legacyEngineRemainsRollback: true,
  physicalLegacyDeletionAllowed: false,
  diagnostic: passed
    ? 'q90r5-lab-smoke-evidence-ready-for-q87-cursor-court-no-main-editor-switch'
    : 'q90r5-lab-smoke-evidence-blocked-no-main-editor-switch',
  issues
};
writeReport(report);
console.log(JSON.stringify(report, null, 2));
process.exit(passed ? 0 : 2);
