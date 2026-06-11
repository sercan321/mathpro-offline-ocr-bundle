import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_real_device_cursor_court_execution.mjs', retiredPhase: 'verify_mathlive_real_device_cursor_court_execution', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const reportDir = path.join(root, 'tool', 'reports');
const reportJson = path.join(reportDir, 'mathlive_real_device_cursor_court_execution_report.json');
const reportMd = path.join(reportDir, 'mathlive_real_device_cursor_court_execution_report.md');
const captureJson = path.join(reportDir, 'mathlive_real_device_cursor_court_execution_capture.json');
const flutterEvidenceJson = path.join(reportDir, 'mathlive_real_device_cursor_court_flutter_evidence.json');

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
  'lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart',
  'lib/features/mathlive/mathlive_real_device_cursor_court_policy.dart',
  'lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart',
  'lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart',
  'tool/verify_mathlive_real_device_cursor_court_execution.mjs',
  'test/v172_q108_real_device_cursor_court_execution_test.dart',
  'docs/audit/V172_Q108_REAL_DEVICE_CURSOR_COURT_EXECUTION_AUDIT_REPORT.md',
  'docs/audit/V172_Q108_CHANGED_FILES_MANIFEST.md',
];

const q108ScenarioIds = [
  'empty-placeholder-tap-leading-caret',
  'fraction-numerator-denominator-routing',
  'sqrt-radicand-routing',
  'power-exponent-routing',
  'subscript-routing',
  'sin-300-continuous-argument-entry',
  'tan-long-expression-navigation',
  'log-base-and-body-separation',
  'integral-lower-upper-body-differential-routing',
  'backspace-delete-structural-editing',
  'long-expression-horizontal-scroll-and-tap',
  'focus-loss-restore-and-keyboard-latency',
];

function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function safeRead(rel) { return exists(rel) ? read(rel) : ''; }
function parseJsonFile(abs) {
  try { return JSON.parse(fs.readFileSync(abs, 'utf8')); } catch { return null; }
}
function parseRelJson(rel) {
  const abs = path.join(root, rel);
  return fs.existsSync(abs) ? parseJsonFile(abs) : null;
}
function marker(text, needle) { return text.includes(needle); }

fs.mkdirSync(reportDir, { recursive: true });

const blockers = [];
const runtimeBlockers = [];
const warnings = [];
for (const rel of required) {
  if (!exists(rel)) blockers.push(`missing required Q108 file: ${rel}`);
}

const policy = safeRead('lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart');
const q94 = safeRead('lib/features/mathlive/mathlive_real_device_cursor_court_policy.dart');
const q106 = safeRead('lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart');
const q107 = safeRead('lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart');
const manifest = safeRead('assets/mathlive/manifest.json');
const contract = safeRead('lib/logic/mathpro_package_contract.dart');
const readme = safeRead('README.md');
const audit = safeRead('docs/audit/V172_Q108_REAL_DEVICE_CURSOR_COURT_EXECUTION_AUDIT_REPORT.md');
const changed = safeRead('docs/audit/V172_Q108_CHANGED_FILES_MANIFEST.md');

