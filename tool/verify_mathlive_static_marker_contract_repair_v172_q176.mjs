import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_static_marker_contract_repair_v172_q176.mjs', retiredPhase: 'verify_mathlive_static_marker_contract_repair_v172_q176', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const html = fs.readFileSync('assets/mathlive/main_editor.html', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_static_marker_contract_repair_policy.dart', 'utf8');

const checks = [];
function check(name, ok) { checks.push([name, !!ok]); }

check('q176 policy exists and is non-claiming', policy.includes("phase = 'V172-Q176'") && policy.includes('realDevicePremiumPassClaimed = false'));
check('q149 marker restored', html.includes('V172-Q149: final visible chrome sweep'));
check('q170 marker restored', html.includes('MathProPremiumLayoutVisualPolish') && html.includes('userFacingDiagnosticOverlay: false'));
check('q175 default renderer purity remains', html.includes('data-mathpro-default-renderer-purity="V172-Q175"') && html.includes('MathProDefaultRendererPurity'));
check('private glyph styling not restored', !html.includes('.ML__placeholder') && !html.includes('.ML__frac-line') && !html.includes('.ML__sqrt-line') && !html.includes('.ML__base'));
check('manifest envelope present', manifest.includes('v172Q176StaticMarkerContractRepair') && manifest.includes('privateMathLiveGlyphStylingRestored'));

const failed = checks.filter(([, ok]) => !ok);
if (failed.length) {
  console.error('MATHLIVE_STATIC_MARKER_CONTRACT_REPAIR_Q176_FAILED');
  for (const [name] of failed) console.error(' - ' + name);
  process.exit(1);
}
console.log('MATHLIVE_STATIC_MARKER_CONTRACT_REPAIR_Q176_PACKAGE_READY_BUT_FLUTTER_AND_DEVICE_EVIDENCE_REQUIRED');
