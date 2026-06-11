#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_real_device_evidence_intake_v172_q204.mjs', preservedPhase: 'verify_mathlive_real_device_evidence_intake_v172_q204' });

const root = process.cwd();
const phase = 'V172-Q204';
const fullPhase = 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE';
const q204r1FullPhase = 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE';
const q204r2FullPhase = 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE';
const baseline = 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE';

function p(rel) { return path.join(root, rel); }
function exists(rel) { return fs.existsSync(p(rel)); }
function read(rel) { return fs.readFileSync(p(rel), 'utf8'); }
function readJson(rel) { return JSON.parse(read(rel)); }
function fail(message) { console.error(`Q204 REAL DEVICE EVIDENCE INTAKE FAIL: ${message}`); process.exit(1); }
function must(rel, token) { const s = read(rel); if (!s.includes(token)) fail(`${rel} missing token: ${token}`); }
function mustNot(rel, token) { const s = read(rel); if (s.includes(token)) fail(`${rel} contains forbidden token: ${token}`); }
function sha256(rel) { return crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex'); }

const files = {
  q204Policy: 'lib/features/mathlive/mathlive_real_device_evidence_intake_policy.dart',
  q203Policy: 'lib/features/mathlive/mathlive_final_static_production_freeze_policy.dart',
  manifest: 'assets/mathlive/manifest.json',
  html: 'assets/mathlive/main_editor_prod.html',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  shimSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  appShell: 'lib/app/app_shell.dart',
  workspace: 'lib/features/workspace/workspace_panel.dart',
  evidenceTemplate: 'tool/evidence/V172_Q204_REAL_DEVICE_EVIDENCE_TEMPLATE.json',
  reportJson: 'tool/reports/mathlive_real_device_evidence_intake_v172_q204_report.json',
  checklist: 'docs/evidence/V172_Q204_REAL_DEVICE_QA_CHECKLIST.md',
  q204Test: 'test/v172_q204_real_device_evidence_intake_test.dart',
  q204Verifier: 'tool/verify_mathlive_real_device_evidence_intake_v172_q204.mjs',
  q204Audit: 'docs/audit/V172_Q204_REAL_DEVICE_EVIDENCE_INTAKE_AUDIT_REPORT.md',
  q204Changed: 'docs/audit/V172_Q204_REAL_DEVICE_EVIDENCE_INTAKE_CHANGED_FILES_MANIFEST.md',
  q204ProtectedHash: 'docs/audit/V172_Q204_PROTECTED_FILE_HASH_MANIFEST.md',
  readme: 'README.md',
  pubspec: 'pubspec.yaml',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

for (const token of [
  "static const String phase = 'V172-Q204'",
  "static const String fullPhase = 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE'",
  'baseline = MathLiveFinalStaticProductionFreezePolicy.fullPhase',
  'q203FinalStaticFreezeRequired = true',
  'q199CommandContractRequired = true',
  'q200NoFreezeContractRequired = true',
  'q201CaretFocusSlotContractRequired = true',
  'q202GraphHistorySolutionStateRequired = true',
  'userSideFlutterAnalyzeEvidenceRequired = true',
  'userSideFlutterTestEvidenceRequired = true',
  'userSideFlutterRunEvidenceRequired = true',
  'androidRealDeviceVideoOrScreenshotsRequired = true',
  'assistantMayInferPassWithoutEvidence = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'androidRealDevicePassClaimed = false',
  'finalReleasePassClaimed = false',
]) must(files.q204Policy, token);

for (const token of [
  "static const String phase = 'V172-Q203'",
  "static const String fullPhase = 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE'",
  'commandContractFinalized = true',
  'noFreezeUiContractFinalized = true',
  'nativeCaretFocusSlotAuthorityFinalized = true',
  'graphHistorySolutionProductionStateFinalized = true',
  'androidRealDevicePassClaimed = false',
  'finalReleasePassClaimed = false',
]) must(files.q203Policy, token);

must(files.appShell, 'final bool _useMathLiveMainEditor = true;');
must(files.workspace, 'MathLiveProductionEditorSurface(');
must(files.shimSurface, 'return MathLiveProductionEditorSurface(');
must(files.prodSurface, 'productionFinalStaticFreezePhase = MathLiveFinalStaticProductionFreezePolicy.phase');
mustNot(files.prodSurface, 'runJavaScriptReturningResult');
mustNot(files.prodSurface, '_decodeJavascriptStringResult');
must(files.html, 'data-mathpro-final-static-production-freeze="V172-Q203"');
must(files.html, '<math-field id="mathlive-field"');
must(files.bridge, "const FINAL_STATIC_PRODUCTION_FREEZE_PHASE = 'V172-Q203';");
must(files.bridge, 'q203ProductionContractsFrozen: true');
mustNot(files.bridge, 'return document.activeElement === mf || true');

const manifest = readJson(files.manifest);
if (![fullPhase, q204r1FullPhase, q204r2FullPhase].includes(manifest.latestProductionPhase)) {
  fail(`latestProductionPhase expected ${fullPhase}, ${q204r1FullPhase}, or ${q204r2FullPhase}, got ${manifest.latestProductionPhase}`);
}
if (manifest.previousLatestProductionPhaseBeforeQ204 !== baseline) fail('previousLatestProductionPhaseBeforeQ204 must point to Q203 baseline');
if (!manifest.v172Q203FinalStaticProductionFreeze) fail('Q203 final static freeze envelope missing');
const env = manifest.v172Q204RealDeviceEvidenceIntakeGate;
if (!env) fail('missing manifest v172Q204RealDeviceEvidenceIntakeGate envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  baseline,
  policy: files.q204Policy,
  evidenceTemplatePath: files.evidenceTemplate,
  optionalEvidencePath: 'tool/evidence/V172_Q204_REAL_DEVICE_EVIDENCE.json',
  evidenceReportPath: files.reportJson,
  q203FinalStaticFreezeRequired: true,
  q199CommandContractRequired: true,
  q200NoFreezeContractRequired: true,
  q201CaretFocusSlotContractRequired: true,
  q202GraphHistorySolutionStateRequired: true,
  userSideFlutterAnalyzeEvidenceRequired: true,
  userSideFlutterTestEvidenceRequired: true,
  userSideFlutterRunEvidenceRequired: true,
  androidRealDeviceVideoOrScreenshotsRequired: true,
  assistantMayInferPassWithoutEvidence: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q204 ${key} expected ${expected}, got ${env[key]}`);
}

const template = readJson(files.evidenceTemplate);
if (template.status !== 'TEMPLATE_ONLY_NOT_REAL_EVIDENCE') fail('evidence template must be TEMPLATE_ONLY_NOT_REAL_EVIDENCE');
for (const key of ['flutterAnalyzePassClaimed','flutterTestPassClaimed','flutterRunPassClaimed','androidRealDevicePassClaimed','caretRealDevicePassClaimed','premiumVisualDevicePassClaimed','noFreezeDevicePassClaimed','graphHistorySolutionDevicePassClaimed','finalReleasePassClaimed']) {
  if (template.passClaims[key] !== false) fail(`template passClaims.${key} must be false`);
}

const optionalEvidence = 'tool/evidence/V172_Q204_REAL_DEVICE_EVIDENCE.json';
if (exists(optionalEvidence)) {
  const evidence = readJson(optionalEvidence);
  if (evidence.phase !== phase || evidence.fullPhase !== fullPhase) fail('optional evidence phase mismatch');
  if (evidence.status === 'TEMPLATE_ONLY_NOT_REAL_EVIDENCE') fail('optional evidence cannot keep template-only status');
}

const report = readJson(files.reportJson);
if (report.status !== 'STATIC_READY_REAL_DEVICE_EVIDENCE_NOT_PROVIDED') fail('Q204 report status must remain evidence-not-provided');
for (const key of ['flutterAnalyzePassClaimed','flutterTestPassClaimed','flutterRunPassClaimed','androidRealDevicePassClaimed','caretRealDevicePassClaimed','premiumVisualDevicePassClaimed','finalReleasePassClaimed']) {
  if (report[key] !== false) fail(`report ${key} must be false`);
}

// Q204R1-added stale test scanner: the Q204 evidence gate must now catch tests
// that still compile against retired Q169 static members on the Q197 shim.
const forbiddenTestRefs = [
  'runJavaScriptReturningResult',
  'mathpro-q163-diagnostic-overlay',
  '_refreshRealDeviceDiagnostic',
  'appShellVisibleFallbackPhase',
  'Q165 KEY:',
  'Q169 KEY:',
  'PAINT:',
  '_visibleFallbackExpression',
  'visibleFallbackMayRenderStructuralTemplates',
  'class _MathLiveMainEditorSurfaceState',
  'class _MathLiveAppShellVisibleFallbackOverlay',
  'class _MathLiveDiagnosticOverlay',
  'MathLiveMainEditorSurface.singleFileRuntimeBootRepairPhase',
  'MathLiveMainEditorSurface.mfTrueBridgeDispatchRepairPhase',
  "phase = 'V172-Q135-Q139'",
  'premiumSurfaceRepairPhase',
  'pointerCaretFluidityPhase',
  'viewportFitPhase',
];
for (const item of fs.readdirSync(p('test'))) {
  if (!item.endsWith('_test.dart')) continue;
  const rel = `test/${item}`;
  const text = read(rel);
  for (const token of forbiddenTestRefs) {
    if (text.includes(token)) fail(`stale test reference remains in ${rel}: ${token}`);
  }
}
for (const [rel, text] of [
  [files.shimSurface, read(files.shimSurface)],
  [files.prodSurface, read(files.prodSurface)],
]) {
  for (const token of ['class _MathLiveMainEditorSurfaceState', 'class _MathLiveAppShellVisibleFallbackOverlay', 'class _MathLiveDiagnosticOverlay']) {
    if (text.includes(token)) fail(`retired implementation marker revived in ${rel}: ${token}`);
  }
}

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_controller.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/solution/solution_steps_panel.dart',
];
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`missing protected file ${rel}`);
  const text = read(rel);
  for (const marker of ['Q204', 'Q204R1', 'RealDeviceEvidenceIntake', 'real-device-evidence-intake']) {
    if (text.includes(marker)) fail(`protected file polluted by evidence marker ${rel}`);
  }
  must(files.q204ProtectedHash, `${rel}: UNCHANGED \`${sha256(rel)}\``);
}

const forbiddenParts = new Set(['build', '.dart_tool', '.gradle', '.idea', 'node_modules', '__pycache__', '.pytest_cache']);
const forbiddenExt = ['.pyc', '.apk', '.aab', '.zip'];
function walk(dir) {
  for (const item of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, item.name);
    const rel = path.relative(root, full).replaceAll(path.sep, '/');
    if (forbiddenParts.has(item.name)) fail(`forbidden artifact directory found: ${rel}`);
    if (forbiddenExt.some((ext) => item.name.endsWith(ext))) fail(`forbidden artifact file found: ${rel}`);
    if (item.isDirectory()) walk(full);
  }
}
walk(root);

must(files.readme, 'V172-Q204 — Real Device Evidence Intake Gate');
must(files.pubspec, 'V172-Q204 real device evidence intake gate');
must(files.q204Audit, 'V172-Q204 — Real Device Evidence Intake Gate Audit Report');
must(files.q204Changed, 'V172-Q204 changed files');
must(files.checklist, 'V172-Q204 — Real Device QA Checklist');

console.log('MATHLIVE_REAL_DEVICE_EVIDENCE_INTAKE_Q204_STATIC_READY_REAL_DEVICE_EVIDENCE_REQUIRED');
