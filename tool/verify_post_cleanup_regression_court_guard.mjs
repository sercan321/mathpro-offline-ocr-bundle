#!/usr/bin/env node
import { existsSync, mkdirSync, readdirSync, readFileSync, statSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const root = process.cwd();
const reportDir = join(root, 'tool', 'reports');
mkdirSync(reportDir, { recursive: true });

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/math_label.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/app/app_shell.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
];

const requiredPolicyFiles = [
  'lib/features/editor_adapter/post_cleanup_regression_court_guard_policy.dart',
  'lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_policy.dart',
  'tool/verify_legacy_cursor_physical_cleanup_execution_guard.mjs',
  'docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json',
];

function readJson(path) {
  try {
    if (!existsSync(path)) return null;
    return JSON.parse(readFileSync(path, 'utf8'));
  } catch (error) {
    return { parseError: String(error) };
  }
}

function listFiles(dir) {
  if (!existsSync(dir)) return [];
  const out = [];
  for (const name of readdirSync(dir)) {
    const p = join(dir, name);
    const st = statSync(p);
    if (st.isDirectory()) out.push(...listFiles(p));
    else out.push(p.slice(root.length + 1).replaceAll('\\\\', '/'));
  }
  return out;
}

function hasAll(paths) {
  return paths.every((p) => existsSync(join(root, p)));
}

function protectedSurfacesClean() {
  const changed = [];
  for (const file of protectedFiles) {
    const path = join(root, file);
    if (!existsSync(path)) {
      changed.push(`${file} missing`);
      continue;
    }
    const text = readFileSync(path, 'utf8');
    if (text.includes('V172-Q113') || text.includes('postCleanupRegressionCourtGuard')) {
      changed.push(`${file} contains Q113 marker`);
    }
  }
  return changed;
}

function runNode(script) {
  if (!existsSync(join(root, script))) {
    return { script, status: 'MISSING', exitCode: null };
  }
  const result = spawnSync('node', [script], { cwd: root, encoding: 'utf8' });
  return {
    script,
    status: result.status === 0 ? 'PASS' : 'BLOCKED_OR_FAILED',
    exitCode: result.status,
    stdout: result.stdout?.slice(0, 4000) ?? '',
    stderr: result.stderr?.slice(0, 4000) ?? '',
  };
}

const q112Run = runNode('tool/verify_legacy_cursor_physical_cleanup_execution_guard.mjs');
const q112Report = readJson(join(reportDir, 'legacy_cursor_physical_cleanup_execution_guard_report.json'));
const q108Report = readJson(join(reportDir, 'mathlive_real_device_cursor_court_execution_report.json'));
const inventory = readJson(join(root, 'docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json'));
const protectedProblems = protectedSurfacesClean();
const allFiles = listFiles(root);
const cleanupDeltaManifests = allFiles.filter((p) => /cleanup.*delta.*manifest/i.test(p) || /post.*cleanup.*delta/i.test(p));

const categories = inventory?.categories ?? {};
const cleanupCandidates = Array.isArray(categories.cleanupCandidateAfterQ112Review) ? categories.cleanupCandidateAfterQ112Review : [];
const manualReviewFiles = Array.isArray(categories.manualReviewRequiredBeforeDeletion) ? categories.manualReviewRequiredBeforeDeletion : [];
const rollbackFiles = Array.isArray(categories.retainRollbackUntilPostActivation) ? categories.retainRollbackUntilPostActivation : [];
const dataPathFiles = Array.isArray(categories.mustKeepDataModelOrSharedEditorCore) ? categories.mustKeepDataModelOrSharedEditorCore : [];

const missingPolicyFiles = requiredPolicyFiles.filter((p) => !existsSync(join(root, p)));
const packageHygieneClean = !allFiles.some((p) => p.startsWith('build/') || p.startsWith('.dart_tool/') || p.startsWith('.gradle/') || p.includes('__pycache__/') || p.endsWith('.pyc') || p.endsWith('.apk') || p.endsWith('.aab'));

