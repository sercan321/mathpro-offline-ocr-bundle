#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/app/gauss_splash_android_adaptive_icon_resource_link_repair_policy.dart',
  'test/v172_q235r1_android_adaptive_icon_resource_link_repair_test.dart',
  'lib/app/gauss_splash_screen.dart',
  'assets/mathlive/manifest.json',
  'README.md',
]) if (!exists(required)) fail(`missing Q235R1 required file: ${required}`);

const policy = read('lib/app/gauss_splash_android_adaptive_icon_resource_link_repair_policy.dart');
const splash = read('lib/app/gauss_splash_screen.dart');
const manifest = read('assets/mathlive/manifest.json');
const readme = read('README.md');

if (exists('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml')) fail('Q235R2 removed adaptive ic_launcher.xml; file returned');
if (exists('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml')) fail('Q235R2 removed adaptive ic_launcher_round.xml; file returned');

for (const marker of [
  "phase = 'V172-Q235R1'",
  'triggeredByUserSideAaptFailure = true',
  'invalidDrawableNodpiReferenceRemoved = true',
  'q235R2AdaptiveIconXmlRouteRemoved = true',
  'q235R2ExactPngLauncherRouteActive = true',
  'boxFitContainPreserved = true',
  'flutterRunPassClaimedByAssistant = false',
]) if (!policy.includes(marker)) fail(`policy missing marker: ${marker}`);

if (!splash.includes('fit: BoxFit.contain')) fail('Q235 contain-fit splash was lost');
if (splash.includes('fit: BoxFit.cover')) fail('crop-prone BoxFit.cover returned');
if (!manifest.includes('V172-Q235R2-GAUSS-SPLASH-BOOT-AND-LAUNCHER-ICON-VISUAL-REPAIR')) fail('manifest missing Q235R2 phase');
if (!readme.includes('V172-Q235R2')) fail('README missing Q235R2 section');

if (errors.length) {
  console.error(`GAUSS_SPLASH_ANDROID_ADAPTIVE_ICON_RESOURCE_LINK_REPAIR_Q235R1_FAILED: ${errors.join('; ')}`);
  process.exit(1);
}
console.log('GAUSS_SPLASH_ANDROID_ADAPTIVE_ICON_RESOURCE_LINK_REPAIR_Q235R1_STATIC_READY_WITH_Q235R2_NO_ADAPTIVE_XML_VISUAL_SUCCESSOR_BUT_REAL_FLUTTER_RUN_RETEST_REQUIRED');
