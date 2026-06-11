#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const phase = 'V172-Q363R1-ANALYZER-TEST-HYGIENE-REPAIR';
const sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const errors = [];
const check = (condition, message) => { if (!condition) errors.push(message); };

check(manifest.cameraOcrLatestPhase === sourcePhase, 'cameraOcrLatestPhase must remain Q363 for hygiene-only repair');
check(manifest.activeProductDevelopmentLatestPhase === sourcePhase, 'activeProductDevelopmentLatestPhase must remain Q363 for hygiene-only repair');
check(manifest.q363R1AnalyzerTestHygieneRepairLatestPhase === phase, 'Q363R1 latest hygiene phase missing');
const q363r1 = manifest.v172Q363R1AnalyzerTestHygieneRepair || {};
check(q363r1.phase === phase, 'Q363R1 manifest envelope phase mismatch');
check(q363r1.sourcePhase === sourcePhase, 'Q363R1 source phase mismatch');
check(q363r1.repairsAnalyzerCompilationErrors === true, 'Q363R1 must declare analyzer compilation repair');
check(q363r1.repairsUndefinedManifestScope === true, 'Q363R1 must declare undefined manifest scope repair');
check(q363r1.repairsUndefinedSuccessorPhaseConstants === true, 'Q363R1 must declare successor phase constant repair');
check(q363r1.repairsMalformedWindowsPathEscape === true, 'Q363R1 must declare malformed Windows path escape repair');
check(q363r1.repairsQ362SuccessorAcceptanceForQ363 === true, 'Q363R1 must declare Q362 successor acceptance repair');

for (const rel of [
  'lib/features/camera/gauss_q363r1_analyzer_test_hygiene_repair_policy.dart',
  'lib/features/camera/gauss_q363r1_analyzer_test_hygiene_repair.dart',
  'test/v172_q363r1_analyzer_test_hygiene_repair_test.dart',
]) check(exists(rel), `${rel} missing`);

for (const rel of [
  'test/v172_q353_onnx_runtime_mobile_dependency_feasibility_gate_test.dart',
  'test/v172_q354_onnx_runtime_android_dependency_abi_build_trial_test.dart',
  'test/v172_q355_onnx_model_private_storage_sha_verification_test.dart',
  'test/v172_q356_onnx_real_model_load_smoke_evidence_blocked_test.dart',
  'test/v172_q356r1_onnx_runtime_android_build_evidence_intake_model_load_unlock_guard_test.dart',
  'test/v172_q356r2_onnx_runtime_android_missing_build_evidence_q357_lock_guard_test.dart',
]) {
  const content = read(rel);
  check(content.includes('V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'), `${rel} must accept Q363 successor phase`);
  check(content.includes('q357OrLaterOnnxBridgeActivePhases'), `${rel} must use Q357-or-later bridge guard`);
  check(!content.includes("if (manifest['cameraOcrLatestPhase'] != q357SuccessorPhase) for"), `${rel} contains old unscoped if-for form`);
}

const q358Test = read('test/v172_q358_onnx_dummy_input_runtime_call_guard_preflight_test.dart');
check(q358Test.includes("replaceAll('\\\\', '/')"), 'Q358 test must use escaped Windows path separator');
check(!q358Test.includes("replaceAll('\\', '/')"), 'Q358 test still has malformed Windows path escape');
const q362Test = read('test/v172_q362_accuracy_performance_multidevice_qa_guard_test.dart');
check(q362Test.includes('V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'), 'Q362 test must accept Q363 successor phase');
const helper = read('test/v172_q344_binary_bundle_successor_test_helper.dart');
check(helper.includes('q363StorePrivacyFinalReleaseGatePhase'), 'successor helper must define Q363 phase');
check(helper.includes('q357OnnxRealModelLoadSmokeBridgePreflightExecutionPhase'), 'successor helper must define Q357 phase');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(!mainActivity.includes('q363r1'), 'Q363R1 must not modify MainActivity/runtime bridge');
check(mainActivity.includes('private val q361FeatureEnabled = false'), 'Q361 default-off bridge must remain present and disabled');
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
  console.error('Q363R1_ANALYZER_TEST_HYGIENE_REPAIR_FAILED');
  for (const error of errors) console.error(` - ${error}`);
  process.exit(1);
}
console.log('Q363R1_ANALYZER_TEST_HYGIENE_REPAIR_PASS');
