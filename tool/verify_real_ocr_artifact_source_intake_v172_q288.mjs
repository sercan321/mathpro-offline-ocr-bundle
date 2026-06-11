#!/usr/bin/env node
// Successor-aware through V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const phase = 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE';
const q309SuccessorPhase = 'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
const q310SuccessorPhase = 'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
const sourcePhase = 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR';
const q289SuccessorPhase = 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q290SuccessorPhase = 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING';
function fail(message) { console.error(`[Q288 VERIFY FAIL] ${message}`); process.exit(1); }
function read(file) { return fs.readFileSync(file, 'utf8'); }
function json(file) { return JSON.parse(read(file)); }
function sha(file) { return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex'); }
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(p));
    else out.push(p);
  }
  return out;
}

const manifest = json('assets/mathlive/manifest.json');
const pubspec = read('pubspec.yaml');
const policy = read('lib/features/camera/gauss_real_ocr_artifact_source_intake_policy.dart');
const gate = read('lib/features/camera/gauss_real_ocr_artifact_source_intake.dart');
const test = read('test/v172_q288_real_ocr_artifact_source_intake_test.dart');
const audit = read('docs/audit/V172_Q288_REAL_OCR_ARTIFACT_SOURCE_INTAKE_AUDIT.md');
const changed = read('docs/audit/V172_Q288_CHANGED_FILES.md');
const readme = read('README.md');
const q288 = manifest.q288RealOcrArtifactSourceIntake;

