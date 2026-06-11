#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_paddle_runtime_abi_trim_test_download_guard_repair_v172_q385r1: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const worker = read('lib/features/camera/gauss_camera_ocr_deferred_model_download_q384r1.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const policy = read('lib/features/camera/gauss_paddle_runtime_abi_trim_test_download_guard_repair_q385r1.dart');
const q384r1Test = read('test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart');
const q385r1Test = read('test/v172_q385r1_paddle_runtime_abi_trim_test_download_guard_repair_test.dart');
const q239dTest = read('test/v172_q239d_deferred_math_ocr_model_manager_test.dart');
const q239eTest = read('test/v172_q239e_mathlive_ocr_review_surface_test.dart');
const q244r1Test = read('test/v172_q244r1_camera_regression_flutter_hygiene_test.dart');
const changed = read('docs/audit/V172_Q385R1_CHANGED_FILES.md');
const audit = read('docs/audit/V172_Q385R1_PADDLE_RUNTIME_ABI_TRIM_TEST_AND_DOWNLOAD_GUARD_REPAIR.md');
const q385Changed = read('docs/audit/V172_Q385_CHANGED_FILES.md');
const manifest = read('android/app/src/main/AndroidManifest.xml');
const buildGradle = read('android/app/build.gradle');

for (const required of [
  'V172-Q385R1-PADDLE-RUNTIME-ABI-TRIM-TEST-AND-DOWNLOAD-GUARD-REPAIR',
  'q384r1MinimumSizeFlutterTestRepaired = true',
  'wifiOnlyClaimRemoved = true',
  'actualWifiGateImplemented = false',
  'sidecarMinimumsRelaxedToAvoidFalseRejects = true',
  'sidecarDocumentedSizeMetadataAdded = true',
  'contentLengthSanityCheckImplemented = true',
  'sidecarShaLockClaimed = false',
  'productionInferenceClaimedByQ385R1 = false',
  'keyboardQ382Touched = false',
]) {
  check(policy.includes(required), `Q385R1 policy marker missing: ${required}`);
}

check(q384r1Test.includes('greaterThanOrEqualTo(200 * 1024 * 1024)'), 'Q384R1 primary artifact test must allow the locked 200 MiB lower bound');
check(!q384r1Test.includes('greaterThan(200 * 1024 * 1024)'), 'Q384R1 stale greaterThan expectation must be removed');

check(q239dTest.includes('queueUserApprovedNetworkPreparation'), 'Q239D stale test must use the successor-approved network queue API');
check(q239dTest.includes("contains('İndirme kuyruğunda')"), 'Q239D stale test must expect the Q385R1 queued copy');
check(!q239dTest.includes("contains('Wi‑Fi kuyruğu')"), 'Q239D stale test must not expect old Wi-Fi queue text');
check(q239eTest.includes("contains('İndirme kuyruğunda')"), 'Q239E stale test must expect the Q385R1 queued copy');
check(!q239eTest.includes("contains('Wi‑Fi kuyruğu')"), 'Q239E stale test must not expect old Wi-Fi queue text');
check(q244r1Test.includes('queueUserApprovedNetworkPreparation'), 'Q244R1 stale hygiene test must use the successor-approved network queue API');

for (const required of [
  'GaussCameraOcrDownloadGuardRepairQ385R1Policy',
  "networkPolicy = 'user-approved-internet-required-large-download'",
  'wifiOnlyClaimRemoved = true',
  'contentLengthSanityCheckImplemented = true',
  "documentedSizeLabel: '3.95 MB'",
  "documentedSizeLabel: '505 kB'",
  "documentedSizeLabel: '2.24 MB'",
  'q385r1-content-length-too-small',
]) {
  check(worker.includes(required), `Q384R1 worker Q385R1 repair marker missing: ${required}`);
}

for (const required of [
  "return 'İndirme kuyruğunda';",
  'queueUserApprovedNetworkPreparation',
  'Q385R1 removed the false Wi-Fi-only claim',
  'wifiOnly: false',
]) {
  check(manager.includes(required), `manager network-copy repair missing: ${required}`);
}
check(!manager.includes("return 'Wi‑Fi kuyruğunda';"), 'manager must not expose false Wi-Fi-only queued label');
check(!manager.includes("networkPolicy = 'wifi-only-by-default'"), 'manager manifest must not claim Wi-Fi-only default after Q385R1');

for (const required of [
  'INTERNET permission was introduced by Q384R1 for the real deferred model download',
  'Q385 did not add a new permission beyond Q384R1',
  'armeabi-v7a source fallback remains present but is not packaged by Q385 release abiFilters',
]) {
  check(q385Changed.includes(required), `Q385 changed-files clarification missing: ${required}`);
}

for (const required of [
  'V172_Q385R1_PADDLE_RUNTIME_ABI_TRIM_TEST_AND_DOWNLOAD_GUARD_REPAIR.md',
  'test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart',
  'GaussPaddleRuntimeAbiTrimTestDownloadGuardRepairQ385R1Policy',
  'No OCR inference, ONNX Runtime, bundled model file, keyboard/Q382, MORE, Graph, History, Solution, or Solver behavior was changed',
]) {
  check(changed.includes(required) || audit.includes(required) || policy.includes(required) || q385r1Test.includes(required), `Q385R1 audit marker missing: ${required}`);
}

check(manifest.includes('<uses-permission android:name="android.permission.INTERNET" />'), 'INTERNET permission must remain present for Q384R1 user-tapped download');
check(buildGradle.includes("abiFilters 'arm64-v8a'"), 'Q385 arm64 ABI filter must remain present');
check(!buildGradle.includes('onnxruntime-android'), 'ONNX Runtime must remain absent');
check(exists('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so'), 'armeabi-v7a source fallback must remain explicit until measured release evidence supports removal');
check(exists('test/v172_q385r1_paddle_runtime_abi_trim_test_download_guard_repair_test.dart'), 'Q385R1 Flutter test missing');
check(exists('docs/audit/V172_Q385R1_CHANGED_FILES.md'), 'Q385R1 changed-files doc missing');

console.log('PASS verify_paddle_runtime_abi_trim_test_download_guard_repair_v172_q385r1');
