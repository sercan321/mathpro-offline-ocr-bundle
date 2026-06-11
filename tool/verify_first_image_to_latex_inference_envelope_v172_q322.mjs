#!/usr/bin/env node
import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE';
const sourcePhase = 'V172-Q321-DUMMY-INPUT-RUNTIME-CALL';
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
const expectedSha256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';

function fail(message) {
  console.error(`[${phase}] ${message}`);
  process.exit(1);
}
function read(file) {
  if (!fs.existsSync(file)) fail(`missing file: ${file}`);
  return fs.readFileSync(file, 'utf8');
}
function json(file) {
  try { return JSON.parse(read(file)); } catch (error) { fail(`invalid JSON ${file}: ${error.message}`); }
}
function sha(file) {
  return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
}
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(full));
    else out.push(full);
  }
  return out;
}

const manifest = json('assets/mathlive/manifest.json');
if (![phase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase must be Q322 or Q323 successor, got ${manifest.cameraOcrLatestPhase}`);
if (![phase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail(`activeProductDevelopmentLatestPhase must be Q322 or Q323 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
if ([q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q323RuntimeDependencyModelLoaderDecision) fail('Q323 successor envelope missing');
if (manifest.firstImageToLatexInferenceLatestPhase !== phase) fail('latest Q322 marker missing');
if (manifest.dummyInputRuntimeCallLatestPhase !== sourcePhase) fail('Q321 source latest marker missing');
if (!manifest.v172Q321DummyInputRuntimeCall) fail('Q321 source envelope missing');
const q322 = manifest.v172Q322FirstImageToLatexInferenceEnvelope;
if (!q322) fail('Q322 manifest envelope missing');
if (q322.phase !== phase) fail('Q322 manifest phase mismatch');
if (q322.sourcePhase !== sourcePhase) fail('Q322 source phase mismatch');
if (q322.nativeChannelName !== 'mathpro/ocr_runtime_bridge') fail('Q322 native channel mismatch');
if (q322.firstImageToLatexInferenceMethod !== 'firstImageToLatexInference') fail('Q322 method mismatch');
if (q322.firstImageToLatexInferenceStatus !== 'FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF') fail('Q322 status mismatch');
if (q322.expectedInferencePdiparamsSha256 !== expectedSha256) fail('Q322 expected SHA mismatch');
if (q322.expectedInferencePdiparamsSizeBytes !== 231675001) fail('Q322 artifact size evidence mismatch');
for (const key of [
  'q315HashEvidenceProvidedToAssistant',
  'q315Sha256MatchesExpected',
  'q315ArtifactStoredOutsideProjectRoot',
  'q319VerifiedArtifactLoadSmokeAdded',
  'q320RuntimeStartupSmokeAdded',
  'q321DummyRuntimeCallMethodAdded',
  'firstImageToLatexInferenceMethodAdded',
  'mainActivityChanged',
  'protectedMainActivityChangeDeclared',
  'methodChannelBindingExtended'
]) {
  if (q322[key] !== true) fail(`Q322 ${key} must be true`);
}
for (const key of [
  'q315RuntimeAccepted',
  'featureFlagDefaultEnabled',
  'pubspecChanged',
  'gradleChanged',
  'androidManifestChanged',
  'runtimeDependencyAdded',
  'paddleRuntimeDependencyAdded',
  'paddleOcrDependencyAdded',
  'onnxRuntimeDependencyAdded',
  'tfliteRuntimeDependencyAdded',
  'downloadDependencyAdded',
  'jniNativeHandlerAdded',
  'nativeModelLoaderAdded',
  'modelBinaryBundledInBaseApp',
  'projectZipContainsModelArtifact',
  'modelArtifactAcceptedForRuntime',
  'runtimeStartupAttempted',
  'runtimeStartupExecuted',
  'runtimeStartupSmokePassed',
  'dummyRuntimeCallAttempted',
  'dummyRuntimeCallExecuted',
  'dummyRuntimeCallPassed',
  'imageInputAccepted',
  'realImageToLatexInferenceAttempted',
  'realImageToLatexInferenceExecuted',
  'realImageToLatexInferencePassed',
  'editableMathLiveReviewOpened',
  'workspaceImportExecuted',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'androidRealDevicePassClaimed'
]) {
  if (q322[key] !== false) fail(`Q322 ${key} must remain false`);
}
for (const field of ['phase','sourcePhase','method','channel','status','imageInputLabel','imageInputAccepted','artifactPath','artifactExists','artifactSizeBytes','expectedArtifactSha256','actualArtifactSha256','sha256MatchesExpected','verifiedArtifactLoadSmokePassed','inferenceBlockedReason','candidateLatex','candidateConfidence','runtimeDependencyAdded','dummyRuntimeCallExecuted','realImageToLatexInferenceAttempted','realImageToLatexInferenceExecuted','realImageToLatexInferencePassed','editableMathLiveReviewOpened','workspaceImportExecuted','ocrPassClaimed']) {
  if (!q322.firstImageToLatexInferenceEnvelopeFields.includes(field)) fail(`Q322 envelope field missing: ${field}`);
}
for (const item of ['no-paddle-onnx-tflite-runtime-dependency-in-q322','no-jni-native-model-loader-in-q322','no-image-input-acceptance-without-selected-runtime-dependency-in-q322','no-real-image-to-latex-execution-in-q322','no-ocr-pass-or-android-real-device-pass-without-real-run-log']) {
  if (!q322.q322HardBlocks.includes(item)) fail(`Q322 hard block missing: ${item}`);
}
for (const item of ['q322-flutter-run-device-log-shows-firstImageToLatexInference-method-response','q322-response-keeps-realImageToLatexInferenceExecuted-false-with-no-runtime-dependency','runtime-dependency-selection-approved-before-real-image-to-latex-execution']) {
  if (!q322.q323EntryCriteria.includes(item)) fail(`Q323 entry criterion missing: ${item}`);
}

for (const file of [
  'lib/features/camera/gauss_first_image_to_latex_inference_envelope_q322_policy.dart',
  'lib/features/camera/gauss_first_image_to_latex_inference_envelope_q322.dart',
  'test/v172_q322_first_image_to_latex_inference_envelope_test.dart',
  'tool/verify_first_image_to_latex_inference_envelope_v172_q322.mjs',
  'docs/audit/V172_Q322_FIRST_IMAGE_TO_LATEX_INFERENCE_ENVELOPE_AUDIT.md',
  'docs/audit/V172_Q322_CHANGED_FILES.md'
]) {
  if (!fs.existsSync(file)) fail(`Q322 file missing: ${file}`);
}
const policy = read('lib/features/camera/gauss_first_image_to_latex_inference_envelope_q322_policy.dart');
for (const marker of [phase, sourcePhase, 'firstImageToLatexInference', 'FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF', 'gauss.ppFormulaNetS.firstImageToLatexInference.defaultOff', expectedSha256]) {
  if (!policy.includes(marker)) fail(`Q322 policy marker missing: ${marker}`);
}
const impl = read('lib/features/camera/gauss_first_image_to_latex_inference_envelope_q322.dart');
if (!impl.includes('return const GaussFirstImageToLatexInferenceEnvelopeQ322Result(')) fail('Q322 evaluate must return const result envelope');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'private val q322Phase = "V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE"',
  'private val q322FirstImageToLatexFeatureEnabled = false',
  'private val q322ImageInputLabel = "q322-image-input-placeholder-no-runtime"',
  '"firstImageToLatexInference" -> result.success(q322FirstImageToLatexInference(call.method))',
  'private fun q322FirstImageToLatexInference(method: String): Map<String, Any>',
  '"status" to "FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF"',
  '"inferenceBlockedReason" to "no-runtime-dependency-bound-in-q322"',
  '"imageInputAccepted" to false',
  '"candidateLatex" to ""',
  '"runtimeDependencyAdded" to false',
  '"dummyRuntimeCallExecuted" to false',
  '"realImageToLatexInferenceAttempted" to false',
  '"realImageToLatexInferenceExecuted" to false',
  '"realImageToLatexInferencePassed" to false',
  '"editableMathLiveReviewOpened" to false',
  '"ocrPassClaimed" to false'
]) {
  if (!mainActivity.includes(marker)) fail(`Q322 MainActivity marker missing: ${marker}`);
}
for (const forbidden of ['PaddleOCR','PaddleLite','loadModel(','runInference(','JNIEnv','OkHttpClient','DownloadManager']) {
  if (mainActivity.includes(forbidden)) fail(`forbidden runtime/download marker in Q322 MainActivity: ${forbidden}`);
}

const changed = read('docs/audit/V172_Q322_CHANGED_FILES.md');
if (!changed.includes('Protected Runtime File Intentionally Modified')) fail('Q322 changed files must declare intentional protected MainActivity change');
if (!changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt')) fail('Q322 changed files must list MainActivity');
if (!changed.includes('default-off first image-to-LaTeX inference envelope method only')) fail('Q322 changed files must explain MainActivity reason');
const audit = read('docs/audit/V172_Q322_FIRST_IMAGE_TO_LATEX_INFERENCE_ENVELOPE_AUDIT.md');
if (!audit.includes('Runtime accepted: `false`')) fail('Q322 audit must keep runtime acceptance false');
if (!audit.includes('FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF')) fail('Q322 audit must disclose blocked inference status');
const readme = read('README.md');
if (!readme.includes('V172-Q322')) fail('README must mention Q322');
if (!readme.includes('FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF')) fail('README must disclose Q322 blocked status');

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added in Q322: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6') || !pubspec.includes('camera_android: 0.10.9+3')) fail('camera dependencies changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must remain absent');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
for (const forbidden of ['READ_EXTERNAL_STORAGE','MANAGE_EXTERNAL_STORAGE','FOREGROUND_SERVICE_DATA_SYNC']) {
  if (androidManifest.includes(forbidden)) fail(`forbidden Android permission added in Q322: ${forbidden}`);
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
  'pubspec.yaml': '97182bbfa14cace9cf1825ba75832e2da18e183279299a14fdfb578a0ad49304'
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
  const lower = normalized.toLowerCase();
  if (normalized.includes('__pycache__') || normalized.includes('.dart_tool/') || normalized.includes('build/') || normalized.includes('.gradle/') || normalized.includes('node_modules/') || normalized.endsWith('.apk') || normalized.endsWith('.aab')) fail(`forbidden artifact in tree: ${normalized}`);
  if (lower.includes('mathproocrartifacts')) fail(`model artifact directory must not be committed: ${normalized}`);
  if (lower.endsWith('inference.pdiparams') || lower.endsWith('pp-formulanet-s_infer.tar')) fail(`model binary/archive must not be committed: ${normalized}`);
}
console.log(JSON.stringify({
  phase,
  status: 'FIRST_IMAGE_TO_LATEX_INFERENCE_ENVELOPE_BOUND_DEFAULT_OFF_NO_RUNTIME_DEPENDENCY',
  sourcePhase,
  nativeChannelName: q322.nativeChannelName,
  firstImageToLatexInferenceMethod: q322.firstImageToLatexInferenceMethod,
  runtimeDependencyAdded: q322.runtimeDependencyAdded,
  dummyRuntimeCallExecuted: q322.dummyRuntimeCallExecuted,
  imageInputAccepted: q322.imageInputAccepted,
  realImageToLatexInferenceAttempted: q322.realImageToLatexInferenceAttempted,
  realImageToLatexInferenceExecuted: q322.realImageToLatexInferenceExecuted,
  realImageToLatexInferencePassed: q322.realImageToLatexInferencePassed,
  editableMathLiveReviewOpened: q322.editableMathLiveReviewOpened,
  workspaceImportExecuted: q322.workspaceImportExecuted,
  ocrPassClaimed: q322.ocrPassClaimed,
  androidRealDevicePassClaimed: q322.androidRealDevicePassClaimed
}, null, 2));
