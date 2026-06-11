#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
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
const phase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const sourcePhase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
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
assert([phase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q350 or Q351 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q350 or Q351 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.optimizedModelArtifactConversionEvidenceIntakeLatestPhase === phase, 'Q350 latest key missing');
const q350 = manifest.v172Q350OptimizedModelArtifactConversionEvidenceIntake;
assert(q350 && q350.phase === phase, 'Q350 manifest envelope missing');
assert(q350.sourcePhase === sourcePhase, 'Q350 source phase mismatch');
assert(q350.q349EvidenceBlockedPresent === true, 'Q350 must build on Q349 evidence-blocked state');
assert(q350.q348EvidenceGatePresent === true, 'Q350 must preserve Q348 evidence gate');
assert(q350.q347PredictorInstantiateSmokePresent === true, 'Q350 must preserve Q347 predictor instantiate smoke');
assert(q350.q346NativeLibraryLoadSmokePresent === true, 'Q350 must preserve Q346 native load smoke');
assert(q350.q345GradleAbiPackagingBuildTrialPresent === true, 'Q350 must preserve Q345 packaging trial');
assert(q350.q344ActualBinaryBundlePresent === true, 'Q350 must preserve Q344 actual binary bundle');
assert(q350.knownUserArtifactFileName === 'inference.pdiparams', 'Q350 must record known Q315 artifact name');
assert(q350.knownUserArtifactSha256 === 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489', 'Q350 must preserve Q315 artifact SHA');
assert(q350.knownUserArtifactSizeBytes === 231675001, 'Q350 must preserve Q315 artifact size');
assert(q350.inferencePdiparamsAloneAcceptedForModelLoad === false, 'Q350 must not accept inference.pdiparams alone for model load');
assert(q350.optimizedModelEvidenceIntakeReady === true, 'Q350 must make optimized model evidence intake ready');
for (const key of [
  'optimizedModelEvidenceProvided', 'conversionLogProvided', 'convertedModelSha256Provided', 'modelLoaderPathApproved',
  'modelLoaderAvailable', 'modelLoadAttempted', 'modelLoaded', 'runtimeStartupExecuted', 'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted', 'editableMathLiveReviewOpened', 'workspaceImportExecuted', 'mainActivityChanged',
  'gradleChanged', 'pubspecChanged', 'androidManifestChanged', 'workspaceChanged', 'keyboardChanged', 'moreTemplateTrayChanged',
  'longPressChanged', 'mathLiveProductionBridgeChanged', 'graphChanged', 'solutionChanged', 'historyChanged',
  'splashChanged', 'iconChanged', 'flutterAnalyzePassClaimed', 'flutterTestPassClaimed', 'androidRealDevicePassClaimed', 'ocrPassClaimed',
]) { assert(q350[key] === false, `Q350 must keep ${key} false`); }
for (const rel of [
  'lib/features/camera/gauss_optimized_model_artifact_conversion_evidence_intake_q350_policy.dart',
  'lib/features/camera/gauss_optimized_model_artifact_conversion_evidence_intake_q350.dart',
  'test/v172_q350_optimized_model_artifact_conversion_evidence_intake_test.dart',
  'tool/verify_optimized_model_artifact_conversion_evidence_intake_v172_q350.mjs',
  'tool/prepare_pp_formulanet_s_optimized_model_intake_v172_q350.mjs',
  'tool/capture_pp_formulanet_s_optimized_model_evidence_v172_q350.mjs',
  'docs/evidence/V172_Q350_OPTIMIZED_MODEL_ARTIFACT_CONVERSION_EVIDENCE_REQUIREMENTS.json',
  'docs/audit/V172_Q350_OPTIMIZED_MODEL_ARTIFACT_CONVERSION_EVIDENCE_INTAKE_AUDIT.md',
  'docs/audit/V172_Q350_CHANGED_FILES.md',
]) { assert(exists(rel), `Q350 expected file missing: ${rel}`); }
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q350 expected bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'), 'Q350 must preserve Q347 MainActivity bridge');
assert(!mainActivity.includes('q350'), 'Q350 must not mutate MainActivity');
for (const forbidden of ['setModelFromFile', 'loadModel(', 'runInference(', 'inference.pdmodel', '.nb']) { assert(!mainActivity.includes(forbidden), `Q350 must not include model loader/runtime marker ${forbidden}`); }
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q350 must preserve Q345 jar dependency');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('Paddle'), 'Q350 must not mutate AndroidManifest for Paddle runtime');
assert(!exists('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so'), 'Q350 must not invent x86_64 optional ABI');
const forbiddenModelFiles = walk(root).filter(rel => /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q350 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !expectedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);
console.log(JSON.stringify({ phase, status: q350.status, optimizedModelEvidenceIntakeReady: q350.optimizedModelEvidenceIntakeReady, modelLoadAttempted: q350.modelLoadAttempted, modelLoaded: q350.modelLoaded, ok: true }, null, 2));
