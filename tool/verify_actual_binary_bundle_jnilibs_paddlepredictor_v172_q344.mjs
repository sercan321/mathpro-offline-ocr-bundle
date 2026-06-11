#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR';
const q345SuccessorPhase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
const q346SuccessorPhase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
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
const sourcePhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
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
assert([phase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q344 or accepted Q345/Q346 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q344 or accepted Q345/Q346 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.actualBinaryBundleJniLibsPaddlePredictorLatestPhase === phase, 'Q344 latest key missing');
const q344 = manifest.v172Q344ActualBinaryBundleJniLibsPaddlePredictor;
assert(q344 && q344.phase === phase, 'Q344 manifest envelope missing');
assert(q344.sourcePhase === sourcePhase, 'Q344 source phase mismatch');
assert(q344.q328NativePackageHashEvidenceJsonAccepted === true, 'Q344 must record accepted Q328 evidence');
assert(q344.explicitUserBinaryBundleApprovalProvided === true, 'Q344 must record explicit user approval');
assert(q344.q343R2FlutterAnalyzeTestCleanUserLogProvided === true, 'Q344 must record Q343R2 clean Flutter analyze/test user log');
assert(q344.actualBinaryBundleExecuted === true, 'Q344 must execute actual binary bundle');
assert(q344.nativeLibraryBundled === true, 'Q344 must bundle native libraries');
assert(q344.jarBundled === true, 'Q344 must bundle PaddlePredictor jar');
assert(q344.jniLibsDirectoryCreated === true, 'Q344 must create jniLibs');
assert(q344.androidAppLibsDirectoryCreated === true, 'Q344 must create android/app/libs');
for (const key of [
  'gradleChanged', 'pubspecChanged', 'androidManifestChanged', 'mainActivityChanged',
  'systemLoadLibraryAdded', 'paddleLiteInstantiated', 'modelLoaderAvailable',
  'runtimeStartupExecuted', 'dummyRuntimeCallExecuted', 'realImageToLatexInferenceExecuted',
  'editableMathLiveReviewOpened', 'workspaceImportExecuted', 'workspaceChanged', 'keyboardChanged',
  'moreTemplateTrayChanged', 'longPressChanged', 'mathLiveProductionBridgeChanged', 'graphChanged',
  'solutionChanged', 'historyChanged', 'splashChanged', 'iconChanged', 'ocrPassClaimed',
  'androidRealDevicePassClaimed',
]) {
  assert(q344[key] === false, `Q344 must keep ${key} false`);
}

for (const [rel, expected] of allowedTargets.entries()) {
  assert(exists(rel), `Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
assert(!exists('android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so'), 'Q344 must not bundle x86_64 optional ABI unless explicitly supplied');
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !allowedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'PaddleLite(', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q344 must not include runtime execution marker ${forbidden}`);
}
assert(exists('docs/evidence/V172_Q344_ACCEPTED_Q328_NATIVE_LIBRARY_PACKAGE_HASH_EVIDENCE.json'), 'Q344 accepted Q328 evidence copy missing');
assert(exists('docs/evidence/V172_Q344_BUNDLED_NATIVE_BINARY_HASHES.json'), 'Q344 bundled hash evidence missing');
for (const rel of [
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_q344_policy.dart',
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_q344.dart',
  'test/v172_q344_actual_binary_bundle_jnilibs_paddlepredictor_test.dart',
  'tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_v172_q344.mjs',
  'docs/audit/V172_Q344_ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_AUDIT.md',
  'docs/audit/V172_Q344_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q344 expected file missing: ${rel}`);
}
console.log(JSON.stringify({
  phase,
  status: q344.status,
  bundledTargets: [...allowedTargets.keys()],
  runtimeExecution: 'BLOCKED_NOT_EXECUTED',
  ok: true,
}, null, 2));
