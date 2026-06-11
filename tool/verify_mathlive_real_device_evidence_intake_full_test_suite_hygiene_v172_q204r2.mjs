#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_real_device_evidence_intake_full_test_suite_hygiene_v172_q204r2.mjs', preservedPhase: 'verify_mathlive_real_device_evidence_intake_full_test_suite_hygiene_v172_q204r2' });

const root = process.cwd();
const phase = 'V172-Q204R2';
const fullPhase = 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE';
const baseline = 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE';
function p(rel) { return path.join(root, rel); }
function exists(rel) { return fs.existsSync(p(rel)); }
function read(rel) { return fs.readFileSync(p(rel), 'utf8'); }
function readJson(rel) { return JSON.parse(read(rel)); }
function fail(message) { console.error(`Q204R2 FULL TEST-SUITE HYGIENE FAIL: ${message}`); process.exit(1); }
function must(rel, token) { if (!read(rel).includes(token)) fail(`${rel} missing token: ${token}`); }
function mustNot(rel, token) { if (read(rel).includes(token)) fail(`${rel} contains forbidden token: ${token}`); }
function sha256(rel) { return crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex'); }

const files = {
  policy: 'lib/features/mathlive/mathlive_real_device_evidence_intake_full_test_suite_hygiene_policy.dart',
  q204Policy: 'lib/features/mathlive/mathlive_real_device_evidence_intake_policy.dart',
  q204r1Policy: 'lib/features/mathlive/mathlive_real_device_evidence_intake_analyze_test_hygiene_policy.dart',
  shim: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  html: 'assets/mathlive/main_editor_prod.html',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  manifest: 'assets/mathlive/manifest.json',
  test: 'test/v172_q204r2_real_device_evidence_intake_full_test_suite_hygiene_test.dart',
  verifier: 'tool/verify_mathlive_real_device_evidence_intake_full_test_suite_hygiene_v172_q204r2.mjs',
  audit: 'docs/audit/V172_Q204R2_REAL_DEVICE_EVIDENCE_INTAKE_FULL_TEST_SUITE_HYGIENE_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q204R2_REAL_DEVICE_EVIDENCE_INTAKE_FULL_TEST_SUITE_HYGIENE_CHANGED_FILES_MANIFEST.md',
  protectedHash: 'docs/audit/V172_Q204R2_PROTECTED_FILE_HASH_MANIFEST.md',
  readme: 'README.md',
  pubspec: 'pubspec.yaml',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

for (const token of [
  "static const String phase = 'V172-Q204R2'",
  "static const String fullPhase =",
  "'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE'",
  'baseline =',
  'MathLiveRealDeviceEvidenceIntakeAnalyzeTestHygienePolicy.fullPhase',
  'q204EvidenceGatePreserved = true',
  'q204r1AnalyzeTestHygienePreserved = true',
  'fullMathLiveTestSuiteMigratedToQ197Q203Architecture = true',
  'shimTestsOnlyAssertCompatibilityForwarding = true',
  'productionImplementationTestsReadProductionSurface = true',
  'bridgeTestsReadProductionBridge = true',
  'htmlTestsReadProductionHtml = true',
  'retiredDiagnosticMarkersRevived = false',
  'returningResultApiRevived = false',
  'visibleFallbackOverlayRevived = false',
  'staleTestScannerCoversFullSuite = true',
  'protectedKeyboardGraphHistorySolutionMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'androidRealDevicePassClaimed = false',
  'finalReleasePassClaimed = false',
  'forbiddenStaleTestMarkers',
]) must(files.policy, token);

const manifest = readJson(files.manifest);
if (manifest.latestProductionPhase !== fullPhase) fail(`latestProductionPhase expected ${fullPhase}, got ${manifest.latestProductionPhase}`);
if (manifest.previousLatestProductionPhaseBeforeQ204R2 !== baseline) fail('previousLatestProductionPhaseBeforeQ204R2 must point to Q204R1 baseline');
if (!manifest.v172Q204RealDeviceEvidenceIntakeGate) fail('Q204 evidence gate envelope must remain present');
if (!manifest.v172Q204R1RealDeviceEvidenceIntakeAnalyzeTestHygiene) fail('Q204R1 analyze/test hygiene envelope must remain present');
const env = manifest.v172Q204R2RealDeviceEvidenceIntakeFullTestSuiteHygiene;
if (!env) fail('missing manifest Q204R2 full test-suite hygiene envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  baseline,
  policy: files.policy,
  q204EvidenceGatePreserved: true,
  q204r1AnalyzeTestHygienePreserved: true,
  fullMathLiveTestSuiteMigratedToQ197Q203Architecture: true,
  shimTestsOnlyAssertCompatibilityForwarding: true,
  productionImplementationTestsReadProductionSurface: true,
  bridgeTestsReadProductionBridge: true,
  htmlTestsReadProductionHtml: true,
  retiredDiagnosticMarkersRevived: false,
  returningResultApiRevived: false,
  visibleFallbackOverlayRevived: false,
  staleTestScannerCoversFullSuite: true,
  protectedKeyboardGraphHistorySolutionMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q204R2 ${key} expected ${expected}, got ${env[key]}`);
}

const forbiddenTestMarkers = [
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
for (const token of forbiddenTestMarkers) must(files.policy, token);
for (const item of fs.readdirSync(p('test'))) {
  if (!item.endsWith('_test.dart')) continue;
  const rel = `test/${item}`;
  const text = read(rel);
  for (const token of forbiddenTestMarkers) {
    if (text.includes(token)) fail(`stale MathLive test marker remains in ${rel}: ${token}`);
  }
}

let migratedCount = 0;
for (const item of fs.readdirSync(p('test'))) {
  if (!item.endsWith('_test.dart')) continue;
  const rel = `test/${item}`;
  if (read(rel).includes('Q204R2 migrated production-surface contract')) migratedCount += 1;
}
if (migratedCount < 35) fail(`expected at least 35 migrated stale MathLive tests, got ${migratedCount}`);

must(files.shim, 'return MathLiveProductionEditorSurface(');
must(files.shim, 'forwardsToProductionSurface = true');
must(files.shim, 'staleCompatibilityShimMayRenderFallback = false');
for (const token of [
  'singleFileRuntimeBootRepairPhase',
  'mfTrueBridgeDispatchRepairPhase',
  'class _MathLiveMainEditorSurfaceState',
  'class _MathLiveAppShellVisibleFallbackOverlay',
  'class _MathLiveDiagnosticOverlay',
]) mustNot(files.shim, token);

must(files.prodSurface, 'class MathLiveProductionEditorSurface extends StatefulWidget');
must(files.prodSurface, 'scheduleMathProKey');
must(files.prodSurface, '_enqueueProductionCommand');
mustNot(files.prodSurface, 'runJavaScriptReturningResult');
mustNot(files.prodSurface, '_decodeJavascriptStringResult');
mustNot(files.prodSurface, '_MathLiveAppShellVisibleFallbackOverlay');
mustNot(files.prodSurface, '_MathLiveDiagnosticOverlay');
must(files.bridge, 'q203ProductionContractsFrozen: true');
must(files.bridge, 'function insertLatex');
must(files.bridge, 'function keepCaretVisible');
mustNot(files.bridge, 'return document.activeElement === mf || true');
must(files.html, '<math-field id="mathlive-field"');
must(files.html, 'data-mathpro-final-static-production-freeze="V172-Q203"');
must(files.html, 'data-mathpro-native-caret-authority="mathlive"');

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
  for (const marker of ['Q204R2', 'FullTestSuiteHygiene', 'full-test-suite-hygiene']) {
    if (text.includes(marker)) fail(`protected file polluted by Q204R2 marker: ${rel}`);
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

must(files.readme, 'V172-Q204R2 — Real Device Evidence Intake Full Test-Suite Hygiene');
must(files.pubspec, 'V172-Q204R2 real device evidence intake full test-suite hygiene');
must(files.audit, 'V172-Q204R2 — Real Device Evidence Intake Full Test-Suite Hygiene Audit Report');
must(files.changed, 'V172-Q204R2 changed files');

console.log('MATHLIVE_REAL_DEVICE_EVIDENCE_INTAKE_FULL_TEST_SUITE_HYGIENE_Q204R2_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
