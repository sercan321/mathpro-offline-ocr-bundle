#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
const q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const sourcePhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
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
assert([phase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q333/Q334/Q335 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q333/Q334/Q335 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativePackageHashEvidenceIntakeRealBundlePermissionReviewLatestPhase === phase, 'Q333 latest phase key missing');
if ([q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) assert(manifest.v172Q334ActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGate, 'Q334 successor envelope missing');
assert(manifest.actualBinaryBundleJniLibsPaddlePredictorBlockedGateLatestPhase === sourcePhase, 'Q332 source latest phase key must remain recorded');
assert(manifest.v172Q332ActualBinaryBundleJniLibsPaddlePredictorBlockedGate, 'Q332 source envelope missing');
const q333 = manifest.v172Q333NativePackageHashEvidenceIntakeRealBundlePermissionReview;
assert(q333 && q333.phase === phase, 'Q333 manifest envelope missing or wrong phase');
assert(q333.sourcePhase === sourcePhase, 'Q333 sourcePhase mismatch');
assert(q333.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q333 native channel mismatch');
assert(q333.nativePackageHashEvidenceIntakeReviewMethod === 'nativePackageHashEvidenceIntakeReview', 'Q333 method missing');
assert(q333.nativePackageHashEvidenceIntakeReviewStatus === 'NATIVE_PACKAGE_HASH_EVIDENCE_INTAKE_REVIEW_BLOCKED_PENDING_Q328_EVIDENCE_JSON_AND_EXPLICIT_USER_BUNDLE_APPROVAL_DEFAULT_OFF', 'Q333 status mismatch');
assert(q333.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q333 external evidence policy mismatch');
assert(q333.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q333 evidence file mismatch');
assert(Array.isArray(q333.requiredNativePackageFiles) && q333.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q333 required jar missing');
assert(q333.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q333 required arm64 library missing');
assert(q333.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q333 planned jar target missing');
assert(q333.plannedBundleTargets.includes('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'Q333 planned arm64 target missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  q332ActualBinaryBundleGateRecorded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  nativePackageHashEvidenceReviewed: false,
  requiredNativePackageHashEvidenceAccepted: false,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  binaryBundlePermissionGranted: false,
  binaryBundleApproved: false,
  actualBinaryBundleExecuted: false,
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
  systemLoadLibraryAdded: false,
  paddleLiteInstantiated: false,
  buildTrialExecuted: false,
  buildTrialPassed: false,
  modelConversionExecuted: false,
  nativeModelLoaderAdded: false,
  modelLoaderAvailable: false,
  modelArtifactAcceptedForRuntime: false,
  runtimeStartupExecuted: false,
  modelLoaded: false,
  dummyRuntimeCallExecuted: false,
  realImageToLatexInferenceExecuted: false,
  editableMathLiveReviewOpened: false,
  workspaceImportExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
  storeReadyPassClaimed: false,
  releasePassClaimed: false,
})) {
  assert(q333[key] === expected, `Q333 ${key} expected ${expected}, got ${q333[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q333Phase = "${phase}"`), 'MainActivity missing q333 phase constant');
assert(mainActivity.includes('private val q333NativePackageHashEvidenceIntakeReviewFeatureEnabled = false'), 'MainActivity missing q333 default-off flag');
assert(mainActivity.includes('"nativePackageHashEvidenceIntakeReview" -> result.success(q333NativePackageHashEvidenceIntakeReview(call.method))'), 'MainActivity missing q333 channel method binding');
assert(mainActivity.includes('private fun q333NativePackageHashEvidenceIntakeReview(method: String): Map<String, Any>'), 'MainActivity missing q333 method');
assert(mainActivity.includes('"nativePackageHashEvidenceReviewed" to false'), 'Q333 bridge must keep evidence review false');
assert(mainActivity.includes('"binaryBundlePermissionGranted" to false'), 'Q333 bridge must keep bundle permission false');
assert(mainActivity.includes('"nativeLibraryBundled" to false'), 'Q333 bridge must keep nativeLibraryBundled false');
assert(mainActivity.includes('"jarBundled" to false'), 'Q333 bridge must keep jarBundled false');
assert(mainActivity.includes('"systemLoadLibraryAdded" to false'), 'Q333 bridge must keep systemLoadLibraryAdded false');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q333 MainActivity must not include ${forbidden}`);
}

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `Q333 must not add pubspec dependency marker ${forbidden}`);
}
const androidFiles = exists('android/app') ? walk(path.join(projectRoot, 'android/app')) : [];
const forbiddenBinaries = androidFiles.filter((file) => ['.so', '.aar', '.jar'].some((suffix) => file.endsWith(suffix)));
assert(forbiddenBinaries.length === 0, `Q333 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
assert(!exists('android/app/src/main/jniLibs'), 'Q333 must not create jniLibs directory');
assert(!exists('android/app/libs'), 'Q333 must not create android/app/libs directory');

for (const rel of [
  'lib/features/camera/gauss_native_package_hash_evidence_intake_real_bundle_permission_review_q333_policy.dart',
  'lib/features/camera/gauss_native_package_hash_evidence_intake_real_bundle_permission_review_q333.dart',
  'test/v172_q333_native_package_hash_evidence_intake_real_bundle_permission_review_test.dart',
  'docs/audit/V172_Q333_NATIVE_PACKAGE_HASH_EVIDENCE_INTAKE_REAL_BUNDLE_PERMISSION_REVIEW_AUDIT.md',
  'docs/audit/V172_Q333_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q333 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q333_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q333 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('nativePackageHashEvidenceIntakeReview'), 'Q333 changed-files doc must mention nativePackageHashEvidenceIntakeReview');
console.log(JSON.stringify({
  phase,
  status: q333.nativePackageHashEvidenceIntakeReviewStatus,
  externalNativePackageEvidencePolicy: q333.externalNativePackageEvidencePolicy,
  perFileSha256EvidenceProvidedToAssistant: q333.perFileSha256EvidenceProvidedToAssistant,
  nativePackageHashEvidenceReviewed: q333.nativePackageHashEvidenceReviewed,
  nativePackageHashEvidenceAccepted: q333.nativePackageHashEvidenceAccepted,
  explicitUserBinaryBundleApprovalProvided: q333.explicitUserBinaryBundleApprovalProvided,
  actualBinaryBundleExecuted: q333.actualBinaryBundleExecuted,
  nativeLibraryBundled: q333.nativeLibraryBundled,
  jarBundled: q333.jarBundled,
  jniLibsDirectoryCreated: q333.jniLibsDirectoryCreated,
  runtimeDependencyAdded: q333.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q333.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q333.ocrPassClaimed,
}, null, 2));
