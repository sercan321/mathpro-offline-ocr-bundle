#!/usr/bin/env node
import fs from 'fs';
import crypto from 'crypto';
import path from 'path';

const phase = 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE';
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
const sourcePhase = 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN';
const expectedPdiparamsSha256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
const fail = (msg) => { console.error(`[Q315][FAIL] ${msg}`); process.exit(1); };
const read = (p) => fs.readFileSync(p, 'utf8');
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
function walk(dir) {
  let out = [];
  for (const entry of fs.readdirSync(dir)) {
    const p = path.join(dir, entry);
    const st = fs.statSync(p);
    if (st.isDirectory()) out = out.concat(walk(p));
    else out.push(p);
  }
  return out;
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const allowedLatestPhases = [phase, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase];
if (!allowedLatestPhases.includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase mismatch: ${manifest.cameraOcrLatestPhase}`);
if (!allowedLatestPhases.includes(manifest.activeProductDevelopmentLatestPhase)) fail('activeProductDevelopmentLatestPhase must point to Q315 or Q315R1 successor');
if (!allowedLatestPhases.includes(manifest.controlledModelArtifactDownloadHashCaptureLatestPhase)) fail('Q315 latest pointer missing or non-successor');
if ([q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q315R1ControlledModelArtifactDownloadHashCaptureFlutterTestRepair) fail('Q315R1 successor envelope missing');
if ([q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q316RuntimeDependencyFeasibilityTrialDefaultOff) fail('Q316 successor envelope missing');
if ([q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag) fail('Q317 successor envelope missing');
if ([q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q318PrivateModelDownloadStorageRealImplementation) fail('Q318 successor envelope missing');
if ([q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q319VerifiedArtifactLoadSmokeOnDevice) fail('Q319 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q320SuccessorPhase && !manifest.v172Q320RuntimeStartupSmokeOnDevice) fail('Q320 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q321SuccessorPhase && !manifest.v172Q321DummyInputRuntimeCall) fail('Q321 successor envelope missing');
if (!manifest.v172Q314RealOcrImplementationReadinessArtifactAcquisitionPlan) fail('Q314 source envelope missing');
const q315 = manifest.v172Q315ControlledModelArtifactDownloadHashCapture;
if (!q315) fail('Q315 manifest envelope missing');
if (q315.phase !== phase) fail('Q315 phase mismatch');
if (q315.sourcePhase !== sourcePhase) fail('Q315 source phase mismatch');
if (q315.selectedEngineLabel !== 'PP-FormulaNet-S') fail('selected engine must remain PP-FormulaNet-S');
if (q315.implementationScope !== 'controlled-artifact-download-hash-capture-procedure-only') fail('implementation scope mismatch');
if (q315.captureState !== 'BLOCKED_PENDING_USER_SIDE_CONTROLLED_DOWNLOAD_LOCAL_HASH_EVIDENCE') fail('capture state mismatch');
if (q315.nextRequiredPhase !== 'Q316_RUNTIME_DEPENDENCY_FEASIBILITY_TRIAL_DEFAULT_OFF') fail('Q316 next phase pointer missing');
if (q315.primaryRepositoryLocator !== 'hf://PaddlePaddle/PP-FormulaNet-S') fail('primary repository locator mismatch');
if (q315.primaryRepositoryLicense !== 'apache-2.0') fail('license label mismatch');
if (q315.primaryRepositoryTotalSizeLabel !== '238 MB') fail('repository size label mismatch');
if (q315.primaryRequiredArtifactFile !== 'inference.pdiparams') fail('primary artifact file mismatch');
if (q315.primaryRequiredArtifactSizeLabel !== '232 MB') fail('primary artifact size mismatch');
if (q315.publishedInferencePdiparamsSha256 !== expectedPdiparamsSha256) fail('published inference.pdiparams sha mismatch');
if (!String(q315.officialResolveDownloadUrl || '').includes('hf-resolve://PaddlePaddle/PP-FormulaNet-S')) fail('official resolve URL missing');
if (q315.controlledDownloadScript !== 'tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs') fail('controlled download script pointer mismatch');
if (q315.artifactOutputDirectoryPolicy !== '../MathProOcrArtifacts/PP-FormulaNet-S') fail('artifact output directory policy mismatch');
if (q315.localArtifactSha256State !== 'NOT_COMPUTED_IN_ASSISTANT_CONTAINER_NETWORK_BLOCKED') fail('local artifact state must remain honest');
if (q315.remoteHashEvidenceState !== 'HF_LARGE_FILE_POINTER_SHA_RECORDED_NOT_RUNTIME_ACCEPTANCE') fail('remote hash evidence state mismatch');
if (q315.runtimeDecisionState !== 'PENDING_Q316_DEFAULT_OFF_RUNTIME_DEPENDENCY_FEASIBILITY_TRIAL') fail('runtime decision state mismatch');

for (const key of [
  'runtimeBehaviorChanged','cameraOcrRuntimeAdded','controlledDownloadPerformedByAssistant','localArtifactSha256Computed','localArtifactSha256MatchedPublishedHash','artifactAcceptedForRuntime','runtimeDependencyAdded','paddleRuntimeAdded','paddleOcrDependencyAdded','onnxRuntimeAdded','tfliteRuntimeAdded','jniNativeHandlerAdded','methodChannelBindingAdded','mainActivityChanged','androidManifestChanged','pubspecChanged','modelBinaryBundledInBaseApp','productionDownloadEnabled','privateStorageImplementationAdded','realPrivateArtifactLoaded','realRuntimeStartupExecuted','realDummyInputRuntimeCallExecuted','realImageToLatexInferenceExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','autoSolveGraphSolutionHistoryEnabled','ocrPassClaimed','cameraOcrRuntimePassClaimed','androidRealDevicePassClaimed','storeReadyPassClaimed','releasePassClaimed'
]) {
  if (q315[key] !== false) fail(`Q315 ${key} must remain false`);
}
for (const key of ['assistantContainerNetworkBlocked','remoteRepositoryFileInventoryCaptured','remoteLargeFileSha256Recorded','protectedRuntimeSurfacesUnchanged']) {
  if (q315[key] !== true) fail(`Q315 ${key} must remain true`);
}

for (const item of ['README.md','config.json','inference.json','inference.pdiparams','inference.yml']) {
  if (!q315.requiredRepositoryFiles.includes(item)) fail(`missing required repository file record: ${item}`);
}
for (const item of [
  'download-artifact-outside-project-root',
  'compute-sha256-from-local-downloaded-file',
  'compare-local-sha256-with-published-hf-large-file-sha256',
  'record-file-size-and-capture-timestamp',
  'do-not-commit-model-artifact-into-project-zip',
  'do-not-accept-artifact-for-runtime-until-local-hash-match-evidence-exists'
]) {
  if (!q315.controlledCaptureRequirements.includes(item)) fail(`missing controlled capture requirement: ${item}`);
}
for (const item of [
  'local-artifact-file-exists-outside-project-root',
  'local-artifact-sha256-equals-published-inference-pdiparams-sha256',
  'local-artifact-byte-size-is-recorded',
  'artifact-license-source-notes-are-recorded',
  'runtime-dependency-trial-remains-default-off-and-rollback-safe'
]) {
  if (!q315.q316EntryCriteria.includes(item)) fail(`missing Q316 entry criterion: ${item}`);
}
for (const item of [
  'no-runtime-dependency-before-local-hash-match-evidence',
  'no-mainactivity-or-androidmanifest-mutation-in-q315',
  'no-model-binary-in-base-app-or-delivery-zip',
  'no-methodchannel-runtime-binding-before-q317-healthcheck',
  'no-camera-image-to-runtime-before-q321-dummy-call-evidence',
  'no-workspace-import-before-editable-mathlive-review-and-user-approval'
]) {
  if (!q315.hardBlocksBeforeRuntime.includes(item)) fail(`missing hard block: ${item}`);
}

for (const file of [
  'lib/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315_policy.dart',
  'lib/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315.dart',
  'test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart',
  'tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs',
  'tool/verify_controlled_model_artifact_download_hash_capture_v172_q315.mjs',
  'docs/audit/V172_Q315_CONTROLLED_MODEL_ARTIFACT_DOWNLOAD_HASH_CAPTURE_AUDIT.md',
  'docs/audit/V172_Q315_CHANGED_FILES.md'
]) {
  if (!fs.existsSync(file)) fail(`Q315 file missing: ${file}`);
}

const policy = read('lib/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315_policy.dart');
for (const marker of [phase, sourcePhase, expectedPdiparamsSha256, 'NOT_COMPUTED_IN_ASSISTANT_CONTAINER_NETWORK_BLOCKED', 'no-model-binary-in-base-app-or-delivery-zip']) {
  if (!policy.includes(marker)) fail(`policy marker missing: ${marker}`);
}
const impl = read('lib/features/camera/gauss_controlled_model_artifact_download_hash_capture_q315.dart');
if (!impl.includes('return const GaussControlledModelArtifactDownloadHashCaptureQ315Result(')) fail('Q315 evaluate must return a const result envelope');
const q315Test = read('test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart');
if (!q315Test.includes('controlledDownloadPerformedByAssistant, isFalse')) fail('Q315 test must assert no assistant download');
if (!q315Test.includes('MathProOcrArtifacts')) fail('Q315 test must assert outside-project artifact path');
const captureScript = read('tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs');
for (const marker of ['EXPECTED_SHA256', expectedPdiparamsSha256, 'ensureOutsideProjectRoot', '--download', '--verify']) {
  if (!captureScript.includes(marker)) fail(`capture script marker missing: ${marker}`);
}

const q314Verifier = read('tool/verify_real_ocr_implementation_readiness_artifact_acquisition_plan_v172_q314.mjs');
if (!q314Verifier.includes(phase)) fail('Q314 verifier must be Q315 successor-aware');
const q314Test = read('test/v172_q314_real_ocr_implementation_readiness_artifact_acquisition_plan_test.dart');
if (!q314Test.includes(phase)) fail('Q314 test must be Q315 successor-aware');
const q313r3Verifier = read('tool/verify_flutter_test_successor_aware_hygiene_repair_v172_q313r3.mjs');
if (!q313r3Verifier.includes(phase)) fail('Q313R3 verifier must be Q315 successor-aware');
const q313r3Test = read('test/v172_q313r3_flutter_test_successor_aware_hygiene_repair_test.dart');
if (!q313r3Test.includes(phase)) fail('Q313R3 test must be Q315 successor-aware');

const changed = read('docs/audit/V172_Q315_CHANGED_FILES.md');
const modifiedAndAddedSections = changed.split('## Protected Runtime Files Not Modified')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','pubspec.yaml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart','graph_card.dart','solution_steps_panel.dart','history_panel.dart','history_controller.dart','math_keyboard.dart','long_press_popup.dart','app_shell.dart','main.dart','gauss_splash_screen.dart']) {
  if (modifiedAndAddedSections.includes(protectedPath)) fail(`Q315 modified/added sections must not list protected runtime file as changed: ${protectedPath}`);
}
const readme = read('README.md');
if (!readme.includes('V172-Q315')) fail('README must mention Q315');
if (!readme.includes('Q316')) fail('README must state Q316 is next runtime dependency feasibility phase');

const pubspec = read('pubspec.yaml');
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden runtime/download dependency added in Q315: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6') || !pubspec.includes('camera_android: 0.10.9+3')) fail('camera dependencies changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must remain absent');

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
  status: 'CONTROLLED_MODEL_ARTIFACT_DOWNLOAD_HASH_CAPTURE_STATIC_READY_LOCAL_HASH_PENDING',
  sourcePhase,
  selectedEngineLabel: q315.selectedEngineLabel,
  publishedInferencePdiparamsSha256: q315.publishedInferencePdiparamsSha256,
  captureState: q315.captureState,
  controlledDownloadPerformedByAssistant: q315.controlledDownloadPerformedByAssistant,
  localArtifactSha256Computed: q315.localArtifactSha256Computed,
  runtimeDependencyAdded: q315.runtimeDependencyAdded,
  ocrPassClaimed: q315.ocrPassClaimed
}, null, 2));
