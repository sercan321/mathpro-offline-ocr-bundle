#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const sourcePhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const q361SuccessorPhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q362SuccessorPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const onnxSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const onnxSizeBytes = 308743097;
const status = 'OCR_REVIEW_APPROVED_IMPORT_CONTRACT_DEFAULT_OFF_NO_DIRECT_IMPORT_NO_SOLVE';
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
assert([phase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q360 or Q361 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q360 or Q361 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.ocrReviewApprovedImportContractLatestPhase === phase, 'Q360 latest key missing');
if (manifest.cameraOcrLatestPhase === q361SuccessorPhase) {
  assert(manifest.cameraOcrRuntimeExecutionBridgeLatestPhase === q361SuccessorPhase, 'Q360 successor Q361 latest key missing');
  assert(exists('tool/verify_camera_ocr_runtime_execution_bridge_v172_q361.mjs'), 'Q360 successor Q361 verifier missing');
}
assert(manifest.firstRealImageToLatexInferenceGuardCandidateEnvelopePreflightLatestPhase === sourcePhase, 'Q360 must preserve Q359 latest key');
const q360 = manifest.v172Q360OcrReviewApprovedImportContract;
assert(q360 && q360.phase === phase, 'Q360 manifest envelope missing');
assert(q360.sourcePhase === sourcePhase, 'Q360 source phase mismatch');
assert(q360.status === status, 'Q360 status mismatch');
assert(q360.selectedDependencyCoordinate === dependencyCoordinate, 'Q360 dependency coordinate mismatch');
assert(q360.expectedOnnxArtifactSha256 === onnxSha256, 'Q360 expected ONNX sha mismatch');
assert(q360.expectedOnnxArtifactSizeBytes === onnxSizeBytes, 'Q360 expected ONNX size mismatch');
for (const key of ['reviewContractPrepared','approvedImportContractPrepared','requiresCandidateEnvelope','requiresEditableMathLiveReviewBeforeImport','requiresExplicitUserApprovalBeforeWorkspaceImport','directOcrToWorkspaceImportBlocked','directOcrToSolveBlocked','directOcrToGraphBlocked','directOcrToSolutionBlocked','directOcrToHistoryBlocked','rejectsEmptyCandidateLatex','rejectsUnreviewedCandidateLatex','rejectsUnapprovedImport']) {
  assert(q360[key] === true, `Q360 must keep ${key} true`);
}
for (const key of ['reviewUiAutoOpened','workspaceImportExecuted','solveGraphSolutionHistoryTouched','nativeRuntimeChanged','uiRuntimeChanged','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelShaVerifiedOnDeviceByPackage','runtimeStartupExecuted','modelLoadAutoExecuted','dummyRuntimeCallAutoExecuted','imageToLatexInferenceExecuted','editableMathLiveReviewOpened','approvedWorkspaceImportExecuted','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','workspaceChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','pubspecChanged','androidManifestChanged','gradleChanged','mainActivityChanged','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','onnxRuntimeAndroidPassClaimedByPackage','modelLoadPassClaimedByPackage','dummyRuntimeCallPassClaimedByPackage','imageToLatexPassClaimedByPackage','ocrReviewPassClaimedByPackage','workspaceImportPassClaimedByPackage','ocrPassClaimed']) {
  assert(q360[key] === false, `Q360 must keep ${key} false`);
}
for (const rel of [
  'lib/features/camera/gauss_ocr_review_approved_import_contract_q360_policy.dart',
  'lib/features/camera/gauss_ocr_review_approved_import_contract_q360.dart',
  'test/v172_q360_ocr_review_approved_import_contract_test.dart',
  'tool/verify_ocr_review_approved_import_contract_v172_q360.mjs',
  'docs/audit/V172_Q360_OCR_REVIEW_APPROVED_IMPORT_CONTRACT_AUDIT.md',
  'docs/audit/V172_Q360_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q360 expected file missing: ${rel}`);
}
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q360 must preserve Q354 ONNX Runtime Android dependency');
assert((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q360 must keep exactly one onnxruntime-android dependency marker');
assert(!pubspec.toLowerCase().includes('onnxruntime'), 'Q360 must not add ONNX Runtime dependency to pubspec');
assert(!androidManifest.includes('ONNX'), 'Q360 must not mutate AndroidManifest for ONNX');
if (manifest.cameraOcrLatestPhase === phase) {
  assert(!mainActivity.includes('q360'), 'Q360 must not mutate MainActivity');
}
assert(!mainActivity.includes('ocrReviewApprovedImport'), 'Q360 must not add native review/import bridge');
if (manifest.cameraOcrLatestPhase === q361SuccessorPhase) {
  assert(mainActivity.includes('private val q361FeatureEnabled = false'), 'Q361 successor default-off flag missing');
  assert(mainActivity.includes('cameraOcrRuntimeExecutionBridge'), 'Q361 successor bridge missing');
}
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q360 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q360 unexpected physical binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q360 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, reviewContractPrepared: q360.reviewContractPrepared, approvedImportContractPrepared: q360.approvedImportContractPrepared, directOcrToWorkspaceImportBlocked: q360.directOcrToWorkspaceImportBlocked, workspaceImportPassClaimed: q360.workspaceImportPassClaimedByPackage, ocrPassClaimed: q360.ocrPassClaimed, ok: true }, null, 2));
