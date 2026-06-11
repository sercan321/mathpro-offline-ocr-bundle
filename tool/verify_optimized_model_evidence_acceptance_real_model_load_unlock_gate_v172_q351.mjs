#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
const sourcePhase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
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
const expectedTargets = new Map([
  ['android/app/libs/PaddlePredictor.jar', { size: 9167, sha256: '81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2' }],
  ['android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so', { size: 4531976, sha256: '2eb3cd0f1d3d01c2199ee79d28f5bef7180a699f7bd9cbb183743f3031277fe2' }],
  ['android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so', { size: 2877288, sha256: '261de17f07130118962226f451a9a75aae84ff15bfe4e4b6b2ed942b5a7b121f' }],
]);
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }
function sha256File(rel) { return crypto.createHash('sha256').update(fs.readFileSync(path.join(root, rel))).digest('hex'); }
function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full, out); else out.push(path.relative(root, full).replaceAll(path.sep, '/'));
  }
  return out;
}
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([phase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q351 or Q352 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q351 or Q352 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.optimizedModelEvidenceAcceptanceRealModelLoadUnlockGateLatestPhase === phase, 'Q351 latest key missing');
const q351 = manifest.v172Q351OptimizedModelEvidenceAcceptanceRealModelLoadUnlockGate;
assert(q351 && q351.phase === phase, 'Q351 manifest envelope missing');
assert(q351.sourcePhase === sourcePhase, 'Q351 source phase mismatch');
assert(q351.q350EvidenceIntakePresent === true, 'Q351 must build on Q350 evidence intake');
assert(q351.q349EvidenceBlockedPresent === true, 'Q351 must preserve Q349 blocked state');
assert(q351.q348EvidenceGatePresent === true, 'Q351 must preserve Q348 evidence gate');
assert(q351.q347PredictorInstantiateSmokePresent === true, 'Q351 must preserve Q347 predictor instantiate smoke');
assert(q351.q346NativeLibraryLoadSmokePresent === true, 'Q351 must preserve Q346 native load smoke');
assert(q351.q345GradleAbiPackagingBuildTrialPresent === true, 'Q351 must preserve Q345 packaging trial');
assert(q351.q344ActualBinaryBundlePresent === true, 'Q351 must preserve Q344 actual binary bundle');
assert(q351.q350OptimizedEvidenceJsonRequired === true, 'Q351 must require Q350 optimized evidence JSON');
assert(q351.inferencePdiparamsAloneAcceptedForModelLoad === false, 'Q351 must not accept inference.pdiparams alone');
for (const key of [
  'optimizedModelEvidenceAccepted', 'modelLoaderPathApproved', 'realModelLoadUnlockGranted', 'modelLoaderAvailable',
  'modelLoadAttempted', 'modelLoaded', 'runtimeStartupExecuted', 'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted', 'editableMathLiveReviewOpened', 'workspaceImportExecuted',
  'mainActivityChanged', 'gradleChanged', 'pubspecChanged', 'androidManifestChanged', 'workspaceChanged', 'keyboardChanged',
  'moreTemplateTrayChanged', 'longPressChanged', 'mathLiveProductionBridgeChanged', 'graphChanged', 'solutionChanged',
  'historyChanged', 'splashChanged', 'iconChanged', 'flutterAnalyzePassClaimed', 'flutterTestPassClaimed',
  'androidRealDevicePassClaimed', 'ocrPassClaimed'
]) { assert(q351[key] === false, `Q351 must keep ${key} false`); }
for (const rel of [
  'lib/features/camera/gauss_optimized_model_evidence_acceptance_real_model_load_unlock_gate_q351_policy.dart',
  'lib/features/camera/gauss_optimized_model_evidence_acceptance_real_model_load_unlock_gate_q351.dart',
  'test/v172_q351_optimized_model_evidence_acceptance_real_model_load_unlock_gate_test.dart',
  'tool/verify_optimized_model_evidence_acceptance_real_model_load_unlock_gate_v172_q351.mjs',
  'tool/intake_pp_formulanet_s_optimized_model_evidence_v172_q351.mjs',
  'tool/prepare_pp_formulanet_s_optimized_model_intake_v172_q350.mjs',
  'tool/capture_pp_formulanet_s_optimized_model_evidence_v172_q350.mjs',
  'docs/evidence/V172_Q351_OPTIMIZED_MODEL_EVIDENCE_ACCEPTANCE_REAL_MODEL_LOAD_UNLOCK_REQUIREMENTS.json',
  'docs/audit/V172_Q351_OPTIMIZED_MODEL_EVIDENCE_ACCEPTANCE_REAL_MODEL_LOAD_UNLOCK_GATE_AUDIT.md',
  'docs/audit/V172_Q351_CHANGED_FILES.md'
]) { assert(exists(rel), `Q351 expected file missing: ${rel}`); }
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q351 expected bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'), 'Q351 must preserve Q347 MainActivity bridge');
assert(!mainActivity.includes('q351'), 'Q351 must not mutate MainActivity');
for (const forbidden of ['setModelFromFile', 'loadModel(', 'runInference(', 'inference.pdmodel', '.nb']) { assert(!mainActivity.includes(forbidden), `Q351 must not include model loader/runtime marker ${forbidden}`); }
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q351 must preserve Q345 jar dependency');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('Paddle'), 'Q351 must not mutate AndroidManifest for Paddle runtime');
assert(!exists('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so'), 'Q351 must not invent x86_64 optional ABI');
const forbiddenModelFiles = walk(root).filter(rel => /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q351 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !expectedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);
console.log(JSON.stringify({ phase, status: q351.status, optimizedModelEvidenceAccepted: q351.optimizedModelEvidenceAccepted, realModelLoadUnlockGranted: q351.realModelLoadUnlockGranted, modelLoadAttempted: q351.modelLoadAttempted, modelLoaded: q351.modelLoaded, ok: true }, null, 2));
