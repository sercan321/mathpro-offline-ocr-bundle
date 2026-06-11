#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';

const root = process.cwd();
const phase = 'V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE';
const fail = (message) => {
  console.error(`PP_FORMULANET_S_RUNTIME_SOURCE_EVIDENCE_Q254_BLOCKED: ${message}`);
  process.exit(1);
};
const read = (p) => fs.readFileSync(`${root}/${p}`, 'utf8');
const exists = (p) => fs.existsSync(`${root}/${p}`);
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(`${root}/${p}`)).digest('hex');

const policyPath = 'lib/features/camera/gauss_pp_formulanet_s_runtime_source_evidence_policy.dart';
const gatePath = 'lib/features/camera/gauss_pp_formulanet_s_runtime_source_evidence.dart';
const testPath = 'test/v172_q254_pp_formulanet_s_runtime_source_evidence_test.dart';
const auditPath = 'docs/audit/V172_Q254_PP_FORMULANET_S_RUNTIME_SOURCE_EVIDENCE_AUDIT.md';
const changedPath = 'docs/audit/V172_Q254_CHANGED_FILES.md';

for (const file of [policyPath, gatePath, testPath, auditPath, changedPath, 'assets/mathlive/manifest.json', 'README.md']) {
  if (!exists(file)) fail(`missing Q254 file: ${file}`);
}

