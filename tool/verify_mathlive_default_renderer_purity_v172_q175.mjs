#!/usr/bin/env node
import fs from 'fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_default_renderer_purity_v172_q175.mjs', retiredPhase: 'verify_mathlive_default_renderer_purity_v172_q175', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const checks = [];
function check(name, ok) { checks.push({ name, ok: Boolean(ok) }); }
function read(path) { return fs.readFileSync(path, 'utf8'); }
const html = read('assets/mathlive/main_editor.html');
const bridge = read('assets/mathlive/mathlive_bridge.js');
const policy = read('lib/features/mathlive/mathlive_default_renderer_purity_policy.dart');
const test = read('test/v172_q175_mathlive_default_renderer_purity_test.dart');
const manifest = read('assets/mathlive/manifest.json');
const styleBlock = html.slice(html.indexOf('<style>'), html.indexOf('</style>'));
check('q175 policy exists and is non-claiming', policy.includes("phase = 'V172-Q175'") && policy.includes('targetDefaultRendererSimilarity = 0.95') && policy.includes('realDevicePremiumPassClaimed = false'));
check('q175 protected mutations are forbidden', policy.includes('keyboardLayoutMutationAllowed = false') && policy.includes('longPressOrderMutationAllowed = false') && policy.includes('appShellMutationAllowed = false') && policy.includes('graphHistorySolutionUiMutationAllowed = false'));
check('q175 html marker exists', html.includes('data-mathpro-default-renderer-purity="V172-Q175"') && html.includes('--mathpro-q175-default-renderer-purity: active'));
check('q175 bridge state exists', bridge.includes("q175DefaultRendererPurityPhase: 'V172-Q175'") && bridge.includes('q175DefaultRendererTarget: 0.95') && bridge.includes('MathProDefaultRendererPurity'));
check('q175 inline bridge mirrored', html.includes("q175DefaultRendererPurityPhase: 'V172-Q175'") && html.includes('MathProDefaultRendererPurity'));
check('renderer-private glyph class styling removed from active style block', !/\.ML__placeholder\s*\{|\.ML__frac-line\s*,|\.ML__sqrt-line\s*\{|\.ML__base\s*,|\.ML__cmr\s*,|\.ML__mathit\s*,|\.ML__mathrm\s*\{/.test(styleBlock));
check('only chrome-level ML suppression remains', styleBlock.includes('.ML__keyboard-toggle') && styleBlock.includes('.ML__toggles') && !styleBlock.includes('.ML__frac-line,'));
check('public CSS variables remain for dark app accent', styleBlock.includes('--caret-color') && styleBlock.includes('--selection-background-color') && styleBlock.includes('--placeholder-color'));
check('q175 test locks contract', test.includes('MathLiveDefaultRendererPurityPolicy') && test.includes('privateMathLiveGlyphClassStylingAllowed'));
check('q175 manifest envelope present', manifest.includes('v172Q175DefaultRendererPurity'));
const failed = checks.filter((x) => !x.ok);
if (failed.length) {
  console.error('MATHLIVE_DEFAULT_RENDERER_PURITY_Q175_FAILED');
  for (const f of failed) console.error(`- ${f.name}`);
  process.exit(1);
}
console.log('MATHLIVE_DEFAULT_RENDERER_PURITY_Q175_PACKAGE_READY_BUT_REAL_DEVICE_PREMIUM_EVIDENCE_REQUIRED');
