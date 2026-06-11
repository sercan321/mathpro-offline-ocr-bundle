#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_runtime_command_binding_v172_q157.mjs', retiredPhase: 'verify_mathlive_runtime_command_binding_v172_q157', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const required = [];
function requireContains(file, needle, label = needle) {
  const text = read(file);
  if (!text.includes(needle)) required.push(`${file} missing ${label}`);
}

requireContains('lib/features/mathlive/mathlive_runtime_command_binding_policy.dart', "phase = 'V172-Q157'", 'Q157 policy phase');
requireContains('lib/features/mathlive/mathlive_runtime_command_binding_policy.dart', 'usesReturningResultAck = true', 'returning-result ack policy');
requireContains('lib/features/mathlive/mathlive_runtime_command_binding_policy.dart', 'visibleFallbackEnabled = true', 'visible fallback policy');
requireContains('lib/features/mathlive/mathlive_runtime_command_binding_policy.dart', 'runtimeMountRetryCount = 12', '12 runtime retries');
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', 'runtimeCommandBindingPhase = \'V172-Q157\'', 'surface Q157 phase');
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', 'runJavaScriptReturningResult', 'JS returning-result command path');
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', 'q157-returning-result-command-ack', 'command ack marker');
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', 'q157-visible-fallback-after-empty-ack', 'visible fallback marker');
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', '_consumeBridgeStateMessage', 'synchronous returned state consumption');
requireContains('assets/mathlive/mathlive_bridge.js', "runtimeCommandBindingPhase: 'V172-Q157'", 'JS Q157 state phase');
const bridge = read('assets/mathlive/mathlive_bridge.js');
if (!(bridge.includes('q157-js-visible-fallback-no-mathfield') || bridge.includes('q161-simple-text-fallback-no-mathfield'))) {
  required.push('assets/mathlive/mathlive_bridge.js missing JS no-mathfield visible fallback / Q161 simple text fallback');
}
if (!(bridge.includes("node.textContent = state.latex || '□';") || bridge.includes('visibleFallbackTextFromLatex(state.latex)'))) {
  required.push('assets/mathlive/mathlive_bridge.js missing fallback host visibility path');
}
requireContains('assets/mathlive/manifest.json', 'v172Q157RuntimeCommandBinding', 'manifest Q157 envelope');

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q157 = manifest.v172Q157RuntimeCommandBinding || {};
if (q157.phase !== 'V172-Q157') required.push('manifest Q157 phase mismatch');
if (q157.usesReturningResultAck !== true) required.push('manifest Q157 returning ack not true');
if (q157.visibleFallbackEnabled !== true) required.push('manifest Q157 fallback not true');
if (q157.runtimeMountRetryCount !== 12) required.push('manifest Q157 retry count not 12');
if (q157.keyboardLayoutMutationAllowed !== false) required.push('manifest Q157 keyboard mutation not blocked');
if (q157.photomathLevelClaimed !== false) required.push('manifest Q157 fake Photomath claim not blocked');

const status = required.length === 0
  ? 'MATHLIVE_RUNTIME_COMMAND_BINDING_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_RUNTIME_COMMAND_BINDING';
console.log(JSON.stringify({
  phase: 'V172-Q157',
  status,
  blockers: required,
  packageSideRepairReady: required.length === 0,
  runtimeCommandBinding: {
    returnedJavascriptAckRequired: true,
    visibleFallbackHostEnabled: true,
    runtimeMountRetries: 12,
    keyboardLayoutMutationAllowed: false,
    longPressOrderMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
}, null, 2));
process.exit(required.length === 0 ? 0 : 1);
