#!/usr/bin/env node
import fs from 'fs';

const fail = (message) => { console.error(`FAIL verify_q389r5e_offline_stale_guard_sweep_repair: ${message}`); process.exit(1); };
const check = (condition, message) => { if (!condition) fail(message); };
const read = (path) => fs.readFileSync(path, 'utf8');
const json = (path) => JSON.parse(read(path));
const exists = (path) => fs.existsSync(path);

const sweptLegacyMainActivityGuardTests = [
  'test/v172_q317_android_native_bridge_minimal_healthcheck_behind_flag_test.dart',
  'test/v172_q318_private_model_download_storage_real_implementation_test.dart',
  'test/v172_q319_verified_artifact_load_smoke_on_device_test.dart',
  'test/v172_q320_runtime_startup_smoke_on_device_test.dart',
  'test/v172_q321_dummy_input_runtime_call_test.dart',
  'test/v172_q322_first_image_to_latex_inference_envelope_test.dart',
  'test/v172_q323_runtime_dependency_model_loader_decision_test.dart',
  'test/v172_q324_approved_runtime_dependency_trial_test.dart',
  'test/v172_q325_runtime_dependency_coordinate_selection_build_trial_gate_test.dart',
  'test/v172_q326_native_library_build_trial_approval_abi_packaging_preflight_test.dart',
  'test/v172_q329_native_package_hash_evidence_review_binary_bundle_approval_gate_test.dart',
  'test/v172_q330_binary_bundle_trial_jnilibs_paddlepredictor_default_off_test.dart',
  'test/v172_q331_native_package_hash_evidence_acceptance_bundle_permission_gate_test.dart',
  'test/v172_q332_actual_binary_bundle_jnilibs_paddlepredictor_blocked_gate_test.dart',
  'test/v172_q333_native_package_hash_evidence_intake_real_bundle_permission_review_test.dart',
  'test/v172_q334_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_test.dart',
];

for (const file of sweptLegacyMainActivityGuardTests) {
  const text = read(file);
  for (const broad of [
    "isNot(contains('PaddleOCR'))",
    "isNot(contains('PaddleLite'))",
    "isNot(contains('OnnxRuntime'))",
    "isNot(contains('MobileConfig'))",
  ]) {
    check(!text.includes(broad), `${file} must not contain stale broad guard ${broad}`);
  }
  check(!text.includes("'MobileConfig',"), `${file} must not keep MobileConfig as a broad forbidden marker list item`);
}

const q325 = read('test/v172_q325_runtime_dependency_coordinate_selection_build_trial_gate_test.dart');
check(q325.includes("isNot(contains('PaddleOCR('))"), 'Q325 must forbid executable PaddleOCR marker only');
check(q325.includes("isNot(contains('OnnxRuntime('))"), 'Q325 must forbid executable OnnxRuntime marker only');
check(q325.includes("isNot(contains('PaddleLite('))") || q325.includes("contains('private val q347Phase"), 'Q325 must not fail on successor PaddleLite class-name evidence');

const q317 = read('test/v172_q317_android_native_bridge_minimal_healthcheck_behind_flag_test.dart');
check(q317.includes("isNot(contains('PaddleOCR('))"), 'Q317 must forbid executable PaddleOCR marker only');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(mainActivity.includes('q386RealPaddleOcrInferenceBridge'), 'real Paddle bridge evidence path must remain present');
check(mainActivity.includes('q387R1NbArtifactReady'), 'real .nb manifest readiness gate must remain present');
check(mainActivity.includes('supportsSetModelFromFile'), 'Paddle Lite setModelFromFile API evidence must remain present');
check(!mainActivity.includes('PaddleOCR('), 'MainActivity must not add PaddleOCR executable/runtime constructor');
check(!mainActivity.includes('OnnxRuntime('), 'MainActivity must not add OnnxRuntime executable/runtime constructor');
check(!mainActivity.includes('PaddleLite('), 'MainActivity must not add PaddleLite executable/runtime constructor');
check(!mainActivity.includes('MobileConfig('), 'MainActivity must not add unguarded MobileConfig constructor usage');
check(!mainActivity.includes('loadModel('), 'MainActivity must not add direct loadModel call');
check(!mainActivity.includes('runInference('), 'MainActivity must not add direct runInference call');

const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
check(manager.includes('ana model dosyası SHA256'), 'Q385R2 ready copy must still mention primary SHA verification');
check(manager.includes('yan dosyalar varlık ve boyut'), 'Q385R2 ready copy must still mention sidecar presence/size checks');

const manifest = json('assets/mathlive/manifest.json');
const entry = manifest.v172Q389R5EOfflineStaleGuardSweepRepair;
check(Boolean(entry), 'manifest Q389R5E entry missing');
check(entry.phase === 'V172-Q389R5E_OFFLINE', 'manifest Q389R5E phase mismatch');
check(entry.sourcePhase === 'V172-Q389R5D_OFFLINE', 'manifest Q389R5E source phase mismatch');
for (const key of ['backendAllowed', 'mlKitAllowed', 'textOcrFallbackAllowed', 'modelBundledInBaseApp', 'fakeLatexCandidateAllowed', 'ocrPassClaimedByPackage', 'androidRealDevicePassClaimedByPackage', 'flutterAnalyzePassClaimedByPackage', 'flutterTestPassClaimedByPackage']) {
  check(entry[key] === false, `manifest ${key} must be false`);
}
check(entry.q317ToQ325BroadRuntimeMarkerGuardsSwept === true, 'manifest must record Q317-Q325 broad guard sweep');
check(entry.q329ToQ334MobileConfigGuardPreservedFromQ389R5D === true, 'manifest must preserve Q329-Q334 guard repair');
check(entry.q382KeyboardOrderingTouched === false, 'Q382 keyboard ordering must remain untouched');
check(entry.graphHistorySolutionSolverTouched === false, 'Graph/History/Solution/Solver must remain untouched');

check(exists('docs/audit/V172_Q389R5E_OFFLINE_STALE_GUARD_SWEEP_REPAIR.md'), 'Q389R5E audit doc missing');
check(exists('docs/audit/V172_Q389R5E_CHANGED_FILES.md'), 'Q389R5E changed files doc missing');
check(read('README.md').includes('V172-Q389R5E'), 'README Q389R5E section missing');

console.log('PASS verify_q389r5e_offline_stale_guard_sweep_repair');
