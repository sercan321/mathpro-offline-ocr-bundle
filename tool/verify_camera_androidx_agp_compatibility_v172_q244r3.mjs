#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (message) => {
  console.error(`CAMERA_ANDROIDX_AGP_COMPATIBILITY_Q244R3_FAIL: ${message}`);
  process.exit(1);
};

const pubspec = read('pubspec.yaml');
// Q244R6 successor: camera 0.10.6 + camera_android 0.10.9+3 avoids CameraX transitive build and old Registrar failures.
const policy = read('lib/features/camera/gauss_camera_androidx_agp_compatibility_policy.dart');
const q239bVerifier = read('tool/verify_camera_permission_capture_shell_v172_q239b.mjs');
const q244Verifier = read('tool/verify_camera_regression_court_v172_q244.mjs');
const test = read('test/v172_q244r3_camera_androidx_agp_compatibility_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

if (!policy.includes('V172-Q244R3-CAMERA-ANDROIDX-AGP-COMPATIBILITY-REPAIR')) {
  fail('Q244R3 policy marker missing');
}
if (!/^\s*camera\s*:\s*(?:0\.11\.0|0\.10\.6)\s*$/m.test(pubspec)) {
  fail('pubspec must pin camera to exact 0.11.0 or Q244R6 successor 0.10.6');
}
if (!/^\s*camera_android\s*:\s*(?:0\.10\.8\+18|0\.10\.9\+3)\s*$/m.test(pubspec)) {
  fail('Q244R4 successor must opt into camera_android 0.10.8+18');
}
if (pubspec.includes('camera_android_camerax') || /^\s*dependency_overrides\s*:\s*$/m.test(pubspec)) {
  fail('Q244R4 successor must remove CameraX override after Kotlin metadata failure');
}
if (/^\s*camera\s*:\s*\^0\.11\.0\s*$/m.test(pubspec)) {
  fail('pubspec must not use floating camera ^0.11.0 because it resolves to CameraX artifacts requiring newer AGP');
}
if (pubspec.includes('camera_android_camerax: ^0.6.30') || pubspec.includes('camera_android_camerax: 0.6.30')) {
  fail('pubspec must not allow camera_android_camerax 0.6.30');
}
if (pubspec.includes('com.android.application version "8.6.0"')) {
  fail('AGP upgrade is intentionally not part of Q244R3');
}
for (const forbidden of ['google_mlkit_text_recognition', 'onnxruntime', 'pix2text', 'paddleocr', 'flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden OCR/download dependency found: ${forbidden}`);
}
if (!q239bVerifier.includes('\\^?0\\.11\\.0') && !q239bVerifier.includes('0\\.11\\.0')) {
  fail('Q239B verifier must accept the AGP-safe camera pin');
}
if (!q244Verifier.includes('\\^?0\\.11\\.0') && !q244Verifier.includes('0\\.11\\.0')) {
  fail('Q244 verifier must accept the AGP-safe camera pin');
}
if (!test.includes('camera_android') || (!test.includes('0\\.10\\.8\\+18') && !test.includes('0\\.10\\.9\\+3'))) {
  fail('Q244R3 successor test must assert camera_android opt-in or Q244R6 successor');
}
if (manifest.cameraAndroidxAgpCompatibilityLatestPhase !== 'V172-Q244R3-CAMERA-ANDROIDX-AGP-COMPATIBILITY-REPAIR' &&
    manifest.cameraPreCameraXCamera2BuildCompatibilityLatestPhase !== 'V172-Q244R6-CAMERA-PRE-CAMERAX-CAMERA2-BUILD-COMPATIBILITY-REPAIR') {
  fail('manifest latest phase missing for Q244R3');
}
if (manifest.v172Q244R3CameraAndroidxAgpCompatibility?.agpUpgradePerformed !== false) {
  fail('manifest must record that AGP upgrade was not performed');
}
if (manifest.v172Q244R4CameraAndroidCamera2Compatibility?.cameraAndroidImplementationPinned !== '0.10.8+18' &&
    manifest.v172Q244R6CameraPreCameraXCamera2BuildCompatibility?.cameraAndroidImplementationPinned !== '0.10.9+3') {
  fail('manifest must record Q244R4/Q244R6 camera_android implementation version');
}

console.log('CAMERA_ANDROIDX_AGP_COMPATIBILITY_Q244R3_STATIC_READY_BUT_REAL_FLUTTER_ANDROID_BUILD_RETEST_REQUIRED');
