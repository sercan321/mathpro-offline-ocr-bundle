#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, readdirSync, statSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const root = process.cwd();
const reportDir = join(root, 'tool', 'reports');
mkdirSync(reportDir, { recursive: true });
const reportJson = join(reportDir, 'final_package_evidence_closure_intake_guard_v172_q125_report.json');
const reportMarkdown = join(reportDir, 'final_package_evidence_closure_intake_guard_v172_q125_report.md');

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
  'lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart',
  'tool/verify_final_package_evidence_closure_intake_guard_v172_q125.mjs',
  'test/v172_q125_final_package_evidence_closure_intake_guard_test.dart',
  'docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_AUDIT_REPORT.md',
  'docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_CHECKLIST.json',
  'tool/verify_release_freeze_final_review_guard_v172_q124.mjs',
];

const requiredMarkers = [
  ['lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart', "phase = 'V172-Q125'"],
  ['lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart', 'finalPackageEvidenceClosureIntakeGuardOnly = true'],
  ['lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart', 'finalPackageEvidenceClosedInThisPackage = false'],
  ['lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart', 'releasePassClaimedInThisPackage = false'],
  ['lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart', 'legacyCursorPhysicalDeletionImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart', 'mathLiveDefaultSwitchImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart', 'Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_PACKAGE_READY_BUT_RELEASE_FREEZE_EVIDENCE_BLOCKED'],
  ['assets/mathlive/manifest.json', '"q125FinalPackageEvidenceClosureIntakeGuardPhase": "V172-Q125"'],
  ['assets/mathlive/manifest.json', '"q125FinalPackageEvidenceClosed": false'],
  ['assets/mathlive/manifest.json', '"q125ReleasePassClaimed": false'],
  ['assets/mathlive/manifest.json', '"q125LegacyCursorPhysicalDeletionImplemented": false'],
  ['assets/mathlive/manifest.json', '"q125MayDeleteLegacyCursor": false'],
  ['assets/mathlive/manifest.json', '"q125MayRetireLegacyMainPathNow": false'],
  ['assets/mathlive/manifest.json', '"q125MaySwitchDefaultEditorNow": false'],
  ['assets/mathlive/manifest.json', '"q125MayClaimReleasePass": false'],
  ['assets/mathlive/manifest.json', '"q125CreatesFakeRuntimeEvidence": false'],
  ['assets/mathlive/manifest.json', '"q125CreatesFakeDeviceEvidence": false'],
  ['assets/mathlive/manifest.json', '"q125CreatesFakeEvidenceClosure": false'],
  ['lib/logic/mathpro_package_contract.dart', 'q125FinalPackageEvidenceClosureIntakeGuardRule'],
  ['README.md', 'V172-Q125 — Final Package Evidence Closure Intake Guard'],
  ['docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_AUDIT_REPORT.md', 'Q125 is a final package evidence closure intake guard only; it does not close final package evidence'],
  ['docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_CHANGED_FILES_MANIFEST.md', 'Protected files intentionally untouched'],
];

