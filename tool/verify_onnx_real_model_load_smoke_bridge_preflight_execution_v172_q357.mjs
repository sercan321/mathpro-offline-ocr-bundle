#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
const q358SuccessorPhase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
const q359SuccessorPhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const q360SuccessorPhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const q361SuccessorPhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q362SuccessorPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q366SuccessorPhase = 'V172-Q366-ONNX-DUMMY-INPUT-RUNTIME-CALL-EXECUTION';
const sourcePhase = 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const onnxSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const onnxSizeBytes = 308743097;
const status = 'ONNX_REAL_MODEL_LOAD_SMOKE_BRIDGE_PRESENT_DEFAULT_OFF_NO_AUTO_EXECUTION_NO_OCR';
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
assert([phase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q357 or Q358 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q357 or Q358 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.onnxRealModelLoadSmokeBridgePreflightExecutionLatestPhase === phase, 'Q357 latest key missing');
if (manifest.cameraOcrLatestPhase === q358SuccessorPhase) {
  assert(manifest.onnxDummyInputRuntimeCallGuardPreflightLatestPhase === q358SuccessorPhase, 'Q357 successor Q358 latest key missing');
  assert(exists('tool/verify_onnx_dummy_input_runtime_call_guard_preflight_v172_q358.mjs'), 'Q357 successor Q358 verifier missing');
}
assert(manifest.onnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardLatestPhase === sourcePhase, 'Q357 must preserve Q356R2 latest key');
const q357 = manifest.v172Q357OnnxRealModelLoadSmokeBridgePreflightExecution;
assert(q357 && q357.phase === phase, 'Q357 manifest envelope missing');
assert(q357.sourcePhase === sourcePhase, 'Q357 source phase mismatch');
assert(q357.status === status, 'Q357 status mismatch');
assert(q357.selectedDependencyCoordinate === dependencyCoordinate, 'Q357 dependency coordinate mismatch');
assert(q357.expectedOnnxArtifactSha256 === onnxSha256, 'Q357 expected ONNX sha mismatch');
assert(q357.expectedOnnxArtifactSizeBytes === onnxSizeBytes, 'Q357 expected ONNX size mismatch');
for (const key of ['defaultOffBridgePresent','mainActivityChangedForBridgeOnly','runtimeClassReferencesAdded','requiresExplicitBridgeInvocation','modelLoadRequiresPrivateStorageArtifact','modelLoadRequiresExactSize','modelLoadRequiresExactSha256']) {
  assert(q357[key] === true, `Q357 must keep ${key} true`);
}
for (const key of ['modelLoadAutoExecuted','startupModelLoadExecuted','cameraFlowModelLoadExecuted','workspaceFlowModelLoadExecuted','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelShaVerifiedOnDeviceByPackage','runtimeStartupExecuted','dummyRuntimeCallExecuted','realImageToLatexInferenceExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','solveGraphSolutionHistoryTouched','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','workspaceChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','pubspecChanged','androidManifestChanged','gradleChanged','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','onnxRuntimeAndroidPassClaimedByPackage','modelLoadPassClaimedByPackage','ocrPassClaimed']) {
  assert(q357[key] === false, `Q357 must keep ${key} false`);
}
for (const rel of [
  'lib/features/camera/gauss_onnx_real_model_load_smoke_bridge_preflight_execution_q357_policy.dart',
  'lib/features/camera/gauss_onnx_real_model_load_smoke_bridge_preflight_execution_q357.dart',
  'test/v172_q357_onnx_real_model_load_smoke_bridge_preflight_execution_test.dart',
  'tool/verify_onnx_real_model_load_smoke_bridge_preflight_execution_v172_q357.mjs',
  'docs/audit/V172_Q357_ONNX_REAL_MODEL_LOAD_SMOKE_BRIDGE_PREFLIGHT_EXECUTION_AUDIT.md',
  'docs/audit/V172_Q357_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q357 expected file missing: ${rel}`);
}
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q357 must preserve Q354 ONNX Runtime Android dependency');
assert((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q357 must keep exactly one onnxruntime-android dependency marker');
assert(!pubspec.toLowerCase().includes('onnxruntime'), 'Q357 must not add ONNX Runtime dependency to pubspec');
assert(!androidManifest.includes('ONNX'), 'Q357 must not mutate AndroidManifest for ONNX');
for (const required of [
  'import ai.onnxruntime.OrtEnvironment',
  'import ai.onnxruntime.OrtSession',
  'private val q357FeatureEnabled = false',
  'private val q357OnnxModelFileName = "pp_formulanet_s.onnx"',
  'private val q357ExpectedOnnxSha256 = "' + onnxSha256 + '"',
  'private val q357ExpectedOnnxSizeBytes = 308743097L',
  '"onnxRealModelLoadSmoke" -> result.success(q357OnnxRealModelLoadSmoke(call.method))',
  'private fun q357OnnxRealModelLoadSmoke(method: String): Map<String, Any>',
  'OrtEnvironment.getEnvironment()',
  'environment.createSession(modelFile.absolutePath, sessionOptions)',
  'default-off-feature-flag-disabled',
  'realImageToLatexInferenceExecuted" to false',
  'workspaceImportExecuted" to false',
  'ocrPassClaimed" to false',
]) {
  assert(mainActivity.includes(required), `Q357 MainActivity required marker missing: ${required}`);
}
const q366OrLaterDummyRuntimeExecutionInstalled = manifest.onnxDummyInputRuntimeCallExecutionLatestPhase === q366SuccessorPhase;
const q357ForbiddenRuntimeMarkers = q366OrLaterDummyRuntimeExecutionInstalled
  ? ['runInference(', 'realImageToLatexInferencePassed" to true', 'workspaceImportExecuted" to true', 'ocrPassClaimed" to true']
  : ['OnnxTensor', 'runInference(', 'realImageToLatexInferencePassed" to true', 'workspaceImportExecuted" to true', 'ocrPassClaimed" to true'];
for (const forbidden of q357ForbiddenRuntimeMarkers) {
  assert(!mainActivity.includes(forbidden), `Q357 must not include forbidden marker ${forbidden}`);
}
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q357 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q357 unexpected physical binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q357 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, defaultOffBridgePresent: q357.defaultOffBridgePresent, mainActivityChangedForBridgeOnly: q357.mainActivityChangedForBridgeOnly, modelLoadAutoExecuted: q357.modelLoadAutoExecuted, modelLoadPassClaimed: q357.modelLoadPassClaimedByPackage, ocrPassClaimed: q357.ocrPassClaimed, ok: true }, null, 2));
