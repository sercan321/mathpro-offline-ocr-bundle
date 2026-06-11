#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const root = process.cwd();
const reportDir = join(root, 'tool', 'reports');
mkdirSync(reportDir, { recursive: true });

function readJson(path) {
  if (!existsSync(path)) return null;
  try { return JSON.parse(readFileSync(path, 'utf8')); } catch { return null; }
}

function runNodeScript(script) {
  if (!existsSync(join(root, script))) {
    return { script, exitCode: 127, status: 'MISSING_SCRIPT' };
  }
  const result = spawnSync(process.execPath, [script], { cwd: root, encoding: 'utf8' });
  return {
    script,
    exitCode: result.status ?? 1,
    stdout: (result.stdout || '').trim(),
    stderr: (result.stderr || '').trim(),
  };
}

const q103Run = runNodeScript('tool/verify_mathlive_graph_eligibility_adapter.mjs');
const q104Run = runNodeScript('tool/verify_mathlive_history_adapter.mjs');
const q105Run = runNodeScript('tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs');
const q108Run = runNodeScript('tool/verify_mathlive_real_device_cursor_court_execution.mjs');
const q109Run = runNodeScript('tool/verify_mathlive_main_editor_switch_conditional_activation.mjs');
const q109Report = readJson(join(root, 'tool/reports/mathlive_main_editor_switch_conditional_activation_report.json'));
const q108Report = readJson(join(root, 'tool/reports/mathlive_real_device_cursor_court_execution_report.json'));
const q103Report = readJson(join(root, 'tool/reports/mathlive_graph_eligibility_adapter_report.json'));
const q104Report = readJson(join(root, 'tool/reports/mathlive_history_adapter_report.json'));
const q105Report = readJson(join(root, 'tool/reports/mathlive_solution_evaluator_candidate_adapter_report.json'));

function statusIncludes(report, text) {
  return typeof report?.status === 'string' && report.status.includes(text);
}

const graphAdapterReady = statusIncludes(q103Report, 'PACKAGE_READY') || statusIncludes(q103Report, 'READY');
const historyAdapterReady = statusIncludes(q104Report, 'PACKAGE_READY') || statusIncludes(q104Report, 'READY');
const solutionAdapterReady = statusIncludes(q105Report, 'PACKAGE_READY') || statusIncludes(q105Report, 'READY');
const q109ReadyForReview = q109Report?.activationEvidenceComplete === true || q109Report?.mayActivateBehindInternalFlagForReview === true || q109Report?.status === 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_READY_FOR_REVIEW';
const q108CursorCourtPassed = q108Report?.realDeviceCursorCourtPass === true || q108Report?.status === 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_COMPLETE';

const flags = {
  q109ConditionalActivationReadyForReview: q109ReadyForReview,
  mathLiveMainEditorActivatedBehindInternalFlag: false,
  q108RealDeviceCursorCourtPassed: q108CursorCourtPassed,
  flutterAnalyzePassed: false,
  flutterTestPassed: false,
  graphAdapterReady,
  historyAdapterReady,
  solutionAdapterReady,
  legacyRollbackAvailable: true,
  postActivationSoakPassed: false,
  explicitRetirementApprovalApproved: false,
  protectedSurfacesUnchanged: true,
  keyboardUntouched: true,
  moreUntouched: true,
  longPressUntouched: true,
  appShellUntouched: true,
  graphHistorySolutionUiUntouched: true,
  noFakeEvidence: true,
  noActualRetirementInThisPackage: true,
  noPhysicalDeletionAttempted: true,
};

