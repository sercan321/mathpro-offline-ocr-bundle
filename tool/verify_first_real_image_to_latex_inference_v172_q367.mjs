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

const phase = 'V172-Q367-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE';
const sourcePhase = 'V172-Q366-ONNX-DUMMY-INPUT-RUNTIME-CALL-EXECUTION';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const expectedSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const expectedSize = 308743097;
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q367 = manifest.v172Q367FirstRealImageToLatexInference || {};
const successorOutputDecoderActive = Boolean(
  manifest.realOcrExecutionOutputDecoderClosureLatestPhase ||
  manifest.realOnnxOutputDecoderCandidateExtractionBindingLatestPhase ||
  manifest.ocrRuntimeReadinessAdaptiveInputDecoderCompletionLatestPhase ||
  manifest.cameraOcrRuntimeFinalizationCropModelVocabReviewCompletionLatestPhase
);
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q367 must preserve Q363 as active cameraOcrLatestPhase');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q367 must preserve Q363 as active product phase');
check(manifest.firstRealImageToLatexInferenceLatestPhase === phase, 'Q367 latest key missing');
check(q367.phase === phase, 'Q367 manifest phase mismatch');
check(q367.sourcePhase === sourcePhase, 'Q367 source phase mismatch');
check(q367.activeProductGatePreservedPhase === activeProductPhase, 'Q367 active product preserved phase mismatch');
check(q367.selectedDependencyCoordinate === dependencyCoordinate, 'Q367 dependency coordinate mismatch');
check(q367.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q367 bridge channel mismatch');
check(q367.bridgeMethod === 'onnxFirstRealImageToLatexInferenceExecution', 'Q367 bridge method mismatch');
check(q367.expectedOnnxArtifactSha256 === expectedSha256, 'Q367 ONNX sha mismatch');
check(q367.expectedOnnxArtifactSizeBytes === expectedSize, 'Q367 ONNX size mismatch');
check(q367.expectedPrivateStorageRelativePath === 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx', 'Q367 private storage path mismatch');

for (const key of [
  'firstRealImageToLatexBridgePrepared',
  'explicitBridgeInvocationRequired',
  'requiresQ366DummyRuntimeCallExecution',
  'privateStorageModelRequired',
  'sourceImagePathRequired',
  'sizeVerificationRequiredBeforeInference',
  'sha256VerificationRequiredBeforeInference',
  'dependencyClassProbeRequired',
  'imageDecodeRequired',
  'imageTensorPreprocessPrepared',
  'candidateEnvelopePrepared',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'preservesQ363AsActiveProductPhase',
]) check(q367[key] === true, `Q367 must keep ${key} true`);

for (const key of [
  'onnxModelBundledIntoFlutterProject',
  'onnxModelAutoCopiedAtStartup',
  'imageToLatexInferenceAutoExecuted',
  'imageToLatexInferenceAttemptedByPackage',
  'imageToLatexPassClaimedByPackage',
  'outputDecodingImplemented',
  'editableMathLiveReviewOpened',
  'workspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'ocrPassClaimed',
  'androidPassClaimed',
  'storeReadyPassClaimed',
  'releaseReadyPassClaimed',
  'pubspecChanged',
  'gradleChanged',
  'androidManifestChanged',
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
]) check(q367[key] === false, `Q367 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_first_real_image_to_latex_inference_q367_policy.dart',
  'lib/features/camera/gauss_first_real_image_to_latex_inference_q367.dart',
  'test/v172_q367_first_real_image_to_latex_inference_test.dart',
  'tool/verify_first_real_image_to_latex_inference_v172_q367.mjs',
  'docs/audit/V172_Q367_FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_AUDIT.md',
  'docs/audit/V172_Q367_CHANGED_FILES.md',
]) check(exists(rel), `Q367 expected file missing: ${rel}`);

check(mainActivity.includes('private val q367Phase = "V172-Q367-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE"'), 'Q367 MainActivity phase constant missing');
check(mainActivity.includes('onnxFirstRealImageToLatexInferenceExecution'), 'Q367 method channel case missing');
check(mainActivity.includes('q367FirstRealImageToLatexInferenceExecution'), 'Q367 function missing');
check(mainActivity.includes('BitmapFactory.decodeFile'), 'Q367 image decode missing');
check(mainActivity.includes('Bitmap.createScaledBitmap'), 'Q367 image resize missing');
check(mainActivity.includes('OnnxTensor.createTensor'), 'Q367 image tensor creation missing');
check(mainActivity.includes('session.run(mapOf(firstInputName to imageTensor))'), 'Q367 image session.run missing');
check(mainActivity.includes('candidateEnvelopeVersion" to q367CandidateEnvelopeVersion'), 'Q367 candidate envelope missing');
if (!successorOutputDecoderActive) {
  check(mainActivity.includes('outputDecodingImplemented" to false'), 'Q367 must not claim output decoding before successor decoder phases');
}
check(mainActivity.includes('workspaceImportExecuted" to false'), 'Q367 must not import workspace');
check(mainActivity.includes('ocrPassClaimed" to false'), 'Q367 must not claim OCR pass');
check(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q367 must preserve Q354 ONNX Runtime dependency');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q367 must keep exactly one ONNX Runtime dependency marker');
check(!pubspec.includes('onnxruntime'), 'Q367 must not add ONNX Runtime dependency to pubspec');
check(!androidManifest.includes('ONNX'), 'Q367 must not mutate AndroidManifest for ONNX');

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
check(forbiddenModels.length === 0, `Q367 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (process.exitCode) {
  console.error('Q367_FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_FAILED');
  process.exit(process.exitCode);
}
console.log('Q367_FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_PASS');
