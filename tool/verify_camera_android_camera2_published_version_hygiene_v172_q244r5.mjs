#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (message) => {
  console.error(`CAMERA_ANDROID_CAMERA2_PUBLISHED_VERSION_HYGIENE_Q244R5_FAIL: ${message}`);
  process.exit(1);
};

const pubspec = read('pubspec.yaml');
const settingsGradle = read('android/settings.gradle');
const policy = read('lib/features/camera/gauss_camera_android_camera2_published_version_hygiene_policy.dart');
const q244r4Verifier = read('tool/verify_camera_android_camera2_compatibility_v172_q244r4.mjs');
const q244r3Verifier = read('tool/verify_camera_androidx_agp_compatibility_v172_q244r3.mjs');
const q239bVerifier = read('tool/verify_camera_permission_capture_shell_v172_q239b.mjs');
const test = read('test/v172_q244r5_camera_android_camera2_published_version_hygiene_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

if (!policy.includes('V172-Q244R5-CAMERA-ANDROID-CAMERA2-PUBLISHED-VERSION-HYGIENE-REPAIR')) {
  fail('Q244R5 policy marker missing');
}
if (!policy.includes("invalidCameraAndroidVersionRejected = '0.10.8+11'")) {
  fail('policy must record the invalid Q244R4 camera_android version');
}
if (!/^\s*camera\s*:\s*(?:0\.11\.0|0\.10\.6)\s*$/m.test(pubspec)) {
  fail('pubspec must keep camera pinned to exact 0.11.0 or Q244R6 successor 0.10.6');
}
if (!/^\s*camera_android\s*:\s*(?:0\.10\.8\+18|0\.10\.9\+3)\s*$/m.test(pubspec)) {
  fail('pubspec must use published Camera2 implementation camera_android 0.10.8+18 or Q244R6 successor 0.10.9+3');
}
if (pubspec.includes('camera_android: 0.10.8+11')) {
  fail('pubspec must not keep unpublished/solver-rejected camera_android 0.10.8+11');
}
if (pubspec.includes('camera_android_camerax')) {
  fail('pubspec must not include camera_android_camerax after CameraX AGP/Kotlin failures');
}
if (/^\s*dependency_overrides\s*:\s*$/m.test(pubspec)) {
  fail('pubspec must not use dependency_overrides for camera compatibility');
}
if (!settingsGradle.includes("id 'com.android.application' version '8.3.2' apply false")) {
  fail('AGP version must remain 8.3.2; no broad Android build upgrade in Q244R5');
}
if (!settingsGradle.includes("id 'org.jetbrains.kotlin.android' version '1.9.22' apply false") &&
    !settingsGradle.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) {
  fail('Kotlin plugin version must be either original Q244R5 1.9.22 or Q244R8 successor 2.1.0');
}
for (const forbidden of ['google_mlkit_text_recognition', 'onnxruntime', 'pix2text', 'paddleocr', 'flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden OCR/download dependency found: ${forbidden}`);
}
for (const required of [q244r4Verifier, q244r3Verifier, q239bVerifier]) {
  if (!required.includes('0.10.8+18') && !required.includes('0\\.10\\.8\\+18') && !required.includes('0.10.9+3') && !required.includes('0\\.10\\.9\\+3')) {
    fail('successor verifier chain must assert camera_android 0.10.8+18 or Q244R6 successor 0.10.9+3');
  }
  if (required.includes('0.10.8+11') || required.includes('0\\.10\\.8\\+11')) {
    fail('successor verifier chain must not assert invalid camera_android 0.10.8+11');
  }
}
if ((!test.includes('0.10.8+18') && !test.includes('0.10.9+3')) || !test.includes('0.10.8+11')) {
  fail('Q244R5 test must assert the rejected invalid version and the current/successor replacement version');
}
if (manifest.cameraAndroidCamera2PublishedVersionHygieneLatestPhase !== 'V172-Q244R5-CAMERA-ANDROID-CAMERA2-PUBLISHED-VERSION-HYGIENE-REPAIR' &&
    manifest.cameraPreCameraXCamera2BuildCompatibilityLatestPhase !== 'V172-Q244R6-CAMERA-PRE-CAMERAX-CAMERA2-BUILD-COMPATIBILITY-REPAIR') {
  fail('manifest latest phase missing for Q244R5');
}
const q244r5 = manifest.v172Q244R5CameraAndroidCamera2PublishedVersionHygiene;
if (!q244r5 || q244r5.cameraAndroidImplementationPinned !== '0.10.8+18' && q244r5.cameraAndroidImplementationPinned !== '0.10.9+3') {
  fail('manifest must record published camera_android implementation version');
}
if (q244r5.invalidCameraAndroidVersionRejected !== '0.10.8+11') {
  fail('manifest must record rejected invalid camera_android version');
}
if (q244r5.agpUpgradePerformed !== false || q244r5.kotlinUpgradePerformed !== false) {
  fail('manifest must record no broad AGP/Kotlin upgrade');
}

console.log('CAMERA_ANDROID_CAMERA2_PUBLISHED_VERSION_HYGIENE_Q244R5_STATIC_READY_BUT_REAL_PUB_GET_FLUTTER_ANDROID_BUILD_RETEST_REQUIRED');
