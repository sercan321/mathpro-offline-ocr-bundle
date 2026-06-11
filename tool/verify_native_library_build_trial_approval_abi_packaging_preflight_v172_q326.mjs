#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
const sourcePhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
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
const projectRoot = process.cwd();
function read(rel) { return fs.readFileSync(path.join(projectRoot, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(projectRoot, rel)); }
function fail(message) { console.error(`[${phase}] ${message}`); process.exit(1); }
function assert(condition, message) { if (!condition) fail(message); }
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([phase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q326 or Q327 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q326 or Q327 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativeLibraryBuildTrialApprovalAbiPackagingPreflightLatestPhase === phase, 'Q326 latest phase key missing');
if (manifest.cameraOcrLatestPhase === q327SuccessorPhase) {
  assert(manifest.nativeLibrarySourcePackageApprovalAbiMatrixLockLatestPhase === q327SuccessorPhase, 'Q327 successor latest phase key missing');
  assert(manifest.v172Q327NativeLibrarySourcePackageApprovalAbiMatrixLock, 'Q327 successor envelope missing');
}
assert(manifest.runtimeDependencyCoordinateSelectionBuildTrialGateLatestPhase === sourcePhase, 'Q325 source latest phase key must remain recorded');
assert(manifest.v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate, 'Q325 source envelope missing');
const q326 = manifest.v172Q326NativeLibraryBuildTrialApprovalAbiPackagingPreflight;
assert(q326 && q326.phase === phase, 'Q326 manifest envelope missing or wrong phase');
assert(q326.sourcePhase === sourcePhase, 'Q326 sourcePhase mismatch');
assert(q326.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q326 native channel mismatch');
assert(q326.nativeLibraryBuildTrialPreflightMethod === 'nativeLibraryBuildTrialPreflight', 'Q326 method missing');
assert(q326.nativeLibraryBuildTrialPreflightStatus === 'NATIVE_LIBRARY_BUILD_TRIAL_PREFLIGHT_BLOCKED_NO_NATIVE_LIBRARY_BUNDLE_DEFAULT_OFF', 'Q326 status mismatch');
assert(q326.selectedRuntimeDependencyCandidate === 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING', 'Q326 selected candidate mismatch');
assert(q326.nativeLibrarySourceCandidate === 'PADDLE_LITE_ANDROID_INFERENCE_LIBRARY_DOWNLOAD_OR_BUILD_REQUIRED_NOT_BUNDLED', 'Q326 native library source candidate mismatch');
assert(Array.isArray(q326.abiPackagingCandidates) && q326.abiPackagingCandidates.includes('arm64-v8a-required-candidate'), 'Q326 ABI candidates missing arm64-v8a');
assert(Array.isArray(q326.nativeLibraryCandidatePaths) && q326.nativeLibraryCandidatePaths.includes('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'Q326 candidate jniLibs path missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  runtimeDependencyCoordinateSelectionRecorded: true,
  nativeLibraryBuildTrialPreflightMethodAdded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  pubspecChanged: false,
  gradleChanged: false,
  androidManifestChanged: false,
  runtimeDependencyAdded: false,
  nativeLibraryBundled: false,
  aarBundled: false,
  jniLibsDirectoryCreated: false,
  abiPackagingTrialExecuted: false,
  buildTrialExecuted: false,
  modelConversionExecuted: false,
  nativeModelLoaderAdded: false,
  modelLoaderAvailable: false,
  runtimeStartupExecuted: false,
  dummyRuntimeCallExecuted: false,
  realImageToLatexInferenceExecuted: false,
  editableMathLiveReviewOpened: false,
  workspaceImportExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
})) {
  assert(q326[key] === expected, `Q326 ${key} expected ${expected}, got ${q326[key]}`);
}
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q326Phase = "${phase}"`), 'MainActivity missing Q326 phase constant');
assert(mainActivity.includes('private val q326NativeLibraryBuildTrialPreflightFeatureEnabled = false'), 'MainActivity missing Q326 feature flag');
assert(mainActivity.includes('"nativeLibraryBuildTrialPreflight" -> result.success(q326NativeLibraryBuildTrialPreflight(call.method))'), 'MainActivity missing Q326 method channel binding');
assert(mainActivity.includes('private fun q326NativeLibraryBuildTrialPreflight(method: String): Map<String, Any>'), 'MainActivity missing Q326 method implementation');
assert(mainActivity.includes('"nativeLibraryBuildTrialBlockedReason" to "q326-records-abi-packaging-preflight-but-does-not-bundle-so-aar-or-mutate-gradle"'), 'MainActivity missing Q326 blocked reason');
for (const forbidden of ['System.loadLibrary', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q326 must not introduce forbidden runtime marker: ${forbidden}`);
}
const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `pubspec must not include ${forbidden}`);
}
for (const rel of [
  'android/app/src/main/jniLibs',
  'android/app/libs',
]) {
  assert(!exists(rel), `Q326 must not create binary packaging directory ${rel}`);
}
const androidFiles = [];
function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else androidFiles.push(full);
  }
}
walk(path.join(projectRoot, 'android'));
for (const file of androidFiles) {
  assert(!file.endsWith('.so') && !file.endsWith('.aar'), `Q326 must not bundle native binary artifact: ${file}`);
}
const changed = read('docs/audit/V172_Q326_CHANGED_FILES.md');
assert(changed.includes('Protected Runtime File Intentionally Modified'), 'Q326 changed-files doc must declare protected MainActivity modification');
assert(changed.includes('nativeLibraryBuildTrialPreflight'), 'Q326 changed-files doc must mention nativeLibraryBuildTrialPreflight');
console.log(JSON.stringify({
  phase,
  status: q326.nativeLibraryBuildTrialPreflightStatus,
  selectedRuntimeDependencyCandidate: q326.selectedRuntimeDependencyCandidate,
  nativeLibraryBundled: q326.nativeLibraryBundled,
  abiPackagingTrialExecuted: q326.abiPackagingTrialExecuted,
  runtimeDependencyAdded: q326.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q326.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q326.ocrPassClaimed,
}, null, 2));
