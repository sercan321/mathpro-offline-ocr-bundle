#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (message) => {
  console.error(`CAMERA_PRECAMERAX_CAMERA2_BUILD_COMPATIBILITY_Q244R6_FAIL: ${message}`);
  process.exit(1);
};

const pubspec = read('pubspec.yaml');
const settingsGradle = read('android/settings.gradle');
const policy = read('lib/features/camera/gauss_camera_precamerax_camera2_build_compatibility_policy.dart');
const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const q244r5Verifier = read('tool/verify_camera_android_camera2_published_version_hygiene_v172_q244r5.mjs');
const q244r4Verifier = read('tool/verify_camera_android_camera2_compatibility_v172_q244r4.mjs');
const q244r3Verifier = read('tool/verify_camera_androidx_agp_compatibility_v172_q244r3.mjs');
const test = read('test/v172_q244r6_camera_precamerax_camera2_build_compatibility_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';

if (!policy.includes('V172-Q244R6-CAMERA-PRE-CAMERAX-CAMERA2-BUILD-COMPATIBILITY-REPAIR')) {
  fail('Q244R6 policy marker missing');
}
if (!policy.includes("cameraPackagePinned = '0.10.6'")) fail('policy must pin camera 0.10.6');
if (!policy.includes("cameraAndroidImplementationPinned = '0.10.9+3'")) fail('policy must pin camera_android 0.10.9+3');
if (!policy.includes('triggeredByUserSideCameraAndroidRegistrarFailure = true')) {
  fail('policy must record user-side Registrar failure trigger');
}
if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must pin camera to exact 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must pin camera_android to exact 0.10.9+3');
for (const forbidden of [
  'camera: 0.11.0',
  'camera_android: 0.10.8+18',
  'camera_android: 0.10.8+11',
  'camera_android_camerax',
  'dependency_overrides:',
]) {
  if (pubspec.includes(forbidden)) fail(`pubspec must not contain stale camera dependency marker: ${forbidden}`);
}
if (!settingsGradle.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settingsGradle.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('AGP version must remain 8.3.2 for Q244R6 or move to 8.6.1 only through Q253 successor modernization');
}
if (!settingsGradle.includes("id 'org.jetbrains.kotlin.android' version '1.9.22' apply false") &&
    !settingsGradle.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) {
  fail('Kotlin plugin version must be either original Q244R6 1.9.22 or Q244R8 successor 2.1.0');
}
for (const forbidden of ['google_mlkit_text_recognition', 'onnxruntime', 'pix2text', 'paddleocr', 'flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden OCR/download dependency found: ${forbidden}`);
}
if (!cameraShell.includes('CameraController(') || !cameraShell.includes('availableCameras()')) {
  fail('camera shell must keep camera capture foundation code');
}
for (const verifier of [q244r5Verifier, q244r4Verifier, q244r3Verifier]) {
  if (!verifier.includes('Q244R6 successor')) fail('previous camera dependency verifier must be Q244R6 successor-aware');
}
if (!test.includes('0.10.6') || !test.includes('0.10.9+3')) {
  fail('Q244R6 test must assert final camera dependency pins');
}
if (manifest.cameraPreCameraXCamera2BuildCompatibilityLatestPhase !== 'V172-Q244R6-CAMERA-PRE-CAMERAX-CAMERA2-BUILD-COMPATIBILITY-REPAIR') {
  fail('manifest latest phase missing for Q244R6');
}
const q244r6 = manifest.v172Q244R6CameraPreCameraXCamera2BuildCompatibility;
if (!q244r6 || q244r6.cameraPackagePinned !== '0.10.6' || q244r6.cameraAndroidImplementationPinned !== '0.10.9+3') {
  fail('manifest must record Q244R6 camera dependency pins');
}
if (q244r6.cameraXImplementationAllowed !== false || q244r6.agpUpgradePerformed !== false || q244r6.kotlinUpgradePerformed !== false) {
  fail('manifest must record CameraX/AGP/Kotlin restrictions');
}
console.log('CAMERA_PRECAMERAX_CAMERA2_BUILD_COMPATIBILITY_Q244R6_STATIC_READY_BUT_REAL_PUB_GET_FLUTTER_ANDROID_BUILD_RETEST_REQUIRED');
