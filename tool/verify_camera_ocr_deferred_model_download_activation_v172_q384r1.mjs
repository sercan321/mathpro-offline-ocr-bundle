#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_camera_ocr_deferred_model_download_activation_v172_q384r1: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const worker = read('lib/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const shell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const review = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const pubspec = read('pubspec.yaml');
const manifest = read('android/app/src/main/AndroidManifest.xml');
const buildGradle = read('android/app/build.gradle');

for (const required of [
  'V172-Q384R1-CAMERA-OCR-DEFERRED-MODEL-DOWNLOAD-ACTIVATION',
  'productionDownloadUrlBound = true',
  'realNetworkDownloadWorkerImplemented = true',
  'sha256VerificationImplemented = true',
  'appPrivateStorageAtomicInstallImplemented = true',
  'modelBinaryBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferenceClaimedByQ384R1 = false',
  'PaddlePaddle/PP-FormulaNet-S/resolve/',
  '0572450e501be9eb1b1cdb7e00fccf4b22fab4df',
  'inference.pdiparams',
  'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489',
  'http.Client()',
  'sha256.startChunkedConversion',
  '.part',
  'rename(target.path)',
  'V172-Q385R1-PADDLE-RUNTIME-ABI-TRIM-TEST-AND-DOWNLOAD-GUARD-REPAIR',
  'contentLengthSanityCheckImplemented = true',
  'sidecarMinimumsRelaxedToAvoidFalseRejects = true',
  "documentedSizeLabel: '3.95 MB'",
  "documentedSizeLabel: '505 kB'",
  "documentedSizeLabel: '2.24 MB'",
  'q385r1-content-length-too-small',
  'q384r1_install_manifest.json',
]) {
  check(worker.includes(required), `Q384R1 worker marker missing: ${required}`);
}

for (const required of [
  "import 'package:path_provider/path_provider.dart';",
  "import 'gauss_camera_ocr_deferred_model_download_q384r1.dart';",
  'installProductionModelQ384R1',
  'getApplicationSupportDirectory()',
  'GaussQ384R1DeferredModelDownloadWorker.install',
  'GaussMathOcrModelInstallStatus.downloading',
  'GaussMathOcrModelInstallStatus.verifying',
  'GaussMathOcrModelInstallStatus.ready',
  'queueUserApprovedNetworkPreparation',
  'user-approved-internet-required-large-download',
  'GaussMathOcrModelInstallStatus.failed',
]) {
  check(manager.includes(required), `manager Q384R1 binding missing: ${required}`);
}

check(shell.includes('_installDeferredMathOcrModel'), 'camera shell must call real Q384R1 installer');
check(!shell.includes('queueWifiOnlyPreparation();\n    if (!mounted) return;'), 'camera shell must not use queue-only model button path');
check(review.includes('GaussDeferredModelInstallCallback'), 'review sheet must use async model install callback');
check(review.includes('LinearProgressIndicator'), 'review sheet must expose progress UI');
check(review.includes('Modeli indir'), 'review sheet must keep user-facing download action');
check(manifest.includes('<uses-permission android:name="android.permission.INTERNET" />'), 'AndroidManifest must grant INTERNET for user-tapped model download');
for (const dep of ['http:', 'crypto:', 'path_provider:']) {
  check(pubspec.includes(dep), `pubspec missing dependency: ${dep}`);
}
check(!buildGradle.includes('onnxruntime-android'), 'Q384R1 must not re-add ONNX Runtime Android AAR');
check(!buildGradle.includes('com.microsoft.onnxruntime'), 'Q384R1 must not re-add com.microsoft.onnxruntime dependency');

for (const rel of [
  'test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart',
  'docs/audit/V172_Q384R1_CAMERA_OCR_DEFERRED_MODEL_DOWNLOAD_ACTIVATION.md',
  'docs/audit/V172_Q384R1_CHANGED_FILES.md',
]) {
  check(exists(rel), `Q384R1 artifact missing: ${rel}`);
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

console.log('PASS verify_camera_ocr_deferred_model_download_activation_v172_q384r1');
