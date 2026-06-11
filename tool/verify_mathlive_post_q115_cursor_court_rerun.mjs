import fs from 'node:fs';
import path from 'node:path';
import process from 'node:process';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_post_q115_cursor_court_rerun.mjs', retiredPhase: 'verify_mathlive_post_q115_cursor_court_rerun', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const reportDir = path.join(root, 'tool', 'reports');
fs.mkdirSync(reportDir, { recursive: true });

const reportJson = path.join(reportDir, 'mathlive_post_q115_cursor_court_rerun_report.json');
const reportMd = path.join(reportDir, 'mathlive_post_q115_cursor_court_rerun_report.md');
const captureJson = path.join(reportDir, 'mathlive_post_q115_cursor_court_rerun_capture.json');
const flutterEvidenceJson = path.join(reportDir, 'mathlive_real_device_cursor_court_flutter_evidence.json');

const requiredFiles = [
  'lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart',
  'lib/features/formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart',
  'lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart',
  'tool/verify_mathlive_post_q115_cursor_court_rerun.mjs',
  'tool/verify_mathlive_structural_caret_anchor_geometry_repair.mjs',
  'tool/verify_mathlive_real_device_cursor_court_execution.mjs',
  'test/v172_q116_post_q115_cursor_court_rerun_test.dart',
  'docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_AUDIT_REPORT.md',
  'docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CHANGED_FILES_MANIFEST.md',
  'docs/evidence/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CAPTURE_TEMPLATE.json',
];

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

const scenarioIds = [
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

function abs(rel) { return path.join(root, rel); }
function exists(rel) { return fs.existsSync(abs(rel)); }
function read(rel) { return fs.readFileSync(abs(rel), 'utf8'); }
function safeRead(rel) { return exists(rel) ? read(rel) : ''; }
function parseJsonFile(file) {
  try { return JSON.parse(fs.readFileSync(file, 'utf8')); } catch { return null; }
}
function parseRelJson(rel) { return exists(rel) ? parseJsonFile(abs(rel)) : null; }

const structuralBlockers = [];
const evidenceBlockers = [];
const warnings = [];

for (const rel of requiredFiles) {
  if (!exists(rel)) structuralBlockers.push(`missing required Q116 file: ${rel}`);
}

const policy = safeRead('lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart');
const manifest = safeRead('assets/mathlive/manifest.json');
const contract = safeRead('lib/logic/mathpro_package_contract.dart');
const readme = safeRead('README.md');
const audit = safeRead('docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_AUDIT_REPORT.md');
const changed = safeRead('docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CHANGED_FILES_MANIFEST.md');
const q115Policy = safeRead('lib/features/formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart');
const q108Policy = safeRead('lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart');

const requiredMarkers = [
  [policy, "phase = 'V172-Q116'"],
  [policy, "repairPhaseUnderTest = 'V172-Q115'"],
  [policy, 'stalePreQ115CaptureAllowed = false'],
  [policy, 'q115StructuralRepairRequired = true'],
  [policy, 'allTwelveQ108ScenariosRequired = true'],
  [policy, 'maximumBlockingFailures = 0'],
  [policy, 'mayClaimCursorPass = false'],
  [policy, 'maySwitchMainEditor = false'],
  [policy, 'mayRetireLegacyMainPath = false'],
  [policy, 'mayDeleteLegacyCursor = false'],
  [policy, 'mayMutateKeyboard = false'],
  [policy, 'mayCreateFakeDeviceEvidence = false'],
  [policy, 'Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'],
  [q115Policy, 'mathpro-v172q115-structural-caret-anchor-geometry-repair-guard-v1'],
  [q108Policy, "phase = 'V172-Q108'"],
  [manifest, '"q116PostQ115CursorCourtRerunPhase": "V172-Q116"'],
  [manifest, '"q116RequiresQ115StructuralRepair": true'],
  [manifest, '"q116StalePreQ115CaptureAllowed": false'],
  [manifest, '"q116RequiredScenarioCount": 12'],
  [manifest, '"q116MayClaimCursorPass": false'],
  [manifest, '"q116MaySwitchMainEditor": false'],
  [manifest, '"q116MayDeleteLegacyCursor": false'],
  [contract, 'q116PostQ115CursorCourtRerunRule'],
  [readme, 'V172-Q116 — Post-Q115 Real-Device Cursor Court Rerun Gate'],
  [audit, 'Q116 is the stale-evidence shield after Q115'],
  [changed, 'Protected files intentionally untouched'],
];
for (const [text, marker] of requiredMarkers) {
  if (!text.includes(marker)) structuralBlockers.push(`missing Q116 marker: ${marker}`);
}

for (const scenarioId of scenarioIds) {
  if (!q108Policy.includes(`id: '${scenarioId}'`)) {
    structuralBlockers.push(`Q108 policy missing scenario: ${scenarioId}`);
  }
}

const combined = [policy, manifest, contract, readme, audit, changed].join('\n');
const forbiddenMarkers = [
  'mayClaimCursorPass = true',
  'maySwitchMainEditor = true',
  'mayEnableMathLiveByDefault = true',
  'mayRetireLegacyMainPath = true',
  'mayDeleteLegacyCursor = true',
  'mayMutateKeyboard = true',
  'mayMutateAppShell = true',
  'mayMutateGraphHistorySolutionUi = true',
  'mayCreateFakeRuntimeEvidence = true',
  'mayCreateFakeSmokeEvidence = true',
  'mayCreateFakeDeviceEvidence = true',
  'stalePreQ115CaptureAllowed = true',
  '"q116MayClaimCursorPass": true',
  '"q116MaySwitchMainEditor": true',
  '"q116MayEnableMathLiveByDefault": true',
  '"q116MayDeleteLegacyCursor": true',
  '"q116StalePreQ115CaptureAllowed": true',
  '"q116MayMutateKeyboard": true',
  '"q116MayMutateAppShell": true',
  '"q116MayMutateGraphHistorySolutionUi": true',
  '"q116CreatesFakeDeviceEvidence": true',
];
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) structuralBlockers.push(`forbidden Q116 enabled marker present: ${marker}`);
}

