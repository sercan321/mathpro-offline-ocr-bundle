import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_main_keyboard_bridge.mjs', retiredPhase: 'verify_mathlive_main_keyboard_bridge', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const reportDir = path.join(root, 'tool', 'reports');
const reportJson = path.join(reportDir, 'mathlive_main_keyboard_bridge_report.json');
const reportMd = path.join(reportDir, 'mathlive_main_keyboard_bridge_report.md');

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
  'lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart',
  'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  'lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart',
  'tool/verify_mathlive_main_keyboard_bridge.mjs',
  'test/v172_q107_main_keyboard_bridge_test.dart',
  'docs/audit/V172_Q107_MAIN_KEYBOARD_BRIDGE_AUDIT_REPORT.md',
  'docs/audit/V172_Q107_CHANGED_FILES_MANIFEST.md',
];

function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function safeRead(rel) { return exists(rel) ? read(rel) : ''; }
function marker(text, needle) { return text.includes(needle); }

fs.mkdirSync(reportDir, { recursive: true });

const blockers = [];
const warnings = [];
for (const rel of required) {
  if (!exists(rel)) blockers.push(`missing required Q107 file: ${rel}`);
}

const policy = safeRead('lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart');
const q85 = safeRead('lib/features/mathlive/mathlive_keyboard_bridge_policy.dart');
const q106 = safeRead('lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart');
const manifest = safeRead('assets/mathlive/manifest.json');
const contract = safeRead('lib/logic/mathpro_package_contract.dart');
const readme = safeRead('README.md');
const audit = safeRead('docs/audit/V172_Q107_MAIN_KEYBOARD_BRIDGE_AUDIT_REPORT.md');
const changed = safeRead('docs/audit/V172_Q107_CHANGED_FILES_MANIFEST.md');