if (![phase, q289SuccessorPhase, q290SuccessorPhase, 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME', 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE', 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE', 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE', 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME', 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME', 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION', 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT', 'V172-Q300-RELEASE-CANDIDATE-FREEZE', 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK', 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK', 'V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF', 'V172-Q304-ANDROID-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-GATE', 'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE', 'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE', 'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE', 'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE', q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q288 or successor');
if (manifest.realOcrArtifactSourceIntakeLatestPhase !== phase) fail('manifest Q288 latest marker missing');
if ([q289SuccessorPhase, q290SuccessorPhase, q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR'].includes(manifest.cameraOcrLatestPhase) && !manifest.q289RuntimeDependencyActualTrialDefaultOff) fail('Q289 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q290SuccessorPhase && !manifest.q290NativeRuntimeHandlerSkeletonAndroidBinding) fail('Q290 successor envelope missing');
if (!q288 || q288.phase !== phase) fail('Q288 manifest envelope missing or phase mismatch');
if (q288.sourcePhase !== sourcePhase) fail('Q288 source phase mismatch');
if (q288.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q288 selected engine mismatch');
if (!q288.intakeMode.includes('official-source-candidate-intake-only') || !q288.intakeMode.includes('sha-pending') || !q288.intakeMode.includes('no-runtime') || !q288.intakeMode.includes('no-ocr-pass')) fail('Q288 intake mode must remain source-only/no-runtime/no-ocr-pass');
if (q288.primaryOfficialRepositoryPath !== 'PaddlePaddle/PP-FormulaNet-S') fail('Q288 primary source repository mismatch');
if (!q288.primaryOfficialSourceLocator.includes('PaddlePaddle/PP-FormulaNet-S')) fail('Q288 primary source URL mismatch');
if (!q288.officialMirrorInferenceArtifactLocator.includes('PP-FormulaNet-S_infer.tar')) fail('Q288 BOS inference artifact candidate missing');
if (q288.recordedLicense !== 'apache-2.0') fail('Q288 license evidence mismatch');
if (q288.expectedSha256 !== 'PENDING_DOWNLOAD_AND_HASH_VERIFICATION') fail('Q288 must not invent a SHA256 before real download/hash verification');
if (q288.huggingFaceRepositorySizeMb !== 238) fail('Q288 Hugging Face repository size evidence mismatch');
if (q288.paddleDocsModelStorageSizeMb !== 224) fail('Q288 Paddle docs model storage evidence mismatch');
if (q288.expectedInputImageSize !== 224) fail('Q288 expected input image size evidence mismatch');

for (const key of [
  'sourceCandidateRecorded',
  'licenseEvidenceRecorded',
  'modelSizeEvidenceRecorded',
  'modelFormatEvidenceRecorded',
  'androidAbiEvidencePending',
  'latencyBudgetEvidencePending',
  'peakMemoryBudgetEvidencePending',
]) {
  if (q288[key] !== true) fail(`Q288 ${key} must be true`);
}

for (const key of [
  'artifactSha256Verified',
  'artifactAcceptedForRuntime',
  'officialDownloadEnabled',
  'changesRuntimeBehavior',
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'graphSolutionHistoryChanged',
  'mathLiveProductionRouteChanged',
  'cameraShellRuntimeChanged',
  'workspaceRuntimeChanged',
  'solverEvaluatorChanged',
  'androidToolchainChanged',
  'cameraDependencyChanged',
  'realOcrRuntimeAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'nativeHandlerImplementationAdded',
  'methodChannelRuntimeBindingAdded',
  'modelBinaryBundledInBaseApp',
  'productionModelUrlBound',
  'productionDownloadEnabled',
  'imageToLatexInferenceExecuted',
  'directWorkspaceImportEnabled',
  'directSolveGraphSolutionHistoryEnabled',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
]) {
  if (q288[key] !== false) fail(`Q288 ${key} must be false`);
}

for (const file of [
  'lib/features/camera/gauss_real_ocr_artifact_source_intake_policy.dart',
  'lib/features/camera/gauss_real_ocr_artifact_source_intake.dart',
  'test/v172_q288_real_ocr_artifact_source_intake_test.dart',
  'tool/verify_real_ocr_artifact_source_intake_v172_q288.mjs',
  'docs/audit/V172_Q288_REAL_OCR_ARTIFACT_SOURCE_INTAKE_AUDIT.md',
  'docs/audit/V172_Q288_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q288 file missing: ${file}`);
}

if (!policy.includes(phase) || !policy.includes('sourceCandidateRecorded = true') || !policy.includes('artifactSha256Verified = false')) fail('Q288 policy markers missing');
if (!gate.includes('sourceCandidateRecordedButShaPending') || !gate.includes('blockedIfRuntimeOrPassClaimAdded')) fail('Q288 gate markers missing');
if (!test.includes('PENDING_DOWNLOAD_AND_HASH_VERIFICATION') || !test.includes('directSolveGraphSolutionHistoryEnabled')) fail('Q288 test markers missing');
if (!audit.includes('PP-FormulaNet-S') || !audit.includes('SHA256') || !audit.includes('Runtime Boundary')) fail('Q288 audit markers missing');
if (!changed.includes('gauss_real_ocr_artifact_source_intake_policy.dart')) fail('Q288 changed files must disclose new policy');
if (changed.includes('- `lib/features/keyboard/key_config.dart`') || changed.includes('- `assets/mathlive/mathlive_prod_bridge.js`') || changed.includes('- `lib/features/mathlive/mathlive_production_editor_surface.dart`')) fail('Q288 changed files must not list protected runtime files as changed');
if (!readme.includes('V172-Q288')) fail('README must mention Q288');

for (const verifier of [
  'tool/verify_camera_ocr_runtime_premium_regression_tap_latency_cadence_v172_q277r3.mjs',
  'tool/verify_real_runtime_integration_evidence_lock_v172_q278.mjs',
  'tool/verify_selected_runtime_dependency_trial_v172_q279.mjs',
  'tool/verify_native_runtime_bridge_implementation_v172_q280.mjs',
  'tool/verify_private_artifact_load_real_smoke_v172_q281.mjs',
  'tool/verify_first_real_runtime_smoke_on_device_v172_q282.mjs',
  'tool/verify_first_real_image_to_latex_inference_court_v172_q283.mjs',
  'tool/verify_ocr_result_real_mathlive_review_runtime_binding_v172_q284.mjs',
  'tool/verify_approved_ocr_workspace_import_runtime_court_v172_q285.mjs',
  'tool/verify_full_camera_ocr_runtime_premium_regression_v172_q286.mjs',
  'tool/verify_store_readiness_camera_ocr_release_audit_v172_q287.mjs',
  'tool/verify_store_readiness_camera_ocr_release_audit_log_repair_v172_q287r1.mjs',
  'tool/verify_store_readiness_camera_ocr_release_audit_test_doc_section_repair_v172_q287r2.mjs',
]) {
  if (!read(verifier).includes(phase)) fail(`successor-aware verifier missing Q288 marker: ${verifier}`);
}

for (const forbidden of [
  'paddleocr', 'paddle_ocr', 'paddle_flutter', 'paddle_lite', 'google_mlkit_text_recognition',
  'onnxruntime', 'tesseract', 'pix2text', 'flutter_downloader', 'background_downloader', 'dio',
]) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q288');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const normalized = file.replaceAll('\\', '/');
  const base = path.basename(normalized).toLowerCase();
  if (normalized.includes('/.git/') || normalized.includes('/.dart_tool/') || normalized.includes('/build/') || normalized.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q288: ${normalized}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q288: ${normalized}`);
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
  status: 'REAL_OCR_ARTIFACT_SOURCE_INTAKE_STATIC_READY_SHA_PENDING_NO_RUNTIME',
  sourcePhase,
  selectedEngineLabel: q288.selectedEngineLabel,
  primaryOfficialRepositoryPath: q288.primaryOfficialRepositoryPath,
  recordedLicense: q288.recordedLicense,
  expectedSha256: q288.expectedSha256,
  protectedHashComparison: 'PASS',
  artifactSha256Verified: q288.artifactSha256Verified,
  artifactAcceptedForRuntime: q288.artifactAcceptedForRuntime,
  realOcrRuntimeAdded: q288.realOcrRuntimeAdded,
  paddleRuntimeAdded: q288.paddleRuntimeAdded,
  modelBinaryBundledInBaseApp: q288.modelBinaryBundledInBaseApp,
  productionDownloadEnabled: q288.productionDownloadEnabled,
  imageToLatexInferenceExecuted: q288.imageToLatexInferenceExecuted,
  ocrPassClaimed: q288.ocrPassClaimed,
  cameraOcrRuntimePassClaimed: q288.cameraOcrRuntimePassClaimed,
  storeReadyPassClaimed: q288.storeReadyPassClaimed,
  releasePassClaimed: q288.releasePassClaimed,
  requiresUserSideRetest: q288.requiresUserSideRetest,
}, null, 2));

// V172-Q299 successor-awareness marker: V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT
