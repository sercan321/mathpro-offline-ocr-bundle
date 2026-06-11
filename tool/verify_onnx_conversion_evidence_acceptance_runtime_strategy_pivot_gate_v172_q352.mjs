#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
const sourcePhase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
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
assert([phase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q352 or Q353 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q352 or Q353 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.onnxConversionEvidenceAcceptanceRuntimeStrategyPivotGateLatestPhase === phase, 'Q352 latest key missing');
const q352 = manifest.v172Q352OnnxConversionEvidenceAcceptanceRuntimeStrategyPivotGate;
assert(q352 && q352.phase === phase, 'Q352 manifest envelope missing');
assert(q352.sourcePhase === sourcePhase, 'Q352 source phase mismatch');
for (const key of ['q351RealModelLoadUnlockGatePresent','q351R2FlutterRunKotlinBuildHelperRepairPresent','q344PaddleLiteBinaryBundlePreserved','officialPpFormulanetSModelDownloaded','onnxConversionEvidenceAccepted','onnxArtifactStoredOutsideProjectRoot','paddleLiteModelLoadStillBlocked','paddleLiteRuntimeParked','onnxRuntimeMobileCandidateOpened']) {
  assert(q352[key] === true, `Q352 must keep ${key} true`);
}
assert(q352.onnxArtifactFileName === 'pp_formulanet_s.onnx', 'Q352 ONNX filename mismatch');
assert(q352.onnxArtifactSha256 === '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a', 'Q352 ONNX sha mismatch');
assert(q352.onnxArtifactSizeBytes === 308743097, 'Q352 ONNX size mismatch');
assert(q352.conversionPaddleVersion === '3.0.0.dev20250426', 'Q352 conversion Paddle version mismatch');
assert(q352.conversionPaddle2OnnxVersion === '2.1.0', 'Q352 conversion Paddle2ONNX version mismatch');
assert(q352.conversionModelFilename === 'inference.json', 'Q352 conversion model filename mismatch');
assert(q352.conversionParamsFilename === 'inference.pdiparams', 'Q352 conversion params filename mismatch');
assert(q352.conversionRequestedOpset === '11', 'Q352 requested opset mismatch');
assert(q352.conversionObservedOpset === '18', 'Q352 observed opset mismatch');
for (const key of ['paddleLiteNbArtifactAvailable','onnxRuntimeDependencyAdded','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelLoadAttempted','onnxModelLoaded','runtimeStartupExecuted','dummyRuntimeCallExecuted','realImageToLatexInferenceExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','mainActivityChanged','gradleChanged','pubspecChanged','androidManifestChanged','workspaceChanged','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','ocrPassClaimed']) {
  assert(q352[key] === false, `Q352 must keep ${key} false`);
}
for (const rel of [
  'lib/features/camera/gauss_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_q352_policy.dart',
  'lib/features/camera/gauss_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_q352.dart',
  'test/v172_q352_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_test.dart',
  'tool/verify_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_v172_q352.mjs',
  'tool/capture_pp_formulanet_s_onnx_artifact_evidence_v172_q352.mjs',
  'docs/evidence/V172_Q352_ONNX_CONVERSION_EVIDENCE.json',
  'docs/audit/V172_Q352_ONNX_CONVERSION_EVIDENCE_ACCEPTANCE_RUNTIME_STRATEGY_PIVOT_GATE_AUDIT.md',
  'docs/audit/V172_Q352_CHANGED_FILES.md',
]) { assert(exists(rel), `Q352 expected file missing: ${rel}`); }
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q352 expected bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes('private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"'), 'Q352 must preserve Q347 bridge state');
if (![q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) for (const forbidden of ['OrtEnvironment', 'onnxruntime', 'OnnxTensor', 'setModelFromFile', 'loadModel(', 'runInference(', 'pp_formulanet_s.onnx']) {
  assert(!mainActivity.includes(forbidden), `Q352 must not include runtime/model-load marker ${forbidden}`);
}
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q352 must preserve Q345 jar dependency');
if ([q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) {
  assert(read('android/app/build.gradle').includes("implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0'"), 'Q352 successor Q354 must contain selected ONNX Runtime dependency');
} else {
  assert(!read('android/app/build.gradle').toLowerCase().includes('onnxruntime'), 'Q352 must not add ONNX Runtime dependency yet');
}
assert(!read('pubspec.yaml').toLowerCase().includes('onnx'), 'Q352 must not add ONNX dependency to pubspec');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('ONNX'), 'Q352 must not mutate AndroidManifest for ONNX runtime');
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q352 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
const binaryArtifacts = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel));
const unexpected = binaryArtifacts.filter(rel => !expectedTargets.has(rel));
assert(unexpected.length === 0, `Unexpected native binary artifacts: ${unexpected.join(', ')}`);
console.log(JSON.stringify({ phase, status: q352.status, onnxArtifactSha256: q352.onnxArtifactSha256, onnxRuntimeMobileCandidateOpened: q352.onnxRuntimeMobileCandidateOpened, onnxModelLoadAttempted: q352.onnxModelLoadAttempted, ocrPassClaimed: q352.ocrPassClaimed, ok: true }, null, 2));
