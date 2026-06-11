#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const sourcePhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
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
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(full));
    else out.push(full);
  }
  return out;
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([phase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q329 or Q330 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q329 or Q330 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
if (manifest.cameraOcrLatestPhase === q330SuccessorPhase) assert(manifest.v172Q330BinaryBundleTrialJniLibsPaddlePredictorDefaultOff, 'Q330 successor envelope missing');
assert(manifest.nativePackageHashEvidenceReviewBinaryBundleApprovalGateLatestPhase === phase, 'Q329 latest phase key missing');
assert(manifest.nativeLibraryPackageFileHashIntakeNoBundleEvidenceGateLatestPhase === sourcePhase, 'Q328 source latest phase key must remain recorded');
assert(manifest.v172Q328NativeLibraryPackageFileHashIntakeNoBundleEvidenceGate, 'Q328 source envelope missing');
const q329 = manifest.v172Q329NativePackageHashEvidenceReviewBinaryBundleApprovalGate;
assert(q329 && q329.phase === phase, 'Q329 manifest envelope missing or wrong phase');
assert(q329.sourcePhase === sourcePhase, 'Q329 sourcePhase mismatch');
assert(q329.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q329 native channel mismatch');
assert(q329.nativePackageHashEvidenceReviewMethod === 'nativePackageHashEvidenceReview', 'Q329 method missing');
assert(q329.nativePackageHashEvidenceReviewStatus === 'NATIVE_PACKAGE_HASH_EVIDENCE_REVIEW_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF', 'Q329 status mismatch');
assert(q329.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q329 external evidence policy mismatch');
assert(q329.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q329 evidence file mismatch');
assert(Array.isArray(q329.requiredNativePackageFiles) && q329.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q329 required jar missing');
assert(q329.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q329 required arm64 native file missing');
assert(Array.isArray(q329.evidenceReviewRequirements) && q329.evidenceReviewRequirements.includes('verify-required-jar-and-arm64-so-sha256-values-before-bundling'), 'Q329 evidence review requirement missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  runtimeDependencyCoordinateSelectionRecorded: true,
  nativeLibraryBuildTrialPreflightRecorded: true,
  nativeLibrarySourcePackageApprovalRecorded: true,
  nativeLibraryPackageHashIntakeRecorded: true,
  nativePackageHashEvidenceReviewMethodAdded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  perFileSha256EvidenceCaptured: false,
  nativePackageHashEvidenceAccepted: false,
  binaryBundleApproved: false,
  pubspecChanged: false,
  gradleChanged: false,
  androidManifestChanged: false,
  runtimeDependencyAdded: false,
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
  assert(q329[key] === expected, `Q329 ${key} expected ${expected}, got ${q329[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q329Phase = "${phase}"`), 'MainActivity missing Q329 phase constant');
assert(mainActivity.includes('private val q329NativePackageHashEvidenceReviewFeatureEnabled = false'), 'MainActivity missing Q329 feature flag');
assert(mainActivity.includes('"nativePackageHashEvidenceReview" -> result.success(q329NativePackageHashEvidenceReview(call.method))'), 'MainActivity missing Q329 method channel binding');
assert(mainActivity.includes('private fun q329NativePackageHashEvidenceReview(method: String): Map<String, Any>'), 'MainActivity missing Q329 method implementation');
assert(mainActivity.includes('"nativePackageHashEvidenceReviewBlockedReason" to "q329-requires-user-provided-native-package-hash-evidence-before-binary-bundle-approval"'), 'MainActivity missing Q329 blocked reason');
assert(mainActivity.includes('"perFileSha256EvidenceProvidedToAssistant" to false'), 'MainActivity missing Q329 no evidence marker');
assert(mainActivity.includes('"nativePackageHashEvidenceAccepted" to false'), 'MainActivity missing Q329 no accepted evidence marker');
assert(mainActivity.includes('"binaryBundleApproved" to false'), 'MainActivity missing Q329 binary bundle approval block');
assert(mainActivity.includes('"PaddlePredictor.jar"'), 'MainActivity missing required jar marker');
assert(mainActivity.includes('"arm64-v8a/libpaddle_lite_jni.so"'), 'MainActivity missing arm64 marker');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q329 must not introduce forbidden runtime marker: ${forbidden}`);
}

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `pubspec must not include ${forbidden}`);
}
for (const rel of ['android/app/src/main/jniLibs', 'android/app/libs']) {
  assert(!exists(rel), `Q329 must not create binary packaging directory ${rel}`);
}
for (const file of walk(path.join(projectRoot, 'android/app'))) {
  assert(!file.endsWith('.so') && !file.endsWith('.aar') && !file.endsWith('.jar'), `Q329 must not bundle native binary package artifact: ${file}`);
}
const changed = read('docs/audit/V172_Q329_CHANGED_FILES.md');
assert(changed.includes('Protected Runtime File Intentionally Modified'), 'Q329 changed-files doc must declare protected MainActivity modification');
assert(changed.includes('nativePackageHashEvidenceReview'), 'Q329 changed-files doc must mention nativePackageHashEvidenceReview');
console.log(JSON.stringify({
  phase,
  status: q329.nativePackageHashEvidenceReviewStatus,
  externalNativePackageEvidencePolicy: q329.externalNativePackageEvidencePolicy,
  perFileSha256EvidenceProvidedToAssistant: q329.perFileSha256EvidenceProvidedToAssistant,
  nativePackageHashEvidenceAccepted: q329.nativePackageHashEvidenceAccepted,
  binaryBundleApproved: q329.binaryBundleApproved,
  nativeLibraryBundled: q329.nativeLibraryBundled,
  jarBundled: q329.jarBundled,
  runtimeDependencyAdded: q329.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q329.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q329.ocrPassClaimed,
}, null, 2));
