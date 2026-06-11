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

for (const required of [
  'assets/branding/gauss_app_icon_1024.png',
  'android/app/src/main/res/mipmap-mdpi/ic_launcher.png',
  'android/app/src/main/res/mipmap-hdpi/ic_launcher.png',
  'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png',
  'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png',
  'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png',
  'android/app/src/main/res/mipmap-mdpi/ic_launcher_round.png',
  'android/app/src/main/res/mipmap-hdpi/ic_launcher_round.png',
  'android/app/src/main/res/mipmap-xhdpi/ic_launcher_round.png',
  'android/app/src/main/res/mipmap-xxhdpi/ic_launcher_round.png',
  'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png',
  'lib/features/branding/premium_black_on_white_launcher_icon_policy.dart',
  'test/v172_q230_premium_black_on_white_launcher_icon_test.dart',
  'assets/mathlive/manifest.json',
  'README.md',
  'android/app/src/main/AndroidManifest.xml'
]) if (!exists(required)) fail(`missing Q230 required file: ${required}`);

if (exists('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml')) fail('Q235R2 removed adaptive ic_launcher.xml to prevent visual zoom; file returned');
if (exists('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml')) fail('Q235R2 removed adaptive ic_launcher_round.xml to prevent visual zoom; file returned');

const policy = read('lib/features/branding/premium_black_on_white_launcher_icon_policy.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  'userProvidedReferenceUsed = true',
  'newImageGenerationUsed = false',
  'launcherIconOnlyPhase = true',
  'premiumBlackOnWhiteLauncherIconApplied = true',
  'keyboardMutationAllowed = false',
  'mathLiveMutationAllowed = false',
  'graphMutationAllowed = false',
  'splashMutationAllowed = false',
  'androidRealDeviceIconPassClaimedByAssistant = false',
  'q235R2ExactPngLauncherRouteActive = true',
  'q235R2AdaptiveIconXmlRouteRemoved = true'
]) if (!policy.includes(marker)) fail(`Q230 policy missing marker: ${marker}`);

if (!androidManifest.includes('android:icon="@mipmap/ic_launcher"')) fail('AndroidManifest icon reference changed unexpectedly');
if (!androidManifest.includes('android:roundIcon="@mipmap/ic_launcher_round"')) fail('AndroidManifest roundIcon reference changed unexpectedly');

const assetHashes = {
  "assets/branding/gauss_app_icon_1024.png": "917186cbc5b2868fc18023611ec0559d657f3589f9e53be11658a715549e2bd4",
  "android/app/src/main/res/mipmap-mdpi/ic_launcher.png": "467b15bd8cdcc21e3701829bd3d3b1bf2119d5894ffeeecf05f84ea4684a9d3d",
  "android/app/src/main/res/mipmap-hdpi/ic_launcher.png": "e8c6437eef550ce7b48043496e70830952fe352df3bbc0ab2bfe5e9c1db19bd0",
  "android/app/src/main/res/mipmap-xhdpi/ic_launcher.png": "7df777692e39e3b1f8280e4004602b0ba158168ed9dac30ca3f517edc17690f5",
  "android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png": "51bdc583a3afba5cd5a47415e6f25858ec7dab6baec90d0cac5234e8aea700a3",
  "android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png": "0e9bba3628291fdb62e372c9d81ae1a321183263381c161f701927b2ff0b7e51",
  "android/app/src/main/res/mipmap-mdpi/ic_launcher_round.png": "467b15bd8cdcc21e3701829bd3d3b1bf2119d5894ffeeecf05f84ea4684a9d3d",
  "android/app/src/main/res/mipmap-hdpi/ic_launcher_round.png": "e8c6437eef550ce7b48043496e70830952fe352df3bbc0ab2bfe5e9c1db19bd0",
  "android/app/src/main/res/mipmap-xhdpi/ic_launcher_round.png": "7df777692e39e3b1f8280e4004602b0ba158168ed9dac30ca3f517edc17690f5",
  "android/app/src/main/res/mipmap-xxhdpi/ic_launcher_round.png": "51bdc583a3afba5cd5a47415e6f25858ec7dab6baec90d0cac5234e8aea700a3",
  "android/app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png": "0e9bba3628291fdb62e372c9d81ae1a321183263381c161f701927b2ff0b7e51"
};
for (const [file, expected] of Object.entries(assetHashes)) {
  if (!exists(file)) fail(`missing launcher asset: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`asset hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

if (!readme.includes('V172-Q235R2')) fail('README missing Q235R2 successor note');
if (!manifest.v172Q235R2GaussSplashBootLauncherIconVisualRepair?.launcherUsesExactUserReferencePngRoute) fail('manifest missing Q235R2 exact PNG launcher route marker');

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
  "android/app/src/main/res/values/styles.xml": "986dcbc9ee5c07bfe946ec919b6df794daddddceb752e3277af4c6e7a2caa286",
  "android/app/src/main/res/values-v31/styles.xml": "a171cce0ccb7dd572c4a2fb12cafd127f5558aedc8eb098ff075b517d69b83fa"
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`protected hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

if (errors.length) {
  console.error(`PREMIUM_BLACK_ON_WHITE_LAUNCHER_ICON_Q230_BLOCKED: ${errors.join('; ')}`);
  process.exit(1);
}

console.log('PREMIUM_BLACK_ON_WHITE_LAUNCHER_ICON_Q230_STATIC_READY_WITH_Q235R7_ANDROID12_SMALL_ICON_SUCCESSOR_BUT_REAL_ANDROID_ICON_RETEST_REQUIRED');
