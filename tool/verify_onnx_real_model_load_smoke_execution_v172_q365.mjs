#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const phase = 'V172-Q365-ONNX-REAL-MODEL-LOAD-SMOKE-EXECUTION';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const sourcePhase = 'V172-Q364-ONNX-MODEL-ARTIFACT-PRIVATE-STORAGE-ACTIVATION';
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
check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q365 must preserve Q363 as active cameraOcrLatestPhase until final OCR activation evidence closes');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q365 must preserve Q363 as active product phase');
check(manifest.onnxRealModelLoadSmokeExecutionLatestPhase === phase, 'Q365 latest key missing');
const q365 = manifest.v172Q365OnnxRealModelLoadSmokeExecution || {};
check(q365.phase === phase, 'Q365 manifest phase mismatch');
check(q365.sourcePhase === sourcePhase, 'Q365 source phase mismatch');
check(q365.activeProductGatePreservedPhase === activeProductPhase, 'Q365 active product preserved phase mismatch');
check(q365.selectedDependencyCoordinate === dependencyCoordinate, 'Q365 dependency coordinate mismatch');
check(q365.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q365 bridge channel mismatch');
check(q365.bridgeMethod === 'onnxRealModelLoadSmokeExecution', 'Q365 bridge method mismatch');
check(q365.expectedOnnxArtifactSha256 === expectedSha256, 'Q365 ONNX sha mismatch');
check(q365.expectedOnnxArtifactSizeBytes === expectedSize, 'Q365 ONNX size mismatch');
for (const key of [
  'realModelLoadSmokeBridgePrepared',
  'explicitBridgeInvocationRequired',
  'privateStorageModelRequired',
  'sizeVerificationRequiredBeforeLoad',
  'sha256VerificationRequiredBeforeLoad',
  'dependencyClassProbeRequired',
  'ortEnvironmentSessionPolicyPrepared',
  'sessionClosePolicyPrepared',
  'inputOutputNameCapturePrepared',
  'startupModelLoadBlocked',
  'cameraFlowModelLoadBlocked',
  'workspaceFlowModelLoadBlocked',
  'solveGraphSolutionHistoryModelLoadBlocked',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'preservesQ363AsActiveProductPhase',
]) check(q365[key] === true, `Q365 must keep ${key} true`);
for (const key of [
  'onnxModelBundledIntoFlutterProject',
  'onnxModelAutoCopiedAtStartup',
  'modelLoadAutoExecuted',
  'modelLoadAttemptedByPackage',
  'modelLoadExecutedByPackage',
  'modelLoadPassClaimedByPackage',
  'dummyRuntimeCallExecuted',
  'imageToLatexInferenceExecuted',
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
]) check(q365[key] === false, `Q365 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_onnx_real_model_load_smoke_execution_q365_policy.dart',
  'lib/features/camera/gauss_onnx_real_model_load_smoke_execution_q365.dart',
  'test/v172_q365_onnx_real_model_load_smoke_execution_test.dart',
  'tool/verify_onnx_real_model_load_smoke_execution_v172_q365.mjs',
  'docs/audit/V172_Q365_ONNX_REAL_MODEL_LOAD_SMOKE_EXECUTION_AUDIT.md',
  'docs/audit/V172_Q365_CHANGED_FILES.md',
]) check(exists(rel), `Q365 expected file missing: ${rel}`);

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(mainActivity.includes('private val q365Phase = "V172-Q365-ONNX-REAL-MODEL-LOAD-SMOKE-EXECUTION"'), 'Q365 MainActivity phase constant missing');
check(mainActivity.includes('private val q365FeatureEnabled = true'), 'Q365 explicit invocation feature should be enabled');
check(mainActivity.includes('onnxRealModelLoadSmokeExecution'), 'Q365 method channel case missing');
check(mainActivity.includes('q365OnnxRealModelLoadSmokeExecution'), 'Q365 model-load function missing');
check(mainActivity.includes('OrtEnvironment.getEnvironment()'), 'Q365 must use OrtEnvironment for session load');
check(mainActivity.includes('environment.createSession(modelFile.absolutePath, sessionOptions)'), 'Q365 must create OrtSession from private model path');
check(mainActivity.includes('inputNames = session.inputNames.joinToString(",")'), 'Q365 input name capture missing');
check(mainActivity.includes('outputNames = session.outputNames.joinToString(",")'), 'Q365 output name capture missing');
check(mainActivity.includes('session?.close()'), 'Q365 session close missing');
check(mainActivity.includes('sessionOptions?.close()'), 'Q365 session options close missing');
check(mainActivity.includes('modelLoadAutoExecuted" to false'), 'Q365 must not auto-run model load');
check(mainActivity.includes('realImageToLatexInferenceExecuted" to false'), 'Q365 must not run image-to-LaTeX');
check(mainActivity.includes('workspaceImportExecuted" to false'), 'Q365 must not import workspace');

const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml').toLowerCase();
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
check(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q365 must preserve Q354 ONNX Runtime dependency');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q365 must keep exactly one ONNX Runtime dependency marker');
check(!pubspec.includes('onnxruntime'), 'Q365 must not add ONNX Runtime dependency to pubspec');
check(!androidManifest.includes('ONNX'), 'Q365 must not mutate AndroidManifest for ONNX');

const forbiddenModels = walk(root).filter((rel) => !rel.startsWith('docs/evidence/') && /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors|pt|pth|pdparams)$/i.test(rel));
check(forbiddenModels.length === 0, `Q365 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (errors.length) {
  console.error('Q365_ONNX_REAL_MODEL_LOAD_SMOKE_EXECUTION_FAILED');
  for (const error of errors) console.error(` - ${error}`);
  process.exit(1);
}
console.log('Q365_ONNX_REAL_MODEL_LOAD_SMOKE_EXECUTION_PASS');
