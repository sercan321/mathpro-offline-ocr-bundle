#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_camera_ocr_runtime_model_format_binding_preflight_v172_q384r2: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policy = read('lib/features/camera/gauss_camera_ocr_runtime_model_format_binding_q384r2.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const shell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const buildGradle = read('android/app/build.gradle');

for (const marker of [
  'V172-Q384R2-CAMERA-OCR-RUNTIME-MODEL-FORMAT-BINDING-PREFLIGHT',
  'paddle-inference-directory',
  'inference.pdiparams',
  'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489',
  'deferredPaddleModelRuntimeBindingPreflight',
  'q384r2-paddle-runtime-binding-not-enabled',
  'q384r1InstallPathPassedToNativeBridge = true',
  'paddleInferenceDirectoryPreflightImplemented = true',
  'onnxMissingReasonRetiredForQ384R2ReviewFlow = true',
  'productionInferenceClaimedByQ384R2 = false',
  'fakeLatexCandidateAllowed = false',
  'workspaceAutoImportAllowed = false',
]) {
  check(policy.includes(marker), `Q384R2 Dart policy marker missing: ${marker}`);
}

for (const marker of [
  'static const bool productionDownloadUrlBound = true;',
  'Kamera OCR inference için runtime/model-format binding Q384R2 preflight ile hizalanır',
]) {
  check(manager.includes(marker), `Q384R2 manager alignment missing: ${marker}`);
}

check(shell.includes("modelSourcePath: _mathOcrModelSnapshot.installPath ?? ''"), 'camera shell must continue passing Q384R1 installPath into native runtime bridge');

for (const marker of [
  'q384R2Phase',
  'V172-Q384R2-CAMERA-OCR-RUNTIME-MODEL-FORMAT-BINDING-PREFLIGHT',
  'q384R2RequiredArtifactFileNames = listOf("config.json", "inference.json", "inference.yml", q384R2PrimaryModelFileName)',
  '"deferredPaddleModelRuntimeBindingPreflight" -> result.success',
  'q384R2DeferredPaddleModelRuntimeBindingPreflight',
  'paddleInferenceDirectoryReady',
  'primarySha256MatchesExpected',
  'missingArtifactFiles',
  'runtimeBindingAttempted" to false',
  'imageToLatexInferenceAttempted" to false',
  'productionInferenceClaimedByQ384R2" to false',
  'q380-q384r2-model-format-binding-preflight',
  'q384r2-paddle-model-source-path-missing',
  'q384r2-paddle-primary-sha256-mismatch',
  'q384r2-paddle-runtime-binding-not-enabled',
]) {
  check(main.includes(marker), `Q384R2 native bridge marker missing: ${marker}`);
}

check(!buildGradle.includes('onnxruntime-android'), 'Q384R2 must not re-add ONNX Runtime Android AAR');
check(!buildGradle.includes('com.microsoft.onnxruntime'), 'Q384R2 must not re-add com.microsoft.onnxruntime dependency');

for (const rel of [
  'test/v172_q384r2_camera_ocr_runtime_model_format_binding_preflight_test.dart',
  'docs/audit/V172_Q384R2_CAMERA_OCR_RUNTIME_MODEL_FORMAT_BINDING_PREFLIGHT.md',
  'docs/audit/V172_Q384R2_CHANGED_FILES.md',
]) {
  check(exists(rel), `Q384R2 artifact missing: ${rel}`);
}

const forbiddenModelExt = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i;
const ignored = (p) => p.includes('/build/') || p.startsWith('build/') || p.includes('/.dart_tool/') || p.startsWith('.dart_tool/') || p.startsWith('docs/evidence/');
const modelArtifacts = [];
const walk = (dir) => {
  for (const entry of fs.readdirSync(path.join(root, dir), { withFileTypes: true })) {
    const rel = path.posix.join(dir, entry.name);
    if (ignored(rel)) continue;
    if (entry.isDirectory()) walk(rel);
    else if (forbiddenModelExt.test(rel)) modelArtifacts.push(rel);
  }
};
walk('.');
check(modelArtifacts.length === 0, `base project must not bundle OCR model artifacts: ${modelArtifacts.join(', ')}`);

console.log('PASS verify_camera_ocr_runtime_model_format_binding_preflight_v172_q384r2');
