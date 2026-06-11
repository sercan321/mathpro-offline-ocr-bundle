#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';

const phase = 'V172-Q266-PP-FORMULANET-S-RUNTIME-ACTIVATION-DECISION-GATE';
const sourcePhase = 'V172-Q265-PP-FORMULANET-S-RUNTIME-EVIDENCE-ACCEPTANCE-COURT';
const fail = (message) => { console.error(`PP_FORMULANET_S_RUNTIME_ACTIVATION_DECISION_GATE_Q266_BLOCKED: ${message}`); process.exit(1); };
const read = (path) => fs.readFileSync(path, 'utf8');
const exists = (path) => fs.existsSync(path);
const sha = (path) => crypto.createHash('sha256').update(fs.readFileSync(path)).digest('hex');

for (const path of [
  'lib/features/camera/gauss_pp_formulanet_s_runtime_activation_decision_gate_policy.dart',
  'lib/features/camera/gauss_pp_formulanet_s_runtime_activation_decision_gate.dart',
  'test/v172_q266_pp_formulanet_s_runtime_activation_decision_gate_test.dart',
  'tool/verify_pp_formulanet_s_runtime_activation_decision_gate_v172_q266.mjs',
  'docs/audit/V172_Q266_PP_FORMULANET_S_RUNTIME_ACTIVATION_DECISION_GATE_AUDIT.md',
  'docs/audit/V172_Q266_CHANGED_FILES.md',
]) if (!exists(path)) fail(`required Q266 file missing: ${path}`);

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const pubspec = read('pubspec.yaml').toLowerCase();
const policy = read('lib/features/camera/gauss_pp_formulanet_s_runtime_activation_decision_gate_policy.dart');
const gate = read('lib/features/camera/gauss_pp_formulanet_s_runtime_activation_decision_gate.dart');
const test = read('test/v172_q266_pp_formulanet_s_runtime_activation_decision_gate_test.dart');
const audit = read('docs/audit/V172_Q266_PP_FORMULANET_S_RUNTIME_ACTIVATION_DECISION_GATE_AUDIT.md');
const changed = read('docs/audit/V172_Q266_CHANGED_FILES.md');
const readme = read('README.md');

