#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const sourcePhase = 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE';
const q350SuccessorPhase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const q351SuccessorPhase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
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
    if (entry.isDirectory()) walk(full, out);
    else out.push(path.relative(root, full).replaceAll(path.sep, '/'));
  }
  return out;
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([phase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q349 or Q350 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q349 or Q350 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.realModelLoadSmokeEvidenceBlockedLatestPhase === phase, 'Q349 latest key missing');
const q349 = manifest.v172Q349RealModelLoadSmokeEvidenceBlocked;
assert(q349 && q349.phase === phase, 'Q349 manifest envelope missing');
assert(q349.sourcePhase === sourcePhase, 'Q349 source phase mismatch');
assert(q349.q348EvidenceGatePresent === true, 'Q349 must build on Q348 evidence gate');
assert(q349.q347PredictorInstantiateSmokePresent === true, 'Q349 must preserve Q347 predictor instantiate smoke');
assert(q349.q346NativeLibraryLoadSmokePresent === true, 'Q349 must preserve Q346 native load smoke');
assert(q349.q345GradleAbiPackagingBuildTrialPresent === true, 'Q349 must preserve Q345 packaging trial');
assert(q349.q344ActualBinaryBundlePresent === true, 'Q349 must preserve Q344 actual binary bundle');
assert(q349.knownUserArtifactFileName === 'inference.pdiparams', 'Q349 must record known Q315 artifact name');
assert(q349.knownUserArtifactSha256 === 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489', 'Q349 must preserve Q315 artifact SHA');
assert(q349.knownUserArtifactSizeBytes === 231675001, 'Q349 must preserve Q315 artifact size');
assert(q349.inferencePdiparamsAloneAcceptedForModelLoad === false, 'Q349 must not accept inference.pdiparams alone for model load');
assert(q349.realModelLoadSmokeRequested === true, 'Q349 must record that real model load smoke is the requested next step');
assert(q349.realModelLoadSmokeBlockedByMissingEvidence === true, 'Q349 must block real model load smoke until conversion evidence is accepted');
assert(Array.isArray(q349.blockedReasons) && q349.blockedReasons.includes('optimized-model-artifact-not-provided'), 'Q349 blocked reasons incomplete');
for (const key of [
  'optimizedModelEvidenceProvided', 'conversionLogProvided', 'convertedModelSha256Provided', 'modelLoaderPathApproved',
  'modelLoaderAvailable', 'modelLoadAttempted', 'modelLoaded', 'runtimeStartupExecuted', 'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted', 'editableMathLiveReviewOpened', 'workspaceImportExecuted', 'mainActivityChanged',
  'gradleChanged', 'pubspecChanged', 'androidManifestChanged', 'workspaceChanged', 'keyboardChanged', 'moreTemplateTrayChanged',
  'longPressChanged', 'mathLiveProductionBridgeChanged', 'graphChanged', 'solutionChanged', 'historyChanged',
  'splashChanged', 'iconChanged', 'flutterAnalyzePassClaimed', 'flutterTestPassClaimed',
  'androidRealDevicePassClaimed', 'ocrPassClaimed',
]) {
  assert(q349[key] === false, `Q349 must keep ${key} false`);
}
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'), 'Q349 must preserve Q347 MainActivity bridge');
assert(!mainActivity.includes('q349'), 'Q349 must not mutate MainActivity');
for (const forbidden of ['setModelFromFile', 'loadModel(', 'runInference(', 'inference.pdmodel', '.nb']) {
  assert(!mainActivity.includes(forbidden), `Q349 must not include model loader/runtime marker ${forbidden}`);
}
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q349 must preserve Q345 jar dependency');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('Paddle'), 'Q349 must not mutate AndroidManifest for Paddle runtime');
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q349 expected bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
assert(!exists('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so'), 'Q349 must not invent x86_64 optional ABI');
const forbiddenModelFiles = walk(root).filter(rel => /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q349 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !expectedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);
for (const rel of [
  'lib/features/camera/gauss_real_model_load_smoke_evidence_blocked_q349_policy.dart',
  'lib/features/camera/gauss_real_model_load_smoke_evidence_blocked_q349.dart',
  'test/v172_q349_real_model_load_smoke_evidence_blocked_test.dart',
  'tool/verify_real_model_load_smoke_evidence_blocked_v172_q349.mjs',
  'docs/audit/V172_Q349_REAL_MODEL_LOAD_SMOKE_EVIDENCE_BLOCKED_AUDIT.md',
  'docs/audit/V172_Q349_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q349 expected file missing: ${rel}`);
}
console.log(JSON.stringify({
  phase,
  status: q349.status,
  realModelLoadSmokeBlockedByMissingEvidence: q349.realModelLoadSmokeBlockedByMissingEvidence,
  modelLoadAttempted: q349.modelLoadAttempted,
  modelLoaded: q349.modelLoaded,
  bundledTargets: [...expectedTargets.keys()],
  ok: true,
}, null, 2));
