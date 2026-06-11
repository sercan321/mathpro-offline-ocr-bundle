#!/usr/bin/env node
import fs from 'fs';
import crypto from 'crypto';
import path from 'path';

const phase = 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
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
const sourcePhase = 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR';
const expectedSha256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
const fail = (msg) => { console.error(`[Q316][FAIL] ${msg}`); process.exit(1); };
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
if (![phase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase mismatch: ${manifest.cameraOcrLatestPhase}`);
if (![phase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail('activeProductDevelopmentLatestPhase must point to Q316 or Q317 successor');
if (manifest.runtimeDependencyFeasibilityTrialDefaultOffLatestPhase !== phase) fail('runtimeDependencyFeasibilityTrialDefaultOffLatestPhase must point to Q316');
if (manifest.controlledModelArtifactDownloadHashCaptureLatestPhase !== sourcePhase) fail('Q315R1 latest phase must remain preserved');
if (!manifest.v172Q315ControlledModelArtifactDownloadHashCapture) fail('Q315 envelope missing');
if (!manifest.v172Q315R1ControlledModelArtifactDownloadHashCaptureFlutterTestRepair) fail('Q315R1 envelope missing');
if ([q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q317AndroidNativeBridgeMinimalHealthcheckBehindFlag) fail('Q317 successor envelope missing');
if ([q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q318PrivateModelDownloadStorageRealImplementation) fail('Q318 successor envelope missing');
const q316 = manifest.v172Q316RuntimeDependencyFeasibilityTrialDefaultOff;
if (!q316) fail('Q316 manifest envelope missing');
if (q316.phase !== phase) fail('Q316 phase mismatch');
if (q316.sourcePhase !== sourcePhase) fail('Q316 source phase mismatch');
if (q316.implementationScope !== 'runtime-dependency-feasibility-preflight-only-default-off') fail('implementation scope mismatch');
if (q316.dependencyTrialState !== 'BLOCKED_PENDING_Q315_LOCAL_HASH_EVIDENCE_AND_EXPLICIT_RUNTIME_DEPENDENCY_APPROVAL') fail('dependency trial state mismatch');
if (q316.featureFlagName !== 'gauss.ppFormulaNetS.runtimeDependencyTrial.defaultOff') fail('feature flag mismatch');
if (q316.expectedInferencePdiparamsSha256 !== expectedSha256) fail('expected inference.pdiparams hash mismatch');
if (q316.runtimeDependencyDecision !== 'NO_RUNTIME_DEPENDENCY_ADDED_IN_Q316_STATIC_PREFLIGHT') fail('runtime dependency decision mismatch');
for (const key of ['q315UserSideFlutterAnalyzePassed','q315UserSideFlutterTestPassed','runtimeDependencyTrialDefaultOff','rollbackRequiredBeforeTrial']) {
  if (q316[key] !== true) fail(`Q316 ${key} must be true`);
}
for (const key of [
  'q315LocalArtifactHashEvidenceProvidedToAssistant',
  'explicitRuntimeDependencyApprovalProvided',
  'runtimeFeatureFlagDefaultEnabled',
  'pubspecChanged',
  'gradleChanged',
  'androidManifestChanged',
  'mainActivityChanged',
  'paddleRuntimeDependencyAdded',
  'paddleOcrDependencyAdded',
  'onnxRuntimeDependencyAdded',
  'tfliteRuntimeDependencyAdded',
  'downloadDependencyAdded',
  'methodChannelBindingAdded',
  'jniNativeHandlerAdded',
  'modelBinaryBundledInBaseApp',
  'modelArtifactAcceptedForRuntime',
  'privateStorageImplementationAdded',
  'runtimeStartupExecuted',
  'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted',
  'editableMathLiveReviewOpened',
  'workspaceImportExecuted',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'androidRealDevicePassClaimed'
]) {
  if (q316[key] !== false) fail(`Q316 ${key} must remain false`);
}
for (const item of [
  'paddle-lite-android-or-paddle-inference-android-feasibility-research',
  'onnxruntime-mobile-feasibility-research-if-export-path-exists',
  'tflite-feasibility-research-only-if-model-conversion-is-proven'
]) {
  if (!q316.candidateRuntimePaths.includes(item)) fail(`missing candidate runtime path: ${item}`);
}
for (const item of [
  'q315-local-artifact-sha256-evidence-matches-published-hash',
  'explicit-user-approval-before-pubspec-or-gradle-mutation',
  'runtime-dependency-must-remain-default-off',
  'rollback-plan-before-any-android-build-system-change'
]) {
  if (!q316.q316DependencyTrialPreconditions.includes(item)) fail(`missing Q316 precondition: ${item}`);
}
for (const item of [
  'no-pubspec-change-without-q315-hash-evidence',
  'no-gradle-change-without-explicit-runtime-dependency-approval',
  'no-mainactivity-methodchannel-binding-in-q316',
  'no-model-binary-in-base-app-or-delivery-zip',
  'no-direct-ocr-to-workspace-or-solve-graph-solution-history'
]) {
  if (!q316.q316HardBlocks.includes(item)) fail(`missing Q316 hard block: ${item}`);
}
for (const item of [
  'q315-hash-capture-evidence-json-provided-and-matches-expected-sha256',
  'chosen-runtime-dependency-is-explicitly-approved',
  'feature-flag-default-off-remains-enforced',
  'flutter-analyze-and-test-clean-after-q316'
]) {
  if (!q316.q317EntryCriteria.includes(item)) fail(`missing Q317 entry criterion: ${item}`);
}

for (const file of [
  'lib/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316_policy.dart',
  'lib/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316.dart',
  'test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart',
  'tool/verify_runtime_dependency_feasibility_trial_default_off_v172_q316.mjs',
  'docs/audit/V172_Q316_RUNTIME_DEPENDENCY_FEASIBILITY_TRIAL_DEFAULT_OFF_AUDIT.md',
  'docs/audit/V172_Q316_CHANGED_FILES.md'
]) {
  if (!fs.existsSync(file)) fail(`Q316 file missing: ${file}`);
}
const policy = read('lib/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316_policy.dart');
for (const marker of [phase, sourcePhase, 'NO_RUNTIME_DEPENDENCY_ADDED_IN_Q316_STATIC_PREFLIGHT', 'gauss.ppFormulaNetS.runtimeDependencyTrial.defaultOff', 'q315-local-artifact-sha256-evidence-matches-published-hash']) {
  if (!policy.includes(marker)) fail(`Q316 policy marker missing: ${marker}`);
}
const impl = read('lib/features/camera/gauss_runtime_dependency_feasibility_trial_default_off_q316.dart');
if (!impl.includes('return const GaussRuntimeDependencyFeasibilityTrialDefaultOffQ316Result(')) fail('Q316 evaluate must return a const result envelope');
const test = read('test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart');
if (!test.includes('runtimeFeatureFlagDefaultEnabled, isFalse')) fail('Q316 test must assert feature flag remains default-off');
if (!test.includes('no-pubspec-change-without-q315-hash-evidence')) fail('Q316 test must assert no-pubspec-change hard block');

const q315r1Test = read('test/v172_q315r1_controlled_model_artifact_download_hash_capture_flutter_test_repair_test.dart');
if (!q315r1Test.includes(phase)) fail('Q315R1 flutter test must accept Q316 successor');
if (!q315r1Test.includes(q317SuccessorPhase)) fail('Q315R1 flutter test must accept Q317 successor');
if (!q315r1Test.includes(q318SuccessorPhase)) fail('Q315R1 flutter test must accept Q318 successor');
if (!q315r1Test.includes(q319SuccessorPhase)) fail('Q315R1 flutter test must accept Q319 successor');
const q315Test = read('test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart');
if (!q315Test.includes(phase)) fail('Q315 flutter test must accept Q316 successor');
if (!q315Test.includes(q317SuccessorPhase)) fail('Q315 flutter test must accept Q317 successor');
if (!q315Test.includes(q318SuccessorPhase)) fail('Q315 flutter test must accept Q318 successor');
if (!q315Test.includes(q319SuccessorPhase)) fail('Q315 flutter test must accept Q319 successor');
const q314Test = read('test/v172_q314_real_ocr_implementation_readiness_artifact_acquisition_plan_test.dart');
if (!q314Test.includes(phase)) fail('Q314 flutter test must accept Q316 successor');
if (!q314Test.includes(q317SuccessorPhase)) fail('Q314 flutter test must accept Q317 successor');
if (!q314Test.includes(q318SuccessorPhase)) fail('Q314 flutter test must accept Q318 successor');
if (!q314Test.includes(q319SuccessorPhase)) fail('Q314 flutter test must accept Q319 successor');
const q313r3Test = read('test/v172_q313r3_flutter_test_successor_aware_hygiene_repair_test.dart');
if (!q313r3Test.includes(phase)) fail('Q313R3 flutter test must accept Q316 successor');
if (!q313r3Test.includes(q317SuccessorPhase)) fail('Q313R3 flutter test must accept Q317 successor');
if (!q313r3Test.includes(q318SuccessorPhase)) fail('Q313R3 flutter test must accept Q318 successor');
if (!q313r3Test.includes(q319SuccessorPhase)) fail('Q313R3 flutter test must accept Q319 successor');

const changed = read('docs/audit/V172_Q316_CHANGED_FILES.md');
const modifiedAndAddedSections = changed.split('## Protected Runtime Files Not Modified')[0];
for (const protectedPath of ['pubspec.yaml','android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt','android/app/src/main/AndroidManifest.xml','assets/mathlive/mathlive_prod_bridge.js','lib/features/mathlive/mathlive_production_editor_surface.dart','lib/features/workspace/workspace_panel.dart','lib/features/camera/gauss_camera_capture_shell.dart','lib/features/keyboard/math_keyboard.dart','lib/features/keyboard/long_press_popup.dart','lib/features/graph/graph_card.dart','lib/features/solution/solution_steps_panel.dart','lib/features/history/history_panel.dart','app_shell.dart','main.dart','gauss_splash_screen.dart']) {
  if (modifiedAndAddedSections.includes(protectedPath)) fail(`Q316 modified/added sections must not list protected runtime file as changed: ${protectedPath}`);
}
const readme = read('README.md');
if (!readme.includes('V172-Q316')) fail('README must mention Q316');
if (!readme.includes('NO_RUNTIME_DEPENDENCY_ADDED_IN_Q316_STATIC_PREFLIGHT')) fail('README must disclose no runtime dependency added');

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added in Q316: ${forbidden}`);
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
  status: 'RUNTIME_DEPENDENCY_FEASIBILITY_PREFLIGHT_READY_DEFAULT_OFF_NO_DEPENDENCY_ADDED',
  sourcePhase,
  dependencyTrialState: q316.dependencyTrialState,
  runtimeDependencyDecision: q316.runtimeDependencyDecision,
  q315LocalArtifactHashEvidenceProvidedToAssistant: q316.q315LocalArtifactHashEvidenceProvidedToAssistant,
  explicitRuntimeDependencyApprovalProvided: q316.explicitRuntimeDependencyApprovalProvided,
  pubspecChanged: q316.pubspecChanged,
  gradleChanged: q316.gradleChanged,
  methodChannelBindingAdded: q316.methodChannelBindingAdded,
  ocrPassClaimed: q316.ocrPassClaimed
}, null, 2));
