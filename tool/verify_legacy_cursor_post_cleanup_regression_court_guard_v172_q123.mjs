#!/usr/bin/env node
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { join, resolve } from 'node:path';
import { spawnSync } from 'node:child_process';

const root = resolve(process.cwd());
const reportDir = join(root, 'tool', 'reports');
mkdirSync(reportDir, { recursive: true });
const reportJson = join(reportDir, 'legacy_cursor_post_cleanup_regression_court_guard_v172_q123_report.json');
const reportMarkdown = join(reportDir, 'legacy_cursor_post_cleanup_regression_court_guard_v172_q123_report.md');

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
  'lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart',
  'tool/verify_legacy_cursor_post_cleanup_regression_court_guard_v172_q123.mjs',
  'test/v172_q123_post_cleanup_regression_court_guard_test.dart',
  'docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md',
  'docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_CHANGED_FILES_MANIFEST.md',
];

const requiredMarkers = [
  ['lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart', "phase = 'V172-Q123'"],
  ['lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart', 'postCleanupRegressionCourtGuardOnly = true'],
  ['lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart', 'postCleanupRegressionCourtExecutedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart', 'physicalCleanupExecutedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart', 'legacyCursorPhysicalDeletionImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart', 'releasePassClaimAllowedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart', 'Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_CLEANUP_EVIDENCE_BLOCKED'],
  ['assets/mathlive/manifest.json', '"q123PostCleanupRegressionCourtGuardPhase": "V172-Q123"'],
  ['assets/mathlive/manifest.json', '"q123PostCleanupRegressionCourtExecuted": false'],
  ['assets/mathlive/manifest.json', '"q123PhysicalCleanupExecuted": false'],
  ['assets/mathlive/manifest.json', '"q123LegacyCursorPhysicalDeletionImplemented": false'],
  ['assets/mathlive/manifest.json', '"q123MayDeleteLegacyCursor": false'],
  ['assets/mathlive/manifest.json', '"q123MayRetireLegacyMainPathNow": false'],
  ['assets/mathlive/manifest.json', '"q123MaySwitchDefaultEditorNow": false'],
  ['assets/mathlive/manifest.json', '"q123MayClaimReleasePass": false'],
  ['assets/mathlive/manifest.json', '"q123CreatesFakeRuntimeEvidence": false'],
  ['assets/mathlive/manifest.json', '"q123CreatesFakeDeviceEvidence": false'],
  ['lib/logic/mathpro_package_contract.dart', 'q123PostCleanupRegressionCourtGuardRule'],
  ['README.md', 'V172-Q123 — Post-Cleanup Regression Court Guard'],
  ['docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md', 'Q123 is a post-cleanup regression court guard only; it does not execute cleanup'],
  ['docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_CHANGED_FILES_MANIFEST.md', 'Protected files intentionally untouched'],
];

