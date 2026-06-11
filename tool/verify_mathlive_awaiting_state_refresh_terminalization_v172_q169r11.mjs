#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_awaiting_state_refresh_terminalization_v172_q169r11.mjs', retiredPhase: 'verify_mathlive_awaiting_state_refresh_terminalization_v172_q169r11', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const fail = (msg) => {
  console.error(`MATHLIVE_AWAITING_STATE_REFRESH_TERMINALIZATION_Q169R11_FAILED: ${msg}`);
  process.exit(1);
};
const read = (p) => fs.readFileSync(p, 'utf8');
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const stale = read('lib/features/mathlive/mathlive_stale_tap_diagnostic_overwrite_policy.dart');
const policy = read('lib/features/mathlive/mathlive_awaiting_state_refresh_terminalization_policy.dart');
const manifest = read('assets/mathlive/manifest.json');

for (const token of [
  'shouldTerminalizeAwaitingRefresh',
  'isAwaitingStateRefreshReason',
  'bridge-dispatched-awaiting-state-refresh',
  'bridge-fire-awaiting-state-refresh',
  'state-refresh-timeout-after-js-fire',
  'refresh-not-delivered-after-fire',
]) {
  if (!stale.includes(token) && !surface.includes(token) && !policy.includes(token)) {
    fail(`missing token ${token}`);
  }
}
if (!surface.includes('shouldPromoteBridgeFireAwaitingRefresh')) fail('surface must promote bridge fire awaiting refresh');
if (!surface.includes('shouldTerminalizeAwaitingRefresh')) fail('surface must terminalize awaiting refresh');
if (!manifest.includes('v172Q169R11AwaitingStateRefreshTerminalization')) fail('manifest missing Q169R11 envelope');
if (surface.includes('lib/features/keyboard/key_config.dart')) fail('surface must not import protected keyboard files');

console.log('MATHLIVE_AWAITING_STATE_REFRESH_TERMINALIZATION_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
