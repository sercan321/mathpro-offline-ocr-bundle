#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_bridge_state_refresh_repair_v172_q169r9.mjs', retiredPhase: 'verify_mathlive_bridge_state_refresh_repair_v172_q169r9', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
function must(condition, message) {
  checks.push({ ok: !!condition, message });
}
function text(path) {
  if (!existsSync(path)) return '';
  return readFileSync(path, 'utf8');
}

const bridge = text('assets/mathlive/mathlive_bridge.js');
const surface = text('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = text('lib/features/mathlive/mathlive_bridge_state_refresh_repair_policy.dart');
const manifestText = text('assets/mathlive/manifest.json');
const appShell = text('lib/app/app_shell.dart');

must(bridge.includes("bridgeStateRefreshRepairPhase: 'V172-Q169R9'"), 'bridge records Q169R9 phase');
must(bridge.includes('function deliverQ169BridgeStateReport'), 'bridge exports deliverQ169BridgeStateReport');
must(bridge.includes('lastStateReportDelivered'), 'bridge records delivered state report marker');
must(bridge.includes('lastBridgeStateRefreshReason'), 'bridge records refresh reason');
must(bridge.includes('q169r9-state-report-delivered'), 'bridge has state report delivered marker');
must(bridge.includes('q169r9-state-refresh-native-paint-probe'), 'bridge probes native paint during refresh');
must(bridge.includes('deliverQ169BridgeStateReport: deliverQ169BridgeStateReport'), 'bridge exposes state refresh function');

must(surface.includes("bridgeStateRefreshRepairPhase = 'V172-Q169R9'"), 'surface records Q169R9 phase');
must(surface.includes('MathLiveBridgeStateRefreshRepairPolicy.forcePostBridgeRefresh'), 'surface forces post-bridge refresh');
must(surface.includes('_forceQ169R9PostBridgeStateRefresh'), 'surface has post bridge refresh method');
must(surface.includes('_q169R9DiagnosticReportJson'), 'surface reads richer diagnostic report');
must(surface.includes('state-refresh-timeout-after-js-fire'), 'surface can overwrite stale tap failure with state refresh timeout');
must(surface.includes('refresh-not-delivered'), 'surface can report refresh-not-delivered path');
must(surface.includes("_q169LastFailureReason == 'tap-before-bridge'"), 'surface prevents tap-before-bridge from being final after bridge send');
must(surface.includes('bridge-sent-awaiting-state-refresh'), 'surface marks bridge-sent awaiting state refresh');
must(surface.includes('deliverQ169BridgeStateReport($payload)'), 'surface calls deliverQ169BridgeStateReport');

must(policy.includes("phase = 'V172-Q169R9'"), 'policy exists for Q169R9');
must(policy.includes('staleTapBeforeBridgeMayBeFinal = false'), 'policy forbids stale tap-before-bridge final state');
must(policy.includes('realDevicePassClaimed = false'), 'policy does not claim real-device pass');
must(policy.includes('keyboardLayoutMutationAllowed = false'), 'policy blocks keyboard layout mutation');
must(policy.includes('appShellMutationAllowed = false'), 'policy blocks AppShell mutation');

const manifest = JSON.parse(manifestText);
must(manifest.v172Q169R9BridgeStateRefreshRepair?.phase === 'V172-Q169R9', 'manifest records Q169R9 envelope');
must(manifest.v172Q169R9BridgeStateRefreshRepair?.realDevicePassClaimed === false, 'manifest does not claim real-device pass');
must(manifest.v172Q169R9BridgeStateRefreshRepair?.staleTapBeforeBridgeMayBeFinal === false, 'manifest blocks stale tap-before-bridge final state');

must(!appShell.includes('V172-Q169R9'), 'AppShell was not modified for Q169R9');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('MATHLIVE_BRIDGE_STATE_REFRESH_REPAIR_Q169R9_FAILED');
  for (const item of failed) console.error(' - ' + item.message);
  process.exit(1);
}

console.log('MATHLIVE_BRIDGE_STATE_REFRESH_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
