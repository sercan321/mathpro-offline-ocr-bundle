#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const errors = [];
const fail = (message) => errors.push(message);
const fullPhase = 'V172-Q235R7-ANDROID12-SMALL-SPLASH-ICON-ELIMINATION';

for (const required of [
  'lib/app/gauss_android12_small_splash_icon_elimination_policy.dart',
  'test/v172_q235r7_android12_small_splash_icon_elimination_test.dart',
  'android/app/src/main/res/values-v31/styles.xml',
  'android/app/src/main/res/drawable/splash_transparent_icon.xml',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png',
  'assets/branding/gauss_splash_screen.png',
  'assets/mathlive/manifest.json',
  'README.md'
]) if (!exists(required)) fail(`missing Q235R7 required file: ${required}`);

const policy = read('lib/app/gauss_android12_small_splash_icon_elimination_policy.dart');
const valuesV31 = read('android/app/src/main/res/values-v31/styles.xml');
const transparentIcon = read('android/app/src/main/res/drawable/splash_transparent_icon.xml');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const splash = read('lib/app/gauss_splash_screen.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');

for (const marker of [
  "phase = 'V172-Q235R7'",
  'triggeredBySmallThenLargeSplashReport = true',
  'android12SystemIconSlotRendersSmallArtwork = true',
  'android12BrandedIconSlotRemoved = true',
  'android12TransparentIconRestored = true',
  'fullSplashOwnedByNativeOverlay = true',
  'nativeOverlayUsesFullSplashArtwork = true',
  'readySignalOnlyReleasePreserved = true',
  'noHardNativeSplashTimeoutPreserved = true',
  'splashArtworkChanged = false',
  'launcherIconMutationAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveMutationAllowed = false',
  'graphRuntimeMutationAllowed = false',
  'flutterRunPassClaimedByAssistant = false',
  'androidRealDeviceSplashPassClaimedByAssistant = false'
]) if (!policy.includes(marker)) fail(`Q235R7 policy missing marker: ${marker}`);

if (!valuesV31.includes('@drawable/splash_transparent_icon')) fail('Android 12+ icon slot must use transparent icon');
if (valuesV31.includes('@drawable/gauss_splash_v31_icon')) fail('Android 12+ small branded icon slot returned');
if (!transparentIcon.includes('android:width="1dp"')) fail('transparent icon width marker missing');
if (!transparentIcon.includes('android:height="1dp"')) fail('transparent icon height marker missing');
if (!transparentIcon.includes('#00000000')) fail('transparent icon alpha marker missing');
if (!mainActivity.includes('R.drawable.gauss_splash_screen_native')) fail('native overlay full splash artwork missing');
if (!mainActivity.includes('ImageView.ScaleType.FIT_CENTER')) fail('native overlay fit-center missing');
if (!mainActivity.includes('"releaseNativeSplash"')) fail('ready-signal release missing');
if (mainActivity.includes('maxNativeSplashVisibleMs')) fail('hard max timeout returned');
if (mainActivity.includes('minNativeSplashVisibleMs')) fail('hard min timeout returned');
if (!splash.includes("invokeMethod<void>('releaseNativeSplash')")) fail('Dart ready signal missing');
if (!splash.includes('fit: BoxFit.contain')) fail('Flutter poster contain fit missing');
if (splash.includes('fit: BoxFit.cover')) fail('crop-prone cover fit returned');

if (sha('android/app/src/main/res/values-v31/styles.xml') !== 'a171cce0ccb7dd572c4a2fb12cafd127f5558aedc8eb098ff075b517d69b83fa') fail('values-v31 hash mismatch');
if (sha('android/app/src/main/res/drawable/splash_transparent_icon.xml') !== '4f5600a77a9e8d8502680de3c22eea6c143feba88b8bd7283ec79afda8e5e5d7') fail('transparent icon hash mismatch');
if (sha('android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png') !== 'c8256729c2eac821bfcfd103a525d531a442902b583b8f55ffb627f4a1926596') fail('native splash hash mismatch');
if (sha('assets/branding/gauss_splash_screen.png') !== 'f3f35b0444cc882c32e8b48919a50101e26e402b69e08c20de84ac9c42723533') fail('splash artwork hash mismatch');

if (manifest.gaussAndroid12SmallSplashIconEliminationLatestPhase !== fullPhase) fail('manifest latest Q235R7 phase mismatch');
const env = manifest.v172Q235R7Android12SmallSplashIconElimination;
if (!env || env.phase !== fullPhase) fail('manifest Q235R7 envelope missing');
else {
  for (const [key, expected] of Object.entries({
    triggeredBySmallThenLargeSplashReport: true,
    android12SystemIconSlotRendersSmallArtwork: true,
    android12BrandedIconSlotRemoved: true,
    android12TransparentIconRestored: true,
    fullSplashOwnedByNativeOverlay: true,
    readySignalOnlyReleasePreserved: true,
    noHardNativeSplashTimeoutPreserved: true,
    splashArtworkChanged: false,
    flutterRunPassClaimed: false,
    androidRealDeviceSplashPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q235R7 ${key} expected ${expected} got ${env[key]}`);
}
if (!readme.includes('## V172-Q235R7 — Android 12 Small Splash Icon Elimination')) fail('README missing Q235R7 section');

const protectedHashes = {
  "lib/features/keyboard/key_config.dart": "4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2",
  "lib/features/keyboard/math_keyboard.dart": "fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c",
  "lib/features/keyboard/bottom_dock.dart": "a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354",
  "lib/features/keyboard/long_press_popup.dart": "4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369",
  "lib/features/keyboard/premium_key.dart": "4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43",
  "lib/features/workspace/template_tray.dart": "b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678",
  "assets/mathlive/main_editor_prod.html": "f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd",
  "assets/mathlive/mathlive_prod_bridge.js": "fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4",
  "lib/features/mathlive/mathlive_production_editor_surface.dart": "f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9",
  "lib/features/solution/solution_steps_panel.dart": "558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b",
  "lib/features/solution/solution_step_models.dart": "faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248",
  "lib/features/history/history_panel.dart": "fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b",
  "lib/features/history/history_controller.dart": "331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51",
  "lib/app/app_shell.dart": "ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637",
  "lib/main.dart": "068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689",
  "android/app/src/main/AndroidManifest.xml": "e788776fb08b0e63d7beb9844b34df0e198a913b715dcfbef3df6e2ef77f5b20",
  "android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt": "c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1"
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`protected hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

const report = {
  phase: 'V172-Q235R7',
  status: errors.length === 0
    ? 'ANDROID12_SMALL_SPLASH_ICON_ELIMINATION_Q235R7_STATIC_READY_BUT_REAL_ANDROID_RETEST_REQUIRED'
    : 'ANDROID12_SMALL_SPLASH_ICON_ELIMINATION_Q235R7_BLOCKED',
  errors,
  android12TransparentIconRestored: true,
  fullSplashOwnedByNativeOverlay: true,
  readySignalOnlyReleasePreserved: true,
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  flutterRunPassClaimed: false,
  androidRealDeviceSplashPassClaimed: false
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/android12_small_splash_icon_elimination_q235r7_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/android12_small_splash_icon_elimination_q235r7_report.md'), `# V172-Q235R7 Android 12 Small Splash Icon Elimination\n\nStatus: ${report.status}\n\nAndroid 12 transparent icon restored: true\n\nFull splash owned by native overlay: true\n\nFlutter/Android PASS claimed: false\n`);

if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}

console.log(report.status);
