#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const root = process.cwd();
const reportDir = join(root, 'tool', 'reports');
mkdirSync(reportDir, { recursive: true });
const reportJson = join(reportDir, 'legacy_cursor_physical_cleanup_planning_gate_report.json');
const reportMarkdown = join(reportDir, 'legacy_cursor_physical_cleanup_planning_gate_report.md');

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
  'lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart',
  'tool/verify_legacy_cursor_physical_cleanup_planning_gate.mjs',
  'test/v172_q121_legacy_cursor_physical_cleanup_planning_gate_test.dart',
  'docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_DRAFT.json',
  'docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_AUDIT_REPORT.md',
  'docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_CHANGED_FILES_MANIFEST.md',
];

const requiredMarkers = [
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart', "phase = 'V172-Q121'"],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart', 'planningGateOnly = true'],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart', 'physicalCleanupImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart', 'legacyCursorPhysicalDeletionImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart', 'Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'],
  ['assets/mathlive/manifest.json', '"q121LegacyCursorPhysicalCleanupPlanningGatePhase": "V172-Q121"'],
  ['assets/mathlive/manifest.json', '"q121PhysicalCleanupImplemented": false'],
  ['assets/mathlive/manifest.json', '"q121LegacyCursorPhysicalDeletionImplemented": false'],
  ['assets/mathlive/manifest.json', '"q121MayDeleteLegacyCursor": false'],
  ['assets/mathlive/manifest.json', '"q121MayRetireLegacyMainPathNow": false'],
  ['assets/mathlive/manifest.json', '"q121MaySwitchDefaultEditorNow": false'],
  ['assets/mathlive/manifest.json', '"q121CreatesFakeRuntimeEvidence": false'],
  ['assets/mathlive/manifest.json', '"q121CreatesFakeDeviceEvidence": false'],
  ['lib/logic/mathpro_package_contract.dart', 'q121LegacyCursorPhysicalCleanupPlanningGateRule'],
  ['README.md', 'V172-Q121 — Legacy Cursor Physical Cleanup Planning Gate'],
  ['docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_AUDIT_REPORT.md', 'Q121 is a planning gate only; it does not delete legacy cursor files'],
  ['docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_CHANGED_FILES_MANIFEST.md', 'Protected files intentionally untouched'],
];

const forbiddenMarkers = [
  'physicalCleanupImplementedInThisPackage = true',
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
  'fakePlanningApprovalAllowed = true',
  'cursorPassClaimAllowedInThisPackage = true',
  'releasePassClaimAllowedInThisPackage = true',
  '"q121PhysicalCleanupImplemented": true',
  '"q121LegacyCursorPhysicalDeletionImplemented": true',
  '"q121MathLiveEnabledByDefault": true',
  '"q121MainWorkspaceMountImplemented": true',
  '"q121MayDeleteLegacyCursor": true',
  '"q121MayRetireLegacyMainPathNow": true',
  '"q121MaySwitchDefaultEditorNow": true',
  '"q121MayClaimCursorPass": true',
  '"q121MayClaimReleasePass": true',
  '"q121CreatesFakeRuntimeEvidence": true',
  '"q121CreatesFakeDeviceEvidence": true',
  '"q121CreatesFakePlanningApproval": true',
];

function fileExists(rel) { return existsSync(join(root, rel)); }
function read(rel) { try { return readFileSync(join(root, rel), 'utf8'); } catch { return ''; } }
function readJson(rel) {
  if (!fileExists(rel)) return null;
  try { return JSON.parse(read(rel)); } catch { return null; }
}
function has(rel, marker) { return read(rel).includes(marker); }
function runNodeScript(script) {
  if (!fileExists(script)) return { script, exitCode: 127, status: 'MISSING_SCRIPT' };
  const result = spawnSync(process.execPath, [script], { cwd: root, encoding: 'utf8' });
  return { script, exitCode: result.status ?? 1, stdout: (result.stdout || '').trim(), stderr: (result.stderr || '').trim() };
}

