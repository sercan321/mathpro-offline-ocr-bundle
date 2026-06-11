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
const fullPhase = 'V172-Q239A-WORKSPACE-CAMERA-ENTRY-BUTTON-REPLACEMENT';
const successorPhase = 'V172-Q239B-CAMERA-PERMISSION-CAPTURE-SHELL';

for (const required of [
  'lib/features/camera/gauss_workspace_camera_entry_policy.dart',
  'lib/features/workspace/workspace_panel.dart',
  'test/v172_q239a_workspace_camera_entry_button_test.dart',
  'docs/audit/V172_Q239A_WORKSPACE_CAMERA_ENTRY_BUTTON_AUDIT.md',
  'docs/audit/V172_Q239A_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml'
]) if (!exists(required)) fail(`missing Q239A required file: ${required}`);

const policy = read('lib/features/camera/gauss_workspace_camera_entry_policy.dart');
const workspace = read('lib/features/workspace/workspace_panel.dart');
const test = read('test/v172_q239a_workspace_camera_entry_button_test.dart');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');
const hasQ239BSuccessor = manifest.cameraPermissionCaptureShellLatestPhase === successorPhase;

for (const marker of [
  "phase = 'V172-Q239A'",
  "fullPhase = 'V172-Q239A-WORKSPACE-CAMERA-ENTRY-BUTTON-REPLACEMENT'",
  'replacesWorkspaceEllipsisAction = true',
  'workspaceTopActionSlotPreserved = true',
  'premiumVisualShellPreserved = true',
  'tooltipProvided = true',
  'semanticLabelProvided = true',
  'safePlaceholderSheetOnly = true',
  'cameraPackageAdded = false',
  'androidCameraPermissionAdded = false',
  'cameraPreviewImplemented = false',
  'ocrEngineAdded = false',
  'deferredModelDownloadImplemented = false',
  'mathLiveImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'keyboardMutationAllowed = false',
  'longPressMutationAllowed = false',
  'moreMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'graphRuntimeMutationAllowed = false',
  'solutionMutationAllowed = false',
  'historyMutationAllowed = false',
  'splashMutationAllowed = false',
  'launcherIconMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'flutterRunPassClaimedByAssistant = false',
  'androidRealDeviceCameraPassClaimedByAssistant = false'
]) if (!policy.includes(marker)) fail(`Q239A policy missing marker: ${marker}`);

for (const marker of [
  "ValueKey('mathpro-workspace-camera-entry-button')",
  'Icons.photo_camera_outlined',
  "tooltip: 'Kamera'",
  "semanticLabel: 'Kamera ile ifade tara'",
]) if (!workspace.includes(marker)) fail(`workspace camera entry missing marker: ${marker}`);

if (hasQ239BSuccessor) {
  for (const marker of [
    '_openCameraCaptureShell(context)',
    'GaussCameraCaptureShell',
  ]) if (!workspace.includes(marker)) fail(`Q239A successor workspace route missing marker: ${marker}`);
} else {
  for (const marker of [
    '_showCameraEntrySheet(context)',
    'void _showCameraEntrySheet(BuildContext context)',
    'Kamera ile ifade al',
    'Gelişmiş matematik okuma modülü sonraki fazda etkinleşecek',
    'MathLive içinde düzenlenebilir'
  ]) if (!workspace.includes(marker)) fail(`Q239A placeholder workspace missing marker: ${marker}`);
}

for (const forbidden of [
  "ValueKey('mathpro-more-placeholder-button')",
  'Icons.more_horiz_rounded',
  "tooltip: 'Daha fazla'",
  'onPressed: () {}'
]) if (workspace.includes(forbidden)) fail(`inert ellipsis workspace action returned: ${forbidden}`);

if (hasQ239BSuccessor) {
  const q239bOriginalCameraPackage = /^\s*camera\s*:\s*\^?0\.11\.0\s*$/m.test(pubspec);
  const q244r6PreCameraXSuccessorPackage = /^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)
    && /^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)
    && !pubspec.includes('camera_android_camerax');
  if (!q239bOriginalCameraPackage && !q244r6PreCameraXSuccessorPackage) {
    fail('Q239B/Q244R6+ successor must declare either camera 0.11.0 or the active pre-CameraX camera 0.10.6 + camera_android 0.10.9+3 dependency line');
  }
  if (!androidManifest.includes('android.permission.CAMERA')) fail('Q239B successor must declare Android camera permission');
} else {
  if (/^\s*camera\s*:/m.test(pubspec)) fail('Q239A without successor must not declare camera dependency');
  if (androidManifest.includes('android.permission.CAMERA')) fail('Q239A without successor must not declare Android camera permission');
}

