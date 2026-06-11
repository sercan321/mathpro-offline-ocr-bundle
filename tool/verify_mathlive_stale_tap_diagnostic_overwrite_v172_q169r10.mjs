#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_stale_tap_diagnostic_overwrite_v172_q169r10.mjs', retiredPhase: 'verify_mathlive_stale_tap_diagnostic_overwrite_v172_q169r10', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
function must(condition, message) { checks.push({ ok: !!condition, message }); }
function text(path) { return existsSync(path) ? readFileSync(path, 'utf8') : ''; }

const bridge = text('assets/mathlive/mathlive_bridge.js');
const surface = text('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = text('lib/features/mathlive/mathlive_stale_tap_diagnostic_overwrite_policy.dart');
const manifestText = text('assets/mathlive/manifest.json');
const appShell = text('lib/app/app_shell.dart');

must(bridge.includes("staleTapDiagnosticOverwritePhase: 'V172-Q169R10'"), 'bridge records Q169R10 phase');
must(bridge.includes('tap-before-bridge may not remain final after SEND:Bridge JS:fire'), 'bridge has Q169R10 compatibility marker');

must(surface.includes("import 'mathlive_stale_tap_diagnostic_overwrite_policy.dart';"), 'surface imports Q169R10 policy');
must(surface.includes('_q169VisibleFailureForDiagnostic'), 'surface normalizes visible Q169 failure reason');
must(surface.includes('_ensureNoStaleTapBeforeBridgeFinal'), 'surface has final stale-tap overwrite guard');
must(surface.includes('MathLiveStaleTapDiagnosticOverwritePolicy.shouldOverwriteStaleTapBeforeBridge'), 'surface calls stale tap overwrite predicate');
must(surface.includes('q169r10-after-post-bridge-refresh-final-guard'), 'surface final guard marker is present');
must(surface.includes('q169r10-final-diagnostic-controller-or-page-not-ready'), 'surface handles missing controller/page final diagnostic');
must(surface.includes('state-refresh-timeout-after-js-fire'), 'surface can display state-refresh-timeout-after-js-fire');
must(surface.includes('refresh-not-delivered-after-fire'), 'surface can display refresh-not-delivered-after-fire path');

must(policy.includes("phase = 'V172-Q169R10'"), 'policy exists for Q169R10');
must(policy.includes('staleTapBeforeBridgeMayBeFinalAfterBridge = false'), 'policy forbids stale tap final after bridge');
must(policy.includes('realDevicePassClaimed = false'), 'policy does not claim real-device pass');
must(policy.includes('keyboardLayoutMutationAllowed = false'), 'policy blocks keyboard mutation');
must(policy.includes('appShellMutationAllowed = false'), 'policy blocks AppShell mutation');
must(policy.includes('graphHistorySolutionMutationAllowed = false'), 'policy blocks Graph/History/Solution mutation');

const manifest = JSON.parse(manifestText);
must(manifest.v172Q169R10StaleTapDiagnosticOverwriteRepair?.phase === 'V172-Q169R10', 'manifest records Q169R10 envelope');
must(manifest.v172Q169R10StaleTapDiagnosticOverwriteRepair?.staleTapBeforeBridgeMayBeFinalAfterBridge === false, 'manifest blocks stale tap final after bridge');
must(manifest.v172Q169R10StaleTapDiagnosticOverwriteRepair?.realDevicePassClaimed === false, 'manifest does not claim device pass');

must(!appShell.includes('V172-Q169R10'), 'AppShell was not modified for Q169R10');

const failed = checks.filter((check) => !check.ok);
if (failed.length > 0) {
  console.error('MATHLIVE_STALE_TAP_DIAGNOSTIC_OVERWRITE_Q169R10_FAILED');
  for (const item of failed) console.error(' - ' + item.message);
  process.exit(1);
}
console.log('MATHLIVE_STALE_TAP_DIAGNOSTIC_OVERWRITE_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
