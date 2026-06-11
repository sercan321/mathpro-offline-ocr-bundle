import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_caret_focus_slot_finalization_v172_q201.mjs', preservedPhase: 'verify_mathlive_production_caret_focus_slot_finalization_v172_q201' });

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const exists = (rel) => fs.existsSync(p(rel));
const fail = (msg) => { console.error(`Q201_PRODUCTION_CARET_FOCUS_SLOT_FINALIZATION_FAIL: ${msg}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} contains forbidden ${needle}`); };
const sha256 = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');

const phase = 'V172-Q201';
const fullPhase = 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION';
const files = {
  q201Policy: 'lib/features/mathlive/mathlive_production_caret_focus_slot_finalization_policy.dart',
  q200Policy: 'lib/features/mathlive/mathlive_production_no_freeze_ui_contract_policy.dart',
  mainSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  manifest: 'assets/mathlive/manifest.json',
  test: 'test/v172_q201_production_caret_focus_slot_finalization_test.dart',
  verifier: 'tool/verify_mathlive_production_caret_focus_slot_finalization_v172_q201.mjs',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

must(files.q201Policy, "static const String phase = 'V172-Q201'");
must(files.q201Policy, "static const String fullPhase = 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION'");
must(files.q201Policy, "static const String baseline = 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION'");
for (const needle of [
  'nativeMathFieldOwnsVisibleCaret = true',
  'nativeMathFieldOwnsFocus = true',
  'nativeMathFieldOwnsSlotSelection = true',
  'flutterCaretOverlayAllowedInProduction = false',
  'flutterVisibleFallbackMirrorAllowedInProduction = false',
  'controllerMirrorMayOverrideNativeCaret = false',
  'externalExpressionMayOverrideNativeCaretAfterUserInput = false',
  'focusSuccessMustBeMeasuredNotAssumed = true',
  'commandDispatchMustPrimeNativeFocus = true',
  'commandDispatchMustRequestNativeCaretVisibility = true',
  'pointerHandlersMustNotPreventMathLiveDefaultSelection = true',
  'pointerEventsMustStayOnMathField = true',
  'selectionChangeMustPushState = true',
  'commandCompletionMustPushCaretState = true',
  'keyboardLayoutMutationAllowed = false',
  'moreInventoryMutationAllowed = false',
  'longPressOrderMutationAllowed = false',
  'graphUiMutationAllowed = false',
  'historyUiMutationAllowed = false',
  'solutionUiMutationAllowed = false',
  'androidRealDevicePassClaimed = false',
  'caretRealDevicePassClaimed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'flutterRunPassClaimedByAssistant = false',
]) must(files.q201Policy, needle);

must(files.mainSurface, "import 'mathlive_production_caret_focus_slot_finalization_policy.dart';");
must(files.prodSurface, 'productionCaretFocusSlotFinalizationPhase = MathLiveProductionCaretFocusSlotFinalizationPolicy.phase');
must(files.prodSurface, "q201-production-caret-focus-slot-finalization-not-started");
must(files.prodSurface, 'int _externalExpressionSyncBlockedByNativeCaretAuthorityCount = 0;');
must(files.prodSurface, 'int _q201NativeCaretKeepVisibleRequestCount = 0;');
must(files.prodSurface, 'bool get _mayAcceptExternalExpressionSyncForNativeCaretAuthority');
must(files.prodSurface, 'externalExpressionMayOverrideNativeCaretAfterUserInput');
must(files.prodSurface, "q201-external-expression-sync-blocked-native-caret-authority");
must(files.prodSurface, "q201-initial-external-expression-sync-before-native-caret-authority");
must(files.prodSurface, "'productionCaretFocusSlotFinalizationPhase': MathLiveProductionCaretFocusSlotFinalizationPolicy.phase");
must(files.prodSurface, "'nativeMathFieldOwnsVisibleCaret': MathLiveProductionCaretFocusSlotFinalizationPolicy.nativeMathFieldOwnsVisibleCaret");
must(files.prodSurface, "'nativeMathFieldOwnsFocus': MathLiveProductionCaretFocusSlotFinalizationPolicy.nativeMathFieldOwnsFocus");
must(files.prodSurface, "'nativeMathFieldOwnsSlotSelection': MathLiveProductionCaretFocusSlotFinalizationPolicy.nativeMathFieldOwnsSlotSelection");
must(files.prodSurface, "'flutterCaretOverlayAllowedInProduction': MathLiveProductionCaretFocusSlotFinalizationPolicy.flutterCaretOverlayAllowedInProduction");
must(files.prodSurface, "'flutterVisibleFallbackMirrorAllowedInProduction': MathLiveProductionCaretFocusSlotFinalizationPolicy.flutterVisibleFallbackMirrorAllowedInProduction");
must(files.prodSurface, "'controllerMirrorMayOverrideNativeCaret': MathLiveProductionCaretFocusSlotFinalizationPolicy.controllerMirrorMayOverrideNativeCaret");
must(files.prodSurface, "'focusSuccessMustBeMeasuredNotAssumed': MathLiveProductionCaretFocusSlotFinalizationPolicy.focusSuccessMustBeMeasuredNotAssumed");
must(files.prodSurface, "q201-command-after-dispatch-keep-native-caret-visible");
must(files.prodSurface, "Future<void> _keepCaretVisible({String reason = 'q201-dart-keep-native-caret-visible'})");
must(files.prodSurface, "'phase': MathLiveProductionCaretFocusSlotFinalizationPolicy.phase");
must(files.prodSurface, "q201-production-keep-native-caret-visible-timeout-or-exception");
must(files.prodSurface, 'q201ExternalSyncBlocked=');
must(files.prodSurface, 'q201KeepCaret=');
mustNot(files.prodSurface, 'EditorCaretOverlay(');
mustNot(files.prodSurface, '_MathLiveAppShellVisibleFallbackOverlay');
mustNot(files.prodSurface, '_MathLiveDiagnosticOverlay');
mustNot(files.prodSurface, 'runJavaScriptReturningResult');

must(files.prodHtml, 'V172-Q201: native MathLive math-field owns visible caret/focus/slot selection');
must(files.prodHtml, 'data-mathpro-production-caret-focus-slot-finalization="V172-Q201"');
must(files.prodHtml, 'data-mathpro-native-caret-authority="mathlive"');
must(files.prodHtml, 'tabindex="0"');
must(files.prodHtml, 'pointer-events: auto;');
must(files.prodHtml, '-webkit-user-select: text;');
must(files.prodHtml, 'user-select: text;');
mustNot(files.prodHtml, 'fallback');

must(files.prodBridge, "const CARET_FOCUS_SLOT_FINALIZATION_PHASE = 'V172-Q201';");
must(files.prodBridge, 'productionCaretFocusSlotFinalizationPhase: CARET_FOCUS_SLOT_FINALIZATION_PHASE');
must(files.prodBridge, 'nativeMathFieldOwnsVisibleCaret: true');
must(files.prodBridge, 'nativeMathFieldOwnsFocus: true');
must(files.prodBridge, 'nativeMathFieldOwnsSlotSelection: true');
must(files.prodBridge, 'flutterVisibleFallbackMirrorAllowedInProduction: false');
must(files.prodBridge, 'controllerMirrorMayOverrideNativeCaret: false');
must(files.prodBridge, 'focusSuccessMustBeMeasuredNotAssumed: true');
must(files.prodBridge, 'lastFocusConfirmed: false');
must(files.prodBridge, 'lastFocusConfirmationPath:');
must(files.prodBridge, 'function measureMathfieldFocus(mf, reason)');
must(files.prodBridge, "trace('q201-js-focus-measured-not-assumed'");
must(files.prodBridge, "return measureMathfieldFocus(mf, state.lastCaretFocusReason);");
mustNot(files.prodBridge, 'document.activeElement === mf || true');
must(files.prodBridge, "mf.setAttribute('tabindex', '0')");
must(files.prodBridge, "mf.setAttribute('data-mathpro-native-caret-authority', CARET_FOCUS_SLOT_FINALIZATION_PHASE)");
must(files.prodBridge, "mf.style.pointerEvents = 'auto'");
must(files.prodBridge, "mf.style.userSelect = 'text'");
must(files.prodBridge, "mf.style.webkitUserSelect = 'text'");
must(files.prodBridge, "q201-pointerdown-focus-no-prevent-default");
must(files.prodBridge, "q201-selection-change-native-caret-state");
must(files.prodBridge, "q201-command-after-insert-native-focus");
must(files.prodBridge, "q201-command-after-insert-keep-native-caret-visible");
must(files.prodBridge, "pushCaretState(tag + '-q201-native-caret-16ms')");
must(files.prodBridge, "pushCaretState(tag + '-q201-native-caret-80ms')");
mustNot(files.prodBridge, 'preventDefault()');
mustNot(files.prodBridge, 'runJavaScriptReturningResult');

const manifest = JSON.parse(read(files.manifest));
if (![fullPhase, 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE', 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE'].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase expected ${fullPhase} or verified Q202 successor, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q201ProductionCaretFocusSlotFinalization;
if (!env) fail('missing manifest Q201 envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  baseline: 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION',
  policy: files.q201Policy,
  nativeMathFieldOwnsVisibleCaret: true,
  nativeMathFieldOwnsFocus: true,
  nativeMathFieldOwnsSlotSelection: true,
  flutterCaretOverlayAllowedInProduction: false,
  flutterVisibleFallbackMirrorAllowedInProduction: false,
  controllerMirrorMayOverrideNativeCaret: false,
  externalExpressionMayOverrideNativeCaretAfterUserInput: false,
  focusSuccessMustBeMeasuredNotAssumed: true,
  commandDispatchMustPrimeNativeFocus: true,
  commandDispatchMustRequestNativeCaretVisibility: true,
  pointerHandlersMustNotPreventMathLiveDefaultSelection: true,
  pointerEventsMustStayOnMathField: true,
  selectionChangeMustPushState: true,
  commandCompletionMustPushCaretState: true,
  q201RuntimeStateFieldsRequired: true,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressOrderMutationAllowed: false,
  graphUiMutationAllowed: false,
  historyUiMutationAllowed: false,
  solutionUiMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  caretRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q201 ${key} expected ${expected}, got ${env[key]}`);
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
const hashManifest = read('docs/audit/V172_Q201_PROTECTED_FILE_HASH_MANIFEST.md');
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  const h = sha256(rel);
  if (!hashManifest.includes(`${rel}: UNCHANGED \`${h}\``)) fail(`protected hash manifest mismatch for ${rel}`);
  const text = read(rel);
  for (const marker of ['Q201', 'ProductionCaretFocusSlotFinalizationPolicy', 'productionCaretFocusSlotFinalizationPhase']) {
    if (text.includes(marker)) fail(`protected file polluted by ${marker}: ${rel}`);
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

must('README.md', 'V172-Q201 — Production Caret / Focus / Slot Finalization');
must('docs/audit/V172_Q201_PRODUCTION_CARET_FOCUS_SLOT_FINALIZATION_AUDIT_REPORT.md', 'V172-Q201 — Production Caret / Focus / Slot Finalization');
must('docs/audit/V172_Q201_PRODUCTION_CARET_FOCUS_SLOT_FINALIZATION_CHANGED_FILES_MANIFEST.md', 'V172-Q201 changed files');
must('docs/audit/V172_Q201_PROTECTED_FILE_HASH_MANIFEST.md', 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_PRODUCTION_CARET_FOCUS_SLOT_FINALIZATION_Q201_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
