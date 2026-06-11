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
const phase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
const sourcePhase = 'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR';
const allowedTargets = new Map([
  ['android/app/libs/PaddlePredictor.jar', { size: 9167, sha256: '81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2' }],
  ['android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so', { size: 4531976, sha256: '2eb3cd0f1d3d01c2199ee79d28f5bef7180a699f7bd9cbb183743f3031277fe2' }],
  ['android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so', { size: 2877288, sha256: '261de17f07130118962226f451a9a75aae84ff15bfe4e4b6b2ed942b5a7b121f' }],
]);

function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }
function sha256File(rel) {
  return crypto.createHash('sha256').update(fs.readFileSync(path.join(root, rel))).digest('hex');
}
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
assert([phase, 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE', 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE', 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE', 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED', 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE', q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q345, Q346, or Q347 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE', 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE', 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE', 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED', 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE', q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q345, Q346, or Q347 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.gradleAbiPackagingBuildTrialLatestPhase === phase, 'Q345 latest key missing');
const q345 = manifest.v172Q345GradleAbiPackagingBuildTrial;
assert(q345 && q345.phase === phase, 'Q345 manifest envelope missing');
assert(q345.sourcePhase === sourcePhase, 'Q345 source phase mismatch');
assert(q345.q344ActualBinaryBundlePresent === true, 'Q345 must build on Q344 actual binary bundle');
assert(q345.paddlePredictorJarDependencyDeclared === true, 'Q345 must declare PaddlePredictor jar dependency');
assert(q345.jniLibsAbiSourceSetPresent === true, 'Q345 must preserve jniLibs ABI source set');
assert(q345.nativeLibraryPackagingByAndroidGradlePluginDefaultSourceSet === true, 'Q345 must record Android Gradle Plugin jniLibs source-set packaging');
assert(q345.gradleChanged === true, 'Q345 must disclose the Gradle packaging dependency change');
for (const key of [
  'pubspecChanged', 'androidManifestChanged', 'mainActivityChanged', 'systemLoadLibraryAdded',
  'paddleLiteInstantiated', 'modelLoaderAvailable', 'runtimeStartupExecuted', 'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted', 'editableMathLiveReviewOpened', 'workspaceImportExecuted',
  'workspaceChanged', 'keyboardChanged', 'moreTemplateTrayChanged', 'longPressChanged',
  'mathLiveProductionBridgeChanged', 'graphChanged', 'solutionChanged', 'historyChanged', 'splashChanged',
  'iconChanged', 'buildTrialExecutedByAssistant', 'flutterAnalyzePassClaimed', 'flutterTestPassClaimed',
  'androidRealDevicePassClaimed', 'ocrPassClaimed',
]) {
  assert(q345[key] === false, `Q345 must keep ${key} false`);
}

const appGradle = read('android/app/build.gradle');
assert(appGradle.includes("implementation files('libs/PaddlePredictor.jar')"), 'android/app/build.gradle must declare the PaddlePredictor local jar dependency');
assert(!read('pubspec.yaml').toLowerCase().includes('paddleocr'), 'Q345 must not add Paddle OCR dependency to pubspec');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('Paddle'), 'Q345 must not mutate AndroidManifest for Paddle runtime');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'PaddleLite(', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q345 must not include runtime execution marker ${forbidden}`);
}
for (const [rel, expected] of allowedTargets.entries()) {
  assert(exists(rel), `Q345 expected bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
assert(!exists('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so'), 'Q345 must not invent x86_64 optional ABI');
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !allowedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);
for (const rel of [
  'lib/features/camera/gauss_gradle_abi_packaging_build_trial_q345_policy.dart',
  'lib/features/camera/gauss_gradle_abi_packaging_build_trial_q345.dart',
  'test/v172_q345_gradle_abi_packaging_build_trial_test.dart',
  'tool/verify_gradle_abi_packaging_build_trial_v172_q345.mjs',
  'docs/audit/V172_Q345_GRADLE_ABI_PACKAGING_BUILD_TRIAL_AUDIT.md',
  'docs/audit/V172_Q345_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q345 expected file missing: ${rel}`);
}
console.log(JSON.stringify({
  phase,
  status: q345.status,
  gradleDependencyDeclared: true,
  bundledTargets: [...allowedTargets.keys()],
  runtimeExecution: 'BLOCKED_NOT_EXECUTED',
  buildTrialExecutedByAssistant: false,
  ok: true,
}, null, 2));
