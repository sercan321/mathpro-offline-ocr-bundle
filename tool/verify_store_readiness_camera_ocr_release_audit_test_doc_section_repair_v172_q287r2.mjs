#!/usr/bin/env node
// Successor-aware through V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE
import fs from 'node:fs';
// Successor-aware through V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG
import path from 'node:path';
import crypto from 'node:crypto';

const phase = 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR';
const sourcePhase = 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR';
const q288SuccessorPhase = 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE';
function fail(message) { console.error(`[Q287R2 VERIFY FAIL] ${message}`); process.exit(1); }
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
const policy = read('lib/features/camera/gauss_store_readiness_camera_ocr_release_audit_test_doc_section_repair_policy.dart');
const gate = read('lib/features/camera/gauss_store_readiness_camera_ocr_release_audit_test_doc_section_repair.dart');
const q287r2Test = read('test/v172_q287r2_store_readiness_camera_ocr_release_audit_test_doc_section_repair_test.dart');
const q287r1Test = read('test/v172_q287r1_store_readiness_camera_ocr_release_audit_log_repair_test.dart');
const q277r3Test = read('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart');
const audit = read('docs/audit/V172_Q287R2_STORE_READINESS_CAMERA_OCR_RELEASE_AUDIT_TEST_DOC_SECTION_REPAIR_AUDIT.md');
const changed = read('docs/audit/V172_Q287R2_CHANGED_FILES.md');
const readme = read('README.md');
const q287r2 = manifest.q287r2StoreReadinessCameraOcrReleaseAuditTestDocSectionRepair;

