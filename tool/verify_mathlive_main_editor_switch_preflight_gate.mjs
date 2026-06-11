#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_main_editor_switch_preflight_gate.mjs', retiredPhase: 'verify_mathlive_main_editor_switch_preflight_gate', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const reportDir = path.join(root, 'tool', 'reports');
fs.mkdirSync(reportDir, { recursive: true });
const reportJson = path.join(reportDir, 'mathlive_main_editor_switch_preflight_gate_report.json');
const reportMd = path.join(reportDir, 'mathlive_main_editor_switch_preflight_gate_report.md');

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

function rel(...parts) { return path.join(root, ...parts); }
function safeRead(relativePath) {
  const p = rel(...relativePath.split('/'));
  if (!fs.existsSync(p)) throw new Error(`Missing required file: ${relativePath}`);
  return fs.readFileSync(p, 'utf8');
}
function readOptional(relativePath) {
  const p = rel(...relativePath.split('/'));
  return fs.existsSync(p) ? fs.readFileSync(p, 'utf8') : '';
}
function parseJson(relativePath) {
  const p = rel(...relativePath.split('/'));
  if (!fs.existsSync(p)) return null;
  return JSON.parse(fs.readFileSync(p, 'utf8'));
}
function hasAnyStatus(report, statuses) {
  return report && statuses.includes(report.status);
}

const structuralBlockers = [];
const evidenceBlockers = [];
const warnings = [];

let policy = '', manifest = '', contract = '', readme = '', audit = '', changed = '', q116Policy = '', q109Policy = '';
try {
  policy = safeRead('lib/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart');
  manifest = safeRead('assets/mathlive/manifest.json');
  contract = safeRead('lib/logic/mathpro_package_contract.dart');
  readme = safeRead('README.md');
  audit = safeRead('docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_AUDIT_REPORT.md');
  changed = safeRead('docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_CHANGED_FILES_MANIFEST.md');
  q116Policy = safeRead('lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart');
  q109Policy = safeRead('lib/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart');
} catch (error) {
  structuralBlockers.push(error.message);
}

const requiredMarkers = [
  [policy, "phase = 'V172-Q117'"],
  [policy, 'preflightGateOnly = true'],
  [policy, 'actualMainEditorSwitchImplementedInThisPackage = false'],
  [policy, 'mathLiveEnabledByDefault = false'],
  [policy, 'legacyFlutterSlotEditorRemainsDefault = true'],
  [policy, 'q116PostQ115CursorCourtRerunRequired = true'],
  [policy, 'q116HumanReviewRequired = true'],
  [policy, 'legacyCursorDeletionAllowed = false'],
  [policy, 'cursorPassClaimAllowedInThisPackage = false'],
  [policy, 'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'],
  [q116Policy, "phase = 'V172-Q116'"],
  [q109Policy, "phase = 'V172-Q109'"],
  [manifest, '"q117MainEditorSwitchPreflightPhase": "V172-Q117"'],
  [manifest, '"q117RequiresQ116PostQ115Evidence": true'],
  [manifest, '"q117ActualMainEditorSwitchImplemented": false'],
  [manifest, '"q117MaySwitchDefaultEditorNow": false'],
  [manifest, '"q117MayDeleteLegacyCursor": false'],
  [contract, 'q117MainEditorSwitchPreflightGateRule'],
  [readme, 'V172-Q117 — Main Editor Switch Preflight Gate'],
  [audit, 'Q117 is a preflight gate, not a main-editor switch'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) structuralBlockers.push(`missing Q117 marker: ${marker}`);
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'actualMainEditorSwitchImplementedInThisPackage = true',
  'mathLiveEnabledByDefault = true',
  'keyboardMutationAllowed = true',
  'moreMutationAllowed = true',
  'longPressMutationAllowed = true',
  'appShellMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
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
  '"q117ActualMainEditorSwitchImplemented": true',
  '"q117MathLiveEnabledByDefault": true',
  '"q117MaySwitchDefaultEditorNow": true',
  '"q117MayRetireLegacyMainPath": true',
  '"q117MayDeleteLegacyCursor": true',
  '"q117MayClaimCursorPass": true',
  '"q117MayMutateKeyboard": true',
  '"q117MayMutateAppShell": true',
  '"q117MayMutateGraphHistorySolutionUi": true',
  '"q117CreatesFakeDeviceEvidence": true',
];
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) structuralBlockers.push(`forbidden Q117 enabled marker present: ${marker}`);
}
for (const relPath of protectedFiles) {
  const text = readOptional(relPath);
  if (text.includes('V172-Q117') || text.includes('q117MainEditorSwitchPreflight')) {
    structuralBlockers.push(`Q117 marker leaked into protected file: ${relPath}`);
  }
}

