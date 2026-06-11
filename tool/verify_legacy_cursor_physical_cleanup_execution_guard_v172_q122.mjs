#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const root = process.cwd();
const reportDir = join(root, 'tool', 'reports');
mkdirSync(reportDir, { recursive: true });
const reportJson = join(reportDir, 'legacy_cursor_physical_cleanup_execution_guard_v172_q122_report.json');
const reportMarkdown = join(reportDir, 'legacy_cursor_physical_cleanup_execution_guard_v172_q122_report.md');

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
  'lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart',
  'tool/verify_legacy_cursor_physical_cleanup_execution_guard_v172_q122.mjs',
  'test/v172_q122_legacy_cursor_physical_cleanup_execution_guard_test.dart',
  'docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_AUDIT_REPORT.md',
  'docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_CHANGED_FILES_MANIFEST.md',
];
const requiredMarkers = [
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart', "phase = 'V172-Q122'"],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart', 'executionGuardOnly = true'],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart', 'physicalCleanupExecutedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart', 'legacyCursorPhysicalDeletionImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart', 'Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'],
  ['assets/mathlive/manifest.json', '"q122LegacyCursorPhysicalCleanupExecutionGuardPhase": "V172-Q122"'],
  ['assets/mathlive/manifest.json', '"q122PhysicalCleanupExecuted": false'],
  ['assets/mathlive/manifest.json', '"q122LegacyCursorPhysicalDeletionImplemented": false'],
  ['assets/mathlive/manifest.json', '"q122MayDeleteLegacyCursor": false'],
  ['assets/mathlive/manifest.json', '"q122MayRetireLegacyMainPathNow": false'],
  ['assets/mathlive/manifest.json', '"q122MaySwitchDefaultEditorNow": false'],
  ['assets/mathlive/manifest.json', '"q122CreatesFakeRuntimeEvidence": false'],
  ['assets/mathlive/manifest.json', '"q122CreatesFakeDeviceEvidence": false'],
  ['lib/logic/mathpro_package_contract.dart', 'q122LegacyCursorPhysicalCleanupExecutionGuardRule'],
  ['README.md', 'V172-Q122 — Legacy Cursor Physical Cleanup Execution Guard'],
  ['docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_AUDIT_REPORT.md', 'Q122 is an execution guard only; it does not delete legacy cursor files'],
  ['docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_CHANGED_FILES_MANIFEST.md', 'Protected files intentionally untouched'],
];
const forbiddenMarkers = [
  'physicalCleanupExecutedInThisPackage = true',
  'legacyCursorPhysicalDeletionImplementedInThisPackage = true',
  'legacyMainPathRetirementImplementedInThisPackage = true',
  'mathLiveDefaultSwitchImplementedInThisPackage = true',
  'mainWorkspaceMountImplementedInThisPackage = true',
  'keyboardMutationAllowed = true',
  'moreMutationAllowed = true',
  'longPressMutationAllowed = true',
  'appShellMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'fakeRuntimeEvidenceAllowed = true',
  'fakeDeviceEvidenceAllowed = true',
  'fakeExecutionApprovalAllowed = true',
  'cursorPassClaimAllowedInThisPackage = true',
  'releasePassClaimAllowedInThisPackage = true',
  '"q122PhysicalCleanupExecuted": true',
  '"q122LegacyCursorPhysicalDeletionImplemented": true',
  '"q122MathLiveEnabledByDefault": true',
  '"q122MainWorkspaceMountImplemented": true',
  '"q122MayDeleteLegacyCursor": true',
  '"q122MayRetireLegacyMainPathNow": true',
  '"q122MaySwitchDefaultEditorNow": true',
  '"q122MayClaimCursorPass": true',
  '"q122MayClaimReleasePass": true',
  '"q122CreatesFakeRuntimeEvidence": true',
  '"q122CreatesFakeDeviceEvidence": true',
  '"q122CreatesFakeExecutionApproval": true',
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
const q121Run = runNodeScript('tool/verify_legacy_cursor_physical_cleanup_planning_gate.mjs');
const q121Report = readJson('tool/reports/legacy_cursor_physical_cleanup_planning_gate_report.json');
const q121PackageReady = q121Report?.packageReady === true || (typeof q121Report?.status === 'string' && q121Report.status.includes('PACKAGE_READY'));
const q121PlanningEvidenceComplete = q121Report?.planningEvidenceComplete === true;
const rollbackFiles = [
  'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
  'lib/features/editor_adapter/legacy_cursor_main_path_retirement_actual_gate_policy.dart',
  'lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart',
  'lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart',
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
for (const rel of requiredFiles) if (!fileExists(rel)) blockers.push(`missing required Q122 file: ${rel}`);
for (const [rel, marker] of requiredMarkers) if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
const combined = [
  read('assets/mathlive/manifest.json'),
  read('lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart'),
  read('README.md'),
  read('docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_AUDIT_REPORT.md'),
].join('\n');
for (const marker of forbiddenMarkers) if (combined.includes(marker)) blockers.push(`forbidden enabled Q122 marker present: ${marker}`);
const protectedSurfacesUnchanged = protectedFiles.every((rel) => fileExists(rel) && !read(rel).includes('V172-Q122') && !read(rel).includes('q122LegacyCursorPhysicalCleanupExecution'));
if (!protectedSurfacesUnchanged) blockers.push('protected surfaces changed or contain Q122 markers');
if (!rollbackFiles.every(fileExists)) blockers.push('legacy rollback files are not preserved');
if (!sharedEditorDataPathFiles.every(fileExists)) blockers.push('shared editor/data-path files are not preserved');
if (!q121PackageReady) blockers.push('Q121 physical cleanup planning gate package is not ready');
const deletedFilesInThisPackage = [];
const packageReady = blockers.length === 0;
const executionEvidenceComplete = false;
const report = {
  phase: 'V172-Q122',
  status: packageReady
    ? 'Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD',
  packageReady,
  executionEvidenceComplete,
  blockers,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  q121PackageReady,
  q121PlanningEvidenceComplete,
  q121Run,
  q121ReportStatus: q121Report?.status ?? null,
  deletedFilesInThisPackage,
  requiredEvidenceBeforePhysicalCleanupExecution: [
    'Q121 cleanup planning evidence complete',
    'Q121 human review approval',
    'explicit Q122 physical cleanup execution approval',
    'flutter analyze PASS evidence',
    'flutter test PASS evidence',
    'MathLive Lab real-device run evidence',
    'main app real-device run evidence',
    'Graph runtime evidence',
    'History runtime evidence',
    'Solution runtime evidence',
    'post-activation soak evidence',
    'cleanup delta manifest prepared',
    'rollback verification',
  ],
  invariants: {
    physicalCleanupExecutedInThisPackage: false,
    legacyCursorPhysicalDeletionImplementedInThisPackage: false,
    legacyMainPathRetirementImplementedInThisPackage: false,
    mathLiveEnabledByDefault: false,
    mainWorkspaceMountImplemented: false,
    legacyRollbackRequired: true,
    protectedSurfacesUnchanged,
    mayDeleteLegacyCursor: false,
    mayRetireLegacyMainPathNow: false,
    maySwitchDefaultEditorNow: false,
    mayClaimCursorPass: false,
    mayClaimReleasePass: false,
    createsFakeRuntimeEvidence: false,
    createsFakeDeviceEvidence: false,
    createsFakeExecutionApproval: false,
  },
};
writeFileSync(reportJson, JSON.stringify(report, null, 2) + '\n');
writeFileSync(reportMarkdown, `# V172-Q122 Legacy Cursor Physical Cleanup Execution Guard Report

- Status: ${report.status}
- Package ready: ${packageReady}
- Execution evidence complete: ${executionEvidenceComplete}
- Deleted files in this package: 0
- May delete legacy cursor now: false
- May retire legacy main path now: false
- May switch default editor now: false
- Blockers: ${blockers.length ? blockers.join('; ') : 'none'}
`);
console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
