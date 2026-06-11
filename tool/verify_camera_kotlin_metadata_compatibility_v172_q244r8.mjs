#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (message) => {
  console.error(`CAMERA_KOTLIN_METADATA_COMPATIBILITY_Q244R8_FAIL: ${message}`);
  process.exit(1);
};

const settings = read('android/settings.gradle');
const pubspec = read('pubspec.yaml');
const manifestXml = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const policy = read('lib/features/camera/gauss_camera_kotlin_metadata_compatibility_policy.dart');
const test = read('test/v172_q244r8_camera_kotlin_metadata_compatibility_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
const protectedRuntimePaths = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/template_tray.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/solution/solution_step_models.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/graph/graph_card.dart',
  'lib/app/app_shell.dart',
  'lib/main.dart',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
];

if (!policy.includes('V172-Q244R8-CAMERA-KOTLIN-METADATA-COMPATIBILITY-REPAIR')) fail('Q244R8 policy marker missing');
if (!policy.includes('triggeredByUserSideKotlinMetadataFailure = true')) fail('policy must record user-side Kotlin metadata trigger');
if (!policy.includes("activeKotlinPluginVersion = '2.1.0'")) fail('policy must record Kotlin 2.1.0');
if (!policy.includes("agpVersionPreserved = '8.3.2'")) fail('policy must preserve AGP 8.3.2');
if (!policy.includes('agpUpgradePerformed = false')) fail('policy must not claim AGP upgrade');
if (!policy.includes('realOcrRuntimeAdded = false')) fail('policy must not add OCR runtime');
if (!policy.includes('directSolveFromCameraAllowed = false')) fail('policy must block direct camera solve');
if (!test.includes('android/settings.gradle')) fail('test must inspect settings.gradle');

if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('settings.gradle must use Kotlin plugin 2.1.0');
if (settings.includes("id 'org.jetbrains.kotlin.android' version '1.9.22' apply false")) fail('settings.gradle must not retain Kotlin plugin 1.9.22');
if (!settings.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settings.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('AGP must be 8.3.2 for Q244R8 or 8.6.1 after the Q253 successor modernization');
}
if (/version\s+'8\.6\.0'/.test(settings)) fail('Q244R8/Q253 must not use AGP 8.6.0; Q253 standardizes on 8.6.1');
if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must preserve camera 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must preserve camera_android 0.10.9+3');
if (pubspec.includes('camera_android_camerax')) fail('pubspec must not include CameraX');
if (pubspec.includes('mlkit') || pubspec.includes('onnx') || pubspec.includes('paddle') || pubspec.includes('pix2text')) fail('pubspec must not add OCR runtime dependencies');
if (!manifestXml.includes('android.permission.CAMERA')) fail('camera permission must remain present from Q239B');
if (!mainActivity.includes('releaseNativeSplash')) fail('MainActivity native splash channel must remain preserved');
if (mainActivity.includes('maxNativeSplashVisibleMs') || mainActivity.includes('minNativeSplashVisibleMs')) fail('native splash hard timers must not return');

for (const rel of protectedRuntimePaths) {
  if (!fs.existsSync(path.join(root, rel))) fail(`protected runtime path missing: ${rel}`);
}

if (manifest.cameraKotlinMetadataCompatibilityLatestPhase !== 'V172-Q244R8-CAMERA-KOTLIN-METADATA-COMPATIBILITY-REPAIR') {
  fail('manifest latest phase missing for Q244R8');
}
const q244r8 = manifest.v172Q244R8CameraKotlinMetadataCompatibility;
if (!q244r8 || q244r8.activeKotlinPluginVersion !== '2.1.0') fail('manifest Q244R8 Kotlin record missing');
if (q253ToolchainActive) {
  const q253 = manifest.v172Q253AndroidToolchainModernization;
  if (!q253 || q253.targetAgpVersion !== '8.6.1' || q253.previousAgpVersion !== '8.3.2') fail('manifest must record Q253 AGP 8.6.1 successor modernization');
} else if (q244r8.agpVersionPreserved !== '8.3.2' || q244r8.agpUpgradePerformed !== false) {
  fail('manifest must preserve AGP without upgrade before Q253');
}
if (q244r8.cameraPackagePreserved !== '0.10.6' || q244r8.cameraAndroidImplementationPreserved !== '0.10.9+3') fail('manifest must preserve Q244R6 camera dependencies');
if (q244r8.cameraRuntimeShellChanged !== false || q244r8.workspaceRuntimeChanged !== false) fail('manifest must record no camera/workspace runtime change');
if (q244r8.realOcrRuntimeAdded !== false || q244r8.directSolveFromCameraAllowed !== false) fail('manifest must block OCR/direct solve');

console.log('CAMERA_KOTLIN_METADATA_COMPATIBILITY_Q244R8_STATIC_READY_BUT_REAL_FLUTTER_ANDROID_BUILD_RETEST_REQUIRED');
