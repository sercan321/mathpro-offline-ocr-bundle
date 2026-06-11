#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const exists = (rel) => fs.existsSync(p(rel));
const readJson = (rel) => JSON.parse(read(rel));
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const fail = (message) => {
  console.error(`CAMERA_REAL_DEVICE_EVIDENCE_CLOSURE_Q245_FAIL: ${message}`);
  process.exit(1);
};

const phase = 'V172-Q245-CAMERA-REAL-DEVICE-EVIDENCE-CLOSURE';
const q244r8 = 'V172-Q244R8-CAMERA-KOTLIN-METADATA-COMPATIBILITY-REPAIR';

const required = [
  'lib/features/camera/gauss_camera_real_device_evidence_closure_policy.dart',
  'test/v172_q245_camera_real_device_evidence_closure_test.dart',
  'tool/verify_camera_real_device_evidence_closure_v172_q245.mjs',
  'docs/audit/V172_Q245_CAMERA_REAL_DEVICE_EVIDENCE_CLOSURE_AUDIT.md',
  'docs/audit/V172_Q245_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/settings.gradle',
  'android/app/src/main/AndroidManifest.xml',
];
for (const rel of required) if (!exists(rel)) fail(`missing required Q245 file: ${rel}`);

const policy = read('lib/features/camera/gauss_camera_real_device_evidence_closure_policy.dart');
const test = read('test/v172_q245_camera_real_device_evidence_closure_test.dart');
const verifier = read('tool/verify_camera_real_device_evidence_closure_v172_q245.mjs');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const readme = read('README.md');
const manifest = readJson('assets/mathlive/manifest.json');
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';

for (const marker of [
  phase,
  q244r8,
  "expectedSourcePackageSha256 = '418247e1e3606d5a09d14821786bd38e5600e563e38e5ad172c86eef6652842e'",
  'userReportedFlutterRunOpenedApp = true',
  "userReportedDeviceId = '23106RN0DA'",
  'userReportedCameraButtonVisible = true',
  'userReportedKeyboardMoreLongPressGraphSolutionHistoryIntact = true',
  'userReportedCameraPermissionPreviewCaptureCropReviewFoundationWorking = true',
  'assistantVerifiedFlutterAnalyzePass = false',
  'assistantVerifiedFlutterTestPass = false',
  'assistantVerifiedFlutterRunPass = false',
  'assistantVerifiedAndroidRealDeviceCameraPass = false',
  'assistantVerifiedOcrPass = false',
  'evidenceClosureOnly = true',
  'runtimeBehaviorChanged = false',
  'workspaceRuntimeChanged = false',
  'cameraRuntimeShellChanged = false',
  'cameraDependencyChanged = false',
  'androidSettingsGradleChanged = false',
  'androidManifestChanged = false',
  'mainActivityChanged = false',
  "activeCameraPackage = '0.10.6'",
  "activeCameraAndroidImplementation = '0.10.9+3'",
  'cameraXImplementationAllowed = false',
  "activeKotlinPluginVersion = '2.1.0'",
  "agpVersionPreserved = '8.3.2'",
  'androidToolchainModernizationDeferredToQ253 = true',
  'realOcrRuntimeAdded = false',
  'textOcrFallbackRuntimeAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'mathLiveProductionBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'directGraphFromCameraAllowed = false',
  'directSolutionFromCameraAllowed = false',
  'directHistoryFromCameraAllowed = false',
  'mathLiveEditableReviewRequiredBeforeImport = true',
  'keyboardMutationAllowed = false',
  'longPressMutationAllowed = false',
  'moreMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'graphMutationAllowed = false',
  'solutionMutationAllowed = false',
  'historyMutationAllowed = false',
  'splashLauncherMutationAllowed = false',
  'q239aVerifierSuccessorHygieneOnly = true',
  'q239aVerifierRuntimeBehaviorChanged = false',
  'q240BenchmarkVerifierSuccessorHygieneOnly = true',
  'q240BenchmarkVerifierRuntimeBehaviorChanged = false',
]) if (!policy.includes(marker)) fail(`Q245 policy missing marker: ${marker}`);

for (const marker of [
  'GaussCameraRealDeviceEvidenceClosurePolicy',
  'userReportedFlutterRunOpenedApp',
  'assistantVerifiedFlutterAnalyzePass, isFalse',
  'assistantVerifiedFlutterTestPass, isFalse',
  'assistantVerifiedFlutterRunPass, isFalse',
  'assistantVerifiedAndroidRealDeviceCameraPass, isFalse',
  'assistantVerifiedOcrPass, isFalse',
  'mathLiveEditableReviewRequiredBeforeImport, isTrue',
  'q240BenchmarkVerifierSuccessorHygieneOnly, isTrue',
]) if (!test.includes(marker)) fail(`Q245 test missing marker: ${marker}`);
if (!verifier.includes('CAMERA_REAL_DEVICE_EVIDENCE_CLOSURE_Q245')) fail('Q245 verifier marker missing');

