#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q343R1-FLUTTER-ANALYZE-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const q343Phase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
const q344SuccessorPhase = 'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR';
const q345SuccessorPhase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
const q346SuccessorPhase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
const q347SuccessorPhase = 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE';
const q348SuccessorPhase = 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE';
const q349SuccessorPhase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const q350SuccessorPhase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const q351SuccessorPhase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
const q351R1SuccessorPhase = 'V172-Q351R1-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const q351R2SuccessorPhase = 'V172-Q351R2-FLUTTER-RUN-KOTLIN-BUILD-HELPER-REPAIR';
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

const q344AllowedBinaryTargets = new Set([
  'android/app/libs/PaddlePredictor.jar',
  'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
  'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
]);
function allowQ344OrLaterBundledBinaries() {
  return [q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase) ||
      [q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase);
}

function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([q343Phase, q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `Q343R1 must preserve Q343 or accept later Q344/Q345/Q346 successor phase, got ${manifest.cameraOcrLatestPhase}`);
assert([q343Phase, q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `Q343R1 must preserve Q343 or accept later Q344/Q345/Q346 product phase, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.q343FlutterAnalyzeTestSuccessorAwareHygieneRepairLatestPhase === phase, 'Q343R1 latest repair key missing');
const q343r1 = manifest.v172Q343R1FlutterAnalyzeTestSuccessorAwareHygieneRepair;
assert(q343r1 && q343r1.phase === phase, 'Q343R1 manifest envelope missing');
assert(q343r1.sourcePhase === q343Phase, 'Q343R1 source phase mismatch');
assert(q343r1.cameraOcrLatestPhaseAdvanced === false, 'Q343R1 must not advance cameraOcrLatestPhase beyond Q343');
assert(q343r1.q342Q343AnalyzerInterpolationRepaired === true, 'Q343R1 must record analyzer interpolation repair');
assert(q343r1.q313R1ThroughQ341SuccessorAwarenessRepairedForQ343 === true, 'Q343R1 must record Q313R1-Q341 successor-awareness repair');
for (const key of [
  'mainActivityChanged',
  'binaryBundleExecuted',
  'nativeLibraryBundled',
  'jarBundled',
  'jniLibsDirectoryCreated',
  'androidAppLibsDirectoryCreated',
  'gradleChanged',
  'pubspecChanged',
  'androidManifestChanged',
  'workspaceChanged',
  'keyboardChanged',
  'moreTemplateTrayChanged',
  'longPressChanged',
  'mathLiveProductionBridgeChanged',
  'graphChanged',
  'solutionChanged',
  'historyChanged',
  'splashChanged',
  'iconChanged',
  'uiRuntimeChanged',
  'systemLoadLibraryAdded',
  'paddleLiteInstantiated',
  'modelLoaderAvailable',
  'runtimeStartupExecuted',
  'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted',
  'ocrReviewUiAdded',
  'workspaceImportAdded',
  'ocrPassClaimed',
  'androidRealDevicePassClaimed',
]) {
  assert(q343r1[key] === false, `Q343R1 must keep ${key} false`);
}

const q342Test = read('test/v172_q342_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_test.dart');
const q343Test = read('test/v172_q343_native_package_hash_evidence_final_acceptance_real_bundle_unlock_gate_test.dart');
assert(q342Test.includes('private val q342Phase = "${GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.phase}"'), 'Q342 test must use interpolation for q342 phase string');
assert(q342Test.includes('"${GaussActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedQ342Policy.methodName}" -> result.success'), 'Q342 test must use interpolation for q342 method string');
assert(!q342Test.includes("'private val q342Phase = \\\"' +"), 'Q342 test must not compose q342 phase with +');
assert(!q342Test.includes('Policy.methodName +'), 'Q342 test must not compose methodName with +');
assert(q343Test.includes('private val q343Phase = "${GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.phase}"'), 'Q343 test must use interpolation for q343 phase string');
assert(q343Test.includes('"${GaussNativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGateQ343Policy.methodName}" -> result.success'), 'Q343 test must use interpolation for q343 method string');
assert(!q343Test.includes("'private val q343Phase = \\\"' +"), 'Q343 test must not compose q343 phase with +');
assert(!q343Test.includes('Policy.methodName +'), 'Q343 test must not compose methodName with +');

const q343AwareTests = [
  'test/v172_q313r1_flutter_log_repair_q295_path_escape_q152_successor_aware_test.dart',
  'test/v172_q313r2_flutter_analyze_info_hygiene_test.dart',
  'test/v172_q313r3_flutter_test_successor_aware_hygiene_repair_test.dart',
  'test/v172_q314_real_ocr_implementation_readiness_artifact_acquisition_plan_test.dart',
  'test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart',
  'test/v172_q315r1_controlled_model_artifact_download_hash_capture_flutter_test_repair_test.dart',
  'test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart',
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
];
for (const rel of q343AwareTests) {
  const text = read(rel);
  assert(text.includes(q343Phase), `${rel} must accept Q343 as successor camera OCR latest phase`);
}

for (const rel of q343AwareTests) {
  const text = read(rel);
  assert(!/^\s*,\s*'V172-Q343/m.test(text), `${rel} must not contain malformed leading-comma Q343 successor syntax`);
}

const forbiddenBinaries = [];
function walk(dir) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else if (/\.(so|aar|jar)$/i.test(entry.name)) forbiddenBinaries.push(path.relative(root, full).replaceAll(path.sep, '/'));
  }
}
walk(path.join(root, 'android', 'app'));
if (allowQ344OrLaterBundledBinaries()) {
  const unexpected = forbiddenBinaries.filter(rel => !q344AllowedBinaryTargets.has(rel));
  assert(unexpected.length === 0, `Q343R1 must allow only Q344-approved native binaries under Q344/Q345/Q346 successors: ${unexpected.join(', ')}`);
} else {
  assert(!exists('android/app/src/main/jniLibs'), 'Q343R1 must not create jniLibs directory');
  assert(!exists('android/app/libs'), 'Q343R1 must not create android/app/libs directory');
  assert(forbiddenBinaries.length === 0, `Q343R1 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
}
for (const rel of [
  'lib/features/camera/gauss_q343_flutter_analyze_test_successor_aware_hygiene_repair_policy.dart',
  'lib/features/camera/gauss_q343_flutter_analyze_test_successor_aware_hygiene_repair.dart',
  'test/v172_q343r1_flutter_analyze_test_successor_aware_hygiene_repair_test.dart',
  'docs/audit/V172_Q343R1_FLUTTER_ANALYZE_TEST_SUCCESSOR_AWARE_HYGIENE_REPAIR_AUDIT.md',
  'docs/audit/V172_Q343R1_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q343R1 expected file missing: ${rel}`);
}
console.log(JSON.stringify({ phase, preservedCameraOcrLatestPhase: manifest.cameraOcrLatestPhase, analyzerRepair: true, successorAwarenessRepair: true, ok: true }, null, 2));