const policy = read(policyPath);
const gate = read(gatePath);
const test = read(testPath);
const audit = read(auditPath);
const changed = read(changedPath);
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const wrapper = read('android/gradle/wrapper/gradle-wrapper.properties');
const appGradle = read('android/app/build.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const prodBridge = read('assets/mathlive/mathlive_prod_bridge.js');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

for (const marker of [
  phase,
  'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION',
  'PP-FormulaNet-S',
  'PP-FormulaNet_plus-L',
  'officialPaddleOcrDocumentationRequired = true',
  'officialPaddleXDocumentationRequired = true',
  'officialModelRepositoryRequired = true',
  'apache2LicenseEvidenceRequired = true',
  'modelStorageSizeEvidenceRequired = true',
  'expectedSha256RequiredBeforeDownload = true',
  'actualSha256RequiredAfterDownload = true',
  'androidRuntimeFeasibilityEvidenceRequired = true',
  'latencyAndMemoryEvidenceRequired = true',
  'editableMathLiveReviewRequired = true',
  'userApprovalRequiredBeforeWorkspaceImport = true',
  'realOcrRuntimeAdded = false',
  'paddleRuntimeAdded = false',
  'paddleOcrDependencyAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'productionDownloadWorkerImplemented = false',
  'productionInferenceAllowed = false',
  'directSolveFromCameraAllowed = false',
  'officialSourceEvidenceRequirements',
  'forbiddenActions',
  'runPpFormulaNetSInference',
  'claimOcrPassWithoutRealInferenceEvidence',
]) if (!policy.includes(marker)) fail(`Q254 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussPpFormulaNetSRuntimeSourceEvidenceDecision',
  'blockedMissingOfficialSourceEvidence',
  'blockedMissingLicenseOrArtifactEvidence',
  'blockedMissingChecksumEvidence',
  'blockedMissingAndroidRuntimeEvidence',
  'blockedUnsafeRuntimeBindingAttempt',
  'blockedMissingMathLiveReviewSafety',
  'runtimeSourceEvidenceStaticReady',
  'class GaussPpFormulaNetSRuntimeSourceEvidenceInput',
  'class GaussPpFormulaNetSRuntimeSourceEvidenceResult',
  'runtimeSourceEvidenceStaticReady',
  'canClaimOcrPass => false',
  'canClaimFlutterPassWithoutLogs => false',
  'canRunPpFormulaNetSInference => false',
  'canSetProductionModelUrlWithoutSha256 => false',
  'canImportCameraOutputWithoutUserApproval => false',
  'canSolveCameraOutputBeforeReviewApproval => false',
  'class GaussPpFormulaNetSRuntimeSourceEvidenceGate',
  'requiresOfficialPaddleOcrDocumentation = true',
  'requiresOfficialPaddleXDocumentation = true',
  'requiresOfficialModelRepository = true',
  'requiresApache2LicenseEvidence = true',
  'requiresExpectedSha256BeforeDownload = true',
  'requiresActualSha256AfterDownload = true',
  'requiresAndroidRuntimeFeasibilityEvidence = true',
  'allowsProductionInferenceInQ254 = false',
  'callsProductionMathLiveBridge = false',
  'Expected SHA256 and post-download actual SHA256 verification are mandatory',
]) if (!gate.includes(marker)) fail(`Q254 gate missing marker: ${marker}`);

for (const marker of [
  phase,
  'records PP-FormulaNet-S source evidence gate without real runtime binding',
  'passes only when official source, checksum, runtime feasibility, and review gates are intact',
  'blocks missing source, checksum, Android runtime, unsafe binding, and review regressions',
  'keeps app dependencies and production runtime surfaces clean',
  'camera: 0.10.6',
  'camera_android: 0.10.9+3',
  'runPpFormulaNetSInference',
  'FormulaRecognition(',
  'paddleocr',
  'onnxruntime',
]) if (!test.includes(marker)) fail(`Q254 test missing marker: ${marker}`);

if (![phase, 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD', 'V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK', 'V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD', 'V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE', 'V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN', 'V172-Q260-PP-FORMULANET-S-REAL-MODEL-DOWNLOAD-INTEGRATION-GATE', 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER', 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE', 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER', 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE', 'V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE', 'V172-Q264-PP-FORMULANET-S-RUNTIME-PROTOTYPE-EVIDENCE-INTAKE-GATE', 'V172-Q265-PP-FORMULANET-S-RUNTIME-EVIDENCE-ACCEPTANCE-COURT', 'V172-Q266-PP-FORMULANET-S-RUNTIME-ACTIVATION-DECISION-GATE', 'V172-Q267-PP-FORMULANET-S-RUNTIME-INTEGRATION-PREFLIGHT-PACKAGE', 'V172-Q268-PP-FORMULANET-S-ISOLATED-RUNTIME-IMPLEMENTATION-GATE', 'V172-Q269-PP-FORMULANET-S-RUNTIME-DEPENDENCY-ISOLATION', 'V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON', 'V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE', 'V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE', 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE', 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to this phase or successor through Q277');
if (manifest.ppFormulaNetSRuntimeSourceEvidenceLatestPhase !== phase) fail('manifest missing Q254 latest phase');
if (manifest.ppFormulaNetSModelDownloadWorkerGuardLatestPhase && manifest.ppFormulaNetSModelDownloadWorkerGuardLatestPhase !== 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD') fail('manifest Q255 latest phase mismatch');
const q254 = manifest.v172Q254PpFormulaNetSRuntimeSourceEvidence;
if (!q254) fail('manifest missing v172Q254PpFormulaNetSRuntimeSourceEvidence');
if (q254.sourcePhase !== 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION') fail('manifest Q254 source phase mismatch');
if (q254.selectedEngineLabel !== 'PP-FormulaNet-S') fail('manifest Q254 selected engine mismatch');
if (q254.officialPaddleOcrDocumentationRequired !== true) fail('manifest must require PaddleOCR docs');
if (q254.officialPaddleXDocumentationRequired !== true) fail('manifest must require PaddleX docs');
if (q254.officialModelRepositoryRequired !== true) fail('manifest must require official model repo');
if (q254.apache2LicenseEvidenceRequired !== true) fail('manifest must require license evidence');
if (q254.expectedSha256RequiredBeforeDownload !== true) fail('manifest must require expected SHA256');
if (q254.actualSha256RequiredAfterDownload !== true) fail('manifest must require actual SHA256');
if (q254.androidRuntimeFeasibilityEvidenceRequired !== true) fail('manifest must require Android runtime feasibility');
if (q254.editableMathLiveReviewRequired !== true) fail('manifest must require editable MathLive review');
if (q254.userApprovalRequiredBeforeWorkspaceImport !== true) fail('manifest must require user approval');
if (q254.realOcrRuntimeAdded !== false) fail('manifest must not add real OCR runtime');
if (q254.paddleRuntimeAdded !== false) fail('manifest must not add Paddle runtime');
if (q254.modelBinaryBundledInBaseApp !== false) fail('manifest must not bundle model binary');
if (q254.productionModelUrlBound !== false) fail('manifest must not bind production model URL');
if (q254.productionInferenceAllowed !== false) fail('manifest must not allow production inference');
if (!Array.isArray(q254.officialSourceEvidenceRequirements) || q254.officialSourceEvidenceRequirements.length < 12) fail('manifest must list official source evidence requirements');
if (!Array.isArray(q254.forbiddenActions) || q254.forbiddenActions.length < 10) fail('manifest must list forbidden actions');

if (!settings.includes("id 'com.android.application' version '8.6.1' apply false")) fail('AGP must remain 8.6.1 after Q253');
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('Kotlin plugin must remain 2.1.0');
if (!wrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7');
if (!appGradle.includes('sourceCompatibility JavaVersion.VERSION_17')) fail('Java sourceCompatibility 17 must remain');
if (!appGradle.includes('targetCompatibility JavaVersion.VERSION_17')) fail('Java targetCompatibility 17 must remain');
if (!appGradle.includes("jvmTarget = '17'")) fail('Kotlin jvmTarget 17 must remain');

if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('camera dependency must remain 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('camera_android dependency must remain 0.10.9+3');
for (const forbidden of ['camera_android_camerax','google_mlkit_text_recognition','paddleocr','paddle_flutter','onnxruntime','tesseract','pix2text','flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`Q254 must not add dependency: ${forbidden}`);
}
if (!androidManifest.includes('android.permission.CAMERA')) fail('CAMERA permission must remain');
if (androidManifest.includes('READ_MEDIA_IMAGES')) fail('Q254 must not add media permissions');
for (const forbidden of ['FormulaRecognition(', 'runPpFormulaNetSInference', 'setWorkspaceLatexWithoutUserApproval']) {
  if (prodBridge.includes(forbidden)) fail(`production MathLive bridge must not contain ${forbidden}`);
}

const forbiddenModel = /\.(onnx|tflite|pt|pth|pdmodel|pdiparams|pdparams|safetensors|bin)$/i;
const scan = (dir) => {
  for (const name of fs.readdirSync(dir)) {
    const full = `${dir}/${name}`;
    const stat = fs.statSync(full);
    if (stat.isDirectory()) scan(full);
    else if (forbiddenModel.test(full)) fail(`model/runtime binary must not be bundled: ${full.replace(root + '/', '')}`);
  }
};
scan(root);

for (const marker of [phase, 'Q254', 'PP-FormulaNet-S', 'official source', 'Apache-2.0', 'model storage', 'SHA256', 'Android runtime feasibility', 'no Paddle runtime', 'no model binary', 'no production inference', 'editable MathLive review', 'user approval', 'Q253']) {
  if (!readme.includes(marker)) fail(`README missing Q254 marker: ${marker}`);
  if (!audit.includes(marker)) fail(`audit missing Q254 marker: ${marker}`);
}
for (const file of [
  policyPath,
  gatePath,
  testPath,
  'tool/verify_pp_formulanet_s_runtime_source_evidence_v172_q254.mjs',
  auditPath,
  changedPath,
  'assets/mathlive/manifest.json',
  'README.md',
  'tool/verify_ocr_mathlive_review_import_v172_q250.mjs',
  'tool/verify_camera_math_ocr_end_to_end_court_v172_q251.mjs',
  'tool/verify_camera_ocr_premium_final_regression_v172_q252.mjs',
  'test/v172_q244r8_camera_kotlin_metadata_compatibility_test.dart',
  'test/v172_q245_camera_real_device_evidence_closure_test.dart',
  'test/v172_q246_ocr_engine_real_benchmark_package_test.dart',
  'test/v172_q247_winner_engine_selection_test.dart',
  'test/v172_q248_deferred_model_download_runtime_test.dart',
  'test/v172_q249_ocr_runtime_adapter_test.dart',
  'test/v172_q250_ocr_mathlive_review_import_test.dart',
  'test/v172_q251_camera_math_ocr_end_to_end_court_test.dart',
  'test/v172_q252_camera_ocr_premium_final_regression_test.dart',
]) if (!changed.includes(file) && !fs.existsSync(`${root}/docs/audit/V172_Q255_CHANGED_FILES.md`)) fail(`changed-files audit missing ${file}`);

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
  'android/settings.gradle': 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30',
  'android/gradle/wrapper/gradle-wrapper.properties': '797ea7d637b36ce5ccff6559a427ae97077073c7992883469e6ecb523fea2b97',
  'android/app/build.gradle': '5533186d6120cb1c8d5c976e2f13f2505d395721d03f6025138fdf96ac3c3ecb',
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
  'lib/features/camera/gauss_camera_ocr_premium_final_regression.dart': 'da55914a5a34f40474c1505693d19bf17e6dce31e2da26d68ccd7b47045b1916',
  'lib/features/camera/gauss_camera_ocr_premium_final_regression_policy.dart': '91c5e9925bb1b56b1ca290c10287d55ea49b237342729947fd1a04f6e345e7a9',
  'lib/features/camera/gauss_android_toolchain_modernization.dart': '6fe6efd30478063c7c430ef174fe396a5f2aad578501a1a927aeaf97f4af0065',
  'lib/features/camera/gauss_android_toolchain_modernization_policy.dart': 'a40b6a0bed391ab98d526c2b7275aaf634923b115be11ea1ec32a582353b9b6d'
};
for (const [p, expected] of Object.entries(protectedHashes)) {
  if (!exists(p)) fail(`protected file missing: ${p}`);
  const actual = sha(p);
  if (actual !== expected) fail(`protected hash changed for ${p}: ${actual} !== ${expected}`);
}

console.log(JSON.stringify({
  phase,
  status: 'PP_FORMULANET_S_RUNTIME_SOURCE_EVIDENCE_Q254_STATIC_READY_BUT_REAL_MODEL_RUNTIME_DOWNLOAD_AND_FLUTTER_RETEST_REQUIRED',
  selectedEngineLabel: 'PP-FormulaNet-S',
  sourcePhase: 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION',
  officialSourceEvidenceGate: true,
  realOcrRuntimeAdded: false,
  paddleRuntimeAdded: false,
  modelBinaryBundledInBaseApp: false,
  productionModelUrlBound: false,
  productionInferenceAllowed: false,
  editableMathLiveReviewRequired: true,
  userApprovalRequiredBeforeWorkspaceImport: true,
  protectedHashComparison: 'PASS',
}, null, 2));
