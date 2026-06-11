#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const sourcePhase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
const q360SuccessorPhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const q361SuccessorPhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q362SuccessorPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q357SourcePhase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const onnxSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const onnxSizeBytes = 308743097;
const status = 'FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_GUARD_CANDIDATE_ENVELOPE_PREFLIGHT_DEFAULT_OFF_NO_OCR';
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
assert([phase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q359 or Q360 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q359 or Q360 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.firstRealImageToLatexInferenceGuardCandidateEnvelopePreflightLatestPhase === phase, 'Q359 latest key missing');
if (manifest.cameraOcrLatestPhase === q360SuccessorPhase) {
  assert(manifest.ocrReviewApprovedImportContractLatestPhase === q360SuccessorPhase, 'Q359 successor Q360 latest key missing');
  assert(exists('tool/verify_ocr_review_approved_import_contract_v172_q360.mjs'), 'Q359 successor Q360 verifier missing');
}
assert(manifest.onnxDummyInputRuntimeCallGuardPreflightLatestPhase === sourcePhase, 'Q359 must preserve Q358 latest key');
assert(manifest.onnxRealModelLoadSmokeBridgePreflightExecutionLatestPhase === q357SourcePhase, 'Q359 must preserve Q357 latest key');
const q359 = manifest.v172Q359FirstRealImageToLatexInferenceGuardCandidateEnvelopePreflight;
assert(q359 && q359.phase === phase, 'Q359 manifest envelope missing');
assert(q359.sourcePhase === sourcePhase, 'Q359 source phase mismatch');
assert(q359.status === status, 'Q359 status mismatch');
assert(q359.selectedDependencyCoordinate === dependencyCoordinate, 'Q359 dependency coordinate mismatch');
assert(q359.expectedOnnxArtifactSha256 === onnxSha256, 'Q359 expected ONNX sha mismatch');
assert(q359.expectedOnnxArtifactSizeBytes === onnxSizeBytes, 'Q359 expected ONNX size mismatch');
for (const key of ['defaultOffBridgePresent','mainActivityChangedForBridgeOnly','requiresExplicitBridgeInvocation','requiresQ358DummyRuntimeGuard','inferenceRequiresPrivateStorageArtifact','inferenceRequiresExactSize','inferenceRequiresExactSha256','requiresEditableMathLiveReviewBeforeImport','requiresExplicitUserApprovalBeforeWorkspaceImport','candidateEnvelopePrepared']) {
  assert(q359[key] === true, `Q359 must keep ${key} true`);
}
for (const key of ['realImageToLatexInferenceAutoExecuted','realImageToLatexInferenceAttempted','realImageToLatexInferenceExecuted','startupImageToLatexInferenceExecuted','cameraFlowImageToLatexInferenceExecuted','workspaceFlowImageToLatexInferenceExecuted','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelShaVerifiedOnDeviceByPackage','runtimeStartupExecuted','modelLoadAutoExecuted','dummyRuntimeCallAutoExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','solveGraphSolutionHistoryTouched','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','workspaceChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','pubspecChanged','androidManifestChanged','gradleChanged','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','onnxRuntimeAndroidPassClaimedByPackage','modelLoadPassClaimedByPackage','dummyRuntimeCallPassClaimedByPackage','imageToLatexPassClaimedByPackage','ocrPassClaimed']) {
  assert(q359[key] === false, `Q359 must keep ${key} false`);
}
for (const rel of [
  'lib/features/camera/gauss_first_real_image_to_latex_inference_guard_candidate_envelope_preflight_q359_policy.dart',
  'lib/features/camera/gauss_first_real_image_to_latex_inference_guard_candidate_envelope_preflight_q359.dart',
  'test/v172_q359_first_real_image_to_latex_inference_guard_candidate_envelope_preflight_test.dart',
  'tool/verify_first_real_image_to_latex_inference_guard_candidate_envelope_preflight_v172_q359.mjs',
  'docs/audit/V172_Q359_FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_GUARD_CANDIDATE_ENVELOPE_PREFLIGHT_AUDIT.md',
  'docs/audit/V172_Q359_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q359 expected file missing: ${rel}`);
}
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q359 must preserve Q354 ONNX Runtime Android dependency');
assert((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q359 must keep exactly one onnxruntime-android dependency marker');
assert(!pubspec.toLowerCase().includes('onnxruntime'), 'Q359 must not add ONNX Runtime dependency to pubspec');
assert(!androidManifest.includes('ONNX'), 'Q359 must not mutate AndroidManifest for ONNX');
for (const required of [
  'private val q359Phase = "' + phase + '"',
  'private val q359FeatureEnabled = false',
  'private val q359Status = "' + status + '"',
  '"onnxFirstImageToLatexInferenceGuard" -> result.success(q359OnnxFirstImageToLatexInferenceGuard(call.method))',
  'private fun q359OnnxFirstImageToLatexInferenceGuard(method: String): Map<String, Any>',
  'requiresQ358DummyRuntimeGuard" to true',
  'candidateEnvelopePrepared" to true',
  'candidateLatex" to ""',
  'candidateConfidence" to 0.0',
  'realImageToLatexInferenceAutoExecuted" to false',
  'realImageToLatexInferenceAttempted" to false',
  'realImageToLatexInferenceExecuted" to false',
  'editableMathLiveReviewOpened" to false',
  'workspaceImportExecuted" to false',
  'ocrPassClaimed" to false',
]) {
  assert(mainActivity.includes(required), `Q359 MainActivity required marker missing: ${required}`);
}
for (const forbidden of ['realImageToLatexInferencePassed" to true', 'workspaceImportExecuted" to true', 'ocrPassClaimed" to true', 'imageToLatexPassClaimedByPackage" to true']) {
  assert(!mainActivity.includes(forbidden), `Q359 must not include forbidden marker ${forbidden}`);
}
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q359 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q359 unexpected physical binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q359 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, defaultOffBridgePresent: q359.defaultOffBridgePresent, candidateEnvelopePrepared: q359.candidateEnvelopePrepared, realImageToLatexInferenceExecuted: q359.realImageToLatexInferenceExecuted, imageToLatexPassClaimed: q359.imageToLatexPassClaimedByPackage, ocrPassClaimed: q359.ocrPassClaimed, ok: true }, null, 2));
