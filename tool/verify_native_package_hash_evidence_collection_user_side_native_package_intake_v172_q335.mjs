#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const phase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const sourcePhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
const status = 'NATIVE_PACKAGE_HASH_EVIDENCE_COLLECTION_INTAKE_BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES_DEFAULT_OFF';
const q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([phase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q335 or Q336 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q335 or Q336 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativePackageHashEvidenceCollectionUserSideNativePackageIntakeLatestPhase === phase, 'Q335 latest phase key missing');
const q335 = manifest.v172Q335NativePackageHashEvidenceCollectionUserSideNativePackageIntake;
assert(q335 && q335.phase === phase, 'Q335 manifest envelope missing or wrong phase');
assert(q335.sourcePhase === sourcePhase, 'Q335 sourcePhase mismatch');
assert(q335.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q335 native channel mismatch');
assert(q335.nativePackageHashEvidenceCollectionIntakeMethod === 'nativePackageHashEvidenceCollectionIntake', 'Q335 method missing');
assert(q335.nativePackageHashEvidenceCollectionIntakeStatus === status, 'Q335 status mismatch');
assert(q335.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q335 external intake policy mismatch');
assert(q335.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q335 evidence file name mismatch');
assert(q335.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q335 required jar missing');
assert(q335.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q335 required arm64 lib missing');
assert(q335.requiredNativePackageFiles.includes('armeabi-v7a/libpaddle_lite_jni.so'), 'Q335 required armeabi-v7a lib missing');
assert(q335.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q335 planned jar target missing');
assert(q335.q335IntakePreparationScript === 'tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs', 'Q335 intake script mismatch');

for (const [key, expected] of Object.entries({
  userSideNativePackageFilesProvided: false,
  q328NativePackageHashEvidenceJsonProvided: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  nativePackageHashEvidenceReviewed: false,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  binaryBundlePermissionGranted: false,
  actualBinaryBundleExecuted: false,
  nativeLibraryBundled: false,
  jarBundled: false,
  jniLibsDirectoryCreated: false,
  androidAppLibsDirectoryCreated: false,
  systemLoadLibraryAdded: false,
  paddleLiteInstantiated: false,
  runtimeDependencyAdded: false,
  realImageToLatexInferenceExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
  storeReadyPassClaimed: false,
  releasePassClaimed: false,
})) {
  assert(q335[key] === expected, `Q335 ${key} expected ${expected}, got ${q335[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q335Phase = "${phase}"`), 'MainActivity missing q335 phase constant');
assert(mainActivity.includes('"nativePackageHashEvidenceCollectionIntake" -> result.success(q335NativePackageHashEvidenceCollectionIntake(call.method))'), 'MainActivity missing Q335 method binding');
assert(mainActivity.includes('"userSideNativePackageFilesProvided" to false'), 'Q335 bridge must keep user-side files false');
assert(mainActivity.includes('"q328NativePackageHashEvidenceJsonProvided" to false'), 'Q335 bridge must keep q328 evidence false');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q335 bridge must keep actual bundle false');
assert(mainActivity.includes('"nativeLibraryBundled" to false'), 'Q335 bridge must keep native bundle false');
assert(mainActivity.includes('"jarBundled" to false'), 'Q335 bridge must keep jar bundle false');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'Predictor(', 'PaddleLite']) {
  assert(!mainActivity.includes(forbidden), `Q335 MainActivity must not include ${forbidden}`);
}

const forbiddenBinaries = [];
function walk(dir) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else if (/\.(so|aar|jar)$/i.test(entry.name)) forbiddenBinaries.push(path.relative(root, full));
  }
}
walk(path.join(root, 'android', 'app')); // project runtime bundle area only; ignore Gradle wrapper jar
assert(forbiddenBinaries.length === 0, `Q335 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
assert(!exists('android/app/src/main/jniLibs'), 'Q335 must not create jniLibs directory');
assert(!exists('android/app/libs'), 'Q335 must not create android/app/libs directory');
assert(exists('tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs'), 'Q335 intake preparation script missing');
for (const rel of [
  'lib/features/camera/gauss_native_package_hash_evidence_collection_user_side_native_package_intake_q335_policy.dart',
  'lib/features/camera/gauss_native_package_hash_evidence_collection_user_side_native_package_intake_q335.dart',
  'test/v172_q335_native_package_hash_evidence_collection_user_side_native_package_intake_test.dart',
  'docs/audit/V172_Q335_NATIVE_PACKAGE_HASH_EVIDENCE_COLLECTION_USER_SIDE_NATIVE_PACKAGE_INTAKE_AUDIT.md',
  'docs/audit/V172_Q335_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q335 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q335_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q335 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('nativePackageHashEvidenceCollectionIntake'), 'Q335 changed-files doc must mention bridge method');
console.log(JSON.stringify({ phase, status: q335.nativePackageHashEvidenceCollectionIntakeStatus, ok: true }, null, 2));
