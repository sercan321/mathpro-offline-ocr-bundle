#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const phase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const sourcePhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const status = 'NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_ACTUAL_BUNDLE_PERMISSION_FINAL_CHECK_BLOCKED_PENDING_Q328_JSON_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
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

assert([phase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q339 or Q340, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q339 or Q340, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheckLatestPhase === phase, 'Q339 latest phase key missing');
const q339 = manifest.v172Q339NativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck;
assert(q339 && q339.phase === phase, 'Q339 manifest envelope missing or wrong phase');
assert(q339.sourcePhase === sourcePhase, 'Q339 sourcePhase mismatch');
assert(q339.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q339 native channel mismatch');
assert(q339.method === 'nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck', 'Q339 method missing');
assert(q339.status === status, 'Q339 status mismatch');
assert(q339.uiProtectionStatus.includes('UI_PROTECTED'), 'Q339 UI protection status missing');
assert(q339.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q339 required jar missing');
assert(q339.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q339 required arm64 lib missing');
assert(q339.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q339 planned jar target missing');

for (const [key, expected] of Object.entries({
  q328NativePackageHashEvidenceJsonProvided: false,
  q328NativePackageHashEvidenceJsonReviewed: false,
  q328NativePackageHashEvidenceJsonAccepted: false,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  finalBundlePermissionGranted: false,
  binaryBundlePermissionGranted: false,
  actualBinaryBundleAttempted: false,
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
  moreTemplateTrayChanged: false,
  longPressChanged: false,
  mathLiveProductionBridgeChanged: false,
  graphChanged: false,
  solutionChanged: false,
  historyChanged: false,
  splashChanged: false,
  iconChanged: false,
  systemLoadLibraryAdded: false,
  paddleLiteInstantiated: false,
  runtimeDependencyAdded: false,
  modelLoaderAvailable: false,
  realImageToLatexInferenceExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
})) {
  assert(q339[key] === expected, `Q339 ${key} expected ${expected}, got ${q339[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q339Phase = "${phase}"`), 'MainActivity missing q339 phase constant');
assert(mainActivity.includes('"nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck" -> result.success(q339NativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck(call.method))'), 'MainActivity missing Q339 method binding');
assert(mainActivity.includes('"q328NativePackageHashEvidenceJsonProvided" to false'), 'Q339 bridge must keep q328 evidence false');
assert(mainActivity.includes('"explicitUserBinaryBundleApprovalProvided" to false'), 'Q339 bridge must keep explicit bundle approval false');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q339 bridge must keep actual bundle false');
assert(mainActivity.includes('"workspaceChanged" to false'), 'Q339 bridge must disclose workspace unchanged');
assert(mainActivity.includes('"keyboardChanged" to false'), 'Q339 bridge must disclose keyboard unchanged');
assert(mainActivity.includes('"moreTemplateTrayChanged" to false'), 'Q339 bridge must disclose MORE unchanged');
assert(mainActivity.includes('"longPressChanged" to false'), 'Q339 bridge must disclose long-press unchanged');
assert(mainActivity.includes('"mathLiveProductionBridgeChanged" to false'), 'Q339 bridge must disclose MathLive production bridge unchanged');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'Predictor(', 'PaddleLite(']) {
  assert(!mainActivity.includes(forbidden), `Q339 MainActivity must not include ${forbidden}`);
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
  assert(unexpected.length === 0, `Q339 must allow only Q344-approved bundled binaries under Q344-Q352 successors: ${unexpected.join(', ')}`);
} else {
  assert(forbiddenBinaries.length === 0, `Q339 must not bundle native binaries before Q344: ${forbiddenBinaries.join(', ')}`);
  assert(!exists('android/app/src/main/jniLibs'), 'Q339 must not create jniLibs directory before Q344');
  assert(!exists('android/app/libs'), 'Q339 must not create android/app/libs directory before Q344');
}
for (const protectedPath of [
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/history/history_panel.dart',
  'lib/app/gauss_splash_screen.dart',
]) {
  assert(exists(protectedPath), `Q339 protected path missing: ${protectedPath}`);
}
for (const rel of [
  'lib/features/camera/gauss_native_package_hash_evidence_capture_actual_bundle_permission_final_check_q339_policy.dart',
  'lib/features/camera/gauss_native_package_hash_evidence_capture_actual_bundle_permission_final_check_q339.dart',
  'test/v172_q339_native_package_hash_evidence_capture_actual_bundle_permission_final_check_test.dart',
  'docs/audit/V172_Q339_NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_ACTUAL_BUNDLE_PERMISSION_FINAL_CHECK_AUDIT.md',
  'docs/audit/V172_Q339_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q339 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q339_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q339 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck'), 'Q339 changed-files doc must mention bridge method');
assert(changed.includes('No workspace/keyboard/MORE/long-press/MathLive/Graph/Solution/History/splash/icon files were modified'), 'Q339 changed-files doc must disclose UI red-line preservation');
console.log(JSON.stringify({ phase, status: q339.status, uiProtected: q339.uiProtectionStatus, ok: true }, null, 2));
