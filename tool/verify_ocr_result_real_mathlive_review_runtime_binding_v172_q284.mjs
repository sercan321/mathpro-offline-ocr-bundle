#!/usr/bin/env node
// Successor-aware through V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE
import fs from 'node:fs';
// Successor-aware through V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG
import path from 'node:path';
import crypto from 'node:crypto';

const phase = 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING';
const sourcePhase = 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT';
function fail(message) { console.error(`[Q284 VERIFY FAIL] ${message}`); process.exit(1); }
function read(file) { return fs.readFileSync(file, 'utf8'); }
function sha(file) { return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex'); }
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(full));
    else out.push(full.replaceAll('\\', '/'));
  }
  return out;
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const gradleWrapper = read('android/gradle/wrapper/gradle-wrapper.properties');
const appBuild = read('android/app/build.gradle');
const policy = read('lib/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding_policy.dart');
const gate = read('lib/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding.dart');
const test = read('test/v172_q284_ocr_result_real_mathlive_review_runtime_binding_test.dart');
const audit = read('docs/audit/V172_Q284_REAL_MATHLIVE_REVIEW_RUNTIME_BINDING_AUDIT.md');
const changed = read('docs/audit/V172_Q284_CHANGED_FILES.md');
const readme = read('README.md');
const q283Verifier = read('tool/verify_first_real_image_to_latex_inference_court_v172_q283.mjs');
const q284 = manifest.q284OcrResultRealMathLiveReviewRuntimeBinding;

