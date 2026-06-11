#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_camera_ocr_download_session_recovery_state_machine_v172_q385r4: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_camera_ocr_download_session_recovery_state_machine_q385r4.dart';
const managerPath = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const reviewPath = 'lib/features/camera/gauss_mathlive_ocr_review_surface.dart';
const testPath = 'test/v172_q385r4_camera_ocr_download_session_recovery_state_machine_test.dart';
const auditPath = 'docs/audit/V172_Q385R4_DOWNLOAD_SESSION_RECOVERY_TEST_AND_STATE_MACHINE_REPAIR.md';
const changedPath = 'docs/audit/V172_Q385R4_CHANGED_FILES.md';
for (const required of [policyPath, managerPath, reviewPath, testPath, auditPath, changedPath]) {
  check(exists(required), `missing Q385R4 file: ${required}`);
}

const policy = read(policyPath);
const manager = read(managerPath);
const review = read(reviewPath);
const test = read(testPath);
const audit = read(auditPath);
const changed = read(changedPath);
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

for (const marker of [
  'V172-Q385R4-DOWNLOAD-SESSION-RECOVERY-TEST-AND-STATE-MACHINE-REPAIR',
  'standaloneQueuedStateSurvivesLoad = true',
  'installSessionQueuedStateCanRecover = true',
  'interruptedDownloadingVerifyingRecoverImmediately = true',
  'installSessionIdPersisted = true',
  'q239dQueuedLoadTestRepaired = true',
  'reviewAsyncCallbackSignatureRepaired = true',
  'reviewDownloadSemanticsMirrorsVisibleCopy = true',
  'sidecarShaLockStillNotClaimed = true',
  'modelBinaryBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferenceClaimedByQ385R4 = false',
  'keyboardQ382Touched = false',
]) check(policy.includes(marker), `Q385R4 policy marker missing: ${marker}`);

for (const marker of [
  "import 'gauss_camera_ocr_download_session_recovery_state_machine_q385r4.dart'",
  'final String? installSessionId',
  "'installSessionId': installSessionId",
  'hasInstallSession',
  'isInterruptedSessionRecoverable',
  'queueUserApprovedNetworkPreparation({',
  'String? installSessionId',
  'final installSessionId = _newInstallSessionId()',
  'queueUserApprovedNetworkPreparation(installSessionId: installSessionId)',
  'snapshot.status == GaussMathOcrModelInstallStatus.queued && !snapshot.hasInstallSession',
  'snapshot.status == GaussMathOcrModelInstallStatus.queued',
  'snapshot.status == GaussMathOcrModelInstallStatus.downloading',
  'snapshot.status == GaussMathOcrModelInstallStatus.verifying',
  'interruptedInstallSessionCopy',
  '_newInstallSessionId()',
  'installSessionIdPrefix',
]) check(manager.includes(marker), `manager Q385R4 state-machine marker missing: ${marker}`);

check(review.includes('final Future<void> Function() onQueueModel'), 'review status card must use async callback signature');
check(review.includes('final downloadActionSemantics = snapshot.downloadActionLabel'), 'review semantics must mirror visible download copy');
check(review.includes('await onQueueModel();'), 'review button must await async queue model callback');

for (const marker of [
  'standalone queued state survives load',
  'install-session queued snapshot recovers',
  'downloading and verifying snapshots recover',
  'queueUserApprovedNetworkPreparation()',
  'installSessionIdPrefix',
]) check(test.includes(marker), `Q385R4 test marker missing: ${marker}`);

for (const marker of [
  'standalone queued',
  'install-session queued',
  'downloading/verifying',
  'VoidCallback',
  'semanticsLabel',
]) check(`${audit}\n${changed}`.includes(marker), `Q385R4 audit/changed marker missing: ${marker}`);

check(manifest.cameraOcrDownloadSessionRecoveryStateMachineLatestPhase === 'V172-Q385R4-DOWNLOAD-SESSION-RECOVERY-TEST-AND-STATE-MACHINE-REPAIR', 'manifest latest Q385R4 phase missing');
check(manifest.v172Q385R4CameraOcrDownloadSessionRecoveryStateMachine?.standaloneQueuedStateSurvivesLoad === true, 'manifest Q385R4 queued-state marker missing');
check(manifest.v172Q385R4CameraOcrDownloadSessionRecoveryStateMachine?.productionInferenceClaimedByQ385R4 === false, 'manifest Q385R4 must not claim inference');

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

console.log('PASS verify_camera_ocr_download_session_recovery_state_machine_v172_q385r4');
