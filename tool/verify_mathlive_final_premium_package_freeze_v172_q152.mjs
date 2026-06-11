#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_final_premium_package_freeze_v172_q152.mjs', retiredPhase: 'verify_mathlive_final_premium_package_freeze_v172_q152', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    const rel = path.relative(root, full).replace(/\\/g, '/');
    out.push(rel);
    if (entry.isDirectory()) walk(full, out);
  }
  return out;
}
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_final_premium_package_freeze_policy.dart',
  'test/v172_q152_mathlive_final_premium_package_freeze_test.dart',
  'tool/verify_mathlive_final_premium_package_freeze_v172_q152.mjs',
  'assets/mathlive/manifest.json',
  'README.md',
  'docs/audit/V172_Q152_MATHLIVE_FINAL_PREMIUM_PACKAGE_FREEZE_AUDIT_REPORT.md',
  'docs/audit/V172_Q152_CHANGED_FILES_MANIFEST.md',
  'docs/evidence/V172_Q152_REAL_DEVICE_PREMIUM_QA_CHECKLIST_TEMPLATE.json'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const priorVerifierScripts = [
  'tool/verify_mathlive_full_main_editor_migration_v172_q135_q139.mjs',
  'tool/verify_mathlive_premium_surface_repair_v172_q140.mjs',
  'tool/verify_mathlive_premium_visual_refinement_v172_q141.mjs',
  'tool/verify_mathlive_semantic_template_coverage_v172_q142.mjs',
  'tool/verify_mathlive_pointer_caret_fluidity_v172_q143.mjs',
  'tool/verify_mathlive_main_editor_state_authority_v172_q144.mjs',
  'tool/verify_mathlive_premium_template_layout_v172_q145.mjs',
  'tool/verify_mathlive_runtime_sync_binding_v172_q146.mjs',
  'tool/verify_mathlive_viewport_fit_v172_q148.mjs',
  'tool/verify_mathlive_visual_chrome_contract_v172_q149.mjs',
  'tool/verify_mathpro_popup_premium_fit_v172_q150.mjs',
  'tool/verify_mathlive_extended_template_court_v172_q151.mjs'
];
for (const rel of priorVerifierScripts) if (!exists(rel)) blockers.push(`missing prior verifier ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const test = exists(required[1]) ? read(required[1]) : '';
const manifestRaw = exists(required[3]) ? read(required[3]) : '{}';
let manifest = {};
try { manifest = JSON.parse(manifestRaw); } catch (error) { blockers.push(`manifest JSON parse failed: ${error.message}`); }
const readme = exists('README.md') ? read('README.md') : '';
const evidenceRaw = exists('docs/evidence/V172_Q152_REAL_DEVICE_PREMIUM_QA_CHECKLIST_TEMPLATE.json') ? read('docs/evidence/V172_Q152_REAL_DEVICE_PREMIUM_QA_CHECKLIST_TEMPLATE.json') : '{}';
let evidence = {};
try { evidence = JSON.parse(evidenceRaw); } catch (error) { blockers.push(`Q152 evidence template JSON parse failed: ${error.message}`); }
const mustContain = [
  [policy, "phase = 'V172-Q152'"],
  [policy, 'patchOnlyDeliveryAllowed = false'],
  [policy, 'staleStandardZipAllowed = false'],
  [policy, 'protectedKeyboardLayoutMutationAllowed = false'],
  [policy, 'protectedLongPressOrderMutationAllowed = false'],
  [policy, 'graphHistorySolutionUiMutationAllowed = false'],
  [policy, 'legacyFlutterCursorOverlayMayReturn = false'],
  [policy, 'mathLiveVisibleChromeAllowed = false'],
  [policy, 'rawNamedTemplateTextFallbackAllowed = false'],
  [policy, 'fakeRuntimeEvidenceAllowed = false'],
  [policy, 'flutterAnalyzePassClaimedByAssistant = false'],
  [policy, 'flutterTestPassClaimedByAssistant = false'],
  [policy, 'flutterRunPassClaimedByAssistant = false'],
  [policy, 'photomathLevelClaimed = false'],
  [test, 'MathLiveFinalPremiumPackageFreezePolicy.phase'],
  [readme, 'V172-Q152 — MathLive Final Premium Package Freeze']
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'patchOnlyDeliveryAllowed = true'],
  [policy, 'staleStandardZipAllowed = true'],
  [policy, 'protectedKeyboardLayoutMutationAllowed = true'],
  [policy, 'protectedLongPressOrderMutationAllowed = true'],
  [policy, 'graphHistorySolutionUiMutationAllowed = true'],
  [policy, 'legacyFlutterCursorOverlayMayReturn = true'],
  [policy, 'mathLiveVisibleChromeAllowed = true'],
  [policy, 'rawNamedTemplateTextFallbackAllowed = true'],
  [policy, 'fakeRuntimeEvidenceAllowed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'cursorPassClaimed = true']
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
if (manifest.activePhase !== 'V172-Q152-MATHLIVE-FINAL-PREMIUM-PACKAGE-FREEZE') blockers.push(`manifest activePhase is ${manifest.activePhase}`);
if (manifest.currentPhase !== 'V172-Q152-MATHLIVE-FINAL-PREMIUM-PACKAGE-FREEZE') blockers.push(`manifest currentPhase is ${manifest.currentPhase}`);
if (!manifest.v172Q152FinalPremiumPackageFreeze) blockers.push('missing manifest v172Q152FinalPremiumPackageFreeze');
if (manifest.v172Q152FinalPremiumPackageFreeze) {
  const q152 = manifest.v172Q152FinalPremiumPackageFreeze;
  const bools = [
    'patchOnlyDeliveryAllowed',
    'staleStandardZipAllowed',
    'protectedKeyboardLayoutMutationAllowed',
    'protectedLongPressOrderMutationAllowed',
    'graphHistorySolutionUiMutationAllowed',
    'legacyFlutterCursorOverlayMayReturn',
    'mathLiveVisibleChromeAllowed',
    'rawNamedTemplateTextFallbackAllowed',
    'fakeRuntimeEvidenceAllowed',
    'flutterAnalyzePassClaimedByAssistant',
    'flutterTestPassClaimedByAssistant',
    'flutterRunPassClaimedByAssistant',
    'cursorPassClaimed',
    'realDevicePassClaimed',
    'photomathLevelClaimed'
  ];
  if (q152.phase !== 'V172-Q152') blockers.push('Q152 manifest phase mismatch');
  for (const key of bools) if (q152[key] !== false) blockers.push(`Q152 manifest ${key} must be false`);
  if (q152.requiresUserSideFinalCourt !== true) blockers.push('Q152 manifest requiresUserSideFinalCourt must be true');
}
if (evidence.phase !== 'V172-Q152') blockers.push('Q152 evidence template phase mismatch');
if (evidence.realDevicePassClaimed !== false) blockers.push('Q152 evidence template must not claim real-device PASS');
if (evidence.photomathLevelClaimed !== false) blockers.push('Q152 evidence template must not claim Photomath PASS');
const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart'
];
for (const rel of protectedFiles) {
  if (!exists(rel)) blockers.push(`protected file missing: ${rel}`);
  else if (read(rel).includes('V172-Q152')) blockers.push(`protected file contains Q152 mutation marker: ${rel}`);
}
const allPaths = walk(root);
const userSideGeneratedPathPatterns = [
  /(^|\/)build(\/|$)/,
  /(^|\/)\.dart_tool(\/|$)/
];
const userSideGeneratedPaths = [];
const forbiddenPathPatterns = [
  /(^|\/)\.gradle(\/|$)/,
  /(^|\/)\.idea(\/|$)/,
  /(^|\/)node_modules(\/|$)/,
  /(^|\/)__pycache__(\/|$)/,
  /(^|\/)\.pytest_cache(\/|$)/,
  /\.pyc$/,
  /\.DS_Store$/,
  /(^|\/)tmp(\/|$)/,
  /(^|\/)temp(\/|$)/
];
for (const rel of allPaths) {
  if (userSideGeneratedPathPatterns.some((pattern) => pattern.test(rel))) {
    userSideGeneratedPaths.push(rel);
    continue;
  }
  if (forbiddenPathPatterns.some((pattern) => pattern.test(rel))) blockers.push(`forbidden hygiene path: ${rel}`);
}
const rootNestedArchives = allPaths.filter((rel) => /\.(zip|tar|gz|7z|rar)$/i.test(rel));
if (rootNestedArchives.length > 0) blockers.push(`nested archive(s) found: ${rootNestedArchives.join(', ')}`);
const officialRuntimePresent = exists('assets/mathlive/vendor/mathlive/mathlive.min.js');
if (!officialRuntimePresent && manifest.officialMathLiveRuntimeBundled === true) blockers.push('manifest claims official runtime bundled but mathlive.min.js is absent');
const status = blockers.length === 0
  ? 'MATHLIVE_FINAL_PREMIUM_PACKAGE_FREEZE_READY_BUT_USER_SIDE_DEVICE_COURT_REQUIRED'
  : 'BLOCKED_MATHLIVE_FINAL_PREMIUM_PACKAGE_FREEZE';
const report = {
  phase: 'V172-Q152',
  status,
  blockers,
  packageFreezeReady: blockers.length === 0,
  userSideDeviceCourtRequired: true,
  packageHygieneChecked: true,
  priorVerifierChainChecked: true,
  fakePassClaimsAllowed: false,
  realDevicePassClaimed: false,
  photomathLevelClaimed: false,
  officialRuntimeBundled: officialRuntimePresent,
  userSideGeneratedPathCount: userSideGeneratedPaths.length,
  userSideGeneratedPathsIgnoredForWorkspaceVerification: userSideGeneratedPaths.slice(0, 24),
  note: 'This is a package-side freeze only. Flutter analyze/test/run and visual/caret quality require user-side execution.'
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_final_premium_package_freeze_v172_q152_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_final_premium_package_freeze_v172_q152_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
