#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
const q347SuccessorPhase = 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE';
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
const sourcePhase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
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
assert([phase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q346 or Q347 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q346 or Q347 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativeLibraryLoadSmokeLatestPhase === phase, 'Q346 latest key missing');
const q346 = manifest.v172Q346NativeLibraryLoadSmoke;
assert(q346 && q346.phase === phase, 'Q346 manifest envelope missing');
assert(q346.sourcePhase === sourcePhase, 'Q346 source phase mismatch');
assert(q346.q345GradleAbiPackagingBuildTrialPresent === true, 'Q346 must build on Q345 packaging trial');
assert(q346.q344ActualBinaryBundlePresent === true, 'Q346 must preserve Q344 actual binary bundle');
assert(q346.methodName === 'nativeLibraryLoadSmoke', 'Q346 bridge method mismatch');
assert(q346.paddleLiteNativeLibraryName === 'paddle_lite_jni', 'Q346 native library name mismatch');
assert(q346.nativeLibraryLoadSmokeBridgeAdded === true, 'Q346 load smoke bridge must be added');
assert(q346.nativeLibraryLoadFeatureDefaultEnabled === false, 'Q346 feature flag must be default-off');
assert(q346.automaticStartupLoad === false, 'Q346 must not auto-load native library at startup');
assert(q346.assistantExecutedNativeLoadSmoke === false, 'Q346 assistant must not claim load smoke execution');
assert(q346.nativeLibraryLoadAttemptedByAssistant === false, 'Q346 must not claim native load attempt by assistant');
assert(q346.nativeLibraryLoadSucceededClaimed === false, 'Q346 must not claim native load success');
assert(q346.mainActivityChanged === true, 'Q346 must disclose MainActivity change');
for (const key of [
  'gradleChanged', 'pubspecChanged', 'androidManifestChanged', 'workspaceChanged', 'keyboardChanged',
  'moreTemplateTrayChanged', 'longPressChanged', 'mathLiveProductionBridgeChanged', 'graphChanged',
  'solutionChanged', 'historyChanged', 'splashChanged', 'iconChanged', 'paddleLiteInstantiated',
  'modelLoaderAvailable', 'modelLoaded', 'runtimeStartupExecuted', 'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted', 'editableMathLiveReviewOpened', 'workspaceImportExecuted',
  'flutterAnalyzePassClaimed', 'flutterTestPassClaimed', 'androidRealDevicePassClaimed', 'ocrPassClaimed',
]) {
  assert(q346[key] === false, `Q346 must keep ${key} false`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes('private val q346Phase = "V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE"'), 'MainActivity missing Q346 phase');
assert(mainActivity.includes('private val q346FeatureEnabled = false'), 'MainActivity Q346 feature flag must be false');
assert(mainActivity.includes('"nativeLibraryLoadSmoke" -> result.success(q346NativeLibraryLoadSmoke(call.method))'), 'MainActivity missing Q346 bridge routing');
assert(mainActivity.includes('private fun q346NativeLibraryLoadSmoke(method: String): Map<String, Any>'), 'MainActivity missing Q346 bridge function');
assert(mainActivity.includes('getDeclaredMethod("loadLibrary", String::class.java)'), 'Q346 guarded load smoke must target JVM loadLibrary only behind default-off flag');
assert(mainActivity.includes('"automaticStartupLoad" to false'), 'Q346 must declare no automatic startup load');
assert(mainActivity.includes('"assistantExecutedNativeLoadSmoke" to false'), 'Q346 must not claim assistant-side execution');
for (const forbidden of ['PaddlePredictor(', 'PaddleLite(', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q346 must not include runtime execution marker ${forbidden}`);
}
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q346 must preserve Q345 jar dependency');
assert(!read('pubspec.yaml').toLowerCase().includes('paddleocr'), 'Q346 must not add Paddle OCR dependency to pubspec');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('Paddle'), 'Q346 must not mutate AndroidManifest for Paddle runtime');
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q346 expected bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
assert(!exists('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so'), 'Q346 must not invent x86_64 optional ABI');
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !expectedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);
for (const rel of [
  'lib/features/camera/gauss_native_library_load_smoke_q346_policy.dart',
  'lib/features/camera/gauss_native_library_load_smoke_q346.dart',
  'test/v172_q346_native_library_load_smoke_test.dart',
  'tool/verify_native_library_load_smoke_v172_q346.mjs',
  'docs/audit/V172_Q346_NATIVE_LIBRARY_LOAD_SMOKE_AUDIT.md',
  'docs/audit/V172_Q346_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q346 expected file missing: ${rel}`);
}
console.log(JSON.stringify({
  phase,
  status: q346.status,
  bridgeMethod: q346.methodName,
  nativeLibraryLoadFeatureDefaultEnabled: q346.nativeLibraryLoadFeatureDefaultEnabled,
  automaticStartupLoad: q346.automaticStartupLoad,
  assistantExecutedNativeLoadSmoke: q346.assistantExecutedNativeLoadSmoke,
  bundledTargets: [...expectedTargets.keys()],
  runtimeExecution: 'BLOCKED_NOT_EXECUTED_BY_DEFAULT',
  ok: true,
}, null, 2));
