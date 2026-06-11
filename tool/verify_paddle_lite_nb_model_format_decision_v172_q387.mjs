#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_paddle_lite_nb_model_format_decision_v172_q387: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_paddle_lite_nb_model_format_decision_gate_q387.dart';
const testPath = 'test/v172_q387_paddle_lite_nb_model_format_decision_gate_test.dart';
const auditPath = 'docs/audit/V172_Q387_PADDLE_LITE_NB_MODEL_FORMAT_DECISION_GATE.md';
const changedPath = 'docs/audit/V172_Q387_CHANGED_FILES.md';
const mainPath = 'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt';
const manifestPath = 'assets/mathlive/manifest.json';
const jarPath = 'android/app/libs/PaddlePredictor.jar';

for (const required of [policyPath, testPath, auditPath, changedPath, mainPath, manifestPath, jarPath]) {
  check(exists(required), `missing Q387 required file: ${required}`);
}

const policy = read(policyPath);
const test = read(testPath);
const main = read(mainPath);
const audit = read(auditPath);
const changed = read(changedPath);
const readme = read('README.md');
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const manifest = JSON.parse(read(manifestPath));

for (const marker of [
  'V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE',
  "sourcePhase = 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE'",
  "currentDownloadedArtifactFormat = 'paddle-inference-directory'",
  "requiredAndroidArtifactFormat = 'paddle-lite-optimized-nb'",
  "requiredModelFileExtension = '.nb'",
  "selectedFutureLoadMethod = 'MobileConfig.setModelFromFile(.nb)'",
  "setModelFromFileMethodName = 'setModelFromFile'",
  "setModelFromBufferMethodName = 'setModelFromBuffer'",
  "setModelDirMethodName = 'setModelDir'",
  "nbModelRequiredBlockedReason = 'q387-paddle-lite-nb-model-required'",
  "setModelDirUnavailableReason = 'q387-current-paddlepredictor-jar-has-no-setModelDir'",
  'setModelDirClaimedAvailableByPackage = false',
  'inferenceDirectoryAcceptedForAndroidRuntime = false',
  'nbModelBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferencePassClaimedByQ387 = false',
  'androidRealDevicePassClaimedByQ387 = false',
  'fakeLatexCandidateAllowed = false',
  'keyboardQ382Touched = false',
  'graphHistorySolutionSolverTouched = false',
]) check(policy.includes(marker), `Q387 policy marker missing: ${marker}`);

for (const marker of [
  'gate blocks current inference-directory when setModelDir is not available',
  'q387-blocked-nb-model-required-current-jar-has-no-setModelDir',
  'gate permits only verified .nb path through setModelFromFile strategy',
  'native bridge adds Q387 evidence and avoids blind inference.pdiparams model load',
  'manifest records Q387 decision without bundling model or ONNX runtime',
]) check(test.includes(marker), `Q387 test marker missing: ${marker}`);

for (const marker of [
  'q387Phase = "V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE"',
  'q387RequiredAndroidArtifactFormat = "paddle-lite-optimized-nb"',
  'q387RequiredModelFileExtension = ".nb"',
  'q387SetModelDirMethodName = "setModelDir"',
  'q387NbModelRequiredBlockedReason = "q387-paddle-lite-nb-model-required"',
  'q387CurrentDownloadedArtifactFormat = q384R2ArtifactFormat',
  'q387FindPaddleLiteNbModelFile',
  'q387IsPaddleLiteNbModelFile',
  'q387CollectMobileConfigApiEvidence',
  'supportsSetModelDir',
  'q387CandidateNbModelFile',
  'q387PaddleLiteNbModelReady',
  'q387SelectedModelLoadStrategy',
  'q387ModelLoadBlockedBeforeAttempt',
  'q387ModelLoadBlockedReason',
  'q387-blocked-nb-model-required-current-jar-has-no-setModelDir',
  'q387-setModelFromFile-paddle-lite-nb',
  'q387ProductionInferencePassClaimed" to q387ProductionInferencePassClaimed',
]) check(main.includes(marker), `MainActivity Q387 marker missing: ${marker}`);

check(!main.includes('setModelFromFile" && it.parameterTypes.size == 1 }?.invoke(config, primaryModelFile.absolutePath)'), 'Q387 must remove blind setModelFromFile(inference.pdiparams) load');
check(main.includes('configClass.methods.firstOrNull { it.name == q387SetModelFromFileMethodName && it.parameterTypes.size == 1 }?.invoke(config, nbModelFile.absolutePath)'), 'Q387 must route setModelFromFile only through .nb candidate');
check(main.includes('if (resized !== bitmap && !resized.isRecycled)'), 'Q387 must recycle resized bitmap after tensor build');
check(main.includes('resized.recycle()'), 'Q387 resized bitmap recycle call missing');

check(manifest.cameraOcrPaddleLiteNbModelFormatDecisionLatestPhase === 'V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE', 'manifest latest Q387 phase missing');
const q387 = manifest.v172Q387PaddleLiteNbModelFormatDecisionGate;
check(q387?.phase === 'V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE', 'manifest Q387 phase mismatch');
check(q387?.currentDownloadedArtifactFormat === 'paddle-inference-directory', 'manifest Q387 current artifact mismatch');
check(q387?.requiredAndroidArtifactFormat === 'paddle-lite-optimized-nb', 'manifest Q387 required artifact mismatch');
check(q387?.requiredModelFileExtension === '.nb', 'manifest Q387 required extension missing');
check(q387?.setModelDirClaimedAvailableByPackage === false, 'manifest Q387 must not claim setModelDir available');
check(q387?.inferenceDirectoryAcceptedForAndroidRuntime === false, 'manifest Q387 must reject inference-directory for current Android runtime');
check(q387?.nbModelBundledInBaseApp === false, 'manifest Q387 must not bundle .nb model');
check(q387?.onnxRuntimeReintroducedInBaseApk === false, 'manifest Q387 must keep ONNX absent');
check(q387?.productionInferencePassClaimedByQ387 === false, 'manifest Q387 must not claim inference PASS');
check(q387?.androidRealDevicePassClaimedByQ387 === false, 'manifest Q387 must not claim Android device PASS');

for (const marker of ['Paddle Lite `.nb`', 'setModelDir', 'q387-paddle-lite-nb-model-required', 'No OCR/image-to-LaTeX/Android real-device PASS', 'recycles the resized bitmap']) {
  check(`${audit}\n${changed}\n${readme}`.includes(marker), `Q387 docs marker missing: ${marker}`);
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

console.log('PASS verify_paddle_lite_nb_model_format_decision_v172_q387');
