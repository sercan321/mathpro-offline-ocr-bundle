#!/usr/bin/env node
import fs from 'fs';
import crypto from 'crypto';
const phase = 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE';
const sourcePhase = 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING';
function fail(message) { console.error(`APPROVED_OCR_WORKSPACE_IMPORT_GATE_Q275_BLOCKED: ${message}`); process.exit(1); }
function read(path) { if (!fs.existsSync(path)) fail(`missing file: ${path}`); return fs.readFileSync(path, 'utf8'); }
function sha(path) { return crypto.createHash('sha256').update(fs.readFileSync(path)).digest('hex'); }
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const policy = read('lib/features/camera/gauss_approved_ocr_workspace_import_gate_policy.dart');
const gate = read('lib/features/camera/gauss_approved_ocr_workspace_import_gate.dart');
const test = read('test/v172_q275_approved_ocr_workspace_import_gate_test.dart');
const audit = read('docs/audit/V172_Q275_APPROVED_OCR_WORKSPACE_IMPORT_GATE_AUDIT.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const settings = read('android/settings.gradle');
if (![phase, 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', 'V172-Q277R1-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-FLUTTER-LOG-REPAIR', 'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE', 'V172-Q277R3-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-TAP-LATENCY-CADENCE', 'V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK', 'V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q280-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-BEHIND-FLAG', 'V172-Q281-PRIVATE-ARTIFACT-LOAD-REAL-SMOKE', 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE', 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT', 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING', 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT', 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q275 or Q276/Q277/Q277R1/Q277R2/Q277R3/Q278/Q279 successor through Q286');
if (manifest.approvedOcrWorkspaceImportGateLatestPhase !== phase) fail('manifest missing Q275 latest phase marker');
const q274 = manifest.v172Q274OcrResultMathLiveRealReviewBinding;
if (!q274 || q274.phase !== sourcePhase) fail('manifest missing Q274 source review binding envelope');
const q275 = manifest.v172Q275ApprovedOcrWorkspaceImportGate;
if (!q275 || q275.phase !== phase) fail('manifest missing Q275 envelope');
if (q275.sourcePhase !== sourcePhase) fail('Q275 source phase mismatch');
if (q275.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q275 selected engine changed');
if (q275.workspaceImportMode !== 'approved-ocr-workspace-import-gate-only-no-auto-solve-no-real-inference') fail('Q275 workspace import mode mismatch');
for (const key of ['realOcrRuntimeAdded','paddleRuntimeAdded','paddleOcrDependencyAdded','nativeBridgeImplementationAdded','jniBindingAdded','methodChannelRuntimeBindingAdded','modelBinaryBundledInBaseApp','productionModelUrlBound','realNetworkDownloadWorkerImplemented','productionDownloadEnabled','productionInferenceAllowed','runtimeDefaultEnabled','realImageToLatexInferenceExecuted','workspaceImportRuntimePassClaimed','ocrPassClaimed']) {
  if (q275[key] !== false) fail(`Q275 must keep ${key} false`);
}
for (const key of ['approvedOcrWorkspaceImportGateImplemented','requiresQ274OcrResultMathLiveReviewBinding','editableMathLiveReviewDraftRequired','userMayEditReviewDraftBeforeApproval','explicitUserApprovalRequired','approvedLatexMustBeNonEmpty','workspaceImportPreparedOnlyAfterUserApproval','workspaceImportMayUseApprovedLatexDraft','importDoesNotAutoEvaluate','importDoesNotAutoSolve','importDoesNotAutoGraph','importDoesNotAutoWriteSolution','importDoesNotAutoWriteHistory','directWorkspaceImportWithoutApprovalBlocked','directCameraSolveBlocked','directCameraGraphSolutionHistoryBlocked','runtimeFeatureFlagDefaultOff']) {
  if (q275[key] !== true) fail(`Q275 must keep ${key} true`);
}
if (!Array.isArray(q275.requiredWorkspaceImportGates) || q275.requiredWorkspaceImportGates.length < 28) fail('Q275 required gates incomplete');
if (!Array.isArray(q275.workspaceImportEnvelopeFields) || q275.workspaceImportEnvelopeFields.length < 15) fail('Q275 workspace import envelope incomplete');
if (!Array.isArray(q275.blockedUntilRealEvidence) || q275.blockedUntilRealEvidence.length < 18) fail('Q275 blocked evidence incomplete');
if (!Array.isArray(q275.workspaceImportFailureCodes) || q275.workspaceImportFailureCodes.length < 15) fail('Q275 failure taxonomy incomplete');
for (const marker of ['explicitUserApprovalRequired','workspaceImportPreparedOnlyAfterUserApproval','importDoesNotAutoSolve','importDoesNotAutoGraph','importDoesNotAutoWriteSolution','importDoesNotAutoWriteHistory']) if (!q275.requiredWorkspaceImportGates.includes(marker)) fail(`Q275 missing gate ${marker}`);
for (const marker of ['approvedLatexDraft','explicitUserApproved','workspaceImportPrepared','autoSolveAfterImport','autoHistoryAfterImport']) if (!q275.workspaceImportEnvelopeFields.includes(marker)) fail(`Q275 missing workspace import envelope field ${marker}`);
for (const marker of ['realExplicitUserApprovalEvidence','realWorkspaceImportPreparedAfterApprovalEvidence','realNoAutoSolveEvidence','realDirectImportWithoutApprovalBlockedEvidence']) if (!q275.blockedUntilRealEvidence.includes(marker)) fail(`Q275 missing blocked evidence ${marker}`);
for (const marker of ['workspaceImportPreparedBeforeApproval','autoSolveRiskDetected','directImportWithoutApprovalRiskDetected','runtimeInferenceAttemptedInQ275']) if (!q275.workspaceImportFailureCodes.includes(marker)) fail(`Q275 missing failure code ${marker}`);
for (const marker of ['readyForFutureApprovedWorkspaceImportOnly','blockedAutoSolveRisk','canImportWithoutUserApproval','canAutoSolveAfterImport','canClaimOcrPassInQ275']) {
  if (!policy.includes(marker) && !gate.includes(marker) && !test.includes(marker) && !audit.includes(marker)) fail(`Q275 marker missing: ${marker}`);
}
for (const forbidden of ['google_mlkit_text_recognition','paddleocr','paddle_flutter','paddle_lite','onnxruntime','tesseract','pix2text','flutter_downloader','background_downloader','dio']) {
  if (pubspec.includes(forbidden)) fail(`Q275 must not add dependency: ${forbidden}`);
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
  "lib/features/mathlive/mathlive_production_editor_surface.dart": "d9110c8d0018758216b1e9967bbd422cd97559d923cfc090e6677514da0d1c99",
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
  "lib/features/camera/gauss_ocr_result_mathlive_real_review_binding.dart": "44773a788155ce3702168932056b0dd2ee68b9c15a08f18b598fbdb8d0a38cf1",
  "lib/features/camera/gauss_ocr_result_mathlive_real_review_binding_policy.dart": "c4fd1e0d6b18842317f3e6c14d91759c421d759a5f1d34ae6e7aa739a09b2d43"
};
for (const [path, expected] of Object.entries(protectedHashes)) {
  if (!fs.existsSync(path)) fail(`protected file missing: ${path}`);
  if (sha(path) !== expected) fail(`protected hash changed: ${path}`);
}
for (const marker of [phase, 'Approved OCR', 'Workspace Import Gate', 'no auto-solve', 'explicit user approval']) {
  if (!readme.includes(marker) && !audit.includes(marker)) fail(`documentation marker missing: ${marker}`);
}
console.log(JSON.stringify({
  phase,
  status: 'APPROVED_OCR_WORKSPACE_IMPORT_GATE_Q275_STATIC_READY_BUT_REAL_WORKSPACE_IMPORT_RUNTIME_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q275.selectedEngineLabel,
  workspaceImportMode: q275.workspaceImportMode,
  approvedOcrWorkspaceImportGateImplemented: q275.approvedOcrWorkspaceImportGateImplemented,
  requiresQ274OcrResultMathLiveReviewBinding: q275.requiresQ274OcrResultMathLiveReviewBinding,
  workspaceImportEnvelopeFields: q275.workspaceImportEnvelopeFields.length,
  requiredWorkspaceImportGates: q275.requiredWorkspaceImportGates.length,
  blockedUntilRealEvidence: q275.blockedUntilRealEvidence.length,
  workspaceImportRuntimePassClaimed: q275.workspaceImportRuntimePassClaimed,
  ocrPassClaimed: q275.ocrPassClaimed,
  realOcrRuntimeAdded: q275.realOcrRuntimeAdded,
  paddleRuntimeAdded: q275.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q275.paddleOcrDependencyAdded,
  nativeBridgeImplementationAdded: q275.nativeBridgeImplementationAdded,
  methodChannelRuntimeBindingAdded: q275.methodChannelRuntimeBindingAdded,
  modelBinaryBundledInBaseApp: q275.modelBinaryBundledInBaseApp,
  productionInferenceAllowed: q275.productionInferenceAllowed,
  protectedHashComparison: 'PASS',
}, null, 2));
