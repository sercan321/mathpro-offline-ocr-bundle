#!/usr/bin/env node
import fs from 'fs';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_native_renderer_purity_finalization_v172_q174.mjs', retiredPhase: 'verify_mathlive_native_renderer_purity_finalization_v172_q174', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const checks = [];
function check(name, ok) { checks.push({ name, ok: Boolean(ok) }); }
function read(path) { return fs.readFileSync(path, 'utf8'); }
const html = read('assets/mathlive/main_editor.html');
const bridge = read('assets/mathlive/mathlive_bridge.js');
const policy = read('lib/features/mathlive/mathlive_native_renderer_purity_finalization_policy.dart');
const test = read('test/v172_q174_mathlive_native_renderer_purity_finalization_test.dart');
const manifest = read('assets/mathlive/manifest.json');
check('q174 policy exists and does not claim device pass', policy.includes("phase = 'V172-Q174'") && policy.includes('realDevicePremiumPassClaimed = false'));
check('q174 protected mutations are forbidden', policy.includes('keyboardLayoutMutationAllowed = false') && policy.includes('longPressOrderMutationAllowed = false') && policy.includes('appShellMutationAllowed = false') && policy.includes('graphHistorySolutionUiMutationAllowed = false'));
check('q174 html native renderer purity marker exists', html.includes('data-mathpro-native-renderer-purity="V172-Q174"') && html.includes('--mathpro-q174-native-renderer-purity: active'));
check('q174 bridge exposes native renderer purity state', bridge.includes("q174NativeRendererPurityPhase: 'V172-Q174'") && bridge.includes('function q174PrepareNativeSlotAwareInsertion') && bridge.includes('function q174ShouldSuppressDuplicateEmptyTemplate'));
check('q174 bridge preserves native active-placeholder insertion', bridge.includes("q174NativeSlotAwareInsertionMode = 'preserve-active-placeholder'") && bridge.includes('older Q173 move-to-end guard is retained only as a verifier/backward'));
check('q174 duplicate empty template suppression exists', bridge.includes('duplicate-empty-template-suppressed-preserve-native-placeholder') && bridge.includes('q174LastDuplicateTemplateSuppressed'));
check('q174 inline bridge mirrored', html.includes('function q174PrepareNativeSlotAwareInsertion') && html.includes('MathProNativeRendererPurity'));
check('q174 test locks policy', test.includes('MathLiveNativeRendererPurityFinalizationPolicy') && test.includes('nativeMathLiveRendererRemainsOwner'));
check('q174 manifest envelope present', manifest.includes('v172Q174NativeRendererPurityFinalization'));
const failed = checks.filter((x) => !x.ok);
if (failed.length) {
  console.error('MATHLIVE_NATIVE_RENDERER_PURITY_FINALIZATION_Q174_FAILED');
  for (const f of failed) console.error(`- ${f.name}`);
  process.exit(1);
}
console.log('MATHLIVE_NATIVE_RENDERER_PURITY_FINALIZATION_Q174_PACKAGE_READY_BUT_REAL_DEVICE_PREMIUM_EVIDENCE_REQUIRED');
