#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';

const phase = 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME';
const q247r1 = 'V172-Q247R1-PP_FORMULANET_S_USER_SELECTION_LOCK';
const root = process.cwd();
const fail = (msg) => { console.error(`DEFERRED_MODEL_DOWNLOAD_RUNTIME_Q248_BLOCKED: ${msg}`); process.exit(1); };
const exists = (p) => fs.existsSync(`${root}/${p}`);
const read = (p) => fs.readFileSync(`${root}/${p}`, 'utf8');
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(`${root}/${p}`)).digest('hex');

const required = [
  'lib/features/camera/gauss_pp_formulanet_s_user_selection_policy.dart',
  'lib/features/camera/gauss_pp_formulanet_s_user_selection.dart',
  'lib/features/camera/gauss_deferred_model_download_runtime_policy.dart',
  'lib/features/camera/gauss_deferred_model_download_runtime.dart',
  'test/v172_q247r1_pp_formulanet_s_user_selection_test.dart',
  'test/v172_q248_deferred_model_download_runtime_test.dart',
  'tool/verify_pp_formulanet_s_user_selection_v172_q247r1.mjs',
  'tool/verify_deferred_model_download_runtime_v172_q248.mjs',
  'docs/audit/V172_Q248_DEFERRED_MODEL_DOWNLOAD_RUNTIME_AUDIT.md',
  'docs/audit/V172_Q248_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
];
for (const p of required) if (!exists(p)) fail(`missing required Q248 file: ${p}`);

