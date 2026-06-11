#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_awaiting_state_refresh_terminalization_hard_binding_v172_q169r12.mjs', retiredPhase: 'verify_mathlive_awaiting_state_refresh_terminalization_hard_binding_v172_q169r12', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
function must(condition, message) { checks.push({ ok: !!condition, message }); }
function text(path) { return existsSync(path) ? readFileSync(path, 'utf8') : ''; }

const surface = text('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = text('lib/features/mathlive/mathlive_awaiting_state_refresh_terminalization_policy.dart');
const stalePolicy = text('lib/features/mathlive/mathlive_stale_tap_diagnostic_overwrite_policy.dart');
const manifestText = text('assets/mathlive/manifest.json');
const appShell = text('lib/app/app_shell.dart');
const keyboard = text('lib/features/keyboard/math_keyboard.dart');
const bottomDock = text('lib/features/keyboard/bottom_dock.dart');

must(surface.includes("import 'mathlive_awaiting_state_refresh_terminalization_policy.dart';"), 'runtime surface must import awaiting-state terminalization policy');
must(surface.includes('MathLiveAwaitingStateRefreshTerminalizationPolicy.terminalizeIfRequired'), 'runtime surface must call terminalizeIfRequired');
must(surface.includes('MathLiveAwaitingStateRefreshTerminalizationPolicy.shouldTerminalize'), 'runtime final guard must call shouldTerminalize');
must(surface.includes('MathLiveAwaitingStateRefreshTerminalizationPolicy.requiredTerminalFailure'), 'runtime must use required terminal failure constant');
must(surface.includes('MathLiveAwaitingStateRefreshTerminalizationPolicy.requiredTerminalPath'), 'runtime must use required terminal path constant');
must(surface.includes("awaitingStateRefreshTerminalizationHardBindingPhase = 'V172-Q169R12'"), 'surface must carry Q169R12 hard-binding marker');

must(policy.includes("hardBindingPhase = 'V172-Q169R12'"), 'policy must record Q169R12 hard-binding phase');
must(policy.includes('blockedIntermediateFailure'), 'policy must define blocked bridge-dispatched intermediate failure');
must(policy.includes('blockedFireIntermediateFailure'), 'policy must define blocked bridge-fire intermediate failure');
must(policy.includes('blockedBridgeSentIntermediateFailure'), 'policy must define blocked bridge-sent intermediate failure');
must(policy.includes('blockedBridgeStateStaleFailure'), 'policy must define blocked bridge-state-stale failure');
must(policy.includes('blockedTapBeforeBridgeFailure'), 'policy must define blocked tap-before-bridge failure');
must(policy.includes('requiredTerminalFailure'), 'policy must define required terminal failure');
must(policy.includes('requiredTerminalPath'), 'policy must define required terminal path');
must(policy.includes('isBlockedIntermediateFailure'), 'policy must expose blocked intermediate predicate');
must(policy.includes('shouldTerminalize'), 'policy must expose terminalization predicate');
must(policy.includes('terminalizeIfRequired'), 'policy must expose hard terminalization adapter');
must(policy.includes('state-refresh-timeout-after-js-fire'), 'policy must terminalize to state-refresh-timeout-after-js-fire');
must(policy.includes('refresh-not-delivered-after-fire'), 'policy must terminalize to refresh-not-delivered-after-fire');

must(stalePolicy.includes('bridge-dispatched-awaiting-state-refresh'), 'Q169R10/Q169R11 stale policy context must remain available');
must(stalePolicy.includes('bridge-fire-awaiting-state-refresh'), 'Q169R10/Q169R11 fire-awaiting context must remain available');

const manifest = JSON.parse(manifestText);
must(manifest.v172Q169R12AwaitingStateRefreshTerminalizationHardBinding?.phase === 'V172-Q169R12', 'manifest must record Q169R12 envelope');
must(manifest.v172Q169R12AwaitingStateRefreshTerminalizationHardBinding?.policyImportedByRuntimeSurface === true, 'manifest must record runtime policy import');
must(manifest.v172Q169R12AwaitingStateRefreshTerminalizationHardBinding?.runtimeUsesTerminalizeIfRequired === true, 'manifest must record terminalizeIfRequired binding');
must(manifest.v172Q169R12AwaitingStateRefreshTerminalizationHardBinding?.requiredTerminalFailure === 'state-refresh-timeout-after-js-fire', 'manifest terminal failure must be exact');
must(manifest.v172Q169R12AwaitingStateRefreshTerminalizationHardBinding?.requiredTerminalPath === 'refresh-not-delivered-after-fire', 'manifest terminal path must be exact');
must(manifest.v172Q169R12AwaitingStateRefreshTerminalizationHardBinding?.nativePaintPassClaimed === false, 'manifest must not claim native paint pass');
must(manifest.v172Q169R12AwaitingStateRefreshTerminalizationHardBinding?.protectedSurfacesUnchanged === true, 'manifest must record protected surfaces unchanged');

must(!appShell.includes('V172-Q169R12'), 'AppShell must not be modified for Q169R12');
must(!keyboard.includes('V172-Q169R12'), 'keyboard source must not be modified for Q169R12');
must(!bottomDock.includes('V172-Q169R12'), 'BottomDock source must not be modified for Q169R12');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('MATHLIVE_AWAITING_STATE_REFRESH_TERMINALIZATION_HARD_BINDING_Q169R12_FAILED');
  for (const item of failed) console.error(' - ' + item.message);
  process.exit(1);
}
console.log('MATHLIVE_AWAITING_STATE_REFRESH_TERMINALIZATION_HARD_BINDING_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
