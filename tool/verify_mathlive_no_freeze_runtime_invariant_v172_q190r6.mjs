#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_no_freeze_runtime_invariant_v172_q190r6.mjs', preservedPhase: 'verify_mathlive_no_freeze_runtime_invariant_v172_q190r6' });

const files = {
  policy: 'lib/features/mathlive/mathlive_no_freeze_runtime_invariant_policy.dart',
  test: 'test/v172_q190r6_no_freeze_runtime_invariant_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  audit: 'docs/audit/V172_Q190R6_NO_FREEZE_RUNTIME_INVARIANT_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q190R6_NO_FREEZE_RUNTIME_INVARIANT_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q190R6_PROTECTED_FILE_HASH_MANIFEST.md',
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

has('policy', "phase = 'V172-Q190R6'");
has('policy', "baseline = 'V172-Q190R5_TEMPLATE_PAYLOAD_SURGICAL_REPAIR'");
has('policy', "repairScope = 'production-no-freeze-runtime-invariant'");
has('policy', 'flutterKeyPressMayAwaitWebViewJavascript = false');
has('policy', 'productionSendKeyReturnsAfterScheduling = true');
has('policy', 'productionBridgeResultDeliveredByStatePush = true');
has('policy', 'webViewJavascriptStillTimeoutBounded = true');
has('policy', 'priorityClearAlwaysReleasesDartQueue = true');
has('policy', 'javascriptPendingQueueHasDeterministicBounds = true');
has('policy', 'productionTailErrorsMustBeCaught = true');
has('policy', 'androidRealDevicePassClaimed = false');
has('policy', 'premiumSymbolVisualPassClaimed = false');
has('policy', 'caretRealDevicePassClaimed = false');

has('test', 'MathLiveNoFreezeRuntimeInvariantPolicy.phase');
has('test', 'productionSendKeyReturnsAfterScheduling');
has('test', 'flutterKeyPressMayAwaitWebViewJavascript');

has('prodSurfaceCombined', "import 'mathlive_no_freeze_runtime_invariant_policy.dart';");
has('prodSurfaceCombined', "'noFreezeRuntimeInvariantPhase': MathLiveNoFreezeRuntimeInvariantPolicy.phase");
has('prodSurfaceCombined', 'q190r6-dart-command-accepted-nonblocking');
if (!((text.prodSurfaceCombined || '').includes('return Future<bool>.value(true);') || (text.prodSurfaceCombined || '').includes('return true;'))) failures.push(`${files.prodSurface} missing immediate success return marker`);
has('prodSurfaceCombined', 'q190r6-production-command-timeout-or-exception');
if (!((text.prodSurfaceCombined || '').includes('q190r6-production-tail-error-released') || (text.prodSurfaceCombined || '').includes('q200-production-tail-error-released'))) failures.push(`${files.prodSurface} missing tail-error release marker`);
has('prodSurfaceCombined', 'MathLiveNoFreezeRuntimeInvariantPolicy.statePushCommandTimeout');

const surface = text.prodSurfaceCombined || '';
const legacyState = sliceBetween(surface, 'class _MathLiveMainEditorSurfaceState', 'class MathLiveProductionEditorSurface');
const productionState = sliceBetween(surface, 'class _MathLiveProductionEditorSurfaceState', '  String? _decodeJavascriptStringResult');
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');
if (legacyState.includes('Q190R6') || legacyState.includes('NoFreeze') || legacyState.includes('noFreezeRuntimeInvariantPhase')) {
  failures.push('legacy _MathLiveMainEditorSurfaceState must not contain Q190R6 no-freeze production code');
}
if (productionState.includes('runJavaScriptReturningResult(')) {
  failures.push('active production state must not use runJavaScriptReturningResult');
}
const enqueueBlock = sliceBetween(productionState, productionState.includes('bool _enqueueProductionCommand') ? 'bool _enqueueProductionCommand' : 'Future<bool> _enqueueProductionCommand', 'Future<bool> _runProductionJavascript');
if (!enqueueBlock) failures.push('production _enqueueProductionCommand block not found');
if (enqueueBlock.includes('Completer<bool>')) failures.push('production _enqueueProductionCommand must not create a Completer tied to WebView completion');
if (enqueueBlock.includes('completer.future.timeout')) failures.push('production _enqueueProductionCommand must not return a WebView-budget future');
if (!(enqueueBlock.includes('return Future<bool>.value(true);') || enqueueBlock.includes('return true;'))) failures.push('production _enqueueProductionCommand must return immediately after scheduling');
if (!enqueueBlock.includes('_productionCommandTail = _productionCommandTail.catchError((_) {}).then((_) async')) failures.push('production dispatch tail must remain serialized and error-isolated');
if (!enqueueBlock.includes('unawaited(_productionCommandTail.catchError')) failures.push('production dispatch tail errors must be caught asynchronously');

has('prodBridge', "NO_FREEZE_RUNTIME_INVARIANT_PHASE = 'V172-Q190R6'");
has('prodBridge', 'noFreezeRuntimeInvariantPhase: NO_FREEZE_RUNTIME_INVARIANT_PHASE');
has('prodBridge', 'flutterKeyPressMayAwaitWebViewJavascript: false');
if (!((text.prodBridge || '').includes("commandCompletionMode: 'q190r6-nonblocking-fire-and-state-push'") || (text.prodBridge || '').includes("commandCompletionMode: 'q200-schedule-now-fire-and-state-push'"))) failures.push(`${files.prodBridge} missing no-freeze commandCompletionMode marker`);
has('prodBridge', 'q190r6-js-command-queued-bounded');
if (!((text.prodBridge || '').includes('q190r6-js-queue-overflow-drop-oldest') || (text.prodBridge || '').includes('q200-js-queue-overflow-drop-oldest-released'))) failures.push(`${files.prodBridge} missing queue overflow drop marker`);
if (!((text.prodBridge || '').includes('q190r6-js-queue-flush-complete-released') || (text.prodBridge || '').includes('q200-js-queue-flush-complete-released'))) failures.push(`${files.prodBridge} missing queue flush complete release marker`);
has('prodBridge', 'q190r6-js-priority-command-reset-pending-queue');
has('prodBridge', 'q190r6-js-clear-reset-pending-queue');
for (const api of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) has('prodBridge', api);
lacks('prodBridge', 'executeMathProCommand');
lacks('prodBridge', 'getRealDeviceDiagnosticReport');
lacks('prodBridge', 'runQ169FinalSelfTestCourt');

has('manifest', 'v172Q190R6NoFreezeRuntimeInvariant');
has('manifest', 'V172-Q190R6-NO-FREEZE-RUNTIME-INVARIANT');
has('manifest', 'flutterKeyPressMayAwaitWebViewJavascript');
has('manifest', 'productionSendKeyReturnsAfterScheduling');
has('manifest', 'productionBridgeResultDeliveredByStatePush');
has('readme', 'V172-Q190R6 — No-Freeze Runtime Invariant');
has('audit', 'V172-Q190R6 No-Freeze Runtime Invariant Audit Report');
has('changed', 'V172-Q190R6 No-Freeze Runtime Invariant Changed Files Manifest');
has('hash', 'V172-Q190R6 Protected File Hash Manifest');
has('hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of ['keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup', 'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel']) {
  lacks(protectedName, 'V172-Q190R6');
  lacks(protectedName, 'No-Freeze Runtime Invariant');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r6 = manifest.v172Q190R6NoFreezeRuntimeInvariant;
  if (!q190r6) failures.push('manifest missing v172Q190R6NoFreezeRuntimeInvariant object');
  else {
    if (q190r6.phase !== 'V172-Q190R6') failures.push('manifest q190r6 phase mismatch');
    if (q190r6.newFeatureAllowed !== false) failures.push('q190r6 must not allow new features');
    if (q190r6.flutterKeyPressMayAwaitWebViewJavascript !== false) failures.push('q190r6 keypress await gate mismatch');
    if (q190r6.productionSendKeyReturnsAfterScheduling !== true) failures.push('q190r6 scheduling return gate missing');
    if (q190r6.productionBridgeResultDeliveredByStatePush !== true) failures.push('q190r6 state push gate missing');
    if (q190r6.androidRealDevicePassClaimed !== false) failures.push('q190r6 must not claim Android PASS');
  }
  if (!['V172-Q190R6-NO-FREEZE-RUNTIME-INVARIANT', 'V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION', 'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE', 'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE', 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R6 or a verified Q190R6-preserving successor phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_NO_FREEZE_RUNTIME_INVARIANT_Q190R6_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_NO_FREEZE_RUNTIME_INVARIANT_Q190R6_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED');
