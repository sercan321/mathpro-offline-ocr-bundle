#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const sourcePhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q361Phase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q360Phase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const onnxSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const onnxSizeBytes = 308743097;
const status = 'STORE_PRIVACY_FINAL_RELEASE_GATE_STATIC_BLOCKED_NO_STORE_READY_PASS_NO_RUNTIME_PASS';
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
assert(manifest.cameraOcrLatestPhase === phase, `cameraOcrLatestPhase must be Q363, got ${manifest.cameraOcrLatestPhase}`);
assert(manifest.activeProductDevelopmentLatestPhase === phase, `activeProductDevelopmentLatestPhase must be Q363, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.storePrivacyFinalReleaseGateLatestPhase === phase, 'Q363 latest key missing');
assert(manifest.accuracyPerformanceMultideviceQaGuardLatestPhase === sourcePhase, 'Q363 must preserve Q362 latest key');
assert(manifest.cameraOcrRuntimeExecutionBridgeLatestPhase === q361Phase, 'Q363 must preserve Q361 latest key');
assert(manifest.ocrReviewApprovedImportContractLatestPhase === q360Phase, 'Q363 must preserve Q360 latest key');
const q363 = manifest.v172Q363StorePrivacyFinalReleaseGate;
assert(q363 && q363.phase === phase, 'Q363 manifest envelope missing');
assert(q363.sourcePhase === sourcePhase, 'Q363 source phase mismatch');
assert(q363.status === status, 'Q363 status mismatch');
assert(q363.selectedDependencyCoordinate === dependencyCoordinate, 'Q363 dependency coordinate mismatch');
assert(q363.expectedOnnxArtifactSha256 === onnxSha256, 'Q363 expected ONNX sha mismatch');
assert(q363.expectedOnnxArtifactSizeBytes === onnxSizeBytes, 'Q363 expected ONNX size mismatch');
for (const key of ['storePrivacyGatePrepared','dataSafetyGatePrepared','finalReleaseGatePrepared','cameraPermissionDisclosureRequired','offlineOcrDisclosureRequired','privateModelStorageDisclosureRequired','modelStorageCleanupPolicyRequired','requiresRealDeviceFlutterEvidenceBeforeRelease','requiresOnnxRuntimeEvidenceBeforeRelease','requiresModelLoadEvidenceBeforeRelease','requiresDummyCallEvidenceBeforeRelease','requiresImageToLatexEvidenceBeforeRelease','requiresEditableMathLiveReviewEvidenceBeforeRelease','requiresApprovedWorkspaceImportEvidenceBeforeRelease','requiresAccuracyPerformanceMultideviceEvidenceBeforeRelease','requiresEditableMathLiveReviewBeforeImport','requiresExplicitUserApprovalBeforeWorkspaceImport','directOcrToWorkspaceImportBlocked','directOcrToSolveGraphSolutionHistoryBlocked','runtimeAutoExecutionBlocked','directOcrToSolveBlocked','directOcrToGraphBlocked','directOcrToSolutionBlocked','directOcrToHistoryBlocked']) {
  assert(q363[key] === true, `Q363 must keep ${key} true`);
}
for (const key of ['featureFlagDefaultEnabled','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelShaVerifiedOnDeviceByPackage','runtimeStartupExecuted','modelLoadExecuted','dummyRuntimeCallExecuted','imageToLatexInferenceExecuted','ocrReviewOpened','workspaceImportExecuted','approvedWorkspaceImportExecuted','solveGraphSolutionHistoryTouched','storeReadyPassClaimed','privacyDataSafetyPassClaimed','finalReleasePassClaimed','releaseCandidatePassClaimed','playStoreReadyPassClaimed','appStoreReadyPassClaimed','premiumFinalPassClaimed','accuracyPassClaimed','performancePassClaimed','multiDevicePassClaimed','flutterAnalyzePassClaimedByPackage','flutterTestPassClaimedByPackage','androidRealDevicePassClaimedByPackage','onnxRuntimeAndroidPassClaimedByPackage','modelLoadPassClaimedByPackage','dummyRuntimeCallPassClaimedByPackage','imageToLatexPassClaimedByPackage','ocrReviewPassClaimedByPackage','workspaceImportPassClaimedByPackage','ocrPassClaimed','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','workspaceChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','pubspecChanged','androidManifestChanged','gradleChanged','mainActivityChanged']) {
  assert(q363[key] === false, `Q363 must keep ${key} false`);
}
for (const rel of [
  'lib/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart',
  'lib/features/camera/gauss_store_privacy_final_release_gate_q363.dart',
  'test/v172_q363_store_privacy_final_release_gate_test.dart',
  'tool/verify_store_privacy_final_release_gate_v172_q363.mjs',
  'docs/audit/V172_Q363_STORE_PRIVACY_FINAL_RELEASE_GATE_AUDIT.md',
  'docs/audit/V172_Q363_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q363 expected file missing: ${rel}`);
}
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q363 must preserve Q354 ONNX Runtime Android dependency');
assert((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q363 must keep exactly one onnxruntime-android dependency marker');
assert(!pubspec.toLowerCase().includes('onnxruntime'), 'Q363 must not add ONNX Runtime dependency to pubspec');
assert(!androidManifest.includes('ONNX'), 'Q363 must not mutate AndroidManifest for ONNX');
assert(mainActivity.includes('private val q361FeatureEnabled = false'), 'Q363 must preserve Q361 bridge default-off flag');
assert(mainActivity.includes('cameraOcrRuntimeExecutionBridge'), 'Q363 must preserve Q361 bridge method');
assert(!mainActivity.includes('q363FeatureEnabled'), 'Q363 must not add native feature flag');
assert(!mainActivity.includes('storePrivacyFinalRelease'), 'Q363 must not add native store/privacy bridge');
const expectedTargets = new Map([
  ['android/app/libs/PaddlePredictor.jar', { size: 9167, sha256: '81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2' }],
  ['android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so', { size: 4531976, sha256: '2eb3cd0f1d3d01c2199ee79d28f5bef7180a699f7bd9cbb183743f3031277fe2' }],
  ['android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so', { size: 2877288, sha256: '261de17f07130118962226f451a9a75aae84ff15bfe4e4b6b2ed942b5a7b121f' }],
]);
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q363 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q363 unexpected physical binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q363 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, storePrivacyGatePrepared: q363.storePrivacyGatePrepared, dataSafetyGatePrepared: q363.dataSafetyGatePrepared, finalReleaseGatePrepared: q363.finalReleaseGatePrepared, finalReleasePassClaimed: q363.finalReleasePassClaimed, ocrPassClaimed: q363.ocrPassClaimed, ok: true }, null, 2));
