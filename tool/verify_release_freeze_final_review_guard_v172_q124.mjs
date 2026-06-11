#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, readdirSync, statSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const root = process.cwd();
const reportDir = join(root, 'tool', 'reports');
mkdirSync(reportDir, { recursive: true });
const reportJson = join(reportDir, 'release_freeze_final_review_guard_v172_q124_report.json');
const reportMarkdown = join(reportDir, 'release_freeze_final_review_guard_v172_q124_report.md');

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

const requiredFiles = [
  'lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart',
  'tool/verify_release_freeze_final_review_guard_v172_q124.mjs',
  'test/v172_q124_release_freeze_final_review_guard_test.dart',
  'docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_AUDIT_REPORT.md',
  'docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_CHECKLIST.json',
  'tool/verify_legacy_cursor_post_cleanup_regression_court_guard_v172_q123.mjs',
];

const requiredMarkers = [
  ['lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart', "phase = 'V172-Q124'"],
  ['lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart', 'releaseFreezeFinalReviewGuardOnly = true'],
  ['lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart', 'finalReleaseFrozenInThisPackage = false'],
  ['lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart', 'releasePassClaimedInThisPackage = false'],
  ['lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart', 'legacyCursorPhysicalDeletionImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart', 'mathLiveDefaultSwitchImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart', 'Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_PACKAGE_READY_BUT_POST_CLEANUP_EVIDENCE_BLOCKED'],
  ['assets/mathlive/manifest.json', '"q124ReleaseFreezeFinalReviewGuardPhase": "V172-Q124"'],
  ['assets/mathlive/manifest.json', '"q124FinalReleaseFrozen": false'],
  ['assets/mathlive/manifest.json', '"q124ReleasePassClaimed": false'],
  ['assets/mathlive/manifest.json', '"q124LegacyCursorPhysicalDeletionImplemented": false'],
  ['assets/mathlive/manifest.json', '"q124MayDeleteLegacyCursor": false'],
  ['assets/mathlive/manifest.json', '"q124MayRetireLegacyMainPathNow": false'],
  ['assets/mathlive/manifest.json', '"q124MaySwitchDefaultEditorNow": false'],
  ['assets/mathlive/manifest.json', '"q124MayClaimReleasePass": false'],
  ['assets/mathlive/manifest.json', '"q124CreatesFakeRuntimeEvidence": false'],
  ['assets/mathlive/manifest.json', '"q124CreatesFakeDeviceEvidence": false'],
  ['lib/logic/mathpro_package_contract.dart', 'q124ReleaseFreezeFinalReviewGuardRule'],
  ['README.md', 'V172-Q124 — Release Freeze Final Review Guard'],
  ['docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_AUDIT_REPORT.md', 'Q124 is a release-freeze final review guard only; it does not freeze a release'],
  ['docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_CHANGED_FILES_MANIFEST.md', 'Protected files intentionally untouched'],
];

const forbiddenMarkers = [
  'finalReleaseFrozenInThisPackage = true',
  'releasePassClaimedInThisPackage = true',
  'postCleanupRegressionCourtExecutedInThisPackage = true',
  'physicalCleanupExecutedInThisPackage = true',
  'legacyCursorPhysicalDeletionImplementedInThisPackage = true',
  'legacyMainPathRetirementImplementedInThisPackage = true',
  'mathLiveDefaultSwitchImplementedInThisPackage = true',
  'mainWorkspaceMountImplementedInThisPackage = true',
  'runtimeGraphHistorySolutionWritesImplementedInThisPackage = true',
  'keyboardMutationAllowed = true',
  'moreMutationAllowed = true',
  'longPressMutationAllowed = true',
  'appShellMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'fakeRuntimeEvidenceAllowed = true',
  'fakeDeviceEvidenceAllowed = true',
  'fakeReleaseEvidenceAllowed = true',
  'cursorPassClaimAllowedInThisPackage = true',
  'releasePassClaimAllowedInThisPackage = true',
  '"q124FinalReleaseFrozen": true',
  '"q124ReleasePassClaimed": true',
  '"q124LegacyCursorPhysicalDeletionImplemented": true',
  '"q124MathLiveEnabledByDefault": true',
  '"q124MainWorkspaceMountImplemented": true',
  '"q124MayDeleteLegacyCursor": true',
  '"q124MayRetireLegacyMainPathNow": true',
  '"q124MaySwitchDefaultEditorNow": true',
  '"q124MayClaimCursorPass": true',
  '"q124MayClaimReleasePass": true',
  '"q124CreatesFakeRuntimeEvidence": true',
  '"q124CreatesFakeDeviceEvidence": true',
  '"q124CreatesFakeReleaseEvidence": true',
];

