#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_real_device_defect_repair_v172_q190.mjs', preservedPhase: 'verify_mathlive_real_device_defect_repair_v172_q190' });

const files = {
  policy: 'lib/features/mathlive/mathlive_real_device_defect_repair_policy.dart',
  test: 'test/v172_q190_real_device_defect_repair_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  q186Verifier: 'tool/verify_mathlive_production_bridge_contract_v172_q186.mjs',
  q189Verifier: 'tool/verify_mathlive_single_device_candidate_v172_q189.mjs',
  q190Audit: 'docs/audit/V172_Q190_REAL_DEVICE_DEFECT_REPAIR_AUDIT_REPORT.md',
  q190Changed: 'docs/audit/V172_Q190_REAL_DEVICE_DEFECT_REPAIR_CHANGED_FILES_MANIFEST.md',
  q190Hash: 'docs/audit/V172_Q190_PROTECTED_FILE_HASH_MANIFEST.md',
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

has('policy', "phase = 'V172-Q190'");
has('policy', "failureSource = 'Q189_REAL_ANDROID_DEVICE_FAIL'");
has('policy', "repairScope = 'production-mathlive-freeze-render-bridge-defect'");
has('policy', 'newFeatureAllowed = false');
has('policy', 'keyboardLayoutMutationAllowed = false');
has('policy', 'moreInventoryMutationAllowed = false');
has('policy', 'longPressOrderMutationAllowed = false');
has('policy', 'graphUiMutationAllowed = false');
has('policy', 'historyPanelMutationAllowed = false');
has('policy', 'solutionStepsPanelMutationAllowed = false');
has('policy', 'productionBridgeFireAndStatePush = true');
has('policy', 'androidReturningResultForKeypressesDisabled = true');
has('policy', 'commandDispatchSerialized = true');
has('policy', 'commandTimeoutPreventsQueueLock = true');
has('policy', 'insertCommitFallbackEnabled = true');
has('policy', 'postInsertStatePushRequired = true');
has('policy', 'clearMustPurgeMathLiveState = true');
has('policy', 'androidBridgeCommandTimeout');

has('test', 'MathLiveRealDeviceDefectRepairPolicy.phase');
has('test', 'androidReturningResultForKeypressesDisabled');
has('test', 'commandDispatchSerialized');
has('test', 'insertCommitFallbackEnabled');

has('prodSurfaceCombined', "import 'mathlive_real_device_defect_repair_policy.dart';");
has('prodSurfaceCombined', '_productionCommandTail');
has('prodSurfaceCombined', '_enqueueProductionCommand');
has('prodSurfaceCombined', '_runProductionJavascript');
has('prodSurfaceCombined', '_refreshProductionStateDeferred');
has('prodSurfaceCombined', 'MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout');
if (!((text.prodSurfaceCombined || '').includes('MathLiveRealDeviceDefectRepairPolicy.androidBridgeTotalCommandBudget') || (text.prodSurfaceCombined || '').includes('q190r6-dart-command-accepted-nonblocking'))) {
  failures.push(`${files.prodSurface} missing legacy command budget marker or Q190R6 nonblocking successor marker`);
}
if (!((text.prodSurfaceCombined || '').includes('q190-production-command-timeout-or-exception') || (text.prodSurfaceCombined || '').includes('q190r6-production-command-timeout-or-exception'))) {
  failures.push(`${files.prodSurface} missing Q190 command timeout marker or Q190R6 successor marker`);
}
if (!((text.prodSurfaceCombined || '').includes('q190-production-command-refresh') || (text.prodSurfaceCombined || '').includes('q190r3-production-command-refresh'))) {
  failures.push(`${files.prodSurface} missing q190 production command refresh marker or verified successor marker`);
}
has('prodBridge', 'q190-production-clear');
lacks('prodSurfaceCombined', "runJavaScriptReturningResult('JSON.stringify($jsExpression)'");

has('prodBridge', "REAL_DEVICE_DEFECT_REPAIR_PHASE = 'V172-Q190'");
has('prodBridge', 'realDeviceDefectRepairPhase');
has('prodBridge', 'completeCommand');
has('prodBridge', 'safeFocusMathfield');
has('prodBridge', 'trySetMathfieldValue');
has('prodBridge', 'mathfield.executeCommand-insert');
if (!text.prodBridge?.includes('direct-setValue-sanitized-document-latex') && !text.prodBridge?.includes('q190r5-direct-setValue-document-placeholder-latex')) failures.push(`${files.prodBridge} missing Q190/Q190R5 direct setValue fallback marker`);
has('prodBridge', 'q190-production-insert-ok');
has('prodBridge', 'q190-production-insert-fail');
has('prodBridge', 'q190-production-clear');
has('prodBridge', 'window.MathProProductionMathLiveBridge = Object.freeze({');
for (const api of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) {
  has('prodBridge', api);
}
lacks('prodBridge', 'executeMathProCommand');
lacks('prodBridge', 'getRealDeviceDiagnosticReport');
lacks('prodBridge', 'runQ169FinalSelfTestCourt');

has('prodHtml', 'data-mathpro-production-html="V172-Q185"');
has('manifest', 'v172Q190RealDeviceDefectRepair');
has('manifest', 'V172-Q190-MATHLIVE-REAL-DEVICE-DEFECT-REPAIR');
has('manifest', 'androidReturningResultForKeypressesDisabled');
has('manifest', 'commandTimeoutPreventsQueueLock');
has('manifest', 'insertCommitFallbackEnabled');
has('manifest', 'realDevicePassClaimed');
has('readme', 'V172-Q190 — Real Device Defect Repair');
has('readme', 'Q189 gerçek Android cihazda FAIL oldu');
has('q190Audit', 'V172-Q190 Real Device Defect Repair Audit Report');
has('q190Changed', 'V172-Q190 Real Device Defect Repair Changed Files Manifest');
has('q190Hash', 'V172-Q190 Protected File Hash Manifest');
has('q190Hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of [
  'keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup',
  'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel',
]) {
  lacks(protectedName, 'V172-Q190');
  lacks(protectedName, 'Real Device Defect Repair');
}


