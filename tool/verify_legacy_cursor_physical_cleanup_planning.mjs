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

function listFiles(dir) {
  if (!existsSync(dir)) return [];
  const out = [];
  for (const name of readdirSync(dir)) {
    const full = join(dir, name);
    const st = statSync(full);
    if (st.isDirectory()) out.push(...listFiles(full));
    else out.push(relative(root, full).replaceAll('\\\\', '/'));
  }
  return out;
}

function hasAll(items) {
  return items.every((p) => existsSync(join(root, p)));
}

const q110Run = runNodeScript('tool/verify_legacy_cursor_main_path_retirement_actual_gate.mjs');
const q110Report = readJson(join(reportDir, 'legacy_cursor_main_path_retirement_actual_gate_report.json'));
const inventoryPath = 'docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json';
const inventory = readJson(join(root, inventoryPath));
const requiredCategories = [
  'mustKeepProtectedSurface',
  'mustKeepDataModelOrSharedEditorCore',
  'retainRollbackUntilPostActivation',
  'cleanupCandidateAfterQ112Review',
  'manualReviewRequiredBeforeDeletion',
];
const allLibDartFiles = listFiles(join(root, 'lib')).filter((p) => p.endsWith('.dart')).sort();
const inventoryCategories = inventory?.categories || {};
const inventoryHasRequiredCategories = requiredCategories.every((category) => Array.isArray(inventoryCategories[category]));
const deletedFilesInThisPackage = inventory?.deletedFilesInThisPackage || [];
const protectedSurfacesUnchanged = hasAll(protectedFiles) && protectedFiles.every((p) => !(readFileSync(join(root, p), 'utf8').includes('V172-Q111')));
const rollbackFiles = [
  'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
  'lib/features/editor_adapter/legacy_cursor_main_path_retirement_actual_gate_policy.dart',
  'lib/features/editor_adapter/legacy_cursor_physical_cleanup_policy.dart',
];
const dataPathFiles = [
  'lib/features/editor/math_node.dart',
  'lib/features/editor/node_factory.dart',
  'lib/features/editor/editor_commands.dart',
  'lib/features/editor/slot_registry.dart',
  'lib/features/editor/tex_serializer.dart',
  'lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart',
  'lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart',
  'lib/features/mathlive/mathlive_history_adapter_policy.dart',
  'lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart',
];
const flags = {
  q110RetirementGateReadyForReview: q110Report?.evidenceCompleteForLaterRetirementReview === true,
  q109ConditionalActivationReadyForReview: q110Report?.inputs?.q109ConditionalActivationReadyForReview === true,
  q108RealDeviceCursorCourtPassed: q110Report?.inputs?.q108RealDeviceCursorCourtPassed === true,
  flutterAnalyzePassed: q110Report?.inputs?.flutterAnalyzePassed === true,
  flutterTestPassed: q110Report?.inputs?.flutterTestPassed === true,
  inventoryManifestPresent: inventory !== null,
  inventoryHasRequiredCategories,
  protectedSurfacesUnchanged,
  rollbackFilesPreserved: hasAll(rollbackFiles),
  dataPathFilesPreserved: hasAll(dataPathFiles),
  noPhysicalDeletionAttempted: inventory?.actualPhysicalCleanupImplementedInThisPackage === false && inventory?.legacyCursorFileDeletionAllowedNow === false && inventory?.mayDeleteLegacyCursorNow === false && Array.isArray(deletedFilesInThisPackage) && deletedFilesInThisPackage.length === 0,
  noRuntimeBehaviorChange: true,
  noFakeEvidence: inventory?.fakeRuntimeEvidenceAllowed === false && inventory?.fakeSmokeEvidenceAllowed === false && inventory?.fakeDeviceEvidenceAllowed === false,
  manualReviewCompleted: false,
  explicitCleanupApprovalApproved: false,
};

