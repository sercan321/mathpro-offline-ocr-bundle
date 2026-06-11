#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_final_refresh_failure_path_hard_binding_v172_q169r13.mjs', retiredPhase: 'verify_mathlive_final_refresh_failure_path_hard_binding_v172_q169r13', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
function must(condition, message) { checks.push({ ok: !!condition, message }); }
function text(path) { return existsSync(path) ? readFileSync(path, 'utf8') : ''; }

const surface = text('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = text('lib/features/mathlive/mathlive_final_refresh_failure_path_hard_binding_policy.dart');
const awaitingPolicy = text('lib/features/mathlive/mathlive_awaiting_state_refresh_terminalization_policy.dart');
const manifestText = text('assets/mathlive/manifest.json');
const appShell = text('lib/app/app_shell.dart');
const keyboard = text('lib/features/keyboard/math_keyboard.dart');
const bottomDock = text('lib/features/keyboard/bottom_dock.dart');
const longPress = text('lib/features/keyboard/long_press_popup.dart');
const graph = text('lib/features/graph/graph_card.dart');
const history = text('lib/features/history/history_panel.dart');
const solution = text('lib/features/solution/solution_steps_panel.dart');

must(surface.includes("import 'mathlive_final_refresh_failure_path_hard_binding_policy.dart';"), 'runtime surface must import Q169R13 final refresh path policy');
must(surface.includes('MathLiveFinalRefreshFailurePathHardBindingPolicy') && surface.includes('terminalFailureForPostFireRefresh'), 'runtime refresh failure branch must use Q169R13 terminal failure adapter');
must(!surface.includes('_q169LastValueApiPath = MathLiveBridgeStateRefreshRepairPolicy.finalRefreshFailurePath;'), 'runtime must not assign legacy Q169R9 finalRefreshFailurePath in refresh failure branch');
must(surface.includes("finalRefreshFailurePathHardBindingPhase = 'V172-Q169R13'"), 'surface must carry Q169R13 marker');
must(surface.includes('PATH:refresh-not-delivered-after-fire'), 'surface must expose required after-fire path in diagnostics/markers');

must(policy.includes("phase = 'V172-Q169R13'"), 'policy must record Q169R13 phase');
must(policy.includes('prohibitedLegacyPath'), 'policy must name the prohibited legacy path');
must(policy.includes("prohibitedLegacyPath = 'refresh-not-delivered'"), 'policy must record prohibited legacy path exactly');
must(policy.includes('requiredTerminalFailure'), 'policy must expose required terminal failure');
must(policy.includes('requiredTerminalPath'), 'policy must expose required terminal path');
must(policy.includes('terminalFailureForPostFireRefresh'), 'policy must expose terminal adapter');
must(policy.includes('state-refresh-timeout-after-js-fire'), 'policy must terminalize to state-refresh-timeout-after-js-fire');
must(policy.includes('refresh-not-delivered-after-fire'), 'policy must terminalize to refresh-not-delivered-after-fire');
must(policy.includes('nativePaintPassClaimed = false'), 'policy must not claim native paint pass');

must(awaitingPolicy.includes("requiredTerminalPath = 'refresh-not-delivered-after-fire'"), 'Q169R12 awaiting policy terminal path must remain after-fire');

const manifest = JSON.parse(manifestText);
const envelope = manifest.v172Q169R13FinalRefreshFailurePathHardBinding;
must(envelope?.phase === 'V172-Q169R13', 'manifest must record Q169R13 envelope');
must(envelope?.runtimeUsesFinalRefreshFailurePathHardBindingPolicy === true, 'manifest must record runtime policy binding');
must(envelope?.prohibitedLegacyPath === 'refresh-not-delivered', 'manifest must record prohibited legacy path');
must(envelope?.requiredTerminalFailure === 'state-refresh-timeout-after-js-fire', 'manifest terminal failure must be exact');
must(envelope?.requiredTerminalPath === 'refresh-not-delivered-after-fire', 'manifest terminal path must be exact');
must(envelope?.nativePaintPassClaimed === false, 'manifest must not claim native paint pass');
must(envelope?.protectedSurfacesUnchanged === true, 'manifest must record protected surfaces unchanged');

must(!appShell.includes('V172-Q169R13'), 'AppShell must not be modified for Q169R13');
must(!keyboard.includes('V172-Q169R13'), 'keyboard source must not be modified for Q169R13');
must(!bottomDock.includes('V172-Q169R13'), 'BottomDock source must not be modified for Q169R13');
must(!longPress.includes('V172-Q169R13'), 'long-press source must not be modified for Q169R13');
must(!graph.includes('V172-Q169R13'), 'Graph UI must not be modified for Q169R13');
must(!history.includes('V172-Q169R13'), 'History UI must not be modified for Q169R13');
must(!solution.includes('V172-Q169R13'), 'Solution UI must not be modified for Q169R13');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('MATHLIVE_FINAL_REFRESH_FAILURE_PATH_HARD_BINDING_Q169R13_FAILED');
  for (const item of failed) console.error(' - ' + item.message);
  process.exit(1);
}
console.log('MATHLIVE_FINAL_REFRESH_FAILURE_PATH_HARD_BINDING_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
