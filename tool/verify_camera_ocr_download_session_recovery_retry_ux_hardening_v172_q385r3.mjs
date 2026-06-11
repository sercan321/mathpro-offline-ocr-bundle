#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_camera_ocr_download_session_recovery_retry_ux_hardening_v172_q385r3: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policy = read('lib/features/camera/gauss_camera_ocr_download_session_recovery_retry_ux_hardening_q385r3.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const worker = read('lib/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart');
const review = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const test = read('test/v172_q385r3_camera_ocr_download_session_recovery_retry_ux_hardening_test.dart');
const changed = read('docs/audit/V172_Q385R3_CHANGED_FILES.md');
const audit = read('docs/audit/V172_Q385R3_CAMERA_OCR_DOWNLOAD_SESSION_RECOVERY_RETRY_UX_HARDENING.md');
const buildGradle = read('android/app/build.gradle');

for (const required of [
  'V172-Q385R3-CAMERA-OCR-DOWNLOAD-SESSION-RECOVERY-RETRY-UX-HARDENING',
  'processLocalActiveInstallGuardImplemented = true',
  'activeSnapshotWithoutRunningProcessRecoversImmediately = true',
  'activeProgressPersistenceImplemented = true',
  'retryButtonCopyImplemented = true',
  'generatedToolReportsDeclaredInAudit = true',
  'sidecarShaLockStillNotClaimed = true',
  'modelBinaryBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferenceClaimedByQ385R3 = false',
  'keyboardQ382Touched = false',
]) check(policy.includes(required), `Q385R3 policy marker missing: ${required}`);

for (const required of [
  "import 'gauss_camera_ocr_download_session_recovery_retry_ux_hardening_q385r3.dart'",
  'static bool _activeInstallRunning = false',
  'debugActiveInstallRunningForQ385R3',
  'if (_activeInstallRunning) return snapshot',
  'activeSnapshotWithoutRunningProcessRecoversImmediately',
  '_persistActiveProgressSnapshot',
  'activeProgressPersistCadence',
  'retryAfterInterruptedSessionCopy',
  'downloadActionLabel',
]) check(manager.includes(required), `manager Q385R3 session/retry marker missing: ${required}`);

check(worker.includes('FutureOr<void> Function(double progress)? onProgress'), 'worker must support awaited progress persistence');
check(worker.includes('await Future<void>.value(onProgress?.call('), 'worker must await progress callback');
check(worker.includes('await Future<void>.value(onArtifactProgress(downloaded))'), 'worker must await artifact progress callback');
check(review.includes('Text(snapshot.downloadActionLabel') && review.includes('downloadActionSemantics'), 'review button must use snapshot retry/active/default copy with semantic legacy download marker');

for (const required of [
  'active persisted state recovers immediately',
  'download action copy distinguishes initial, active, and retry states',
  'debugActiveInstallRunningForQ385R3',
]) check(test.includes(required), `Q385R3 Flutter test marker missing: ${required}`);

for (const required of [
  'process-local active install guard',
  'immediate retry',
  'active progress persistence',
  'tool/reports',
]) check(changed.includes(required) || audit.includes(required), `Q385R3 audit/changed marker missing: ${required}`);

for (const forbidden of ['onnxruntime-android', 'com.microsoft.onnxruntime']) check(!buildGradle.includes(forbidden), `ONNX Runtime must remain absent: ${forbidden}`);
check(exists('test/v172_q385r3_camera_ocr_download_session_recovery_retry_ux_hardening_test.dart'), 'Q385R3 Flutter test missing');
check(exists('docs/audit/V172_Q385R3_CAMERA_OCR_DOWNLOAD_SESSION_RECOVERY_RETRY_UX_HARDENING.md'), 'Q385R3 audit doc missing');
check(exists('docs/audit/V172_Q385R3_CHANGED_FILES.md'), 'Q385R3 changed-files doc missing');

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

console.log('PASS verify_camera_ocr_download_session_recovery_retry_ux_hardening_v172_q385r3');
