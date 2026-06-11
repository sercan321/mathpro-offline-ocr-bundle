#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (message) => {
  console.error(`CAMERA_SUCCESSOR_TEST_METADATA_HYGIENE_Q244R7_FAIL: ${message}`);
  process.exit(1);
};

const pubspec = read('pubspec.yaml');
const policy = read('lib/features/camera/gauss_camera_successor_test_metadata_hygiene_policy.dart');
const test = read('test/v172_q244r7_camera_successor_test_metadata_hygiene_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const staleTestFiles = [
  'test/v172_q239a_workspace_camera_entry_button_test.dart',
  'test/v172_q239b_camera_permission_capture_shell_test.dart',
  'test/v172_q239c_formula_crop_scan_frame_test.dart',
  'test/v172_q239d_deferred_math_ocr_model_manager_test.dart',
  'test/v172_q239e_mathlive_ocr_review_surface_test.dart',
  'test/v172_q240_ocr_engine_benchmark_court_test.dart',
  'test/v172_q243_camera_ux_premium_polish_test.dart',
];

if (!policy.includes('V172-Q244R7-CAMERA-SUCCESSOR-TEST-METADATA-HYGIENE-REPAIR')) fail('Q244R7 policy marker missing');
if (!policy.includes('triggeredByUserSideFlutterTestStaleCameraExpectation = true')) fail('policy must record user-side stale test trigger');
if (!policy.includes("activeCameraPackage = '0.10.6'")) fail('policy must record active camera package');
if (!policy.includes("activeCameraAndroidImplementation = '0.10.9+3'")) fail('policy must record active camera_android implementation');
if (!policy.includes('runtimeCameraShellChanged = false')) fail('Q244R7 must be test metadata hygiene only');
if (!policy.includes('realOcrRuntimeAdded = false')) fail('Q244R7 must not add OCR runtime');
if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must remain on Q244R6 camera 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must remain on Q244R6 camera_android 0.10.9+3');
if (pubspec.includes('camera_android_camerax')) fail('pubspec must not include CameraX after user-side build failures');

for (const rel of staleTestFiles) {
  const source = read(rel);
  if (!source.includes('0\\.11\\.0|0\\.10\\.6')) fail(`${rel} must accept Q244R6 successor camera version`);
  if (!source.includes("isNot(contains('camera_android_camerax'))")) fail(`${rel} must explicitly block CameraX successor regression`);
  if (source.includes("RegExp(r'^\\s*camera:\\s*\\^?0\\.11\\.0\\s*'")) fail(`${rel} still contains stale exact 0.11.0-only regex`);
}
if (!test.includes('v172_q239d_deferred_math_ocr_model_manager_test.dart')) fail('Q244R7 test must cover stale Q239D failure file');
if (manifest.cameraSuccessorTestMetadataHygieneLatestPhase !== 'V172-Q244R7-CAMERA-SUCCESSOR-TEST-METADATA-HYGIENE-REPAIR') {
  fail('manifest latest phase missing for Q244R7');
}
const q244r7 = manifest.v172Q244R7CameraSuccessorTestMetadataHygiene;
if (!q244r7 || q244r7.activeCameraPackage !== '0.10.6' || q244r7.activeCameraAndroidImplementation !== '0.10.9+3') {
  fail('manifest Q244R7 dependency record missing');
}
if (q244r7.runtimeCameraShellChanged !== false || q244r7.pubspecChanged !== false || q244r7.androidBuildFilesChanged !== false) {
  fail('manifest must record Q244R7 as test metadata hygiene only');
}
console.log('CAMERA_SUCCESSOR_TEST_METADATA_HYGIENE_Q244R7_STATIC_READY_BUT_REAL_FLUTTER_TEST_AND_ANDROID_RETEST_REQUIRED');
