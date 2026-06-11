#!/usr/bin/env node
import fs from 'fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_premium_layout_visual_polish_v172_q170.mjs', retiredPhase: 'verify_mathlive_premium_layout_visual_polish_v172_q170', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const checks = [];
function check(name, ok) { checks.push({ name, ok: Boolean(ok) }); }
function read(path) { return fs.readFileSync(path, 'utf8'); }

const html = read('assets/mathlive/main_editor.html');
const bridge = read('assets/mathlive/mathlive_bridge.js');
const diag = read('lib/features/mathlive/mathlive_real_device_diagnostic_bridge_policy.dart');
const single = read('lib/features/mathlive/mathlive_single_source_bridge_policy.dart');
const court = read('lib/features/mathlive/mathlive_channel_push_self_test_hard_binding_policy.dart');
const popup = read('lib/features/keyboard/premium_popup_fit_policy.dart');
const policy = read('lib/features/mathlive/mathlive_premium_layout_visual_polish_policy.dart');
const manifest = read('assets/mathlive/manifest.json');

check('q170 policy exists', policy.includes("phase = 'V172-Q170'") && policy.includes('userFacingDiagnosticOverlayAllowed = false'));
check('visible diagnostic overlay disabled', diag.includes('visibleDiagnosticOverlayEnabled = false'));
check('diagnostic bridge still internal enabled', diag.includes('diagnosticBridgeEnabled = true'));
check('single source parser requires envelope marker or full fields', single.includes('shouldConsumeSingleSourceEnvelope(String message) {') && !single.includes('message.contains(\'"$marker":"$phase"\') ||'));
check('final court parser no longer consumes generic rootCause only', court.includes('hasCompleteCourtFields(message)') && !court.includes("message.contains('\\\"rootCause\\\"')"));
check('html q170 premium marker', html.includes('data-mathpro-premium-visual="V172-Q170"'));
check('html q170 premium CSS active', html.includes('--mathpro-q170-premium-visual-polish: active'));
check('html q170 production overlay false marker', html.includes('userFacingDiagnosticOverlay: false'));
check('bridge q170 marker', bridge.includes("premiumLayoutVisualPolishPhase: 'V172-Q170'"));
check('popup q170 marker', popup.includes("premiumVisualPolishPhase = 'V172-Q170'"));
check('popup q170 polish coexists with q172 no-clip height', popup.includes("premiumVisualPolishPhase = 'V172-Q170'") && popup.includes("legacyPopupContractRepairPhase = 'V172-Q172'") && popup.includes('longPressChipHeight = 48.0') && popup.includes('longPressPanelMinHeight = 60.0'));
check('manifest q170 envelope', manifest.includes('v172Q170PremiumLayoutVisualPolish'));

const failed = checks.filter((x) => !x.ok);
if (failed.length) {
  console.error('MATHLIVE_PREMIUM_LAYOUT_VISUAL_POLISH_Q170_FAILED');
  for (const f of failed) console.error(`- ${f.name}`);
  process.exit(1);
}
console.log('MATHLIVE_PREMIUM_LAYOUT_VISUAL_POLISH_Q170_PACKAGE_READY_BUT_DEVICE_PREMIUM_EVIDENCE_REQUIRED');
