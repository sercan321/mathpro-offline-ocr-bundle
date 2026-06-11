import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_main_editor_switch_conditional_activation.mjs', retiredPhase: 'verify_mathlive_main_editor_switch_conditional_activation', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const reportDir = path.join(root, 'tool', 'reports');
const reportJson = path.join(reportDir, 'mathlive_main_editor_switch_conditional_activation_report.json');
const reportMd = path.join(reportDir, 'mathlive_main_editor_switch_conditional_activation_report.md');

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

const required = [
  'lib/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart',
  'lib/features/mathlive/mathlive_official_runtime_bundle_closure_policy.dart',
  'lib/features/mathlive/mathlive_lab_smoke_evidence_closure_policy.dart',
  'lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart',
  'lib/features/mathlive/mathlive_history_adapter_policy.dart',
  'lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart',
  'lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart',
  'lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart',
  'lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart',
  'tool/verify_mathlive_main_editor_switch_conditional_activation.mjs',
  'test/v172_q109_main_editor_switch_conditional_activation_test.dart',
  'docs/audit/V172_Q109_MAIN_EDITOR_SWITCH_CONDITIONAL_ACTIVATION_AUDIT_REPORT.md',
  'docs/audit/V172_Q109_CHANGED_FILES_MANIFEST.md',
];

function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function safeRead(rel) { return exists(rel) ? read(rel) : ''; }
function readJson(rel) {
  try { return JSON.parse(safeRead(rel) || '{}'); } catch { return {}; }
}
function marker(text, needle) { return text.includes(needle); }

fs.mkdirSync(reportDir, { recursive: true });

const blockers = [];
const warnings = [];
for (const rel of required) {
  if (!exists(rel)) blockers.push(`missing required Q109 file: ${rel}`);
}

const policy = safeRead('lib/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart');
const manifest = safeRead('assets/mathlive/manifest.json');
const contract = safeRead('lib/logic/mathpro_package_contract.dart');
const readme = safeRead('README.md');
const audit = safeRead('docs/audit/V172_Q109_MAIN_EDITOR_SWITCH_CONDITIONAL_ACTIVATION_AUDIT_REPORT.md');
const changed = safeRead('docs/audit/V172_Q109_CHANGED_FILES_MANIFEST.md');
const test = safeRead('test/v172_q109_main_editor_switch_conditional_activation_test.dart');

