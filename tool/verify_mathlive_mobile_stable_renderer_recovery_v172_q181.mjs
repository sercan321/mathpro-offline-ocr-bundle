import fs from 'node:fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_mobile_stable_renderer_recovery_v172_q181.mjs', retiredPhase: 'verify_mathlive_mobile_stable_renderer_recovery_v172_q181', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const html = fs.readFileSync('assets/mathlive/main_editor.html', 'utf8');
const required = [
  'V172-Q181: mobile stable renderer recovery',
  'q181LightweightMainEditorBoot',
  'MathProMobileStableRendererRecovery',
  'heavyDiagnosticCourtsDefaultDisabled',
  'math-field::part(root)',
  'math-field::part(editable)',
  'math-field::part(container)',
  'math-field::part(content)',
  'font-size: clamp(27px, 7.6vw, 34px)'
];
const forbidden = ['.ML__placeholder {', '.ML__frac-line {', '.ML__sqrt-line {', '.ML__base {', '.ML__cmr {', '.ML__mathit {', '.ML__mathrm {'];
const missing = required.filter((x)=>!html.includes(x));
const bad = forbidden.filter((x)=>html.includes(x));
if (missing.length || bad.length) {
  console.error(JSON.stringify({missing,bad}, null, 2));
  process.exit(1);
}
console.log('MATHLIVE_MOBILE_STABLE_RENDERER_RECOVERY_READY_V172_Q181');