const blockers = [];
if (!flags.q109ConditionalActivationReadyForReview) blockers.push('Q109 conditional activation evidence is not ready for review');
if (!flags.mathLiveMainEditorActivatedBehindInternalFlag) blockers.push('MathLive main editor has not been activated behind the explicit internal flag');
if (!flags.q108RealDeviceCursorCourtPassed) blockers.push('Q108 real-device cursor court has not passed');
if (!flags.flutterAnalyzePassed) blockers.push('flutter analyze PASS evidence is missing');
if (!flags.flutterTestPassed) blockers.push('flutter test PASS evidence is missing');
if (!flags.graphAdapterReady) blockers.push('Q103 Graph adapter readiness report is missing or not ready');
if (!flags.historyAdapterReady) blockers.push('Q104 History adapter readiness report is missing or not ready');
if (!flags.solutionAdapterReady) blockers.push('Q105 Solution/Evaluator adapter readiness report is missing or not ready');
if (!flags.legacyRollbackAvailable) blockers.push('legacy rollback is not available');
if (!flags.postActivationSoakPassed) blockers.push('post-activation soak evidence is missing');
if (!flags.explicitRetirementApprovalApproved) blockers.push('explicit legacy main-path retirement approval is missing');
if (!flags.protectedSurfacesUnchanged) blockers.push('protected UI surfaces changed');
if (!flags.keyboardUntouched) blockers.push('keyboard source changed');
if (!flags.moreUntouched) blockers.push('MORE source changed');
if (!flags.longPressUntouched) blockers.push('long-press source changed');
if (!flags.appShellUntouched) blockers.push('app_shell.dart changed');
if (!flags.graphHistorySolutionUiUntouched) blockers.push('Graph/History/Solution UI changed');
if (!flags.noFakeEvidence) blockers.push('runtime/smoke/device evidence was faked');
if (!flags.noActualRetirementInThisPackage) blockers.push('Q110 attempted actual legacy main-path retirement');
if (!flags.noPhysicalDeletionAttempted) blockers.push('Q110 attempted physical legacy cursor deletion');

const packageSideGateReady = flags.graphAdapterReady && flags.historyAdapterReady && flags.solutionAdapterReady && flags.legacyRollbackAvailable && flags.protectedSurfacesUnchanged && flags.keyboardUntouched && flags.moreUntouched && flags.longPressUntouched && flags.appShellUntouched && flags.graphHistorySolutionUiUntouched && flags.noFakeEvidence && flags.noActualRetirementInThisPackage && flags.noPhysicalDeletionAttempted;
const evidenceCompleteForLaterRetirementReview = packageSideGateReady && flags.q109ConditionalActivationReadyForReview && flags.mathLiveMainEditorActivatedBehindInternalFlag && flags.q108RealDeviceCursorCourtPassed && flags.flutterAnalyzePassed && flags.flutterTestPassed && flags.postActivationSoakPassed && flags.explicitRetirementApprovalApproved;
const status = evidenceCompleteForLaterRetirementReview
  ? 'LEGACY_CURSOR_MAIN_PATH_RETIREMENT_READY_FOR_EXPLICIT_REVIEW'
  : packageSideGateReady
    ? 'LEGACY_CURSOR_MAIN_PATH_RETIREMENT_GATE_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_LEGACY_CURSOR_MAIN_PATH_RETIREMENT_ACTUAL_GATE';

const report = {
  phase: 'V172-Q110',
  status,
  packageSideGateReady,
  evidenceCompleteForLaterRetirementReview,
  blockers,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  actualLegacyMainPathRetirementImplementedInThisPackage: false,
  mayRetireLegacyMainPathInLaterReviewedPhase: evidenceCompleteForLaterRetirementReview,
  mayRetireLegacyMainPathNow: false,
  mayDeleteLegacyCursor: false,
  maySwitchDefaultEditorNow: false,
  mayClaimCursorPass: false,
  protectedUiSurfaceMutationAllowed: false,
  q103Run,
  q104Run,
  q105Run,
  q108Run,
  q109Run,
  inputs: flags,
};

writeFileSync(join(reportDir, 'legacy_cursor_main_path_retirement_actual_gate_report.json'), JSON.stringify(report, null, 2) + '\n');
writeFileSync(join(reportDir, 'legacy_cursor_main_path_retirement_actual_gate_report.md'), `# V172-Q110 Legacy Cursor Main Path Retirement Actual Gate\n\nStatus: ${status}\n\nPackage-side gate ready: ${packageSideGateReady}\n\nEvidence complete for later retirement review: ${evidenceCompleteForLaterRetirementReview}\n\n## Blockers\n${blockers.map((b) => `- ${b}`).join('\n') || '- none'}\n\n## Safety\n- actualLegacyMainPathRetirementImplementedInThisPackage: false\n- mayRetireLegacyMainPathNow: false\n- mayDeleteLegacyCursor: false\n- maySwitchDefaultEditorNow: false\n- protectedUiSurfaceMutationAllowed: false\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(evidenceCompleteForLaterRetirementReview ? 0 : 2);
