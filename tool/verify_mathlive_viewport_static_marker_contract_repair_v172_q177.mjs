import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_viewport_static_marker_contract_repair_v172_q177.mjs', retiredPhase: 'verify_mathlive_viewport_static_marker_contract_repair_v172_q177', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const required = [
  ['assets/mathlive/main_editor.html', 'V172-Q148: premium viewport fit'],
  ['assets/mathlive/main_editor.html', 'MathProDefaultRendererPurity'],
  ['assets/mathlive/main_editor.html', 'internalGlyphClassStylingForbidden: true'],
  ['assets/mathlive/manifest.json', 'V172-Q177-VIEWPORT-STATIC-MARKER-CONTRACT-REPAIR'],
  ['lib/features/mathlive/mathlive_viewport_static_marker_contract_repair_policy.dart', "static const String phase = 'V172-Q177'"],
  ['test/v172_q177_viewport_static_marker_contract_repair_test.dart', 'V172-Q177 restores Q148 viewport marker'],
];

const forbiddenInHtml = [
  '.ML__placeholder',
  '.ML__frac-line',
  '.ML__sqrt-line',
  '.ML__base',
  '.ML__cmr',
  '.ML__mathit',
  '.ML__mathrm',
];

let failures = [];
for (const [file, marker] of required) {
  const text = fs.existsSync(file) ? fs.readFileSync(file, 'utf8') : '';
  if (!text.includes(marker)) failures.push(`missing marker: ${marker} in ${file}`);
}
const html = fs.readFileSync('assets/mathlive/main_editor.html', 'utf8');
for (const marker of forbiddenInHtml) {
  const cssOccurrences = [...html.matchAll(new RegExp(marker.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g'))].length;
  if (cssOccurrences > 0) failures.push(`private MathLive glyph class styling reintroduced: ${marker}`);
}

if (failures.length) {
  console.error(JSON.stringify({ status: 'FAILED_Q177_VIEWPORT_STATIC_MARKER_CONTRACT_REPAIR', failures }, null, 2));
  process.exit(1);
}

console.log(JSON.stringify({
  status: 'MATHLIVE_VIEWPORT_STATIC_MARKER_CONTRACT_REPAIR_PACKAGE_READY_BUT_FLUTTER_AND_DEVICE_EVIDENCE_REQUIRED',
  phase: 'V172-Q177',
  q148ViewportMarkerRestored: true,
  defaultRendererPurityPreserved: true,
  flutterPassClaimedByAssistant: false,
  realDevicePremiumPassClaimed: false
}, null, 2));
