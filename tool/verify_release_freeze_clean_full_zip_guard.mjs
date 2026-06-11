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

const requiredQ114Files = [
  'lib/features/editor_adapter/release_freeze_clean_full_zip_guard_policy.dart',
  'tool/verify_release_freeze_clean_full_zip_guard.mjs',
  'test/v172_q114_release_freeze_clean_full_zip_guard_test.dart',
  'docs/audit/V172_Q114_RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_AUDIT_REPORT.md',
  'docs/audit/V172_Q114_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q114_RELEASE_FREEZE_CHECKLIST.json',
  'tool/verify_post_cleanup_regression_court_guard.mjs',
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
    else out.push(p.slice(root.length + 1).replaceAll('\\', '/'));
  }
  return out;
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

function protectedSurfacesClean() {
  const problems = [];
  for (const file of protectedFiles) {
    const path = join(root, file);
    if (!existsSync(path)) {
      problems.push(`${file} missing`);
      continue;
    }
    const text = readFileSync(path, 'utf8');
    if (text.includes('V172-Q114') || text.includes('releaseFreezeCleanFullZipGuard')) {
      problems.push(`${file} contains Q114 marker`);
    }
  }
  return problems;
}

const q113Run = runNode('tool/verify_post_cleanup_regression_court_guard.mjs');
const q113Report = readJson(join(reportDir, 'post_cleanup_regression_court_guard_report.json'));
const checklist = readJson(join(root, 'docs/audit/V172_Q114_RELEASE_FREEZE_CHECKLIST.json'));
const allFiles = listFiles(root);
const missingQ114Files = requiredQ114Files.filter((p) => !existsSync(join(root, p)));
const protectedProblems = protectedSurfacesClean();
const forbiddenNestedArtifacts = allFiles.filter((p) => p.endsWith('.zip') || p.endsWith('.apk') || p.endsWith('.aab') || p.startsWith('build/') || p.startsWith('.dart_tool/') || p.startsWith('.gradle/') || p.includes('__pycache__/') || p.endsWith('.pyc') || p.endsWith('.tmp'));
const packageHygieneClean = forbiddenNestedArtifacts.length === 0;

const flags = {
  q113PostCleanupRegressionCourtReady: q113Report?.evidenceCompleteForPostCleanupRegressionCourt === true,
  q113GuardPackageReady: q113Report?.packageSideRegressionGuardReady === true,
  flutterPubGetPassed: q113Report?.inputs?.flutterPubGetPassed === true,
  flutterAnalyzePassed: q113Report?.inputs?.flutterAnalyzePassed === true,
  flutterTestPassed: q113Report?.inputs?.flutterTestPassed === true,
  mathLiveLabRealDeviceRunPassed: q113Report?.inputs?.mathLiveLabRealDeviceRunPassed === true,
  mainAppRealDeviceRunPassed: q113Report?.inputs?.mainAppRealDeviceRunPassed === true,
  graphHistorySolutionRuntimeVerified: q113Report?.inputs?.graphWorks === true && q113Report?.inputs?.historyWorks === true && q113Report?.inputs?.solutionInputWorks === true,
  rollbackVerified: q113Report?.inputs?.rollbackFlagWorks === true,
  protectedSurfacesUnchanged: protectedProblems.length === 0 && missingQ114Files.length === 0,
  zipIntegrityVerified: checklist?.zipIntegrityVerified === true,
  freshExtractVerified: checklist?.freshExtractVerified === true,
  packageHygieneClean,
  noStaleArchivesInsidePackage: forbiddenNestedArtifacts.filter((p) => p.endsWith('.zip') || p.endsWith('.apk') || p.endsWith('.aab')).length === 0,
  noPatchOnlyDelivery: checklist?.expectedDeliveryZipName === 'MathProFlutterPhase17.zip' && checklist?.patchOnlyDeliveryAllowed === false,
  finalAuditDocsPresent: existsSync(join(root, 'docs/audit/V172_Q114_RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_AUDIT_REPORT.md')) && existsSync(join(root, 'docs/audit/V172_Q114_CHANGED_FILES_MANIFEST.md')),
  noFakeEvidence: checklist?.fakeRuntimeEvidenceAllowed === false && checklist?.fakeSmokeEvidenceAllowed === false && checklist?.fakeDeviceEvidenceAllowed === false,
  explicitReleaseFreezeApproval: checklist?.explicitReleaseFreezeApproval === true,
};

