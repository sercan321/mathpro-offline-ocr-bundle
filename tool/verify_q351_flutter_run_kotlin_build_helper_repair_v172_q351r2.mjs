#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q351R2-FLUTTER-RUN-KOTLIN_BUILD_HELPER_REPAIR';
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
assert([preserved, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), 'Q351R2 must preserve or accept Q352 successor cameraOcrLatestPhase');
assert([preserved, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), 'Q351R2 must preserve or accept Q352 successor activeProductDevelopmentLatestPhase');
assert(manifest.q351R2FlutterRunKotlinBuildHelperRepairLatestPhase === phase, 'Q351R2 latest marker missing');
const q351r2 = manifest.v172Q351R2FlutterRunKotlinBuildHelperRepair;
assert(q351r2 && q351r2.phase === phase, 'Q351R2 manifest envelope missing');
assert(q351r2.kotlinBuildHelperRepair === true, 'Q351R2 must record Kotlin build helper repair');
assert(q351r2.mainActivityChanged === true, 'Q351R2 must disclose MainActivity change');
for (const key of ['gradleChanged','pubspecChanged','androidManifestChanged','systemLoadLibraryAdded','paddleLiteInstantiated','modelLoadAttempted','modelLoaded','runtimeStartupExecuted','realImageToLatexInferenceExecuted','ocrPassClaimed','androidRealDevicePassClaimed']) assert(q351r2[key] === false, `${key} must remain false`);
const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(main.includes('private fun q318PrivateModelStorageRoot(): File'), 'missing q318PrivateModelStorageRoot helper');
assert(main.includes('private fun q318PrivateModelArtifactFile(): File'), 'missing q318PrivateModelArtifactFile helper');
assert(main.includes('File(filesDir, q318PrivateModelDirectoryName)'), 'storage helper must use app-private filesDir root');
assert(main.includes('File(q318PrivateModelStorageRoot(), q318PrivateModelArtifactFileName)'), 'artifact helper must use storage root helper');
assert(!main.includes('setModelFromFile'), 'must not add model loader');
assert(!main.includes('runInference('), 'must not add inference');
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q345 jar dependency must be preserved');
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
console.log(JSON.stringify({ phase, preservedCameraOcrLatestPhase: preserved, kotlinBuildHelperRepair: true, mainActivityChanged: true, ok: true }, null, 2));
