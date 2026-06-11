#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
const sourcePhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
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
if (![phase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase must be Q325 or Q326 successor, got ${manifest.cameraOcrLatestPhase}`);
if (![phase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail(`activeProductDevelopmentLatestPhase must be Q325 or Q326 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
if (manifest.runtimeDependencyCoordinateSelectionBuildTrialGateLatestPhase !== phase) fail('latest Q325 marker missing');
if (manifest.cameraOcrLatestPhase === q326SuccessorPhase && !manifest.v172Q326NativeLibraryBuildTrialApprovalAbiPackagingPreflight) fail('Q326 successor envelope missing');
if (manifest.approvedRuntimeDependencyTrialLatestPhase !== sourcePhase) fail('Q324 source latest marker missing');
if (!manifest.v172Q324ApprovedRuntimeDependencyTrial) fail('Q324 source envelope missing');
const q325 = manifest.v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate;
if (!q325) fail('Q325 manifest envelope missing');
if (q325.phase !== phase) fail('Q325 manifest phase mismatch');
if (q325.sourcePhase !== sourcePhase) fail('Q325 source phase mismatch');
if (q325.nativeChannelName !== 'mathpro/ocr_runtime_bridge') fail('Q325 native channel mismatch');
if (q325.runtimeDependencyCoordinateSelectionMethod !== 'runtimeDependencyCoordinateSelection') fail('Q325 method mismatch');
if (q325.runtimeDependencyCoordinateSelectionStatus !== 'RUNTIME_DEPENDENCY_COORDINATE_SELECTION_RECORDED_BUILD_TRIAL_BLOCKED_NO_GRADLE_MUTATION_DEFAULT_OFF') fail('Q325 status mismatch');
if (q325.selectedRuntimeDependencyCandidate !== 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING') fail('Q325 runtime candidate mismatch');
if (q325.selectedModelLoaderCandidate !== 'PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE') fail('Q325 model loader candidate mismatch');
if (q325.selectedRuntimeDependencyCoordinate !== 'NO_MAVEN_COORDINATE_SELECTED_MANUAL_NATIVE_LIBRARY_TRIAL_REQUIRED') fail('Q325 runtime coordinate state mismatch');
if (q325.expectedInferencePdiparamsSha256 !== expectedSha256) fail('Q325 expected SHA mismatch');
if (q325.expectedInferencePdiparamsSizeBytes !== 231675001) fail('Q325 artifact size evidence mismatch');
for (const key of ['q315HashEvidenceProvidedToAssistant','q315Sha256MatchesExpected','q315ArtifactStoredOutsideProjectRoot','q324ApprovedRuntimeDependencyTrialDefined','runtimeDependencyCoordinateSelectionMethodAdded','mainActivityChanged','protectedMainActivityChangeDeclared','methodChannelBindingExtended','runtimeDependencyCoordinateSelected']) {
  if (q325[key] !== true) fail(`Q325 ${key} must be true`);
}
for (const key of ['q315RuntimeAccepted','featureFlagDefaultEnabled','pubspecChanged','gradleChanged','androidManifestChanged','runtimeDependencyAdded','approvedRuntimeDependencySelected','paddleRuntimeDependencyAdded','paddleOcrDependencyAdded','onnxRuntimeDependencyAdded','tfliteRuntimeDependencyAdded','downloadDependencyAdded','jniNativeHandlerAdded','nativeLibraryBundled','nativeModelLoaderAdded','buildTrialExecuted','buildTrialPassed','modelBinaryBundledInBaseApp','projectZipContainsModelArtifact','modelArtifactAcceptedForRuntime','modelLoaderAvailable','modelLoadAttempted','modelLoaded','runtimeStartupAttempted','runtimeStartupExecuted','runtimeStartupSmokePassed','dummyRuntimeCallAttempted','dummyRuntimeCallExecuted','dummyRuntimeCallPassed','imageInputAccepted','realImageToLatexInferenceAttempted','realImageToLatexInferenceExecuted','realImageToLatexInferencePassed','editableMathLiveReviewOpened','workspaceImportExecuted','ocrPassClaimed','cameraOcrRuntimePassClaimed','androidRealDevicePassClaimed']) {
  if (q325[key] !== false) fail(`Q325 ${key} must remain false`);
}
for (const field of ['selectedRuntimeDependencyCandidate','selectedModelLoaderCandidate','selectedRuntimeDependencyCoordinate','coordinateSelectionReason','buildTrialBlockedReason','runtimeDependencyCoordinateSelected','buildTrialExecuted','nativeLibraryBundled']) {
  if (!q325.buildTrialEnvelopeFields.includes(field)) fail(`Q325 envelope field missing: ${field}`);
}
for (const item of ['no-pubspec-gradle-androidmanifest-mutation-in-q325','no-native-library-or-aar-bundling-in-q325','no-runtime-startup-or-model-loader-binding-in-q325','no-image-to-latex-execution-in-q325']) {
  if (!q325.q325HardBlocks.includes(item)) fail(`Q325 hard block missing: ${item}`);
}
for (const file of [
  'lib/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325_policy.dart',
  'lib/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325.dart',
  'test/v172_q325_runtime_dependency_coordinate_selection_build_trial_gate_test.dart',
  'tool/verify_runtime_dependency_coordinate_selection_build_trial_gate_v172_q325.mjs',
  'docs/audit/V172_Q325_RUNTIME_DEPENDENCY_COORDINATE_SELECTION_BUILD_TRIAL_GATE_AUDIT.md',
  'docs/audit/V172_Q325_CHANGED_FILES.md'
]) { if (!fs.existsSync(file)) fail(`Q325 file missing: ${file}`); }
const policy = read('lib/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325_policy.dart');
for (const marker of [phase, sourcePhase, 'runtimeDependencyCoordinateSelection', 'RUNTIME_DEPENDENCY_COORDINATE_SELECTION_RECORDED_BUILD_TRIAL_BLOCKED_NO_GRADLE_MUTATION_DEFAULT_OFF', 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING', expectedSha256]) {
  if (!policy.includes(marker)) fail(`Q325 policy marker missing: ${marker}`);
}
const impl = read('lib/features/camera/gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325.dart');
if (!impl.includes('return const GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Result(')) fail('Q325 evaluate must return const result envelope');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'private val q325Phase = "V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE"',
  'private val q325RuntimeDependencyCoordinateSelectionFeatureEnabled = false',
  'private val q325SelectedRuntimeDependencyCandidate = "PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING"',
  'private val q325SelectedRuntimeDependencyCoordinate = "NO_MAVEN_COORDINATE_SELECTED_MANUAL_NATIVE_LIBRARY_TRIAL_REQUIRED"',
  '"runtimeDependencyCoordinateSelection" -> result.success(q325RuntimeDependencyCoordinateSelection(call.method))',
  'private fun q325RuntimeDependencyCoordinateSelection(method: String): Map<String, Any>',
  '"status" to q325RuntimeDependencyCoordinateSelectionStatus',
  '"buildTrialBlockedReason" to "q325-records-explicit-candidate-but-does-not-mutate-gradle-or-bundle-native-library"',
  '"runtimeDependencyAdded" to false',
  '"runtimeDependencyCoordinateSelected" to true',
  '"nativeLibraryBundled" to false',
  '"buildTrialExecuted" to false',
  '"modelLoaderAvailable" to false',
  '"realImageToLatexInferenceExecuted" to false',
  '"ocrPassClaimed" to false'
]) { if (!mainActivity.includes(marker)) fail(`Q325 MainActivity marker missing: ${marker}`); }
for (const forbidden of ['PaddleOCR','PaddleLite','OnnxRuntime','loadModel(','runInference(','JNIEnv','OkHttpClient','DownloadManager']) {
  if (mainActivity.includes(forbidden)) fail(`forbidden runtime/download marker in Q325 MainActivity: ${forbidden}`);
}
const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr','paddle_lite','onnxruntime','tflite_flutter']) {
  if (pubspec.includes(forbidden)) fail(`forbidden dependency marker in pubspec: ${forbidden}`);
}
const changed = read('docs/audit/V172_Q325_CHANGED_FILES.md');
if (!changed.includes('Protected Runtime File Intentionally Modified')) fail('Q325 changed files must declare intentional MainActivity change');
if (!changed.includes('runtimeDependencyCoordinateSelection')) fail('Q325 changed files must explain MainActivity reason');
const audit = read('docs/audit/V172_Q325_RUNTIME_DEPENDENCY_COORDINATE_SELECTION_BUILD_TRIAL_GATE_AUDIT.md');
if (!audit.includes('Runtime accepted: `false`')) fail('Q325 audit must keep runtime acceptance false');
if (!audit.includes('PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING')) fail('Q325 audit must disclose candidate');
const readme = read('README.md');
if (!readme.includes('V172-Q325')) fail('README Q325 section missing');
const allFiles = walk('.').filter(file => !file.includes('/build/') && !file.includes('/.dart_tool/'));
for (const file of allFiles) {
  if (/\.(pdiparams|pdmodel|onnx|tflite|nb|aar|so)$/i.test(file)) fail(`model/native runtime artifact must not be committed: ${file}`);
}
console.log(JSON.stringify({
  phase,
  status: q325.runtimeDependencyCoordinateSelectionStatus,
  selectedRuntimeDependencyCandidate: q325.selectedRuntimeDependencyCandidate,
  selectedRuntimeDependencyCoordinate: q325.selectedRuntimeDependencyCoordinate,
  runtimeDependencyAdded: q325.runtimeDependencyAdded,
  buildTrialExecuted: q325.buildTrialExecuted,
  nativeLibraryBundled: q325.nativeLibraryBundled,
  realImageToLatexInferenceExecuted: q325.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q325.ocrPassClaimed
}, null, 2));
