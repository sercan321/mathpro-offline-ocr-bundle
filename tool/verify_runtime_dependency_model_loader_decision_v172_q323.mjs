#!/usr/bin/env node
import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
const sourcePhase = 'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE';
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
if (![phase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase must be Q323 or Q324 successor, got ${manifest.cameraOcrLatestPhase}`);
if (![phase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail(`activeProductDevelopmentLatestPhase must be Q323 or Q324 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
if (manifest.runtimeDependencyModelLoaderDecisionLatestPhase !== phase) fail('latest Q323 marker missing');
if ([q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q324ApprovedRuntimeDependencyTrial) fail('Q324 successor envelope missing');
if (manifest.firstImageToLatexInferenceLatestPhase !== sourcePhase) fail('Q322 source latest marker missing');
if (!manifest.v172Q322FirstImageToLatexInferenceEnvelope) fail('Q322 source envelope missing');
const q323 = manifest.v172Q323RuntimeDependencyModelLoaderDecision;
if (!q323) fail('Q323 manifest envelope missing');
if (q323.phase !== phase) fail('Q323 manifest phase mismatch');
if (q323.sourcePhase !== sourcePhase) fail('Q323 source phase mismatch');
if (q323.nativeChannelName !== 'mathpro/ocr_runtime_bridge') fail('Q323 native channel mismatch');
if (q323.runtimeDependencyModelLoaderDecisionMethod !== 'runtimeDependencyModelLoaderDecision') fail('Q323 method mismatch');
if (q323.runtimeDependencyModelLoaderDecisionStatus !== 'RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF') fail('Q323 status mismatch');
if (q323.selectedRuntimeDependency !== 'UNSELECTED_PENDING_APPROVED_ANDROID_COMPATIBLE_RUNTIME_EVIDENCE') fail('Q323 selected runtime must remain unselected');
if (q323.selectedModelLoader !== 'NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY') fail('Q323 selected model loader must remain none');
if (q323.expectedInferencePdiparamsSha256 !== expectedSha256) fail('Q323 expected SHA mismatch');
if (q323.expectedInferencePdiparamsSizeBytes !== 231675001) fail('Q323 artifact size evidence mismatch');
for (const key of ['q315HashEvidenceProvidedToAssistant','q315Sha256MatchesExpected','q315ArtifactStoredOutsideProjectRoot','q319VerifiedArtifactLoadSmokeAdded','q320RuntimeStartupSmokeAdded','q321DummyRuntimeCallMethodAdded','q322FirstImageToLatexInferenceMethodAdded','runtimeDependencyModelLoaderDecisionMethodAdded','mainActivityChanged','protectedMainActivityChangeDeclared','methodChannelBindingExtended']) {
  if (q323[key] !== true) fail(`Q323 ${key} must be true`);
}
for (const key of ['q315RuntimeAccepted','featureFlagDefaultEnabled','pubspecChanged','gradleChanged','androidManifestChanged','runtimeDependencyAdded','approvedRuntimeDependencySelected','paddleRuntimeDependencyAdded','paddleOcrDependencyAdded','onnxRuntimeDependencyAdded','tfliteRuntimeDependencyAdded','downloadDependencyAdded','jniNativeHandlerAdded','nativeModelLoaderAdded','modelBinaryBundledInBaseApp','projectZipContainsModelArtifact','modelArtifactAcceptedForRuntime','modelLoaderAvailable','modelLoadAttempted','modelLoaded','runtimeStartupAttempted','runtimeStartupExecuted','runtimeStartupSmokePassed','dummyRuntimeCallAttempted','dummyRuntimeCallExecuted','dummyRuntimeCallPassed','imageInputAccepted','realImageToLatexInferenceAttempted','realImageToLatexInferenceExecuted','realImageToLatexInferencePassed','editableMathLiveReviewOpened','workspaceImportExecuted','ocrPassClaimed','cameraOcrRuntimePassClaimed','androidRealDevicePassClaimed']) {
  if (q323[key] !== false) fail(`Q323 ${key} must remain false`);
}
for (const field of ['dependencyDecisionBlockedReason','approvedRuntimeDependencySelected','modelLoaderAvailable','modelLoadAttempted','modelLoaded','runtimeDependencyAdded']) {
  if (!q323.decisionEnvelopeFields.includes(field)) fail(`Q323 envelope field missing: ${field}`);
}
for (const item of ['no-pubspec-gradle-androidmanifest-mutation-in-q323','no-paddle-onnx-tflite-runtime-dependency-in-q323','no-model-loader-binding-in-q323','no-runtime-startup-or-dummy-call-execution-in-q323','no-image-to-latex-execution-in-q323']) {
  if (!q323.q323HardBlocks.includes(item)) fail(`Q323 hard block missing: ${item}`);
}
for (const file of [
  'lib/features/camera/gauss_runtime_dependency_model_loader_decision_q323_policy.dart',
  'lib/features/camera/gauss_runtime_dependency_model_loader_decision_q323.dart',
  'test/v172_q323_runtime_dependency_model_loader_decision_test.dart',
  'tool/verify_runtime_dependency_model_loader_decision_v172_q323.mjs',
  'docs/audit/V172_Q323_RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_AUDIT.md',
  'docs/audit/V172_Q323_CHANGED_FILES.md'
]) { if (!fs.existsSync(file)) fail(`Q323 file missing: ${file}`); }
const policy = read('lib/features/camera/gauss_runtime_dependency_model_loader_decision_q323_policy.dart');
for (const marker of [phase, sourcePhase, 'runtimeDependencyModelLoaderDecision', 'RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF', 'UNSELECTED_PENDING_APPROVED_ANDROID_COMPATIBLE_RUNTIME_EVIDENCE', expectedSha256]) {
  if (!policy.includes(marker)) fail(`Q323 policy marker missing: ${marker}`);
}
const impl = read('lib/features/camera/gauss_runtime_dependency_model_loader_decision_q323.dart');
if (!impl.includes('return const GaussRuntimeDependencyModelLoaderDecisionQ323Result(')) fail('Q323 evaluate must return const result envelope');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'private val q323Phase = "V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION"',
  'private val q323RuntimeDependencyDecisionFeatureEnabled = false',
  'private val q323SelectedRuntimeDependency = "UNSELECTED_PENDING_APPROVED_ANDROID_COMPATIBLE_RUNTIME_EVIDENCE"',
  '"runtimeDependencyModelLoaderDecision" -> result.success(q323RuntimeDependencyModelLoaderDecision(call.method))',
  'private fun q323RuntimeDependencyModelLoaderDecision(method: String): Map<String, Any>',
  '"status" to "RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF"',
  '"dependencyDecisionBlockedReason" to "approved-android-compatible-runtime-dependency-not-yet-selected-in-q323"',
  '"runtimeDependencyAdded" to false',
  '"approvedRuntimeDependencySelected" to false',
  '"modelLoaderAvailable" to false',
  '"modelLoadAttempted" to false',
  '"modelLoaded" to false',
  '"realImageToLatexInferenceExecuted" to false',
  '"ocrPassClaimed" to false'
]) { if (!mainActivity.includes(marker)) fail(`Q323 MainActivity marker missing: ${marker}`); }
for (const forbidden of ['PaddleOCR','PaddleLite','OnnxRuntime','loadModel(','runInference(','JNIEnv','OkHttpClient','DownloadManager']) {
  if (mainActivity.includes(forbidden)) fail(`forbidden runtime/download marker in Q323 MainActivity: ${forbidden}`);
}
const changed = read('docs/audit/V172_Q323_CHANGED_FILES.md');
if (!changed.includes('Protected Runtime File Intentionally Modified')) fail('Q323 changed files must declare intentional MainActivity change');
if (!changed.includes('runtime dependency/model loader decision envelope method only')) fail('Q323 changed files must explain MainActivity reason');
const audit = read('docs/audit/V172_Q323_RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_AUDIT.md');
if (!audit.includes('Runtime accepted: `false`')) fail('Q323 audit must keep runtime acceptance false');
if (!audit.includes('RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF')) fail('Q323 audit must disclose blocked status');
const readme = read('README.md');
if (!readme.includes('V172-Q323')) fail('README must mention Q323');
if (!readme.includes('RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF')) fail('README must disclose Q323 blocked status');
const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added in Q323: ${forbidden}`);
}
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
for (const forbidden of ['READ_EXTERNAL_STORAGE','MANAGE_EXTERNAL_STORAGE','FOREGROUND_SERVICE_DATA_SYNC']) {
  if (androidManifest.includes(forbidden)) fail(`forbidden Android permission added in Q323: ${forbidden}`);
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
  status: 'RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BOUND_DEFAULT_OFF_NO_DEPENDENCY_ADDED',
  sourcePhase,
  method: q323.runtimeDependencyModelLoaderDecisionMethod,
  selectedRuntimeDependency: q323.selectedRuntimeDependency,
  selectedModelLoader: q323.selectedModelLoader,
  runtimeDependencyAdded: q323.runtimeDependencyAdded,
  approvedRuntimeDependencySelected: q323.approvedRuntimeDependencySelected,
  modelLoaderAvailable: q323.modelLoaderAvailable,
  modelLoaded: q323.modelLoaded,
  realImageToLatexInferenceExecuted: q323.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q323.ocrPassClaimed,
  androidRealDevicePassClaimed: q323.androidRealDevicePassClaimed
}, null, 2));
