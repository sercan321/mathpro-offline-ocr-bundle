#!/usr/bin/env node
import fs from 'fs';
import crypto from 'crypto';
const phase = 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE';
const sourcePhase = 'V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE';
function read(p) { return fs.readFileSync(p, 'utf8'); }
function sha(p) { return crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex'); }
function fail(message) { console.error(`PP_FORMULANET_S_IMAGE_TO_LATEX_PROTOTYPE_GATE_Q273_BLOCKED: ${message}`); process.exit(1); }
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const policy = read('lib/features/camera/gauss_pp_formulanet_s_image_to_latex_prototype_gate_policy.dart');
const gate = read('lib/features/camera/gauss_pp_formulanet_s_image_to_latex_prototype_gate.dart');
const test = read('test/v172_q273_pp_formulanet_s_image_to_latex_prototype_gate_test.dart');
const audit = read('docs/audit/V172_Q273_PP_FORMULANET_S_IMAGE_TO_LATEX_PROTOTYPE_GATE_AUDIT.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const settings = read('android/settings.gradle');
if (![phase, 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', 'V172-Q277R1-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-FLUTTER-LOG-REPAIR', 'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE', 'V172-Q277R3-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-TAP-LATENCY-CADENCE', 'V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK', 'V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q280-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-BEHIND-FLAG', 'V172-Q281-PRIVATE-ARTIFACT-LOAD-REAL-SMOKE', 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE', 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT', 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING', 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT', 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q273');
if (manifest.ppFormulaNetSImageToLatexPrototypeGateLatestPhase !== phase) fail('manifest missing Q273 latest phase marker');
const q272 = manifest.v172Q272PpFormulaNetSFirstRuntimeSmokePrototype;
if (!q272 || q272.phase !== sourcePhase) fail('manifest missing Q272 source envelope');
const q273 = manifest.v172Q273PpFormulaNetSImageToLatexPrototypeGate;
if (!q273 || q273.phase !== phase) fail('manifest missing Q273 envelope');
if (q273.sourcePhase !== sourcePhase) fail('Q273 source phase mismatch');
if (q273.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q273 selected engine changed');
if (q273.imageToLatexPrototypeMode !== 'image-to-latex-prototype-gate-only-no-real-inference-no-production-runtime') fail('Q273 prototype mode mismatch');
if (q273.imageToLatexPrototypeGateImplemented !== true || q273.requiresQ272FirstRuntimeSmokePrototype !== true) fail('Q273 implementation/source gate missing');
for (const key of ['realOcrRuntimeAdded','paddleRuntimeAdded','paddleOcrDependencyAdded','nativeBridgeImplementationAdded','jniBindingAdded','methodChannelRuntimeBindingAdded','modelBinaryBundledInBaseApp','productionModelUrlBound','realNetworkDownloadWorkerImplemented','productionDownloadEnabled','productionInferenceAllowed','runtimeDefaultEnabled','realImageToLatexInferenceExecuted','imageToLatexPassClaimed','ocrPassClaimed']) {
  if (q273[key] !== false) fail(`Q273 must keep ${key} false`);
}
if (q273.runtimeFeatureFlagDefaultOff !== true || q273.prototypeMayReturnOnlyEnvelope !== true) fail('Q273 must keep feature flag default-off and envelope-only mode');
if (q273.editableMathLiveReviewRequired !== true || q273.userApprovalRequiredBeforeWorkspaceImport !== true) fail('Q273 must require MathLive review and user approval');
if (q273.directCameraSolveBlocked !== true || q273.directCameraGraphSolutionHistoryBlocked !== true) fail('Q273 direct solve/graph/solution/history must remain blocked');
if (!Array.isArray(q273.requiredPrototypeGates) || q273.requiredPrototypeGates.length < 36) fail('Q273 required gates incomplete');
if (!Array.isArray(q273.blockedUntilRealEvidence) || q273.blockedUntilRealEvidence.length < 23) fail('Q273 blocked evidence incomplete');
if (!Array.isArray(q273.imageInputEnvelopeFields) || q273.imageInputEnvelopeFields.length < 11) fail('Q273 image input envelope incomplete');
if (!Array.isArray(q273.latexCandidateEnvelopeFields) || q273.latexCandidateEnvelopeFields.length < 11) fail('Q273 candidate envelope incomplete');
if (!Array.isArray(q273.prototypeFailureCodes) || q273.prototypeFailureCodes.length < 13) fail('Q273 failure taxonomy incomplete');
for (const marker of ['croppedImageInputEnvelopeDocumented','primaryLatexCandidateFieldDocumented','noRealImageToLatexInferenceInQ273','noImageToLatexPassClaimedWithoutRealEvidence','editableMathLiveReviewRequired']) if (!q273.requiredPrototypeGates.includes(marker)) fail(`Q273 missing gate ${marker}`);
for (const marker of ['realCroppedImageCaptureEvidence','realPrimaryLatexCandidateEvidence','realMathLiveReviewEvidence','explicitUserApprovalForImageToLatexPrototypePhase']) if (!q273.blockedUntilRealEvidence.includes(marker)) fail(`Q273 missing blocked evidence ${marker}`);
for (const marker of ['croppedImageSha256','cropBounds','reviewOnlyMode']) if (!q273.imageInputEnvelopeFields.includes(marker)) fail(`Q273 missing image input field ${marker}`);
for (const marker of ['primaryLatexCandidate','alternativeLatexCandidates','confidence','mathLiveReviewRequired']) if (!q273.latexCandidateEnvelopeFields.includes(marker)) fail(`Q273 missing candidate field ${marker}`);
for (const marker of ['unsafeRuntimeInferenceAttempted','directSolveRiskDetected']) if (!q273.prototypeFailureCodes.includes(marker)) fail(`Q273 missing failure code ${marker}`);
for (const marker of ['readyForFutureImageToLatexPrototypeOnly','blockedRealInferenceOrPassClaimedInQ273','canRunRealImageToLatexInQ273: false','canClaimImageToLatexPassInQ273: false','canClaimOcrPassInQ273: false']) {
  if (!policy.includes(marker) && !gate.includes(marker) && !test.includes(marker) && !audit.includes(marker)) fail(`Q273 marker missing: ${marker}`);
}
for (const forbidden of ['google_mlkit_text_recognition','paddleocr','paddle_flutter','paddle_lite','onnxruntime','tesseract','pix2text','flutter_downloader','background_downloader','dio']) {
  if (pubspec.includes(forbidden)) fail(`Q273 must not add dependency: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
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
  'pubspec.yaml': '97182bbfa14cace9cf1825ba75832e2da18e183279299a14fdfb578a0ad49304',
  'android/settings.gradle': 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30',
  'android/gradle/wrapper/gradle-wrapper.properties': '797ea7d637b36ce5ccff6559a427ae97077073c7992883469e6ecb523fea2b97',
  'android/app/build.gradle': '5533186d6120cb1c8d5c976e2f13f2505d395721d03f6025138fdf96ac3c3ecb',
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51',
}
for (const [path, expected] of Object.entries(protectedHashes)) {
  if (!fs.existsSync(path)) fail(`protected file missing: ${path}`);
  if (sha(path) !== expected) fail(`protected hash changed: ${path}`);
}
for (const marker of [phase, 'Image-to-LaTeX Prototype Gate', 'no real image-to-LaTeX inference', 'MathLive review']) {
  if (!readme.includes(marker) && !audit.includes(marker)) fail(`documentation marker missing: ${marker}`);
}
console.log(JSON.stringify({
  phase,
  status: 'PP_FORMULANET_S_IMAGE_TO_LATEX_PROTOTYPE_GATE_Q273_STATIC_READY_BUT_REAL_IMAGE_TO_LATEX_INFERENCE_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q273.selectedEngineLabel,
  prototypeMode: q273.imageToLatexPrototypeMode,
  imageToLatexPrototypeGateImplemented: q273.imageToLatexPrototypeGateImplemented,
  requiresQ272FirstRuntimeSmokePrototype: q273.requiresQ272FirstRuntimeSmokePrototype,
  imageInputEnvelopeFields: q273.imageInputEnvelopeFields.length,
  latexCandidateEnvelopeFields: q273.latexCandidateEnvelopeFields.length,
  requiredPrototypeGates: q273.requiredPrototypeGates.length,
  blockedUntilRealEvidence: q273.blockedUntilRealEvidence.length,
  imageToLatexPassClaimed: q273.imageToLatexPassClaimed,
  ocrPassClaimed: q273.ocrPassClaimed,
  realOcrRuntimeAdded: q273.realOcrRuntimeAdded,
  paddleRuntimeAdded: q273.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q273.paddleOcrDependencyAdded,
  nativeBridgeImplementationAdded: q273.nativeBridgeImplementationAdded,
  methodChannelRuntimeBindingAdded: q273.methodChannelRuntimeBindingAdded,
  modelBinaryBundledInBaseApp: q273.modelBinaryBundledInBaseApp,
  productionInferenceAllowed: q273.productionInferenceAllowed,
  protectedHashComparison: 'PASS',
}, null, 2));