const forbiddenMarkers = [
  'postCleanupRegressionCourtExecutedInThisPackage = true',
  'physicalCleanupExecutedInThisPackage = true',
  'legacyCursorPhysicalDeletionImplementedInThisPackage = true',
  'legacyMainPathRetirementImplementedInThisPackage = true',
  'mathLiveDefaultSwitchImplementedInThisPackage = true',
  'mainWorkspaceMountImplementedInThisPackage = true',
  'runtimeGraphHistorySolutionWritesImplementedInThisPackage = true',
  'cleanupDeltaManifestGeneratedInThisPackage = true',
  'keyboardMutationAllowed = true',
  'moreMutationAllowed = true',
  'longPressMutationAllowed = true',
  'appShellMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'fakeRuntimeEvidenceAllowed = true',
  'fakeDeviceEvidenceAllowed = true',
  'fakeCleanupEvidenceAllowed = true',
  'cursorPassClaimAllowedInThisPackage = true',
  'releasePassClaimAllowedInThisPackage = true',
  '"q123PostCleanupRegressionCourtExecuted": true',
  '"q123PhysicalCleanupExecuted": true',
  '"q123LegacyCursorPhysicalDeletionImplemented": true',
  '"q123MathLiveEnabledByDefault": true',
  '"q123MainWorkspaceMountImplemented": true',
  '"q123MayDeleteLegacyCursor": true',
  '"q123MayRetireLegacyMainPathNow": true',
  '"q123MaySwitchDefaultEditorNow": true',
  '"q123MayClaimCursorPass": true',
  '"q123MayClaimReleasePass": true',
  '"q123CreatesFakeRuntimeEvidence": true',
  '"q123CreatesFakeDeviceEvidence": true',
  '"q123CreatesFakeCleanupEvidence": true',
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

const q122Run = runNodeScript('tool/verify_legacy_cursor_physical_cleanup_execution_guard_v172_q122.mjs');
const q122Report = readJson('tool/reports/legacy_cursor_physical_cleanup_execution_guard_v172_q122_report.json');
const q122PackageReady = q122Report?.packageReady === true || (typeof q122Report?.status === 'string' && q122Report.status.includes('PACKAGE_READY'));
const q122ExecutionEvidenceComplete = q122Report?.executionEvidenceComplete === true;

const rollbackFiles = [
  'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
  'lib/features/editor_adapter/legacy_cursor_main_path_retirement_actual_gate_policy.dart',
  'lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart',
  'lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart',
  'lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart',
];

const sharedEditorDataPathFiles = [
  'lib/features/editor/math_node.dart',
  'lib/features/editor/node_factory.dart',
  'lib/features/editor/editor_commands.dart',
  'lib/features/editor/slot_registry.dart',
  'lib/features/editor/tex_serializer.dart',
  'lib/features/formula_engine/slot_geometry_bundle_authority.dart',
  'lib/features/formula_engine/structural_cursor_release_hardening_policy.dart',
  'lib/features/workspace/editor_caret_overlay.dart',
];

const blockers = [];
for (const rel of requiredFiles) if (!fileExists(rel)) blockers.push(`missing required Q123 file: ${rel}`);
for (const [rel, marker] of requiredMarkers) if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
const combined = [
  read('assets/mathlive/manifest.json'),
  read('lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart'),
  read('README.md'),
  read('docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md'),
].join('\n');
for (const marker of forbiddenMarkers) if (combined.includes(marker)) blockers.push(`forbidden enabled Q123 marker present: ${marker}`);
const protectedSurfacesUnchanged = protectedFiles.every((rel) => fileExists(rel) && !read(rel).includes('V172-Q123') && !read(rel).includes('q123PostCleanupRegression'));
if (!protectedSurfacesUnchanged) blockers.push('protected surfaces changed or contain Q123 markers');
if (!rollbackFiles.every(fileExists)) blockers.push('legacy rollback files are not preserved');
if (!sharedEditorDataPathFiles.every(fileExists)) blockers.push('shared editor/data-path files are not preserved');
if (!q122PackageReady) blockers.push('Q122 physical cleanup execution guard package is not ready');

const deletedFilesInThisPackage = [];
const packageReady = blockers.length === 0;
const postCleanupRegressionEvidenceComplete = false;
const report = {
  phase: 'V172-Q123',
  status: packageReady
    ? 'Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_CLEANUP_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD',
  packageReady,
  postCleanupRegressionEvidenceComplete,
  blockers,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  q122PackageReady,
  q122ExecutionEvidenceComplete,
  q122Run,
  q122ReportStatus: q122Report?.status ?? null,
  deletedFilesInThisPackage,
  requiredEvidenceBeforePostCleanupRegressionCourt: [
    'Q122 cleanup execution evidence complete',
    'Q122 human review approval',
    'approved cleanup actually executed',
    'cleanup delta manifest present',
    'flutter pub get PASS evidence',
    'flutter analyze PASS evidence',
    'flutter test PASS evidence',
    'MathLive Lab real-device run evidence',
    'main app real-device run evidence',
    'Q108/Q116 real-device cursor court PASS evidence',
    'Graph runtime evidence',
    'History runtime evidence',
    'Solution runtime evidence',
    'legacy cursor overlay absence on MathLive path',
    'rollback verification',
    'explicit Q123 post-cleanup regression court approval',
  ],
  invariants: {
    postCleanupRegressionCourtExecutedInThisPackage: false,
    physicalCleanupExecutedInThisPackage: false,
    legacyCursorPhysicalDeletionImplementedInThisPackage: false,
    legacyMainPathRetirementImplementedInThisPackage: false,
    mathLiveEnabledByDefault: false,
    mainWorkspaceMountImplemented: false,
    runtimeGraphHistorySolutionWritesImplemented: false,
    legacyRollbackRequired: true,
    protectedSurfacesUnchanged,
    mayRunPostCleanupRegressionCourtReview: false,
    mayDeleteLegacyCursor: false,
    mayRetireLegacyMainPathNow: false,
    maySwitchDefaultEditorNow: false,
    mayClaimCursorPass: false,
    mayClaimReleasePass: false,
    createsFakeRuntimeEvidence: false,
    createsFakeDeviceEvidence: false,
    createsFakeCleanupEvidence: false,
  },
};
writeFileSync(reportJson, JSON.stringify(report, null, 2) + '\n');
writeFileSync(reportMarkdown, `# V172-Q123 Post-Cleanup Regression Court Guard Report

- Status: ${report.status}
- Package ready: ${packageReady}
- Post-cleanup regression evidence complete: ${postCleanupRegressionEvidenceComplete}
- Deleted files in this package: 0
- May run post-cleanup regression court review now: false
- May delete legacy cursor now: false
- May claim release PASS: false
- Blockers: ${blockers.length ? blockers.join('; ') : 'none'}
`);
console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
