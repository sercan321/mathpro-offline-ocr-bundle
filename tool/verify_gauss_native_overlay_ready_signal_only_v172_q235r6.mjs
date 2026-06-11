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
const fullPhase = 'V172-Q235R6-GAUSS-NATIVE-OVERLAY-READY-SIGNAL-ONLY';

const requiredFiles = [
  "lib/app/gauss_native_overlay_ready_signal_only_policy.dart",
  "test/v172_q235r6_gauss_native_overlay_ready_signal_only_test.dart",
  "android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt",
  "lib/app/mathpro_app.dart",
  "lib/app/gauss_splash_screen.dart",
  "android/app/src/main/res/drawable/launch_background.xml",
  "android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png",
  "assets/branding/gauss_splash_screen.png",
  "assets/mathlive/manifest.json",
  "README.md"
];
for (const required of requiredFiles) if (!exists(required)) fail(`missing Q235R6 required file: ${required}`);

const policy = read('lib/app/gauss_native_overlay_ready_signal_only_policy.dart');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const app = read('lib/app/mathpro_app.dart');
const splash = read('lib/app/gauss_splash_screen.dart');
const launchBackground = read('android/app/src/main/res/drawable/launch_background.xml');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');

const policyMarkers = [
  "phase = 'V172-Q235R6'",
  "triggeredByNoFixedSplashDurationRequest = true",
  "nativeOverlayAboveFlutterViewEnabled = true",
  "nativeOverlayUsesFullSplashArtwork = true",
  "nativeOverlayUsesFitCenter = true",
  "hardMaxNativeSplashTimeoutRemoved = true",
  "hardMinNativeSplashTimeoutRemoved = true",
  "releaseOnlyOnFlutterReadySignal = true",
  "releaseSignalSentAfterAppShellChildFrame = true",
  "splashCanRemainAsLongAsStartupNeeds = true",
  "nativeOverlayHasNoTimeCap = true",
  "flutterPosterUsesBoxFitContain = true",
  "appShellStackedBehindSplash = false",
  "firstFrameDeferralAllowed = false",
  "keyboardMutationAllowed = false",
  "mathLiveMutationAllowed = false",
  "graphRuntimeMutationAllowed = false",
  "flutterRunPassClaimedByAssistant = false",
  "androidRealDeviceSplashPassClaimedByAssistant = false"
];
for (const marker of policyMarkers) if (!policy.includes(marker)) fail(`Q235R6 policy missing marker: ${marker}`);

const mainMarkers = [
  "class MainActivity : FlutterActivity()",
  "nativeSplashChannelName = \"mathpro/native_splash\"",
  "installNativeSplashOverlay()",
  "addContentView(splash, params)",
  "R.drawable.gauss_splash_screen_native",
  "ImageView.ScaleType.FIT_CENTER",
  "\"releaseNativeSplash\"",
  "hideNativeSplashOverlay()",
  "removeView(overlay)"
];
for (const marker of mainMarkers) if (!mainActivity.includes(marker)) fail(`MainActivity missing marker: ${marker}`);

const forbiddenMarkers = [
  "maxNativeSplashVisibleMs",
  "minNativeSplashVisibleMs",
  "maybeHideNativeSplashOverlay",
  "flutterReleaseRequested",
  "nativeSplashCreatedAtMs",
  "postDelayed({ hideNativeSplashOverlay()",
  "postDelayed({ maybeHideNativeSplashOverlay()",
  "elapsedMs >=",
  "remainingMs"
];
for (const forbidden of forbiddenMarkers) if (mainActivity.includes(forbidden)) fail(`MainActivity still contains forbidden timeout marker: ${forbidden}`);

if (!app.includes('home: const GaussStartupSplash(child: MathProAppShell()),')) fail('MathProApp must still use Flutter poster bridge');
if (!splash.includes("MethodChannel('mathpro/native_splash')")) fail('Dart splash missing native MethodChannel');
if (!splash.includes("invokeMethod<void>('releaseNativeSplash')")) fail('Dart splash missing releaseNativeSplash invoke');
if (!splash.includes('_scheduleNativeSplashReleaseAfterChildFrame')) fail('Dart splash missing ready-release scheduler');
if (!splash.includes('addPostFrameCallback')) fail('Dart splash must release after a frame');
if (!splash.includes('fit: BoxFit.contain')) fail('Splash must use BoxFit.contain');
if (splash.includes('fit: BoxFit.cover')) fail('Splash must not use BoxFit.cover');
if (splash.includes('Stack(')) fail('AppShell must not be stacked behind Flutter splash poster');
if (splash.includes('deferFirstFrame') || splash.includes('allowFirstFrame')) fail('first-frame deferral returned');
if (!launchBackground.includes('@drawable/gauss_splash_screen_native')) fail('native launch background artwork missing');

if (sha('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt') !== 'be00452868a25aeab056009185a679bde8c4eac025b97210b4b2b2b8c0b74cbe') fail('MainActivity hash mismatch');
if (sha('assets/branding/gauss_splash_screen.png') !== 'f3f35b0444cc882c32e8b48919a50101e26e402b69e08c20de84ac9c42723533') fail('splash asset hash mismatch');
if (sha('android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png') !== 'c8256729c2eac821bfcfd103a525d531a442902b583b8f55ffb627f4a1926596') fail('native splash asset hash mismatch');

if (manifest.gaussNativeOverlayReadySignalOnlyLatestPhase !== fullPhase) fail('manifest latest Q235R6 phase mismatch');
const env = manifest.v172Q235R6GaussNativeOverlayReadySignalOnly;
if (!env || env.phase !== fullPhase) fail('manifest Q235R6 envelope missing');
else {
  for (const [key, expected] of Object.entries({
    hardMaxNativeSplashTimeoutRemoved: true,
    hardMinNativeSplashTimeoutRemoved: true,
    releaseOnlyOnFlutterReadySignal: true,
    releaseSignalSentAfterAppShellChildFrame: true,
    splashCanRemainAsLongAsStartupNeeds: true,
    nativeOverlayHasNoTimeCap: true,
    flutterRunPassClaimed: false,
    androidRealDeviceSplashPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q235R6 ${key} expected ${expected} got ${env[key]}`);
}
if (!readme.includes('## V172-Q235R6 — GAUSS Native Overlay Ready-Signal-Only Release')) fail('README missing Q235R6 section');

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
  "android/app/src/main/AndroidManifest.xml": "e788776fb08b0e63d7beb9844b34df0e198a913b715dcfbef3df6e2ef77f5b20"
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`protected hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

const report = {
  phase: 'V172-Q235R6',
  status: errors.length === 0
    ? 'GAUSS_NATIVE_OVERLAY_READY_SIGNAL_ONLY_Q235R6_STATIC_READY_BUT_REAL_ANDROID_RETEST_REQUIRED'
    : 'GAUSS_NATIVE_OVERLAY_READY_SIGNAL_ONLY_Q235R6_BLOCKED',
  errors,
  noHardNativeSplashTimeout: true,
  releaseOnlyOnFlutterReadySignal: true,
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  flutterRunPassClaimed: false,
  androidRealDeviceSplashPassClaimed: false
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/gauss_native_overlay_ready_signal_only_q235r6_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/gauss_native_overlay_ready_signal_only_q235r6_report.md'), `# V172-Q235R6 GAUSS Native Overlay Ready-Signal-Only\n\nStatus: ${report.status}\n\nNo hard native splash timeout: true\n\nRelease only on Flutter ready signal: true\n\nFlutter/Android PASS claimed: false\n`);

if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}

console.log(report.status);
