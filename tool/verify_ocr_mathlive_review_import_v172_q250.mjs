import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const phase = 'V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT';
const q249 = 'V172-Q249-OCR-RUNTIME-ADAPTER';

function fail(message) {
  console.error(`OCR_MATHLIVE_REVIEW_IMPORT_Q250_BLOCKED: ${message}`);
  process.exit(1);
}
function read(rel) {
  const p = path.join(root, rel);
  if (!fs.existsSync(p)) fail(`missing file: ${rel}`);
  return fs.readFileSync(p, 'utf8');
}
function exists(rel) {
  return fs.existsSync(path.join(root, rel));
}
function sha(rel) {
  return crypto.createHash('sha256').update(fs.readFileSync(path.join(root, rel))).digest('hex');
}

const policy = read('lib/features/camera/gauss_ocr_mathlive_review_import_policy.dart');
const reviewImport = read('lib/features/camera/gauss_ocr_mathlive_review_import.dart');
const reviewSurface = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const test = read('test/v172_q250_ocr_mathlive_review_import_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
const readme = read('README.md');
const audit = read('docs/audit/V172_Q250_OCR_MATHLIVE_REVIEW_IMPORT_AUDIT.md');
const changed = read('docs/audit/V172_Q250_CHANGED_FILES.md');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  phase,
  q249,
  "selectedEngineLabel = 'PP-FormulaNet-S'",
  "fallbackEngineLabel = 'PP-FormulaNet_plus-L'",
  "reviewImportMode = 'editable-mathlive-review-first-import-contract'",
  "reviewSurfaceKey = 'mathpro-ocr-mathlive-review-import-surface'",
  'q249AdapterEnvelopeRequired = true',
  'q248DeferredModelReadinessStillRequired = true',
  'adapterPrimaryCandidateRequiredBeforeReview = true',
  'candidateAlternativesPreserved = true',
  'confidenceAndWarningsPreserved = true',
  'editableMathLiveReviewDraftImplemented = true',
  'userApprovalRequiredBeforeWorkspaceImport = true',
  'workspaceImportPreparedOnlyAfterUserApproval = true',
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
  'productionRuntimeBindingAllowed = false',
  'productionMathLiveBridgeCalled = false',
  'androidToolchainModernizationDeferredToQ253 = true',
]) if (!policy.includes(marker)) fail(`Q250 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussOcrMathLiveReviewImportDecision',
  'blockedAdapterNotReady',
  'blockedMissingPrimaryCandidate',
  'blockedUnsafeCandidate',
  'editableReviewDraftReady',
  'workspaceImportReadyAfterUserApproval',
  'class GaussOcrMathLiveReviewCandidateDraft',
  'originalLatex',
  'editableLatex',
  'warnings',
  'fromAdapterCandidate',
  'class GaussOcrMathLiveReviewImportDraft',
  'canOpenEditableMathLiveReview',
  'canImportToWorkspaceAfterUserApproval',
  'canEvaluateBeforeApproval => false',
  'canGraphBeforeApproval => false',
  'canWriteSolutionBeforeApproval => false',
  'canWriteHistoryBeforeApproval => false',
  'class GaussOcrMathLiveReviewImport',
  'requiresUserApprovalBeforeWorkspaceImport = true',
  'callsProductionMathLiveBridge = false',
  'createEditableReviewDraft',
  'Q249 adapter envelope must be review-only ready before MathLive review import.',
  'A primary LaTeX candidate is required before editable MathLive review.',
]) if (!reviewImport.includes(marker)) fail(`Q250 review import missing marker: ${marker}`);

for (const marker of [
  "import 'gauss_ocr_mathlive_review_import.dart';",
  'factory GaussMathLiveOcrReviewDraft.fromQ250Import',
  'userApprovedForWorkspaceImport',
  'bool get canImportToWorkspace => hasRealOcrCandidate && userApprovedForWorkspaceImport',
  'Gerçek OCR adayı ve kullanıcı onayı gelmeden workspace aktarımı',
]) if (!reviewSurface.includes(marker)) fail(`review surface missing Q250 marker: ${marker}`);

const duplicateDraftFieldMatches = reviewSurface.match(/final GaussMathLiveOcrReviewDraft draft;/g) ?? [];
if (duplicateDraftFieldMatches.length !== 3) {
  fail(`review surface should contain exactly one draft field per card class; found ${duplicateDraftFieldMatches.length}`);
}
if (reviewSurface.includes('final GaussMathLiveOcrReviewDraft draft;\n  final GaussMathLiveOcrReviewDraft draft;')) {
  fail('review surface still contains duplicate draft field compile-risk');
}

for (const marker of [
  phase,
  'PP-FormulaNet-S',
  'editable MathLive review-first import',
  'blocks MathLive review import until the Q249 adapter envelope is review-ready',
  'blocks workspace import before user approval',
  'workspaceImportReadyAfterUserApproval',
  'camera: 0.10.6',
  'camera_android: 0.10.9+3',
  'google_mlkit_text_recognition',
  'paddleocr',
  'onnxruntime',
]) if (!test.includes(marker)) fail(`Q250 test missing marker: ${marker}`);

if (manifest.ocrMathLiveReviewImportLatestPhase !== phase) fail('manifest missing ocrMathLiveReviewImportLatestPhase Q250');
if (![phase, 'V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT', 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION', 'V172-Q254-PP-FORMULANET-S-RUNTIME-SOURCE-EVIDENCE-GATE', 'V172-Q255-PP-FORMULANET-S-MODEL-DOWNLOAD-WORKER-GUARD', 'V172-Q256-PP-FORMULANET-S-ARTIFACT-MANIFEST-AND-SHA-LOCK', 'V172-Q257-PP-FORMULANET-S-DOWNLOAD-ORCHESTRATOR-UI-GUARD', 'V172-Q258-PP-FORMULANET-S-PRODUCTION-ARTIFACT-RESOLVER-GATE', 'V172-Q259-PP-FORMULANET-S-REAL-DOWNLOAD-WORKER-DRY-RUN', 'V172-Q260-PP-FORMULANET-S-REAL-MODEL-DOWNLOAD-INTEGRATION-GATE', 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER', 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE', 'V172-Q261-PP-FORMULANET-S-RUNTIME-FEASIBILITY-ADAPTER', 'V172-Q262-PP-FORMULANET-S-RUNTIME-PROTOTYPE-BRIDGE-GATE', 'V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE', 'V172-Q264-PP-FORMULANET-S-RUNTIME-PROTOTYPE-EVIDENCE-INTAKE-GATE', 'V172-Q265-PP-FORMULANET-S-RUNTIME-EVIDENCE-ACCEPTANCE-COURT', 'V172-Q266-PP-FORMULANET-S-RUNTIME-ACTIVATION-DECISION-GATE', 'V172-Q267-PP-FORMULANET-S-RUNTIME-INTEGRATION-PREFLIGHT-PACKAGE', 'V172-Q268-PP-FORMULANET-S-ISOLATED-RUNTIME-IMPLEMENTATION-GATE', 'V172-Q269-PP-FORMULANET-S-RUNTIME-DEPENDENCY-ISOLATION', 'V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON', 'V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE', 'V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE', 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE', 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to this phase or successor through Q277');
if (manifest.v172Q250OcrMathLiveReviewImport?.selectedEngineLabel !== 'PP-FormulaNet-S') fail('manifest missing PP-FormulaNet-S selected engine for Q250');
if (manifest.v172Q250OcrMathLiveReviewImport?.userApprovalRequiredBeforeWorkspaceImport !== true) fail('manifest must require user approval before workspace import');
if (manifest.v172Q250OcrMathLiveReviewImport?.directWorkspaceImportAllowed !== false) fail('manifest must block direct workspace import');
if (manifest.v172Q250OcrMathLiveReviewImport?.directSolveFromCameraAllowed !== false) fail('manifest must block direct solve');
if (manifest.v172Q250OcrMathLiveReviewImport?.productionMathLiveBridgeCalled !== false) fail('manifest must not call production MathLive bridge');

for (const marker of [phase, 'Q250', 'PP-FormulaNet-S', 'editable review', 'user approval', 'no Paddle runtime', 'no model binary']) {
  if (!readme.includes(marker)) fail(`README missing Q250 marker: ${marker}`);
  if (!audit.includes(marker)) fail(`audit missing Q250 marker: ${marker}`);
}
for (const marker of ['gauss_ocr_mathlive_review_import_policy.dart', 'gauss_ocr_mathlive_review_import.dart', 'gauss_mathlive_ocr_review_surface.dart', 'verify_ocr_mathlive_review_import_v172_q250.mjs']) {
  if (!changed.includes(marker)) fail(`changed-files audit missing marker: ${marker}`);
}

if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must keep camera: 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must keep camera_android: 0.10.9+3');
for (const forbidden of ['camera_android_camerax', 'google_mlkit_text_recognition', 'paddleocr', 'onnxruntime', 'flutter_downloader']) {
  if (pubspec.includes(forbidden)) fail(`pubspec must not add dependency: ${forbidden}`);
}
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('Kotlin plugin 2.1.0 must remain');
if (!settings.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settings.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('AGP must remain 8.3.2 for this phase or move to 8.6.1 only through Q253 successor modernization');
}
if (!androidManifest.includes('android.permission.CAMERA')) fail('CAMERA permission must remain');
if (androidManifest.includes('READ_MEDIA_IMAGES')) fail('Q250 must not add media permissions');

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
].map(read).join('\n');
for (const forbidden of ['runPpFormulaNetSInference(', 'runOcrEngine(', 'setWorkspaceLatexWithoutUserApproval', 'setWorkspaceLatexWithoutReview', 'evaluateFromCamera', 'graphFromCamera', 'writeHistoryFromCamera', 'solveFromCamera', 'downloadModelNow', 'PaddleOCR', 'FormulaRecognition(']) {
  if (runtimeFiles.includes(forbidden)) fail(`Q250 must not mutate active runtime marker: ${forbidden}`);
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
  status: 'OCR_MATHLIVE_REVIEW_IMPORT_Q250_STATIC_READY_WITH_Q251_Q252_SUCCESSOR_BUT_REAL_RUNTIME_AND_FLUTTER_RETEST_REQUIRED',
  selectedEngineLabel: 'PP-FormulaNet-S',
  reviewImportMode: 'editable-mathlive-review-first-import-contract',
  realOcrRuntimeAdded: false,
  paddleRuntimeAdded: false,
  modelBinaryBundledInBaseApp: false,
  productionMathLiveBridgeCalled: false,
  userApprovalRequiredBeforeWorkspaceImport: true,
  protectedHashComparison: 'PASS',
}, null, 2));