const q116Report = parseJson('tool/reports/mathlive_post_q115_cursor_court_rerun_report.json');
const q109Report = parseJson('tool/reports/mathlive_main_editor_switch_conditional_activation_report.json');
const q100Report = parseJson('tool/reports/mathlive_official_runtime_bundle_report.json');
const q101Report = parseJson('tool/reports/mathlive_lab_smoke_evidence_closure_report.json');
const q103Report = parseJson('tool/reports/mathlive_graph_eligibility_adapter_report.json');
const q104Report = parseJson('tool/reports/mathlive_history_adapter_report.json');
const q105Report = parseJson('tool/reports/mathlive_solution_evaluator_candidate_adapter_report.json');
const q106Report = parseJson('tool/reports/mathlive_main_workspace_mount_flag_report.json');
const q107Report = parseJson('tool/reports/mathlive_main_keyboard_bridge_report.json');
const q117Capture = parseJson('tool/reports/mathlive_main_editor_switch_preflight_capture.json');

const q116PackageReady = q116Report?.packageReady === true || hasAnyStatus(q116Report, [
  'Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED',
  'Q116_POST_Q115_CURSOR_COURT_RERUN_READY_FOR_HUMAN_REVIEW',
]);
const q116PostQ115EvidenceComplete = q116Report?.postQ115EvidenceComplete === true || hasAnyStatus(q116Report, [
  'Q116_POST_Q115_CURSOR_COURT_RERUN_READY_FOR_HUMAN_REVIEW',
]);
const q116HumanReviewApproved = q117Capture?.q116HumanReviewApproved === true;
const q109PackageReady = q109Report?.packageSideGateReady === true || hasAnyStatus(q109Report, [
  'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED',
  'MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_READY_FOR_REVIEW',
]);
const q100Closed = q100Report?.officialRuntimeBundleClosed === true || hasAnyStatus(q100Report, ['MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSED_FOR_SMOKE_EVIDENCE']);
const q101Closed = q101Report?.labSmokeEvidenceClosed === true || hasAnyStatus(q101Report, ['MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT', 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE_READY']);
const q103Ready = q103Report?.packageReady === true || hasAnyStatus(q103Report, ['MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED']);
const q104Ready = q104Report?.packageReady === true || hasAnyStatus(q104Report, ['MATHLIVE_HISTORY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED']);
const q105Ready = q105Report?.packageReady === true || hasAnyStatus(q105Report, ['MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED']);
const q106Ready = q106Report?.packageReady === true || hasAnyStatus(q106Report, ['MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED']);
const q107Ready = q107Report?.packageSideMainKeyboardBridgeReady === true || hasAnyStatus(q107Report, ['MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED']);
const flutterAnalyzePassed = q117Capture?.flutterAnalyzePassed === true;
const flutterTestPassed = q117Capture?.flutterTestPassed === true;
const explicitInternalFlagEnabled = q117Capture?.explicitInternalFlagEnabled === true;
const explicitActivationReviewApproved = q117Capture?.explicitActivationReviewApproved === true;

if (!q116PackageReady) evidenceBlockers.push('Q116 post-Q115 cursor court package readiness is missing');
if (!q116PostQ115EvidenceComplete) evidenceBlockers.push('Q116 post-Q115 real-device cursor court rerun evidence is not complete');
if (!q116HumanReviewApproved) evidenceBlockers.push('Q116 post-Q115 cursor court human review approval is missing');
if (!q109PackageReady) evidenceBlockers.push('Q109 conditional activation package gate is not ready');
if (!q100Closed) evidenceBlockers.push('Q100 official runtime bundle closure has not passed');
if (!q101Closed) evidenceBlockers.push('Q101 Lab smoke evidence closure has not passed');
if (!q103Ready) evidenceBlockers.push('Q103 graph eligibility adapter is not ready');
if (!q104Ready) evidenceBlockers.push('Q104 History adapter is not ready');
if (!q105Ready) evidenceBlockers.push('Q105 Solution/Evaluator adapter is not ready');
if (!q106Ready) evidenceBlockers.push('Q106 mount flag package readiness is missing');
if (!q107Ready) evidenceBlockers.push('Q107 main keyboard bridge package readiness is missing');
if (!flutterAnalyzePassed) evidenceBlockers.push('flutter analyze PASS evidence is missing');
if (!flutterTestPassed) evidenceBlockers.push('flutter test PASS evidence is missing');
if (!explicitInternalFlagEnabled) evidenceBlockers.push('explicit internal MathLive editor flag is not enabled');
if (!explicitActivationReviewApproved) evidenceBlockers.push('explicit activation review approval is missing');
if (q117Capture && q117Capture.noActualSwitchInThisPackage === false) evidenceBlockers.push('Q117 capture records an attempted main-editor switch');
if (q117Capture && q117Capture.noLegacyRetirementOrDeletion === false) evidenceBlockers.push('Q117 capture records attempted legacy retirement or deletion');
if (q117Capture && q117Capture.noFakeEvidence === false) evidenceBlockers.push('Q117 capture records fake evidence risk');

const packageReady = structuralBlockers.length === 0 && q116PackageReady && q109PackageReady && q103Ready && q104Ready && q105Ready && q106Ready && q107Ready;
const evidenceComplete = packageReady && evidenceBlockers.length === 0;
const status = evidenceComplete
  ? 'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_READY_FOR_HUMAN_REVIEW'
  : packageReady
    ? 'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE';

const report = {
  phase: 'V172-Q117',
  status,
  packageReady,
  packageSideGateReady: packageReady,
  q116PackageReady,
  q116PostQ115EvidenceComplete,
  q116HumanReviewApproved,
  q109ConditionalActivationPackageReady: q109PackageReady,
  q100OfficialRuntimeBundleClosed: q100Closed,
  q101LabSmokeEvidenceClosed: q101Closed,
  q103GraphEligibilityAdapterReady: q103Ready,
  q104HistoryAdapterReady: q104Ready,
  q105SolutionEvaluatorAdapterReady: q105Ready,
  q106MountFlagPackageReady: q106Ready,
  q107MainKeyboardBridgePackageReady: q107Ready,
  flutterAnalyzePassed,
  flutterTestPassed,
  explicitInternalFlagEnabled,
  explicitActivationReviewApproved,
  preflightEvidenceComplete: evidenceComplete,
  actualMainEditorSwitchImplementedInThisPackage: false,
  mathLiveEnabledByDefault: false,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  mayProceedToMainEditorActivationReview: evidenceComplete,
  maySwitchDefaultEditorNow: false,
  mayRetireLegacyMainPathNow: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  mayMutateKeyboard: false,
  mayMutateAppShell: false,
  mayMutateGraphHistorySolutionUi: false,
  mayCreateFakeEvidence: false,
  structuralBlockers,
  evidenceBlockers,
  blockers: [...structuralBlockers, ...evidenceBlockers],
  warnings,
};

fs.writeFileSync(reportJson, `${JSON.stringify(report, null, 2)}\n`);
fs.writeFileSync(reportMd,
  `# V172-Q117 Main Editor Switch Preflight Gate Report\n\n` +
  `- Status: ${status}\n` +
  `- Package ready: ${packageReady}\n` +
  `- Preflight evidence complete: ${evidenceComplete}\n` +
  `- Actual main-editor switch implemented: false\n` +
  `- MathLive enabled by default: false\n` +
  `- Legacy cursor deletion allowed: false\n` +
  `- Cursor PASS claimed: false\n\n` +
  `## Blockers\n\n` +
  (report.blockers.length ? report.blockers.map((b) => `- ${b}`).join('\n') : '- none') +
  '\n'
);

console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
