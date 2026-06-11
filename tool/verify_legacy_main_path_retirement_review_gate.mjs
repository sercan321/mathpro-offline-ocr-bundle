#!/usr/bin/env node
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { spawnSync } from 'node:child_process';

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = dirname(__dirname);
const reportDir = join(root, 'tool', 'reports');
const reportJson = join(reportDir, 'legacy_main_path_retirement_review_gate_report.json');
const reportMarkdown = join(reportDir, 'legacy_main_path_retirement_review_gate_report.md');

function read(rel) {
  const p = join(root, rel);
  return existsSync(p) ? readFileSync(p, 'utf8') : '';
}

function fileExists(rel) {
  return existsSync(join(root, rel));
}

function has(rel, marker) {
  return read(rel).includes(marker);
}

function readJson(rel) {
  const p = join(root, rel);
  if (!existsSync(p)) return null;
  try { return JSON.parse(readFileSync(p, 'utf8')); } catch { return null; }
}

function runNodeScript(script) {
  if (!existsSync(join(root, script))) {
    return { script, exitCode: 127, status: 'MISSING_SCRIPT' };
  }
  const result = spawnSync(process.execPath, [script], { cwd: root, encoding: 'utf8' });
  return {
    script,
    exitCode: result.status ?? 1,
    stdout: (result.stdout || '').trim(),
    stderr: (result.stderr || '').trim(),
  };
}

const requiredFiles = [
  'lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart',
  'tool/verify_legacy_main_path_retirement_review_gate.mjs',
  'test/v172_q120_legacy_main_path_retirement_review_gate_test.dart',
  'docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_AUDIT_REPORT.md',
  'docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_CHANGED_FILES_MANIFEST.md',
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

const requiredMarkers = [
  ['lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart', "phase = 'V172-Q120'"],
  ['lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart', 'reviewGateOnly = true'],
  ['lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart', 'actualLegacyMainPathRetirementImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart', 'legacyCursorPhysicalDeletionImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart', 'mathLiveDefaultSwitchImplementedInThisPackage = false'],
  ['lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart', 'Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'],
  ['assets/mathlive/manifest.json', '"q120LegacyMainPathRetirementReviewGatePhase": "V172-Q120"'],
  ['assets/mathlive/manifest.json', '"q120ActualLegacyRetirementImplemented": false'],
  ['assets/mathlive/manifest.json', '"q120LegacyCursorPhysicalDeletionImplemented": false'],
  ['assets/mathlive/manifest.json', '"q120MathLiveEnabledByDefault": false'],
  ['assets/mathlive/manifest.json', '"q120MayRetireLegacyMainPathNow": false'],
  ['assets/mathlive/manifest.json', '"q120MayDeleteLegacyCursor": false'],
  ['assets/mathlive/manifest.json', '"q120MaySwitchDefaultEditorNow": false'],
  ['assets/mathlive/manifest.json', '"q120CreatesFakeRuntimeEvidence": false'],
  ['assets/mathlive/manifest.json', '"q120CreatesFakeDeviceEvidence": false'],
  ['lib/logic/mathpro_package_contract.dart', 'q120LegacyMainPathRetirementReviewGateRule'],
  ['README.md', 'V172-Q120 — Legacy Main Path Retirement Review Gate'],
  ['docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_AUDIT_REPORT.md', 'Q120 is a review gate only; it does not retire the legacy main path'],
  ['docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_CHANGED_FILES_MANIFEST.md', 'Protected files intentionally untouched'],
];

const forbiddenMarkers = [
  'actualLegacyMainPathRetirementImplementedInThisPackage = true',
  'legacyCursorPhysicalDeletionImplementedInThisPackage = true',
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
  'fakeRetirementApprovalAllowed = true',
  'cursorPassClaimAllowedInThisPackage = true',
  'releasePassClaimAllowedInThisPackage = true',
  '"q120ActualLegacyRetirementImplemented": true',
  '"q120LegacyCursorPhysicalDeletionImplemented": true',
  '"q120MathLiveEnabledByDefault": true',
  '"q120MayRetireLegacyMainPathNow": true',
  '"q120MayDeleteLegacyCursor": true',
  '"q120MaySwitchDefaultEditorNow": true',
  '"q120MayClaimCursorPass": true',
  '"q120MayClaimReleasePass": true',
  '"q120CreatesFakeRuntimeEvidence": true',
  '"q120CreatesFakeDeviceEvidence": true',
  '"q120CreatesFakeRetirementApproval": true',
];

const q119Run = runNodeScript('tool/verify_mathlive_graph_history_solution_runtime_binding_gate.mjs');
const q119Report = readJson('tool/reports/mathlive_graph_history_solution_runtime_binding_gate_report.json');
const q119PackageReady = q119Report?.packageReady === true || typeof q119Report?.status === 'string' && q119Report.status.includes('PACKAGE_READY');

const blockers = [];
for (const rel of requiredFiles) {
  if (!fileExists(rel)) blockers.push(`missing required Q120 file: ${rel}`);
}
for (const [rel, marker] of requiredMarkers) {
  if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
}
const combined = [
  read('assets/mathlive/manifest.json'),
  read('lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart'),
  read('README.md'),
].join('\n');
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) blockers.push(`forbidden enabled Q120 marker present: ${marker}`);
}
for (const rel of protectedFiles) {
  const source = read(rel);
  if (source.includes('V172-Q120') || source.includes('q120LegacyMainPathRetirementReview')) {
    blockers.push(`Q120 marker found in protected file: ${rel}`);
  }
}
if (!q119PackageReady) blockers.push('Q119 runtime binding gate package is not ready');