const policy = read('lib/features/camera/gauss_deferred_model_download_runtime_policy.dart');
const runtime = read('lib/features/camera/gauss_deferred_model_download_runtime.dart');
const test = read('test/v172_q248_deferred_model_download_runtime_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
const readme = read('README.md');
const audit = read('docs/audit/V172_Q248_DEFERRED_MODEL_DOWNLOAD_RUNTIME_AUDIT.md');
const changed = read('docs/audit/V172_Q248_CHANGED_FILES.md');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  phase,
  q247r1,
  'selectedEngineLabel = \'PP-FormulaNet-S\'',
  'fallbackEngineLabel = \'PP-FormulaNet_plus-L\'',
  'modelPackId = \'gauss_pp_formulanet_s_optional_math_ocr_pack\'',
  'modelInstallMode = \'deferred-after-install\'',
  'modelStoragePolicy = \'app-private-storage\'',
  'sha256VerificationRequiredBeforeReady = true',
  'privateAppStorageRequiredBeforeReady = true',
  'offlineAfterInstallRequiredBeforeInference = true',
  'mathLiveEditableReviewRequiredBeforeImport = true',
  'baseApkMustNotCarryModelBytes = true',
  'brokenOrUnverifiedModelMustNotRun = true',
  'q249RuntimeAdapterStillRequired = true',
  'realOcrRuntimeAdded = false',
  'paddleRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'productionDownloadWorkerImplemented = false',
  'productionInferenceAllowed = false',
  'directSolveFromCameraAllowed = false',
  'androidToolchainModernizationDeferredToQ253 = true',
]) if (!policy.includes(marker)) fail(`Q248 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussDeferredModelDownloadStatus',
  'notInstalled',
  'queued',
  'downloading',
  'verifying',
  'ready',
  'failed',
  'updateAvailable',
  'disabledByUser',
  'GaussPpFormulaNetSDeferredModelManifest',
  'productionModelUrlBound = false',
  'modelBinaryBundledInBaseApp = false',
  'productionDownloadWorkerImplemented = false',
  'productionInferenceAllowed = false',
  'GaussDeferredModelArtifactEvidence',
  'GaussDeferredModelReadinessDecision',
  'blockedSha256Mismatch',
  'blockedBaseApkBundlingAttempt',
  'readyForFutureQ249AdapterOnly',
  'evaluateReadiness',
  'canRunInferenceNow: false',
  'canProceedToQ249Adapter: true',
]) if (!runtime.includes(marker)) fail(`Q248 runtime missing marker: ${marker}`);

for (const marker of [
  phase,
  'PP-FormulaNet-S',
  'deferredModelStateMachineImplemented, isTrue',
  'modelIntegrityGateImplemented, isTrue',
  'productionInferenceAllowed, isFalse',
  'GaussDeferredModelDownloadStatus.ready',
  'blockedNoVerifiedArtifact',
  'blockedSha256Mismatch',
  'blockedDirectSolveAttempt',
  'readyForFutureQ249AdapterOnly',
  'camera: 0.10.6',
  'camera_android',
]) if (!test.includes(marker)) fail(`Q248 test missing marker: ${marker}`);

if (manifest.deferredModelDownloadRuntimeLatestPhase !== phase) fail('manifest latest Q248 phase missing');
const env = manifest.v172Q248DeferredModelDownloadRuntime;
if (!env || env.phase !== phase) fail('manifest Q248 envelope missing');
for (const [key, expected] of Object.entries({
  closesOverPhase: q247r1,
  selectedEngineLabel: 'PP-FormulaNet-S',
  selectedEngineFamily: 'pp_formula_net_s',
  fallbackEngineLabel: 'PP-FormulaNet_plus-L',
  modelPackId: 'gauss_pp_formulanet_s_optional_math_ocr_pack',
  modelInstallMode: 'deferred-after-install',
  modelStoragePolicy: 'app-private-storage',
  defaultNetworkPolicy: 'wifi-only-until-user-overrides',
  q247R1UserSelectionPreserved: true,
  deferredModelStateMachineImplemented: true,
  modelIntegrityGateImplemented: true,
  sha256VerificationRequiredBeforeReady: true,
  privateAppStorageRequiredBeforeReady: true,
  offlineAfterInstallRequiredBeforeInference: true,
  mathLiveEditableReviewRequiredBeforeImport: true,
  baseApkMustNotCarryModelBytes: true,
  brokenOrUnverifiedModelMustNotRun: true,
  q249RuntimeAdapterStillRequired: true,
  realOcrRuntimeAdded: false,
  paddleRuntimeAdded: false,
  paddleOcrDependencyAdded: false,
  textOcrFallbackRuntimeAdded: false,
  onnxRuntimeAdded: false,
  modelBinaryBundledInBaseApp: false,
  productionModelUrlBound: false,
  productionDownloadWorkerImplemented: false,
  productionInferenceAllowed: false,
  productionRuntimeBindingAllowed: false,
  cameraRuntimeShellChanged: false,
  workspaceRuntimeChanged: false,
  mathLiveProductionBridgeCalled: false,
  directWorkspaceImportImplemented: false,
  directSolveFromCameraAllowed: false,
  directGraphFromCameraAllowed: false,
  directSolutionFromCameraAllowed: false,
  directHistoryFromCameraAllowed: false,
  androidToolchainModernizationDeferredToQ253: true,
  cameraDependencyChanged: false,
  androidSettingsGradleChanged: false,
  androidManifestChanged: false,
  mainActivityChanged: false,
  keyboardMutationAllowed: false,
  longPressMutationAllowed: false,
  moreMutationAllowed: false,
  mathLiveProductionMutationAllowed: false,
  graphMutationAllowed: false,
  solutionMutationAllowed: false,
  historyMutationAllowed: false,
  splashLauncherMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDeviceDownloadPassClaimedByAssistant: false,
  realPpFormulaNetSInferencePassClaimedByAssistant: false,
  nextPlannedPhase: 'V172-Q249-OCR-RUNTIME-ADAPTER',
})) if (env[key] !== expected) fail(`manifest Q248 ${key} expected ${expected} got ${env[key]}`);

for (const state of ['notInstalled','queued','downloading','verifying','ready','failed','updateAvailable','disabledByUser']) {
  if (!env.installStates?.includes(state)) fail(`manifest Q248 installStates missing ${state}`);
}
for (const gate of ['verifiedPpFormulaNetSArtifact','expectedSha256Present','actualSha256MatchesExpected','modelSizeWithinDeferredBudget','privateAppStorage','offlineAfterInstall','mathLiveEditableReviewRequired','directSolveBlocked','notBundledInBaseApk']) {
  if (!env.requiredReadinessGates?.includes(gate)) fail(`manifest Q248 requiredReadinessGates missing ${gate}`);
}
for (const rel of required) {
  if (!env.changedFiles?.includes(rel)) fail(`manifest Q248 changedFiles missing ${rel}`);
}

for (const marker of [
  '## V172-Q248 Deferred Model Download Runtime',
  'PP-FormulaNet-S deferred model runtime contract',
  'No production URL, downloader worker, Paddle runtime, model binary, or inference path is added in Q248',
  'OCR output must still go to editable MathLive review',
]) if (!readme.includes(marker)) fail(`README missing Q248 marker: ${marker}`);
for (const marker of [
  '# V172-Q248 Deferred Model Download Runtime Audit',
  'PP-FormulaNet-S is preserved as the selected candidate',
  'does not bundle model bytes into the base APK',
  'does not add production OCR inference',
  'Direct solve remains blocked',
]) if (!audit.includes(marker)) fail(`Q248 audit missing marker: ${marker}`);
for (const marker of ['# V172-Q248 Changed Files','gauss_deferred_model_download_runtime_policy.dart','verify_deferred_model_download_runtime_v172_q248.mjs','Protected Runtime Surfaces']) {
  if (!changed.includes(marker)) fail(`Q248 changed-files missing marker: ${marker}`);
}

if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must keep camera: 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must keep camera_android: 0.10.9+3');
if (/camera_android_camerax/.test(pubspec)) fail('Q248 must not reintroduce camera_android_camerax');
for (const regex of [/^\s*google_mlkit_text_recognition\s*:/m,/^\s*paddle/m,/^\s*onnxruntime/m,/^\s*pix2text/m,/^\s*flutter_downloader\s*:/m,/^\s*workmanager\s*:/m,/^\s*http\s*:/m]) {
  if (regex.test(pubspec)) fail(`Q248 must not add OCR/download/runtime dependency matching ${regex}`);
}
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('Q248 must keep Kotlin plugin 2.1.0');
if (!settings.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settings.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('AGP must remain 8.3.2 for Q248 or move to 8.6.1 only through Q253 successor modernization');
}
if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission missing');
for (const forbidden of ['READ_MEDIA_IMAGES','READ_EXTERNAL_STORAGE','INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q248 must not add Android manifest permission: ${forbidden}`);
}

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
  'android/settings.gradle': '13fddb7fda0628619eb9341fa53c40b6e360b56a515464cd4148ddb6d56f1666',
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51',
};
for (const [p, expected] of Object.entries(protectedHashes)) {
  if (!exists(p)) fail(`protected file missing: ${p}`);
  const actual = sha(p);
  if (p === 'android/settings.gradle' && q253ToolchainActive) {
    const q253Expected = 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30';
    if (actual !== expected && actual !== q253Expected) fail(`protected hash changed for ${p}: ${actual} != ${expected} or ${q253Expected}`);
    continue;
  }
  if (actual !== expected) fail(`protected hash changed for ${p}: ${actual} != ${expected}`);
}

