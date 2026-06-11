#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const check = (condition, message) => {
  if (!condition) {
    console.error(message);
    process.exitCode = 1;
  }
};

const phase = 'V172-Q370-CAMERA-OCR-FINAL-REAL-DEVICE-QA-RELEASE-CLOSURE';
const sourcePhase = 'V172-Q369-APPROVED-OCR-WORKSPACE-IMPORT-ACTIVATION';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const expectedSha = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const expectedSize = 308743097;
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q370 = manifest.v172Q370CameraOcrFinalRealDeviceQaReleaseClosure || {};
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q370 must preserve Q363 as active camera OCR phase');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q370 must preserve Q363 as active product phase');
check(manifest.cameraOcrFinalRealDeviceQaReleaseClosureLatestPhase === phase, 'Q370 latest key missing');
check(q370.phase === phase, 'Q370 manifest phase mismatch');
check(q370.sourcePhase === sourcePhase, 'Q370 source phase mismatch');
check(q370.activeProductGatePreservedPhase === activeProductPhase, 'Q370 active gate mismatch');
check(q370.status === 'CAMERA_OCR_FINAL_REAL_DEVICE_QA_RELEASE_CLOSURE_EVIDENCE_REQUIRED_NO_PASS_CLAIM', 'Q370 status mismatch');
check(q370.engine === 'PP-FormulaNet-S', 'Q370 engine mismatch');
check(q370.expectedOnnxArtifactFileName === 'pp_formulanet_s.onnx', 'Q370 expected ONNX filename mismatch');
check(q370.expectedOnnxArtifactSha256 === expectedSha, 'Q370 expected ONNX sha mismatch');
check(q370.expectedOnnxArtifactSizeBytes === expectedSize, 'Q370 expected ONNX size mismatch');

for (const key of [
  'finalRealDeviceQaClosurePrepared',
  'requiresFlutterAnalyzePass',
  'requiresFlutterTestPass',
  'requiresFlutterRunPass',
  'requiresQ364PrivateStorageEvidence',
  'requiresQ365ModelLoadSmokeEvidence',
  'requiresQ366DummyRuntimeCallEvidence',
  'requiresQ367ImageToLatexEvidence',
  'requiresQ368EditableReviewEvidence',
  'requiresQ369ApprovedImportEvidence',
  'requiresNoDirectOcrToWorkspaceImport',
  'requiresNoDirectOcrToSolveGraphSolutionHistory',
  'requiresStorePrivacyDataSafetyReview',
  'preservesQ363AsActiveProductPhase',
]) check(q370[key] === true, `Q370 must keep ${key} true`);

for (const key of [
  'modelPrivateStoragePassClaimed',
  'modelLoadPassClaimed',
  'dummyRuntimeCallPassClaimed',
  'imageToLatexPassClaimed',
  'ocrReviewPassClaimed',
  'workspaceImportPassClaimed',
  'ocrPassClaimed',
  'androidPassClaimed',
  'storeReadyPassClaimed',
  'releaseReadyPassClaimed',
  'workspaceImportAutoExecuted',
  'solveGraphSolutionHistoryTouched',
  'pubspecChanged',
  'gradleChanged',
  'androidManifestChanged',
  'mainActivityChanged',
  'keyboardChanged',
  'moreTemplateTrayChanged',
  'longPressChanged',
  'mathLiveProductionBridgeChanged',
  'workspaceChanged',
  'graphChanged',
  'solutionChanged',
  'historyChanged',
  'splashChanged',
  'iconChanged',
]) check(q370[key] === false, `Q370 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_camera_ocr_final_real_device_qa_release_closure_q370_policy.dart',
  'lib/features/camera/gauss_camera_ocr_final_real_device_qa_release_closure_q370.dart',
  'test/v172_q370_camera_ocr_final_real_device_qa_release_closure_test.dart',
  'tool/verify_camera_ocr_final_real_device_qa_release_closure_v172_q370.mjs',
  'docs/audit/V172_Q370_CAMERA_OCR_FINAL_REAL_DEVICE_QA_RELEASE_CLOSURE_AUDIT.md',
  'docs/audit/V172_Q370_CHANGED_FILES.md',
]) check(exists(rel), `Q370 expected file missing: ${rel}`);

check(!mainActivity.includes('q370'), 'Q370 must not mutate MainActivity');
check(!mainActivity.includes('cameraOcrFinalRealDeviceQaReleaseClosure'), 'Q370 must not add a native bridge');
check(!pubspec.includes('q370_release_dependency'), 'Q370 must not add pubspec dependencies');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q370 must preserve exactly one ONNX Runtime dependency marker');
check(!androidManifest.includes('Q370'), 'Q370 must not mutate AndroidManifest');

const forbiddenModels = [];
const scan = (dir) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const abs = path.join(dir, entry.name);
    const rel = path.relative(root, abs).replaceAll('\\', '/');
    if (rel.startsWith('build/') || rel.includes('/build/')) continue;
    if (entry.isDirectory()) scan(abs);
    else if (/\.(onnx|nb|pdmodel|pdiparams|tflite)$/i.test(entry.name)) forbiddenModels.push(rel);
  }
};
scan(root);
check(forbiddenModels.length === 0, `Q370 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (process.exitCode) {
  console.error('Q370_CAMERA_OCR_FINAL_REAL_DEVICE_QA_RELEASE_CLOSURE_FAILED');
  process.exit(process.exitCode);
}
console.log('Q370_CAMERA_OCR_FINAL_REAL_DEVICE_QA_RELEASE_CLOSURE_PASS');
