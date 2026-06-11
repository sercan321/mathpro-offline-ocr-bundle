#!/usr/bin/env node
import fs from 'fs';
import crypto from 'crypto';
import path from 'path';

const phase = 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE';
const successorPhaseQ313R3 = 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const successorPhaseQ314 = 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN';
const successorPhaseQ315 = 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE';
const q315R1SuccessorPhase = 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR';
const q316SuccessorPhase = 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q317SuccessorPhase = 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG';
const q318SuccessorPhase = 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION';
const q319SuccessorPhase = 'V172-Q319-VERIFIED-ARTIFACT-LOAD-SMOKE-ON-DEVICE';
const q320SuccessorPhase = 'V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE';
const q321SuccessorPhase = 'V172-Q321-DUMMY-INPUT-RUNTIME-CALL';
const q322SuccessorPhase = 'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE';
const q323SuccessorPhase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
const q324SuccessorPhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q325SuccessorPhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
const q326SuccessorPhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
const q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
const q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const sourcePhase = 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE';
const fail = (msg) => { console.error(`[Q313R2][FAIL] ${msg}`); process.exit(1); };
const read = (p) => fs.readFileSync(p, 'utf8');
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
function walk(dir) { let out = []; for (const entry of fs.readdirSync(dir)) { const p = path.join(dir, entry); const st = fs.statSync(p); if (st.isDirectory()) out = out.concat(walk(p)); else out.push(p); } return out; }

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
if (![phase, successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase mismatch: ${manifest.cameraOcrLatestPhase}`);
if (![phase, successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail('activeProductDevelopmentLatestPhase must point to Q313R2 or Q313R3 successor');
if ([successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q313R3FlutterTestSuccessorAwareHygieneRepair) fail('manifest Q313R3 successor envelope missing');
if ([q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q316RuntimeDependencyFeasibilityTrialDefaultOff) fail('Q316 successor envelope missing');
if ([q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag) fail('Q317 successor envelope missing');
if ([q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q318PrivateModelDownloadStorageRealImplementation) fail('Q318 successor envelope missing');
if ([q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q319VerifiedArtifactLoadSmokeOnDevice) fail('Q319 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q320SuccessorPhase && !manifest.v172Q320RuntimeStartupSmokeOnDevice) fail('Q320 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q321SuccessorPhase && !manifest.v172Q321DummyInputRuntimeCall) fail('Q321 successor envelope missing');
if ((manifest.cameraOcrLatestPhase === successorPhaseQ314 || (manifest.cameraOcrLatestPhase === successorPhaseQ315 || [q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase))) && !manifest.v172Q314RealOcrImplementationReadinessArtifactAcquisitionPlan) fail('manifest Q314 successor envelope missing');
if (manifest.flutterAnalyzeInfoHygieneLatestPhase !== phase) fail('flutterAnalyzeInfoHygieneLatestPhase missing');
const q313r2 = manifest.v172Q313R2FlutterAnalyzeInfoHygiene;
if (!q313r2) fail('manifest Q313R2 envelope missing');
if (q313r2.phase !== phase) fail('Q313R2 phase mismatch');
if (q313r2.sourcePhase !== sourcePhase) fail('Q313R2 source phase mismatch');
for (const key of ['preferConstConstructorsApplied','q291TestConstDeclarationApplied']) {
  if (q313r2[key] !== true) fail(`${key} must be true`);
}
for (const key of ['parserErrorReintroduced','runtimeBehaviorChanged','cameraOcrRuntimeAdded','paddleRuntimeAdded','paddleOcrDependencyAdded','jniNativeHandlerAdded','methodChannelBindingAdded','modelBinaryBundledInBaseApp','productionDownloadEnabled','realImageToLatexInferenceExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','ocrPassClaimed','cameraOcrRuntimePassClaimed','storeReadyPassClaimed','releasePassClaimed']) {
  if (q313r2[key] !== false) fail(`${key} must be false`);
}
for (const file of [
  'lib/features/camera/gauss_flutter_analyze_info_hygiene_q313r2_policy.dart',
  'lib/features/camera/gauss_flutter_analyze_info_hygiene_q313r2.dart',
  'test/v172_q313r2_flutter_analyze_info_hygiene_test.dart',
  'tool/verify_flutter_analyze_info_hygiene_v172_q313r2.mjs',
  'docs/audit/V172_Q313R2_FLUTTER_ANALYZE_INFO_HYGIENE_AUDIT.md',
  'docs/audit/V172_Q313R2_CHANGED_FILES.md'
]) { if (!fs.existsSync(file)) fail(`Q313R2 file missing: ${file}`); }

const expectedConstReturns = {
  'lib/features/camera/gauss_first_real_dummy_input_runtime_call.dart': 'return const GaussFirstRealDummyInputRuntimeCallResult(',
  'lib/features/camera/gauss_first_real_image_to_latex_inference.dart': 'return const GaussFirstRealImageToLatexInferenceResult(',
  'lib/features/camera/gauss_first_real_runtime_startup_smoke.dart': 'return const GaussFirstRealRuntimeStartupSmokeResult(',
  'lib/features/camera/gauss_native_runtime_handler_skeleton_android_binding.dart': 'return const GaussNativeRuntimeHandlerSkeletonAndroidBindingResult(',
  'lib/features/camera/gauss_private_model_download_sha_verification_runtime.dart': 'return const GaussPrivateModelDownloadShaVerificationRuntimeResult(',
  'lib/features/camera/gauss_real_ocr_artifact_source_intake.dart': 'return const GaussRealOcrArtifactSourceIntakeResult(',
  'lib/features/camera/gauss_real_private_artifact_load_smoke.dart': 'return const GaussRealPrivateArtifactLoadSmokeResult(',
  'lib/features/camera/gauss_runtime_dependency_actual_trial_default_off.dart': 'return const GaussRuntimeDependencyActualTrialDefaultOffResult('
};
for (const [file, marker] of Object.entries(expectedConstReturns)) {
  if (!read(file).includes(marker)) fail(`const constructor hygiene marker missing in ${file}`);
}
if (!read('test/v172_q291_private_model_download_sha_verification_runtime_test.dart').includes('const fields = GaussPrivateModelDownloadShaVerificationRuntimePolicy.privateArtifactEnvelopeFields;')) fail('Q291 test const declaration hygiene missing');

const q295 = read('lib/features/camera/gauss_first_real_image_to_latex_inference.dart');
if (q295.includes("contains('\\files\\models\\')") || q295.includes("contains('\\cache\\crops\\')")) fail('Q295 malformed Windows path string literal reintroduced');
if (!q295.includes("replaceAll('\\\\', '/')")) fail('Q295 path normalization repair missing');

const changed = read('docs/audit/V172_Q313R2_CHANGED_FILES.md');
const modifiedSection = changed.split('## Protected Runtime Files Not Modified')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','pubspec.yaml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart','graph_card.dart','solution_steps_panel.dart','history_panel.dart','math_keyboard.dart','long_press_popup.dart']) {
  if (modifiedSection.includes(protectedPath)) fail(`Q313R2 modified section must not list protected/runtime file as changed: ${protectedPath}`);
}
const pubspec = read('pubspec.yaml');
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden runtime/download dependency added: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6') || !pubspec.includes('camera_android: 0.10.9+3')) fail('camera dependencies changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must remain absent');

const readme = read('README.md');
if (!readme.includes('V172-Q313R2')) fail('README must mention Q313R2');
if ([successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !readme.includes('V172-Q313R3')) fail('README must mention Q313R3 successor');
if ((manifest.cameraOcrLatestPhase === successorPhaseQ314 || (manifest.cameraOcrLatestPhase === successorPhaseQ315 || [q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase))) && !readme.includes('V172-Q314')) fail('README must mention Q314 successor');
if ((manifest.cameraOcrLatestPhase === successorPhaseQ315 || [q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) && !readme.includes('V172-Q315')) fail('README must mention Q315 successor');
const q313r1Verifier = read('tool/verify_flutter_log_repair_q295_path_escape_q152_successor_aware_v172_q313r1.mjs');
if (!q313r1Verifier.includes(phase)) fail('Q313R1 verifier must be Q313R2 successor-aware');
const q313Verifier = read('tool/verify_full_camera_ocr_real_device_regression_gate_v172_q313.mjs');
if (!q313Verifier.includes(phase)) fail('Q313 verifier must be Q313R2 successor-aware');

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
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51'
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
for (const file of walk('.')) {
  const normalized = file.split(path.sep).join('/').replace(/^\.\//, '');
  if (normalized.includes('__pycache__') || normalized.includes('.dart_tool/') || normalized.includes('build/') || normalized.includes('.gradle/') || normalized.includes('node_modules/')) fail(`forbidden artifact in tree: ${normalized}`);
}
console.log(JSON.stringify({ phase, status: 'FLUTTER_ANALYZE_INFO_HYGIENE_STATIC_READY_RUNTIME_UNCHANGED', sourcePhase, preferConstConstructorsApplied: q313r2.preferConstConstructorsApplied, q291TestConstDeclarationApplied: q313r2.q291TestConstDeclarationApplied, ocrPassClaimed: q313r2.ocrPassClaimed }, null, 2));
