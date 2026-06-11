#!/usr/bin/env node
import { existsSync, mkdirSync, readdirSync, readFileSync, statSync, writeFileSync } from 'node:fs';
import { join, relative } from 'node:path';
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

function readJson(path) {
  if (!existsSync(path)) return null;
  try { return JSON.parse(readFileSync(path, 'utf8')); } catch { return null; }
}

function runNodeScript(script) {
  if (!existsSync(join(root, script))) return { script, exitCode: 127, status: 'MISSING_SCRIPT' };
  const result = spawnSync(process.execPath, [script], { cwd: root, encoding: 'utf8' });
  return { script, exitCode: result.status ?? 1, stdout: (result.stdout || '').trim(), stderr: (result.stderr || '').trim() };
}

function hasAll(items) {
  return items.every((p) => existsSync(join(root, p)));
}

function categoryFiles(inventory, category) {
  const value = inventory?.categories?.[category];
  return Array.isArray(value) ? value : [];
}

const q111Run = runNodeScript('tool/verify_legacy_cursor_physical_cleanup_planning.mjs');
const q111Report = readJson(join(reportDir, 'legacy_cursor_physical_cleanup_planning_report.json'));
const inventoryPath = 'docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json';
const inventory = readJson(join(root, inventoryPath));
const requiredCategories = [
  'mustKeepProtectedSurface',
  'mustKeepDataModelOrSharedEditorCore',
  'retainRollbackUntilPostActivation',
  'cleanupCandidateAfterQ112Review',
  'manualReviewRequiredBeforeDeletion',
];
const inventoryCategories = inventory?.categories || {};
const inventoryCategoriesComplete = requiredCategories.every((category) => Array.isArray(inventoryCategories[category]));
const cleanupCandidates = categoryFiles(inventory, 'cleanupCandidateAfterQ112Review');
const manualReviewRequired = categoryFiles(inventory, 'manualReviewRequiredBeforeDeletion');
const rollbackFiles = categoryFiles(inventory, 'retainRollbackUntilPostActivation');
const dataPathFiles = categoryFiles(inventory, 'mustKeepDataModelOrSharedEditorCore');
const protectedInventoryFiles = categoryFiles(inventory, 'mustKeepProtectedSurface');
const deletedFilesInThisPackage = inventory?.deletedFilesInThisPackage || [];

const protectedSurfacesUnchanged = hasAll(protectedFiles) && hasAll(protectedInventoryFiles) && protectedFiles.every((p) => !(readFileSync(join(root, p), 'utf8').includes('V172-Q112')));
const cleanupCandidatesClassified = cleanupCandidates.length > 0 && manualReviewRequired.length > 0;
const cleanupCandidateFilesStillPresent = hasAll(cleanupCandidates) && hasAll(manualReviewRequired);

const flags = {
  q111PlanningPackageReady: q111Report?.packageSidePlanningReady === true,
  q111EvidenceCompleteForCleanupExecutionReview: q111Report?.evidenceCompleteForCleanupExecutionReview === true,
  q110RetirementGateReadyForReview: q111Report?.inputs?.q110RetirementGateReadyForReview === true,
  q109ConditionalActivationReadyForReview: q111Report?.inputs?.q109ConditionalActivationReadyForReview === true,
  q108RealDeviceCursorCourtPassed: q111Report?.inputs?.q108RealDeviceCursorCourtPassed === true,
  flutterAnalyzePassed: q111Report?.inputs?.flutterAnalyzePassed === true,
  flutterTestPassed: q111Report?.inputs?.flutterTestPassed === true,
  postActivationSoakPassed: false,
  inventoryManifestPresent: inventory !== null,
  inventoryCategoriesComplete,
  cleanupCandidatesClassified,
  cleanupCandidateFilesStillPresent,
  protectedSurfacesUnchanged,
  rollbackFilesPreserved: hasAll(rollbackFiles),
  dataPathFilesPreserved: hasAll(dataPathFiles),
  noPhysicalDeletionAttempted: inventory?.actualPhysicalCleanupImplementedInThisPackage === false && inventory?.legacyCursorFileDeletionAllowedNow === false && inventory?.mayDeleteLegacyCursorNow === false && Array.isArray(deletedFilesInThisPackage) && deletedFilesInThisPackage.length === 0,
  noRuntimeBehaviorChange: true,
  noFakeEvidence: inventory?.fakeRuntimeEvidenceAllowed === false && inventory?.fakeSmokeEvidenceAllowed === false && inventory?.fakeDeviceEvidenceAllowed === false,
  manualInventoryReviewCompleted: false,
  explicitQ112CleanupApprovalApproved: false,
};

