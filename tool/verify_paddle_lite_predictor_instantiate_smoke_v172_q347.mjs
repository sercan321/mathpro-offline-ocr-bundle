#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE';
const sourcePhase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
const q348SuccessorPhase = 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE';
const q349SuccessorPhase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
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
assert([phase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q347 or Q348 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q347 or Q348 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.paddleLitePredictorInstantiateSmokeLatestPhase === phase, 'Q347 latest key missing');
const q347 = manifest.v172Q347PaddleLitePredictorInstantiateSmoke;
assert(q347 && q347.phase === phase, 'Q347 manifest envelope missing');
assert(q347.sourcePhase === sourcePhase, 'Q347 source phase mismatch');
assert(q347.q346NativeLibraryLoadSmokePresent === true, 'Q347 must build on Q346 native load smoke');
assert(q347.q345GradleAbiPackagingBuildTrialPresent === true, 'Q347 must preserve Q345 packaging trial');
assert(q347.q344ActualBinaryBundlePresent === true, 'Q347 must preserve Q344 actual binary bundle');
assert(q347.methodName === 'paddleLitePredictorInstantiateSmoke', 'Q347 bridge method mismatch');
assert(q347.paddleLitePredictorClassName === 'com.baidu.paddle.lite.PaddlePredictor', 'Q347 predictor class mismatch');
assert(q347.paddleLiteConfigClassName === 'com.baidu.paddle.lite.MobileConfig', 'Q347 config class mismatch');
assert(q347.paddleLiteCreatePredictorMethodName === 'createPaddlePredictor', 'Q347 create method mismatch');
assert(q347.predictorInstantiateSmokeBridgeAdded === true, 'Q347 instantiate smoke bridge must be added');
assert(q347.predictorInstantiateFeatureDefaultEnabled === false, 'Q347 feature flag must be default-off');
assert(q347.automaticStartupInstantiate === false, 'Q347 must not auto-instantiate at startup');
assert(q347.assistantExecutedPredictorInstantiateSmoke === false, 'Q347 assistant must not claim instantiate smoke execution');
assert(q347.predictorInstantiateAttemptedByAssistant === false, 'Q347 assistant must not claim predictor instantiate attempt');
assert(q347.predictorInstantiateSucceededClaimed === false, 'Q347 assistant must not claim predictor instantiate success');
assert(q347.nativeLibraryLoadSmokeRequiredBeforeInstantiate === true, 'Q347 must require Q346 native load smoke before predictor instantiate');
assert(q347.mainActivityChanged === true, 'Q347 must disclose MainActivity change');
for (const key of [
  'gradleChanged', 'pubspecChanged', 'androidManifestChanged', 'workspaceChanged', 'keyboardChanged',
  'moreTemplateTrayChanged', 'longPressChanged', 'mathLiveProductionBridgeChanged', 'graphChanged',
  'solutionChanged', 'historyChanged', 'splashChanged', 'iconChanged', 'paddleLiteInstantiated',
  'modelLoaderAvailable', 'modelLoaded', 'runtimeStartupExecuted', 'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted', 'editableMathLiveReviewOpened', 'workspaceImportExecuted',
  'flutterAnalyzePassClaimed', 'flutterTestPassClaimed', 'androidRealDevicePassClaimed', 'ocrPassClaimed',
]) {
  assert(q347[key] === false, `Q347 must keep ${key} false`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'), 'MainActivity missing Q347 phase');
assert(mainActivity.includes('private val q347FeatureEnabled = false'), 'MainActivity Q347 feature flag must be false');
assert(mainActivity.includes('"paddleLitePredictorInstantiateSmoke" -> result.success(q347PaddleLitePredictorInstantiateSmoke(call.method))'), 'MainActivity missing Q347 bridge routing');
assert(mainActivity.includes('private fun q347PaddleLitePredictorInstantiateSmoke(method: String): Map<String, Any>'), 'MainActivity missing Q347 bridge function');
assert(mainActivity.includes('q347PredictorClassName = "com.baidu.paddle.lite.Paddle" + "Predictor"'), 'Q347 must use reflection-safe predictor class spelling');
assert(mainActivity.includes('q347ConfigClassName = "com.baidu.paddle.lite.Mobile" + "Config"'), 'Q347 must use reflection-safe config class spelling');
assert(mainActivity.includes('q347CreatePredictorMethodName = "create" + "Paddle" + "Predictor"'), 'Q347 must use reflection-safe create method spelling');
assert(mainActivity.includes('getDeclaredMethod(q347CreatePredictorMethodName, configBaseClass)'), 'Q347 must use reflective create predictor smoke only');
assert(mainActivity.includes('"automaticStartupInstantiate" to false'), 'Q347 must declare no automatic startup instantiate');
assert(mainActivity.includes('"assistantExecutedPredictorInstantiateSmoke" to false'), 'Q347 must not claim assistant-side execution');
for (const forbidden of ['PaddlePredictor(', 'MobileConfig', 'PaddleLite(', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q347 must not include forbidden direct runtime marker ${forbidden}`);
}
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q347 must preserve Q345 jar dependency');
assert(!read('pubspec.yaml').toLowerCase().includes('paddleocr'), 'Q347 must not add Paddle OCR dependency to pubspec');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('Paddle'), 'Q347 must not mutate AndroidManifest for Paddle runtime');
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q347 expected bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
assert(!exists('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so'), 'Q347 must not invent x86_64 optional ABI');
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !expectedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);
for (const rel of [
  'lib/features/camera/gauss_paddle_lite_predictor_instantiate_smoke_q347_policy.dart',
  'lib/features/camera/gauss_paddle_lite_predictor_instantiate_smoke_q347.dart',
  'test/v172_q347_paddle_lite_predictor_instantiate_smoke_test.dart',
  'tool/verify_paddle_lite_predictor_instantiate_smoke_v172_q347.mjs',
  'docs/audit/V172_Q347_PADDLE_LITE_PREDICTOR_INSTANTIATE_SMOKE_AUDIT.md',
  'docs/audit/V172_Q347_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q347 expected file missing: ${rel}`);
}
console.log(JSON.stringify({
  phase,
  status: q347.status,
  bridgeMethod: q347.methodName,
  predictorInstantiateFeatureDefaultEnabled: q347.predictorInstantiateFeatureDefaultEnabled,
  automaticStartupInstantiate: q347.automaticStartupInstantiate,
  assistantExecutedPredictorInstantiateSmoke: q347.assistantExecutedPredictorInstantiateSmoke,
  bundledTargets: [...expectedTargets.keys()],
  runtimeExecution: 'BLOCKED_NOT_EXECUTED_BY_DEFAULT',
  ok: true,
}, null, 2));
