#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_base_apk_ocr_runtime_slimming_download_only_contract_v172_q384: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const buildGradle = read('android/app/build.gradle');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const pubspec = read('pubspec.yaml').toLowerCase();
const manifestXml = read('android/app/src/main/AndroidManifest.xml');

check(buildGradle.includes("implementation files('libs/PaddlePredictor.jar')"), 'PaddlePredictor.jar bridge must be preserved');
check(!buildGradle.includes('onnxruntime-android'), 'ONNX Runtime Android AAR must be removed from base build.gradle');
check(!buildGradle.includes('com.microsoft.onnxruntime'), 'ONNX Runtime coordinate must not be an Android dependency');
check(!pubspec.includes('onnxruntime'), 'pubspec must not add ONNX Runtime');
check(!manifestXml.includes('ONNX'), 'AndroidManifest must not be mutated for ONNX');

for (const forbidden of [
  'import ai.onnxruntime',
  'OrtEnvironment.getEnvironment()',
  'OrtSession.SessionOptions',
  'OnnxTensor.createTensor',
  'is OnnxValue',
]) {
  check(!mainActivity.includes(forbidden), `MainActivity must not compile-link ONNX Runtime symbol: ${forbidden}`);
}
for (const required of [
  'private val q384Phase = "V172-Q384-BASE-APK-OCR-RUNTIME-SLIMMING-DOWNLOAD-ONLY-CONTRACT"',
  'private val q384Status = "ONNX_RUNTIME_REMOVED_FROM_BASE_APK_DOWNLOAD_ONLY_OCR_CONTRACT_ACTIVE"',
  'private val q384OnnxRuntimeBundledInBaseApk = false',
  'q384-download-only-ocr-contract-onnx-runtime-not-bundled',
  'q384-base-apk-onnx-runtime-removed',
]) {
  check(mainActivity.includes(required), `Q384 marker missing from MainActivity: ${required}`);
}

check(exists('android/app/libs/PaddlePredictor.jar'), 'PaddlePredictor.jar must remain present');
check(exists('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'arm64 Paddle Lite native bridge must remain present for current runtime path');
check(exists('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so'), 'legacy armeabi-v7a Paddle Lite native bridge must remain unchanged in this phase');

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
check(modelArtifacts.length === 0, `base project must not bundle model artifacts: ${modelArtifacts.join(', ')}`);

for (const rel of [
  'test/v172_q384_base_apk_ocr_runtime_slimming_download_only_contract_test.dart',
  'docs/audit/V172_Q384_BASE_APK_OCR_RUNTIME_SLIMMING_DOWNLOAD_ONLY_CONTRACT.md',
  'docs/audit/V172_Q384_CHANGED_FILES.md',
]) {
  check(exists(rel), `Q384 artifact missing: ${rel}`);
}

console.log('PASS verify_base_apk_ocr_runtime_slimming_download_only_contract_v172_q384');