const q120Run = runNodeScript('tool/verify_legacy_main_path_retirement_review_gate.mjs');
const q120Report = readJson('tool/reports/legacy_main_path_retirement_review_gate_report.json');
const q120PackageReady = q120Report?.packageReady === true || (typeof q120Report?.status === 'string' && q120Report.status.includes('PACKAGE_READY'));
const q120ReviewEvidenceComplete = q120Report?.reviewEvidenceComplete === true;
const planningDraft = readJson('docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_DRAFT.json');
const requiredCategories = [
  'mustKeepProtectedSurface',
  'mustKeepRollbackUntilPostCleanupRegression',
  'mustKeepSharedEditorDataPath',
  'cleanupCandidateAfterExplicitExecutionApproval',
  'manualReviewRequiredBeforeDeletion',
];
const categories = planningDraft?.categories ?? {};
const planningDraftHasRequiredCategories = requiredCategories.every((key) => Array.isArray(categories[key]));
const protectedSurfacesUnchanged = protectedFiles.every((rel) => fileExists(rel) && !read(rel).includes('V172-Q121') && !read(rel).includes('q121LegacyCursorPhysicalCleanupPlanning'));
const rollbackFiles = [
  'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
  'lib/features/editor_adapter/legacy_cursor_main_path_retirement_actual_gate_policy.dart',
  'lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart',
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
for (const rel of requiredFiles) if (!fileExists(rel)) blockers.push(`missing required Q121 file: ${rel}`);
for (const [rel, marker] of requiredMarkers) if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
const combined = [
  read('assets/mathlive/manifest.json'),
  read('lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart'),
  read('README.md'),
  read('docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_DRAFT.json'),
].join('\n');
for (const marker of forbiddenMarkers) if (combined.includes(marker)) blockers.push(`forbidden enabled Q121 marker present: ${marker}`);
if (!q120PackageReady) blockers.push('Q120 retirement review gate package is not ready');
if (planningDraft === null) blockers.push('Q121 planning draft JSON is missing or invalid');
if (!planningDraftHasRequiredCategories) blockers.push('Q121 planning draft categories are incomplete');
if (!protectedSurfacesUnchanged) blockers.push('protected surfaces changed or contain Q121 markers');
if (!rollbackFiles.every(fileExists)) blockers.push('legacy rollback files are not preserved');
if (!sharedEditorDataPathFiles.every(fileExists)) blockers.push('shared editor/data-path files are not preserved');
if (Array.isArray(planningDraft?.deletedFilesInThisPackage) && planningDraft.deletedFilesInThisPackage.length !== 0) blockers.push('Q121 planning draft records deleted files');

const packageReady = blockers.length === 0;
const planningEvidenceComplete = false;
const report = {
  phase: 'V172-Q121',
  status: packageReady
    ? 'Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE',
  packageReady,
  planningEvidenceComplete,
  blockers,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  q120PackageReady,
  q120ReviewEvidenceComplete,
  q120Run,
  q120ReportStatus: q120Report?.status ?? null,
  planningDraft: 'docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_DRAFT.json',
  planningCategoryCounts: Object.fromEntries(requiredCategories.map((key) => [key, Array.isArray(categories[key]) ? categories[key].length : 0])),
  requiredEvidenceBeforeCleanupExecutionReview: [
    'Q120 retirement review evidence complete',
    'Q120 human review approval',
    'explicit Q121 physical cleanup planning approval',
    'flutter analyze PASS evidence',
    'flutter test PASS evidence',
    'MathLive Lab real-device run evidence',
    'main app real-device run evidence',
    'Graph runtime evidence',
    'History runtime evidence',
    'Solution runtime evidence',
    'post-activation soak evidence',
    'protected surface hash verification',
    'legacy rollback availability',
  ],
  physicalCleanupImplementedInThisPackage: false,
  legacyCursorPhysicalDeletionImplementedInThisPackage: false,
  mayProceedToPhysicalCleanupExecutionReview: false,
  mayDeleteLegacyCursorNow: false,
  mayRetireLegacyMainPathNow: false,
  maySwitchDefaultEditorNow: false,
  mayMountMathLiveInMainWorkspaceNow: false,
  mayClaimCursorPass: false,
  mayClaimReleasePass: false,
  protectedSurfacesUntouchedByPolicy: true,
};

writeFileSync(reportJson, `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(reportMarkdown, `# V172-Q121 Legacy Cursor Physical Cleanup Planning Gate\n\nStatus: ${report.status}\n\nPackage ready: ${report.packageReady}\nPlanning evidence complete: ${report.planningEvidenceComplete}\n\nMay proceed to physical cleanup execution review: ${report.mayProceedToPhysicalCleanupExecutionReview}\nMay delete legacy cursor now: ${report.mayDeleteLegacyCursorNow}\nMay retire legacy main path now: ${report.mayRetireLegacyMainPathNow}\nMay switch default editor now: ${report.maySwitchDefaultEditorNow}\n\nPlanning draft: ${report.planningDraft}\n\nBlockers:\n${blockers.length ? blockers.map((b) => `- ${b}`).join('\n') : '- Evidence is intentionally incomplete until user-side runtime/device/human-review reports are provided.'}\n`);

if (!packageReady) {
  console.error(report.status);
  console.error(blockers.join('\n'));
  process.exit(1);
}
console.log(report.status);
