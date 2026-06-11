#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const phase = 'V172-Q363R2-FLUTTER-TEST-LEGACY-SUCCESSOR-AWARENESS-CLOSURE-REPAIR';
const sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const errors = [];
const check = (condition, message) => { if (!condition) errors.push(message); };

check(manifest.cameraOcrLatestPhase === sourcePhase, 'cameraOcrLatestPhase must remain Q363 for Q363R2 hygiene-only repair');
check(manifest.activeProductDevelopmentLatestPhase === sourcePhase, 'activeProductDevelopmentLatestPhase must remain Q363 for Q363R2 hygiene-only repair');
check(manifest.q363R2FlutterTestLegacySuccessorAwarenessClosureRepairLatestPhase === phase, 'Q363R2 latest hygiene phase missing');
const q363r2 = manifest.v172Q363R2FlutterTestLegacySuccessorAwarenessClosureRepair || {};
check(q363r2.phase === phase, 'Q363R2 manifest envelope phase mismatch');
check(q363r2.sourcePhase === sourcePhase, 'Q363R2 source phase mismatch');
check(q363r2.repairsFlutterTestFailures === true, 'Q363R2 must declare flutter test repair');
check(q363r2.repairsLegacyQ322ToQ352SuccessorAwareness === true, 'Q363R2 must declare Q322-Q352 successor-awareness repair');
check(q363r2.repairsQ344ToQ351R2SuccessorAwareness === true, 'Q363R2 must declare Q344-Q351R2 successor-awareness repair');
check(q363r2.repairsStorePrivacyFinalReleaseGateAcceptance === true, 'Q363R2 must declare Q363 active phase acceptance repair');

for (const rel of [
  'lib/features/camera/gauss_q363r2_flutter_test_legacy_successor_awareness_closure_repair_policy.dart',
  'lib/features/camera/gauss_q363r2_flutter_test_legacy_successor_awareness_closure_repair.dart',
  'test/v172_q363r2_flutter_test_legacy_successor_awareness_closure_repair_test.dart',
]) check(exists(rel), `${rel} missing`);

const legacyTests = [
  'test/v172_q322_first_image_to_latex_inference_envelope_test.dart',
  'test/v172_q323_runtime_dependency_model_loader_decision_test.dart',
  'test/v172_q324_approved_runtime_dependency_trial_test.dart',
  'test/v172_q325_runtime_dependency_coordinate_selection_build_trial_gate_test.dart',
  'test/v172_q326_native_library_build_trial_approval_abi_packaging_preflight_test.dart',
  'test/v172_q327_native_library_source_package_approval_abi_matrix_lock_test.dart',
  'test/v172_q328_native_library_package_file_hash_intake_no_bundle_evidence_gate_test.dart',
  'test/v172_q329_native_package_hash_evidence_review_binary_bundle_approval_gate_test.dart',
  'test/v172_q330_binary_bundle_trial_jnilibs_paddlepredictor_default_off_test.dart',
  'test/v172_q331_native_package_hash_evidence_acceptance_bundle_permission_gate_test.dart',
  'test/v172_q332_actual_binary_bundle_jnilibs_paddlepredictor_blocked_gate_test.dart',
  'test/v172_q333_native_package_hash_evidence_intake_real_bundle_permission_review_test.dart',
  'test/v172_q334_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_test.dart',
  'test/v172_q335_native_package_hash_evidence_collection_user_side_native_package_intake_test.dart',
  'test/v172_q336_native_package_hash_evidence_capture_q328_json_intake_test.dart',
  'test/v172_q337_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_test.dart',
  'test/v172_q338_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_test.dart',
  'test/v172_q339_native_package_hash_evidence_capture_actual_bundle_permission_final_check_test.dart',
  'test/v172_q340_actual_binary_bundle_jnilibs_paddlepredictor_evidence_blocked_gate_test.dart',
  'test/v172_q341_native_package_hash_evidence_capture_bundle_evidence_acceptance_test.dart',
  'test/v172_q342_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_test.dart',
  'test/v172_q343_native_package_hash_evidence_final_acceptance_real_bundle_unlock_gate_test.dart',
  'test/v172_q343r1_flutter_analyze_test_successor_aware_hygiene_repair_test.dart',
  'test/v172_q343r2_flutter_analyze_test_syntax_hygiene_repair_test.dart',
  'test/v172_q344_actual_binary_bundle_jnilibs_paddlepredictor_test.dart',
  'test/v172_q345_gradle_abi_packaging_build_trial_test.dart',
  'test/v172_q346_native_library_load_smoke_test.dart',
  'test/v172_q347_paddle_lite_predictor_instantiate_smoke_test.dart',
  'test/v172_q348_optimized_model_conversion_model_loader_evidence_gate_test.dart',
  'test/v172_q349_real_model_load_smoke_evidence_blocked_test.dart',
  'test/v172_q350_optimized_model_artifact_conversion_evidence_intake_test.dart',
  'test/v172_q351_optimized_model_evidence_acceptance_real_model_load_unlock_gate_test.dart',
  'test/v172_q351r1_flutter_test_successor_aware_hygiene_repair_test.dart',
  'test/v172_q351r2_flutter_run_kotlin_build_helper_repair_test.dart',
];

