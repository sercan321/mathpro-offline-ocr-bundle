#!/usr/bin/env node
import fs from 'fs';

const fail = (message) => { console.error(`FAIL verify_q389r5d_offline_legacy_flutter_test_guard_repair: ${message}`); process.exit(1); };
const check = (condition, message) => { if (!condition) fail(message); };
const read = (path) => fs.readFileSync(path, 'utf8');
const exists = (path) => fs.existsSync(path);
const json = (path) => JSON.parse(read(path));

const q326 = read('test/v172_q326_native_library_build_trial_approval_abi_packaging_preflight_test.dart');
check(q326.includes("isNot(contains('PaddleOCR('))"), 'Q326 must forbid executable PaddleOCR constructor/API marker, not broad historical text');
check(q326.includes("isNot(contains('OnnxRuntime('))"), 'Q326 must forbid executable OnnxRuntime constructor/API marker, not broad historical text');
check(!q326.includes("isNot(contains('OnnxRuntime'))"), 'Q326 must not broadly forbid successor OnnxRuntime evidence strings');

const legacyGateTests = [
  ['Q329', 'test/v172_q329_native_package_hash_evidence_review_binary_bundle_approval_gate_test.dart'],
  ['Q330', 'test/v172_q330_binary_bundle_trial_jnilibs_paddlepredictor_default_off_test.dart'],
  ['Q331', 'test/v172_q331_native_package_hash_evidence_acceptance_bundle_permission_gate_test.dart'],
  ['Q332', 'test/v172_q332_actual_binary_bundle_jnilibs_paddlepredictor_blocked_gate_test.dart'],
  ['Q333', 'test/v172_q333_native_package_hash_evidence_intake_real_bundle_permission_review_test.dart'],
  ['Q334', 'test/v172_q334_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_test.dart'],
];
for (const [phase, file] of legacyGateTests) {
  const text = read(file);
  check(text.includes("'MobileConfig('") || text.includes("contains('MobileConfig(')"), `${phase} must forbid direct MobileConfig constructor usage`);
  check(!text.includes("'MobileConfig',"), `${phase} must not hard-forbid successor MobileConfig class-name evidence`);
  check(text.includes("'PaddlePredictor('") || text.includes("contains('PaddlePredictor(')"), `${phase} must still forbid direct PaddlePredictor constructor usage`);
  check(text.includes("'PaddleOCR('") || text.includes("contains('PaddleOCR(')"), `${phase} must forbid executable PaddleOCR marker`);
  check(!text.includes("'PaddleOCR',"), `${phase} must not hard-forbid broad PaddleOCR evidence string`);
  check(text.includes("'OnnxRuntime('") || text.includes("contains('OnnxRuntime(')"), `${phase} must forbid executable OnnxRuntime marker`);
  check(!text.includes("'OnnxRuntime',"), `${phase} must not hard-forbid broad OnnxRuntime evidence string`);
  check(text.includes("'loadModel('") && text.includes("'runInference('"), `${phase} must still forbid direct load/run runtime calls`);
}

const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
check(manager.includes('ana model dosyası SHA256'), 'Q385R2 ready copy must mention primary SHA verification');
check(manager.includes('yan dosyalar varlık ve boyut'), 'Q385R2 ready copy must mention sidecar presence/size checks');
check(!manager.includes('yan dosyalar SHA256'), 'Q385R2 ready copy must not claim sidecar SHA locks');

const manifest = json('assets/mathlive/manifest.json');
const entry = manifest.v172Q389R5DOfflineLegacyFlutterTestGuardRepair;
check(Boolean(entry), 'manifest Q389R5D entry missing');
check(entry.phase === 'V172-Q389R5D_OFFLINE', 'manifest Q389R5D phase mismatch');
check(entry.sourcePhase === 'V172-Q389R5C_OFFLINE', 'manifest Q389R5D source phase mismatch');
for (const key of ['backendAllowed', 'mlKitAllowed', 'textOcrFallbackAllowed', 'modelBundledInBaseApp', 'fakeLatexCandidateAllowed', 'ocrPassClaimedByPackage', 'androidRealDevicePassClaimedByPackage', 'flutterAnalyzePassClaimedByPackage', 'flutterTestPassClaimedByPackage']) {
  check(entry[key] === false, `manifest ${key} must be false`);
}
check(entry.legacyQ326GuardMadeSuccessorAware === true, 'manifest must record Q326 guard repair');
check(entry.legacyQ329ToQ334MobileConfigGuardMadeSuccessorAware === true, 'manifest must record Q329-Q334 guard repair');
check(entry.q385R2ReadyCopySidecarPhraseRestored === true, 'manifest must record Q385R2 sidecar copy repair');

check(exists('docs/audit/V172_Q389R5D_OFFLINE_LEGACY_FLUTTER_TEST_GUARD_REPAIR.md'), 'Q389R5D audit doc missing');
check(exists('docs/audit/V172_Q389R5D_CHANGED_FILES.md'), 'Q389R5D changed files doc missing');
check(read('README.md').includes('V172-Q389R5D'), 'README Q389R5D section missing');

console.log('PASS verify_q389r5d_offline_legacy_flutter_test_guard_repair');