const blockers = [];
if (!flags.q111PlanningPackageReady) blockers.push('Q111 physical cleanup planning package is not ready');
if (!flags.q111EvidenceCompleteForCleanupExecutionReview) blockers.push('Q111 evidence is not complete for cleanup execution review');
if (!flags.q110RetirementGateReadyForReview) blockers.push('Q110 retirement gate is not ready for review');
if (!flags.q109ConditionalActivationReadyForReview) blockers.push('Q109 conditional activation is not ready for review');
if (!flags.q108RealDeviceCursorCourtPassed) blockers.push('Q108 real-device cursor court has not passed');
if (!flags.flutterAnalyzePassed) blockers.push('flutter analyze PASS evidence is missing');
if (!flags.flutterTestPassed) blockers.push('flutter test PASS evidence is missing');
if (!flags.postActivationSoakPassed) blockers.push('post-activation soak evidence is missing');
if (!flags.inventoryManifestPresent) blockers.push('Q111 inventory manifest is missing');
if (!flags.inventoryCategoriesComplete) blockers.push('Q111 inventory categories are incomplete');
if (!flags.cleanupCandidatesClassified) blockers.push('cleanup candidates are not classified');
if (!flags.cleanupCandidateFilesStillPresent) blockers.push('cleanup candidate or manual-review files were already deleted');
if (!flags.protectedSurfacesUnchanged) blockers.push('protected UI surfaces changed or contain Q112 markers');
if (!flags.rollbackFilesPreserved) blockers.push('legacy rollback files are not preserved');
if (!flags.dataPathFilesPreserved) blockers.push('shared editor/data-path files are not preserved');
if (!flags.noPhysicalDeletionAttempted) blockers.push('Q112 attempted physical legacy cursor deletion');
if (!flags.noRuntimeBehaviorChange) blockers.push('Q112 attempted runtime editor behavior change');
if (!flags.noFakeEvidence) blockers.push('runtime/smoke/device evidence was faked');
if (!flags.manualInventoryReviewCompleted) blockers.push('manual Q111 inventory review is missing');
if (!flags.explicitQ112CleanupApprovalApproved) blockers.push('explicit Q112 cleanup approval is missing');

const packageSideExecutionGuardReady = flags.inventoryManifestPresent && flags.inventoryCategoriesComplete && flags.cleanupCandidatesClassified && flags.cleanupCandidateFilesStillPresent && flags.protectedSurfacesUnchanged && flags.rollbackFilesPreserved && flags.dataPathFilesPreserved && flags.noPhysicalDeletionAttempted && flags.noRuntimeBehaviorChange && flags.noFakeEvidence;
const evidenceCompleteForPhysicalCleanupExecution = packageSideExecutionGuardReady && flags.q111PlanningPackageReady && flags.q111EvidenceCompleteForCleanupExecutionReview && flags.q110RetirementGateReadyForReview && flags.q109ConditionalActivationReadyForReview && flags.q108RealDeviceCursorCourtPassed && flags.flutterAnalyzePassed && flags.flutterTestPassed && flags.postActivationSoakPassed && flags.manualInventoryReviewCompleted && flags.explicitQ112CleanupApprovalApproved;
const status = evidenceCompleteForPhysicalCleanupExecution
  ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_READY_FOR_SEPARATE_APPROVED_PACKAGE'
  : packageSideExecutionGuardReady
    ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD';

const report = {
  phase: 'V172-Q112',
  status,
  packageSideExecutionGuardReady,
  evidenceCompleteForPhysicalCleanupExecution,
  blockers,
  q111InventoryManifest: inventoryPath,
  cleanupCandidateCount: cleanupCandidates.length,
  manualReviewRequiredCount: manualReviewRequired.length,
  rollbackFileCount: rollbackFiles.length,
  dataPathFileCount: dataPathFiles.length,
  protectedFileCount: protectedFiles.length,
  physicalCleanupExecutionImplementedInThisPackage: false,
  actualPhysicalCleanupImplementedInThisPackage: false,
  legacyCursorFileDeletionAllowedNow: false,
  mayDeleteLegacyCursorNow: false,
  mayExecuteCleanupInThisPackage: false,
  mayExecuteCleanupInSeparateApprovedPackage: evidenceCompleteForPhysicalCleanupExecution,
  protectedUiSurfaceMutationAllowed: false,
  cursorPassClaimAllowedInThisPackage: false,
  q111Run,
  inputs: flags,
};

writeFileSync(join(reportDir, 'legacy_cursor_physical_cleanup_execution_guard_report.json'), JSON.stringify(report, null, 2) + '\n');
writeFileSync(join(reportDir, 'legacy_cursor_physical_cleanup_execution_guard_report.md'), `# V172-Q112 Legacy Cursor Physical Cleanup Execution Guard\n\nStatus: ${status}\n\nPackage-side execution guard ready: ${packageSideExecutionGuardReady}\n\nEvidence complete for physical cleanup execution: ${evidenceCompleteForPhysicalCleanupExecution}\n\nQ111 inventory manifest: ${inventoryPath}\n\n## Inventory counts\n- cleanupCandidateAfterQ112Review: ${cleanupCandidates.length}\n- manualReviewRequiredBeforeDeletion: ${manualReviewRequired.length}\n- retainRollbackUntilPostActivation: ${rollbackFiles.length}\n- mustKeepDataModelOrSharedEditorCore: ${dataPathFiles.length}\n\n## Blockers\n${blockers.map((b) => `- ${b}`).join('\n') || '- none'}\n\n## Safety\n- physicalCleanupExecutionImplementedInThisPackage: false\n- mayDeleteLegacyCursorNow: false\n- mayExecuteCleanupInThisPackage: false\n- protectedUiSurfaceMutationAllowed: false\n- cursorPassClaimAllowedInThisPackage: false\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(evidenceCompleteForPhysicalCleanupExecution ? 0 : 2);