const blockers = [];
if (!flags.q110RetirementGateReadyForReview) blockers.push('Q110 retirement gate is not ready for review');
if (!flags.q109ConditionalActivationReadyForReview) blockers.push('Q109 conditional activation is not ready for review');
if (!flags.q108RealDeviceCursorCourtPassed) blockers.push('Q108 real-device cursor court has not passed');
if (!flags.flutterAnalyzePassed) blockers.push('flutter analyze PASS evidence is missing');
if (!flags.flutterTestPassed) blockers.push('flutter test PASS evidence is missing');
if (!flags.inventoryManifestPresent) blockers.push('Q111 cleanup inventory manifest is missing');
if (!flags.inventoryHasRequiredCategories) blockers.push('Q111 cleanup inventory categories are incomplete');
if (!flags.protectedSurfacesUnchanged) blockers.push('protected UI surfaces changed or contain Q111 markers');
if (!flags.rollbackFilesPreserved) blockers.push('legacy rollback files are not preserved');
if (!flags.dataPathFilesPreserved) blockers.push('shared editor/data-path files are not preserved');
if (!flags.noPhysicalDeletionAttempted) blockers.push('Q111 attempted physical legacy cursor deletion');
if (!flags.noRuntimeBehaviorChange) blockers.push('Q111 attempted runtime editor behavior change');
if (!flags.noFakeEvidence) blockers.push('runtime/smoke/device evidence was faked');
if (!flags.manualReviewCompleted) blockers.push('manual cleanup inventory review is missing');
if (!flags.explicitCleanupApprovalApproved) blockers.push('explicit Q112 cleanup approval is missing');

const packageSidePlanningReady = flags.inventoryManifestPresent && flags.inventoryHasRequiredCategories && flags.protectedSurfacesUnchanged && flags.rollbackFilesPreserved && flags.dataPathFilesPreserved && flags.noPhysicalDeletionAttempted && flags.noRuntimeBehaviorChange && flags.noFakeEvidence;
const evidenceCompleteForCleanupExecutionReview = packageSidePlanningReady && flags.q110RetirementGateReadyForReview && flags.q109ConditionalActivationReadyForReview && flags.q108RealDeviceCursorCourtPassed && flags.flutterAnalyzePassed && flags.flutterTestPassed && flags.manualReviewCompleted && flags.explicitCleanupApprovalApproved;
const status = evidenceCompleteForCleanupExecutionReview
  ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_READY_FOR_EXPLICIT_Q112_REVIEW'
  : packageSidePlanningReady
    ? 'LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING';

const report = {
  phase: 'V172-Q111',
  status,
  packageSidePlanningReady,
  evidenceCompleteForCleanupExecutionReview,
  blockers,
  inventoryManifest: inventoryPath,
  inventoryCategoryCounts: Object.fromEntries(requiredCategories.map((category) => [category, Array.isArray(inventoryCategories[category]) ? inventoryCategories[category].length : 0])),
  libDartFileCount: allLibDartFiles.length,
  actualPhysicalCleanupImplementedInThisPackage: false,
  mayDeleteLegacyCursorNow: false,
  mayExecuteCleanupInLaterReviewedQ112: evidenceCompleteForCleanupExecutionReview,
  protectedUiSurfaceMutationAllowed: false,
  cursorPassClaimAllowedInThisPackage: false,
  q110Run,
  inputs: flags,
};

writeFileSync(join(reportDir, 'legacy_cursor_physical_cleanup_planning_report.json'), JSON.stringify(report, null, 2) + '\n');
writeFileSync(join(reportDir, 'legacy_cursor_physical_cleanup_planning_report.md'), `# V172-Q111 Legacy Cursor Physical Cleanup Planning\n\nStatus: ${status}\n\nPackage-side planning ready: ${packageSidePlanningReady}\n\nEvidence complete for Q112 cleanup execution review: ${evidenceCompleteForCleanupExecutionReview}\n\nInventory manifest: ${inventoryPath}\n\n## Inventory category counts\n${Object.entries(report.inventoryCategoryCounts).map(([k, v]) => `- ${k}: ${v}`).join('\n')}\n\n## Blockers\n${blockers.map((b) => `- ${b}`).join('\n') || '- none'}\n\n## Safety\n- actualPhysicalCleanupImplementedInThisPackage: false\n- mayDeleteLegacyCursorNow: false\n- protectedUiSurfaceMutationAllowed: false\n- cursorPassClaimAllowedInThisPackage: false\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(evidenceCompleteForCleanupExecutionReview ? 0 : 2);
