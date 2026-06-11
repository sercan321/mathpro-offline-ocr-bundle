#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const phase = 'V172-Q366-ONNX-DUMMY-INPUT-RUNTIME-CALL-EXECUTION';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const sourcePhase = 'V172-Q365-ONNX-REAL-MODEL-LOAD-SMOKE-EXECUTION';
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
check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q366 must preserve Q363 as active cameraOcrLatestPhase until final OCR activation evidence closes');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q366 must preserve Q363 as active product phase');
check(manifest.onnxDummyInputRuntimeCallExecutionLatestPhase === phase, 'Q366 latest key missing');
const q366 = manifest.v172Q366OnnxDummyInputRuntimeCallExecution || {};
check(q366.phase === phase, 'Q366 manifest phase mismatch');
check(q366.sourcePhase === sourcePhase, 'Q366 source phase mismatch');
check(q366.activeProductGatePreservedPhase === activeProductPhase, 'Q366 active product preserved phase mismatch');
check(q366.selectedDependencyCoordinate === dependencyCoordinate, 'Q366 dependency coordinate mismatch');
check(q366.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q366 bridge channel mismatch');
check(q366.bridgeMethod === 'onnxDummyInputRuntimeCallExecution', 'Q366 bridge method mismatch');
check(q366.expectedOnnxArtifactSha256 === expectedSha256, 'Q366 ONNX sha mismatch');
check(q366.expectedOnnxArtifactSizeBytes === expectedSize, 'Q366 ONNX size mismatch');
for (const key of [
  'dummyInputRuntimeCallBridgePrepared',
  'explicitBridgeInvocationRequired',
  'requiresQ365ModelLoadSmoke',
  'privateStorageModelRequired',
  'sizeVerificationRequiredBeforeCall',
  'sha256VerificationRequiredBeforeCall',
  'dependencyClassProbeRequired',
  'dummyInputTensorShapePolicyPrepared',
  'resultClosePolicyPrepared',
  'tensorClosePolicyPrepared',
  'sessionClosePolicyPrepared',
  'startupDummyRuntimeCallBlocked',
  'cameraFlowDummyRuntimeCallBlocked',
  'workspaceFlowDummyRuntimeCallBlocked',
  'solveGraphSolutionHistoryDummyRuntimeCallBlocked',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'preservesQ363AsActiveProductPhase',
]) check(q366[key] === true, `Q366 must keep ${key} true`);
for (const key of [
  'onnxModelBundledIntoFlutterProject',
  'onnxModelAutoCopiedAtStartup',
  'dummyRuntimeCallAutoExecuted',
  'dummyRuntimeCallAttemptedByPackage',
  'dummyRuntimeCallExecutedByPackage',
  'dummyRuntimeCallPassClaimedByPackage',
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
]) check(q366[key] === false, `Q366 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_onnx_dummy_input_runtime_call_execution_q366_policy.dart',
  'lib/features/camera/gauss_onnx_dummy_input_runtime_call_execution_q366.dart',
  'test/v172_q366_onnx_dummy_input_runtime_call_execution_test.dart',
  'tool/verify_onnx_dummy_input_runtime_call_execution_v172_q366.mjs',
  'docs/audit/V172_Q366_ONNX_DUMMY_INPUT_RUNTIME_CALL_EXECUTION_AUDIT.md',
  'docs/audit/V172_Q366_CHANGED_FILES.md',
]) check(exists(rel), `Q366 expected file missing: ${rel}`);

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(mainActivity.includes('private val q366Phase = "V172-Q366-ONNX-DUMMY-INPUT-RUNTIME-CALL-EXECUTION"'), 'Q366 MainActivity phase constant missing');
check(mainActivity.includes('private val q366FeatureEnabled = true'), 'Q366 explicit invocation feature should be enabled');
check(mainActivity.includes('onnxDummyInputRuntimeCallExecution'), 'Q366 method channel case missing');
check(mainActivity.includes('q366OnnxDummyInputRuntimeCallExecution'), 'Q366 dummy runtime call function missing');
check(mainActivity.includes('OnnxTensor.createTensor(environment, inputBuffer, longArrayOf(1L))'), 'Q366 dummy tensor creation missing');
check(mainActivity.includes('session.run(mapOf(firstInputName to dummyTensor))'), 'Q366 session.run dummy call missing');
check(mainActivity.includes('resultSet?.close()'), 'Q366 result close missing');
check(mainActivity.includes('dummyTensor?.close()'), 'Q366 tensor close missing');
check(mainActivity.includes('session?.close()'), 'Q366 session close missing');
check(mainActivity.includes('dummyRuntimeCallAutoExecuted" to false'), 'Q366 must not auto-run dummy call');
check(mainActivity.includes('realImageToLatexInferenceExecuted" to false'), 'Q366 must not run image-to-LaTeX');
check(mainActivity.includes('workspaceImportExecuted" to false'), 'Q366 must not import workspace');

const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml').toLowerCase();
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
check(buildGradle.includes(`implementation '${dependencyCoordinate}'`), 'Q366 must preserve Q354 ONNX Runtime dependency');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q366 must keep exactly one ONNX Runtime dependency marker');
check(!pubspec.includes('onnxruntime'), 'Q366 must not add ONNX Runtime dependency to pubspec');
check(!androidManifest.includes('ONNX'), 'Q366 must not mutate AndroidManifest for ONNX');

const forbiddenModels = walk(root).filter((rel) => !rel.startsWith('docs/evidence/') && /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors|pt|pth|pdparams)$/i.test(rel));
check(forbiddenModels.length === 0, `Q366 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (errors.length) {
  console.error('Q366_ONNX_DUMMY_INPUT_RUNTIME_CALL_EXECUTION_FAILED');
  for (const error of errors) console.error(` - ${error}`);
  process.exit(1);
}
console.log('Q366_ONNX_DUMMY_INPUT_RUNTIME_CALL_EXECUTION_PASS');
