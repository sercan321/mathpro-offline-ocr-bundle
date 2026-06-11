#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const sourcePhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q360Phase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const q359Phase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const onnxSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const onnxSizeBytes = 308743097;
const status = 'ACCURACY_PERFORMANCE_MULTIDEVICE_QA_GUARD_STATIC_NO_RUNTIME_PASS_NO_UI_CHANGE';
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
assert([phase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q362 or Q363 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q362 or Q363 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.accuracyPerformanceMultideviceQaGuardLatestPhase === phase, 'Q362 latest key missing');
if (manifest.cameraOcrLatestPhase === q363SuccessorPhase) {
  assert(manifest.storePrivacyFinalReleaseGateLatestPhase === q363SuccessorPhase, 'Q362 successor Q363 latest key missing');
  assert(exists('tool/verify_store_privacy_final_release_gate_v172_q363.mjs'), 'Q362 successor Q363 verifier missing');
}
assert(manifest.cameraOcrRuntimeExecutionBridgeLatestPhase === sourcePhase, 'Q362 must preserve Q361 latest key');
assert(manifest.ocrReviewApprovedImportContractLatestPhase === q360Phase, 'Q362 must preserve Q360 latest key');
assert(manifest.firstRealImageToLatexInferenceGuardCandidateEnvelopePreflightLatestPhase === q359Phase, 'Q362 must preserve Q359 latest key');
const q362 = manifest.v172Q362AccuracyPerformanceMultideviceQaGuard;
assert(q362 && q362.phase === phase, 'Q362 manifest envelope missing');
assert(q362.sourcePhase === sourcePhase, 'Q362 source phase mismatch');
assert(q362.status === status, 'Q362 status mismatch');
assert(q362.selectedDependencyCoordinate === dependencyCoordinate, 'Q362 dependency coordinate mismatch');
assert(q362.expectedOnnxArtifactSha256 === onnxSha256, 'Q362 expected ONNX sha mismatch');
assert(q362.expectedOnnxArtifactSizeBytes === onnxSizeBytes, 'Q362 expected ONNX size mismatch');

for (const key of ['accuracyQaGuardPrepared','candidateRankingGuardPrepared','performanceQaGuardPrepared','multiDeviceQaGuardPrepared','requiresReviewedCandidateEnvelope','requiresEditableMathLiveReviewBeforeImport','requiresExplicitUserApprovalBeforeWorkspaceImport','requiresRealDeviceEvidenceBeforePass','requiresLatencyMemoryThermalEvidenceBeforePass','requiresMultiDeviceEvidenceBeforePass','cameraAutoExecutionBlocked','runtimeAutoExecutionBlocked','workspaceAutoImportBlocked','solveGraphSolutionHistoryAutoExecutionBlocked','directOcrToWorkspaceImportBlocked','directOcrToSolveBlocked','directOcrToGraphBlocked','directOcrToSolutionBlocked','directOcrToHistoryBlocked']) {
  assert(q362[key] === true, `Q362 must keep ${key} true`);
}
for (const key of ['featureFlagDefaultEnabled','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelShaVerifiedOnDeviceByPackage','runtimeStartupExecuted','modelLoadExecuted','dummyRuntimeCallExecuted','imageToLatexInferenceExecuted','ocrReviewOpened','workspaceImportExecuted','approvedWorkspaceImportExecuted','solveGraphSolutionHistoryTouched','accuracyPassClaimed','performancePassClaimed','latencyPassClaimed','memoryPassClaimed','thermalPassClaimed','multiDevicePassClaimed','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','onnxRuntimeAndroidPassClaimedByPackage','modelLoadPassClaimedByPackage','dummyRuntimeCallPassClaimedByPackage','imageToLatexPassClaimedByPackage','ocrReviewPassClaimedByPackage','workspaceImportPassClaimedByPackage','ocrPassClaimed','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','workspaceChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','pubspecChanged','androidManifestChanged','gradleChanged','mainActivityChanged']) {
  assert(q362[key] === false, `Q362 must keep ${key} false`);
}

for (const rel of [
  'lib/features/camera/gauss_accuracy_performance_multidevice_qa_guard_q362_policy.dart',
  'lib/features/camera/gauss_accuracy_performance_multidevice_qa_guard_q362.dart',
  'test/v172_q362_accuracy_performance_multidevice_qa_guard_test.dart',
  'tool/verify_accuracy_performance_multidevice_qa_guard_v172_q362.mjs',
  'docs/audit/V172_Q362_ACCURACY_PERFORMANCE_MULTIDEVICE_QA_GUARD_AUDIT.md',
  'docs/audit/V172_Q362_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q362 expected file missing: ${rel}`);
}

const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q362 must preserve Q354 ONNX Runtime Android dependency');
assert((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q362 must keep exactly one onnxruntime-android dependency marker');
assert(!pubspec.toLowerCase().includes('onnxruntime'), 'Q362 must not add ONNX Runtime dependency to pubspec');
assert(!androidManifest.includes('ONNX'), 'Q362 must not mutate AndroidManifest for ONNX');
assert(mainActivity.includes('private val q361FeatureEnabled = false'), 'Q362 must preserve Q361 bridge default-off flag');
assert(mainActivity.includes('cameraOcrRuntimeExecutionBridge'), 'Q362 must preserve Q361 bridge method');
assert(!mainActivity.includes('q362FeatureEnabled'), 'Q362 must not add native feature flag');
assert(!mainActivity.includes('accuracyPerformanceMultideviceQa'), 'Q362 must not add native QA bridge');

const expectedTargets = new Map([
  ['android/app/libs/PaddlePredictor.jar', { size: 9167, sha256: '81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2' }],
  ['android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so', { size: 4531976, sha256: '2eb3cd0f1d3d01c2199ee79d28f5bef7180a699f7bd9cbb183743f3031277fe2' }],
  ['android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so', { size: 2877288, sha256: '261de17f07130118962226f451a9a75aae84ff15bfe4e4b6b2ed942b5a7b121f' }],
]);
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q362 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q362 unexpected physical binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q362 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, accuracyQaGuardPrepared: q362.accuracyQaGuardPrepared, performanceQaGuardPrepared: q362.performanceQaGuardPrepared, multiDeviceQaGuardPrepared: q362.multiDeviceQaGuardPrepared, ocrPassClaimed: q362.ocrPassClaimed, ok: true }, null, 2));