if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must preserve camera 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must preserve camera_android 0.10.9+3');
if (pubspec.includes('camera_android_camerax')) fail('CameraX dependency must remain absent');
for (const forbidden of ['google_mlkit_text_recognition', 'google_mlkit_commons', 'onnxruntime', 'paddle', 'pix2text', 'tesseract']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`OCR/model runtime dependency must not be added: ${forbidden}`);
}
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('Kotlin plugin 2.1.0 must be preserved');
if (!settings.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settings.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('AGP must be 8.3.2 for Q245 or 8.6.1 after Q253 successor modernization');
}
if (!androidManifest.includes('android.permission.CAMERA')) fail('CAMERA permission must remain present');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE']) if (androidManifest.includes(forbidden)) fail(`media permission must not be added: ${forbidden}`);
if (!mainActivity.includes('releaseNativeSplash')) fail('native splash release channel must remain preserved');
if (mainActivity.includes('maxNativeSplashVisibleMs') || mainActivity.includes('minNativeSplashVisibleMs')) fail('hard native splash timers must not return');

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c',
  'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354',
  'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369',
  'lib/features/keyboard/premium_key.dart': '4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/features/solution/solution_steps_panel.dart': '558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b',
  'lib/features/solution/solution_step_models.dart': 'faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
  'lib/features/graph/graph_card.dart': '124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/AndroidManifest.xml': '4fe91898ddf5ff94af1527314c8977806f23b051b7de078f25604dfa4731c1a6',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt': 'c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1',
  'lib/app/gauss_splash_screen.dart': '465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81',
};
for (const [rel, expected] of Object.entries(protectedHashes)) {
  if (!exists(rel)) fail(`protected/red-line file missing: ${rel}`);
  const actual = sha(rel);
  if (actual !== expected) fail(`protected/red-line hash mismatch for ${rel}: ${actual} expected ${expected}`);
}

const modelBinaryExt = /\.(onnx|tflite|pt|pth|pdmodel|pdiparams|bin)$/i;
const allFiles = [];
const walk = (dir) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    const rel = path.relative(root, full).replaceAll(path.sep, '/');
    if (entry.isDirectory()) walk(full);
    else allFiles.push(rel);
  }
};
walk(root);
for (const rel of allFiles) {
  if (modelBinaryExt.test(rel)) fail(`model binary must not be bundled in base app: ${rel}`);
}

if (manifest.cameraRealDeviceEvidenceClosureLatestPhase !== phase) fail('manifest latest Q245 phase missing');
const env = manifest.v172Q245CameraRealDeviceEvidenceClosure;
if (!env || env.phase !== phase) fail('manifest Q245 envelope missing');
for (const [key, expected] of Object.entries({
  closesOverPackagePhase: q244r8,
  expectedSourcePackageSha256: '418247e1e3606d5a09d14821786bd38e5600e563e38e5ad172c86eef6652842e',
  userReportedFlutterRunOpenedApp: true,
  userReportedDeviceId: '23106RN0DA',
  userReportedCameraButtonVisible: true,
  userReportedKeyboardMoreLongPressGraphSolutionHistoryIntact: true,
  userReportedCameraPermissionPreviewCaptureCropReviewFoundationWorking: true,
  assistantVerifiedFlutterAnalyzePass: false,
  assistantVerifiedFlutterTestPass: false,
  assistantVerifiedFlutterRunPass: false,
  assistantVerifiedAndroidRealDeviceCameraPass: false,
  assistantVerifiedOcrPass: false,
  evidenceClosureOnly: true,
  runtimeBehaviorChanged: false,
  workspaceRuntimeChanged: false,
  cameraRuntimeShellChanged: false,
  cameraDependencyChanged: false,
  androidSettingsGradleChanged: false,
  androidManifestChanged: false,
  mainActivityChanged: false,
  activeCameraPackage: '0.10.6',
  activeCameraAndroidImplementation: '0.10.9+3',
  cameraXImplementationAllowed: false,
  activeKotlinPluginVersion: '2.1.0',
  agpVersionPreserved: '8.3.2',
  androidToolchainModernizationDeferredToQ253: true,
  realOcrRuntimeAdded: false,
  directSolveFromCameraAllowed: false,
  mathLiveEditableReviewRequiredBeforeImport: true,
  q239aVerifierSuccessorHygieneOnly: true,
  q239aVerifierRuntimeBehaviorChanged: false,
  q240BenchmarkVerifierSuccessorHygieneOnly: true,
  q240BenchmarkVerifierRuntimeBehaviorChanged: false,
})) {
  if (env[key] !== expected) fail(`manifest Q245 ${key} expected ${expected} got ${env[key]}`);
}
if (!Array.isArray(env.changedFiles) || !env.changedFiles.includes('tool/verify_workspace_camera_entry_button_v172_q239a.mjs')) {
  fail('manifest Q245 changedFiles must record Q239A verifier successor hygiene');
}
for (const staleVerifier of [
  'tool/verify_ocr_engine_benchmark_court_v172_q240.mjs',
  'tool/verify_ocr_benchmark_dataset_lab_runner_v172_q240r1.mjs',
]) {
  if (!env.changedFiles.includes(staleVerifier)) fail(`manifest Q245 changedFiles must record OCR benchmark verifier hygiene: ${staleVerifier}`);
}
if (!readme.includes('## V172-Q245 Camera Real Device Evidence Closure')) fail('README missing Q245 section');
if (!read('docs/audit/V172_Q245_CAMERA_REAL_DEVICE_EVIDENCE_CLOSURE_AUDIT.md').includes('No runtime behavior change')) fail('Q245 audit must record no runtime behavior change');
if (!read('docs/audit/V172_Q245_CHANGED_FILES.md').includes('tool/verify_workspace_camera_entry_button_v172_q239a.mjs')) fail('Q245 changed files must record Q239A verifier hygiene');

console.log('CAMERA_REAL_DEVICE_EVIDENCE_CLOSURE_Q245_STATIC_READY_BUT_FRESH_USER_SIDE_FLUTTER_ANALYZE_TEST_RUN_RETEST_REQUIRED');