const packageReady = blockers.length === 0;
const reviewEvidenceComplete = false;
const report = {
  phase: 'V172-Q120',
  status: packageReady
    ? 'Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE',
  packageReady,
  reviewEvidenceComplete,
  blockers,
  selectedDefaultEngine: 'legacyFlutterSlotEditor',
  candidateEngine: 'mathlive',
  rollbackEngine: 'legacyFlutterSlotEditor',
  q119PackageReady,
  q119Run,
  q119ReportStatus: q119Report?.status ?? null,
  requiredEvidenceBeforeRetirementReview: [
    'Q119 runtime binding evidence complete',
    'Q119 human review approval',
    'explicit Q120 legacy main-path retirement review approval',
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
  mayRetireLegacyMainPathNow: false,
  mayDeleteLegacyCursor: false,
  maySwitchDefaultEditorNow: false,
  mayMountMathLiveInMainWorkspaceNow: false,
  mayProceedToPhysicalCleanupPlanning: false,
  mayClaimCursorPass: false,
  mayClaimReleasePass: false,
  protectedSurfacesUntouchedByPolicy: true,
};

mkdirSync(reportDir, { recursive: true });
writeFileSync(reportJson, `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(reportMarkdown, `# V172-Q120 Legacy Main Path Retirement Review Gate\n\nStatus: ${report.status}\n\nPackage ready: ${report.packageReady}\nReview evidence complete: ${report.reviewEvidenceComplete}\n\nMay retire legacy main path now: ${report.mayRetireLegacyMainPathNow}\nMay delete legacy cursor: ${report.mayDeleteLegacyCursor}\nMay switch default editor now: ${report.maySwitchDefaultEditorNow}\nMay proceed to physical cleanup planning: ${report.mayProceedToPhysicalCleanupPlanning}\n\nBlockers:\n${blockers.length ? blockers.map((b) => `- ${b}`).join('\n') : '- Evidence is intentionally incomplete until user-side runtime/device/human-review reports are provided.'}\n`);

if (!packageReady) {
  console.error(report.status);
  console.error(blockers.join('\n'));
  process.exit(1);
}
console.log(report.status);
