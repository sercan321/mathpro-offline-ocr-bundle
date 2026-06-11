#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';

const root = process.cwd();
const phase = 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION';
const fail = (message) => {
  console.error(`CAMERA_OCR_PREMIUM_FINAL_REGRESSION_Q252_BLOCKED: ${message}`);
  process.exit(1);
};
const read = (p) => fs.readFileSync(`${root}/${p}`, 'utf8');
const exists = (p) => fs.existsSync(`${root}/${p}`);
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(`${root}/${p}`)).digest('hex');

const policyPath = 'lib/features/camera/gauss_camera_ocr_premium_final_regression_policy.dart';
const courtPath = 'lib/features/camera/gauss_camera_ocr_premium_final_regression.dart';
const testPath = 'test/v172_q252_camera_ocr_premium_final_regression_test.dart';
const auditPath = 'docs/audit/V172_Q252_CAMERA_OCR_PREMIUM_FINAL_REGRESSION_AUDIT.md';
const changedPath = 'docs/audit/V172_Q252_CHANGED_FILES.md';

for (const file of [policyPath, courtPath, testPath, auditPath, changedPath, 'assets/mathlive/manifest.json', 'README.md']) {
  if (!exists(file)) fail(`missing Q252 file: ${file}`);
}

const policy = read(policyPath);
const court = read(courtPath);
const test = read(testPath);
const audit = read(auditPath);
const changed = read(changedPath);
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';

