#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';

const root = process.cwd();
const phase = 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
const fail = (message) => {
  console.error(`ANDROID_TOOLCHAIN_MODERNIZATION_Q253_BLOCKED: ${message}`);
  process.exit(1);
};
const read = (p) => fs.readFileSync(`${root}/${p}`, 'utf8');
const exists = (p) => fs.existsSync(`${root}/${p}`);
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(`${root}/${p}`)).digest('hex');

const policyPath = 'lib/features/camera/gauss_android_toolchain_modernization_policy.dart';
const courtPath = 'lib/features/camera/gauss_android_toolchain_modernization.dart';
const testPath = 'test/v172_q253_android_toolchain_modernization_test.dart';
const auditPath = 'docs/audit/V172_Q253_ANDROID_TOOLCHAIN_MODERNIZATION_AUDIT.md';
const changedPath = 'docs/audit/V172_Q253_CHANGED_FILES.md';

for (const file of [policyPath, courtPath, testPath, auditPath, changedPath, 'assets/mathlive/manifest.json', 'README.md']) {
  if (!exists(file)) fail(`missing Q253 file: ${file}`);
}

const policy = read(policyPath);
const court = read(courtPath);
const test = read(testPath);
const audit = read(auditPath);
const changed = read(changedPath);
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const wrapper = read('android/gradle/wrapper/gradle-wrapper.properties');
const appGradle = read('android/app/build.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

for (const marker of [
  phase,
  'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION',
  'sourcePackageSha256',
  '0d1d6f118744dabe3faf48c821b6d009eb163aa5eef854708dca0718e37fd358',
  "previousAgpVersion = '8.3.2'",
  "targetAgpVersion = '8.6.1'",
  "kotlinGradlePluginVersion = '2.1.0'",
  "gradleWrapperVersion = '8.7'",
  "javaSourceCompatibility = '17'",
  "javaTargetCompatibility = '17'",
  "kotlinJvmTarget = '17'",
  "androidOfficialKotlin21MinimumAgp = '8.6'",
  "androidOfficialAgp86MinimumGradle = '8.7'",
  "androidOfficialAgp86Jdk = '17'",
  'agpUpgradePerformed = true',
  'kotlinPluginPreserved = true',
  'gradleWrapperPreservedAtRequiredVersion = true',
  'java17CompileOptionsPreserved = true',
  'cameraDependencyLinePreserved = true',
  'cameraOcrFoundationPreserved = true',
  'ppFormulaNetSUserSelectionPreserved = true',
  'realOcrRuntimeAdded = false',
  'paddleRuntimeAdded = false',
  'paddleOcrDependencyAdded = false',
  'ppFormulaNetSModelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'productionDownloadWorkerImplemented = false',
  'productionInferenceAllowed = false',
  'editableMathLiveReviewRequired = true',
  'userApprovalRequiredBeforeWorkspaceImport = true',
  'directWorkspaceImportAllowed = false',
  'directSolveFromCameraAllowed = false',
  'directGraphFromCameraAllowed = false',
  'directSolutionFromCameraAllowed = false',
  'directHistoryFromCameraAllowed = false',
  'keyboardLayoutMustRemainUnchanged = true',
  'moreInventoryMustRemainUnchanged = true',
  'longPressInventoryMustRemainUnchanged = true',
  'mathLiveProductionRouteMustRemainUnchanged = true',
  'graphSurfaceMustRemainUnchanged = true',
  'solutionSurfaceMustRemainUnchanged = true',
  'historySurfaceMustRemainUnchanged = true',
  'splashAndLauncherMustRemainUnchanged = true',
]) if (!policy.includes(marker)) fail(`Q253 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussAndroidToolchainModernizationDecision',
  'blockedMissingQ252Foundation',
  'blockedAgpTargetMismatch',
  'blockedGradleOrJavaTargetMismatch',
  'blockedCameraOcrRegression',
  'blockedProtectedSurfaceRegression',
  'blockedForbiddenRuntimeBinding',
  'androidToolchainModernizationStaticReady',
  'class GaussAndroidToolchainModernizationInput',
  'class GaussAndroidToolchainModernizationResult',
  'androidToolchainModernizationStaticReady',
  'canClaimFlutterPassWithoutLogs => false',
  'canClaimAndroidRunPassWithoutDeviceLog => false',
  'canClaimOcrPass => false',
  'canImportCameraOutputWithoutUserApproval => false',
  'canSolveCameraOutputBeforeReviewApproval => false',
  'class GaussAndroidToolchainModernization',
  'requiresQ252PremiumFinalRegression = true',
  'upgradesAgpTo861 = true',
  'preservesKotlinPlugin210 = true',
  'requiresGradleWrapper87 = true',
  'requiresJava17CompileOptions = true',
  'requiresKotlinJvmTarget17 = true',
  'preservesCameraDependencies = true',
  'preservesMathLiveReviewOnlyOcr = true',
  'realInferenceEnabledInQ253 = false',
  'callsProductionMathLiveBridge = false',
  'runPpFormulaNetSInference',
  'setWorkspaceLatexWithoutUserApproval',
  'Q253 requires the Q252 camera/OCR premium final regression closure as its source baseline.',
  'android/settings.gradle must use Android Gradle Plugin 8.6.1 for Q253.',
  'Kotlin Gradle Plugin must remain 2.1.0; Q253 is not a Kotlin-version experiment.',
  'Gradle wrapper must remain 8.7, the required Gradle line for AGP 8.6.',
]) if (!court.includes(marker)) fail(`Q253 court missing marker: ${marker}`);

for (const marker of [
  phase,
  '8.6.1',
  '2.1.0',
  '8.7',
  '17',
  'records AGP 8.6.1 / Kotlin 2.1.0 / Gradle 8.7 / Java 17 modernization scope',
  'keeps camera/OCR as review-only and blocks real runtime additions',
  'passes only when Q252 foundation, Android targets, and protected surfaces are intact',
  'Paddle runtime must not be added in Q253',
]) if (!test.includes(marker)) fail(`Q253 test missing marker: ${marker}`);

if (!settings.includes("id 'com.android.application' version '8.6.1' apply false")) fail('settings.gradle must use AGP 8.6.1');
if (settings.includes("id 'com.android.application' version '8.3.2' apply false")) fail('settings.gradle must not keep AGP 8.3.2 after Q253');
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('settings.gradle must preserve Kotlin Gradle Plugin 2.1.0');
if (settings.includes("id 'org.jetbrains.kotlin.android' version '1.9.22' apply false")) fail('settings.gradle must not regress to Kotlin plugin 1.9.22');
if (!wrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7 for AGP 8.6');
if (!appGradle.includes('sourceCompatibility JavaVersion.VERSION_17')) fail('app build.gradle must preserve Java sourceCompatibility 17');
if (!appGradle.includes('targetCompatibility JavaVersion.VERSION_17')) fail('app build.gradle must preserve Java targetCompatibility 17');
if (!appGradle.includes("jvmTarget = '17'")) fail('app build.gradle must preserve Kotlin jvmTarget 17');

if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency must remain 0.10.6');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency must remain 0.10.9+3');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must remain absent');
for (const forbidden of [
  'google_mlkit_text_recognition',
  'paddleocr',
  'paddle_flutter',
  'onnxruntime',
  'tesseract',
  'pix2text',
]) if (pubspec.toLowerCase().includes(forbidden)) fail(`Q253 must not add OCR runtime dependency: ${forbidden}`);

if (androidManifest.includes('READ_MEDIA_IMAGES')) fail('Q253 must not add media permissions');
if (!androidManifest.includes('android.permission.CAMERA')) fail('camera permission must remain present');

if (manifest.androidToolchainModernizationLatestPhase !== phase) fail('manifest missing androidToolchainModernizationLatestPhase Q253');
const q253 = manifest.v172Q253AndroidToolchainModernization;
if (!q253) fail('manifest missing v172Q253AndroidToolchainModernization');
if (q253.sourcePhase !== 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION') fail('manifest Q253 sourcePhase mismatch');
if (q253.previousAgpVersion !== '8.3.2') fail('manifest previous AGP mismatch');
if (q253.targetAgpVersion !== '8.6.1') fail('manifest target AGP mismatch');
if (q253.kotlinGradlePluginVersion !== '2.1.0') fail('manifest Kotlin plugin mismatch');
if (q253.gradleWrapperVersion !== '8.7') fail('manifest Gradle wrapper mismatch');
if (q253.javaTargetCompatibility !== '17') fail('manifest Java target mismatch');
if (q253.agpUpgradePerformed !== true) fail('manifest must record AGP upgrade');
if (q253.cameraOcrFoundationPreserved !== true) fail('manifest must preserve camera/OCR foundation');
if (q253.ppFormulaNetSUserSelectionPreserved !== true) fail('manifest must preserve PP-FormulaNet-S selection');
if (q253.realOcrRuntimeAdded !== false) fail('manifest must not add real OCR runtime');
if (q253.paddleRuntimeAdded !== false) fail('manifest must not add Paddle runtime');
if (q253.modelBinaryBundledInBaseApp !== false) fail('manifest must not bundle model binary');
if (q253.productionInferenceAllowed !== false) fail('manifest must not allow production inference');
if (q253.editableMathLiveReviewRequired !== true) fail('manifest must require editable MathLive review');
if (q253.userApprovalRequiredBeforeWorkspaceImport !== true) fail('manifest must require user approval');
if (q253.directWorkspaceImportAllowed !== false) fail('manifest must block direct workspace import');
if (q253.directSolveFromCameraAllowed !== false) fail('manifest must block direct solve');
if (q253.directGraphFromCameraAllowed !== false) fail('manifest must block direct graph');
if (q253.directSolutionFromCameraAllowed !== false) fail('manifest must block direct solution');
if (q253.directHistoryFromCameraAllowed !== false) fail('manifest must block direct history');
if (!Array.isArray(q253.requiredModernizationGates) || q253.requiredModernizationGates.length < 12) fail('manifest must define required Q253 gates');

for (const marker of [phase, 'Q253', 'AGP 8.6.1', 'Kotlin 2.1.0', 'Gradle 8.7', 'Java 17', 'Q252', 'PP-FormulaNet-S', 'no real OCR runtime', 'editable MathLive review', 'user approval']) {
  if (!readme.includes(marker)) fail(`README missing Q253 marker: ${marker}`);
  if (!audit.includes(marker)) fail(`audit missing Q253 marker: ${marker}`);
}
for (const file of [
  'android/settings.gradle',
  policyPath,
  courtPath,
  testPath,
  'tool/verify_android_toolchain_modernization_v172_q253.mjs',
  auditPath,
  changedPath,
  'assets/mathlive/manifest.json',
  'README.md',
]) if (!changed.includes(file)) fail(`changed-files audit missing ${file}`);

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
  'lib/features/workspace/workspace_panel.dart': '7e3c32f710b07b8fba3bd4223de650c71f334747644a41cfd0079ff7d49812b1',
  'pubspec.yaml': '97182bbfa14cace9cf1825ba75832e2da18e183279299a14fdfb578a0ad49304',
  'android/gradle/wrapper/gradle-wrapper.properties': '797ea7d637b36ce5ccff6559a427ae97077073c7992883469e6ecb523fea2b97',
  'android/app/build.gradle': '5533186d6120cb1c8d5c976e2f13f2505d395721d03f6025138fdf96ac3c3ecb',
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51',
  'lib/features/camera/gauss_camera_ocr_premium_final_regression.dart': 'da55914a5a34f40474c1505693d19bf17e6dce31e2da26d68ccd7b47045b1916',
  'lib/features/camera/gauss_camera_ocr_premium_final_regression_policy.dart': '91c5e9925bb1b56b1ca290c10287d55ea49b237342729947fd1a04f6e345e7a9',
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  const actual = sha(file);
  if (actual !== expected) fail(`protected hash changed for ${file}: ${actual}`);
}

const runtimeFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/camera/gauss_camera_capture_shell.dart',
].map(read).join('\n');
for (const forbidden of [
  'runPpFormulaNetSInference',
  'FormulaRecognition(',
  'paddleocr',
  'google_mlkit_text_recognition',
  'onnxruntime',
  'setWorkspaceLatexWithoutUserApproval',
]) {
  if (runtimeFiles.includes(forbidden)) fail(`Q253 must not mutate active runtime marker: ${forbidden}`);
}

console.log(JSON.stringify({
  phase,
  status: 'ANDROID_TOOLCHAIN_MODERNIZATION_Q253_STATIC_READY_BUT_FLUTTER_ANDROID_RETEST_REQUIRED',
  sourcePhase: q253.sourcePhase,
  previousAgpVersion: q253.previousAgpVersion,
  targetAgpVersion: q253.targetAgpVersion,
  kotlinGradlePluginVersion: q253.kotlinGradlePluginVersion,
  gradleWrapperVersion: q253.gradleWrapperVersion,
  javaTargetCompatibility: q253.javaTargetCompatibility,
  realOcrRuntimeAdded: q253.realOcrRuntimeAdded,
  modelBinaryBundledInBaseApp: q253.modelBinaryBundledInBaseApp,
  protectedHashComparison: 'PASS',
}, null, 2));
