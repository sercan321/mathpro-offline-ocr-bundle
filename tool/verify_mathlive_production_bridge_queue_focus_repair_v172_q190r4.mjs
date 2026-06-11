#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_bridge_queue_focus_repair_v172_q190r4.mjs', preservedPhase: 'verify_mathlive_production_bridge_queue_focus_repair_v172_q190r4' });

const files = {
  policy: 'lib/features/mathlive/mathlive_production_bridge_queue_focus_repair_policy.dart',
  test: 'test/v172_q190r4_production_bridge_queue_focus_repair_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  appShell: 'lib/app/app_shell.dart',
  workspace: 'lib/features/workspace/workspace_panel.dart',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  audit: 'docs/audit/V172_Q190R4_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q190R4_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q190R4_PROTECTED_FILE_HASH_MANIFEST.md',
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

has('policy', "phase = 'V172-Q190R4'");
has('policy', "baseline = 'V172-Q190R3_PRODUCTION_COMMAND_BUS_COURT'");
has('policy', "repairScope = 'production-bridge-queue-focus-commit-repair'");
has('policy', 'activeProductionCurrentStateUsesPushNotReturningResult = true');
has('policy', 'clearCommandMustResetDartCommandTail = true');
has('policy', 'clearCommandMustResetBridgePendingQueue = true');
has('policy', 'templatePayloadDocumentFallbackBlocked = true');
has('policy', 'rawInsertTokenCommitRejected = true');
has('policy', 'postCommandFocusRefreshRequired = true');
has('policy', 'productionPublicApiExpansionAllowed = false');
has('policy', 'visualDebugOverlayAllowed = false');
has('policy', 'androidRealDevicePassClaimed = false');
has('policy', 'premiumSymbolVisualPassClaimed = false');
has('policy', 'caretRealDevicePassClaimed = false');

has('test', 'MathLiveProductionBridgeQueueFocusRepairPolicy.phase');
has('test', 'activeProductionCurrentStateUsesPushNotReturningResult');
has('test', 'clearCommandMustResetDartCommandTail');
has('test', 'templatePayloadDocumentFallbackBlocked');

has('appShell', 'final bool _useMathLiveMainEditor = true;');
has('workspace', 'MathLiveProductionEditorSurface(');

has('prodSurfaceCombined', "import 'mathlive_production_bridge_queue_focus_repair_policy.dart';");
has('prodSurfaceCombined', "'bridgeQueueFocusRepairPhase': MathLiveProductionBridgeQueueFocusRepairPolicy.phase");
has('prodSurfaceCombined', '_productionCommandEpoch');
has('prodSurfaceCombined', 'priorityReset: command.action == \'clear\'');
if (!((text.prodSurfaceCombined || '').includes('q190r4-dart-priority-clear-reset-$label-$sequence') || (text.prodSurfaceCombined || '').includes('q190r6-dart-priority-clear-nonblocking-reset-$label-$sequence'))) {
  failures.push(`${files.prodSurface} missing Q190R4 priority clear reset marker or Q190R6 nonblocking successor marker`);
}
if (!((text.prodSurfaceCombined || '').includes('q190r4-dart-stale-dispatch-completed-after-priority-reset-$label-$sequence') || (text.prodSurfaceCombined || '').includes('q190r6-dart-stale-dispatch-completed-after-priority-reset-$label-$sequence'))) {
  failures.push(`${files.prodSurface} missing Q190R4 stale dispatch marker or Q190R6 successor marker`);
}
has('prodSurfaceCombined', 'q190r4-production-current-state-push');
has('prodSurfaceCombined', 'return _lastProductionStateJson.isEmpty ? null : _lastProductionStateJson;');
if (!((text.prodSurfaceCombined || '').includes('q190r4-production-command-budget-timeout-$label-$sequence') || (text.prodSurfaceCombined || '').includes('q190r6-production-command-timeout-or-exception-$label-$sequence'))) {
  failures.push(`${files.prodSurface} missing Q190R4 command budget timeout marker or Q190R6 command timeout successor marker`);
}

const surface = text.prodSurfaceCombined || '';
const legacyState = sliceBetween(surface, 'class _MathLiveMainEditorSurfaceState', 'class MathLiveProductionEditorSurface');
const productionState = sliceBetween(surface, 'class _MathLiveProductionEditorSurfaceState', '');
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');
if (legacyState.includes('q190r4') || legacyState.includes('MathLiveProductionBridgeQueueFocusRepairPolicy')) {
  failures.push('legacy _MathLiveMainEditorSurfaceState must not contain Q190R4 production repair code');
}
if (productionState.includes('runJavaScriptReturningResult(')) {
  failures.push('active _MathLiveProductionEditorSurfaceState must not use runJavaScriptReturningResult');
}
for (const required of ['_productionCommandEpoch', 'priorityReset', 'q190r4-production-current-state-push', '_lastProductionStateJson']) {
  if (!productionState.includes(required)) failures.push(`production state missing ${required}`);
}
const productionBuild = sliceBetween(productionState, 'Widget build(BuildContext context)', '// Q140:');
if (productionBuild.includes('_MathLiveAppShellVisibleFallbackOverlay')) failures.push('production build must not use Flutter visible fallback overlay');
if (productionBuild.includes('_MathLiveDiagnosticOverlay')) failures.push('production build must not use Q169 diagnostic overlay');

has('prodBridge', "BRIDGE_QUEUE_FOCUS_REPAIR_PHASE = 'V172-Q190R4'");
has('prodBridge', 'bridgeQueueFocusRepairPhase: BRIDGE_QUEUE_FOCUS_REPAIR_PHASE');
has('prodBridge', 'function resetPendingCommands(reason)');
if (!((text.prodBridge || '').includes("resetPendingCommands('q190r4-js-priority-command-reset-pending-queue')") || (text.prodBridge || '').includes("resetPendingCommands('q190r6-js-priority-command-reset-pending-queue')"))) {
  failures.push(`${files.prodBridge} missing Q190R4 priority queue reset marker or Q190R6 successor marker`);
}
if (!((text.prodBridge || '').includes("resetPendingCommands('q190r4-js-clear-reset-pending-queue')") || (text.prodBridge || '').includes("resetPendingCommands('q190r6-js-clear-reset-pending-queue')"))) {
  failures.push(`${files.prodBridge} missing Q190R4 clear queue reset marker or Q190R6 successor marker`);
}
if (!text.prodBridge?.includes("trace('q190r4-js-template-document-fallback-blocked'") && !text.prodBridge?.includes("q190r5-js-template-raw-token-fallback-blocked")) failures.push(`${files.prodBridge} missing Q190R4/Q190R5 template fallback block marker`);
if (!text.prodBridge?.includes("state.lastFailureReason = 'q190r4-template-insert-not-committed-no-document-fallback'") && !text.prodBridge?.includes("q190r5-template-document-payload-still-has-raw-token")) failures.push(`${files.prodBridge} missing Q190R4/Q190R5 template fallback failure marker`);
has('prodBridge', 'if (!containsRawInsertToken(latex))');
has('prodBridge', 'containsRawInsertToken(afterText)');
has('prodBridge', 'window.MathProProductionMathLiveBridge = Object.freeze({');
for (const api of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) has('prodBridge', api);
lacks('prodBridge', 'getCommandTrace');
lacks('prodBridge', 'executeMathProCommand');
lacks('prodBridge', 'getRealDeviceDiagnosticReport');
lacks('prodBridge', 'runQ169FinalSelfTestCourt');

has('manifest', 'v172Q190R4ProductionBridgeQueueFocusRepair');
has('manifest', 'V172-Q190R4-PRODUCTION-BRIDGE-QUEUE-FOCUS-REPAIR');
has('manifest', 'activeProductionCurrentStateUsesPushNotReturningResult');
has('manifest', 'clearCommandMustResetDartCommandTail');
has('manifest', 'templatePayloadDocumentFallbackBlocked');
has('readme', 'V172-Q190R4 — Production Bridge Queue Focus Repair');
has('audit', 'V172-Q190R4 Production Bridge Queue Focus Repair Audit Report');
has('changed', 'V172-Q190R4 Production Bridge Queue Focus Repair Changed Files Manifest');
has('hash', 'V172-Q190R4 Protected File Hash Manifest');
has('hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of ['keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup', 'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel']) {
  lacks(protectedName, 'V172-Q190R4');
  lacks(protectedName, 'Production Bridge Queue Focus Repair');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r4 = manifest.v172Q190R4ProductionBridgeQueueFocusRepair;
  if (!q190r4) failures.push('manifest missing v172Q190R4ProductionBridgeQueueFocusRepair object');
  else {
    if (q190r4.phase !== 'V172-Q190R4') failures.push('manifest q190r4 phase mismatch');
    if (q190r4.newFeatureAllowed !== false) failures.push('q190r4 must not allow new features');
    if (q190r4.activeProductionCurrentStateUsesPushNotReturningResult !== true) failures.push('q190r4 push state gate missing');
    if (q190r4.clearCommandMustResetDartCommandTail !== true) failures.push('q190r4 clear Dart tail reset gate missing');
    if (q190r4.clearCommandMustResetBridgePendingQueue !== true) failures.push('q190r4 clear JS queue reset gate missing');
    if (q190r4.templatePayloadDocumentFallbackBlocked !== true) failures.push('q190r4 template fallback block gate missing');
    if (q190r4.androidRealDevicePassClaimed !== false) failures.push('q190r4 must not claim Android PASS');
  }
  if (!['V172-Q190R4-PRODUCTION-BRIDGE-QUEUE-FOCUS-REPAIR', 'V172-Q190R5-TEMPLATE-PAYLOAD-SURGICAL-REPAIR', 'V172-Q190R6-NO-FREEZE-RUNTIME-INVARIANT', 'V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION', 'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE', 'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE', 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R4 or a Q190R4-preserving superseding production phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR_Q190R4_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR_Q190R4_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED');