for (const marker of [
  phase,
  'V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT',
  'sourcePackageSha256',
  'fef6abfeeeb7b5b0c15801726a96555baea7cdd36855015756115f26d8508768',
  'PP-FormulaNet-S',
  'PP-FormulaNet_plus-L',
  'q245RealDeviceEvidenceClosureRequired = true',
  'q246BenchmarkPackageRequired = true',
  'q247WinnerGateRequired = true',
  'q247r1PpFormulaNetSUserSelectionRequired = true',
  'q248DeferredModelRuntimeRequired = true',
  'q249ReviewOnlyAdapterRequired = true',
  'q250MathLiveReviewImportRequired = true',
  'q251EndToEndCourtRequired = true',
  'keyboardLayoutMustRemainUnchanged = true',
  'moreInventoryMustRemainUnchanged = true',
  'longPressInventoryMustRemainUnchanged = true',
  'mathLiveProductionRouteMustRemainUnchanged = true',
  'graphSurfaceMustRemainUnchanged = true',
  'solutionSurfaceMustRemainUnchanged = true',
  'historySurfaceMustRemainUnchanged = true',
  'editableMathLiveReviewRequired = true',
  'userApprovalRequiredBeforeWorkspaceImport = true',
  'directWorkspaceImportAllowed = false',
  'directSolveFromCameraAllowed = false',
  'directGraphFromCameraAllowed = false',
  'directSolutionFromCameraAllowed = false',
  'directHistoryFromCameraAllowed = false',
  'realOcrRuntimeAdded = false',
  'paddleRuntimeAdded = false',
  'paddleOcrDependencyAdded = false',
  'ppFormulaNetSModelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'productionDownloadWorkerImplemented = false',
  'productionInferenceAllowed = false',
  'premiumFinalPassClaimedByAssistant = false',
  'androidToolchainModernizationDeferredToQ253 = true',
  'realPpFormulaNetSRuntimeIntegrationDeferred = true',
]) if (!policy.includes(marker)) fail(`Q252 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussCameraOcrPremiumFinalRegressionDecision',
  'blockedMissingQ251Court',
  'blockedProtectedSurfaceRegression',
  'blockedModelBundlingRegression',
  'blockedDirectCameraActionRegression',
  'blockedFakePassClaimRegression',
  'premiumFinalRegressionStaticReady',
  'class GaussCameraOcrPremiumFinalRegressionInput',
  'class GaussCameraOcrPremiumFinalRegressionResult',
  'canClaimRealOcrPass => false',
  'canClaimFlutterPassWithoutLogs => false',
  'canImportCameraOutputWithoutUserApproval => false',
  'canEvaluateCameraOutputBeforeReviewApproval => false',
  'canGraphCameraOutputBeforeReviewApproval => false',
  'canWriteSolutionOrHistoryBeforeReviewApproval => false',
  'class GaussCameraOcrPremiumFinalRegression',
  'requiresQ251EndToEndCourt = true',
  'requiresProtectedSurfaceHashesUnchanged = true',
  'requiresNoBaseApkModelBundle = true',
  'requiresNoPaddleRuntimeDependency = true',
  'requiresNoProductionModelUrl = true',
  'requiresMathLiveReviewAndUserApproval = true',
  'allowsDirectWorkspaceImport = false',
  'allowsDirectSolve = false',
  'allowsDirectGraph = false',
  'allowsDirectSolution = false',
  'allowsDirectHistory = false',
  'realInferenceEnabledInQ252 = false',
  'callsProductionMathLiveBridge = false',
  'forbiddenFinalRegressionActions',
  'runPpFormulaNetSInference',
  'bindPaddleRuntime',
  'bundlePpFormulaNetSModelInBaseApk',
  'setProductionModelUrl',
  'setWorkspaceLatexWithoutUserApproval',
  'Q252 final regression must close over the Q251 end-to-end court.',
  'PP-FormulaNet-S model bytes must not be bundled in the base APK during Q252.',
  'Camera output must not directly solve, graph, write Solution, or write History.',
]) if (!court.includes(marker)) fail(`Q252 court missing marker: ${marker}`);

for (const marker of [
  phase,
  'PP-FormulaNet-S',
  'camera: 0.10.6',
  'camera_android: 0.10.9+3',
  'records Q252 as premium final regression closure, not real OCR PASS',
  'passes final static regression only when the full Q245-Q251 safety chain is intact',
  'blocks protected-surface, model-bundle, direct-action, and fake-pass regressions',
  'runPpFormulaNetSInference',
  'FormulaRecognition(',
  'google_mlkit_text_recognition',
  'paddleocr',
  'onnxruntime',
]) if (!test.includes(marker)) fail(`Q252 test missing marker: ${marker}`);

if (![phase, 'V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE', 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD', 'V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK', 'V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD', 'V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE', 'V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN', 'V172-Q260-PP-FORMULANET-S-REAL-MODEL-DOWNLOAD-INTEGRATION-GATE', 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER', 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE', 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER', 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE', 'V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE', 'V172-Q264-PP-FORMULANET-S-RUNTIME-PROTOTYPE-EVIDENCE-INTAKE-GATE', 'V172-Q265-PP-FORMULANET-S-RUNTIME-EVIDENCE-ACCEPTANCE-COURT', 'V172-Q266-PP-FORMULANET-S-RUNTIME-ACTIVATION-DECISION-GATE', 'V172-Q267-PP-FORMULANET-S-RUNTIME-INTEGRATION-PREFLIGHT-PACKAGE', 'V172-Q268-PP-FORMULANET-S-ISOLATED-RUNTIME-IMPLEMENTATION-GATE', 'V172-Q269-PP-FORMULANET-S-RUNTIME-DEPENDENCY-ISOLATION', 'V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON', 'V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE', 'V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE', 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE', 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to this phase or successor through Q277');
if (manifest.cameraOcrPremiumFinalRegressionLatestPhase !== phase) fail('manifest missing cameraOcrPremiumFinalRegressionLatestPhase Q252');
const q252 = manifest.v172Q252CameraOcrPremiumFinalRegression;
if (!q252) fail('manifest missing v172Q252CameraOcrPremiumFinalRegression');
if (q252.selectedEngineLabel !== 'PP-FormulaNet-S') fail('manifest missing PP-FormulaNet-S selected engine for Q252');
if (q252.q251EndToEndCourtRequired !== true) fail('manifest must require Q251 end-to-end court');
if (q252.editableMathLiveReviewRequired !== true) fail('manifest must require editable MathLive review');
if (q252.userApprovalRequiredBeforeWorkspaceImport !== true) fail('manifest must require user approval');
if (q252.directWorkspaceImportAllowed !== false) fail('manifest must block direct workspace import');
if (q252.directSolveFromCameraAllowed !== false) fail('manifest must block direct solve');
if (q252.directGraphFromCameraAllowed !== false) fail('manifest must block direct graph');
if (q252.directSolutionFromCameraAllowed !== false) fail('manifest must block direct solution');
if (q252.directHistoryFromCameraAllowed !== false) fail('manifest must block direct history');
if (q252.realOcrRuntimeAdded !== false) fail('manifest must not add real OCR runtime');
if (q252.paddleRuntimeAdded !== false) fail('manifest must not add Paddle runtime');
if (q252.modelBinaryBundledInBaseApp !== false) fail('manifest must not bundle model binary');
if (q252.productionModelUrlBound !== false) fail('manifest must not bind production model URL');
if (q252.realEndToEndOcrPassClaimed !== false) fail('manifest must not claim real OCR PASS');
if (q252.premiumFinalPassClaimedByAssistant !== false) fail('manifest must not claim premium final PASS');
if (q252.androidToolchainModernizationDeferredToQ253 !== true) fail('manifest must defer Android toolchain to Q253');
if (!Array.isArray(q252.requiredFinalRegressionGates) || q252.requiredFinalRegressionGates.length < 18) fail('manifest must define Q252 final regression gates');
if (!Array.isArray(q252.deferredFuturePhases) || q252.deferredFuturePhases.length < 3) fail('manifest must define deferred future phases');

for (const marker of [phase, 'Q252', 'PP-FormulaNet-S', 'Q245', 'Q246', 'Q247', 'Q247R1', 'Q248', 'Q249', 'Q250', 'Q251', 'editable MathLive review', 'user approval', 'no Paddle', 'no model', 'no real OCR PASS', 'Q253']) {
  if (!readme.includes(marker)) fail(`README missing Q252 marker: ${marker}`);
  if (!audit.includes(marker)) fail(`audit missing Q252 marker: ${marker}`);
}
for (const marker of [
  'gauss_camera_ocr_premium_final_regression_policy.dart',
  'gauss_camera_ocr_premium_final_regression.dart',
  'verify_camera_ocr_premium_final_regression_v172_q252.mjs',
  'verify_ocr_mathlive_review_import_v172_q250.mjs',
  'verify_camera_math_ocr_end_to_end_court_v172_q251.mjs',
]) {
  if (!changed.includes(marker)) fail(`changed-files audit missing marker: ${marker}`);
}

if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must keep camera: 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must keep camera_android: 0.10.9+3');
for (const forbidden of ['camera_android_camerax', 'google_mlkit_text_recognition', 'paddleocr', 'onnxruntime', 'flutter_downloader']) {
  if (pubspec.includes(forbidden)) fail(`pubspec must not add dependency: ${forbidden}`);
}
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('Kotlin plugin 2.1.0 must remain');
if (!settings.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settings.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('AGP must remain 8.3.2 for Q252 or move to 8.6.1 only through Q253 successor modernization');
}
if (!androidManifest.includes('android.permission.CAMERA')) fail('CAMERA permission must remain');
if (androidManifest.includes('READ_MEDIA_IMAGES')) fail('Q252 must not add media permissions');

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
  'lib/features/camera/gauss_deferred_model_download_runtime.dart': '74a394ca4021bb2c2af99f45e9273e826a57c31b4f1804f91d5dfba73277b87d',
  'lib/features/camera/gauss_deferred_model_download_runtime_policy.dart': '9b9f4bc7aa352da2063ae5300256a4e2f78a9b8849e1e0d483d304be67c05ae1',
  'lib/features/camera/gauss_ocr_runtime_adapter.dart': '6f9c7f1208a09f3d067d27888eea8e74675a90f77035ec7bff724dd770675544',
  'lib/features/camera/gauss_ocr_runtime_adapter_policy.dart': '31575eb6767f1b6a1310535c1a9e51ad2178ace6605cca9addc5ee3258a82445',
  'lib/features/camera/gauss_ocr_mathlive_review_import.dart': '8e610c3753b8b20be9e1ed70f40b2dc48786abb1adda15cabe526ac0e1223fa3',
  'lib/features/camera/gauss_ocr_mathlive_review_import_policy.dart': 'b528add3552ebc501d0b175345e3afc0c646fbc151c2e6726509bc6c8d9b4a25',
  'lib/features/camera/gauss_mathlive_ocr_review_surface.dart': '226e64b5e50535976ac17b450cf45eac55d500fc7a9305aef3d7004ab9da39c0',
  'lib/features/camera/gauss_camera_math_ocr_end_to_end_court.dart': '91a066e6d0f350c0bbd8ed6a110e4d8a56d2aef18e8dd334f1267621f248fe02',
  'lib/features/camera/gauss_camera_math_ocr_end_to_end_court_policy.dart': '5747d190e226ec80b72b3a11b8b696ffaad9951fefa8e56de18b4473d5f57af6',
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
  'lib/features/workspace/workspace_panel.dart',
  'lib/app/app_shell.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/history/history_controller.dart',
].map(read).join('\n');
for (const forbidden of ['runPpFormulaNetSInference(', 'FormulaRecognition(', 'runOcrEngine(', 'setWorkspaceLatexWithoutUserApproval', 'setWorkspaceLatexWithoutReview', 'evaluateFromCamera', 'graphFromCamera', 'writeHistoryFromCamera', 'solveFromCamera', 'downloadModelNow', 'PaddleOCR']) {
  if (runtimeFiles.includes(forbidden)) fail(`Q252 must not mutate active runtime marker: ${forbidden}`);
}

const forbiddenExt = /\.(onnx|tflite|pt|pth|pdmodel|pdiparams|bin)$/i;
const walk = (dir) => {
  for (const name of fs.readdirSync(dir)) {
    const p = `${dir}/${name}`;
    const rel = p.slice(root.length + 1);
    const st = fs.statSync(p);
    if (st.isDirectory()) {
      if (['.dart_tool', 'build', '.gradle', 'node_modules', '__pycache__'].includes(name)) fail(`forbidden artifact directory present: ${rel}`);
      walk(p);
    } else {
      if (forbiddenExt.test(name)) fail(`model/binary artifact bundled in base app: ${rel}`);
      if (/\.pyc$/.test(name)) fail(`forbidden pyc artifact present: ${rel}`);
    }
  }
};
walk(root);

console.log(JSON.stringify({
  phase,
  status: 'CAMERA_OCR_PREMIUM_FINAL_REGRESSION_Q252_STATIC_READY_BUT_REAL_OCR_RUNTIME_AND_FLUTTER_RETEST_REQUIRED',
  selectedEngineLabel: 'PP-FormulaNet-S',
  regressionMode: 'camera-ocr-premium-final-static-regression-closure',
  realOcrRuntimeAdded: false,
  paddleRuntimeAdded: false,
  modelBinaryBundledInBaseApp: false,
  productionInferenceAllowed: false,
  realEndToEndOcrPassClaimed: false,
  premiumFinalPassClaimedByAssistant: false,
  directCameraSolveBlocked: true,
  userApprovalRequiredBeforeWorkspaceImport: true,
  requiredFinalRegressionGates: q252.requiredFinalRegressionGates.length,
  protectedHashComparison: 'PASS',
}, null, 2));
