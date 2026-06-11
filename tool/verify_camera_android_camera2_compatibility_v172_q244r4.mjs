#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (message) => {
  console.error(`CAMERA_ANDROID_CAMERA2_COMPATIBILITY_Q244R4_FAIL: ${message}`);
  process.exit(1);
};

const pubspec = read('pubspec.yaml');
const settingsGradle = read('android/settings.gradle');
const policy = read('lib/features/camera/gauss_camera_android_camera2_compatibility_policy.dart');
const q239bVerifier = read('tool/verify_camera_permission_capture_shell_v172_q239b.mjs');
const q244Verifier = read('tool/verify_camera_regression_court_v172_q244.mjs');
const q244r3Verifier = read('tool/verify_camera_androidx_agp_compatibility_v172_q244r3.mjs');
const test = read('test/v172_q244r4_camera_android_camera2_compatibility_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

if (!policy.includes('V172-Q244R4-CAMERA-ANDROID-CAMERA2-COMPATIBILITY-REPAIR')) {
  fail('Q244R4 policy marker missing');
}
if (!/^\s*camera\s*:\s*(?:0\.11\.0|0\.10\.6)\s*$/m.test(pubspec)) {
  fail('pubspec must keep camera pinned to exact 0.11.0 or Q244R6 successor 0.10.6');
}
if (!/^\s*camera_android\s*:\s*(?:0\.10\.8\+18|0\.10\.9\+3)\s*$/m.test(pubspec)) {
  fail('pubspec must opt into camera_android 0.10.8+18 or Q244R6 successor 0.10.9+3');
}
if (pubspec.includes('camera_android_camerax')) {
  fail('pubspec must not include camera_android_camerax after user-side Kotlin metadata failure');
}
if (/^\s*dependency_overrides\s*:\s*$/m.test(pubspec)) {
  fail('pubspec must not use dependency_overrides for CameraX in Q244R4');
}
if (!settingsGradle.includes("id 'com.android.application' version '8.3.2' apply false")) {
  fail('AGP version must remain 8.3.2; no broad Android build upgrade in Q244R4');
}
if (!settingsGradle.includes("id 'org.jetbrains.kotlin.android' version '1.9.22' apply false") &&
    !settingsGradle.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) {
  fail('Kotlin plugin version must be either original Q244R4 1.9.22 or Q244R8 successor 2.1.0');
}
for (const forbidden of ['google_mlkit_text_recognition', 'onnxruntime', 'pix2text', 'paddleocr', 'flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden OCR/download dependency found: ${forbidden}`);
}
if (!q239bVerifier.includes('camera_android')) {
  fail('Q239B verifier must be successor-aware for camera_android');
}
if (!q244Verifier.includes('camera_android_camerax')) {
  fail('Q244 verifier must block stale CameraX implementation');
}
if (!q244r3Verifier.includes('Q244R4 successor')) {
  fail('Q244R3 verifier must be successor-aware after Q244R4');
}
if (!test.includes('camera_android') || (!test.includes('0.10.8+18') && !test.includes('0.10.9+3'))) {
  fail('Q244R4 test must assert camera_android opt-in or Q244R6 successor');
}
if (manifest.cameraAndroidCamera2CompatibilityLatestPhase !== 'V172-Q244R4-CAMERA-ANDROID-CAMERA2-COMPATIBILITY-REPAIR' &&
    manifest.cameraAndroidCamera2CompatibilityLatestPhase !== 'V172-Q244R5-CAMERA-ANDROID-CAMERA2-PUBLISHED-VERSION-HYGIENE-REPAIR' &&
    manifest.cameraAndroidCamera2CompatibilityLatestPhase !== 'V172-Q244R6-CAMERA-PRE-CAMERAX-CAMERA2-BUILD-COMPATIBILITY-REPAIR') {
  fail('manifest latest phase missing for Q244R4/Q244R5 successor');
}
const q244r4 = manifest.v172Q244R4CameraAndroidCamera2Compatibility;
if (!q244r4 || q244r4.cameraAndroidImplementationPinned !== '0.10.8+18' && q244r4.cameraAndroidImplementationPinned !== '0.10.9+3') {
  fail('manifest must record camera_android implementation version');
}
if (q244r4.agpUpgradePerformed !== false || q244r4.kotlinUpgradePerformed !== false) {
  fail('manifest must record no broad AGP/Kotlin upgrade');
}

console.log('CAMERA_ANDROID_CAMERA2_COMPATIBILITY_Q244R4_STATIC_READY_BUT_REAL_FLUTTER_ANDROID_BUILD_RETEST_REQUIRED');
