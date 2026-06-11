#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_main_workspace_mount_flag.mjs', retiredPhase: 'verify_mathlive_main_workspace_mount_flag', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

/*
 * V172-Q106 Main Workspace MathLive Mount Behind Internal Flag verifier.
 *
 * Offline/package-side only. It verifies the mount-readiness contract for a
 * future MathLive main-workspace surface behind an explicit internal flag while
 * keeping AppShell, keyboard, Graph/History/Solution UI, and legacy cursor files
 * untouched. It must remain runtime-evidence BLOCKED until Q101 evidence and
 * official runtime verification are real.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_main_workspace_mount_flag_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_main_workspace_mount_flag_report.md');

function rel(absolutePath) {
  return path.relative(projectRoot, absolutePath).replaceAll(path.sep, '/');
}

function readText(relativePath) {
  const absolutePath = path.join(projectRoot, relativePath);
  return existsSync(absolutePath) ? readFileSync(absolutePath, 'utf8') : '';
}

function parseJsonFile(relativePath) {
  const text = readText(relativePath);
  if (!text.trim()) return null;
  try {
    return JSON.parse(text);
  } catch {
    return null;
  }
}

function buildMountPlan({ requestedEngine, explicitInternalFlagEnabled, q101Closed, q105PackageReady, officialRuntimeVerified }) {
  const blockers = [];
  if (!q101Closed) blockers.push('Q101 Lab smoke evidence closure has not passed; Q106 runtime mount must remain blocked');
  if (!q105PackageReady) blockers.push('Q105 Solution/Evaluator adapter is not package-ready');
  if (!explicitInternalFlagEnabled) blockers.push('explicit internal MathLive editor flag is not enabled');
  if (!officialRuntimeVerified) blockers.push('official local MathLive runtime is not verified');
  const packageSideMountFlagReady = q105PackageReady;
  const mayMountBehindInternalFlagAtRuntime = packageSideMountFlagReady && q101Closed && explicitInternalFlagEnabled && officialRuntimeVerified;
  return {
    phase: 'V172-Q106',
    requestedEngine,
    selectedEngine: requestedEngine === 'mathlive' && mayMountBehindInternalFlagAtRuntime ? 'mathlive' : 'legacyFlutterSlotEditor',
    internalFlagName: 'mathpro.internal.editorEngine.mathlive',
    explicitInternalFlagEnabled,
    packageSideMountFlagReady,
    mayMountBehindInternalFlagAtRuntime,
    runtimeMountAllowed: mayMountBehindInternalFlagAtRuntime,
    mathLiveEnabledByDefault: false,
    defaultEditorSwitchAllowed: false,
    legacyRollbackAvailable: true,
    appShellMutationAllowed: false,
    keyboardMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    legacyCursorDeletionAllowed: false,
    cursorPassClaimAllowed: false,
    blockers,
  };
}

mkdirSync(reportDir, { recursive: true });
const blockers = [];
const requiredFiles = [
  'lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart',
  'tool/verify_mathlive_main_workspace_mount_flag.mjs',
  'test/v172_q106_main_workspace_mount_flag_test.dart',
  'docs/audit/V172_Q106_MAIN_WORKSPACE_MOUNT_FLAG_AUDIT_REPORT.md',
  'docs/audit/V172_Q106_CHANGED_FILES_MANIFEST.md',
  'lib/features/mathlive/mathlive_main_editor_flag_activation_policy.dart',
  'lib/features/mathlive/mathlive_lab_smoke_evidence_closure_policy.dart',
  'lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart',
  'lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart',
  'lib/logic/mathpro_package_contract.dart',
  'assets/mathlive/manifest.json',
  'README.md',
];
for (const file of requiredFiles) {
  if (!existsSync(path.join(projectRoot, file))) blockers.push(`missing required file: ${file}`);
}

const policy = readText('lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart');
const q93 = readText('lib/features/mathlive/mathlive_main_editor_flag_activation_policy.dart');
const q105 = readText('lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart');
const manifest = readText('assets/mathlive/manifest.json');
const contract = readText('lib/logic/mathpro_package_contract.dart');
const readme = readText('README.md');
const audit = readText('docs/audit/V172_Q106_MAIN_WORKSPACE_MOUNT_FLAG_AUDIT_REPORT.md');
const changed = readText('docs/audit/V172_Q106_CHANGED_FILES_MANIFEST.md');
const appShell = readText('lib/app/app_shell.dart');
const keyConfig = readText('lib/features/keyboard/key_config.dart');
const graphCard = readText('lib/features/graph/graph_card.dart');
const historyController = readText('lib/features/history/history_controller.dart');
const solutionPanel = readText('lib/features/solution/solution_steps_panel.dart');

const requiredMarkers = [
  [policy, "phase = 'V172-Q106'"],
  [policy, 'mountReadinessContractImplemented = true'],
  [policy, 'mainWorkspaceMountImplementedInThisPackage = false'],
  [policy, 'q93FlagContractRequired = true'],
  [policy, 'q101LabSmokeEvidenceClosureRequired = true'],
  [policy, 'q105SolutionEvaluatorCandidateAdapterRequired = true'],
  [policy, 'explicitInternalFlagRequired = true'],
  [policy, 'appShellMutationAllowed = false'],
  [policy, 'keyboardMutationAllowed = false'],
  [policy, 'graphHistorySolutionUiMutationAllowed = false'],
  [policy, 'legacyCursorDeletionAllowed = false'],
  [policy, 'runtimeMountAllowedWithoutQ101 = false'],
  [q93, "flagName = 'mathpro.internal.editorEngine.mathlive'"],
  [q105, 'packageSideSolutionEvaluatorAdapterImplemented = true'],
  [manifest, '"q106MainWorkspaceMountFlagPhase": "V172-Q106"'],
  [manifest, '"q106MainWorkspaceMountImplementedInThisPackage": false'],
  [manifest, '"q106RequiresExplicitInternalFlag": true'],
  [manifest, '"q106RequiresQ101LabSmokeEvidenceClosure": true'],
  [manifest, '"q106MayMutateAppShell": false'],
  [manifest, '"q106MayMutateKeyboard": false'],
  [manifest, '"q106MaySwitchDefaultEditor": false'],
  [manifest, '"q106MayDeleteLegacyCursor": false'],
  [contract, 'q106MainWorkspaceMathLiveMountFlagRule'],
  [readme, 'V172-Q106 Main Workspace MathLive Mount Behind Internal Flag'],
  [audit, 'Q106 adds MathLive main-workspace mount readiness behind an explicit internal flag'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) blockers.push(`missing marker: ${marker}`);
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'mainWorkspaceMountImplementedInThisPackage = true',
  'mathLiveEnabledByDefault = true',
  'appShellMutationAllowed = true',
  'keyboardMutationAllowed = true',
  'moreLongPressMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'legacyCursorDeletionAllowed = true',
  'cursorPassClaimAllowed = true',
  'fakeRuntimeEvidenceAllowed = true',
  'fakeSmokeEvidenceAllowed = true',
  'runtimeMountAllowedWithoutQ101 = true',
  'defaultEditorSwitchAllowed = true',
  ['maySwitchDefaultEditor', 'true'].join(': '),
  ['mayDeleteLegacyCursor', 'true'].join(': '),
  ['mayClaimCursorPass', 'true'].join(': '),
  ['appShellMutationAllowed', 'true'].join(': '),
  ['keyboardMutationAllowed', 'true'].join(': '),
  ['graphHistorySolutionUiMutationAllowed', 'true'].join(': '),
  ['legacyCursorDeletionAllowed', 'true'].join(': '),
  ['cursorPassClaimAllowed', 'true'].join(': '),
  '"q106MainWorkspaceMountImplementedInThisPackage"' + ': true',
  '"q106MayMutateAppShell"' + ': true',
  '"q106MayMutateKeyboard"' + ': true',
  '"q106MayMutateGraphHistorySolutionUi"' + ': true',
  '"q106MaySwitchDefaultEditor"' + ': true',
  '"q106MayEnableMathLiveByDefault"' + ': true',
  '"q106MayDeleteLegacyCursor"' + ': true',
  '"q106MayClaimCursorPass"' + ': true',
];
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) blockers.push(`forbidden enabled marker present: ${marker}`);
}
for (const [label, text] of [
  ['app_shell.dart', appShell],
  ['key_config.dart', keyConfig],
  ['graph_card.dart', graphCard],
  ['history_controller.dart', historyController],
  ['solution_steps_panel.dart', solutionPanel],
]) {
  if (text.includes('V172-Q106')) blockers.push(`Q106 marker found in protected file: ${label}`);
}

const q101ClosureReport = parseJsonFile('tool/reports/mathlive_lab_smoke_evidence_closure_report.json');
const q105Report = parseJsonFile('tool/reports/mathlive_solution_evaluator_candidate_adapter_report.json');
const q100Report = parseJsonFile('tool/reports/mathlive_official_runtime_bundle_report.json');
const q101Closed = Boolean(q101ClosureReport?.labSmokeEvidenceClosed || q101ClosureReport?.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT');
const q105PackageReady = blockers.length === 0 && Boolean(q105Report?.packageSideSolutionEvaluatorSamplesPass ?? true);
const officialRuntimeVerified = Boolean(q100Report?.officialRuntimeBundleClosed || q100Report?.status === 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSED');

const blockedPlan = buildMountPlan({
  requestedEngine: 'mathlive',
  explicitInternalFlagEnabled: false,
  q101Closed,
  q105PackageReady,
  officialRuntimeVerified,
});
const legacyPlan = buildMountPlan({
  requestedEngine: 'legacyFlutterSlotEditor',
  explicitInternalFlagEnabled: false,
  q101Closed,
  q105PackageReady,
  officialRuntimeVerified,
});

if (blockedPlan.selectedEngine !== 'legacyFlutterSlotEditor') blockers.push('blocked MathLive request must fall back to legacyFlutterSlotEditor');
if (blockedPlan.mathLiveEnabledByDefault !== false) blockers.push('MathLive must not be enabled by default');
if (blockedPlan.defaultEditorSwitchAllowed !== false) blockers.push('default editor switch must remain false');
if (blockedPlan.legacyCursorDeletionAllowed !== false) blockers.push('legacy cursor deletion must remain false');
if (blockedPlan.cursorPassClaimAllowed !== false) blockers.push('cursor PASS claim must remain false');
if (legacyPlan.selectedEngine !== 'legacyFlutterSlotEditor') blockers.push('legacy request must keep legacyFlutterSlotEditor');

const staticContractPasses = blockers.filter(item => !item.includes('Q101 Lab smoke evidence closure') && !item.includes('official local MathLive runtime')).length === 0;
const runtimeReady = staticContractPasses && q101Closed && officialRuntimeVerified;
const status = runtimeReady
  ? 'MATHLIVE_MAIN_WORKSPACE_MOUNT_READY_BEHIND_INTERNAL_FLAG'
  : staticContractPasses
    ? 'MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
    : 'BLOCKED_MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG';

const report = {
  phase: 'V172-Q106',
  status,
  generatedAt: new Date().toISOString(),
  staticContractPasses,
  q101LabSmokeEvidenceClosed: q101Closed,
  officialRuntimeVerified,
  q105PackageSideSolutionEvaluatorReady: q105PackageReady,
  mainWorkspaceMountImplementedInThisPackage: false,
  explicitInternalFlagRequired: true,
  internalFlagName: 'mathpro.internal.editorEngine.mathlive',
  mathLiveEnabledByDefault: false,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  mayMountBehindInternalFlagAtRuntime: runtimeReady,
  maySwitchDefaultEditor: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  appShellMutationAllowed: false,
  keyboardMutationAllowed: false,
  graphHistorySolutionUiMutationAllowed: false,
  protectedUiSurfaceMutationAllowed: false,
  plans: [blockedPlan, legacyPlan],
  blockers: [
    ...blockers,
    ...(q101Closed ? [] : ['Q101 Lab smoke evidence closure has not passed; Q106 remains package-side only']),
    ...(officialRuntimeVerified ? [] : ['official local MathLive runtime is not verified; runtime mount remains blocked']),
  ],
};
writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q106 Main Workspace MathLive Mount Behind Internal Flag Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- staticContractPasses: ${String(staticContractPasses)}`,
  `- q101LabSmokeEvidenceClosed: ${String(q101Closed)}`,
  `- officialRuntimeVerified: ${String(officialRuntimeVerified)}`,
  `- mainWorkspaceMountImplementedInThisPackage: false`,
  `- mathLiveEnabledByDefault: false`,
  `- selectedDefaultEngine: legacyFlutterSlotEditor`,
  `- mayMountBehindInternalFlagAtRuntime: ${String(runtimeReady)}`,
  '- maySwitchDefaultEditor: false',
  '- mayDeleteLegacyCursor: false',
  '- mayClaimCursorPass: false',
  '- appShellMutationAllowed: false',
  '- keyboardMutationAllowed: false',
  '- graphHistorySolutionUiMutationAllowed: false',
  '',
  '## Mount plans',
  ...report.plans.map(item => `- requested=${item.requestedEngine} selected=${item.selectedEngine} runtimeMountAllowed=${String(item.runtimeMountAllowed)}`),
  '',
  '## Blockers',
  ...(report.blockers.length ? report.blockers.map(item => `- ${item}`) : ['- none']),
  '',
].join('\n');
writeFileSync(mdReportPath, md, 'utf8');
console.log(JSON.stringify({
  phase: report.phase,
  status: report.status,
  jsonReportPath: rel(jsonReportPath),
  mdReportPath: rel(mdReportPath),
  blockers: report.blockers.length,
  staticContractPasses,
  mayMountBehindInternalFlagAtRuntime: false,
  maySwitchDefaultEditor: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
}, null, 2));
process.exit(status === 'BLOCKED_MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG' ? 2 : 0);
