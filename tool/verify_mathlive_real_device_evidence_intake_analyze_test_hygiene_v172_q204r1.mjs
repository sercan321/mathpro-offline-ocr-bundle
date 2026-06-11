#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_real_device_evidence_intake_analyze_test_hygiene_v172_q204r1.mjs', preservedPhase: 'verify_mathlive_real_device_evidence_intake_analyze_test_hygiene_v172_q204r1' });

const root = process.cwd();
const phase = 'V172-Q204R1';
const fullPhase = 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE';
const q204r2FullPhase = 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE';
const baseline = 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE';
function p(rel) { return path.join(root, rel); }
function exists(rel) { return fs.existsSync(p(rel)); }
function read(rel) { return fs.readFileSync(p(rel), 'utf8'); }
function readJson(rel) { return JSON.parse(read(rel)); }
function fail(message) { console.error(`Q204R1 ANALYZE/TEST HYGIENE FAIL: ${message}`); process.exit(1); }
function must(rel, token) { if (!read(rel).includes(token)) fail(`${rel} missing token: ${token}`); }
function mustNot(rel, token) { if (read(rel).includes(token)) fail(`${rel} contains forbidden token: ${token}`); }
function sha256(rel) { return crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex'); }

const files = {
  policy: 'lib/features/mathlive/mathlive_real_device_evidence_intake_analyze_test_hygiene_policy.dart',
  q204Policy: 'lib/features/mathlive/mathlive_real_device_evidence_intake_policy.dart',
  shim: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  html: 'assets/mathlive/main_editor_prod.html',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  manifest: 'assets/mathlive/manifest.json',
  q169r35Test: 'test/v172_q169r35_single_file_runtime_boot_repair_test.dart',
  q169r4Test: 'test/v172_q169r4_mathlive_mf_true_bridge_dispatch_repair_test.dart',
  q204r1Test: 'test/v172_q204r1_real_device_evidence_intake_analyze_test_hygiene_test.dart',
  q204Verifier: 'tool/verify_mathlive_real_device_evidence_intake_v172_q204.mjs',
  q204r1Verifier: 'tool/verify_mathlive_real_device_evidence_intake_analyze_test_hygiene_v172_q204r1.mjs',
  audit: 'docs/audit/V172_Q204R1_REAL_DEVICE_EVIDENCE_INTAKE_ANALYZE_TEST_HYGIENE_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q204R1_REAL_DEVICE_EVIDENCE_INTAKE_ANALYZE_TEST_HYGIENE_CHANGED_FILES_MANIFEST.md',
  protectedHash: 'docs/audit/V172_Q204R1_PROTECTED_FILE_HASH_MANIFEST.md',
  readme: 'README.md',
  pubspec: 'pubspec.yaml',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

for (const token of [
  "static const String phase = 'V172-Q204R1'",
  "static const String fullPhase =",
  "'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'",
  'baseline = MathLiveRealDeviceEvidenceIntakePolicy.fullPhase',
  'q204EvidenceGatePreserved = true',
  'staleQ169SurfaceStaticExpectationsRemovedFromTests = true',
  'retiredMainEditorSurfaceStaticsRevived = false',
  'testsReadProductionSurfaceFileAfterQ197 = true',
  'testsReadProductionBridgeAfterQ197 = true',
  'testsReadProductionHtmlAfterQ197 = true',
  'unusedDecodeJavascriptStringResultRemoved = true',
  'q204VerifierIncludesStaleTestScanner = true',
  'protectedKeyboardGraphHistorySolutionMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'androidRealDevicePassClaimed = false',
  'finalReleasePassClaimed = false',
]) must(files.policy, token);

const manifest = readJson(files.manifest);
if (![fullPhase, q204r2FullPhase].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase expected ${fullPhase} or ${q204r2FullPhase}, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q204R1RealDeviceEvidenceIntakeAnalyzeTestHygiene;
if (!env) fail('missing v172Q204R1RealDeviceEvidenceIntakeAnalyzeTestHygiene manifest envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  baseline,
  policy: files.policy,
  staleQ169SurfaceStaticExpectationsRemovedFromTests: true,
  retiredMainEditorSurfaceStaticsRevived: false,
  testsReadProductionSurfaceFileAfterQ197: true,
  testsReadProductionBridgeAfterQ197: true,
  testsReadProductionHtmlAfterQ197: true,
  unusedDecodeJavascriptStringResultRemoved: true,
  q204VerifierIncludesStaleTestScanner: true,
  protectedKeyboardGraphHistorySolutionMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q204R1 ${key} expected ${expected}, got ${env[key]}`);
}
if (!manifest.v172Q204RealDeviceEvidenceIntakeGate) fail('Q204 evidence gate envelope must remain present');

must(files.q204Verifier, 'forbiddenTestRefs');
must(files.q204Verifier, 'MathLiveMainEditorSurface.singleFileRuntimeBootRepairPhase');
must(files.q204Verifier, 'MathLiveMainEditorSurface.mfTrueBridgeDispatchRepairPhase');

const forbiddenTestRefs = [
  'MathLiveMainEditorSurface.singleFileRuntimeBootRepairPhase',
  'MathLiveMainEditorSurface.mfTrueBridgeDispatchRepairPhase',
];
for (const item of fs.readdirSync(p('test'))) {
  if (!item.endsWith('_test.dart')) continue;
  const rel = `test/${item}`;
  const text = read(rel);
  for (const token of forbiddenTestRefs) {
    if (text.includes(token)) fail(`stale undefined static reference remains in ${rel}: ${token}`);
  }
}

must(files.q169r35Test, 'MathLiveMainEditorSurface.forwardsToProductionSurface');
must(files.q169r35Test, 'MathLiveProductionEditorSurface.webViewAssetPath');
must(files.q169r35Test, 'assets/mathlive/main_editor_prod.html');
must(files.q169r35Test, 'mathlive_prod_bridge.js');
must(files.q169r4Test, 'MathLiveMainEditorSurface.forwardsToProductionSurface');
must(files.q169r4Test, 'mathlive_production_editor_surface.dart');
must(files.q169r4Test, 'mathlive_prod_bridge.js');

must(files.shim, 'return MathLiveProductionEditorSurface(');
must(files.shim, 'staleCompatibilityShimMayRenderFallback = false');
for (const token of ['singleFileRuntimeBootRepairPhase', 'mfTrueBridgeDispatchRepairPhase', 'class _MathLiveMainEditorSurfaceState', 'class _MathLiveAppShellVisibleFallbackOverlay', 'class _MathLiveDiagnosticOverlay']) {
  mustNot(files.shim, token);
}
for (const token of ['_decodeJavascriptStringResult', 'runJavaScriptReturningResult', '_MathLiveAppShellVisibleFallbackOverlay', '_MathLiveDiagnosticOverlay']) {
  mustNot(files.prodSurface, token);
}
must(files.prodSurface, 'scheduleMathProKey');
must(files.prodSurface, '_enqueueProductionCommand');
must(files.html, '<math-field id="mathlive-field"');
must(files.bridge, 'q203ProductionContractsFrozen: true');
mustNot(files.bridge, 'return document.activeElement === mf || true');

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
  for (const marker of ['Q204R1', 'AnalyzeTestHygiene', 'analyze-test-hygiene']) {
    if (text.includes(marker)) fail(`protected file polluted by Q204R1 marker: ${rel}`);
  }
  must(files.protectedHash, `${rel}: UNCHANGED \`${sha256(rel)}\``);
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

must(files.readme, 'V172-Q204R1 — Real Device Evidence Intake Analyze/Test Hygiene');
must(files.pubspec, 'V172-Q204R1 real device evidence intake analyze/test hygiene');
must(files.audit, 'V172-Q204R1 — Real Device Evidence Intake Analyze/Test Hygiene Audit Report');
must(files.changed, 'V172-Q204R1 changed files');

console.log('MATHLIVE_REAL_DEVICE_EVIDENCE_INTAKE_ANALYZE_TEST_HYGIENE_Q204R1_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