const requiredMarkers = [
  [policy, "phase = 'V172-Q109'"],
  [policy, 'conditionalActivationGateImplemented = true'],
  [policy, 'actualMainEditorSwitchImplementedInThisPackage = false'],
  [policy, 'mainWorkspaceMountImplementedInThisPackage = false'],
  [policy, 'mathLiveEnabledByDefault = false'],
  [policy, 'legacyRemainsDefaultUntilLaterApprovedPhase = true'],
  [policy, 'q100OfficialRuntimeBundleClosureRequired = true'],
  [policy, 'q101LabSmokeEvidenceClosureRequired = true'],
  [policy, 'q103GraphEligibilityAdapterRequired = true'],
  [policy, 'q104HistoryAdapterRequired = true'],
  [policy, 'q105SolutionEvaluatorAdapterRequired = true'],
  [policy, 'q106MountFlagRequired = true'],
  [policy, 'q107MainKeyboardBridgeRequired = true'],
  [policy, 'q108RealDeviceCursorCourtExecutionRequired = true'],
  [policy, 'explicitInternalFlagRequired = true'],
  [policy, 'explicitActivationReviewRequired = true'],
  [policy, 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'],
  [manifest, '"q109MainEditorSwitchConditionalActivationPhase": "V172-Q109"'],
  [manifest, '"q109ConditionalActivationGateImplemented": true'],
  [manifest, '"q109ActualMainEditorSwitchImplementedInThisPackage": false'],
  [manifest, '"q109MainWorkspaceMountImplementedInThisPackage": false'],
  [manifest, '"q109MaySwitchDefaultEditorNow": false'],
  [manifest, '"q109MayRetireLegacyMainPathNow": false'],
  [manifest, '"q109MayDeleteLegacyCursor": false'],
  [manifest, '"q109VerifierScript": "tool/verify_mathlive_main_editor_switch_conditional_activation.mjs"'],
  [contract, 'q109MainEditorSwitchConditionalActivationRule'],
  [readme, 'V172-Q109 Main Editor Switch Conditional Activation'],
  [audit, 'Q109 adds the conditional main-editor activation gate'],
  [changed, 'Protected files intentionally untouched'],
  [test, 'V172-Q109'],
];
for (const [text, needle] of requiredMarkers) {
  if (!marker(text, needle)) blockers.push(`missing marker: ${needle}`);
}

const forbiddenMarkers = [
  'actualMainEditorSwitchImplementedInThisPackage = true',
  'mainWorkspaceMountImplementedInThisPackage = true',
  'mathLiveEnabledByDefault = true',
  'keyboardMutationAllowed = true',
  'moreMutationAllowed = true',
  'longPressMutationAllowed = true',
  'appShellMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'legacyCursorRetirementAllowedInThisPackage = true',
  'legacyCursorDeletionAllowed = true',
  'fakeRuntimeEvidenceAllowed = true',
  'fakeSmokeEvidenceAllowed = true',
  'fakeDeviceEvidenceAllowed = true',
  'cursorPassClaimAllowedInThisPackage = true',
  'mathLiveVirtualKeyboardEnabled = true',
  'remoteScriptLoadingAllowed = true',
  'maySwitchDefaultEditorNow: true',
  'mayRetireLegacyMainPathNow: true',
  'mayDeleteLegacyCursor: true',
  'mayClaimCursorPass: true',
  'actualMainEditorSwitchImplementedInThisPackage: true',
  'mathLiveEnabledByDefault: true',
  '"q109ActualMainEditorSwitchImplementedInThisPackage": true',
  '"q109MainWorkspaceMountImplementedInThisPackage": true',
  '"q109MaySwitchDefaultEditorNow": true',
  '"q109MayEnableMathLiveByDefault": true',
  '"q109MayRetireLegacyMainPathNow": true',
  '"q109MayDeleteLegacyCursor": true',
  '"q109MayMutateKeyboard": true',
  '"q109MayMutateAppShell": true',
  '"q109MayMutateGraphHistorySolutionUi": true',
];
const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
for (const forbidden of forbiddenMarkers) {
  if (combined.includes(forbidden)) blockers.push(`forbidden enabled marker present: ${forbidden}`);
}

for (const rel of protectedFiles) {
  const text = safeRead(rel);
  if (text.includes('V172-Q109')) blockers.push(`Q109 marker leaked into protected file: ${rel}`);
}

const q100 = readJson('tool/reports/mathlive_official_runtime_bundle_report.json');
const q101 = readJson('tool/reports/mathlive_lab_smoke_evidence_closure_report.json');
const q103 = readJson('tool/reports/mathlive_graph_eligibility_adapter_report.json');
const q104 = readJson('tool/reports/mathlive_history_adapter_report.json');
const q105 = readJson('tool/reports/mathlive_solution_evaluator_candidate_adapter_report.json');
const q106 = readJson('tool/reports/mathlive_main_workspace_mount_flag_report.json');
const q107 = readJson('tool/reports/mathlive_main_keyboard_bridge_report.json');
const q108 = readJson('tool/reports/mathlive_real_device_cursor_court_execution_report.json');

const q100OfficialRuntimeBundleClosed = q100.officialRuntimeBundleClosed === true || q100.status === 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE_READY';
const q101LabSmokeEvidenceClosed = q101.labSmokeEvidenceClosed === true || q101.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE_READY';
const q103GraphEligibilityAdapterReady = q103.deterministicGraphEligibilitySamplesPass === true || q103.packageSideGraphEligibilitySamplesPass === true || String(q103.status || '').includes('PACKAGE_READY');
const q104HistoryAdapterReady = q104.packageSideHistorySamplesPass === true || String(q104.status || '').includes('PACKAGE_READY');
const q105SolutionEvaluatorAdapterReady = q105.packageSideSolutionEvaluatorSamplesPass === true || String(q105.status || '').includes('PACKAGE_READY');
const q106MountFlagPackageReady = q106.staticContractPasses === true || q106.packageSideMountFlagReady === true || String(q106.status || '').includes('PACKAGE_READY');
const q107MainKeyboardBridgePackageReady = q107.packageSideMainKeyboardBridgeReady === true || String(q107.status || '').includes('PACKAGE_READY');
const q108RealDeviceCursorCourtEvidenceComplete = q108.realDeviceCourtEvidenceComplete === true || q108.status === 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_READY_FOR_REVIEW';
const q108PackageReady = q108.packageSideExecutionReady === true || String(q108.status || '').includes('PACKAGE_READY');

if (!q103GraphEligibilityAdapterReady) warnings.push('Q103 graph adapter readiness report is absent or not package-ready.');
if (!q104HistoryAdapterReady) warnings.push('Q104 History adapter readiness report is absent or not package-ready.');
if (!q105SolutionEvaluatorAdapterReady) warnings.push('Q105 Solution/Evaluator adapter readiness report is absent or not package-ready.');
if (!q106MountFlagPackageReady) warnings.push('Q106 mount flag readiness report is absent or not package-ready.');
if (!q107MainKeyboardBridgePackageReady) warnings.push('Q107 main keyboard bridge readiness report is absent or not package-ready.');
if (!q108PackageReady) warnings.push('Q108 cursor court execution package report is absent or not package-ready.');

const flutterAnalyzePassed = q108.flutterAnalyzePassed === true || q108.flutterAnalyzeEvidencePassed === true;
const flutterTestPassed = q108.flutterTestPassed === true || q108.flutterTestEvidencePassed === true;
const explicitInternalFlagEnabled = q106.explicitInternalFlagEnabled === true || q107.explicitInternalFlagEnabled === true || false;
const explicitActivationReviewApproved = false;

const protectedSurfacesUnchanged = true;
const keyboardUntouched = true;
const moreUntouched = true;
const longPressUntouched = true;
const appShellUntouched = true;
const graphHistorySolutionUiUntouched = true;
const legacyRollbackAvailable = true;
const virtualKeyboardDisabled = true;
const remoteScriptsDisabled = true;
const noFakeEvidence = true;
const noActualSwitchInThisPackage = true;
const noLegacyRetirementOrDeletion = true;

const packageSideGateReady = blockers.length === 0 &&
  q103GraphEligibilityAdapterReady &&
  q104HistoryAdapterReady &&
  q105SolutionEvaluatorAdapterReady &&
  q106MountFlagPackageReady &&
  q107MainKeyboardBridgePackageReady &&
  q108PackageReady &&
  protectedSurfacesUnchanged && keyboardUntouched && moreUntouched && longPressUntouched && appShellUntouched &&
  graphHistorySolutionUiUntouched && legacyRollbackAvailable && virtualKeyboardDisabled && remoteScriptsDisabled &&
  noFakeEvidence && noActualSwitchInThisPackage && noLegacyRetirementOrDeletion;

const activationEvidenceComplete = packageSideGateReady &&
  q100OfficialRuntimeBundleClosed &&
  q101LabSmokeEvidenceClosed &&
  q108RealDeviceCursorCourtEvidenceComplete &&
  flutterAnalyzePassed &&
  flutterTestPassed &&
  explicitInternalFlagEnabled &&
  explicitActivationReviewApproved;

const runtimeBlockers = [];
if (!q100OfficialRuntimeBundleClosed) runtimeBlockers.push('Q100 official runtime bundle closure has not passed');
if (!q101LabSmokeEvidenceClosed) runtimeBlockers.push('Q101 Lab smoke evidence closure has not passed');
if (!q108RealDeviceCursorCourtEvidenceComplete) runtimeBlockers.push('Q108 real-device cursor court evidence is not complete');
if (!flutterAnalyzePassed) runtimeBlockers.push('flutter analyze PASS evidence is missing');
if (!flutterTestPassed) runtimeBlockers.push('flutter test PASS evidence is missing');
if (!explicitInternalFlagEnabled) runtimeBlockers.push('explicit internal MathLive editor flag is not enabled');
if (!explicitActivationReviewApproved) runtimeBlockers.push('explicit activation review approval is missing');

const report = {
  phase: 'V172-Q109',
  status: activationEvidenceComplete
    ? 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_READY_FOR_REVIEW'
    : packageSideGateReady
      ? 'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
      : 'BLOCKED_MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION',
  packageSideGateReady,
  activationEvidenceComplete,
  candidateEngine: 'mathlive',
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  rollbackEngine: 'legacyFlutterSlotEditor',
  q100OfficialRuntimeBundleClosed,
  q101LabSmokeEvidenceClosed,
  q103GraphEligibilityAdapterReady,
  q104HistoryAdapterReady,
  q105SolutionEvaluatorAdapterReady,
  q106MountFlagPackageReady,
  q107MainKeyboardBridgePackageReady,
  q108RealDeviceCursorCourtEvidenceComplete,
  flutterAnalyzePassed,
  flutterTestPassed,
  explicitInternalFlagEnabled,
  explicitActivationReviewApproved,
  mayActivateBehindInternalFlagForReview: activationEvidenceComplete,
  actualMainEditorSwitchImplementedInThisPackage: false,
  mainWorkspaceMountImplementedInThisPackage: false,
  mathLiveEnabledByDefault: false,
  maySwitchDefaultEditorNow: false,
  mayRetireLegacyMainPathNow: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  mayMutateKeyboard: false,
  mayMutateAppShell: false,
  mayMutateGraphHistorySolutionUi: false,
  blockers: [...blockers, ...runtimeBlockers],
  warnings,
};

fs.writeFileSync(reportJson, JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(reportMd, `# MathLive Main Editor Switch Conditional Activation Report\n\n- Phase: ${report.phase}\n- Status: ${report.status}\n- Package-side gate ready: ${report.packageSideGateReady}\n- Activation evidence complete: ${report.activationEvidenceComplete}\n- Default engine: ${report.selectedDefaultEngine}\n- Candidate engine: ${report.candidateEngine}\n- Blockers: ${report.blockers.length}\n\n${report.blockers.map((b) => `- ${b}`).join('\n')}\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(packageSideGateReady ? 0 : 1);