function fileExists(rel) { return existsSync(join(root, rel)); }
function read(rel) { try { return readFileSync(join(root, rel), 'utf8'); } catch { return ''; } }
function readJson(rel) { if (!fileExists(rel)) return null; try { return JSON.parse(read(rel)); } catch { return null; } }
function has(rel, marker) { return read(rel).includes(marker); }
function runNodeScript(script) {
  if (!fileExists(script)) return { script, exitCode: 127, status: 'MISSING_SCRIPT' };
  const result = spawnSync(process.execPath, [script], { cwd: root, encoding: 'utf8' });
  return { script, exitCode: result.status ?? 1, stdout: (result.stdout || '').trim(), stderr: (result.stderr || '').trim() };
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

const q123Run = runNodeScript('tool/verify_legacy_cursor_post_cleanup_regression_court_guard_v172_q123.mjs');
const q123Report = readJson('tool/reports/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_report.json');
const q123PackageReady = q123Report?.packageReady === true || (typeof q123Report?.status === 'string' && q123Report.status.includes('PACKAGE_READY'));
const q123PostCleanupRegressionEvidenceComplete = q123Report?.postCleanupRegressionEvidenceComplete === true;
const allFiles = listFiles(root);
const forbiddenArtifacts = allFiles.filter((p) =>
  p.endsWith('.zip') || p.endsWith('.apk') || p.endsWith('.aab') ||
  p.startsWith('build/') || p.startsWith('.dart_tool/') || p.startsWith('.gradle/') ||
  p.startsWith('.idea/') || p.includes('__pycache__/') || p.endsWith('.pyc') || p.endsWith('.tmp')
);

const blockers = [];
for (const rel of requiredFiles) if (!fileExists(rel)) blockers.push(`missing required Q124 file: ${rel}`);
for (const [rel, marker] of requiredMarkers) if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
const combined = [
  read('assets/mathlive/manifest.json'),
  read('lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart'),
  read('README.md'),
  read('docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_AUDIT_REPORT.md'),
].join('\n');
for (const marker of forbiddenMarkers) if (combined.includes(marker)) blockers.push(`forbidden enabled Q124 marker present: ${marker}`);
const protectedSurfacesUnchanged = protectedFiles.every((rel) => fileExists(rel) && !read(rel).includes('V172-Q124') && !read(rel).includes('q124ReleaseFreezeFinalReview'));
if (!protectedSurfacesUnchanged) blockers.push('protected surfaces changed or contain Q124 markers');
if (!q123PackageReady) blockers.push('Q123 post-cleanup regression court guard package is not ready');
if (forbiddenArtifacts.length) blockers.push(`forbidden build/cache/nested release artifacts found: ${forbiddenArtifacts.slice(0, 20).join('; ')}`);

const packageReady = blockers.length === 0;
const releaseFreezeFinalReviewEvidenceComplete = false;
const report = {
  phase: 'V172-Q124',
  status: packageReady
    ? 'Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_PACKAGE_READY_BUT_POST_CLEANUP_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD',
  packageReady,
  releaseFreezeFinalReviewEvidenceComplete,
  blockers,
  expectedPrimaryZipName: 'MathProFlutterPhase17.zip',
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  q123PackageReady,
  q123PostCleanupRegressionEvidenceComplete,
  q123Run,
  q123ReportStatus: q123Report?.status ?? null,
  forbiddenArtifacts,
  requiredEvidenceBeforeReleaseFreezeFinalReview: [
    'Q123 post-cleanup regression evidence complete',
    'Q123 human review approval',
    'flutter pub get PASS evidence',
    'flutter analyze PASS evidence',
    'flutter test PASS evidence',
    'MathLive Lab real-device evidence',
    'main app real-device evidence',
    'Q108/Q116 cursor court PASS evidence',
    'Graph runtime evidence',
    'History runtime evidence',
    'Solution runtime evidence',
    'rollback verification',
    'clean full ZIP verification',
    'fresh extract verification',
    'explicit Q124 release-freeze approval',
  ],
  invariants: {
    releaseFreezeFinalReviewGuardOnly: true,
    finalReleaseFrozenInThisPackage: false,
    releasePassClaimedInThisPackage: false,
    postCleanupRegressionCourtExecutedInThisPackage: false,
    physicalCleanupExecutedInThisPackage: false,
    legacyCursorPhysicalDeletionImplementedInThisPackage: false,
    legacyMainPathRetirementImplementedInThisPackage: false,
    mathLiveEnabledByDefault: false,
    mainWorkspaceMountImplemented: false,
    runtimeGraphHistorySolutionWritesImplemented: false,
    legacyRollbackRequired: true,
    protectedSurfacesUnchanged,
    mayOpenReleaseFreezeFinalReview: false,
    mayDeleteLegacyCursor: false,
    mayRetireLegacyMainPathNow: false,
    maySwitchDefaultEditorNow: false,
    mayClaimCursorPass: false,
    mayClaimReleasePass: false,
    createsFakeRuntimeEvidence: false,
    createsFakeDeviceEvidence: false,
    createsFakeReleaseEvidence: false,
  },
};
writeFileSync(reportJson, JSON.stringify(report, null, 2) + '\n');
writeFileSync(reportMarkdown, `# V172-Q124 Release Freeze Final Review Guard Report\n\n- Status: ${report.status}\n- Package ready: ${packageReady}\n- Release-freeze final review evidence complete: ${releaseFreezeFinalReviewEvidenceComplete}\n- May open release-freeze final review now: false\n- May claim release PASS: false\n- May delete legacy cursor now: false\n- Blockers: ${blockers.length ? blockers.join('; ') : 'none'}\n`);
console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