const requiredMarkers = [
  [policy, "phase = 'V172-Q107'"],
  [policy, 'q85LabBridgeIsSourceOfTruth = true'],
  [policy, 'q106MountFlagRequired = true'],
  [policy, 'q101LabSmokeEvidenceClosureRequired = true'],
  [policy, 'officialRuntimeVerificationRequired = true'],
  [policy, 'mainWorkspaceBridgeImplementedInThisPackage = false'],
  [policy, 'mainBridgeRuntimeBindingAllowedWithoutEvidence = false'],
  [policy, 'keyboardMutationAllowed = false'],
  [policy, 'moreMutationAllowed = false'],
  [policy, 'longPressMutationAllowed = false'],
  [policy, 'appShellMutationAllowed = false'],
  [policy, 'legacyCursorDeletionAllowed = false'],
  [policy, 'mathLiveVirtualKeyboardEnabled = false'],
  [policy, 'remoteScriptLoadingAllowed = false'],
  [policy, 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'],
  [q85, "static const String phase = 'V172-Q85'"],
  [q106, "static const String phase = 'V172-Q106'"],
  [manifest, '"q107MainKeyboardBridgePhase": "V172-Q107"'],
  [manifest, '"q107MainWorkspaceBridgeImplementedInThisPackage": false'],
  [manifest, '"q107UsesQ85FrozenBridge": true'],
  [manifest, '"q107RequiresQ106MountFlag": true'],
  [manifest, '"q107MayMutateKeyboard": false'],
  [manifest, '"q107MaySwitchDefaultEditor": false'],
  [manifest, '"q107MayDeleteLegacyCursor": false'],
  [contract, 'q107MainKeyboardBridgeRule'],
  [readme, 'V172-Q107 MathPro Keyboard → MathLive Main Bridge Hardening'],
  [audit, 'Q107 hardens the MathPro Keyboard → MathLive main-bridge candidate'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, needle] of requiredMarkers) {
  if (!marker(text, needle)) blockers.push(`missing marker: ${needle}`);
}

const forbiddenMarkers = [
  'mainWorkspaceBridgeImplementedInThisPackage = true',
  'mainBridgeRuntimeBindingAllowedWithoutEvidence = true',
  'mathLiveEnabledByDefault = true',
  'defaultEditorSwitchAllowed = true',
  'keyboardMutationAllowed = true',
  'moreMutationAllowed = true',
  'longPressMutationAllowed = true',
  'appShellMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
  'legacyCursorDeletionAllowed = true',
  'cursorPassClaimAllowed = true',
  'fakeRuntimeEvidenceAllowed = true',
  'fakeSmokeEvidenceAllowed = true',
  'mathLiveVirtualKeyboardEnabled = true',
  'remoteScriptLoadingAllowed = true',
  '"q107MainWorkspaceBridgeImplementedInThisPackage": true',
  '"q107MayMutateKeyboard": true',
  '"q107MaySwitchDefaultEditor": true',
  '"q107MayEnableMathLiveByDefault": true',
  '"q107MayDeleteLegacyCursor": true',
];
const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
for (const forbidden of forbiddenMarkers) {
  if (combined.includes(forbidden)) blockers.push(`forbidden enabled marker present: ${forbidden}`);
}

const q85MappingMarkers = [
  "'7': '7'",
  "'+': '+'",
  "'×': r'\\times '",
  "'÷': r'\\div '",
  "'%': r'\\%'",
  "'=': '='",
  "'□/□': r'\\frac{}{}'",
  "'√□': r'\\sqrt{}'",
  "'□^□': '^{}'",
  "'sin': r'\\sin\\left(\\right)'",
  "'log': r'\\log_{}\\left(\\right)'",
  "'∫□dx': r'\\int {}\\,d{}'",
];
for (const needle of q85MappingMarkers) {
  if (!q85.includes(needle)) blockers.push(`Q85 frozen mapping marker missing: ${needle}`);
}

for (const rel of protectedFiles) {
  const text = safeRead(rel);
  if (text.includes('V172-Q107')) blockers.push(`Q107 marker leaked into protected file: ${rel}`);
}

let q101EvidenceClosed = false;
try {
  const q101Report = JSON.parse(safeRead('tool/reports/mathlive_lab_smoke_evidence_closure_report.json') || '{}');
  q101EvidenceClosed = q101Report.labSmokeEvidenceClosed === true || q101Report.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE_READY';
} catch {
  warnings.push('Q101 closure report is absent or not parseable; runtime bridge remains blocked.');
}
let officialRuntimeVerified = false;
try {
  const q100Report = JSON.parse(safeRead('tool/reports/mathlive_official_runtime_bundle_report.json') || '{}');
  officialRuntimeVerified = q100Report.officialRuntimeBundleClosed === true || q100Report.status === 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE_READY';
} catch {
  warnings.push('Q100 runtime bundle report is absent or not parseable; runtime bridge remains blocked.');
}

const packageReady = blockers.length === 0;
const runtimeReady = packageReady && q101EvidenceClosed && officialRuntimeVerified;
const runtimeBlockers = [];
if (!q101EvidenceClosed) runtimeBlockers.push('Q101 Lab smoke evidence closure has not passed');
if (!officialRuntimeVerified) runtimeBlockers.push('official MathLive runtime bundle is not verified');

const report = {
  phase: 'V172-Q107',
  status: runtimeReady
    ? 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_READY_BEHIND_INTERNAL_FLAG'
    : packageReady
      ? 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'
      : 'BLOCKED_MATHLIVE_MAIN_KEYBOARD_BRIDGE',
  packageSideMainKeyboardBridgeReady: packageReady,
  q85FrozenBridgeSourceOfTruth: true,
  q106MountFlagRequired: true,
  q101LabSmokeEvidenceClosed: q101EvidenceClosed,
  officialRuntimeVerified,
  explicitInternalFlagRequired: true,
  mayBindMainKeyboardBridgeAtRuntime: runtimeReady,
  maySwitchDefaultEditor: false,
  mayEnableMathLiveByDefault: false,
  mayMutateKeyboard: false,
  mayMutateAppShell: false,
  mayMutateGraphHistorySolutionUi: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  blockers: [...blockers, ...runtimeBlockers],
  warnings,
};

fs.writeFileSync(reportJson, JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(reportMd, `# MathLive Main Keyboard Bridge Report\n\n- Phase: ${report.phase}\n- Status: ${report.status}\n- Package-side ready: ${report.packageSideMainKeyboardBridgeReady}\n- Runtime bridge allowed: ${report.mayBindMainKeyboardBridgeAtRuntime}\n- Blockers: ${report.blockers.length}\n\n${report.blockers.map((b) => `- ${b}`).join('\n')}\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
