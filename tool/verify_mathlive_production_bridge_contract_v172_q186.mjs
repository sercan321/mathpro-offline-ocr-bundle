#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_bridge_contract_v172_q186.mjs', preservedPhase: 'verify_mathlive_production_bridge_contract_v172_q186' });

const files = {
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  surface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  appShell: 'lib/app/app_shell.dart',
  policy: 'lib/features/mathlive/mathlive_production_bridge_contract_policy.dart',
  test: 'test/v172_q186_production_mathlive_bridge_contract_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
};
const text = Object.fromEntries(Object.entries(files).map(([k, p]) => [k, fs.readFileSync(p, 'utf8')]));
text.surfaceCombined = `${text.surface}\n${text.prodSurface || ''}`;
const failures = [];
text.prodSurfaceCombined = `${text.prodSurface || ''}\n${text.prodSurfacePart || ''}`;
const has = (name, needle) => { if (!text[name].includes(needle)) failures.push(`${files[name]} missing ${needle}`); };
const lacks = (name, needle) => { if (text[name].includes(needle)) failures.push(`${files[name]} must not contain ${needle}`); };

has('bridge', "const BRIDGE_CONTRACT_PHASE = 'V172-Q186'");
has('bridge', 'productionBridgeContractPhase: BRIDGE_CONTRACT_PHASE');
has('bridge', 'Object.freeze({');
has('bridge', 'notifyFlutterState');
has('bridge', 'getLatex');
has('bridge', 'mountedMathfield()');
has('bridge', 'customMathfieldDefined()');
has('bridge', 'mathfieldInstanceMounted: false');
has('bridge', 'selectionMode: \'placeholder\'');

for (const forbidden of [
  'executeMathProCommand',
  'getState:',
  'flushQueuedCommands',
  'scheduleMount:',
  'getRealDeviceDiagnosticReport',
  'runQ169FinalSelfTestCourt',
  'getRuntimeSmokeEvidenceReport',
  'COURT_SINGLE_SOURCE',
  'runtimeSmokeEvidenceReport',
]) {
  lacks('bridge', forbidden);
}

const apiBlockMatch = text.bridge.match(/window\.MathProProductionMathLiveBridge\s*=\s*Object\.freeze\(\{([\s\S]*?)\}\);/);
if (!apiBlockMatch) {
  failures.push('production bridge exported Object.freeze API block not found');
} else {
  const apiBlock = apiBlockMatch[1];
  const required = ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState'];
  for (const name of required) {
    if (!new RegExp(`(^|\\n)\\s*${name}(,|\\s*:|\\s*$)`, 'm').test(apiBlock)) failures.push(`public bridge API missing ${name}`);
  }
  for (const name of ['executeMathProCommand', 'getState', 'scheduleMount', 'flushQueuedCommands', 'runQueuedCommands']) {
    if (new RegExp(`(^|\\n)\\s*${name}(,|\\s*:|\\s*$)`, 'm').test(apiBlock)) failures.push(`forbidden public bridge API exposed: ${name}`);
  }
}

has('surface', "import 'mathlive_production_bridge_contract_policy.dart';");
has('surfaceCombined', 'MathLiveProductionBridgeContractPolicy.phase');
has('surfaceCombined', 'MathLiveProductionBridgeContractPolicy.flutterControllerQueueMayFlush');
has('surfaceCombined', 'window.MathProProductionMathLiveBridge.insertLatex');
has('surfaceCombined', 'window.MathProProductionMathLiveBridge.deleteBackward');
has('surfaceCombined', 'window.MathProProductionMathLiveBridge.clear');
has('surfaceCombined', 'window.MathProProductionMathLiveBridge.notifyFlutterState');
has('surfaceCombined', "message.contains('mathfieldElementDefined\":true')");
has('surfaceCombined', "message.contains('mathfieldInstanceMounted\":true')");
lacks('surfaceCombined', 'MathProProductionMathLiveBridge.executeMathProCommand');
lacks('surfaceCombined', 'MathProProductionMathLiveBridge.getState');

has('appShell', "import '../features/mathlive/mathlive_production_platform_view_policy.dart';");
has('appShell', 'if (!MathLiveProductionPlatformViewPolicy.canUseProductionWebView)');
lacks('appShell', "import '../features/mathlive/mathlive_lab_screen_policy.dart';");
lacks('appShell', 'MathLiveLabScreenPolicy.canUseRuntimeWebView');
has('appShell', 'V172-Q186: on a real WebView runtime, MathLive is the only production');

has('policy', "phase = 'V172-Q186'");
has('policy', 'minimalPublicApiFrozen = true');
has('policy', 'realDeviceFlutterMirrorFeedsProductionSurface = false');
has('policy', 'strictRuntimeMountedRequiresCustomElement = true');
has('test', 'MathLiveProductionBridgeContractPolicy.publicBridgeApi');
has('manifest', 'v172Q186ProductionMathLiveBridgeContractFreeze');
has('readme', 'V172-Q186 — Minimal Production MathLive Bridge Contract Freeze');

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_BRIDGE_CONTRACT_Q186_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_BRIDGE_CONTRACT_Q186_PACKAGE_READY_BUT_FLUTTER_DEVICE_EVIDENCE_REQUIRED');
