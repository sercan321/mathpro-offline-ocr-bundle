#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q351R1-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const preserved = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
const q352SuccessorPhase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
const q353SuccessorPhase = 'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
const q354SuccessorPhase = 'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
const q355SuccessorPhase = 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION';
const q356SuccessorPhase = 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const q356r1SuccessorPhase = 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD';
const q356r2SuccessorPhase = 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD';
const q357SuccessorPhase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
const q358SuccessorPhase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
const q359SuccessorPhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const q360SuccessorPhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const q361SuccessorPhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q362SuccessorPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }
function sha256(rel) { return crypto.createHash('sha256').update(fs.readFileSync(path.join(root, rel))).digest('hex'); }
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([preserved, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), 'Q351R1 must preserve or accept Q352 successor cameraOcrLatestPhase');
assert([preserved, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), 'Q351R1 must preserve or accept Q352 successor activeProductDevelopmentLatestPhase');
assert(manifest.q351R1FlutterTestSuccessorAwareHygieneRepairLatestPhase === phase, 'Q351R1 latest marker missing');
const q351r1 = manifest.v172Q351R1FlutterTestSuccessorAwareHygieneRepair;
assert(q351r1 && q351r1.phase === phase, 'Q351R1 manifest envelope missing');
for (const key of ['successorAwarenessRepair','runtimeMarkerExpectationRepair','generatedBuildArtifactExclusionRepair']) assert(q351r1[key] === true, `${key} must be true`);
for (const key of ['mainActivityChanged','gradleChanged','pubspecChanged','androidManifestChanged','modelLoadAttempted','modelLoaded','runtimeStartupExecuted','realImageToLatexInferenceExecuted','ocrPassClaimed','androidRealDevicePassClaimed']) assert(q351r1[key] === false, `${key} must remain false`);
const helper = read('test/v172_q344_binary_bundle_successor_test_helper.dart');
assert(helper.includes('q347OrLaterPaddleLiteBridgeActivePhases'), 'helper must expose Q347+ Paddle Lite bridge successor set');
assert(helper.includes('isQ347OrLaterPaddleLiteBridgeActive'), 'helper must expose Q347+ active predicate');
for (const rel of [
  'test/v172_q318_private_model_download_storage_real_implementation_test.dart',
  'test/v172_q319_verified_artifact_load_smoke_on_device_test.dart',
  'test/v172_q320_runtime_startup_smoke_on_device_test.dart',
  'test/v172_q321_dummy_input_runtime_call_test.dart',
  'test/v172_q322_first_image_to_latex_inference_envelope_test.dart',
  'test/v172_q323_runtime_dependency_model_loader_decision_test.dart',
  'test/v172_q324_approved_runtime_dependency_trial_test.dart',
  'test/v172_q325_runtime_dependency_coordinate_selection_build_trial_gate_test.dart',
  'test/v172_q335_native_package_hash_evidence_collection_user_side_native_package_intake_test.dart'
]) {
  const content = read(rel);
  assert(content.includes('isQ347OrLaterPaddleLiteBridgeActive'), `${rel} must be Q347+ runtime marker successor-aware`);
}
const q342 = read('test/v172_q342_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_test.dart');
assert(q342.includes('q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGatePhase'), 'Q342 successor list must accept Q351');
for (const rel of ['test/v172_q350_optimized_model_artifact_conversion_evidence_intake_test.dart','test/v172_q351_optimized_model_evidence_acceptance_real_model_load_unlock_gate_test.dart']) {
  const content = read(rel);
  assert(content.includes("!path.startsWith('build/')"), `${rel} must ignore generated build artifacts`);
  assert(content.includes("!path.startsWith('.dart_tool/')"), `${rel} must ignore generated Dart tool artifacts`);
}
const expected = new Map([
  ['android/app/libs/PaddlePredictor.jar', ['9167', '81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2']],
  ['android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so', ['4531976', '2eb3cd0f1d3d01c2199ee79d28f5bef7180a699f7bd9cbb183743f3031277fe2']],
  ['android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so', ['2877288', '261de17f07130118962226f451a9a75aae84ff15bfe4e4b6b2ed942b5a7b121f']],
]);
for (const [rel, [size, hash]] of expected.entries()) {
  assert(exists(rel), `expected binary missing: ${rel}`);
  assert(String(fs.statSync(path.join(root, rel)).size) === size, `${rel} size mismatch`);
  assert(sha256(rel) === hash, `${rel} hash mismatch`);
}
assert(read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').includes('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'), 'Q347 bridge must be preserved');
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q345 jar dependency must be preserved');
console.log(JSON.stringify({ phase, preservedCameraOcrLatestPhase: preserved, successorAwarenessRepair: true, generatedBuildArtifactExclusionRepair: true, runtimeMarkerExpectationRepair: true, ok: true }, null, 2));
