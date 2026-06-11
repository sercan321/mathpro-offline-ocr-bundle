#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_command_bus_court_v172_q190r3.mjs', preservedPhase: 'verify_mathlive_production_command_bus_court_v172_q190r3' });

const files = {
  policy: 'lib/features/mathlive/mathlive_production_command_bus_court_policy.dart',
  test: 'test/v172_q190r3_production_command_bus_court_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  appShell: 'lib/app/app_shell.dart',
  workspace: 'lib/features/workspace/workspace_panel.dart',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  audit: 'docs/audit/V172_Q190R3_PRODUCTION_COMMAND_BUS_COURT_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q190R3_PRODUCTION_COMMAND_BUS_COURT_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q190R3_PROTECTED_FILE_HASH_MANIFEST.md',
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

has('policy', "phase = 'V172-Q190R3'");
has('policy', "baseline = 'V172-Q190R2_PRODUCTION_ACTIVE_PATH_HARDENING'");
has('policy', "repairScope = 'production-command-bus-court-and-state-trace'");
has('policy', 'productionBridgeMustEmitCommandTraceStatus = true');
has('policy', 'productionBridgeMustCountReceivedCompletedAndFailedCalls = true');
has('policy', 'productionBridgeMustTraceInsertCommitOutcome = true');
has('policy', 'productionBridgeMustTraceQueueFlush = true');
has('policy', 'productionBridgeMustTraceNotifyFlutterState = true');
has('policy', 'dartSurfaceMustTraceDispatchStartSentFailedAndTimeout = true');
has('policy', 'traceStateIntoSelectionDescription = true');
has('policy', 'productionPublicApiExpansionAllowed = false');
has('policy', 'visualDebugOverlayAllowed = false');
has('policy', 'androidRealDevicePassClaimed = false');
has('policy', 'premiumSymbolVisualPassClaimed = false');
has('policy', 'caretRealDevicePassClaimed = false');

has('test', 'MathLiveProductionCommandBusCourtPolicy.phase');
has('test', 'productionBridgeMustEmitCommandTraceStatus');
has('test', 'traceStateIntoSelectionDescription');
has('test', 'visualDebugOverlayAllowed');

has('appShell', 'final bool _useMathLiveMainEditor = true;');
has('workspace', 'MathLiveProductionEditorSurface(');

has('prodSurfaceCombined', "import 'mathlive_production_command_trace_policy.dart';");
has('prodSurfaceCombined', '_lastProductionStateJson');
has('prodSurfaceCombined', '_lastProductionCommandTrace');
has('prodSurfaceCombined', '_productionDispatchStartedCount');
has('prodSurfaceCombined', '_productionDispatchCompletedCount');
has('prodSurfaceCombined', '_productionDispatchFailureCount');
has('prodSurfaceCombined', "'commandTracePhase': MathLiveProductionCommandTracePolicy.phase");
has('prodSurfaceCombined', "q190r3-dart-dispatch-start-$label-$sequence");
if (!((text.prodSurfaceCombined || '').includes('q190r3-dart-dispatch-sent-$label-$sequence') || (text.prodSurfaceCombined || '').includes('q190r6-dart-dispatch-sent-nonblocking-$label-$sequence'))) {
  failures.push(`${files.prodSurface} missing q190r3 dispatch sent marker or Q190R6 nonblocking successor marker`);
}
if (!((text.prodSurfaceCombined || '').includes('q190r3-dart-dispatch-failed-$label-$sequence') || (text.prodSurfaceCombined || '').includes('q190r6-dart-dispatch-failed-released-$label-$sequence'))) {
  failures.push(`${files.prodSurface} missing q190r3 dispatch failed marker or Q190R6 released successor marker`);
}
if (!((text.prodSurfaceCombined || '').includes('q190r3-production-command-budget-timeout-$label-$sequence') || (text.prodSurfaceCombined || '').includes('q190r6-production-command-timeout-or-exception-$label-$sequence'))) {
  failures.push(`${files.prodSurface} missing q190r3 command budget timeout marker or Q190R6 command timeout successor marker`);
}
has('prodSurfaceCombined', "q190r3-production-current-state");
has('prodSurfaceCombined', 'MathLiveProductionCommandTracePolicy.traceStateIntoSelectionDescription');
has('prodSurfaceCombined', "message.contains('commandTraceStatus')");
has('prodSurfaceCombined', "q190r3-flutter-key-tap-$label");
has('prodSurfaceCombined', "q190r3-flutter-bridge-send-accepted-$label");

const surface = text.prodSurfaceCombined || '';
const legacyState = sliceBetween(surface, 'class _MathLiveMainEditorSurfaceState', 'class MathLiveProductionEditorSurface');
const productionState = sliceBetween(surface, 'class _MathLiveProductionEditorSurfaceState', '');
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');
for (const forbidden of ['_lastProductionStateJson', '_lastProductionCommandTrace', '_productionDispatchStartedCount', '_productionDispatchCompletedCount', '_productionDispatchFailureCount']) {
  if (legacyState.includes(forbidden)) failures.push(`legacy _MathLiveMainEditorSurfaceState must not reference Q190R3 trace field ${forbidden}`);
  if (!productionState.includes(forbidden)) failures.push(`production _MathLiveProductionEditorSurfaceState must contain Q190R3 trace field ${forbidden}`);
}
const productionBuild = sliceBetween(productionState, 'Widget build(BuildContext context)', '// Q140:');
if (productionBuild.includes('_MathLiveAppShellVisibleFallbackOverlay')) failures.push('production build must not use Flutter visible fallback overlay');
if (productionBuild.includes('_MathLiveDiagnosticOverlay')) failures.push('production build must not use Q169 diagnostic overlay');

has('prodBridge', "COMMAND_TRACE_PHASE = 'V172-Q190R3'");
has('prodBridge', 'commandTracePhase: COMMAND_TRACE_PHASE');
has('prodBridge', 'commandTraceStatus');
has('prodBridge', 'commandTraceEvents');
has('prodBridge', 'lastCommandStartedAt');
has('prodBridge', 'lastCommandCompletedAt');
has('prodBridge', 'lastBridgeError');
has('prodBridge', 'bridgeCallReceivedCount');
has('prodBridge', 'bridgeCallCompletedCount');
has('prodBridge', 'bridgeCallFailedCount');
has('prodBridge', 'bridgeNotifyCount');
has('prodBridge', 'function trace(status, extra)');
has('prodBridge', 'function beginBridgeCommand(action, payload)');
has('prodBridge', 'function finishBridgeCommand(status, extra)');
has('prodBridge', 'function failBridgeCommand(status, error)');
if (!((text.prodBridge || '').includes("trace('q190r3-js-command-queued'") || (text.prodBridge || '').includes("trace('q190r6-js-command-queued-bounded'"))) {
  failures.push(`${files.prodBridge} missing q190r3 command queued marker or Q190R6 bounded successor marker`);
}
if (!((text.prodBridge || '').includes("trace('q190r3-js-queue-flush-request'") || (text.prodBridge || '').includes("trace('q190r6-js-queue-flush-request-nonblocking'"))) {
  failures.push(`${files.prodBridge} missing q190r3 queue flush request marker or Q190R6 nonblocking successor marker`);
}
has('prodBridge', "finishBridgeCommand('q190r3-js-insert-committed'");
has('prodBridge', "failBridgeCommand('q190r3-js-insert-not-committed'");
has('prodBridge', "finishBridgeCommand('q190r3-js-delete-backward-complete'");
has('prodBridge', "finishBridgeCommand('q190r3-js-clear-complete'");
has('prodBridge', "finishBridgeCommand('q190r3-js-set-latex-complete'");
has('prodBridge', "trace('q190r3-js-focus-request'");
has('prodBridge', "trace('q190r3-js-keep-caret-visible-request'");
has('prodBridge', 'window.MathProProductionMathLiveBridge = Object.freeze({');
for (const api of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) has('prodBridge', api);
lacks('prodBridge', 'getCommandTrace');
lacks('prodBridge', 'executeMathProCommand');
lacks('prodBridge', 'getRealDeviceDiagnosticReport');
lacks('prodBridge', 'runQ169FinalSelfTestCourt');

has('manifest', 'v172Q190R3ProductionCommandBusCourt');
has('manifest', 'V172-Q190R3-PRODUCTION-COMMAND-BUS-COURT');
has('manifest', 'productionBridgeMustEmitCommandTraceStatus');
has('manifest', 'visualDebugOverlayAllowed');
has('manifest', 'androidRealDevicePassClaimed');
has('readme', 'V172-Q190R3 — Production Command Bus Court');
has('audit', 'V172-Q190R3 Production Command Bus Court Audit Report');
has('changed', 'V172-Q190R3 Production Command Bus Court Changed Files Manifest');
has('hash', 'V172-Q190R3 Protected File Hash Manifest');
has('hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of ['keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup', 'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel']) {
  lacks(protectedName, 'V172-Q190R3');
  lacks(protectedName, 'Production Command Bus Court');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r3 = manifest.v172Q190R3ProductionCommandBusCourt;
  if (!q190r3) failures.push('manifest missing v172Q190R3ProductionCommandBusCourt object');
  else {
    if (q190r3.phase !== 'V172-Q190R3') failures.push('manifest q190r3 phase mismatch');
    if (q190r3.newFeatureAllowed !== false) failures.push('q190r3 must not allow new features');
    if (q190r3.productionBridgeMustEmitCommandTraceStatus !== true) failures.push('q190r3 command trace gate missing');
    if (q190r3.visualDebugOverlayAllowed !== false) failures.push('q190r3 must not allow visual debug overlay');
    if (q190r3.androidRealDevicePassClaimed !== false) failures.push('q190r3 must not claim Android PASS');
  }
  if (![
    'V172-Q190R3-PRODUCTION-COMMAND-BUS-COURT',
    'V172-Q190R4-PRODUCTION-BRIDGE-QUEUE-FOCUS-REPAIR',
    'V172-Q190R5-TEMPLATE-PAYLOAD-SURGICAL-REPAIR',
    'V172-Q190R6-NO-FREEZE-RUNTIME-INVARIANT',
    'V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION',
    'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE',
    'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE',
  , 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R3 or a verified successor phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_COMMAND_BUS_COURT_Q190R3_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_COMMAND_BUS_COURT_Q190R3_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED');