for (const rel of protectedFiles) {
  const text = safeRead(rel);
  if (text.includes('V172-Q116') || text.includes('q116PostQ115CursorCourtRerun')) {
    structuralBlockers.push(`Q116 marker leaked into protected file: ${rel}`);
  }
}

const q115Report = parseRelJson('tool/reports/mathlive_structural_caret_anchor_geometry_repair_report.json');
const q108Report = parseRelJson('tool/reports/mathlive_real_device_cursor_court_execution_report.json');
const q101Report = parseRelJson('tool/reports/mathlive_lab_smoke_evidence_closure_report.json');
const q100Report = parseRelJson('tool/reports/mathlive_official_runtime_bundle_report.json');
const capture = fs.existsSync(captureJson) ? parseJsonFile(captureJson) : null;
const flutterEvidence = fs.existsSync(flutterEvidenceJson) ? parseJsonFile(flutterEvidenceJson) : null;

const q115Ready = q115Report?.status === 'Q115_STRUCTURAL_CARET_ANCHOR_GEOMETRY_REPAIR_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED' || q115Report?.q108RealDeviceCourtStillRequired === true;
const q108Ready = q108Report?.packageSideExecutionReady === true || q108Report?.status === 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED' || q108Report?.status === 'MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_READY_FOR_REVIEW';
const q101Closed = q101Report?.labSmokeEvidenceClosed === true || q101Report?.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT' || q101Report?.status === 'MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE_READY';
const officialRuntimeVerified = q100Report?.officialRuntimeBundleClosed === true || q100Report?.status === 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSED_FOR_SMOKE_EVIDENCE' || q100Report?.status === 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE_READY';
const flutterAnalyzePassed = flutterEvidence?.flutterAnalyzePassed === true;
const flutterTestPassed = flutterEvidence?.flutterTestPassed === true;
const labDeviceRunCaptured = flutterEvidence?.labDeviceRunCaptured === true || capture?.labDeviceRunCaptured === true;
const mainDeviceRunCaptured = flutterEvidence?.mainDeviceRunCaptured === true || capture?.mainDeviceRunCaptured === true;
const captureReferencesQ115Repair = capture?.repairPhaseUnderTest === 'V172-Q115' && capture?.postQ115StructuralCaretAnchorGeometryRepairRetested === true;
const structuralCaretMisalignmentAbsent = capture?.structuralCaretMisalignmentAbsent === true && capture?.observedFailureClass !== 'caret-anchor-geometry-misalignment';
const blockingFailureCount = Number.isFinite(capture?.blockingFailureCount) ? capture.blockingFailureCount : 0;

