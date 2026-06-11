#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_paddle_lite_nb_source_download_install_binding_v172_q387r2: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_paddle_lite_nb_download_install_binding_q387r2.dart';
const managerPath = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const testPath = 'test/v172_q387r2_paddle_lite_nb_source_download_install_binding_test.dart';
const auditPath = 'docs/audit/V172_Q387R2_PADDLE_LITE_NB_SOURCE_DOWNLOAD_INSTALL_BINDING.md';
const changedPath = 'docs/audit/V172_Q387R2_CHANGED_FILES.md';
const manifestPath = 'assets/mathlive/manifest.json';

for (const required of [policyPath, managerPath, testPath, auditPath, changedPath, manifestPath]) {
  check(exists(required), `missing Q387R2 required file: ${required}`);
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
  'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING',
  "sourcePhase = 'V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE'",
  'REAL_NB_DOWNLOAD_INSTALL_WORKER_READY_BUT_PRODUCTION_ARTIFACT_SOURCE_NOT_BOUND',
  "productionNbSourceMissingBlockedReason = 'q387r2-production-paddle-lite-nb-source-not-bound'",
  "q387R1EvidenceRejectedBlockedReason = 'q387r2-q387r1-nb-evidence-rejected'",
  "contentLengthTooSmallBlockedReason = 'q387r2-nb-content-length-too-small'",
  "downloadedArtifactTooSmallBlockedReason = 'q387r2-nb-artifact-too-small'",
  "sha256MismatchBlockedReason = 'q387r2-nb-sha256-mismatch'",
  'productionNbDownloadUrlBound = false',
  'productionNbSha256Bound = false',
  'productionNbSizeBound = false',
  'downloadInstallWorkerImplemented = true',
  'q387R1EvidenceGateRequiredBeforeDownload = true',
  'writesQ387R1NativeManifest = true',
  'writesQ387R2InstallManifest = true',
  'legacyInferenceDirectoryPromotedToAndroidRuntime = false',
  'modelBinaryBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferencePassClaimedByQ387R2 = false',
  'androidRealDevicePassClaimedByQ387R2 = false',
  'fakeLatexCandidateAllowed = false',
  'keyboardQ382Touched = false',
  'graphHistorySolutionSolverTouched = false',
  'installFromVerifiedSource',
  'GaussPaddleLiteNbArtifactManifestQ387R1Gate.evaluate',
  'q387r1_paddle_lite_nb_manifest.json',
  'q387r2_paddle_lite_nb_install_manifest.json',
]) check(policy.includes(marker), `Q387R2 policy/worker marker missing: ${marker}`);

for (const marker of [
  "import 'gauss_paddle_lite_nb_download_install_binding_q387r2.dart';",
  'androidRuntimeNbDownloadInstallPhase',
  'androidRuntimeNbProductionSourceBlockedReason',
  'productionPaddleLiteNbDownloadUrlBound',
  'installVerifiedPaddleLiteNbModelQ387R2',
  'GaussQ387R2PaddleLiteNbDownloadInstallWorker.installFromVerifiedSource',
  'Android Paddle Lite için gerçek .nb model kaynağı henüz bağlı değil',
]) check(manager.includes(marker), `manager Q387R2 marker missing: ${marker}`);

for (const marker of [
  'keeps production .nb source unbound until real URL SHA size provenance exists',
  'binds only sources that satisfy the Q387R1 evidence gate',
  'rejects placeholder or non-nb sources before download is allowed',
  'preserves download-only, no fake OCR, and protected-scope claims',
]) check(test.includes(marker), `Q387R2 test marker missing: ${marker}`);

check(manifest.cameraOcrPaddleLiteNbSourceDownloadInstallLatestPhase === 'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING', 'manifest latest Q387R2 phase missing');
const q387r2 = manifest.v172Q387R2PaddleLiteNbSourceDownloadInstallBinding;
check(q387r2?.phase === 'V172-Q387R2-PADDLE-LITE-NB-SOURCE-DOWNLOAD-INSTALL-BINDING', 'manifest Q387R2 phase mismatch');
check(q387r2?.productionNbDownloadUrlBound === false, 'manifest must not claim production .nb URL');
check(q387r2?.productionNbSha256Bound === false, 'manifest must not claim production .nb SHA');
check(q387r2?.downloadInstallWorkerImplemented === true, 'manifest Q387R2 worker flag missing');
check(q387r2?.q387R1EvidenceGateRequiredBeforeDownload === true, 'manifest must require Q387R1 evidence');
check(q387r2?.writesQ387R1NativeManifest === true, 'manifest must write Q387R1 native manifest');
check(q387r2?.modelBinaryBundledInBaseApp === false, 'manifest must keep .nb out of base app');
check(q387r2?.productionInferencePassClaimedByQ387R2 === false, 'manifest must not claim OCR PASS');
check(q387r2?.q387R3OrQ388AllowedWithoutRealNbArtifact === false, 'manifest must block next runtime phase without real .nb artifact');

for (const marker of ['Q387R2', 'q387r2-production-paddle-lite-nb-source-not-bound', 'download/install worker', 'does not invent', 'No keyboard layout/order/labels']) {
  check(`${audit}\n${changed}\n${readme}`.includes(marker), `Q387R2 docs/README marker missing: ${marker}`);
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

console.log('PASS verify_paddle_lite_nb_source_download_install_binding_v172_q387r2');