for (const regex of [
  /^\s*google_mlkit_text_recognition\s*:/m,
  /^\s*google_mlkit_commons\s*:/m,
  /^\s*paddle/m,
  /^\s*onnxruntime/m,
  /^\s*pix2text/m,
]) if (regex.test(pubspec)) fail(`Q239A/Q239B must not add OCR/model dependency matching ${regex}`);

for (const forbidden of [
  'android.permission.READ_MEDIA_IMAGES',
  'android.permission.READ_EXTERNAL_STORAGE'
]) if (androidManifest.includes(forbidden)) fail(`Q239A/Q239B must not add Android media permission: ${forbidden}`);

if (manifest.workspaceCameraEntryButtonLatestPhase !== fullPhase) fail('manifest latest Q239A phase mismatch');
const env = manifest.v172Q239AWorkspaceCameraEntryButton;
if (!env || env.phase !== fullPhase) fail('manifest Q239A envelope missing');
else {
  for (const [key, expected] of Object.entries({
    replacesWorkspaceEllipsisAction: true,
    workspaceTopActionSlotPreserved: true,
    premiumVisualShellPreserved: true,
    safePlaceholderSheetOnly: true,
    cameraPackageAdded: false,
    androidCameraPermissionAdded: false,
    cameraPreviewImplemented: false,
    ocrEngineAdded: false,
    deferredModelDownloadImplemented: false,
    mathLiveImportImplemented: false,
    directSolveFromCameraAllowed: false,
    keyboardMutationAllowed: false,
    longPressMutationAllowed: false,
    moreMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    graphRuntimeMutationAllowed: false,
    solutionMutationAllowed: false,
    historyMutationAllowed: false,
    splashMutationAllowed: false,
    launcherIconMutationAllowed: false,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    flutterRunPassClaimed: false,
    androidRealDeviceCameraPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q239A ${key} expected ${expected} got ${env[key]}`);
}

if (!test.includes('GaussWorkspaceCameraEntryButtonPolicy')) fail('Q239A test is not bound to policy');
if (!readme.includes('## V172-Q239A — Workspace Camera Entry Button Replacement')) fail('README missing Q239A section');

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
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt': 'c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1',
  'lib/features/graph/graph_card.dart': '124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f',
  'lib/app/gauss_splash_screen.dart': '465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81'
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected/red-line file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`protected/red-line hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

const report = {
  phase: 'V172-Q239A',
  successorDetected: hasQ239BSuccessor,
  status: errors.length === 0
    ? 'WORKSPACE_CAMERA_ENTRY_BUTTON_Q239A_STATIC_READY_WITH_Q239B_SUCCESSOR_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED'
    : 'WORKSPACE_CAMERA_ENTRY_BUTTON_Q239A_BLOCKED',
  errors,
  replacesWorkspaceEllipsisAction: true,
  cameraDependencyAllowedByQ239BSuccessor: hasQ239BSuccessor,
  cameraDependencyAllowsQ244R6PreCameraXSuccessor: hasQ239BSuccessor && /^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec) && /^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec),
  androidCameraPermissionAllowedByQ239BSuccessor: hasQ239BSuccessor,
  ocrEngineAdded: false,
  mathLiveImportImplemented: false,
  directSolveFromCameraAllowed: false,
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  flutterRunPassClaimed: false,
  androidRealDeviceCameraPassClaimed: false
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/workspace_camera_entry_button_q239a_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/workspace_camera_entry_button_q239a_report.md'), `# V172-Q239A Workspace Camera Entry Button Replacement\n\nStatus: ${report.status}\n\nQ239B successor detected: ${hasQ239BSuccessor}\n\nWorkspace ellipsis replaced by camera entry: true\n\nOCR / MathLive import / direct solve added: false\n\nFlutter/Android PASS claimed: false\n\nQ244R6/Q244R8 pre-CameraX successor accepted: ${report.cameraDependencyAllowsQ244R6PreCameraXSuccessor}\n`);

if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}

console.log(report.status);