if (!q115Ready) evidenceBlockers.push('Q115 structural caret anchor geometry repair report is absent or not package-ready');
if (!q108Ready) evidenceBlockers.push('Q108 real-device cursor court execution report is absent or not package-ready');
if (!q101Closed) evidenceBlockers.push('Q101 Lab smoke evidence closure has not passed');
if (!officialRuntimeVerified) evidenceBlockers.push('official MathLive runtime bundle is not verified');
if (!flutterAnalyzePassed) evidenceBlockers.push('flutter analyze PASS evidence is missing');
if (!flutterTestPassed) evidenceBlockers.push('flutter test PASS evidence is missing');
if (!labDeviceRunCaptured) evidenceBlockers.push('post-Q115 real-device MathLive Lab run capture is missing');
if (!mainDeviceRunCaptured) evidenceBlockers.push('post-Q115 real-device main app run capture is missing');

let scenarioPassCount = 0;
if (!capture) {
  evidenceBlockers.push('post-Q115 Q108 scenario capture JSON is missing');
} else if (!capture.scenarioResults || typeof capture.scenarioResults !== 'object') {
  evidenceBlockers.push('post-Q115 scenarioResults object is missing');
} else {
  for (const scenarioId of scenarioIds) {
    if (!(scenarioId in capture.scenarioResults)) evidenceBlockers.push(`post-Q115 scenario evidence missing: ${scenarioId}`);
    if (capture.scenarioResults[scenarioId] === true) scenarioPassCount += 1;
  }
  if (scenarioPassCount < scenarioIds.length) evidenceBlockers.push(`only ${scenarioPassCount}/${scenarioIds.length} post-Q115 scenarios passed`);
}
if (!captureReferencesQ115Repair) evidenceBlockers.push('capture does not explicitly reference V172-Q115 as the repair under test');
if (!structuralCaretMisalignmentAbsent) evidenceBlockers.push('structural caret anchor/geometry misalignment is still recorded or not explicitly cleared');
if (blockingFailureCount > 0) evidenceBlockers.push(`${blockingFailureCount} blocking post-Q115 cursor/focus failures recorded`);

const packageReady = structuralBlockers.length === 0 && q115Ready && q108Ready;
const evidenceComplete = packageReady && evidenceBlockers.length === 0;
const status = evidenceComplete
  ? 'Q116_POST_Q115_CURSOR_COURT_RERUN_READY_FOR_HUMAN_REVIEW'
  : packageReady
    ? 'Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
    : 'BLOCKED_Q116_POST_Q115_CURSOR_COURT_RERUN_PACKAGE';

const report = {
  phase: 'V172-Q116',
  status,
  packageReady,
  q115StructuralRepairPackageReady: q115Ready,
  q108ExecutionPackageReady: q108Ready,
  q101LabSmokeEvidenceClosed: q101Closed,
  officialRuntimeVerified,
  flutterAnalyzePassed,
  flutterTestPassed,
  labDeviceRunCaptured,
  mainDeviceRunCaptured,
  postQ115CaptureProvided: Boolean(capture),
  captureReferencesQ115Repair,
  structuralCaretMisalignmentAbsent,
  scenarioPassCount,
  requiredScenarioCount: scenarioIds.length,
  blockingFailureCount,
  postQ115EvidenceComplete: evidenceComplete,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayRetireLegacyMainPath: false,
  mayDeleteLegacyCursor: false,
  mayMutateKeyboard: false,
  mayMutateAppShell: false,
  mayMutateGraphHistorySolutionUi: false,
  structuralBlockers,
  evidenceBlockers,
  blockers: [...structuralBlockers, ...evidenceBlockers],
  warnings,
};

fs.writeFileSync(reportJson, `${JSON.stringify(report, null, 2)}\n`);
fs.writeFileSync(reportMd,
  `# V172-Q116 Post-Q115 Cursor Court Rerun Report\n\n` +
  `- Status: ${status}\n` +
  `- Package ready: ${packageReady}\n` +
  `- Post-Q115 evidence complete: ${evidenceComplete}\n` +
  `- Scenario pass count: ${scenarioPassCount}/${scenarioIds.length}\n` +
  `- Cursor PASS claimed: false\n` +
  `- Main-editor switch allowed: false\n` +
  `- Legacy cursor deletion allowed: false\n\n` +
  `## Blockers\n\n` +
  (report.blockers.length ? report.blockers.map((b) => `- ${b}`).join('\n') : '- none') +
  '\n'
);

console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 1);
