#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const sourcePhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
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
assert([phase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q327 or Q328 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q327 or Q328 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativeLibrarySourcePackageApprovalAbiMatrixLockLatestPhase === phase, 'Q327 latest phase key missing');
assert(manifest.nativeLibraryBuildTrialApprovalAbiPackagingPreflightLatestPhase === sourcePhase, 'Q326 source latest phase key must remain recorded');
assert(manifest.v172Q326NativeLibraryBuildTrialApprovalAbiPackagingPreflight, 'Q326 source envelope missing');
const q327 = manifest.v172Q327NativeLibrarySourcePackageApprovalAbiMatrixLock;
assert(q327 && q327.phase === phase, 'Q327 manifest envelope missing or wrong phase');
assert(q327.sourcePhase === sourcePhase, 'Q327 sourcePhase mismatch');
if (manifest.cameraOcrLatestPhase === q328SuccessorPhase) assert(manifest.v172Q328NativeLibraryPackageFileHashIntakeNoBundleEvidenceGate, 'Q328 successor envelope missing');
assert(q327.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q327 native channel mismatch');
assert(q327.nativeLibrarySourcePackageApprovalMethod === 'nativeLibrarySourcePackageApproval', 'Q327 method missing');
assert(q327.nativeLibrarySourcePackageApprovalStatus === 'NATIVE_LIBRARY_SOURCE_PACKAGE_APPROVAL_ABI_MATRIX_LOCKED_NO_BINARY_BUNDLE_DEFAULT_OFF', 'Q327 status mismatch');
assert(q327.selectedRuntimeDependencyCandidate === 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING', 'Q327 selected candidate mismatch');
assert(q327.approvedNativeLibrarySourcePackage === 'PADDLE_LITE_ANDROID_PREDICTION_LIBRARY_RELEASE_OR_SELF_COMPILED_PACKAGE_PENDING_USER_APPROVAL', 'Q327 source package candidate mismatch');
assert(Array.isArray(q327.requiredNativeLibraryFiles) && q327.requiredNativeLibraryFiles.includes('PaddlePredictor.jar'), 'Q327 required jar missing');
assert(q327.requiredNativeLibraryFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q327 required arm64 library missing');
assert(Array.isArray(q327.abiMatrix) && q327.abiMatrix.includes('arm64-v8a-required'), 'Q327 ABI matrix missing arm64-v8a');
assert(Array.isArray(q327.nativeLibraryCandidatePaths) && q327.nativeLibraryCandidatePaths.includes('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'Q327 candidate jniLibs path missing');
assert(q327.jarCandidatePath === 'android/app/libs/PaddlePredictor.jar', 'Q327 jar candidate path mismatch');
assert(Array.isArray(q327.sourcePackageEvidenceRequirements) && q327.sourcePackageEvidenceRequirements.includes('per-file-sha256-for-jar-and-each-so-before-commit'), 'Q327 source evidence requirements missing SHA gate');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  runtimeDependencyCoordinateSelectionRecorded: true,
  nativeLibraryBuildTrialPreflightRecorded: true,
  nativeLibrarySourcePackageApprovalMethodAdded: true,
  abiMatrixLocked: true,
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
  jarBundled: false,
  jniLibsDirectoryCreated: false,
  androidAppLibsDirectoryCreated: false,
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
  storeReadyPassClaimed: false,
  releasePassClaimed: false,
})) {
  assert(q327[key] === expected, `Q327 ${key} expected ${expected}, got ${q327[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q327Phase = "${phase}"`), 'MainActivity missing Q327 phase constant');
assert(mainActivity.includes('private val q327NativeLibrarySourcePackageApprovalFeatureEnabled = false'), 'MainActivity missing Q327 feature flag');
assert(mainActivity.includes('"nativeLibrarySourcePackageApproval" -> result.success(q327NativeLibrarySourcePackageApproval(call.method))'), 'MainActivity missing Q327 method channel binding');
assert(mainActivity.includes('private fun q327NativeLibrarySourcePackageApproval(method: String): Map<String, Any>'), 'MainActivity missing Q327 method implementation');
assert(mainActivity.includes('"nativeLibrarySourcePackageApprovalBlockedReason" to "q327-locks-source-package-and-abi-matrix-but-does-not-bundle-so-aar-jar-or-mutate-gradle"'), 'MainActivity missing Q327 blocked reason');
assert(mainActivity.includes('"PaddlePredictor.jar"'), 'MainActivity missing required jar marker');
assert(mainActivity.includes('"arm64-v8a/libpaddle_lite_jni.so"'), 'MainActivity missing arm64 ABI marker');
assert(mainActivity.includes('"abiMatrixLocked" to true'), 'MainActivity missing ABI matrix lock marker');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q327 must not introduce forbidden runtime marker: ${forbidden}`);
}

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `pubspec must not include ${forbidden}`);
}
for (const rel of [
  'android/app/src/main/jniLibs',
  'android/app/libs',
]) {
  assert(!exists(rel), `Q327 must not create binary packaging directory ${rel}`);
}
const androidFiles = [];
function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else androidFiles.push(full);
  }
}
walk(path.join(projectRoot, 'android/app'));
for (const file of androidFiles) {
  assert(!file.endsWith('.so') && !file.endsWith('.aar') && !file.endsWith('.jar'), `Q327 must not bundle native binary package artifact: ${file}`);
}
const changed = read('docs/audit/V172_Q327_CHANGED_FILES.md');
assert(changed.includes('Protected Runtime File Intentionally Modified'), 'Q327 changed-files doc must declare protected MainActivity modification');
assert(changed.includes('nativeLibrarySourcePackageApproval'), 'Q327 changed-files doc must mention nativeLibrarySourcePackageApproval');
console.log(JSON.stringify({
  phase,
  status: q327.nativeLibrarySourcePackageApprovalStatus,
  selectedRuntimeDependencyCandidate: q327.selectedRuntimeDependencyCandidate,
  requiredPrimaryAbi: q327.requiredPrimaryAbi,
  nativeLibraryBundled: q327.nativeLibraryBundled,
  jarBundled: q327.jarBundled,
  abiMatrixLocked: q327.abiMatrixLocked,
  runtimeDependencyAdded: q327.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q327.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q327.ocrPassClaimed,
}, null, 2));