if (![phase, 'V172-Q267-PP-FORMULANET-S-RUNTIME-INTEGRATION-PREFLIGHT-PACKAGE', 'V172-Q268-PP-FORMULANET-S-ISOLATED-RUNTIME-IMPLEMENTATION-GATE', 'V172-Q269-PP-FORMULANET-S-RUNTIME-DEPENDENCY-ISOLATION', 'V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON', 'V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE', 'V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE', 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE', 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to this phase or successor through Q277');
if (manifest.ppFormulaNetSRuntimeActivationDecisionGateLatestPhase !== phase) fail('manifest missing Q266 latest phase');
const q266 = manifest.v172Q266PpFormulaNetSRuntimeActivationDecisionGate;
if (!q266 || q266.phase !== phase) fail('manifest missing Q266 envelope');
if (q266.sourcePhase !== sourcePhase) fail('Q266 sourcePhase mismatch');
if (q266.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q266 selected engine must be PP-FormulaNet-S');
if (q266.fallbackEngineLabel !== 'PP-FormulaNet_plus-L') fail('Q266 fallback must remain PP-FormulaNet_plus-L');
if (q266.activationMode !== 'runtime-activation-decision-gate-only-no-runtime-no-inference') fail('Q266 mode mismatch');
for (const [key, expected] of Object.entries({
  runtimeActivationDecisionGateImplemented: true,
  requiresQ265AcceptedEvidence: true,
  runtimeActivationPassClaimed: false,
  ocrPassClaimed: false,
  realOcrRuntimeAdded: false,
  paddleRuntimeAdded: false,
  paddleOcrDependencyAdded: false,
  nativeBridgeAdded: false,
  jniBindingAdded: false,
  methodChannelRuntimeBindingAdded: false,
  modelBinaryBundledInBaseApp: false,
  productionModelUrlBound: false,
  realNetworkDownloadWorkerImplemented: false,
  productionDownloadEnabled: false,
  productionInferenceAllowed: false,
  editableMathLiveReviewRequired: true,
  userApprovalRequiredBeforeWorkspaceImport: true,
  directCameraSolveBlocked: true,
  directCameraGraphSolutionHistoryBlocked: true,
})) { if (q266[key] !== expected) fail(`manifest Q266 ${key} expected ${expected} got ${q266[key]}`); }
if (!Array.isArray(q266.activationDecisionStates) || q266.activationDecisionStates.length < 12) fail('Q266 activationDecisionStates incomplete');
if (!Array.isArray(q266.requiredActivationGates) || q266.requiredActivationGates.length < 22) fail('Q266 requiredActivationGates incomplete');
if (!Array.isArray(q266.blockedUntilRealEvidence) || q266.blockedUntilRealEvidence.length < 14) fail('Q266 blockedUntilRealEvidence incomplete');
for (const marker of ['acceptedQ265RuntimeEvidenceCourtResult','realAndroidRuntimeCandidateDecisionLog','realSupportedAbiMatrixLog','realModelFormatCompatibilityLog','realPrivateArtifactVerificationLog','realLatencyBudgetEvidence','realPeakMemoryBudgetEvidence','realFallbackPlanEvidence','realMathLiveReviewEvidence','realDirectSolveBlockedEvidence','realFlutterAnalyzeLog','realFlutterTestLog','realFlutterRunLog','explicitUserApprovalForRuntimeActivationPhase']) if (!q266.blockedUntilRealEvidence.includes(marker)) fail(`Q266 missing blocked evidence ${marker}`);
for (const marker of ['q265AcceptedEvidencePresent','runtimeCandidateSelected','androidAbiSupported','modelFormatAccepted','privateArtifactVerified','latencyWithinBudget','peakMemoryWithinBudget','fallbackPlanDefined','editableMathLiveReviewRequired','directSolveBlocked']) if (!q266.requiredActivationGates.includes(marker)) fail(`Q266 missing gate ${marker}`);
for (const marker of ['approvedForFutureRuntimeIntegrationGateOnly','rejectedMissingQ265AcceptedEvidence','rejectedUnsafeRuntimeCandidate','canActivateRuntimeInQ266: false','canClaimRuntimeActivationPassInQ266: false','canClaimOcrPassInQ266: false','canAddPaddleRuntimeInQ266: false','canBindRuntimeBridgeInQ266: false','canImportCameraOutputWithoutUserApproval: false']) {
  if (!policy.includes(marker) && !gate.includes(marker) && !test.includes(marker) && !audit.includes(marker)) fail(`Q266 marker missing: ${marker}`);
}
for (const forbidden of ['google_mlkit_text_recognition','paddleocr','paddle_flutter','paddle_lite','onnxruntime','tesseract','pix2text','flutter_downloader','background_downloader','dio']) {
  if (pubspec.includes(forbidden)) fail(`Q266 must not add dependency: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (!read('android/settings.gradle').includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!read('android/settings.gradle').includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');

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
  "lib/features/camera/gauss_pp_formulanet_s_runtime_evidence_acceptance_court.dart": "409088ff4399cfdb22287026c746d4047956ae32e307decc21d7edcb122a1876"
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  const actual = sha(file);
  if (actual !== expected) fail(`protected file changed: ${file} expected ${expected} got ${actual}`);
}

for (const file of [
  'assets/mathlive/manifest.json',
  'README.md',
  'tool/verify_pp_formulanet_s_runtime_evidence_acceptance_court_v172_q265.mjs',
  'docs/audit/V172_Q266_PP_FORMULANET_S_RUNTIME_ACTIVATION_DECISION_GATE_AUDIT.md',
  'docs/audit/V172_Q266_CHANGED_FILES.md',
]) if (!exists(file)) fail(`Q266 changed-file missing: ${file}`);
if (!changed.includes('gauss_pp_formulanet_s_runtime_activation_decision_gate.dart')) fail('changed-files audit missing Q266 Dart file');
if (!readme.includes(phase)) fail('README missing Q266 note');

console.log(JSON.stringify({
  phase,
  status: 'PP_FORMULANET_S_RUNTIME_ACTIVATION_DECISION_GATE_Q266_STATIC_READY_BUT_REAL_RUNTIME_ACTIVATION_INFERENCE_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q266.selectedEngineLabel,
  activationMode: q266.activationMode,
  runtimeActivationDecisionGateImplemented: q266.runtimeActivationDecisionGateImplemented,
  requiresQ265AcceptedEvidence: q266.requiresQ265AcceptedEvidence,
  activationDecisionStates: q266.activationDecisionStates.length,
  requiredActivationGates: q266.requiredActivationGates.length,
  blockedUntilRealEvidence: q266.blockedUntilRealEvidence.length,
  runtimeActivationPassClaimed: q266.runtimeActivationPassClaimed,
  ocrPassClaimed: q266.ocrPassClaimed,
  realOcrRuntimeAdded: q266.realOcrRuntimeAdded,
  paddleRuntimeAdded: q266.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q266.paddleOcrDependencyAdded,
  nativeBridgeAdded: q266.nativeBridgeAdded,
  jniBindingAdded: q266.jniBindingAdded,
  methodChannelRuntimeBindingAdded: q266.methodChannelRuntimeBindingAdded,
  modelBinaryBundledInBaseApp: q266.modelBinaryBundledInBaseApp,
  productionInferenceAllowed: q266.productionInferenceAllowed,
  protectedHashComparison: 'PASS',
}, null, 2));
