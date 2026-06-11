#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs', retiredPhase: 'verify_mathlive_main_editor_activation_dry_run_gate', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const reportDir = path.join(root, 'tool', 'reports');
fs.mkdirSync(reportDir, { recursive: true });
const reportJson = path.join(reportDir, 'mathlive_main_editor_activation_dry_run_gate_report.json');
const reportMd = path.join(reportDir, 'mathlive_main_editor_activation_dry_run_gate_report.md');

function readRequired(relPath, blockers) {
  const abs = path.join(root, relPath);
  if (!fs.existsSync(abs)) {
    blockers.push(`missing required file: ${relPath}`);
    return '';
  }
  return fs.readFileSync(abs, 'utf8');
}

function readOptional(relPath) {
  const abs = path.join(root, relPath);
  if (!fs.existsSync(abs)) return '';
  return fs.readFileSync(abs, 'utf8');
}

function parseJson(relPath) {
  const abs = path.join(root, relPath);
  if (!fs.existsSync(abs)) return null;
  try {
    return JSON.parse(fs.readFileSync(abs, 'utf8'));
  } catch (error) {
    return { __parseError: String(error) };
  }
}

function hasAnyStatus(report, statuses) {
  if (!report || report.__parseError) return false;
  return statuses.includes(report.status) || statuses.includes(report.result);
}

const structuralBlockers = [];
const evidenceBlockers = [];
const warnings = [];

const requiredFiles = [
  'lib/features/mathlive/mathlive_main_editor_activation_dry_run_gate_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart',
  'tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs',
  'test/v172_q118_main_editor_activation_dry_run_gate_test.dart',
  'docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_AUDIT_REPORT.md',
  'docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_CHANGED_FILES_MANIFEST.md',
];
for (const rel of requiredFiles) {
  if (!fs.existsSync(path.join(root, rel))) structuralBlockers.push(`missing required Q118 file: ${rel}`);
}

const policy = readRequired('lib/features/mathlive/mathlive_main_editor_activation_dry_run_gate_policy.dart', structuralBlockers);
const q117Policy = readRequired('lib/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart', structuralBlockers);
const manifest = readRequired('assets/mathlive/manifest.json', structuralBlockers);
const contract = readRequired('lib/logic/mathpro_package_contract.dart', structuralBlockers);
const readme = readRequired('README.md', structuralBlockers);
const audit = readRequired('docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_AUDIT_REPORT.md', structuralBlockers);
const changed = readRequired('docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_CHANGED_FILES_MANIFEST.md', structuralBlockers);

const requiredMarkers = [
  [policy, "phase = 'V172-Q118'"],
  [policy, 'dryRunGateOnly = true'],
  [policy, 'q117PreflightEvidenceRequired = true'],
  [policy, 'actualMainEditorSwitchImplementedInThisPackage = false'],
  [policy, 'mathLiveEnabledByDefault = false'],
  [policy, 'legacyCursorDeletionAllowed = false'],
  [policy, 'cursorPassClaimAllowedInThisPackage = false'],
  [policy, 'Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE_READY_BUT_PREFLIGHT_EVIDENCE_BLOCKED'],
  [q117Policy, "phase = 'V172-Q117'"],
  [manifest, '"q118MainEditorActivationDryRunPhase": "V172-Q118"'],
  [manifest, '"q118RequiresQ117PreflightEvidence": true'],
  [manifest, '"q118ActualMainEditorSwitchImplemented": false'],
  [manifest, '"q118MaySwitchDefaultEditorNow": false'],
  [manifest, '"q118MayDeleteLegacyCursor": false'],
  [contract, 'q118MainEditorActivationDryRunGateRule'],
  [readme, 'V172-Q118 — Main Editor Activation Dry-Run Gate'],
  [audit, 'Q118 is a dry-run gate, not a runtime activation'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) structuralBlockers.push(`missing Q118 marker: ${marker}`);
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'actualMainEditorSwitchImplementedInThisPackage = true',
  'mainWorkspaceMountImplementedInThisPackage = true',
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
  '"q118ActualMainEditorSwitchImplemented": true',
  '"q118MathLiveEnabledByDefault": true',
  '"q118MaySwitchDefaultEditorNow": true',
  '"q118MayRetireLegacyMainPath": true',
  '"q118MayDeleteLegacyCursor": true',
  '"q118MayClaimCursorPass": true',
  '"q118MayMutateKeyboard": true',
  '"q118MayMutateAppShell": true',
  '"q118MayMutateGraphHistorySolutionUi": true',
  '"q118CreatesFakeDeviceEvidence": true',
];
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) structuralBlockers.push(`forbidden Q118 enabled marker present: ${marker}`);
}

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
for (const relPath of protectedFiles) {
  const text = readOptional(relPath);
  if (text.includes('V172-Q118') || text.includes('q118MainEditorActivationDryRun')) {
    structuralBlockers.push(`Q118 marker leaked into protected file: ${relPath}`);
  }
}

