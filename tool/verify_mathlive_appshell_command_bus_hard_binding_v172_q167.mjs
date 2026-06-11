#!/usr/bin/env node
import fs from 'fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_appshell_command_bus_hard_binding_v172_q167.mjs', retiredPhase: 'verify_mathlive_appshell_command_bus_hard_binding_v172_q167', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

function read(p){ return fs.readFileSync(p,'utf8'); }
function requireContains(name, text, needle){
  if(!text.includes(needle)){
    console.error(`${name} missing ${needle}`);
    process.exit(1);
  }
}
const shell = read('lib/app/app_shell.dart');
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = read('lib/features/mathlive/mathlive_appshell_command_bus_hard_binding_policy.dart');
const manifest = read('assets/mathlive/manifest.json');
requireContains('shell', shell, 'MathLiveAppShellCommandBusHardBindingPolicy');
requireContains('shell', shell, '_safeMathLiveFallbackExpressionFor');
requireContains('shell', shell, 'markKeyboardTap(label, visibleLatex: visibleFallbackLatex)');
requireContains('shell', shell, 'markBridgeSendResult(label, sent: sent)');
requireContains('surface', surface, "appShellCommandBusHardBindingPhase = 'V172-Q167'");
requireContains('surface', surface, '_appShellVisibleExpression');
requireContains('surface', surface, 'Q167 KEY:');
requireContains('surface', surface, 'SEND:Bridge');
requireContains('surface', surface, 'SEND:Queued');
requireContains('surface', surface, '_visibleFallbackExpression');
requireContains('policy', policy, "phase = 'V172-Q167'");
requireContains('manifest', manifest, 'v172Q167AppShellCommandBusHardBinding');
console.log('MATHLIVE_APPSHELL_COMMAND_BUS_HARD_BINDING_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED');