if (![phase, 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT', 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT', 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR', 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR', 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE', 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING', 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME', 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE', 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE', 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q284 or Q285 successor through Q287R1');
if (manifest.ocrResultRealMathLiveReviewRuntimeBindingLatestPhase !== phase) fail('manifest q284 latest marker missing');
if (!q284) fail('manifest q284OcrResultRealMathLiveReviewRuntimeBinding block missing');
if (q284.phase !== phase) fail('Q284 manifest phase mismatch');
if (q284.sourcePhase !== sourcePhase) fail('Q284 source phase mismatch');
if (q284.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q284 selected engine mismatch');
if (!q284.bindingMode.includes('gate-only') || !q284.bindingMode.includes('no-real-inference') || !q284.bindingMode.includes('no-direct-import')) fail('Q284 binding mode must be gate-only/no-real-inference/no-direct-import');

for (const key of [
  'ocrResultRealMathLiveReviewRuntimeBindingImplemented',
  'requiresQ283FirstRealImageToLatexInferenceCourt',
  'requiresQ282RuntimeSmokeEvidence',
  'requiresQ281PrivateArtifactLoadSmoke',
  'requiresQ280NativeRuntimeBridge',
  'requiresQ279DependencyTrial',
  'requiresQ278EvidenceLock',
  'requiresRuntimeCandidateEnvelope',
  'requiresPrimaryLatexCandidate',
  'requiresCandidateAlternativesConfidenceWarningsMetadata',
  'requiresImageInputMetadata',
  'editableMathLiveReviewRequired',
  'reviewDraftMustRemainEditable',
  'explicitUserApprovalRequiredBeforeWorkspaceImport',
  'workspaceImportPreparedOnlyAfterUserApproval',
  'directWorkspaceImportBlocked',
  'directSolveGraphSolutionHistoryBlocked',
]) {
  if (q284[key] !== true) fail(`Q284 ${key} must be true`);
}
for (const key of [
  'realMathLiveReviewRuntimeBindingExecutedInQ284',
  'realImageToLatexInferenceExecutedInQ284',
  'realRuntimeInvocationExecutedInQ284',
  'nativeRuntimeBridgeInvokedInQ284',
  'realOcrRuntimeAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'runtimeDependencyAddedToPubspec',
  'gradleNativeRuntimeDependencyAdded',
  'nativeHandlerImplementationAdded',
  'jniBindingAdded',
  'methodChannelRuntimeBindingAdded',
  'modelBinaryBundledInBaseApp',
  'productionModelUrlBound',
  'productionDownloadEnabled',
  'realNetworkDownloadWorkerImplemented',
  'reviewBindingPassClaimed',
  'imageToLatexPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'premiumFinalPassClaimed',
  'releasePassClaimed',
]) {
  if (q284[key] !== false) fail(`Q284 ${key} must be false`);
}
if (q284.minimumRequiredReviewFields !== 18) fail('Q284 review field minimum mismatch');
if (q284.maxEditableLatexLength !== 16000) fail('Q284 editable LaTeX length budget mismatch');
if (q284.maxAlternativeCandidateCount !== 8) fail('Q284 alternative candidate count mismatch');
if (!Array.isArray(q284.requiredReviewRuntimeBindingGates) || q284.requiredReviewRuntimeBindingGates.length < 12) fail('Q284 gate list too small');
for (const required of ['q283FirstRealImageToLatexInferenceCourtPresent', 'editableLatexDraftRequired', 'explicitUserApprovalRequiredBeforeWorkspaceImport', 'directSolveGraphSolutionHistoryBlocked']) {
  if (!q284.requiredReviewRuntimeBindingGates.includes(required)) fail(`Q284 missing gate: ${required}`);
}
if (!Array.isArray(q284.blockedUntilRealEvidence) || !q284.blockedUntilRealEvidence.includes('realEditableMathLiveReviewDraftEvidence')) fail('Q284 must require editable MathLive review draft evidence');
if (!Array.isArray(q284.reviewDraftEnvelopeFields) || q284.reviewDraftEnvelopeFields.length < 18) fail('Q284 review draft envelope field list incomplete');
if (!q284.reviewDraftEnvelopeFields.includes('editableLatexDraft') || !q284.reviewDraftEnvelopeFields.includes('workspaceImportPrepared')) fail('Q284 review draft fields missing');
if (!Array.isArray(q284.forbiddenActions) || !q284.forbiddenActions.includes('importCameraOutputWithoutUserApproval') || !q284.forbiddenActions.includes('runRealImageToLatexInferenceInQ284')) fail('Q284 forbidden action list incomplete');

for (const file of [
  'lib/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding_policy.dart',
  'lib/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding.dart',
  'test/v172_q284_ocr_result_real_mathlive_review_runtime_binding_test.dart',
  'tool/verify_ocr_result_real_mathlive_review_runtime_binding_v172_q284.mjs',
  'docs/audit/V172_Q284_REAL_MATHLIVE_REVIEW_RUNTIME_BINDING_AUDIT.md',
  'docs/audit/V172_Q284_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q284 file missing: ${file}`);
}
if (!policy.includes(phase) || !policy.includes('realMathLiveReviewRuntimeBindingExecutedInQ284 = false')) fail('Q284 policy markers missing');
if (!gate.includes('guardedReviewDraftBinding') || !gate.includes('readyForQ285ApprovedWorkspaceImportRuntimeCourtOnly') || !gate.includes('reviewRuntimeBindingFeatureFlagOff')) fail('Q284 gate markers missing');
if (!test.includes('canImportWorkspaceWithoutUserApproval, isFalse') || !test.includes('canClaimOcrPassInQ284, isFalse')) fail('Q284 test markers missing');
if (!audit.includes('no Paddle runtime') || !changed.includes('gauss_ocr_result_real_mathlive_review_runtime_binding.dart') || !readme.includes('V172-Q284')) fail('Q284 docs/readme markers missing');
if (!q283Verifier.includes(phase)) fail('Q283 verifier must be Q284 successor through Q287R1-aware');

for (const forbidden of [
  'paddleocr', 'paddle_ocr', 'paddle_flutter', 'paddle_lite', 'google_mlkit_text_recognition',
  'onnxruntime', 'tesseract', 'pix2text', 'flutter_downloader', 'background_downloader', 'dio',
]) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q284');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
if (!gradleWrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7');
if (!appBuild.includes('JavaVersion.VERSION_17') || !appBuild.includes("jvmTarget = '17'")) fail('Java/Kotlin target must remain 17');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const normalized = file.replaceAll('\\', '/');
  const base = path.basename(normalized).toLowerCase();
  if (normalized.includes('/.git/') || normalized.includes('/.dart_tool/') || normalized.includes('/build/') || normalized.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q284: ${normalized}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q284: ${normalized}`);
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
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'd9110c8d0018758216b1e9967bbd422cd97559d923cfc090e6677514da0d1c99',
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
  'android/settings.gradle': 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30',
  'android/gradle/wrapper/gradle-wrapper.properties': '797ea7d637b36ce5ccff6559a427ae97077073c7992883469e6ecb523fea2b97',
  'android/app/build.gradle': '5533186d6120cb1c8d5c976e2f13f2505d395721d03f6025138fdf96ac3c3ecb',
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51',
};
for (const [filePath, expected] of Object.entries(protectedHashes)) {
  if (!fs.existsSync(filePath)) fail(`protected path missing: ${filePath}`);
  const actual = sha(filePath);
  if (actual !== expected) {
    const q325AllowsMainActivitySuccessorChange =
      filePath === 'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt' &&
      manifest.v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate;
    if (!q325AllowsMainActivitySuccessorChange) fail(`protected hash changed unexpectedly for ${filePath}`);
  }
}

console.log(JSON.stringify({
  phase,
  status: 'OCR_RESULT_REAL_MATHLIVE_REVIEW_RUNTIME_BINDING_Q284_STATIC_READY_BUT_REAL_REVIEW_RUNTIME_INFERENCE_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q284.selectedEngineLabel,
  bindingMode: q284.bindingMode,
  requiredReviewRuntimeBindingGates: q284.requiredReviewRuntimeBindingGates.length,
  blockedUntilRealEvidence: q284.blockedUntilRealEvidence.length,
  forbiddenActions: q284.forbiddenActions.length,
  reviewDraftEnvelopeFields: q284.reviewDraftEnvelopeFields.length,
  realMathLiveReviewRuntimeBindingExecutedInQ284: q284.realMathLiveReviewRuntimeBindingExecutedInQ284,
  realImageToLatexInferenceExecutedInQ284: q284.realImageToLatexInferenceExecutedInQ284,
  realRuntimeInvocationExecutedInQ284: q284.realRuntimeInvocationExecutedInQ284,
  nativeRuntimeBridgeInvokedInQ284: q284.nativeRuntimeBridgeInvokedInQ284,
  realOcrRuntimeAdded: q284.realOcrRuntimeAdded,
  paddleRuntimeAdded: q284.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q284.paddleOcrDependencyAdded,
  modelBinaryBundledInBaseApp: q284.modelBinaryBundledInBaseApp,
  reviewBindingPassClaimed: q284.reviewBindingPassClaimed,
  ocrPassClaimed: q284.ocrPassClaimed,
  protectedHashComparison: 'PASS',
}, null, 2));