if (![phase, q288SuccessorPhase, 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING', 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME', 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE', 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE', 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE', 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME', 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME', 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION', 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT', 'V172-Q300-RELEASE-CANDIDATE-FREEZE', 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK', 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q287R2 or Q288 successor');
if (manifest.storeReadinessCameraOcrReleaseAuditTestDocSectionRepairLatestPhase !== phase) fail('manifest Q287R2 latest marker missing');
if (!q287r2 || q287r2.phase !== phase) fail('Q287R2 manifest envelope missing or phase mismatch');
if (q287r2.sourcePhase !== sourcePhase) fail('Q287R2 source phase mismatch');
if (q287r2.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q287R2 selected engine mismatch');
if (!q287r2.repairMode.includes('test-doc-section-repair-only') || !q287r2.repairMode.includes('no-runtime') || !q287r2.repairMode.includes('no-release-pass')) fail('Q287R2 mode must be section-repair/no-runtime/no-release-pass');
if (q287r2.repairedIssueCount !== 2) fail('Q287R2 must record exactly two repaired test/documentation issues');

for (const key of [
  'repairsQ277R3ChangedFilesSectionAssertion',
  'repairsQ287R1ChangedFilesSectionAssertion',
  'keepsAnalyzeCleanResult',
]) {
  if (q287r2[key] !== true) fail(`Q287R2 ${key} must be true`);
}

for (const key of [
  'changesRuntimeBehavior',
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'graphSolutionHistoryChanged',
  'mathLiveProductionRouteChanged',
  'cameraShellRuntimeChanged',
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
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
]) {
  if (q287r2[key] !== false) fail(`Q287R2 ${key} must be false`);
}

for (const file of [
  'lib/features/camera/gauss_store_readiness_camera_ocr_release_audit_test_doc_section_repair_policy.dart',
  'lib/features/camera/gauss_store_readiness_camera_ocr_release_audit_test_doc_section_repair.dart',
  'test/v172_q287r2_store_readiness_camera_ocr_release_audit_test_doc_section_repair_test.dart',
  'tool/verify_store_readiness_camera_ocr_release_audit_test_doc_section_repair_v172_q287r2.mjs',
  'docs/audit/V172_Q287R2_STORE_READINESS_CAMERA_OCR_RELEASE_AUDIT_TEST_DOC_SECTION_REPAIR_AUDIT.md',
  'docs/audit/V172_Q287R2_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q287R2 file missing: ${file}`);
}

if (!policy.includes(phase) || !policy.includes('repairedIssueCount = 2') || !policy.includes('changesRuntimeBehavior = false')) fail('Q287R2 policy markers missing');
if (!gate.includes('repairedButRequiresUserRetest') || !gate.includes('blockedIfRuntimeOrReleaseClaimAdded')) fail('Q287R2 gate markers missing');
if (!q287r2Test.includes('repairsQ277R3ChangedFilesSectionAssertion') || !q287r2Test.includes("split('## Modified').last.split('## Not Changed').first")) fail('Q287R2 test markers missing');
if (!q277r3Test.includes("split('## Modified').last.split('## Explicitly Not Modified').first")) fail('Q277R3 test must parse the Modified section only');
if (!q287r1Test.includes("split('## Modified').last.split('## Not Changed').first")) fail('Q287R1 test must parse the Modified section only');
if (!q287r1Test.includes("split('## Not Changed').last.split('## Runtime Boundary').first")) fail('Q287R1 test must separately parse the Not Changed section');
if (!audit.includes('whole changed-files documents') || !audit.includes('not changed')) fail('Q287R2 audit must document section-scoping repair');
if (!changed.includes('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart') || !changed.includes('test/v172_q287r1_store_readiness_camera_ocr_release_audit_log_repair_test.dart')) fail('Q287R2 changed files must disclose repaired tests');
if (changed.includes('- `lib/features/keyboard/key_config.dart`') || changed.includes('- `assets/mathlive/mathlive_prod_bridge.js`')) fail('Q287R2 changed files must not list protected runtime files as changed');
if (!readme.includes('V172-Q287R2')) fail('README must mention Q287R2');
if (!read('tool/verify_store_readiness_camera_ocr_release_audit_log_repair_v172_q287r1.mjs').includes(phase)) fail('Q287R1 verifier must be Q287R2 successor-aware');
if (!read('tool/verify_store_readiness_camera_ocr_release_audit_v172_q287.mjs').includes(phase)) fail('Q287 verifier must be Q287R2 successor-aware');
if (!read('tool/verify_full_camera_ocr_runtime_premium_regression_v172_q286.mjs').includes(phase)) fail('Q286 verifier must be Q287R2 successor-aware');

for (const forbidden of [
  'paddleocr', 'paddle_ocr', 'paddle_flutter', 'paddle_lite', 'google_mlkit_text_recognition',
  'onnxruntime', 'tesseract', 'pix2text', 'flutter_downloader', 'background_downloader', 'dio',
]) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q287R2');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const normalized = file.replaceAll('\\', '/');
  const base = path.basename(normalized).toLowerCase();
  if (normalized.includes('/.git/') || normalized.includes('/.dart_tool/') || normalized.includes('/build/') || normalized.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q287R2: ${normalized}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q287R2: ${normalized}`);
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
  status: 'STORE_READINESS_CAMERA_OCR_RELEASE_AUDIT_Q287R2_TEST_DOC_SECTION_REPAIR_STATIC_READY_BUT_USER_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q287r2.selectedEngineLabel,
  repairedIssueCount: q287r2.repairedIssueCount,
  protectedHashComparison: 'PASS',
  changesRuntimeBehavior: q287r2.changesRuntimeBehavior,
  realOcrRuntimeAdded: q287r2.realOcrRuntimeAdded,
  paddleRuntimeAdded: q287r2.paddleRuntimeAdded,
  modelBinaryBundledInBaseApp: q287r2.modelBinaryBundledInBaseApp,
  ocrPassClaimed: q287r2.ocrPassClaimed,
  storeReadyPassClaimed: q287r2.storeReadyPassClaimed,
  releasePassClaimed: q287r2.releasePassClaimed,
  requiresUserSideRetest: q287r2.requiresUserSideRetest,
}, null, 2));

// V172-Q299 successor-awareness marker: V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT
