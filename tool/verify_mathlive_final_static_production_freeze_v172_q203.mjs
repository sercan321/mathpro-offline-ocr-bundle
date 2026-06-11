#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_final_static_production_freeze_v172_q203.mjs', preservedPhase: 'verify_mathlive_final_static_production_freeze_v172_q203' });

const root = process.cwd();
const phase = 'V172-Q203';
const fullPhase = 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE';
const baseline = 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION';

function p(rel) { return path.join(root, rel); }
function exists(rel) { return fs.existsSync(p(rel)); }
function read(rel) { return fs.readFileSync(p(rel), 'utf8'); }
function fail(message) { console.error(`Q203 FINAL STATIC PRODUCTION FREEZE FAIL: ${message}`); process.exit(1); }
function must(rel, token) { const s = read(rel); if (!s.includes(token)) fail(`${rel} missing token: ${token}`); }
function mustNot(rel, token) { const s = read(rel); if (s.includes(token)) fail(`${rel} contains forbidden token: ${token}`); }
function sha256(rel) { return crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex'); }

const files = {
  q203Policy: 'lib/features/mathlive/mathlive_final_static_production_freeze_policy.dart',
  q199Policy: 'lib/features/mathlive/mathlive_production_command_contract_policy.dart',
  q200Policy: 'lib/features/mathlive/mathlive_production_no_freeze_ui_contract_policy.dart',
  q201Policy: 'lib/features/mathlive/mathlive_production_caret_focus_slot_finalization_policy.dart',
  q202Policy: 'lib/features/mathlive/mathlive_production_graph_history_solution_state_finalization_policy.dart',
  mainSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  appShell: 'lib/app/app_shell.dart',
  workspace: 'lib/features/workspace/workspace_panel.dart',
  html: 'assets/mathlive/main_editor_prod.html',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  manifest: 'assets/mathlive/manifest.json',
  runtimeManifest: 'assets/mathlive/vendor/mathlive/runtime_manifest.json',
  readme: 'README.md',
  pubspec: 'pubspec.yaml',
  q203Test: 'test/v172_q203_final_static_production_freeze_test.dart',
  q203Verifier: 'tool/verify_mathlive_final_static_production_freeze_v172_q203.mjs',
  q203Audit: 'docs/audit/V172_Q203_FINAL_STATIC_PRODUCTION_FREEZE_AUDIT_REPORT.md',
  q203Changed: 'docs/audit/V172_Q203_FINAL_STATIC_PRODUCTION_FREEZE_CHANGED_FILES_MANIFEST.md',
  q203ProtectedHash: 'docs/audit/V172_Q203_PROTECTED_FILE_HASH_MANIFEST.md',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

for (const token of [
  "static const String phase = 'V172-Q203'",
  "static const String fullPhase = 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE'",
  "static const String baseline = 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION'",
  'productionRoute =',
  'officialMathLiveFontBundleRequired = true',
  'officialMathLiveFontBundleIngested = true',
  'legacyMarkerCleanupPhase = MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.phase',
  'commandContractPhase = MathLiveProductionCommandContractPolicy.phase',
  'noFreezeUiContractPhase = MathLiveProductionNoFreezeUiContractPolicy.phase',
  'caretFocusSlotFinalizationPhase = MathLiveProductionCaretFocusSlotFinalizationPolicy.phase',
  'graphHistorySolutionStateFinalizationPhase =',
  'requiredCriticalCommandContractCount = 23',
  'commandContractFinalized = true',
  'rawVisibleLabelFallbackAllowedForCriticalTemplates = false',
  'rawInsertTokensMayCrossProductionBridge =',
  'noFreezeUiContractFinalized = true',
  'productionSendKeyMayAwaitWebViewJavascript =',
  'commandSchedulingReturnsSynchronously =',
  'nativeCaretFocusSlotAuthorityFinalized = true',
  'nativeMathFieldOwnsVisibleCaret =',
  'flutterCaretOverlayAllowedInProduction =',
  'flutterVisibleFallbackMirrorAllowedInProduction =',
  'controllerMirrorMayOverrideNativeCaret =',
  'graphHistorySolutionProductionStateFinalized = true',
  'graphSourceMustBeMathLiveProductionState =',
  'fallbackExpressionMayFeedGraphHistorySolution =',
  'openPlaceholderMayGenerateFakeResult =',
  'keyboardLayoutMutationAllowed = false',
  'moreInventoryMutationAllowed = false',
  'longPressOrderMutationAllowed = false',
  'bottomDockMutationAllowed = false',
  'premiumKeyMutationAllowed = false',
  'templateTrayMutationAllowed = false',
  'graphUiMutationAllowed = false',
  'graphControllerMutationAllowed = false',
  'historyControllerMutationAllowed = false',
  'historyPanelMutationAllowed = false',
  'solutionStepsPanelMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'flutterRunPassClaimedByAssistant = false',
  'androidRealDevicePassClaimed = false',
  'caretRealDevicePassClaimed = false',
  'premiumVisualDevicePassClaimed = false',
  'finalReleasePassClaimed = false',
]) must(files.q203Policy, token);

// Prior phase evidence remains present.
for (const token of [
  "static const String phase = 'V172-Q199'",
  'criticalContracts = <MathLiveProductionCommandContractEntry>',
  'rawInsertTokensMayCrossProductionBridge = false',
  "label: 'Taylor'",
  "label: 'Maclaurin'",
  "label: '∫ₐᵇ'",
]) must(files.q199Policy, token);
for (const token of [
  "static const String phase = 'V172-Q200'",
  'productionSendKeyMayAwaitWebViewJavascript = false',
  'productionCommandSchedulingReturnsSynchronously = true',
  'runJavaScriptReturningResultAllowedInProductionPath = false',
  'maxScheduledProductionTailDepth = 64',
]) must(files.q200Policy, token);
for (const token of [
  "static const String phase = 'V172-Q201'",
  'nativeMathFieldOwnsVisibleCaret = true',
  'flutterCaretOverlayAllowedInProduction = false',
  'flutterVisibleFallbackMirrorAllowedInProduction = false',
  'controllerMirrorMayOverrideNativeCaret = false',
  'focusSuccessMustBeMeasuredNotAssumed = true',
]) must(files.q201Policy, token);
for (const token of [
  "static const String phase = 'V172-Q202'",
  'graphSourceMustBeMathLiveProductionState = true',
  'historySourceMustBeMathLiveProductionState = true',
  'solutionSourceMustBeMathLiveProductionState = true',
  'fallbackExpressionMayFeedGraphHistorySolution = false',
  'openPlaceholderMayGenerateFakeResult = false',
  'fakeSolutionAllowed = false',
]) must(files.q202Policy, token);

// Active production route markers.
must(files.appShell, 'final bool _useMathLiveMainEditor = true;');
must(files.appShell, 'MathLiveProductionGraphHistorySolutionStateEnvelope? _lastMathLiveProductionStateEnvelope;');
must(files.appShell, 'buildFinalizedProductionEnvelope(snapshot)');
mustNot(files.appShell, 'mathlive_lab_screen_policy.dart');
mustNot(files.appShell, 'MathLiveRuntimeSyncEnvelope?');
mustNot(files.appShell, 'fallbackExpression: _calculator.state.expressionText');
must(files.workspace, 'MathLiveProductionEditorSurface(');
must(files.mainSurface, "part 'mathlive_production_editor_surface.dart';");
must(files.mainSurface, "mathlive_final_static_production_freeze_policy.dart");
must(files.prodSurface, 'productionFinalStaticFreezePhase = MathLiveFinalStaticProductionFreezePolicy.phase');
must(files.prodSurface, 'q203-final-static-production-freeze-not-started');
must(files.prodSurface, 'Q203: finalStaticProductionFreezePhase');
mustNot(files.prodSurface, 'runJavaScriptReturningResult');
mustNot(files.prodSurface, '_MathLiveAppShellVisibleFallbackOverlay');
mustNot(files.prodSurface, '_MathLiveDiagnosticOverlay');

// HTML/bridge production freeze markers.
must(files.html, 'data-mathpro-final-static-production-freeze="V172-Q203"');
must(files.html, '<math-field id="mathlive-field"');
must(files.html, 'virtual-keyboard-mode="off"');
must(files.html, 'data-mathpro-native-caret-authority="V172-Q201"');
mustNot(files.html, 'https://');
mustNot(files.html, 'http://');
must(files.bridge, "const FINAL_STATIC_PRODUCTION_FREEZE_PHASE = 'V172-Q203';");
must(files.bridge, 'finalStaticProductionFreezePhase: FINAL_STATIC_PRODUCTION_FREEZE_PHASE');
must(files.bridge, 'q203ProductionContractsFrozen: true');
must(files.bridge, 'q203FinalStaticFreezeAndroidPassClaimed: false');
must(files.bridge, "finalStaticProductionFreezeStatus: 'q203-static-freeze-ready-runtime-device-evidence-required'");
must(files.bridge, 'productionCommandSchedulingReturnsSynchronously: true');
must(files.bridge, 'productionSendKeyMayAwaitWebViewJavascript: false');
must(files.bridge, 'nativeMathFieldOwnsVisibleCaret: true');
must(files.bridge, 'flutterVisibleFallbackMirrorAllowedInProduction: false');
mustNot(files.bridge, 'return document.activeElement === mf || true');

// Manifest truth.
const manifest = JSON.parse(read(files.manifest));
if (![fullPhase, 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE', 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE'].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase expected ${fullPhase} or verified Q204 successor, got ${manifest.latestProductionPhase}`);
if (manifest.previousLatestProductionPhaseBeforeQ203 !== baseline) fail('previousLatestProductionPhaseBeforeQ203 does not point to Q202 baseline');
const env = manifest.v172Q203FinalStaticProductionFreeze;
if (!env) fail('missing manifest v172Q203FinalStaticProductionFreeze envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  baseline,
  policy: files.q203Policy,
  officialMathLiveFontBundleRequired: true,
  officialMathLiveFontBundleIngested: true,
  legacyMarkerCleanupPhase: 'V172-Q198',
  commandContractPhase: 'V172-Q199',
  noFreezeUiContractPhase: 'V172-Q200',
  caretFocusSlotFinalizationPhase: 'V172-Q201',
  graphHistorySolutionStateFinalizationPhase: 'V172-Q202',
  commandContractFinalized: true,
  noFreezeUiContractFinalized: true,
  nativeCaretFocusSlotAuthorityFinalized: true,
  graphHistorySolutionProductionStateFinalized: true,
  rawVisibleLabelFallbackAllowedForCriticalTemplates: false,
  rawInsertTokensMayCrossProductionBridge: false,
  controllerSendKeyMayAwaitProductionDispatch: false,
  productionSendKeyMayAwaitWebViewJavascript: false,
  commandSchedulingReturnsSynchronously: true,
  nativeMathFieldOwnsVisibleCaret: true,
  flutterCaretOverlayAllowedInProduction: false,
  flutterVisibleFallbackMirrorAllowedInProduction: false,
  controllerMirrorMayOverrideNativeCaret: false,
  graphSourceMustBeMathLiveProductionState: true,
  historySourceMustBeMathLiveProductionState: true,
  solutionSourceMustBeMathLiveProductionState: true,
  fallbackExpressionMayFeedGraphHistorySolution: false,
  openPlaceholderMayGenerateFakeResult: false,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressOrderMutationAllowed: false,
  bottomDockMutationAllowed: false,
  premiumKeyMutationAllowed: false,
  templateTrayMutationAllowed: false,
  graphUiMutationAllowed: false,
  graphControllerMutationAllowed: false,
  historyControllerMutationAllowed: false,
  historyPanelMutationAllowed: false,
  solutionStepsPanelMutationAllowed: false,
  packageHygieneRequired: true,
  protectedHashVerificationRequired: true,
  freshExtractVerificationRequired: true,
  fullVerifierChainRequired: true,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  caretRealDevicePassClaimed: false,
  premiumVisualDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q203 ${key} expected ${expected}, got ${env[key]}`);
}

// Official MathLive/KaTeX font bundle remains present.
const fontDir = 'assets/mathlive/vendor/mathlive/fonts';
if (!exists(fontDir)) fail('missing MathLive font directory');
const fontFiles = fs.readdirSync(p(fontDir)).filter((name) => name.endsWith('.woff2'));
if (fontFiles.length < 20) fail(`expected at least 20 MathLive/KaTeX woff2 fonts, got ${fontFiles.length}`);
must(files.runtimeManifest, 'mathlive');
must(files.runtimeManifest, '0.109.2');

// Protected hash lock.
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
const protectedHashManifest = read(files.q203ProtectedHash);
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  const h = sha256(rel);
  if (!protectedHashManifest.includes(`${rel}: UNCHANGED \`${h}\``)) fail(`protected hash mismatch for ${rel}`);
  const text = read(rel);
  for (const marker of ['Q203', 'FinalStaticProductionFreeze', 'q203-final-static']) {
    if (text.includes(marker)) fail(`protected file polluted by Q203 marker ${rel}`);
  }
}

// Static Dart import/part resolution without Dart SDK.
const dartFiles = [];
function walkDart(dir) {
  for (const entry of fs.readdirSync(p(dir), { withFileTypes: true })) {
    const rel = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      if (['build', '.dart_tool', '.gradle', '.idea', 'node_modules'].includes(entry.name)) continue;
      walkDart(rel);
    } else if (entry.isFile() && entry.name.endsWith('.dart')) dartFiles.push(rel);
  }
}
for (const dir of ['lib', 'test']) if (exists(dir)) walkDart(dir);
const importRe = /^\s*import\s+['"]([^'"]+)['"]/gm;
const partRe = /^\s*part\s+['"]([^'"]+)['"]/gm;
for (const file of dartFiles) {
  const src = read(file);
  let m;
  while ((m = importRe.exec(src)) !== null) {
    const spec = m[1];
    if (spec.startsWith('dart:') || spec.startsWith('package:flutter') || spec.startsWith('package:flutter_test') || spec.startsWith('package:webview_flutter') || spec.startsWith('package:provider') || spec.startsWith('package:shared_preferences')) continue;
    if (spec.startsWith('package:mathpro_flutter_phase17/')) {
      const target = spec.replace('package:mathpro_flutter_phase17/', 'lib/');
      if (!exists(target)) fail(`${file} imports missing package target ${spec}`);
      continue;
    }
    if (spec.startsWith('.')) {
      const target = path.normalize(path.join(path.dirname(file), spec));
      if (!exists(target)) fail(`${file} imports missing relative target ${spec} -> ${target}`);
    }
  }
  while ((m = partRe.exec(src)) !== null) {
    const target = path.normalize(path.join(path.dirname(file), m[1]));
    if (!exists(target)) fail(`${file} has missing part target ${m[1]} -> ${target}`);
  }
}

// Package hygiene.
const forbiddenDirs = ['build', '.dart_tool', '.gradle', '.idea', 'node_modules', '__pycache__', '.pytest_cache'];
function walk(rel) {
  for (const entry of fs.readdirSync(p(rel), { withFileTypes: true })) {
    const child = path.join(rel, entry.name);
    if (entry.isDirectory()) {
      if (forbiddenDirs.includes(entry.name)) fail(`forbidden directory present: ${child}`);
      walk(child);
    } else if (entry.isFile()) {
      if (entry.name.endsWith('.pyc')) fail(`forbidden pyc present: ${child}`);
      if (entry.name.endsWith('.zip') || entry.name.endsWith('.apk') || entry.name.endsWith('.aab')) fail(`forbidden nested artifact present: ${child}`);
    }
  }
}
walk('.');

must(files.readme, 'V172-Q203 — Final Static Production Freeze');
must(files.pubspec, 'V172-Q203 final static production freeze');
must(files.q203Audit, 'V172-Q203 — Final Static Production Freeze Audit Report');
must(files.q203Changed, 'V172-Q203 changed files');
must(files.q203ProtectedHash, 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_FINAL_STATIC_PRODUCTION_FREEZE_Q203_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
