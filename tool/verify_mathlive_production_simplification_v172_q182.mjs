#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_simplification_v172_q182.mjs', preservedPhase: 'verify_mathlive_production_simplification_v172_q182' });

const html = fs.readFileSync('assets/mathlive/main_editor.html', 'utf8');
const bridge = fs.readFileSync('assets/mathlive/mathlive_bridge.js', 'utf8');
const surface = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_production_simplification_policy.dart', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');
const failures = [];
function requireContains(name, text, needle) {
  if (!text.includes(needle)) failures.push(`${name} missing ${needle}`);
}
function requireNotContains(name, text, needle) {
  if (text.includes(needle)) failures.push(`${name} must not contain ${needle}`);
}

requireContains('html', html, 'data-mathpro-production-simplification="V172-Q182"');
requireContains('html', html, 'V172-Q182: production MathLive simplification');
requireContains('html', html, 'window.MathProProductionMathLiveSimplification');
requireContains('html', html, 'q182ProductionMathLiveSimplificationActive');
requireContains('bridge', bridge, 'q182ProductionMathLiveSimplificationActive');
requireContains('bridge', bridge, 'MathProEnableDiagnosticCourt');
requireContains('surface', surface, 'MathLiveProductionSimplificationPolicy');
if (!surface.includes('bool get _q182ProductionSimplified') && !surface.includes('bool get _productionRouteEnabled')) failures.push('surface missing Q182 production enablement getter or Q198 successor getter');
if (!surface.includes('if (!_q182ProductionSimplified)') && !surface.includes('if (!_productionRouteEnabled)')) failures.push('surface missing Q182 production guard or Q198 successor guard');
requireContains('policy', policy, "phase = 'V172-Q182'");
requireContains('manifest', manifest, 'v172Q182ProductionMathLiveSimplification');
requireContains('manifest', manifest, 'singleSourceCourtPushDebugOnly');

const htmlInitialCourt = html.includes("if (!q182ProductionMathLiveSimplificationActive) {\n    getRealDeviceDiagnosticReport('q163-initial-diagnostic q169-initial-native-paint-diagnostic');");
if (!htmlInitialCourt) failures.push('main_editor.html initial diagnostic court is not gated by Q182');
const bridgeInitialCourt = bridge.includes("if (!q182ProductionMathLiveSimplificationActive) {\n    getRealDeviceDiagnosticReport('q163-initial-diagnostic q169-initial-native-paint-diagnostic');");
if (!bridgeInitialCourt) failures.push('mathlive_bridge.js initial diagnostic court is not gated by Q182');

const forbiddenPrivateGlyphStyling = [
  '.ML__placeholder', '.ML__frac-line', '.ML__sqrt-line', '.ML__base', '.ML__cmr', '.ML__mathit', '.ML__mathrm'
];
for (const needle of forbiddenPrivateGlyphStyling) {
  const cssIndex = html.indexOf('<style>');
  const cssEnd = html.indexOf('</style>');
  const css = cssIndex >= 0 && cssEnd >= 0 ? html.slice(cssIndex, cssEnd) : html;
  if (css.includes(needle)) failures.push(`active CSS contains private glyph selector ${needle}`);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_SIMPLIFICATION_Q182_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_SIMPLIFICATION_Q182_READY_BUT_ANDROID_DEVICE_PREMIUM_EVIDENCE_REQUIRED');
