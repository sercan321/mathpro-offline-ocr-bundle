#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
const sourcePhase = 'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
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
const q352Phase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
const hygieneSourcePhase = 'V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR';
const status = 'ONNX_RUNTIME_ANDROID_DEPENDENCY_ADDED_FOR_ABI_BUILD_TRIAL_DEFAULT_OFF_NO_MODEL_LOAD_NO_OCR';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const onnxSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const onnxSizeBytes = 308743097;
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
assert([phase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q354 or Q355 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q354 or Q355 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.onnxRuntimeAndroidDependencyAbiBuildTrialLatestPhase === phase, 'Q354 latest key missing');
if ([q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) {
  assert(manifest.onnxModelPrivateStorageShaVerificationLatestPhase === q355SuccessorPhase, 'Q354 successor Q355 latest key missing');
  assert(fs.existsSync(path.join(root, 'tool/verify_onnx_model_private_storage_sha_verification_v172_q355.mjs')), 'Q354 successor Q355 verifier missing');
}
assert(manifest.onnxRuntimeMobileDependencyFeasibilityGateLatestPhase === sourcePhase, 'Q354 must preserve Q353 latest key');
assert(manifest.onnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateLatestPhase === q352Phase, 'Q354 must preserve Q352 latest key');
assert(manifest.legacyVerifierSuccessorAwarenessHygieneRepairLatestPhase === hygieneSourcePhase, 'Q354 must preserve Q352R1 latest key');
const q354 = manifest.v172Q354OnnxRuntimeAndroidDependencyAbiBuildTrial;
assert(q354 && q354.phase === phase, 'Q354 manifest envelope missing');
assert(q354.sourcePhase === sourcePhase, 'Q354 source phase mismatch');
assert(q354.status === status, 'Q354 status mismatch');
assert(q354.selectedDependencyCoordinate === dependencyCoordinate, 'Q354 dependency coordinate mismatch');
for (const key of ['q353FeasibilityGateAccepted','q352OnnxConversionEvidenceAccepted','q352R1LegacyVerifierHygienePresent','q344PaddleLiteBinaryBundlePreserved','dependencyCoordinateSelected','onnxRuntimeDependencyAdded','androidAbiBuildTrialPrepared','userSideAndroidBuildEvidenceRequired']) {
  assert(q354[key] === true, `Q354 must keep ${key} true`);
}
assert(q354.gradleChanged === true, 'Q354 must record Gradle changed for dependency trial');
assert(q354.onnxArtifactSha256 === onnxSha256, 'Q354 ONNX sha mismatch');
assert(q354.onnxArtifactSizeBytes === onnxSizeBytes, 'Q354 ONNX size mismatch');
for (const key of ['assistantSideAndroidBuildExecuted','apkAabSizeImpactMeasuredByAssistant','abiInventoryResolvedByAssistant','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelLoadAttempted','onnxModelLoaded','runtimeStartupExecuted','dummyRuntimeCallExecuted','realImageToLatexInferenceExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','solveGraphSolutionHistoryTouched','mainActivityChanged','pubspecChanged','androidManifestChanged','workspaceChanged','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','ocrPassClaimed']) {
  assert(q354[key] === false, `Q354 must keep ${key} false`);
}
for (const rel of [
  'lib/features/camera/gauss_onnx_runtime_android_dependency_abi_build_trial_q354_policy.dart',
  'lib/features/camera/gauss_onnx_runtime_android_dependency_abi_build_trial_q354.dart',
  'test/v172_q354_onnx_runtime_android_dependency_abi_build_trial_test.dart',
  'tool/verify_onnx_runtime_android_dependency_abi_build_trial_v172_q354.mjs',
  'docs/audit/V172_Q354_ONNX_RUNTIME_ANDROID_DEPENDENCY_ABI_BUILD_TRIAL_AUDIT.md',
  'docs/audit/V172_Q354_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q354 expected file missing: ${rel}`);
}
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(buildGradle.includes("implementation files('libs/PaddlePredictor.jar')"), 'Q354 must preserve Q345 jar dependency');
assert(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q354 must add selected ONNX Runtime Android dependency');
assert((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q354 must add exactly one onnxruntime-android dependency marker');
assert(!pubspec.toLowerCase().includes('onnxruntime'), 'Q354 must not add ONNX Runtime dependency to pubspec');
assert(!pubspec.toLowerCase().includes('onnx:'), 'Q354 must not add ONNX dependency to pubspec');
assert(!androidManifest.includes('ONNX'), 'Q354 must not mutate AndroidManifest for ONNX');
assert(mainActivity.includes('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'), 'Q354 must preserve Q347 bridge state');
if (![q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) for (const forbidden of ['OrtEnvironment', 'OnnxTensor', 'OnnxValue', 'ai.onnxruntime', 'setModelFromFile', 'loadModel(', 'runInference(', 'pp_formulanet_s.onnx']) {
  assert(!mainActivity.includes(forbidden), `Q354 must not include runtime/model-load marker ${forbidden}`);
}
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q354 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q354 unexpected physical binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q354 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, selectedDependencyCoordinate: q354.selectedDependencyCoordinate, onnxRuntimeDependencyAdded: q354.onnxRuntimeDependencyAdded, assistantSideAndroidBuildExecuted: q354.assistantSideAndroidBuildExecuted, modelLoadAttempted: q354.onnxModelLoadAttempted, ocrPassClaimed: q354.ocrPassClaimed, ok: true }, null, 2));
