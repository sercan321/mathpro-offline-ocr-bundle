import fs from 'node:fs';
import path from 'node:path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_structural_caret_anchor_geometry_repair.mjs', retiredPhase: 'verify_mathlive_structural_caret_anchor_geometry_repair', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const root = process.cwd();
const reportDir = path.join(root, 'tool', 'reports');
fs.mkdirSync(reportDir, { recursive: true });

function read(rel) {
  return fs.readFileSync(path.join(root, rel), 'utf8');
}
function exists(rel) {
  return fs.existsSync(path.join(root, rel));
}

const requiredFiles = [
  'lib/features/formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart',
  'lib/features/formula_engine/slot_geometry_bundle_authority.dart',
  'lib/features/formula_engine/structural_cursor_release_hardening_policy.dart',
  'lib/features/workspace/editor_caret_overlay.dart',
  'test/v172_q115_structural_caret_anchor_geometry_repair_test.dart',
  'docs/audit/V172_Q115_STRUCTURAL_CARET_ANCHOR_GEOMETRY_REPAIR_AUDIT_REPORT.md',
  'docs/audit/V172_Q115_STRUCTURAL_CARET_ANCHOR_GEOMETRY_REPAIR_CHANGED_FILES_MANIFEST.md',
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

const checks = [];
function pass(name, detail) { checks.push({ name, status: 'PASS', detail }); }
function fail(name, detail) { checks.push({ name, status: 'FAIL', detail }); }

const missing = requiredFiles.filter((rel) => !exists(rel));
if (missing.length) fail('required_q115_files_present', `Missing: ${missing.join(', ')}`);
else pass('required_q115_files_present', 'All Q115 policy/test/audit files are present.');

if (!missing.includes('lib/features/formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart')) {
  const policy = read('lib/features/formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart');
  const requiredMarkers = [
    'mathpro-v172q115-structural-caret-anchor-geometry-repair-guard-v1',
    'structuralCaretAnchorGeometryRepairAvailable = true',
    'emptyPlaceholderLeadingRailLocked = true',
    'caretMayOverlapPlaceholder = false',
    'detachedLinearFallbackCaretAllowed = false',
    'mathLiveMainEditorSwitchAllowedInThisPackage = false',
    'mathLiveDefaultEditorEnabled = false',
    'legacyCursorDeletionAllowed = false',
    'keyboardSurfaceMutationAllowed = false',
    'realDeviceCursorPassClaimed = false',
    'photomathWolframLevelClaimed = false',
    'anchorActiveEmptyCaret',
    'anchorPaintedCaret',
    'isAnchoredPipeBoxCaret',
    'isDetachedFromPlaceholder',
  ];
  const absent = requiredMarkers.filter((marker) => !policy.includes(marker));
  if (absent.length) fail('q115_policy_markers', `Missing markers: ${absent.join(', ')}`);
  else pass('q115_policy_markers', 'Q115 policy blocks fake pass/switch/deletion and exposes anchor guards.');

  const roles = [
    'fractionNumerator', 'fractionDenominator', 'sqrtValue', 'rootIndex', 'powerExponent',
    'subscript', 'logBase', 'functionArgument', 'integralUpperLimit', 'integralLowerLimit',
    'integralBody', 'integralDifferential', 'limitVariable', 'limitTarget', 'limitBody',
  ];
  const missingRoles = roles.filter((role) => !policy.includes(`'${role}'`));
  if (missingRoles.length) fail('q108_failed_roles_covered', `Missing roles: ${missingRoles.join(', ')}`);
  else pass('q108_failed_roles_covered', 'Q108 failed structural role families are covered by Q115.');
}

const bundle = exists('lib/features/formula_engine/slot_geometry_bundle_authority.dart') ? read('lib/features/formula_engine/slot_geometry_bundle_authority.dart') : '';
const hardening = exists('lib/features/formula_engine/structural_cursor_release_hardening_policy.dart') ? read('lib/features/formula_engine/structural_cursor_release_hardening_policy.dart') : '';
const overlay = exists('lib/features/workspace/editor_caret_overlay.dart') ? read('lib/features/workspace/editor_caret_overlay.dart') : '';
const wiringMissing = [];
if (!bundle.includes('MathLiveStructuralCaretAnchorGeometryRepairPolicy.anchorActiveEmptyCaret')) wiringMissing.push('bundle authority final rail guard');
if (!hardening.includes('MathLiveStructuralCaretAnchorGeometryRepairPolicy.anchorPaintedCaret')) wiringMissing.push('structural hardening final paint guard');
if (!overlay.includes('MathLiveStructuralCaretAnchorGeometryRepairPolicy.anchorPaintedCaret')) wiringMissing.push('editor overlay final paint guard');
if (wiringMissing.length) fail('q115_runtime_wiring', `Missing: ${wiringMissing.join(', ')}`);
else pass('q115_runtime_wiring', 'Q115 final anchor guard is wired into bundle, hardening, and overlay paint paths.');

const protectedWithQ115 = protectedFiles.filter((rel) => exists(rel) && read(rel).includes('V172-Q115'));
if (protectedWithQ115.length) fail('protected_surfaces_not_mutated_by_q115', `Q115 marker found in protected files: ${protectedWithQ115.join(', ')}`);
else pass('protected_surfaces_not_mutated_by_q115', 'No Q115 markers found in protected keyboard/UI/Graph/History/Solution surfaces.');

const forbiddenCombined = [bundle, hardening, overlay].join('\n');
const forbiddenMarkers = [
  'mathLiveDefaultEditorEnabled = true',
  'mathLiveMainEditorSwitchAllowedInThisPackage = true',
  'legacyCursorDeletionAllowed = true',
  'realDeviceCursorPassClaimed = true',
  'photomathWolframLevelClaimed = true',
  'paintVisibleSlotOverlay: true',
];
const forbiddenHits = forbiddenMarkers.filter((marker) => forbiddenCombined.includes(marker));
if (forbiddenHits.length) fail('q115_forbidden_claims_absent', `Forbidden enabled markers present: ${forbiddenHits.join(', ')}`);
else pass('q115_forbidden_claims_absent', 'No default-editor switch, legacy deletion, debug overlay, or device PASS claim is enabled.');

const failed = checks.filter((check) => check.status === 'FAIL');
const status = failed.length ? 'BLOCKED_Q115_STRUCTURAL_CARET_ANCHOR_GEOMETRY_REPAIR' : 'Q115_STRUCTURAL_CARET_ANCHOR_GEOMETRY_REPAIR_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED';
const report = {
  phase: 'V172-Q115',
  status,
  blockers: failed.map((check) => check.detail),
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
  q108RealDeviceCourtStillRequired: true,
  checks,
};
fs.writeFileSync(path.join(reportDir, 'mathlive_structural_caret_anchor_geometry_repair_report.json'), `${JSON.stringify(report, null, 2)}\n`);
fs.writeFileSync(
  path.join(reportDir, 'mathlive_structural_caret_anchor_geometry_repair_report.md'),
  `# V172-Q115 Structural Caret Anchor Geometry Repair Report\n\n` +
    `Status: ${status}\n\n` +
    `Cursor PASS claimed: false\n\n` +
    `Main-editor switch allowed: false\n\n` +
    `Legacy cursor deletion allowed: false\n\n` +
    checks.map((check) => `- ${check.status}: ${check.name} — ${check.detail}`).join('\n') +
    '\n'
);

console.log(status);
if (failed.length) {
  for (const check of failed) console.error(`[FAIL] ${check.name}: ${check.detail}`);
  process.exit(1);
}