const q117Report = parseJson('tool/reports/mathlive_main_editor_switch_preflight_gate_report.json');
const q118Capture = parseJson('tool/reports/mathlive_main_editor_activation_dry_run_gate_capture.json');

const q117PackageReady = q117Report?.packageReady === true || q117Report?.packageSideGateReady === true || hasAnyStatus(q117Report, [
  'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE_READY_BUT_EVIDENCE_BLOCKED',
  'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_READY_FOR_HUMAN_REVIEW',
]);
const q117PreflightEvidenceComplete = q117Report?.preflightEvidenceComplete === true || hasAnyStatus(q117Report, [
  'Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_READY_FOR_HUMAN_REVIEW',
]);
const q117HumanReviewApproved = q118Capture?.q117HumanReviewApproved === true;
const explicitRuntimeFlagEnabled = q118Capture?.explicitRuntimeFlagEnabled === true;
const explicitActivationApproval = q118Capture?.explicitActivationApproval === true;
const flutterAnalyzePassed = q118Capture?.flutterAnalyzePassed === true;
const flutterTestPassed = q118Capture?.flutterTestPassed === true;
const labDeviceRunCaptured = q118Capture?.labDeviceRunCaptured === true;
const mainDeviceRunCaptured = q118Capture?.mainDeviceRunCaptured === true;
const graphRuntimeVerified = q118Capture?.graphRuntimeVerified === true;
const historyRuntimeVerified = q118Capture?.historyRuntimeVerified === true;
const solutionRuntimeVerified = q118Capture?.solutionRuntimeVerified === true;

if (!q117PackageReady) evidenceBlockers.push('Q117 main-editor switch preflight package gate is not ready');
if (!q117PreflightEvidenceComplete) evidenceBlockers.push('Q117 preflight evidence is not complete');
if (!q117HumanReviewApproved) evidenceBlockers.push('Q117 human review approval is missing');
if (!explicitRuntimeFlagEnabled) evidenceBlockers.push('explicit runtime MathLive main-editor flag is not enabled');
if (!explicitActivationApproval) evidenceBlockers.push('explicit Q118 activation approval is missing');
if (!flutterAnalyzePassed) evidenceBlockers.push('flutter analyze PASS evidence is missing');
if (!flutterTestPassed) evidenceBlockers.push('flutter test PASS evidence is missing');
if (!labDeviceRunCaptured) evidenceBlockers.push('MathLive Lab real-device run evidence is missing');
if (!mainDeviceRunCaptured) evidenceBlockers.push('main app real-device run evidence is missing');
if (!graphRuntimeVerified) evidenceBlockers.push('Graph runtime verification is missing');
if (!historyRuntimeVerified) evidenceBlockers.push('History runtime verification is missing');
if (!solutionRuntimeVerified) evidenceBlockers.push('Solution runtime verification is missing');
if (q118Capture && q118Capture.noActualSwitchInThisPackage === false) evidenceBlockers.push('Q118 capture records an attempted main-editor switch');
if (q118Capture && q118Capture.noLegacyRetirementOrDeletion === false) evidenceBlockers.push('Q118 capture records attempted legacy retirement or deletion');
if (q118Capture && q118Capture.noFakeEvidence === false) evidenceBlockers.push('Q118 capture records fake evidence risk');

const packageReady = structuralBlockers.length === 0 && q117PackageReady;
const evidenceComplete = packageReady && evidenceBlockers.length === 0;
const status = evidenceComplete
  ? 'Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_READY_FOR_HUMAN_REVIEW'
  : packageReady
    ? 'Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE_READY_BUT_PREFLIGHT_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE';

const report = {
  phase: 'V172-Q118',
  status,
  packageReady,
  packageSideGateReady: packageReady,
  q117PackageReady,
  q117PreflightEvidenceComplete,
  q117HumanReviewApproved,
  explicitRuntimeFlagEnabled,
  explicitActivationApproval,
  flutterAnalyzePassed,
  flutterTestPassed,
  labDeviceRunCaptured,
  mainDeviceRunCaptured,
  graphRuntimeVerified,
  historyRuntimeVerified,
  solutionRuntimeVerified,
  activationEvidenceComplete: evidenceComplete,
  dryRunGateOnly: true,
  actualMainEditorSwitchImplementedInThisPackage: false,
  mainWorkspaceMountImplementedInThisPackage: false,
  mathLiveEnabledByDefault: false,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  mayProceedToRuntimeActivationReview: evidenceComplete,
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
  `# V172-Q118 Main Editor Activation Dry-Run Gate Report\n\n` +
  `- Status: ${status}\n` +
  `- Package ready: ${packageReady}\n` +
  `- Activation evidence complete: ${evidenceComplete}\n` +
  `- Actual main-editor switch implemented: false\n` +
  `- MathLive enabled by default: false\n` +
  `- Legacy cursor deletion allowed: false\n` +
  `- Blockers: ${report.blockers.length}\n` +
  report.blockers.map((item) => `  - ${item}`).join('\n') +
  `\n`,
);

console.log(status);
console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
