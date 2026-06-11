#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_camera_ocr_download_compile_legacy_verifier_recovery_v172_q385r2: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const worker = read('lib/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const policy = read('lib/features/camera/gauss_camera_ocr_download_compile_legacy_verifier_recovery_q385r2.dart');
const shell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const review = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const q239dVerifier = read('tool/verify_deferred_math_ocr_model_manager_v172_q239d.mjs');
const q239eVerifier = read('tool/verify_mathlive_ocr_review_surface_v172_q239e.mjs');
const q244r1Verifier = read('tool/verify_camera_regression_flutter_hygiene_v172_q244r1.mjs');
const q385r2Test = read('test/v172_q385r2_camera_ocr_download_compile_legacy_verifier_recovery_test.dart');
const changed = read('docs/audit/V172_Q385R2_CHANGED_FILES.md');
const audit = read('docs/audit/V172_Q385R2_CAMERA_OCR_DOWNLOAD_COMPILE_LEGACY_VERIFIER_RECOVERY_REPAIR.md');
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');

for (const required of [
  'V172-Q385R2-CAMERA-OCR-DOWNLOAD-COMPILE-LEGACY-VERIFIER-RECOVERY-REPAIR',
  'accumulatorSinkCompileRiskRepaired = true',
  'legacyCameraVerifiersMadeSuccessorAware = true',
  'staleQueuedDownloadRecoveryImplemented = true',
  'downloadRequestTimeoutImplemented = true',
  'downloadStreamIdleTimeoutImplemented = true',
  'primaryShaCopySeparatedFromSidecarSizeCopy = true',
  'sidecarShaLockStillNotClaimed = true',
  'modelBinaryBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferenceClaimedByQ385R2 = false',
  'keyboardQ382Touched = false',
]) check(policy.includes(required), `Q385R2 policy marker missing: ${required}`);

check(!worker.includes('crypto.AccumulatorSink'), 'Q385R2 must remove crypto.AccumulatorSink compile risk');
check(worker.includes('class _GaussQ385R2DigestCaptureSink implements Sink<crypto.Digest>'), 'Q385R2 custom digest sink missing');
check(worker.includes("import 'dart:async';"), 'Q385R2 worker must import dart:async for timeout handling');
check(worker.includes('.timeout(\n      GaussCameraOcrDownloadCompileLegacyVerifierRecoveryQ385R2Policy.requestTimeout'), 'Q385R2 request timeout missing');
check(worker.includes('response.stream.timeout('), 'Q385R2 stream idle timeout missing');
check(worker.includes('q385r2VerificationCopy'), 'Q385R2 install manifest verification-copy marker missing');
check(worker.includes("'primarySha256Verified': true"), 'Q385R2 must record primary SHA verification explicitly');
check(worker.includes("'sidecarShaLockClaimed': false"), 'Q385R2 must not claim sidecar SHA locks');

for (const required of [
  'stateUpdatedAtIso',
  'canRetryDownload',
  '_recoverStaleActiveSnapshot',
  'staleActiveStateGracePeriod',
  'Önceki model indirme oturumu tamamlanamadı',
  'Model indirmesi zaman aşımına uğradı',
  'Ana model dosyası SHA256',
  'yan dosyalar varlık ve boyut',
]) check(manager.includes(required), `manager Q385R2 recovery/copy marker missing: ${required}`);

for (const copy of [
  'ana model dosyası SHA256 ile doğrulandı; yan dosyalar varlık/boyut kontrolünden geçti',
  'Ana model SHA256 ile doğrulandı; yan dosyalar varlık/boyut kontrolünden geçti',
]) check(shell.includes(copy) || review.includes(copy), `camera/review honest SHA copy missing: ${copy}`);

for (const verifier of [q239dVerifier, q239eVerifier]) {
  check(verifier.includes('successorActive'), 'legacy Q239 verifier must detect successor mode');
  check(verifier.includes('SUCCESSOR_AWARE_STATIC_READY'), 'legacy Q239 verifier must report successor-aware status');
  check(!verifier.includes("networkPolicy = 'wifi-only-by-default'\",\n  'requiresSha256BeforeReady"), 'legacy verifier must not hard-pin old Wi-Fi-only manager marker without successor gate');
}
check(q244r1Verifier.includes('q239d_copy_contains_sonraki_faz_or_successor_download_recovery'), 'Q244R1 verifier must allow successor download recovery marker');

for (const required of [
  'stale active download state',
  'AccumulatorSink compile-risk',
  'legacy verifier',
  'timeout',
  'primary SHA',
  'sidecar size',
]) check(q385r2Test.includes(required) || audit.includes(required) || changed.includes(required), `Q385R2 test/audit marker missing: ${required}`);

for (const forbidden of ['onnxruntime-android', 'com.microsoft.onnxruntime']) check(!buildGradle.includes(forbidden), `ONNX Runtime must remain absent: ${forbidden}`);
for (const dep of ['http:', 'crypto:', 'path_provider:']) check(pubspec.includes(dep), `Q384/Q385 download deps must remain present: ${dep}`);
check(exists('test/v172_q385r2_camera_ocr_download_compile_legacy_verifier_recovery_test.dart'), 'Q385R2 Flutter test missing');
check(exists('docs/audit/V172_Q385R2_CAMERA_OCR_DOWNLOAD_COMPILE_LEGACY_VERIFIER_RECOVERY_REPAIR.md'), 'Q385R2 audit doc missing');
check(exists('docs/audit/V172_Q385R2_CHANGED_FILES.md'), 'Q385R2 changed-files doc missing');

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

console.log('PASS verify_camera_ocr_download_compile_legacy_verifier_recovery_v172_q385r2');
