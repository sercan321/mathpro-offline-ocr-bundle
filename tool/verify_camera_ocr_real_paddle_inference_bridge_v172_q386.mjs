#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_camera_ocr_real_paddle_inference_bridge_v172_q386: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_camera_ocr_real_paddle_inference_bridge_q386.dart';
const testPath = 'test/v172_q386_camera_ocr_real_paddle_inference_bridge_test.dart';
const auditPath = 'docs/audit/V172_Q386_REAL_PADDLE_OCR_INFERENCE_BRIDGE.md';
const changedPath = 'docs/audit/V172_Q386_CHANGED_FILES.md';
for (const required of [policyPath, testPath, auditPath, changedPath]) check(exists(required), `missing Q386 file: ${required}`);

const policy = read(policyPath);
const test = read(testPath);
const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const audit = read(auditPath);
const changed = read(changedPath);

for (const marker of [
  'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE',
  "nativeBridgeMethod = 'realPaddleOcrInferenceBridgeQ386'",
  "q380BridgeEntry = 'q380-q386-real-paddle-inference-bridge'",
  'nativePaddleRuntimeLoadAttemptEnabled = true',
  'paddlePredictorModelLoadAttemptEnabled = true',
  'cameraImageDecodeAttemptEnabled = true',
  'adaptiveTensorPreprocessAttemptEnabled = true',
  'paddlePredictorRunAttemptEnabled = true',
  'outputDecoderReuseQ380 = true',
  'reviewRequiredBeforeWorkspaceImport = true',
  'directWorkspaceImportBlocked = true',
  'directSolveGraphSolutionHistoryBlocked = true',
  'fakeLatexCandidateAllowed = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'modelBinaryBundledInBaseApp = false',
  'productionInferencePassClaimedByQ386 = false',
  'androidRealDevicePassClaimedByQ386 = false',
]) check(policy.includes(marker), `Q386 policy marker missing: ${marker}`);

for (const marker of [
  'q386Phase',
  'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE',
  'q386BridgeMethod = "realPaddleOcrInferenceBridgeQ386"',
  '"realPaddleOcrInferenceBridgeQ386" -> result.success',
  'q386RealPaddleOcrInferenceBridge',
  'q380-q386-real-paddle-inference-bridge',
  'System.loadLibrary(q346PaddleLiteNativeLibraryName)',
  'Class.forName(q347PredictorClassName)',
  'setModelFromFile',
  'getInput',
  'q380BuildImageTensorValues',
  'run',
  'q386CollectPaddleOutputs',
  'q380DecodeLogitOrTokenOutputs',
  'q386-paddle-lite-model-load-failed-or-artifact-format-incompatible',
  'productionInferenceClaimedByQ386" to false',
  'workspaceImportAutoExecuted" to false',
  'solveGraphSolutionHistoryTouched" to false',
]) check(main.includes(marker), `MainActivity Q386 marker missing: ${marker}`);

for (const marker of [
  'native bridge wires Q386 into Q380/Q381 review flow',
  'productionInferenceClaimedByQ386" to false',
  'workspaceImportAutoExecuted" to false',
]) check(test.includes(marker), `Q386 test marker missing: ${marker}`);

check(manifest.cameraOcrRealPaddleInferenceBridgeLatestPhase === 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE', 'manifest latest Q386 phase missing');
const q386 = manifest.v172Q386CameraOcrRealPaddleInferenceBridge;
check(q386?.nativePaddleRuntimeLoadAttemptEnabled === true, 'manifest Q386 runtime load marker missing');
check(q386?.paddlePredictorRunAttemptEnabled === true, 'manifest Q386 run marker missing');
check(q386?.fakeLatexCandidateAllowed === false, 'manifest Q386 must block fake LaTeX');
check(q386?.ocrPassClaimedByPackage === false, 'manifest Q386 must not claim OCR PASS');
check(q386?.androidRealDevicePassClaimedByPackage === false, 'manifest Q386 must not claim Android real-device PASS');

for (const marker of ['Paddle Lite', 'setModelFromFile', 'q386-paddle-lite-model-load-failed-or-artifact-format-incompatible', 'No OCR/image-to-LaTeX/Android real-device PASS']) {
  check(`${audit}\n${changed}`.includes(marker), `Q386 audit/changed marker missing: ${marker}`);
}

for (const forbidden of ['onnxruntime-android', 'com.microsoft.onnxruntime']) check(!buildGradle.includes(forbidden), `ONNX Runtime must remain absent: ${forbidden}`);
for (const regex of [/^\s*google_mlkit_text_recognition\s*:/m, /^\s*onnxruntime/m, /^\s*pix2text/m]) check(!regex.test(pubspec), `forbidden OCR/runtime dependency returned: ${regex}`);

const forbiddenModelExt = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i;
const modelArtifacts = [];
const walk = (dir) => {
  for (const entry of fs.readdirSync(path.join(root, dir), { withFileTypes: true })) {
    const rel = path.posix.join(dir, entry.name);
    if (rel.includes('/build/') || rel.includes('/.dart_tool/') || rel.startsWith('docs/evidence/')) continue;
    if (entry.isDirectory()) walk(rel);
    else if (forbiddenModelExt.test(rel)) modelArtifacts.push(rel);
  }
};
walk('.');
check(modelArtifacts.length === 0, `base project must not bundle OCR model artifacts: ${modelArtifacts.join(', ')}`);

console.log('PASS verify_camera_ocr_real_paddle_inference_bridge_v172_q386');
