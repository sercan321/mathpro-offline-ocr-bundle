#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const phase = 'V172-Q364-ONNX-MODEL-ARTIFACT-PRIVATE-STORAGE-ACTIVATION';
const sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const dependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
const expectedSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const expectedSize = 308743097;
const errors = [];
const check = (condition, message) => { if (!condition) errors.push(message); };
const walk = (dir, out = []) => {
  if (!fs.existsSync(dir)) return out;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    const rel = path.relative(root, full).replaceAll(path.sep, '/');
    if (rel.startsWith('build/') || rel.includes('/build/') || rel.startsWith('.dart_tool/') || rel.includes('/.dart_tool/')) continue;
    if (entry.isDirectory()) walk(full, out);
    else out.push(rel);
  }
  return out;
};

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
check(manifest.cameraOcrLatestPhase === sourcePhase, 'Q364 must preserve Q363 as active cameraOcrLatestPhase until final activation evidence closes');
check(manifest.activeProductDevelopmentLatestPhase === sourcePhase, 'Q364 must preserve Q363 as active product phase');
check(manifest.onnxModelArtifactPrivateStorageActivationLatestPhase === phase, 'Q364 latest key missing');
const q364 = manifest.v172Q364OnnxModelArtifactPrivateStorageActivation || {};
check(q364.phase === phase, 'Q364 manifest phase mismatch');
check(q364.sourcePhase === sourcePhase, 'Q364 source phase mismatch');
check(q364.runtimeBridgeSourcePhase === 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'Q364 runtime bridge source mismatch');
check(q364.selectedDependencyCoordinate === dependencyCoordinate, 'Q364 dependency coordinate mismatch');
check(q364.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q364 bridge channel mismatch');
check(q364.bridgeMethod === 'onnxModelArtifactPrivateStorageActivation', 'Q364 bridge method mismatch');
check(q364.expectedOnnxArtifactSha256 === expectedSha256, 'Q364 ONNX sha mismatch');
check(q364.expectedOnnxArtifactSizeBytes === expectedSize, 'Q364 ONNX size mismatch');
for (const key of [
  'privateStorageActivationBridgePrepared',
  'explicitBridgeInvocationRequired',
  'sourcePathRequiredForCopy',
  'sizeVerificationRequired',
  'sha256VerificationRequired',
  'atomicCopyPolicyPrepared',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'preservesQ363AsActiveProductPhase',
]) check(q364[key] === true, `Q364 must keep ${key} true`);
for (const key of [
  'onnxModelBundledIntoFlutterProject',
  'onnxModelAutoCopiedAtStartup',
  'cameraAutoExecutionEnabled',
  'modelLoadAutoExecuted',
  'modelLoadAttemptedByPackage',
  'dummyRuntimeCallExecuted',
  'imageToLatexInferenceExecuted',
  'editableMathLiveReviewOpened',
  'workspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'modelPrivateStoragePassClaimedByPackage',
  'modelLoadPassClaimedByPackage',
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
]) check(q364[key] === false, `Q364 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_onnx_model_artifact_private_storage_activation_q364_policy.dart',
  'lib/features/camera/gauss_onnx_model_artifact_private_storage_activation_q364.dart',
  'test/v172_q364_onnx_model_artifact_private_storage_activation_test.dart',
  'tool/verify_onnx_model_artifact_private_storage_activation_v172_q364.mjs',
  'docs/audit/V172_Q364_ONNX_MODEL_ARTIFACT_PRIVATE_STORAGE_ACTIVATION_AUDIT.md',
  'docs/audit/V172_Q364_CHANGED_FILES.md',
]) check(exists(rel), `Q364 expected file missing: ${rel}`);

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(mainActivity.includes('private val q364Phase = "V172-Q364-ONNX-MODEL-ARTIFACT-PRIVATE-STORAGE-ACTIVATION"'), 'Q364 MainActivity phase constant missing');
check(mainActivity.includes('private val q364FeatureEnabled = true'), 'Q364 explicit bridge feature should be enabled only for explicit invocation');
check(mainActivity.includes('onnxModelArtifactPrivateStorageActivation'), 'Q364 method channel case missing');
check(mainActivity.includes('q364OnnxModelArtifactPrivateStorageActivation'), 'Q364 private-storage function missing');
check(mainActivity.includes('FileOutputStream'), 'Q364 atomic copy implementation missing FileOutputStream import/use');
check(mainActivity.includes('sourcePath'), 'Q364 must require sourcePath argument for copy');
check(mainActivity.includes('copyAttempted'), 'Q364 copyAttempted result missing');
check(mainActivity.includes('copyExecuted'), 'Q364 copyExecuted result missing');
check(mainActivity.includes('privateStorageModelReady'), 'Q364 privateStorageModelReady result missing');
check(mainActivity.includes('modelLoadAutoExecuted" to false'), 'Q364 must not auto-run model load');
check(mainActivity.includes('realImageToLatexInferenceExecuted" to false'), 'Q364 must not run image-to-LaTeX');
check(mainActivity.includes('workspaceImportExecuted" to false'), 'Q364 must not import workspace');

const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml').toLowerCase();
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
check(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q364 must preserve Q354 ONNX Runtime dependency');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q364 must keep exactly one ONNX Runtime dependency marker');
check(!pubspec.includes('onnxruntime'), 'Q364 must not add ONNX Runtime dependency to pubspec');
check(!androidManifest.includes('ONNX'), 'Q364 must not mutate AndroidManifest for ONNX');

const forbiddenModels = walk(root).filter((rel) => !rel.startsWith('docs/evidence/') && /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors|pt|pth|pdparams)$/i.test(rel));
check(forbiddenModels.length === 0, `Q364 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (errors.length) {
  console.error('Q364_ONNX_MODEL_ARTIFACT_PRIVATE_STORAGE_ACTIVATION_FAILED');
  for (const error of errors) console.error(` - ${error}`);
  process.exit(1);
}
console.log('Q364_ONNX_MODEL_ARTIFACT_PRIVATE_STORAGE_ACTIVATION_PASS');