const forbiddenMarkers = [
  'finalPackageEvidenceClosedInThisPackage = true',
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
  'fakeEvidenceClosureAllowed = true',
  'cursorPassClaimAllowedInThisPackage = true',
  'releasePassClaimAllowedInThisPackage = true',
  '"q125FinalPackageEvidenceClosed": true',
  '"q125ReleasePassClaimed": true',
  '"q125LegacyCursorPhysicalDeletionImplemented": true',
  '"q125MathLiveEnabledByDefault": true',
  '"q125MainWorkspaceMountImplemented": true',
  '"q125MayDeleteLegacyCursor": true',
  '"q125MayRetireLegacyMainPathNow": true',
  '"q125MaySwitchDefaultEditorNow": true',
  '"q125MayClaimCursorPass": true',
  '"q125MayClaimReleasePass": true',
  '"q125CreatesFakeRuntimeEvidence": true',
  '"q125CreatesFakeDeviceEvidence": true',
  '"q125CreatesFakeReleaseEvidence": true',
  '"q125CreatesFakeEvidenceClosure": true',
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

const q124Run = runNodeScript('tool/verify_release_freeze_final_review_guard_v172_q124.mjs');
const q124Report = readJson('tool/reports/release_freeze_final_review_guard_v172_q124_report.json');
const q124PackageReady = q124Report?.packageReady === true || (typeof q124Report?.status === 'string' && q124Report.status.includes('PACKAGE_READY'));
const q124ReleaseFreezeFinalReviewEvidenceComplete = q124Report?.releaseFreezeFinalReviewEvidenceComplete === true;
const allFiles = listFiles(root);
const forbiddenArtifacts = allFiles.filter((p) =>
  p.endsWith('.zip') || p.endsWith('.apk') || p.endsWith('.aab') ||
  p.startsWith('build/') || p.startsWith('.dart_tool/') || p.startsWith('.gradle/') ||
  p.startsWith('.idea/') || p.includes('__pycache__/') || p.endsWith('.pyc') || p.endsWith('.tmp')
);

const blockers = [];
for (const rel of requiredFiles) if (!fileExists(rel)) blockers.push(`missing required Q125 file: ${rel}`);
for (const [rel, marker] of requiredMarkers) if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
const combined = [
  read('assets/mathlive/manifest.json'),
  read('lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart'),
  read('README.md'),
  read('docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_AUDIT_REPORT.md'),
].join('\n');
for (const marker of forbiddenMarkers) if (combined.includes(marker)) blockers.push(`forbidden enabled Q125 marker present: ${marker}`);
const protectedSurfacesUnchanged = protectedFiles.every((rel) => fileExists(rel) && !read(rel).includes('V172-Q125') && !read(rel).includes('q125FinalPackageEvidenceClosure'));
if (!protectedSurfacesUnchanged) blockers.push('protected surfaces changed or contain Q125 markers');
if (!q124PackageReady) blockers.push('Q124 release-freeze final review guard package is not ready');
if (forbiddenArtifacts.length) blockers.push(`forbidden build/cache/nested release artifacts found: ${forbiddenArtifacts.slice(0, 20).join('; ')}`);

const packageReady = blockers.length === 0;
const finalPackageEvidenceClosureComplete = false;
const report = {
  phase: 'V172-Q125',
  status: packageReady
    ? 'Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_PACKAGE_READY_BUT_RELEASE_FREEZE_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD',
  packageReady,
  finalPackageEvidenceClosureComplete,
  blockers,
  expectedPrimaryZipName: 'MathProFlutterPhase17.zip',
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  q124PackageReady,
  q124ReleaseFreezeFinalReviewEvidenceComplete,
  q124Run,
  q124ReportStatus: q124Report?.status ?? null,
  forbiddenArtifacts,
  requiredEvidenceBeforeFinalPackageEvidenceClosure: [
    'Q124 release-freeze final review evidence complete',
    'Q124 human review approval',
    'Q124 explicit release-freeze approval',
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
    'final evidence ledger',
    'frozen defect ledger',
    'touched files manifest',
    'selected verifier reports',
    'explicit Q125 evidence-closure approval',
  ],
  invariants: {
    finalPackageEvidenceClosureIntakeGuardOnly: true,
    finalPackageEvidenceClosedInThisPackage: false,
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
    mayOpenFinalPackageEvidenceClosure: false,
    mayDeleteLegacyCursor: false,
    mayRetireLegacyMainPathNow: false,
    maySwitchDefaultEditorNow: false,
    mayClaimCursorPass: false,
    mayClaimReleasePass: false,
    createsFakeRuntimeEvidence: false,
    createsFakeDeviceEvidence: false,
    createsFakeReleaseEvidence: false,
    createsFakeEvidenceClosure: false,
  },
};
writeFileSync(reportJson, JSON.stringify(report, null, 2) + '\n');
writeFileSync(reportMarkdown, `# V172-Q125 Final Package Evidence Closure Intake Guard Report

- Status: ${report.status}
- Package ready: ${packageReady}
- Final package evidence closure complete: ${finalPackageEvidenceClosureComplete}
- May open final package evidence closure now: false
- May claim release PASS: false
- May delete legacy cursor now: false
- Blockers: ${blockers.length ? blockers.join('; ') : 'none'}
`);
console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
