#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_real_device_defect_repair_compile_fix_v172_q190r1.mjs', preservedPhase: 'verify_mathlive_real_device_defect_repair_compile_fix_v172_q190r1' });

const files = {
  policy: 'lib/features/mathlive/mathlive_real_device_defect_repair_compile_fix_policy.dart',
  test: 'test/v172_q190r1_real_device_defect_repair_compile_fix_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  q190Audit: 'docs/audit/V172_Q190_REAL_DEVICE_DEFECT_REPAIR_AUDIT_REPORT.md',
  q190r1Audit: 'docs/audit/V172_Q190R1_REAL_DEVICE_DEFECT_REPAIR_COMPILE_FIX_AUDIT_REPORT.md',
  q190r1Changed: 'docs/audit/V172_Q190R1_REAL_DEVICE_DEFECT_REPAIR_COMPILE_FIX_CHANGED_FILES_MANIFEST.md',
  q190r1Hash: 'docs/audit/V172_Q190R1_PROTECTED_FILE_HASH_MANIFEST.md',
  keyConfig: 'lib/features/keyboard/key_config.dart',
  mathKeyboard: 'lib/features/keyboard/math_keyboard.dart',
  bottomDock: 'lib/features/keyboard/bottom_dock.dart',
  premiumKey: 'lib/features/keyboard/premium_key.dart',
  longPressPopup: 'lib/features/keyboard/long_press_popup.dart',
  templateTray: 'lib/features/workspace/template_tray.dart',
  graphCard: 'lib/features/graph/graph_card.dart',
  graphController: 'lib/features/graph/graph_controller.dart',
  historyController: 'lib/features/history/history_controller.dart',
  historyPanel: 'lib/features/history/history_panel.dart',
  solutionPanel: 'lib/features/solution/solution_steps_panel.dart',
};

const failures = [];
const text = {};
for (const [name, path] of Object.entries(files)) {
  if (!fs.existsSync(path)) failures.push(`missing required file: ${path}`);
  else text[name] = fs.readFileSync(path, 'utf8');
}
text.prodSurfaceCombined = `${text.prodSurface || ''}\n${text.prodSurfacePart || ''}`;
const has = (name, needle) => {
  if (!text[name]?.includes(needle)) failures.push(`${files[name]} missing ${needle}`);
};
const lacks = (name, needle) => {
  if (text[name]?.includes(needle)) failures.push(`${files[name]} must not contain ${needle}`);
};

function sliceBetween(source, startNeedle, endNeedle) {
  const start = source.indexOf(startNeedle);
  if (start < 0) return '';
  if (!endNeedle) return source.slice(start);
  const end = source.indexOf(endNeedle, start + startNeedle.length);
  return source.slice(start, end < 0 ? source.length : end);
}

has('policy', "phase = 'V172-Q190R1'");
has('policy', "baseline = 'V172-Q190_REAL_DEVICE_DEFECT_REPAIR_COMPILE_BLOCKED'");
has('policy', 'productionHelpersScopedToProductionState = true');
has('policy', 'legacyMainEditorStateMustNotReferenceProductionTail = true');
has('policy', 'legacyMainEditorStateMustNotReferenceProductionEmitState = true');
has('policy', 'enqueueProductionCommandOnlyInProductionState = true');
has('policy', 'insertCommitRequiresActualDeltaWhenBeforeIsNonEmpty = true');
has('policy', 'emptyBeforeMayCommitToNonEmptyAfter = true');
has('policy', 'assistantFlutterAnalyzePassClaimed = false');
has('policy', 'androidRealDevicePassClaimed = false');

has('test', 'MathLiveRealDeviceDefectRepairCompileFixPolicy.phase');
has('test', 'productionHelpersScopedToProductionState');
has('test', 'insertCommitRequiresActualDeltaWhenBeforeIsNonEmpty');

const surface = text.prodSurfaceCombined || '';
const legacyState = sliceBetween(
  surface,
  'class _MathLiveMainEditorSurfaceState',
  'class MathLiveProductionEditorSurface'
);
const productionState = sliceBetween(
  surface,
  'class _MathLiveProductionEditorSurfaceState',
  ''
);
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');

