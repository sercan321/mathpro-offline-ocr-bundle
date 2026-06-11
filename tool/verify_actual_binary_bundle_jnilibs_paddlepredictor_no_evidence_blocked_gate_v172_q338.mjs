#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
const phase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const sourcePhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const status = 'ACTUAL_BINARY_BUNDLE_BLOCKED_NO_Q328_NATIVE_HASH_EVIDENCE_NO_USER_APPROVAL_UI_PROTECTED_DEFAULT_OFF';
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

const q344AndLaterBinaryBundlePhases = new Set([
  'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR',
  'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL',
  'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE',
  'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE',
  'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE',
  'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED',
  'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE',
  'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE',
  'V172-Q351R1-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR',
  'V172-Q351R2-FLUTTER-RUN-KOTLIN-BUILD-HELPER-REPAIR',
  'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE', 'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE', 'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL', 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION', 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED', 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD', 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD',
  'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION', 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT', 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE',
  'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',
]);
const q344AllowedBinaryTargets = new Set([
  'android/app/libs/PaddlePredictor.jar',
  'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
  'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
]);
function allowQ344OrLaterBundledBinaries() {
  return q344AndLaterBinaryBundlePhases.has(manifest.cameraOcrLatestPhase) ||
      q344AndLaterBinaryBundlePhases.has(manifest.activeProductDevelopmentLatestPhase);
}

assert([phase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q338 or Q339 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q338 or Q339 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.actualBinaryBundleNoEvidenceBlockedGateLatestPhase === phase, 'Q338 latest phase key missing');
const q338 = manifest.v172Q338ActualBinaryBundleJniLibsPaddlePredictorNoEvidenceBlockedGate;
assert(q338 && q338.phase === phase, 'Q338 manifest envelope missing or wrong phase');
assert(q338.sourcePhase === sourcePhase, 'Q338 sourcePhase mismatch');
assert(q338.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q338 native channel mismatch');
assert(q338.actualBinaryBundleNoEvidenceBlockedGateMethod === 'actualBinaryBundleNoEvidenceBlockedGate', 'Q338 method missing');
assert(q338.actualBinaryBundleNoEvidenceBlockedGateStatus === status, 'Q338 status mismatch');
assert(q338.uiProtectionStatus.includes('UI_PROTECTED'), 'Q338 UI protection status missing');
assert(q338.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q338 required jar missing');
assert(q338.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q338 required arm64 lib missing');
assert(q338.requiredNativePackageFiles.includes('armeabi-v7a/libpaddle_lite_jni.so'), 'Q338 required armeabi-v7a lib missing');
assert(q338.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q338 planned jar target missing');

for (const [key, expected] of Object.entries({
  q328NativePackageHashEvidenceJsonProvided: false,
  q328NativePackageHashEvidenceJsonReviewed: false,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  binaryBundlePermissionGranted: false,
  actualBinaryBundlePlacementAttempted: false,
  actualBinaryBundleExecuted: false,
  nativeLibraryBundled: false,
  jarBundled: false,
  jniLibsDirectoryCreated: false,
  androidAppLibsDirectoryCreated: false,
  gradleChanged: false,
  pubspecChanged: false,
  androidManifestChanged: false,
  workspaceChanged: false,
  keyboardChanged: false,
  mathLiveProductionBridgeChanged: false,
  graphChanged: false,
  solutionChanged: false,
  historyChanged: false,
  splashChanged: false,
  systemLoadLibraryAdded: false,
  paddleLiteInstantiated: false,
  runtimeDependencyAdded: false,
  realImageToLatexInferenceExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
})) {
  assert(q338[key] === expected, `Q338 ${key} expected ${expected}, got ${q338[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q338Phase = "${phase}"`), 'MainActivity missing q338 phase constant');
assert(mainActivity.includes('"actualBinaryBundleNoEvidenceBlockedGate" -> result.success(q338ActualBinaryBundleNoEvidenceBlockedGate(call.method))'), 'MainActivity missing Q338 method binding');
assert(mainActivity.includes('"q328NativePackageHashEvidenceJsonProvided" to false'), 'Q338 bridge must keep q328 evidence false');
assert(mainActivity.includes('"explicitUserBinaryBundleApprovalProvided" to false'), 'Q338 bridge must keep explicit bundle approval false');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q338 bridge must keep actual bundle false');
assert(mainActivity.includes('"workspaceChanged" to false'), 'Q338 bridge must disclose workspace unchanged');
assert(mainActivity.includes('"keyboardChanged" to false'), 'Q338 bridge must disclose keyboard unchanged');
assert(mainActivity.includes('"mathLiveProductionBridgeChanged" to false'), 'Q338 bridge must disclose MathLive production bridge unchanged');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'Predictor(', 'PaddleLite(']) {
  assert(!mainActivity.includes(forbidden), `Q338 MainActivity must not include ${forbidden}`);
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
walk(path.join(root, 'android', 'app'));
if (allowQ344OrLaterBundledBinaries()) {
  const unexpected = forbiddenBinaries.map(rel => rel.replaceAll(path.sep, '/')).filter(rel => !q344AllowedBinaryTargets.has(rel));
  assert(unexpected.length === 0, `Q338 must allow only Q344-approved bundled binaries under Q344-Q352 successors: ${unexpected.join(', ')}`);
} else {
  assert(forbiddenBinaries.length === 0, `Q338 must not bundle native binaries before Q344: ${forbiddenBinaries.join(', ')}`);
  assert(!exists('android/app/src/main/jniLibs'), 'Q338 must not create jniLibs directory before Q344');
  assert(!exists('android/app/libs'), 'Q338 must not create android/app/libs directory before Q344');
}
for (const protectedPath of [
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/graph/graph_card.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/history/history_panel.dart',
  'lib/app/gauss_splash_screen.dart',
]) {
  assert(exists(protectedPath), `Q338 protected path missing: ${protectedPath}`);
}
for (const rel of [
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_q338_policy.dart',
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_q338.dart',
  'test/v172_q338_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_test.dart',
  'docs/audit/V172_Q338_ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_NO_EVIDENCE_BLOCKED_GATE_AUDIT.md',
  'docs/audit/V172_Q338_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q338 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q338_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q338 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('actualBinaryBundleNoEvidenceBlockedGate'), 'Q338 changed-files doc must mention bridge method');
assert(changed.includes('No workspace/keyboard/MathLive/Graph/Solution/History/splash/icon files were modified'), 'Q338 changed-files doc must disclose UI red-line preservation');
console.log(JSON.stringify({ phase, status: q338.actualBinaryBundleNoEvidenceBlockedGateStatus, uiProtected: q338.uiProtectionStatus, ok: true }, null, 2));
