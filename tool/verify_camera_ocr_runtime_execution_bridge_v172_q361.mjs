#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const sourcePhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const q362SuccessorPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q359Phase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const onnxSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const onnxSizeBytes = 308743097;
const status = 'CAMERA_OCR_RUNTIME_EXECUTION_BRIDGE_DEFAULT_OFF_NO_AUTO_RUN_REVIEW_APPROVAL_REQUIRED';
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
assert([phase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q361 or Q362 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q361 or Q362 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.cameraOcrRuntimeExecutionBridgeLatestPhase === phase, 'Q361 latest key missing');
if ([q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) {
  assert(manifest.accuracyPerformanceMultideviceQaGuardLatestPhase === q362SuccessorPhase, 'Q361 successor Q362 latest key missing');
  assert(exists('tool/verify_accuracy_performance_multidevice_qa_guard_v172_q362.mjs'), 'Q361 successor Q362 verifier missing');
}
assert(manifest.ocrReviewApprovedImportContractLatestPhase === sourcePhase, 'Q361 must preserve Q360 latest key');
assert(manifest.firstRealImageToLatexInferenceGuardCandidateEnvelopePreflightLatestPhase === q359Phase, 'Q361 must preserve Q359 latest key');
const q361 = manifest.v172Q361CameraOcrRuntimeExecutionBridge;
assert(q361 && q361.phase === phase, 'Q361 manifest envelope missing');
assert(q361.sourcePhase === sourcePhase, 'Q361 source phase mismatch');
assert(q361.status === status, 'Q361 status mismatch');
assert(q361.selectedDependencyCoordinate === dependencyCoordinate, 'Q361 dependency coordinate mismatch');
assert(q361.expectedOnnxArtifactSha256 === onnxSha256, 'Q361 expected ONNX sha mismatch');
assert(q361.expectedOnnxArtifactSizeBytes === onnxSizeBytes, 'Q361 expected ONNX size mismatch');
for (const key of ['runtimeExecutionBridgePrepared','requiresExplicitBridgeInvocation','requiresQ357ModelLoadGuard','requiresQ358DummyRuntimeGuard','requiresQ359CandidateEnvelope','requiresQ360EditableReviewAndApprovedImportContract','cameraAutoExecutionBlocked','startupAutoExecutionBlocked','workspaceAutoExecutionBlocked','solveGraphSolutionHistoryAutoExecutionBlocked','requiresEditableMathLiveReviewBeforeImport','requiresExplicitUserApprovalBeforeWorkspaceImport','directOcrToWorkspaceImportBlocked','directOcrToSolveBlocked','directOcrToGraphBlocked','directOcrToSolutionBlocked','directOcrToHistoryBlocked']) {
  assert(q361[key] === true, `Q361 must keep ${key} true`);
}
for (const key of ['featureFlagDefaultEnabled','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelShaVerifiedOnDeviceByPackage','runtimeStartupExecuted','modelLoadAutoExecuted','modelLoadAttempted','dummyRuntimeCallAutoExecuted','dummyRuntimeCallAttempted','imageToLatexInferenceAutoExecuted','imageToLatexInferenceAttempted','imageToLatexInferenceExecuted','editableMathLiveReviewAutoOpened','editableMathLiveReviewOpened','workspaceImportExecuted','approvedWorkspaceImportExecuted','solveGraphSolutionHistoryTouched','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','workspaceChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','pubspecChanged','androidManifestChanged','gradleChanged','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','onnxRuntimeAndroidPassClaimedByPackage','modelLoadPassClaimedByPackage','dummyRuntimeCallPassClaimedByPackage','imageToLatexPassClaimedByPackage','ocrReviewPassClaimedByPackage','workspaceImportPassClaimedByPackage','ocrPassClaimed']) {
  assert(q361[key] === false, `Q361 must keep ${key} false`);
}
for (const rel of [
  'lib/features/camera/gauss_camera_ocr_runtime_execution_bridge_q361_policy.dart',
  'lib/features/camera/gauss_camera_ocr_runtime_execution_bridge_q361.dart',
  'test/v172_q361_camera_ocr_runtime_execution_bridge_test.dart',
  'tool/verify_camera_ocr_runtime_execution_bridge_v172_q361.mjs',
  'docs/audit/V172_Q361_CAMERA_OCR_RUNTIME_EXECUTION_BRIDGE_AUDIT.md',
  'docs/audit/V172_Q361_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q361 expected file missing: ${rel}`);
}
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q361 must preserve Q354 ONNX Runtime Android dependency');
assert((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q361 must keep exactly one onnxruntime-android dependency marker');
assert(!pubspec.toLowerCase().includes('onnxruntime'), 'Q361 must not add ONNX Runtime dependency to pubspec');
assert(!androidManifest.includes('ONNX'), 'Q361 must not mutate AndroidManifest for ONNX');
assert(mainActivity.includes('private val q361FeatureEnabled = false'), 'Q361 MainActivity default-off flag missing');
assert(mainActivity.includes('"cameraOcrRuntimeExecutionBridge"'), 'Q361 bridge method channel binding missing');
assert(mainActivity.includes('private fun q361CameraOcrRuntimeExecutionBridge'), 'Q361 bridge function missing');
assert(mainActivity.includes('"requiresQ360EditableReviewAndApprovedImportContract" to true'), 'Q361 must preserve Q360 review/import contract in native bridge');
assert(!mainActivity.includes('q361FeatureEnabled = true'), 'Q361 feature flag must not be enabled by package');
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q361 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q361 unexpected physical binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q361 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, runtimeExecutionBridgePrepared: q361.runtimeExecutionBridgePrepared, featureFlagDefaultEnabled: q361.featureFlagDefaultEnabled, cameraAutoExecutionBlocked: q361.cameraAutoExecutionBlocked, ocrPassClaimed: q361.ocrPassClaimed, ok: true }, null, 2));