const flags = {
  q112ExecutionGuardPackageReady: q112Report?.packageSideExecutionGuardReady === true,
  q112EvidenceCompleteForPhysicalCleanupExecution: q112Report?.evidenceCompleteForPhysicalCleanupExecution === true,
  approvedCleanupActuallyExecuted: false,
  cleanupDeltaManifestPresent: cleanupDeltaManifests.length > 0,
  flutterPubGetPassed: false,
  flutterAnalyzePassed: q112Report?.inputs?.flutterAnalyzePassed === true,
  flutterTestPassed: q112Report?.inputs?.flutterTestPassed === true,
  mathLiveLabRealDeviceRunPassed: false,
  mainAppRealDeviceRunPassed: false,
  q108RealDeviceCursorCourtPassed: q108Report?.realDeviceCursorCourtPassed === true || q108Report?.evidenceCompleteForCursorCourt === true,
  graphWorks: false,
  historyWorks: false,
  solutionInputWorks: false,
  noLegacyCursorOverlayVisibleOnMathLivePath: false,
  rollbackFlagWorks: false,
  protectedSurfacesUnchanged: protectedProblems.length === 0 && missingPolicyFiles.length === 0,
  cleanupCandidateFilesStillPresent: hasAll(cleanupCandidates) && hasAll(manualReviewFiles),
  rollbackFilesPreserved: hasAll(rollbackFiles),
  dataPathFilesPreserved: hasAll(dataPathFiles),
  packageHygieneClean,
  noFakeEvidence: inventory?.fakeRuntimeEvidenceAllowed === false && inventory?.fakeSmokeEvidenceAllowed === false && inventory?.fakeDeviceEvidenceAllowed === false,
  explicitReleaseApprovalApproved: false,
};

const blockers = [];
if (!flags.q112ExecutionGuardPackageReady) blockers.push('Q112 cleanup execution guard package is not ready');
if (!flags.q112EvidenceCompleteForPhysicalCleanupExecution) blockers.push('Q112 physical cleanup execution evidence is incomplete');
if (!flags.approvedCleanupActuallyExecuted) blockers.push('approved physical cleanup package has not actually executed');
if (!flags.cleanupDeltaManifestPresent) blockers.push('cleanup delta manifest is missing');
if (!flags.flutterPubGetPassed) blockers.push('flutter pub get PASS evidence is missing');
if (!flags.flutterAnalyzePassed) blockers.push('flutter analyze PASS evidence is missing');
if (!flags.flutterTestPassed) blockers.push('flutter test PASS evidence is missing');
if (!flags.mathLiveLabRealDeviceRunPassed) blockers.push('MathLive Lab real-device run PASS evidence is missing');
if (!flags.mainAppRealDeviceRunPassed) blockers.push('main app real-device run PASS evidence is missing');
if (!flags.q108RealDeviceCursorCourtPassed) blockers.push('Q108 real-device cursor court PASS evidence is missing');
if (!flags.graphWorks) blockers.push('Graph runtime behavior is not verified');
if (!flags.historyWorks) blockers.push('History runtime behavior is not verified');
if (!flags.solutionInputWorks) blockers.push('Solution input runtime behavior is not verified');
if (!flags.noLegacyCursorOverlayVisibleOnMathLivePath) blockers.push('legacy cursor overlay absence on MathLive path is not verified');
if (!flags.rollbackFlagWorks) blockers.push('rollback flag behavior is not verified');
if (!flags.protectedSurfacesUnchanged) blockers.push(`protected surfaces or Q113 policy files are not clean: ${[...protectedProblems, ...missingPolicyFiles].join('; ')}`);
if (!flags.cleanupCandidateFilesStillPresent) blockers.push('cleanup candidate/manual-review files are missing before approved cleanup evidence');
if (!flags.rollbackFilesPreserved) blockers.push('rollback files are not preserved');
if (!flags.dataPathFilesPreserved) blockers.push('shared editor/data-path files are not preserved');
if (!flags.packageHygieneClean) blockers.push('package hygiene is not clean');
if (!flags.noFakeEvidence) blockers.push('runtime/smoke/device evidence was faked');
if (!flags.explicitReleaseApprovalApproved) blockers.push('explicit post-cleanup release approval is missing');