for (const rel of legacyTests) {
  const content = read(rel);
  check(content.includes(sourcePhase), `${rel} must accept Q363 active product phase`);
}

const allTestFiles = fs.readdirSync(path.join(root, 'test')).filter((name) => name.endsWith('.dart'));
for (const name of allTestFiles) {
  const rel = `test/${name}`;
  const content = read(rel);
  if (content.includes("contains(manifest['cameraOcrLatestPhase'])") ||
      content.includes("contains(manifest['activeProductDevelopmentLatestPhase'])")) {
    check(content.includes(sourcePhase) || content.includes('q363StorePrivacyFinalReleaseGatePhase'), `${rel} has manifest active-phase expectations but no Q363 successor acceptance`);
  }
}

const q358Test = read('test/v172_q358_onnx_dummy_input_runtime_call_guard_preflight_test.dart');
check(q358Test.includes("replaceAll('\\\\', '/')"), 'Q358 test must use escaped Windows path separator');
check(!q358Test.includes("replaceAll('\\', '/')"), 'Q358 test still has malformed Windows path escape');
const helper = read('test/v172_q344_binary_bundle_successor_test_helper.dart');
check(helper.includes('q363StorePrivacyFinalReleaseGatePhase'), 'successor helper must define Q363 phase');
check(helper.includes('q363StorePrivacyFinalReleaseGatePhase,'), 'successor helper must include Q363 in successor phase sets');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(!mainActivity.includes('q363r2'), 'Q363R2 must not modify MainActivity/runtime bridge');
const gradle = read('android/app/build.gradle');
check(gradle.includes("implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0'"), 'Q354 ONNX Runtime dependency must be preserved');
const pubspec = read('pubspec.yaml').toLowerCase();
check(!pubspec.includes('onnxruntime'), 'pubspec must not gain ONNX Runtime dependency');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
check(!androidManifest.includes('ONNX'), 'AndroidManifest must not be modified for ONNX');

const forbiddenModelExtensions = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i;
const walk = (dir) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    const rel = path.relative(root, full).replaceAll(path.sep, '/');
    if (rel.startsWith('build/') || rel.includes('/build/') || rel.startsWith('.dart_tool/') || rel.includes('/.dart_tool/')) continue;
    if (entry.isDirectory()) walk(full);
    if (entry.isFile() && forbiddenModelExtensions.test(entry.name) && !rel.startsWith('docs/evidence/')) {
      errors.push(`model artifact must not be bundled: ${rel}`);
    }
  }
};
walk(root);

if (errors.length) {
  console.error('Q363R2_FLUTTER_TEST_LEGACY_SUCCESSOR_AWARENESS_CLOSURE_REPAIR_FAILED');
  for (const error of errors) console.error(` - ${error}`);
  process.exit(1);
}
console.log('Q363R2_FLUTTER_TEST_LEGACY_SUCCESSOR_AWARENESS_CLOSURE_REPAIR_PASS');
