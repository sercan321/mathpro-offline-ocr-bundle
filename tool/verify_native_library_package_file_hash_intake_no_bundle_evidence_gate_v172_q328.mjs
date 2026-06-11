#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const sourcePhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
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
assert([phase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q328 or Q329 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q328 or Q329 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativeLibraryPackageFileHashIntakeNoBundleEvidenceGateLatestPhase === phase, 'Q328 latest phase key missing');
assert(manifest.nativeLibrarySourcePackageApprovalAbiMatrixLockLatestPhase === sourcePhase, 'Q327 source latest phase key must remain recorded');
assert(manifest.v172Q327NativeLibrarySourcePackageApprovalAbiMatrixLock, 'Q327 source envelope missing');
if (manifest.cameraOcrLatestPhase === q329SuccessorPhase) assert(manifest.v172Q329NativePackageHashEvidenceReviewBinaryBundleApprovalGate, 'Q329 successor envelope missing');
const q328 = manifest.v172Q328NativeLibraryPackageFileHashIntakeNoBundleEvidenceGate;
assert(q328 && q328.phase === phase, 'Q328 manifest envelope missing or wrong phase');
assert(q328.sourcePhase === sourcePhase, 'Q328 sourcePhase mismatch');
assert(q328.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q328 native channel mismatch');
assert(q328.nativeLibraryPackageFileHashIntakeMethod === 'nativeLibraryPackageFileHashIntake', 'Q328 method missing');
assert(q328.nativeLibraryPackageFileHashIntakeStatus === 'NATIVE_LIBRARY_PACKAGE_FILE_HASH_INTAKE_BLOCKED_NO_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF', 'Q328 status mismatch');
assert(q328.selectedRuntimeDependencyCandidate === 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING', 'Q328 selected candidate mismatch');
assert(q328.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q328 external evidence policy mismatch');
assert(q328.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q328 evidence filename mismatch');
assert(Array.isArray(q328.requiredNativePackageFiles) && q328.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q328 required jar missing');
assert(q328.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q328 required arm64 library missing');
assert(Array.isArray(q328.nativePackageHashEvidenceRequirements) && q328.nativePackageHashEvidenceRequirements.includes('capture-sha256-for-PaddlePredictor-jar-and-each-required-so'), 'Q328 SHA evidence requirement missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  runtimeDependencyCoordinateSelectionRecorded: true,
  nativeLibraryBuildTrialPreflightRecorded: true,
  nativeLibrarySourcePackageApprovalRecorded: true,
  abiMatrixLocked: true,
  nativeLibraryPackageHashIntakeMethodAdded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  pubspecChanged: false,
  gradleChanged: false,
  androidManifestChanged: false,
  runtimeDependencyAdded: false,
  perFileSha256EvidenceCaptured: false,
  nativePackageHashEvidenceAccepted: false,
  nativePackageFilesProvidedToProject: false,
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
  modelArtifactAcceptedForRuntime: false,
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
  assert(q328[key] === expected, `Q328 ${key} expected ${expected}, got ${q328[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q328Phase = "${phase}"`), 'MainActivity missing Q328 phase constant');
assert(mainActivity.includes('private val q328NativeLibraryPackageFileHashIntakeFeatureEnabled = false'), 'MainActivity missing Q328 feature flag');
assert(mainActivity.includes('"nativeLibraryPackageFileHashIntake" -> result.success(q328NativeLibraryPackageFileHashIntake(call.method))'), 'MainActivity missing Q328 method channel binding');
assert(mainActivity.includes('private fun q328NativeLibraryPackageFileHashIntake(method: String): Map<String, Any>'), 'MainActivity missing Q328 method implementation');
assert(mainActivity.includes('"nativeLibraryPackageFileHashIntakeBlockedReason" to "q328-requires-external-native-package-file-hashes-before-any-so-jar-aar-or-gradle-bundle"'), 'MainActivity missing Q328 blocked reason');
assert(mainActivity.includes('"externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy'), 'MainActivity missing external evidence policy marker');
assert(mainActivity.includes('"perFileSha256EvidenceCaptured" to false'), 'MainActivity missing Q328 no hash evidence marker');
assert(mainActivity.includes('"nativePackageHashEvidenceAccepted" to false'), 'MainActivity missing Q328 no accepted hash evidence marker');
assert(mainActivity.includes('"PaddlePredictor.jar"'), 'MainActivity missing required jar marker');
assert(mainActivity.includes('"arm64-v8a/libpaddle_lite_jni.so"'), 'MainActivity missing arm64 ABI marker');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q328 must not introduce forbidden runtime marker: ${forbidden}`);
}

const script = read('tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs');
assert(script.includes('../MathProOcrNativePackages/Paddle_Lite_Android'), 'Q328 capture script missing external input-dir policy');
assert(script.includes('PaddlePredictor.jar'), 'Q328 capture script missing jar file');
assert(script.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q328 capture script missing arm64 file');
assert(script.includes('q328_native_library_package_hash_evidence.json'), 'Q328 capture script missing evidence file');
assert(script.includes('refusing to read/write native package evidence inside project root'), 'Q328 capture script must reject project-root evidence writes');

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `pubspec must not include ${forbidden}`);
}
for (const rel of [
  'android/app/src/main/jniLibs',
  'android/app/libs',
]) {
  assert(!exists(rel), `Q328 must not create binary packaging directory ${rel}`);
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
  assert(!file.endsWith('.so') && !file.endsWith('.aar') && !file.endsWith('.jar'), `Q328 must not bundle native binary package artifact: ${file}`);
}
const changed = read('docs/audit/V172_Q328_CHANGED_FILES.md');
assert(changed.includes('Protected Runtime File Intentionally Modified'), 'Q328 changed-files doc must declare protected MainActivity modification');
assert(changed.includes('nativeLibraryPackageFileHashIntake'), 'Q328 changed-files doc must mention nativeLibraryPackageFileHashIntake');
console.log(JSON.stringify({
  phase,
  status: q328.nativeLibraryPackageFileHashIntakeStatus,
  selectedRuntimeDependencyCandidate: q328.selectedRuntimeDependencyCandidate,
  externalNativePackageEvidencePolicy: q328.externalNativePackageEvidencePolicy,
  perFileSha256EvidenceCaptured: q328.perFileSha256EvidenceCaptured,
  nativeLibraryBundled: q328.nativeLibraryBundled,
  jarBundled: q328.jarBundled,
  runtimeDependencyAdded: q328.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q328.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q328.ocrPassClaimed,
}, null, 2));