const packageSideRegressionGuardReady = flags.protectedSurfacesUnchanged && flags.cleanupCandidateFilesStillPresent && flags.rollbackFilesPreserved && flags.dataPathFilesPreserved && flags.packageHygieneClean && flags.noFakeEvidence;
const evidenceCompleteForPostCleanupRegressionCourt = packageSideRegressionGuardReady && flags.q112ExecutionGuardPackageReady && flags.q112EvidenceCompleteForPhysicalCleanupExecution && flags.approvedCleanupActuallyExecuted && flags.cleanupDeltaManifestPresent && flags.flutterPubGetPassed && flags.flutterAnalyzePassed && flags.flutterTestPassed && flags.mathLiveLabRealDeviceRunPassed && flags.mainAppRealDeviceRunPassed && flags.q108RealDeviceCursorCourtPassed && flags.graphWorks && flags.historyWorks && flags.solutionInputWorks && flags.noLegacyCursorOverlayVisibleOnMathLivePath && flags.rollbackFlagWorks && flags.explicitReleaseApprovalApproved;
const status = evidenceCompleteForPostCleanupRegressionCourt
  ? 'POST_CLEANUP_REGRESSION_COURT_READY_FOR_RELEASE_REVIEW'
  : packageSideRegressionGuardReady
    ? 'POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_POST_CLEANUP_REGRESSION_COURT_GUARD';

const report = {
  phase: 'V172-Q113',
  status,
  packageSideRegressionGuardReady,
  evidenceCompleteForPostCleanupRegressionCourt,
  blockers,
  q112Run,
  q112ReportStatus: q112Report?.status ?? 'missing',
  q108ReportStatus: q108Report?.status ?? 'missing',
  cleanupCandidateCount: cleanupCandidates.length,
  manualReviewRequiredCount: manualReviewFiles.length,
  rollbackFileCount: rollbackFiles.length,
  dataPathFileCount: dataPathFiles.length,
  cleanupDeltaManifests,
  postCleanupRegressionExecutedInThisPackage: false,
  physicalCleanupAssumedCompleteInThisPackage: false,
  finalReleaseCandidateClaimAllowedInThisPackage: false,
  mayClaimPostCleanupPassNow: false,
  mayClaimCursorPassNow: false,
  mayClaimPhotomathWolframLevelNow: false,
  maySwitchMathLiveDefaultEditorNow: false,
  mayDeleteLegacyCursorNow: false,
  protectedUiSurfaceMutationAllowed: false,
  inputs: flags,
};

writeFileSync(join(reportDir, 'post_cleanup_regression_court_guard_report.json'), JSON.stringify(report, null, 2) + '\n');
writeFileSync(join(reportDir, 'post_cleanup_regression_court_guard_report.md'), `# V172-Q113 Post-Cleanup Regression Court Guard\n\nStatus: ${status}\n\nPackage-side regression guard ready: ${packageSideRegressionGuardReady}\n\nEvidence complete for post-cleanup regression court: ${evidenceCompleteForPostCleanupRegressionCourt}\n\nQ112 report status: ${report.q112ReportStatus}\n\n## Blockers\n${blockers.map((b) => `- ${b}`).join('\n') || '- none'}\n\n## Safety\n- postCleanupRegressionExecutedInThisPackage: false\n- physicalCleanupAssumedCompleteInThisPackage: false\n- finalReleaseCandidateClaimAllowedInThisPackage: false\n- mayClaimPostCleanupPassNow: false\n- mayClaimCursorPassNow: false\n- maySwitchMathLiveDefaultEditorNow: false\n- mayDeleteLegacyCursorNow: false\n- protectedUiSurfaceMutationAllowed: false\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(evidenceCompleteForPostCleanupRegressionCourt ? 0 : 2);