for (const forbidden of ['_enqueueProductionCommand', '_productionCommandTail', '_runProductionJavascript', '_refreshProductionStateDeferred', '_emitState(']) {
  if (legacyState.includes(forbidden)) failures.push(`legacy _MathLiveMainEditorSurfaceState must not reference ${forbidden}`);
}
for (const required of ['_enqueueProductionCommand', '_productionCommandTail', '_runProductionJavascript', '_refreshProductionStateDeferred', '_emitState(']) {
  if (!productionState.includes(required)) failures.push(`production _MathLiveProductionEditorSurfaceState must contain ${required}`);
}
const globalEnqueueCount = (surface.match(/_enqueueProductionCommand/g) || []).length;
if (globalEnqueueCount < 2) failures.push(`_enqueueProductionCommand must appear in production command call and definition, found ${globalEnqueueCount}`);

has('prodBridge', 'function valueChangedOrNonEmpty(before)');
has('prodBridge', "const beforeText = String(before || '');");
has('prodBridge', "const afterText = String(safeGetValue('latex-expanded') || safeGetValue('latex') || '');");
has('prodBridge', 'if (beforeText.trim().length === 0)');
has('prodBridge', 'return afterText.trim().length > 0;');
has('prodBridge', 'return afterText !== beforeText;');
lacks('prodBridge', "return after !== before || String(after || '').trim().length > 0;");

has('manifest', 'v172Q190R1RealDeviceDefectRepairCompileFix');
has('manifest', 'V172-Q190R1-REAL-DEVICE-DEFECT-REPAIR-COMPILE-FIX');
has('manifest', 'activeCurrentPhaseCompatibilityNote');
has('manifest', 'latestProductionPhase');
has('readme', 'V172-Q190R1 — Real Device Defect Repair Compile Fix');
has('readme', 'flutter analyze gerçek PASS bu asistan ortamında üretilemedi');
has('q190r1Audit', 'V172-Q190R1 Real Device Defect Repair Compile Fix Audit Report');
has('q190r1Changed', 'V172-Q190R1 Real Device Defect Repair Compile Fix Changed Files Manifest');
has('q190r1Hash', 'V172-Q190R1 Protected File Hash Manifest');
has('q190r1Hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of [
  'keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup',
  'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel',
]) {
  lacks(protectedName, 'V172-Q190R1');
  lacks(protectedName, 'Real Device Defect Repair Compile Fix');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r1 = manifest.v172Q190R1RealDeviceDefectRepairCompileFix;
  if (!q190r1) failures.push('manifest missing v172Q190R1RealDeviceDefectRepairCompileFix object');
  else {
    if (q190r1.phase !== 'V172-Q190R1') failures.push('manifest q190r1 phase mismatch');
    if (q190r1.newFeatureAllowed !== false) failures.push('q190r1 must not allow new features');
    if (q190r1.productionHelpersScopedToProductionState !== true) failures.push('q190r1 must scope production helpers to production state');
    if (q190r1.legacyMainEditorStateMustNotReferenceProductionTail !== true) failures.push('q190r1 must block legacy production tail refs');
    if (q190r1.insertCommitRequiresActualDeltaWhenBeforeIsNonEmpty !== true) failures.push('q190r1 must harden insert commit predicate');
    if (q190r1.assistantFlutterAnalyzePassClaimed !== false) failures.push('q190r1 must not claim assistant-side flutter analyze PASS');
    if (q190r1.androidRealDevicePassClaimed !== false) failures.push('q190r1 must not claim Android PASS');
  }
  if (![
    'V172-Q190R1-REAL-DEVICE-DEFECT-REPAIR-COMPILE-FIX',
    'V172-Q190R2-PRODUCTION-ACTIVE-PATH-HARDENING',
    'V172-Q190R3-PRODUCTION-COMMAND-BUS-COURT',
    'V172-Q190R4-PRODUCTION-BRIDGE-QUEUE-FOCUS-REPAIR',
    'V172-Q190R5-TEMPLATE-PAYLOAD-SURGICAL-REPAIR',
    'V172-Q190R6-NO-FREEZE-RUNTIME-INVARIANT',
    'V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION',
    'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE',
    'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE',
  , 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R1 or a verified successor phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_REAL_DEVICE_DEFECT_REPAIR_COMPILE_FIX_Q190R1_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}

console.log('MATHLIVE_REAL_DEVICE_DEFECT_REPAIR_COMPILE_FIX_Q190R1_STATIC_READY_BUT_FLUTTER_ANALYZE_REQUIRED');
