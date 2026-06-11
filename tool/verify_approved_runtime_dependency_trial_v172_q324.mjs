#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const sourcePhase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
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
  try { return fs.readFileSync(file, 'utf8'); } catch (error) { fail(`missing/read error ${file}: ${error.message}`); }
}
function json(file) {
  try { return JSON.parse(read(file)); } catch (error) { fail(`invalid JSON ${file}: ${error.message}`); }
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
if (![phase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase must be Q324 or Q325 successor, got ${manifest.cameraOcrLatestPhase}`);
if (![phase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail(`activeProductDevelopmentLatestPhase must be Q324 or Q325 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
if (manifest.approvedRuntimeDependencyTrialLatestPhase !== phase) fail('latest Q324 marker missing');
if (manifest.cameraOcrLatestPhase === q325SuccessorPhase && !manifest.v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate) fail('Q325 successor envelope missing');
if (manifest.runtimeDependencyModelLoaderDecisionLatestPhase !== sourcePhase) fail('Q323 source latest marker missing');
if (!manifest.v172Q323RuntimeDependencyModelLoaderDecision) fail('Q323 source envelope missing');
const q324 = manifest.v172Q324ApprovedRuntimeDependencyTrial;
if (!q324) fail('Q324 manifest envelope missing');
if (q324.phase !== phase) fail('Q324 manifest phase mismatch');
if (q324.sourcePhase !== sourcePhase) fail('Q324 source phase mismatch');
if (q324.nativeChannelName !== 'mathpro/ocr_runtime_bridge') fail('Q324 native channel mismatch');
if (q324.approvedRuntimeDependencyTrialMethod !== 'approvedRuntimeDependencyTrial') fail('Q324 method mismatch');
if (q324.approvedRuntimeDependencyTrialStatus !== 'APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF') fail('Q324 status mismatch');
if (q324.selectedRuntimeDependency !== 'UNSELECTED_PENDING_BUILD_COMPATIBLE_RUNTIME_COORDINATES') fail('Q324 selected runtime must remain unselected');
if (q324.selectedModelLoader !== 'NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY') fail('Q324 selected model loader must remain none');
if (q324.expectedInferencePdiparamsSha256 !== expectedSha256) fail('Q324 expected SHA mismatch');
if (q324.expectedInferencePdiparamsSizeBytes !== 231675001) fail('Q324 artifact size evidence mismatch');
for (const key of ['q315HashEvidenceProvidedToAssistant','q315Sha256MatchesExpected','q315ArtifactStoredOutsideProjectRoot','q323RuntimeDependencyModelLoaderDecisionAdded','approvedRuntimeDependencyTrialMethodAdded','mainActivityChanged','protectedMainActivityChangeDeclared','methodChannelBindingExtended','approvedRuntimeDependencyTrialDefined']) {
  if (q324[key] !== true) fail(`Q324 ${key} must be true`);
}
for (const key of ['q315RuntimeAccepted','featureFlagDefaultEnabled','q323UserFlutterAnalyzePassed','q323UserFlutterTestPassed','q323UserFlutterRunPassed','pubspecChanged','gradleChanged','androidManifestChanged','runtimeDependencyAdded','approvedRuntimeDependencySelected','paddleRuntimeDependencyAdded','paddleOcrDependencyAdded','onnxRuntimeDependencyAdded','tfliteRuntimeDependencyAdded','downloadDependencyAdded','jniNativeHandlerAdded','nativeModelLoaderAdded','modelBinaryBundledInBaseApp','projectZipContainsModelArtifact','modelArtifactAcceptedForRuntime','modelLoaderAvailable','modelLoadAttempted','modelLoaded','runtimeStartupAttempted','runtimeStartupExecuted','runtimeStartupSmokePassed','dummyRuntimeCallAttempted','dummyRuntimeCallExecuted','dummyRuntimeCallPassed','imageInputAccepted','realImageToLatexInferenceAttempted','realImageToLatexInferenceExecuted','realImageToLatexInferencePassed','editableMathLiveReviewOpened','workspaceImportExecuted','ocrPassClaimed','cameraOcrRuntimePassClaimed','androidRealDevicePassClaimed']) {
  if (q324[key] !== false) fail(`Q324 ${key} must remain false`);
}
for (const field of ['dependencyTrialBlockedReason','approvedRuntimeDependencySelected','modelLoaderAvailable','runtimeDependencyAdded','q323UserFlutterRunPassed']) {
  if (!q324.trialEnvelopeFields.includes(field)) fail(`Q324 envelope field missing: ${field}`);
}
for (const item of ['no-pubspec-gradle-androidmanifest-mutation-in-q324','no-paddle-onnx-tflite-runtime-dependency-in-q324','no-selected-runtime-coordinates-without-user-approval','no-model-loader-binding-in-q324','no-image-to-latex-execution-in-q324']) {
  if (!q324.q324HardBlocks.includes(item)) fail(`Q324 hard block missing: ${item}`);
}
for (const file of [
  'lib/features/camera/gauss_approved_runtime_dependency_trial_q324_policy.dart',
  'lib/features/camera/gauss_approved_runtime_dependency_trial_q324.dart',
  'test/v172_q324_approved_runtime_dependency_trial_test.dart',
  'tool/verify_approved_runtime_dependency_trial_v172_q324.mjs',
  'docs/audit/V172_Q324_APPROVED_RUNTIME_DEPENDENCY_TRIAL_AUDIT.md',
  'docs/audit/V172_Q324_CHANGED_FILES.md'
]) { if (!fs.existsSync(file)) fail(`Q324 file missing: ${file}`); }
const policy = read('lib/features/camera/gauss_approved_runtime_dependency_trial_q324_policy.dart');
for (const marker of [phase, sourcePhase, 'approvedRuntimeDependencyTrial', 'APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF', 'UNSELECTED_PENDING_BUILD_COMPATIBLE_RUNTIME_COORDINATES', expectedSha256]) {
  if (!policy.includes(marker)) fail(`Q324 policy marker missing: ${marker}`);
}
const impl = read('lib/features/camera/gauss_approved_runtime_dependency_trial_q324.dart');
if (!impl.includes('return const GaussApprovedRuntimeDependencyTrialQ324Result(')) fail('Q324 evaluate must return const result envelope');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'private val q324Phase = "V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG"',
  'private val q324ApprovedRuntimeDependencyTrialFeatureEnabled = false',
  'private val q324SelectedRuntimeDependency = "UNSELECTED_PENDING_BUILD_COMPATIBLE_RUNTIME_COORDINATES"',
  '"approvedRuntimeDependencyTrial" -> result.success(q324ApprovedRuntimeDependencyTrial(call.method))',
  'private fun q324ApprovedRuntimeDependencyTrial(method: String): Map<String, Any>',
  '"status" to q324ApprovedRuntimeDependencyTrialStatus',
  '"dependencyTrialBlockedReason" to "q323-user-flutter-run-and-approved-runtime-coordinates-not-yet-provided-in-q324"',
  '"runtimeDependencyAdded" to false',
  '"approvedRuntimeDependencySelected" to false',
  '"modelLoaderAvailable" to false',
  '"modelLoadAttempted" to false',
  '"modelLoaded" to false',
  '"realImageToLatexInferenceExecuted" to false',
  '"ocrPassClaimed" to false'
]) { if (!mainActivity.includes(marker)) fail(`Q324 MainActivity marker missing: ${marker}`); }
for (const forbidden of ['PaddleOCR','PaddleLite','OnnxRuntime','loadModel(','runInference(','JNIEnv','OkHttpClient','DownloadManager']) {
  if (mainActivity.includes(forbidden)) fail(`forbidden runtime/download marker in Q324 MainActivity: ${forbidden}`);
}
const changed = read('docs/audit/V172_Q324_CHANGED_FILES.md');
if (!changed.includes('Protected Runtime File Intentionally Modified')) fail('Q324 changed files must declare intentional MainActivity change');
if (!changed.includes('approved runtime dependency trial envelope method only')) fail('Q324 changed files must explain MainActivity reason');
const audit = read('docs/audit/V172_Q324_APPROVED_RUNTIME_DEPENDENCY_TRIAL_AUDIT.md');
if (!audit.includes('Runtime accepted: `false`')) fail('Q324 audit must keep runtime acceptance false');
if (!audit.includes('APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF')) fail('Q324 audit must disclose blocked status');
const readme = read('README.md');
if (!readme.includes('V172-Q324')) fail('README must mention Q324');
if (!readme.includes('APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF')) fail('README must disclose Q324 blocked status');
const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added in Q324: ${forbidden}`);
}
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
for (const forbidden of ['READ_EXTERNAL_STORAGE','MANAGE_EXTERNAL_STORAGE','FOREGROUND_SERVICE_DATA_SYNC']) {
  if (androidManifest.includes(forbidden)) fail(`forbidden Android permission added in Q324: ${forbidden}`);
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
  status: 'APPROVED_RUNTIME_DEPENDENCY_TRIAL_BOUND_DEFAULT_OFF_NO_DEPENDENCY_ADDED',
  sourcePhase,
  method: q324.approvedRuntimeDependencyTrialMethod,
  selectedRuntimeDependency: q324.selectedRuntimeDependency,
  selectedModelLoader: q324.selectedModelLoader,
  runtimeDependencyAdded: q324.runtimeDependencyAdded,
  approvedRuntimeDependencySelected: q324.approvedRuntimeDependencySelected,
  modelLoaderAvailable: q324.modelLoaderAvailable,
  realImageToLatexInferenceExecuted: q324.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q324.ocrPassClaimed,
  androidRealDevicePassClaimed: q324.androidRealDevicePassClaimed
}, null, 2));