const runtimeFiles = [
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'lib/features/camera/gauss_mathlive_ocr_review_surface.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/app/app_shell.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
].map(read).join('\n');
for (const forbidden of ['runOcrEngine(','setWorkspaceLatexWithoutReview','evaluateFromCamera','graphFromCamera','writeHistoryFromCamera','solveFromCamera','downloadModelNow','PaddleOCR','FormulaRecognition(']) {
  if (runtimeFiles.includes(forbidden)) fail(`Q248 must not mutate runtime OCR/solver marker: ${forbidden}`);
}

const forbiddenExt = /\.(onnx|tflite|pt|pth|pdmodel|pdiparams|bin)$/i;
const walk = (dir) => {
  for (const name of fs.readdirSync(dir)) {
    const p = `${dir}/${name}`;
    const rel = p.slice(root.length + 1);
    const st = fs.statSync(p);
    if (st.isDirectory()) walk(p);
    else if (forbiddenExt.test(name)) fail(`model/binary artifact bundled in base app: ${rel}`);
  }
};
walk(root);

console.log(JSON.stringify({
  phase,
  status: 'DEFERRED_MODEL_DOWNLOAD_RUNTIME_Q248_STATIC_READY_BUT_REAL_DOWNLOADER_RUNTIME_AND_FLUTTER_RETEST_REQUIRED',
  selectedEngineLabel: env.selectedEngineLabel,
  installStates: env.installStates.length,
  requiredReadinessGates: env.requiredReadinessGates.length,
  realOcrRuntimeAdded: env.realOcrRuntimeAdded,
  modelBinaryBundledInBaseApp: env.modelBinaryBundledInBaseApp,
  productionInferenceAllowed: env.productionInferenceAllowed,
  protectedHashComparison: 'PASS',
}, null, 2));
