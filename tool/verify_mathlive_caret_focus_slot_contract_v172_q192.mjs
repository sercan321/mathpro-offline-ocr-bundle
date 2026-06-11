#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_caret_focus_slot_contract_v172_q192.mjs', preservedPhase: 'verify_mathlive_caret_focus_slot_contract_v172_q192' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q192_CARET_FOCUS_SLOT_CONTRACT_FAIL: ${msg}`); process.exit(1); };
const must = (p, s) => { if (!exists(p) || !read(p).includes(s)) fail(`${p} missing ${s}`); };

const files = {
  policy: 'lib/features/mathlive/mathlive_caret_focus_slot_contract_policy.dart',
  surface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  html: 'assets/mathlive/main_editor_prod.html',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  test: 'test/v172_q192_caret_focus_slot_contract_test.dart',
  audit: 'docs/audit/V172_Q192_CARET_FOCUS_SLOT_CONTRACT_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q192_CARET_FOCUS_SLOT_CONTRACT_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q192_PROTECTED_FILE_HASH_MANIFEST.md',
};
for (const p of Object.values(files)) if (!exists(p)) fail(`missing required file ${p}`);
const surfaceCombined = `${read(files.surface)}\n${read(files.prodSurfacePart)}`;
const mustSurface = (s) => { if (!surfaceCombined.includes(s)) fail(`${files.surface} + ${files.prodSurfacePart} missing ${s}`); };

must(files.policy, "phase = 'V172-Q192'");
must(files.policy, 'nativeMathLiveCaretOwnsSelection = true');
must(files.policy, 'flutterCaretOverlayAllowed = false');
must(files.policy, 'flutterFallbackMirrorMayOwnVisibleEditor = false');
must(files.policy, 'webViewGestureMustBeEager = true');
must(files.policy, 'pointerTapMustStayInsideMathfield = true');
must(files.policy, 'commandDispatchMustRefocusMathfield = true');
must(files.policy, 'commandDispatchMustRequestCaretVisibility = true');
must(files.policy, 'statePushAfterPointerAndSelectionEvents = true');
must(files.policy, 'rawCursorOverlayMayRenderInProduction = false');

mustSurface("import 'mathlive_caret_focus_slot_contract_policy.dart';");
mustSurface("'caretFocusSlotContractPhase': MathLiveCaretFocusSlotContractPolicy.phase");
mustSurface("'flutterCaretOverlayAllowed': MathLiveCaretFocusSlotContractPolicy.flutterCaretOverlayAllowed");
mustSurface("'nativeMathLiveCaretOwnsSelection': MathLiveCaretFocusSlotContractPolicy.nativeMathLiveCaretOwnsSelection");
mustSurface('Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())');
mustSurface('q192-dart-keep-caret-visible');

must(files.bridge, "CARET_FOCUS_SLOT_CONTRACT_PHASE = 'V172-Q192'");
must(files.bridge, 'caretFocusSlotContractPhase: CARET_FOCUS_SLOT_CONTRACT_PHASE');
must(files.bridge, 'flutterCaretOverlayAllowed: false');
must(files.bridge, 'safeFocusMathfield(mf,');
must(files.bridge, 'pushCaretState');
must(files.bridge, 'scheduleCaretStatePush');
must(files.bridge, 'keepNativeCaretInView');
must(files.bridge, 'q192-pointerdown-focus');
must(files.bridge, 'q192-click-focus');
must(files.bridge, 'q192-touchend-focus');
must(files.bridge, 'q192-selection-change-caret-state');
must(files.bridge, 'q192-command-after-insert-focus');
must(files.bridge, 'q192-command-after-insert-keep-caret-visible');
must(files.bridge, 'q192-keep-caret-visible-command');

must(files.html, 'data-mathpro-caret-focus-slot-contract="V172-Q192"');
must(files.html, 'touch-action: auto;');
must(files.readme, 'V172-Q192 — Caret / Focus / Slot Contract Closure');
must(files.test, 'MathLiveCaretFocusSlotContractPolicy');

const surface = surfaceCombined;
const legacyStart = surface.indexOf('class _MathLiveMainEditorSurfaceState');
const productionStart = surface.indexOf('class _MathLiveProductionEditorSurfaceState');
if (productionStart < 0) fail('production class missing');
if (legacyStart >= 0 && legacyStart > productionStart) fail('legacy class appears after production class');
const legacy = legacyStart >= 0 ? surface.slice(legacyStart, productionStart) : '';
if (legacyStart < 0 && !surface.includes('legacyImplementationPhysicallyRemoved = true')) fail('legacy class absent without Q194 cleanup marker');
const fallbackStart = surface.indexOf('class _MathLiveAppShellVisibleFallbackOverlay', productionStart);
const production = surface.slice(productionStart, fallbackStart > productionStart ? fallbackStart : undefined);
for (const forbidden of ['V172-Q192', 'CaretFocusSlotContract', 'caretFocusSlotContractPhase']) {
  if (legacy.includes(forbidden)) fail(`legacy state contains forbidden Q192 marker ${forbidden}`);
}
if (!production.includes('caretFocusSlotContractPhase')) fail('production class missing Q192 payload');
if (production.includes('runJavaScriptReturningResult')) fail('production class reintroduced runJavaScriptReturningResult');
if (production.includes('_MathLiveAppShellVisibleFallbackOverlay(')) fail('production class uses fallback overlay');

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
for (const p of protectedFiles) {
  if (!exists(p)) fail(`missing protected file ${p}`);
  const t = read(p);
  if (t.includes('V172-Q192') || t.includes('CaretFocusSlot')) fail(`protected file polluted by Q192 marker ${p}`);
}

const manifest = JSON.parse(read(files.manifest));
if (!['V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) fail('manifest latestProductionPhase is not Q192 or verified Q193/Q194/Q195 successor');
const q = manifest.v172Q192CaretFocusSlotContractClosure;
if (!q) fail('manifest missing Q192 envelope');
if (q.nativeMathLiveCaretOwnsSelection !== true) fail('manifest native caret authority mismatch');
if (q.flutterCaretOverlayAllowed !== false) fail('manifest allows Flutter caret overlay');
if (q.flutterFallbackMirrorMayOwnVisibleEditor !== false) fail('manifest allows fallback mirror ownership');
if (q.flutterAnalyzePassClaimedByAssistant !== false) fail('manifest falsely claims Flutter analyze PASS');
if (q.androidRealDevicePassClaimed !== false) fail('manifest falsely claims Android PASS');
if (q.caretRealDevicePassClaimed !== false) fail('manifest falsely claims caret device PASS');

console.log('MATHLIVE_CARET_FOCUS_SLOT_CONTRACT_Q192_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