const blockers = [];
if (!flags.q113PostCleanupRegressionCourtReady) blockers.push('Q113 post-cleanup regression court is not ready for release review');
if (!flags.q113GuardPackageReady) blockers.push('Q113 package-side guard is not ready');
if (!flags.flutterPubGetPassed) blockers.push('flutter pub get PASS evidence is missing');
if (!flags.flutterAnalyzePassed) blockers.push('flutter analyze PASS evidence is missing');
if (!flags.flutterTestPassed) blockers.push('flutter test PASS evidence is missing');
if (!flags.mathLiveLabRealDeviceRunPassed) blockers.push('MathLive Lab real-device PASS evidence is missing');
if (!flags.mainAppRealDeviceRunPassed) blockers.push('main app real-device PASS evidence is missing');
if (!flags.graphHistorySolutionRuntimeVerified) blockers.push('Graph/History/Solution runtime verification is missing');
if (!flags.rollbackVerified) blockers.push('rollback verification is missing');
if (!flags.protectedSurfacesUnchanged) blockers.push(`protected/Q114 files are not clean: ${[...protectedProblems, ...missingQ114Files].join('; ')}`);
if (!flags.zipIntegrityVerified) blockers.push('final ZIP integrity verification is missing');
if (!flags.freshExtractVerified) blockers.push('fresh extract verification is missing');
if (!flags.packageHygieneClean) blockers.push(`package hygiene is not clean: ${forbiddenNestedArtifacts.slice(0, 20).join('; ')}`);
if (!flags.noStaleArchivesInsidePackage) blockers.push('stale nested archive/APK/AAB artifact is present inside package');
if (!flags.noPatchOnlyDelivery) blockers.push('delivery is patch-only or expected full ZIP name is not locked');
if (!flags.finalAuditDocsPresent) blockers.push('final release-freeze audit documents are missing');
if (!flags.noFakeEvidence) blockers.push('runtime/smoke/device evidence was faked');
if (!flags.explicitReleaseFreezeApproval) blockers.push('explicit release-freeze approval is missing');

const packageSideReleaseFreezeGuardReady = flags.q113GuardPackageReady && flags.protectedSurfacesUnchanged && flags.packageHygieneClean && flags.noStaleArchivesInsidePackage && flags.noPatchOnlyDelivery && flags.finalAuditDocsPresent && flags.noFakeEvidence;
const evidenceCompleteForReleaseFreezeReview = packageSideReleaseFreezeGuardReady && flags.q113PostCleanupRegressionCourtReady && flags.flutterPubGetPassed && flags.flutterAnalyzePassed && flags.flutterTestPassed && flags.mathLiveLabRealDeviceRunPassed && flags.mainAppRealDeviceRunPassed && flags.graphHistorySolutionRuntimeVerified && flags.rollbackVerified && flags.zipIntegrityVerified && flags.freshExtractVerified && flags.explicitReleaseFreezeApproval;
const status = evidenceCompleteForReleaseFreezeReview
  ? 'RELEASE_FREEZE_CLEAN_FULL_ZIP_READY_FOR_FINAL_APPROVAL'
  : packageSideReleaseFreezeGuardReady
    ? 'RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD';

const report = {
  phase: 'V172-Q114',
  status,
  packageSideReleaseFreezeGuardReady,
  evidenceCompleteForReleaseFreezeReview,
  blockers,
  q113Run,
  q113ReportStatus: q113Report?.status ?? 'missing',
  expectedDeliveryZipName: 'MathProFlutterPhase17.zip',
  releaseFrozenInThisPackage: false,
  finalReleasePassClaimAllowedInThisPackage: false,
  cleanFullZipClaimAllowedWithoutFreshExtract: false,
  patchOnlyDeliveryAllowed: false,
  maySwitchMathLiveDefaultEditorNow: false,
  mayDeleteLegacyCursorNow: false,
  protectedUiSurfaceMutationAllowed: false,
  fakeRuntimeEvidenceAllowed: false,
  fakeSmokeEvidenceAllowed: false,
  fakeDeviceEvidenceAllowed: false,
  forbiddenNestedArtifacts,
  protectedProblems,
  missingQ114Files,
  inputs: flags,
};

writeFileSync(join(reportDir, 'release_freeze_clean_full_zip_guard_report.json'), JSON.stringify(report, null, 2) + '\n');
writeFileSync(join(reportDir, 'release_freeze_clean_full_zip_guard_report.md'), `# V172-Q114 Release Freeze / Clean Full ZIP Guard\n\nStatus: ${status}\n\nPackage-side release-freeze guard ready: ${packageSideReleaseFreezeGuardReady}\n\nEvidence complete for release-freeze review: ${evidenceCompleteForReleaseFreezeReview}\n\nExpected delivery ZIP: MathProFlutterPhase17.zip\n\nQ113 report status: ${report.q113ReportStatus}\n\n## Blockers\n${blockers.map((b) => `- ${b}`).join('\n') || '- none'}\n\n## Safety\n- releaseFrozenInThisPackage: false\n- finalReleasePassClaimAllowedInThisPackage: false\n- cleanFullZipClaimAllowedWithoutFreshExtract: false\n- patchOnlyDeliveryAllowed: false\n- maySwitchMathLiveDefaultEditorNow: false\n- mayDeleteLegacyCursorNow: false\n- protectedUiSurfaceMutationAllowed: false\n- fakeRuntimeEvidenceAllowed: false\n- fakeSmokeEvidenceAllowed: false\n- fakeDeviceEvidenceAllowed: false\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(evidenceCompleteForReleaseFreezeReview ? 0 : 2);
