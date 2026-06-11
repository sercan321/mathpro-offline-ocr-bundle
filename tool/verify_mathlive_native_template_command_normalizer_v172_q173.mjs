#!/usr/bin/env node
import fs from 'fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_native_template_command_normalizer_v172_q173.mjs', retiredPhase: 'verify_mathlive_native_template_command_normalizer_v172_q173', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const checks = [];
function check(name, ok) { checks.push({ name, ok: Boolean(ok) }); }
function read(path) { return fs.readFileSync(path, 'utf8'); }
const html = read('assets/mathlive/main_editor.html');
const bridge = read('assets/mathlive/mathlive_bridge.js');
const policy = read('lib/features/mathlive/mathlive_native_template_command_normalizer_policy.dart');
const q171Policy = read('lib/features/mathlive/mathlive_template_optical_correction_policy.dart');
const popup = read('lib/features/keyboard/premium_popup_fit_policy.dart');
const test = read('test/v172_q173_mathlive_native_template_command_normalizer_test.dart');
const manifest = read('assets/mathlive/manifest.json');
check('q173 policy exists and is non-claiming', policy.includes("phase = 'V172-Q173'") && policy.includes('realDevicePremiumPassClaimed = false'));
check('q173 policy forbids protected mutations', policy.includes('keyboardLayoutMutationAllowed = false') && policy.includes('longPressOrderMutationAllowed = false') && policy.includes('graphHistorySolutionUiMutationAllowed = false'));
check('q173 html marker exists', html.includes('data-mathpro-native-template-normalizer="V172-Q173"') && html.includes('MathProNativeTemplateCommandNormalizer'));
check('q173 bridge markers exist', bridge.includes("q173NativeTemplateCommandNormalizerPhase: 'V172-Q173'") && bridge.includes('function q173NormalizeNativeTemplateLatex') && bridge.includes('function q173MoveCaretOutOfEmptyTemplateForSibling'));
check('q173 inline bridge mirrored', html.includes('function q173NormalizeNativeTemplateLatex') && html.includes('q173MoveCaretOutOfEmptyTemplateForSibling'));
check('q173 prevents structural empty-template nesting on rapid template tests', bridge.includes('moveToMathfieldEnd') && bridge.includes('moved-to-mathfield-end-before-structural-sibling'));
check('q173 normalizes common wrappers for native MathLive render', bridge.includes("'\\\\sin(#0)'") && bridge.includes("'\\\\frac{d}{dx}#0'") && bridge.includes("'\\\\log(#0)'"));
check('q171 families expanded for radical and function', q171Policy.includes("'radical'") && q171Policy.includes("'function'"));
check('q172 popup legacy contract superseded by q231 compact popup', popup.includes("legacyPopupContractRepairPhase = 'V172-Q172'") && popup.includes('longPressChipHeight = 48.0') && popup.includes('longPressPanelMinHeight = 60.0'));
check('q173 test locks native normalizer contract', test.includes('MathLiveNativeTemplateCommandNormalizerPolicy') && test.includes('repeatedEmptyTemplateNestingAllowed'));
check('q173 manifest envelope present', manifest.includes('v172Q173NativeTemplateCommandNormalizer'));
const failed = checks.filter((x) => !x.ok);
if (failed.length) {
  console.error('MATHLIVE_NATIVE_TEMPLATE_COMMAND_NORMALIZER_Q173_FAILED');
  for (const f of failed) console.error(`- ${f.name}`);
  process.exit(1);
}
console.log('MATHLIVE_NATIVE_TEMPLATE_COMMAND_NORMALIZER_Q173_PACKAGE_READY_BUT_REAL_DEVICE_PREMIUM_EVIDENCE_REQUIRED');
