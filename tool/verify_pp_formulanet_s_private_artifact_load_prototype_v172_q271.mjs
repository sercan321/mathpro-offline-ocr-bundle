#!/usr/bin/env node
import fs from 'fs';
import crypto from 'crypto';
const phase = 'V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE';
const sourcePhase = 'V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON';
function read(p) { return fs.readFileSync(p, 'utf8'); }
function exists(p) { return fs.existsSync(p); }
function sha(p) { return crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex'); }
function fail(message) { console.error(`PP_FORMULANET_S_PRIVATE_ARTIFACT_LOAD_PROTOTYPE_Q271_BLOCKED: ${message}`); process.exit(1); }
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const policy = read('lib/features/camera/gauss_pp_formulanet_s_private_artifact_load_prototype_policy.dart');
const gate = read('lib/features/camera/gauss_pp_formulanet_s_private_artifact_load_prototype.dart');
const test = read('test/v172_q271_pp_formulanet_s_private_artifact_load_prototype_test.dart');
const audit = read('docs/audit/V172_Q271_PP_FORMULANET_S_PRIVATE_ARTIFACT_LOAD_PROTOTYPE_AUDIT.md');
const changed = read('docs/audit/V172_Q271_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const settings = read('android/settings.gradle');
if (![phase, 'V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE', 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE', 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to this phase or Q272 successor through Q286');
if (manifest.ppFormulaNetSPrivateArtifactLoadPrototypeLatestPhase !== phase) fail('manifest missing Q271 latest phase marker');
const q270 = manifest.v172Q270PpFormulaNetSNativeRuntimeBridgeSkeleton;
if (!q270 || q270.phase !== sourcePhase) fail('manifest missing Q270 source envelope');
const q271 = manifest.v172Q271PpFormulaNetSPrivateArtifactLoadPrototype;
if (!q271 || q271.phase !== phase) fail('manifest missing Q271 envelope');
if (q271.sourcePhase !== sourcePhase) fail('Q271 source phase mismatch');
if (q271.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q271 selected engine changed');
if (q271.artifactLoadMode !== 'private-artifact-load-prototype-gate-only-no-runtime-no-inference') fail('Q271 artifact load mode mismatch');
if (q271.privateArtifactLoadPrototypeImplemented !== true) fail('Q271 prototype flag missing');
if (q271.requiresQ270NativeRuntimeBridgeSkeleton !== true) fail('Q271 must require Q270 bridge skeleton');
if (q271.privateStorageOnly !== true || q271.artifactMayNotComeFromAssetsOrBaseApk !== true) fail('Q271 must enforce private storage and no base APK/assets artifact');
if (q271.expectedSha256Length !== 64) fail('Q271 expected SHA length must be 64');
for (const key of ['realOcrRuntimeAdded','paddleRuntimeAdded','paddleOcrDependencyAdded','nativeBridgeImplementationAdded','nativeBridgeAdded','jniBindingAdded','methodChannelRuntimeBindingAdded','modelBinaryBundledInBaseApp','productionModelUrlBound','realNetworkDownloadWorkerImplemented','productionDownloadEnabled','productionInferenceAllowed','runtimeDefaultEnabled','artifactLoadPrototypePassClaimed','ocrPassClaimed']) {
  if (q271[key] !== false) fail(`Q271 must keep ${key} false`);
}
if (q271.runtimeFeatureFlagDefaultOff !== true) fail('Q271 runtime feature flag must remain default-off');
if (q271.editableMathLiveReviewRequired !== true || q271.userApprovalRequiredBeforeWorkspaceImport !== true) fail('Q271 must require MathLive review and user approval');
if (q271.directCameraSolveBlocked !== true || q271.directCameraGraphSolutionHistoryBlocked !== true) fail('Q271 direct solve/graph/solution/history must remain blocked');
if (!Array.isArray(q271.artifactLoadDecisionStates) || q271.artifactLoadDecisionStates.length < 16) fail('Q271 decision states incomplete');
if (!Array.isArray(q271.requiredArtifactLoadGates) || q271.requiredArtifactLoadGates.length < 35) fail('Q271 required gates incomplete');
if (!Array.isArray(q271.blockedUntilRealEvidence) || q271.blockedUntilRealEvidence.length < 20) fail('Q271 blocked evidence incomplete');
if (!Array.isArray(q271.artifactAccessEnvelopeFields) || q271.artifactAccessEnvelopeFields.length < 9) fail('Q271 artifact access envelope incomplete');
if (!Array.isArray(q271.modelFormatProbeFields) || q271.modelFormatProbeFields.length < 8) fail('Q271 model-format probe incomplete');
if (!Array.isArray(q271.artifactLoadFailureCodes) || q271.artifactLoadFailureCodes.length < 12) fail('Q271 failure taxonomy incomplete');
for (const marker of ['q270NativeRuntimeBridgeSkeletonPresent','privateArtifactPathInsideAppStorage','artifactSha256Is64Hex','artifactShaPreviouslyAcceptedByCourt','artifactNotBundledInBaseApk','artifactNotLoadedFromAssets','modelFormatProbeDocumented','loadDryRunContractDocumented','noProductionInferenceInQ271']) if (!q271.requiredArtifactLoadGates.includes(marker)) fail(`Q271 missing required gate ${marker}`);
for (const marker of ['acceptedQ270NativeRuntimeBridgeSkeleton','realPrivateArtifactPathEvidence','realPrivateArtifactSha256Evidence','realModelFormatProbeLog','realArtifactLoadDryRunLog','realDeviceArtifactLoadSmokeLog','realMathLiveReviewEvidence','explicitUserApprovalForArtifactLoadPrototypePhase']) if (!q271.blockedUntilRealEvidence.includes(marker)) fail(`Q271 missing blocked evidence ${marker}`);
for (const marker of ['privateArtifactPath','artifactSha256','artifactSizeBytes','modelFormatProbeMode','reviewOnlyMode']) if (!q271.artifactAccessEnvelopeFields.includes(marker)) fail(`Q271 missing artifact access envelope field ${marker}`);
for (const marker of ['artifactExists','artifactReadable','sha256MatchesAcceptedEvidence','formatHeaderProbe','noInferenceExecuted']) if (!q271.modelFormatProbeFields.includes(marker)) fail(`Q271 missing model-format probe field ${marker}`);
for (const marker of ['privateArtifactPathMissing','artifactShaMalformed','artifactShaNotAcceptedByCourt','artifactBundledInBaseApkOrAssets','modelFormatProbeFailed','artifactLoadTimeout','memoryPressure']) if (!q271.artifactLoadFailureCodes.includes(marker)) fail(`Q271 missing failure code ${marker}`);
for (const marker of ['readyForFuturePrivateArtifactLoadSmokeOnly','blockedMalformedSha256','blockedArtifactBundledInBaseApkOrAssets','privateArtifactPathInsideAppStorage','canLoadPrivateArtifactInQ271: false','canProbeModelFormatInQ271: false','canRunInferenceInQ271: false','canClaimOcrPassInQ271: false']) {
  if (!policy.includes(marker) && !gate.includes(marker) && !test.includes(marker) && !audit.includes(marker)) fail(`Q271 marker missing: ${marker}`);
}
for (const forbidden of ['google_mlkit_text_recognition','paddleocr','paddle_flutter','paddle_lite','onnxruntime','tesseract','pix2text','flutter_downloader','background_downloader','dio']) {
  if (pubspec.includes(forbidden)) fail(`Q271 must not add dependency: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
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
  "lib/features/graph/graph_card.dart": "124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f",
  "lib/app/app_shell.dart": "ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637",
  "lib/main.dart": "068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689",
  "android/app/src/main/AndroidManifest.xml": "4fe91898ddf5ff94af1527314c8977806f23b051b7de078f25604dfa4731c1a6",
  "android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt": "c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1",
  "lib/app/gauss_splash_screen.dart": "465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81",
  "lib/features/workspace/workspace_panel.dart": "7e3c32f710b07b8fba3bd4223de650c71f334747644a41cfd0079ff7d49812b1",
  "pubspec.yaml": "97182bbfa14cace9cf1825ba75832e2da18e183279299a14fdfb578a0ad49304",
  "android/settings.gradle": "c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30",
  "android/gradle/wrapper/gradle-wrapper.properties": "797ea7d637b36ce5ccff6559a427ae97077073c7992883469e6ecb523fea2b97",
  "android/app/build.gradle": "5533186d6120cb1c8d5c976e2f13f2505d395721d03f6025138fdf96ac3c3ecb",
  "lib/features/camera/gauss_camera_capture_shell.dart": "92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51",
  "lib/features/camera/gauss_deferred_model_download_runtime.dart": "74a394ca4021bb2c2af99f45e9273e826a57c31b4f1804f91d5dfba73277b87d",
  "lib/features/camera/gauss_ocr_runtime_adapter.dart": "6f9c7f1208a09f3d067d27888eea8e74675a90f77035ec7bff724dd770675544",
  "lib/features/camera/gauss_ocr_mathlive_review_import.dart": "8e610c3753b8b20be9e1ed70f40b2dc48786abb1adda15cabe526ac0e1223fa3",
  "lib/features/camera/gauss_mathlive_ocr_review_surface.dart": "226e64b5e50535976ac17b450cf45eac55d500fc7a9305aef3d7004ab9da39c0",
  "lib/features/camera/gauss_camera_math_ocr_end_to_end_court.dart": "91a066e6d0f350c0bbd8ed6a110e4d8a56d2aef18e8dd334f1267621f248fe02",
  "lib/features/camera/gauss_camera_ocr_premium_final_regression.dart": "da55914a5a34f40474c1505693d19bf17e6dce31e2da26d68ccd7b47045b1916",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_source_evidence.dart": "39397e5334a940a692e7612df2e2cfec359793a99d3264501f1f776708697f60",
  "lib/features/camera/gauss_pp_formulanet_s_model_download_worker_guard.dart": "fe06a603defb5b23eba0cbbdbb6421f09b586d610d1cc415deba7bf934f438c3",
  "lib/features/camera/gauss_pp_formulanet_s_artifact_manifest_sha_lock.dart": "23e7d27bb4e127ecc40c9c1c465fbddb661bbc51f3f130fa5478f3eb55ad4d78",
  "lib/features/camera/gauss_pp_formulanet_s_download_orchestrator_ui_guard.dart": "6c7c34c1f1a42895b9c5225aa1c16f29c0a7ffb02498d914bcc7dd93ddfc3903",
  "lib/features/camera/gauss_pp_formulanet_s_production_artifact_resolver_gate.dart": "157e471bbcf80c559bdfe86ed88ff9ab61ce1a80f8bfe7c415888c48dbdbead0",
  "lib/features/camera/gauss_pp_formulanet_s_real_download_worker_dry_run.dart": "3a7f505e6f753d850c5617ba83f2fed438084586d5657bfbfd76f637c9758a6f",
  "lib/features/camera/gauss_pp_formulanet_s_real_model_download_integration_gate.dart": "7bae00de8d2e6f7162d3fe7e2e78a4d7fffebe9286dbcbde30d52438c909a9d7",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_feasibility_adapter.dart": "19c69b2eb919a3deb70478d13768bd82405014ff5e5e9583f87684ed86568e03",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_prototype_bridge_gate.dart": "56c6202623931388dc1ae29ba98b6627435711e7ccd306bec12e053926cef85c",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_prototype_smoke_evidence_template.dart": "77cff0af1864a2ec78800cc9c8018a4a5c949d95bae5fce4091207e0b33dc586",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_prototype_evidence_intake_gate.dart": "be6189713497ab737138c1ea94f2e5ac15eb8730ce1037cfb31e190cafe0d056",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_evidence_acceptance_court.dart": "409088ff4399cfdb22287026c746d4047956ae32e307decc21d7edcb122a1876",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_activation_decision_gate.dart": "4f47c8e430a4b07d5a3900cca18251412b817edbd25971e7e54276b9508e5775",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_integration_preflight_package.dart": "caf9432fa52d9ce6da7811b73349acf2b7365339024f00e83c577ecc3f168c37",
  "lib/features/camera/gauss_pp_formulanet_s_isolated_runtime_implementation_gate.dart": "22ca8691c3ab9bed0a1fbf701278e5f378acf832a41a3089ef5c078c99757f89",
  "lib/features/camera/gauss_pp_formulanet_s_runtime_dependency_isolation.dart": "8f63318b8a47949414202ce4658f440c0cf2874092853ec281c1dd6310d56c63",
  "lib/features/camera/gauss_pp_formulanet_s_native_runtime_bridge_skeleton.dart": "005e59893aa2b86629894c862edb77e03d8df2c354c4e3ea62a869606651f960"
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  const actual = sha(file);
  if (actual !== expected) fail(`protected file changed: ${file} expected ${expected} got ${actual}`);
}
for (const file of [
  'lib/features/camera/gauss_pp_formulanet_s_private_artifact_load_prototype_policy.dart',
  'lib/features/camera/gauss_pp_formulanet_s_private_artifact_load_prototype.dart',
  'test/v172_q271_pp_formulanet_s_private_artifact_load_prototype_test.dart',
  'tool/verify_pp_formulanet_s_private_artifact_load_prototype_v172_q271.mjs',
  'docs/audit/V172_Q271_PP_FORMULANET_S_PRIVATE_ARTIFACT_LOAD_PROTOTYPE_AUDIT.md',
  'docs/audit/V172_Q271_CHANGED_FILES.md',
]) if (!exists(file)) fail(`Q271 file missing: ${file}`);
if (!changed.includes('gauss_pp_formulanet_s_private_artifact_load_prototype.dart')) fail('changed-files audit missing Q271 Dart file');
if (!readme.includes(phase)) fail('README missing Q271 note');
console.log(JSON.stringify({
  phase,
  status: 'PP_FORMULANET_S_PRIVATE_ARTIFACT_LOAD_PROTOTYPE_Q271_STATIC_READY_BUT_REAL_ARTIFACT_LOAD_RUNTIME_INFERENCE_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q271.selectedEngineLabel,
  artifactLoadMode: q271.artifactLoadMode,
  privateArtifactLoadPrototypeImplemented: q271.privateArtifactLoadPrototypeImplemented,
  requiresQ270NativeRuntimeBridgeSkeleton: q271.requiresQ270NativeRuntimeBridgeSkeleton,
  privateStorageOnly: q271.privateStorageOnly,
  artifactMayNotComeFromAssetsOrBaseApk: q271.artifactMayNotComeFromAssetsOrBaseApk,
  artifactLoadDecisionStates: q271.artifactLoadDecisionStates.length,
  requiredArtifactLoadGates: q271.requiredArtifactLoadGates.length,
  blockedUntilRealEvidence: q271.blockedUntilRealEvidence.length,
  artifactAccessEnvelopeFields: q271.artifactAccessEnvelopeFields.length,
  modelFormatProbeFields: q271.modelFormatProbeFields.length,
  artifactLoadFailureCodes: q271.artifactLoadFailureCodes.length,
  artifactLoadPrototypePassClaimed: q271.artifactLoadPrototypePassClaimed,
  runtimeDefaultEnabled: q271.runtimeDefaultEnabled,
  runtimeFeatureFlagDefaultOff: q271.runtimeFeatureFlagDefaultOff,
  ocrPassClaimed: q271.ocrPassClaimed,
  realOcrRuntimeAdded: q271.realOcrRuntimeAdded,
  paddleRuntimeAdded: q271.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q271.paddleOcrDependencyAdded,
  nativeBridgeImplementationAdded: q271.nativeBridgeImplementationAdded,
  jniBindingAdded: q271.jniBindingAdded,
  methodChannelRuntimeBindingAdded: q271.methodChannelRuntimeBindingAdded,
  modelBinaryBundledInBaseApp: q271.modelBinaryBundledInBaseApp,
  productionInferenceAllowed: q271.productionInferenceAllowed,
  protectedHashComparison: 'PASS',
}, null, 2));
