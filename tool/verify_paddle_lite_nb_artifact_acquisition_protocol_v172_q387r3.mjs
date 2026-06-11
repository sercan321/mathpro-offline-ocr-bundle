#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_paddle_lite_nb_artifact_acquisition_protocol_v172_q387r3: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';
const managerPath = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const testPath = 'test/v172_q387r3_paddle_lite_nb_artifact_acquisition_protocol_test.dart';
const auditPath = 'docs/audit/V172_Q387R3_PADDLE_LITE_NB_ARTIFACT_ACQUISITION_CONVERSION_PROTOCOL.md';
const changedPath = 'docs/audit/V172_Q387R3_CHANGED_FILES.md';
const manifestPath = 'assets/mathlive/manifest.json';

for (const required of [policyPath, managerPath, testPath, auditPath, changedPath, manifestPath]) {
  check(exists(required), `missing Q387R3 required file: ${required}`);
}

const policy = read(policyPath);
const manager = read(managerPath);
const test = read(testPath);
const audit = read(auditPath);
const changed = read(changedPath);
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const manifest = JSON.parse(read(manifestPath));

for (const marker of [
  'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL',
  "sourcePhase = 'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING'",
  'REAL_NB_ARTIFACT_ACQUISITION_PROTOCOL_READY_BUT_VERIFIED_NB_BINARY_NOT_ACQUIRED',
  "sourceArtifactKind = 'paddle-inference-directory'",
  "requiredOutputArtifactKind = 'paddle-lite-optimized-nb'",
  "requiredConversionTool = 'paddle_lite_opt'",
  "requiredAndroidTarget = 'android-arm64-v8a'",
  "requiredRuntimeLoadMethod = 'MobileConfig.setModelFromFile(.nb)'",
  "verifiedNbArtifactNotAcquiredBlockedReason = 'q387r3-verified-paddle-lite-nb-artifact-not-acquired'",
  "conversionToolEvidenceRequiredBlockedReason = 'q387r3-conversion-tool-evidence-required'",
  "conversionCommandRequiredBlockedReason = 'q387r3-conversion-command-required'",
  "sourceInferenceFilesRequiredBlockedReason = 'q387r3-source-inference-files-required'",
  "q387R2ProductionBindingBlockedReason = 'q387r3-q387r2-production-binding-blocked-until-real-nb-evidence'",
  'requiredSourceInferenceFiles',
  "'config.json'",
  "'inference.json'",
  "'inference.yml'",
  "'inference.pdiparams'",
  'officialPreoptimizedNbArtifactFoundInQ387R3 = false',
  'conversionProtocolRequired = true',
  'conversionRunsOffDeviceOnly = true',
  'conversionOutputMustBeDownloadOnly = true',
  'q387R2ProductionSourceBindingAllowedWithoutEvidence = false',
  'q388RealInferenceAllowedWithoutVerifiedNb = false',
  'modelBinaryBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferencePassClaimedByQ387R3 = false',
  'androidRealDevicePassClaimedByQ387R3 = false',
  'fakeLatexCandidateAllowed = false',
  'keyboardQ382Touched = false',
  'graphHistorySolutionSolverTouched = false',
  'GaussPaddleLiteNbArtifactAcquisitionProtocolQ387R3Gate.evaluate',
  'canBindToQ387R2ProductionSource',
  'canProceedToQ388RealInference',
]) check(policy.includes(marker), `Q387R3 policy marker missing: ${marker}`);

for (const marker of [
  "import 'gauss_paddle_lite_nb_artifact_acquisition_protocol_q387r3.dart';",
  'androidRuntimeNbAcquisitionProtocolPhase',
  'androidRuntimeNbAcquisitionBlockedReason',
  'productionPaddleLiteNbAcquiredForAndroidRuntime = false',
  'Q387R3 conversion/acquisition',
]) check(manager.includes(marker), `manager Q387R3 marker missing: ${marker}`);

for (const marker of [
  'blocks Q388 while no verified .nb acquisition evidence exists',
  'accepts only complete conversion evidence for Q387R2 production binding',
  'rejects incomplete conversion/source evidence',
  'preserves download-only, no fake OCR, and protected-scope claims',
]) check(test.includes(marker), `Q387R3 test marker missing: ${marker}`);

check(manifest.cameraOcrPaddleLiteNbArtifactAcquisitionProtocolLatestPhase === 'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL', 'manifest latest Q387R3 phase missing');
const q387r3 = manifest.v172Q387R3PaddleLiteNbArtifactAcquisitionConversionProtocol;
check(q387r3?.phase === 'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL', 'manifest Q387R3 phase mismatch');
check(q387r3?.sourcePhase === 'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING', 'manifest Q387R3 source mismatch');
check(q387r3?.officialPreoptimizedNbArtifactFoundInQ387R3 === false, 'manifest must not claim official preoptimized .nb was found');
check(q387r3?.conversionProtocolRequired === true, 'manifest must require conversion protocol');
check(q387r3?.q387R2ProductionSourceBindingAllowedWithoutEvidence === false, 'manifest must block Q387R2 production binding without evidence');
check(q387r3?.q388RealInferenceAllowedWithoutVerifiedNb === false, 'manifest must block Q388 without verified .nb');
check(q387r3?.modelBinaryBundledInBaseApp === false, 'manifest must keep model out of base app');
check(q387r3?.fakeLatexCandidateAllowed === false, 'manifest must not allow fake OCR');
check(Array.isArray(q387r3?.requiredSourceInferenceFiles), 'manifest source files array missing');
for (const sourceFile of ['config.json', 'inference.json', 'inference.yml', 'inference.pdiparams']) {
  check(q387r3.requiredSourceInferenceFiles.includes(sourceFile), `manifest missing required source file: ${sourceFile}`);
}

for (const marker of ['Q387R3', 'q387r3-verified-paddle-lite-nb-artifact-not-acquired', 'paddle_lite_opt', 'does not invent', 'No keyboard layout/order/labels']) {
  check(`${audit}\n${changed}\n${readme}`.includes(marker), `Q387R3 docs/README marker missing: ${marker}`);
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

console.log('PASS verify_paddle_lite_nb_artifact_acquisition_protocol_v172_q387r3');