// V172-Q190R1 compile-scope guard: Q190 production helpers must never be
// copied into the legacy main editor state again. Keeping this gate in the
// original Q190 verifier prevents the exact Android-defect repair package from
// regressing back to an analyzer/build blocker.
function sliceBetween(source, startNeedle, endNeedle) {
  const start = source.indexOf(startNeedle);
  if (start < 0) return '';
  if (!endNeedle) return source.slice(start);
  const end = source.indexOf(endNeedle, start + startNeedle.length);
  return source.slice(start, end < 0 ? source.length : end);
}
const legacyState = sliceBetween(
  text.prodSurfaceCombined || '',
  'class _MathLiveMainEditorSurfaceState',
  'class MathLiveProductionEditorSurface'
);
const productionState = sliceBetween(
  text.prodSurfaceCombined || '',
  'class _MathLiveProductionEditorSurfaceState',
  ''
);
for (const forbidden of ['_enqueueProductionCommand', '_productionCommandTail', '_runProductionJavascript', '_refreshProductionStateDeferred', '_emitState(']) {
  if (legacyState.includes(forbidden)) failures.push(`legacy _MathLiveMainEditorSurfaceState must not reference ${forbidden}`);
}
for (const required of ['_enqueueProductionCommand', '_productionCommandTail', '_runProductionJavascript', '_refreshProductionStateDeferred', '_emitState(']) {
  if (!productionState.includes(required)) failures.push(`production _MathLiveProductionEditorSurfaceState must contain ${required}`);
}
has('prodBridge', "const beforeText = String(before || '');");
has('prodBridge', 'if (beforeText.trim().length === 0)');
has('prodBridge', 'return afterText !== beforeText;');
lacks('prodBridge', "return after !== before || String(after || '').trim().length > 0;");

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190 = manifest.v172Q190RealDeviceDefectRepair;
  if (!q190) failures.push('manifest missing v172Q190RealDeviceDefectRepair object');
  else {
    if (q190.phase !== 'V172-Q190') failures.push('manifest q190 phase mismatch');
    if (q190.newFeatureAllowed !== false) failures.push('q190 must not allow new features');
    if (q190.productionBridgePublicApiMutationAllowed !== false) failures.push('q190 must not mutate production bridge public API');
    if (q190.androidReturningResultForKeypressesDisabled !== true) failures.push('q190 must disable returning-result keypress dispatch');
    if (q190.commandDispatchSerialized !== true) failures.push('q190 must serialize commands');
    if (q190.realDevicePassClaimed !== false) failures.push('q190 must not claim real-device PASS');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_REAL_DEVICE_DEFECT_REPAIR_Q190_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}

console.log('MATHLIVE_REAL_DEVICE_DEFECT_REPAIR_Q190_PACKAGE_READY_BUT_ANDROID_RETEST_REQUIRED');
