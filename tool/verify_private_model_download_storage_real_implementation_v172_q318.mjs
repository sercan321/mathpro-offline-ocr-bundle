#!/usr/bin/env node
import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION';
const sourcePhase = 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG';
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
if (![phase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase must be Q318 or Q319 successor, got ${manifest.cameraOcrLatestPhase}`);
if (![phase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail(`activeProductDevelopmentLatestPhase must be Q318 or Q319 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
if (manifest.privateModelDownloadStorageRealImplementationLatestPhase !== phase) fail('latest Q318 marker missing');
if (manifest.androidNativeBridgeMinimalHealthcheckLatestPhase !== sourcePhase) fail('Q317 source latest marker missing');
if (!manifest.v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag) fail('Q317 envelope missing');
if ([q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q319VerifiedArtifactLoadSmokeOnDevice) fail('Q319 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q320SuccessorPhase && !manifest.v172Q320RuntimeStartupSmokeOnDevice) fail('Q320 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q321SuccessorPhase && !manifest.v172Q321DummyInputRuntimeCall) fail('Q321 successor envelope missing');
const q318 = manifest.v172Q318PrivateModelDownloadStorageRealImplementation;
if (!q318) fail('Q318 manifest envelope missing');
if (q318.phase !== phase) fail('Q318 manifest phase mismatch');
if (q318.sourcePhase !== sourcePhase) fail('Q318 source phase mismatch');
if (q318.nativeChannelName !== 'mathpro/ocr_runtime_bridge') fail('Q318 native channel mismatch');
if (q318.privateStorageInfoMethod !== 'privateStorageInfo') fail('Q318 privateStorageInfo method missing');
if (q318.verifyPrivateStorageArtifactMethod !== 'verifyPrivateStorageArtifact') fail('Q318 verifyPrivateStorageArtifact method missing');
if (q318.privateStorageStatus !== 'PRIVATE_MODEL_STORAGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF') fail('Q318 storage status mismatch');
if (q318.modelDirectoryName !== 'ocr_models/PP-FormulaNet-S') fail('Q318 private storage model directory mismatch');
if (q318.artifactFileName !== 'inference.pdiparams') fail('Q318 artifact file mismatch');
if (q318.expectedInferencePdiparamsSha256 !== expectedSha256) fail('Q318 expected SHA mismatch');
if (q318.q315EvidenceSizeBytes !== 231675001) fail('Q318 size evidence mismatch');
for (const key of [
  'q315HashEvidenceProvidedToAssistant',
  'q315Sha256MatchesExpected',
  'q315ArtifactStoredOutsideProjectRoot',
  'q317NativeBridgeHealthcheckAdded',
  'privateStorageImplementationAdded',
  'privateStoragePathResolverAdded',
  'privateStorageShaHealthcheckAdded',
  'mainActivityChanged',
  'protectedMainActivityChangeDeclared',
  'methodChannelBindingExtended'
]) {
  if (q318[key] !== true) fail(`Q318 ${key} must be true`);
}
for (const key of [
  'q315RuntimeAccepted',
  'q317UserSideFlutterAnalyzeProvided',
  'q317UserSideFlutterTestProvided',
  'q317UserSideFlutterRunProvided',
  'privateModelDownloadImplementationAdded',
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
  'runtimeStartupExecuted',
  'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted',
  'editableMathLiveReviewOpened',
  'workspaceImportExecuted',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'androidRealDevicePassClaimed'
]) {
  if (q318[key] !== false) fail(`Q318 ${key} must remain false`);
}
for (const field of ['phase','method','channel','status','privateStorageRoot','artifactPath','artifactExists','artifactSizeBytes','expectedArtifactSha256','actualArtifactSha256','sha256MatchesExpected','modelArtifactAcceptedForRuntime','runtimeDependencyAdded','runtimeStartupExecuted','imageToLatexInferenceExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','ocrPassClaimed']) {
  if (!q318.privateStorageEnvelopeFields.includes(field)) fail(`Q318 storage envelope field missing: ${field}`);
}
for (const item of ['no-network-download-worker-inside-app-in-q318','no-model-binary-committed-to-project-zip-in-q318','no-model-load-or-runtime-acceptance-in-q318','no-runtime-startup-dummy-call-or-image-to-latex-in-q318','no-ocr-pass-or-android-real-device-pass-without-real-run-log']) {
  if (!q318.q318HardBlocks.includes(item)) fail(`Q318 hard block missing: ${item}`);
}

for (const file of [
  'lib/features/camera/gauss_private_model_download_storage_real_implementation_q318_policy.dart',
  'lib/features/camera/gauss_private_model_download_storage_real_implementation_q318.dart',
  'test/v172_q318_private_model_download_storage_real_implementation_test.dart',
  'tool/verify_private_model_download_storage_real_implementation_v172_q318.mjs',
  'docs/audit/V172_Q318_PRIVATE_MODEL_DOWNLOAD_STORAGE_REAL_IMPLEMENTATION_AUDIT.md',
  'docs/audit/V172_Q318_CHANGED_FILES.md'
]) {
  if (!fs.existsSync(file)) fail(`Q318 file missing: ${file}`);
}
const policy = read('lib/features/camera/gauss_private_model_download_storage_real_implementation_q318_policy.dart');
for (const marker of [phase, sourcePhase, 'privateStorageInfo', 'verifyPrivateStorageArtifact', 'PRIVATE_MODEL_STORAGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF', 'ocr_models/PP-FormulaNet-S', expectedSha256]) {
  if (!policy.includes(marker)) fail(`Q318 policy marker missing: ${marker}`);
}
const impl = read('lib/features/camera/gauss_private_model_download_storage_real_implementation_q318.dart');
if (!impl.includes('return const GaussPrivateModelDownloadStorageRealImplementationQ318Result(')) fail('Q318 evaluate must return const result envelope');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'private val q318Phase = "V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION"',
  'private val q318PrivateStorageFeatureEnabled = false',
  'private val q318PrivateModelDirectoryName = "ocr_models/PP-FormulaNet-S"',
  'private val q318PrivateModelArtifactFileName = "inference.pdiparams"',
  '"privateStorageInfo", "verifyPrivateStorageArtifact" -> result.success(q318PrivateModelStorageHealthcheck(call.method))',
  'File(filesDir, q318PrivateModelDirectoryName)',
  'q318Sha256File',
  '"status" to "PRIVATE_MODEL_STORAGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF"',
  '"modelArtifactAcceptedForRuntime" to false',
  '"runtimeDependencyAdded" to false',
  '"runtimeStartupExecuted" to false',
  '"imageToLatexInferenceExecuted" to false',
  '"ocrPassClaimed" to false'
]) {
  if (!mainActivity.includes(marker)) fail(`Q318 MainActivity marker missing: ${marker}`);
}
for (const forbidden of ['PaddleOCR','PaddleLite','loadModel(','runInference(','imageToLatex(','JNIEnv','OkHttpClient','DownloadManager']) {
  if (mainActivity.includes(forbidden)) fail(`forbidden runtime/download marker in Q318 MainActivity: ${forbidden}`);
}

const changed = read('docs/audit/V172_Q318_CHANGED_FILES.md');
if (!changed.includes('Protected Runtime File Intentionally Modified')) fail('Q318 changed files must declare intentional protected MainActivity change');
if (!changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt')) fail('Q318 changed files must list MainActivity');
if (!changed.includes('private model storage path and SHA healthcheck methods only')) fail('Q318 changed files must explain MainActivity reason');
const audit = read('docs/audit/V172_Q318_PRIVATE_MODEL_DOWNLOAD_STORAGE_REAL_IMPLEMENTATION_AUDIT.md');
if (!audit.includes('SHA match: `true`')) fail('Q318 audit must record Q315 SHA match');
if (!audit.includes('Runtime accepted: `false`')) fail('Q318 audit must keep runtime acceptance false');

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added in Q318: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6') || !pubspec.includes('camera_android: 0.10.9+3')) fail('camera dependencies changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must remain absent');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
for (const forbidden of ['READ_EXTERNAL_STORAGE','MANAGE_EXTERNAL_STORAGE','FOREGROUND_SERVICE_DATA_SYNC']) {
  if (androidManifest.includes(forbidden)) fail(`forbidden Android permission added in Q318: ${forbidden}`);
}
const readme = read('README.md');
if (!readme.includes('V172-Q318')) fail('README must mention Q318');
if (!readme.includes('PRIVATE_MODEL_STORAGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF')) fail('README must disclose Q318 storage status');

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
  status: 'PRIVATE_MODEL_STORAGE_HEALTHCHECK_BOUND_DEFAULT_OFF_NO_RUNTIME',
  sourcePhase,
  nativeChannelName: q318.nativeChannelName,
  privateStorageInfoMethod: q318.privateStorageInfoMethod,
  verifyPrivateStorageArtifactMethod: q318.verifyPrivateStorageArtifactMethod,
  q315Sha256MatchesExpected: q318.q315Sha256MatchesExpected,
  privateStorageImplementationAdded: q318.privateStorageImplementationAdded,
  privateModelDownloadImplementationAdded: q318.privateModelDownloadImplementationAdded,
  runtimeDependencyAdded: q318.runtimeDependencyAdded,
  modelArtifactAcceptedForRuntime: q318.modelArtifactAcceptedForRuntime,
  runtimeStartupExecuted: q318.runtimeStartupExecuted,
  realImageToLatexInferenceExecuted: q318.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q318.ocrPassClaimed,
  androidRealDevicePassClaimed: q318.androidRealDevicePassClaimed
}, null, 2));