const requiredMarkers = [
  [policy, "phase = 'V172-Q108'"],
  [policy, 'sourceCourtPhase = MathLiveRealDeviceCursorCourtPolicy.phase'],
  [policy, 'mountFlagPhase = MathLiveMainWorkspaceMountFlagPolicy.phase'],
  [policy, 'mainKeyboardBridgePhase = MathLiveMainKeyboardBridgePolicy.phase'],
  [policy, 'executionPackageOnly = true'],
  [policy, 'q94CourtProtocolRequired = true'],
  [policy, 'q106MountFlagRequired = true'],
  [policy, 'q107MainKeyboardBridgeRequired = true'],
  [policy, 'q101LabSmokeEvidenceClosureRequired = true'],
  [policy, 'officialRuntimeVerificationRequired = true'],
  [policy, 'packageMayClaimCursorPass = false'],
  [policy, 'packageMaySwitchMainEditor = false'],
  [policy, 'packageMayRetireLegacyMainPath = false'],
  [policy, 'packageMayDeleteLegacyCursor = false'],
  [policy, 'keyboardMutationAllowed = false'],
  [policy, 'appShellMutationAllowed = false'],
  [policy, 'graphHistorySolutionUiMutationAllowed = false'],
  [policy, 'fakeDeviceEvidenceAllowed = false'],
  [policy, 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED'],
  [q94, "static const String phase = 'V172-Q94'"],
  [q106, "static const String phase = 'V172-Q106'"],
  [q107, "static const String phase = 'V172-Q107'"],
  [manifest, '"q108RealDeviceCursorCourtExecutionPhase": "V172-Q108"'],
  [manifest, '"q108ExecutionPackageOnly": true'],
  [manifest, '"q108MayClaimCursorPass": false'],
  [manifest, '"q108MaySwitchMainEditor": false'],
  [manifest, '"q108MayDeleteLegacyCursor": false'],
  [manifest, '"q108VerifierScript": "tool/verify_mathlive_real_device_cursor_court_execution.mjs"'],
  [contract, 'q108RealDeviceCursorCourtExecutionRule'],
  [readme, 'V172-Q108 Real Device MathLive Cursor Court Execution Package'],
  [audit, 'Q108 turns the Q94 real-device MathLive cursor court into an execution/capture package'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, needle] of requiredMarkers) {
  if (!marker(text, needle)) blockers.push(`missing marker: ${needle}`);
}

for (const scenario of q108ScenarioIds) {
  if (!policy.includes(`id: '${scenario}'`)) blockers.push(`Q108 scenario missing from policy: ${scenario}`);
  if (!q94.includes(`'${scenario}'`)) blockers.push(`Q94 protocol missing matching scenario: ${scenario}`);
}

const requiredCommands = [
  'flutter pub get',
  'flutter analyze',
  'flutter test',
  'node tool/verify_mathlive_official_runtime_bundle.mjs',
  'node tool/verify_mathlive_lab_smoke_evidence_closure.mjs',
  'node tool/verify_mathlive_main_workspace_mount_flag.mjs',
  'node tool/verify_mathlive_main_keyboard_bridge.mjs',
  'node tool/verify_mathlive_real_device_cursor_court_execution.mjs',
  'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA',
  'flutter run -d 23106RN0DA',
];
for (const command of requiredCommands) {
  if (!policy.includes(command) || !readme.includes(command)) blockers.push(`Q108 required command missing from policy/readme: ${command}`);
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'packageMayClaimDevicePass = true',
  'packageMayClaimCursorPass = true',
  'packageMaySwitchMainEditor = true',
  'packageMayEnableMathLiveByDefault = true',
  'packageMayRetireLegacyMainPath = true',
  'packageMayDeleteLegacyCursor = true',
  'keyboardMutationAllowed = true',
  'appShellMutationAllowed = true',
  'graphHistorySolutionUiMutationAllowed = true',
  'protectedUiSurfaceMutationAllowed = true',
  'fakeRuntimeEvidenceAllowed = true',
  'fakeSmokeEvidenceAllowed = true',
  'fakeDeviceEvidenceAllowed = true',
  'mathLiveVirtualKeyboardEnabled = true',
  'remoteScriptLoadingAllowed = true',
  '"q108MayClaimCursorPass": true',
  '"q108MaySwitchMainEditor": true',
  '"q108MayEnableMathLiveByDefault": true',
  '"q108MayDeleteLegacyCursor": true',
  '"q108MayMutateKeyboard": true',
  '"q108MayMutateAppShell": true',
  '"q108MayMutateGraphHistorySolutionUi": true',
];
for (const forbidden of forbiddenMarkers) {
  if (combined.includes(forbidden)) blockers.push(`forbidden enabled marker present: ${forbidden}`);
}

for (const rel of protectedFiles) {
  const text = safeRead(rel);
  if (text.includes('V172-Q108')) blockers.push(`Q108 marker leaked into protected file: ${rel}`);
}

const q101Report = parseRelJson('tool/reports/mathlive_lab_smoke_evidence_closure_report.json');
const q100Report = parseRelJson('tool/reports/mathlive_official_runtime_bundle_report.json');
const q106Report = parseRelJson('tool/reports/mathlive_main_workspace_mount_flag_report.json');
const q107Report = parseRelJson('tool/reports/mathlive_main_keyboard_bridge_report.json');
const capture = fs.existsSync(captureJson) ? parseJsonFile(captureJson) : null;
const flutterEvidence = fs.existsSync(flutterEvidenceJson) ? parseJsonFile(flutterEvidenceJson) : null;

const q101Closed = q101Report?.labSmokeEvidenceClosed === true || q101Report?.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE_READY';
const officialRuntimeVerified = q100Report?.officialRuntimeBundleClosed === true || q100Report?.status === 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE_READY';
const q106PackageReady = q106Report?.staticContractPasses === true || q106Report?.status === 'MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED' || q106Report?.status === 'MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_READY_BEHIND_INTERNAL_FLAG';
const q107PackageReady = q107Report?.packageSideMainKeyboardBridgeReady === true || q107Report?.status === 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED' || q107Report?.status === 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_READY_BEHIND_INTERNAL_FLAG';
const flutterAnalyzePassed = flutterEvidence?.flutterAnalyzePassed === true;
const flutterTestPassed = flutterEvidence?.flutterTestPassed === true;
const labDeviceRunCaptured = flutterEvidence?.labDeviceRunCaptured === true || capture?.labDeviceRunCaptured === true;
const mainDeviceRunCaptured = flutterEvidence?.mainDeviceRunCaptured === true || capture?.mainDeviceRunCaptured === true;

if (!q101Closed) runtimeBlockers.push('Q101 Lab smoke evidence closure has not passed');
if (!officialRuntimeVerified) runtimeBlockers.push('official MathLive runtime bundle is not verified');
if (!q106PackageReady) runtimeBlockers.push('Q106 main-workspace mount flag report is absent or not package-ready');
if (!q107PackageReady) runtimeBlockers.push('Q107 main keyboard bridge report is absent or not package-ready');
if (!flutterAnalyzePassed) runtimeBlockers.push('flutter analyze PASS evidence is missing');
if (!flutterTestPassed) runtimeBlockers.push('flutter test PASS evidence is missing');
if (!labDeviceRunCaptured) runtimeBlockers.push('real-device MathLive Lab run capture is missing');
if (!mainDeviceRunCaptured) runtimeBlockers.push('real-device main app run capture is missing');

let scenarioPassCount = 0;
let blockingFailureCount = Number.isFinite(capture?.blockingFailureCount) ? capture.blockingFailureCount : 0;
if (!capture) {
  runtimeBlockers.push('Q108 scenario capture JSON is missing');
} else if (!capture.scenarioResults || typeof capture.scenarioResults !== 'object') {
  runtimeBlockers.push('Q108 scenarioResults object is missing');
} else {
  for (const scenario of q108ScenarioIds) {
    if (!(scenario in capture.scenarioResults)) runtimeBlockers.push(`Q108 scenario evidence missing: ${scenario}`);
    if (capture.scenarioResults[scenario] === true) scenarioPassCount += 1;
  }
  if (scenarioPassCount < q108ScenarioIds.length) runtimeBlockers.push(`only ${scenarioPassCount}/${q108ScenarioIds.length} Q108 scenarios passed`);
}
if (blockingFailureCount > 0) runtimeBlockers.push(`${blockingFailureCount} blocking cursor/focus failures recorded`);

const packageReady = blockers.length === 0;
const realDeviceEvidenceComplete = packageReady && runtimeBlockers.length === 0;
const report = {
  phase: 'V172-Q108',
  status: realDeviceEvidenceComplete
    ? 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_READY_FOR_REVIEW'
    : packageReady
      ? 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED'
      : 'BLOCKED_MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE',
  packageSideExecutionReady: packageReady,
  q94ScenarioCount: q108ScenarioIds.length,
  q108ScenarioIds,
  q101LabSmokeEvidenceClosed: q101Closed,
  officialRuntimeVerified,
  q106MountFlagPackageReady: q106PackageReady,
  q107MainKeyboardBridgePackageReady: q107PackageReady,
  flutterAnalyzePassed,
  flutterTestPassed,
  labDeviceRunCaptured,
  mainDeviceRunCaptured,
  scenarioCaptureProvided: Boolean(capture),
  scenarioPassCount,
  requiredScenarioCount: q108ScenarioIds.length,
  blockingFailureCount,
  realDeviceCourtEvidenceComplete: realDeviceEvidenceComplete,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayRetireLegacyMainPath: false,
  mayDeleteLegacyCursor: false,
  mayMutateKeyboard: false,
  mayMutateAppShell: false,
  mayMutateGraphHistorySolutionUi: false,
  blockers: [...blockers, ...runtimeBlockers],
  warnings,
};

fs.writeFileSync(reportJson, JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(reportMd, `# MathLive Real Device Cursor Court Execution Report\n\n- Phase: ${report.phase}\n- Status: ${report.status}\n- Package-side execution ready: ${report.packageSideExecutionReady}\n- Real-device evidence complete: ${report.realDeviceCourtEvidenceComplete}\n- Scenario pass count: ${report.scenarioPassCount}/${report.requiredScenarioCount}\n- Blockers: ${report.blockers.length}\n\n${report.blockers.map((b) => `- ${b}`).join('\n')}\n`);

console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
