#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const readJson = (p) => JSON.parse(read(p));
const fail = (message) => {
  console.error(`ADVANCED_MATH_OCR_OFFLINE_MODE_GUARD_Q242_VERIFICATION_FAILED: ${message}`);
  process.exit(1);
};

for (const required of [
  'lib/features/camera/gauss_advanced_math_ocr_offline_mode_guard_policy.dart',
  'lib/features/camera/gauss_advanced_math_ocr_offline_mode_guard.dart',
  'test/v172_q242_advanced_math_ocr_offline_mode_guard_test.dart',
  'tool/verify_advanced_math_ocr_offline_mode_guard_v172_q242.mjs',
  'docs/audit/V172_Q242_ADVANCED_MATH_OCR_OFFLINE_MODE_GUARD_AUDIT.md',
  'docs/audit/V172_Q242_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml',
]) if (!exists(required)) fail(`missing Q242 required file: ${required}`);

const policy = read('lib/features/camera/gauss_advanced_math_ocr_offline_mode_guard_policy.dart');
const guard = read('lib/features/camera/gauss_advanced_math_ocr_offline_mode_guard.dart');
const test = read('test/v172_q242_advanced_math_ocr_offline_mode_guard_test.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  "phase = 'V172-Q242'",
  "fullPhase = 'V172-Q242-ADVANCED-MATH-OCR-OFFLINE-MODE-GUARD'",
  'q241WinnerEngineAdapterPreserved = true',
  'q240r3ExternalLabIntakeGatePreserved = true',
  'q239eMathLiveReviewSurfacePreserved = true',
  'q239dDeferredModelManagerPreserved = true',
  'advancedOfflineModeGuardImplemented = true',
  'offlineReadinessDecisionImplemented = true',
  'localModelReadyRequired = true',
  'localModelSha256VerificationRequired = true',
  'appPrivateInstallPathRequired = true',
  'offlineRuntimeAvailabilityRequired = true',
  'winnerAdapterReviewOnlyEnvelopeRequired = true',
  'croppedImageContextRequired = true',
  'mathLiveReviewRequiredBeforeAnyAction = true',
  'directActionAttemptsBlocked = true',
  'realOcrEngineAdded = false',
  'textOcrFallbackAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'offlineOcrExecutionAllowedInThisPhase = false',
  'productionMathLiveBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'realEngineAccuracyPassClaimedByAssistant = false',
]) if (!policy.includes(marker)) fail(`Q242 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussAdvancedMathOcrOfflineModeStatus',
  'contractReadyFutureOnly',
  'blockedModelNotReady',
  'blockedModelVerification',
  'blockedRuntimeUnavailable',
  'blockedAdapterUnsafe',
  'blockedDirectActionAttempt',
  'class GaussAdvancedMathOcrOfflineModeRequest',
  'class GaussAdvancedMathOcrOfflineModeDecision',
  'class GaussAdvancedMathOcrOfflineModeGuard',
  'realOcrEngineAdded = false',
  'offlineOcrExecutionAllowedInThisPhase = false',
  'mathLiveReviewRequired = true',
  'directSolveAllowed = false',
  'directWorkspaceImportAllowed = false',
  'offlineReadinessGates',
  'q239dModelSnapshotReadyGate',
  'localModelSha256VerificationGate',
  'offlineRuntimeAvailabilityGate',
  'q241WinnerAdapterReviewOnlyGate',
  'mathLiveReviewBeforeAnyActionGate',
  'forbiddenOfflineModeActions',
  'executeOcrInQ242',
  'setWorkspaceLatexWithoutReview',
  'evaluateFromCamera',
  'request.modelSnapshot.canRunOffline',
  'request.adapterEnvelope.mayOpenMathLiveReviewOnly',
  'futureOfflineReviewPathPrepared',
  'mayExecuteOcrNow => false',
  'blocksUnsafeOfflineActions',
  'exposesOfflineReviewOnlyContract',
]) if (!guard.includes(marker)) fail(`Q242 guard missing marker: ${marker}`);

for (const marker of [
  'GaussAdvancedMathOcrOfflineModeGuardPolicy.phase',
  'advancedOfflineModeGuardImplemented',
  'localModelSha256VerificationRequired',
  'mathLiveReviewRequiredBeforeAnyAction',
  'realOcrEngineAdded, isFalse',
  'offlineOcrExecutionAllowedInThisPhase, isFalse',
  'GaussAdvancedMathOcrOfflineModeGuard.evaluate',
  'GaussAdvancedMathOcrOfflineModeStatus.contractReadyFutureOnly',
  'GaussAdvancedMathOcrOfflineModeStatus.blockedModelNotReady',
  'GaussAdvancedMathOcrOfflineModeStatus.blockedDirectActionAttempt',
  'futureOfflineReviewPathPrepared, isTrue',
  'mayExecuteOcrNow, isFalse',
  'directSolveAllowed, isFalse',
  'directWorkspaceImportAllowed, isFalse',
  'blocksUnsafeOfflineActions, isTrue',
  'exposesOfflineReviewOnlyContract, isTrue',
]) if (!test.includes(marker)) fail(`Q242 test missing marker: ${marker}`);

const env = manifest.v172Q242AdvancedMathOcrOfflineModeGuard;
if (!env) fail('manifest missing v172Q242AdvancedMathOcrOfflineModeGuard envelope');
else {
  for (const [key, expected] of Object.entries({
    phase: 'V172-Q242',
    fullPhase: 'V172-Q242-ADVANCED-MATH-OCR-OFFLINE-MODE-GUARD',
    q241WinnerEngineAdapterPreserved: true,
    q240r3ExternalLabIntakeGatePreserved: true,
    q239eMathLiveReviewSurfacePreserved: true,
    q239dDeferredModelManagerPreserved: true,
    advancedOfflineModeGuardImplemented: true,
    offlineReadinessDecisionImplemented: true,
    localModelReadyRequired: true,
    localModelSha256VerificationRequired: true,
    appPrivateInstallPathRequired: true,
    offlineRuntimeAvailabilityRequired: true,
    winnerAdapterReviewOnlyEnvelopeRequired: true,
    croppedImageContextRequired: true,
    mathLiveReviewRequiredBeforeAnyAction: true,
    directActionAttemptsBlocked: true,
    realOcrEngineAdded: false,
    textOcrFallbackAdded: false,
    paddleRuntimeAdded: false,
    pix2TextRuntimeAdded: false,
    onnxRuntimeAdded: false,
    modelBinaryBundledInBaseApp: false,
    productionModelUrlBound: false,
    backgroundDownloadWorkerImplemented: false,
    offlineOcrExecutionAllowedInThisPhase: false,
    productionMathLiveBridgeCalled: false,
    directWorkspaceImportImplemented: false,
    directSolveFromCameraAllowed: false,
    graphFromCameraAllowed: false,
    historyWriteFromCameraAllowed: false,
    solutionFromCameraAllowed: false,
    keyboardMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    realEngineAccuracyPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q242 ${key} expected ${expected} got ${env[key]}`);
  for (const gate of ['q239dModelSnapshotReadyGate', 'localModelSha256VerificationGate', 'q241WinnerAdapterReviewOnlyGate', 'mathLiveReviewBeforeAnyActionGate']) {
    if (!(env.offlineReadinessGates || []).includes(gate)) fail(`manifest Q242 offline readiness gate missing ${gate}`);
  }
  for (const action of ['executeOcrInQ242', 'setWorkspaceLatexWithoutReview', 'evaluateFromCamera']) {
    if (!(env.forbiddenOfflineModeActions || []).includes(action)) fail(`manifest Q242 forbidden offline action missing ${action}`);
  }
}

if (manifest.advancedMathOcrOfflineModeGuardLatestPhase !== 'V172-Q242') {
  fail('manifest latest Q242 marker missing or incorrect');
}

if (!readme.includes('# V172-Q242 — Advanced Math OCR Offline Mode Guard')) fail('README missing Q242 section');
if (!readme.includes('Q242 still does not execute OCR')) fail('README must state Q242 does not execute OCR');
if (!readme.includes('editable MathLive review')) fail('README must preserve editable MathLive review statement');

if (!/^\s*camera\s*:\s*(?:0\.10\.6|\^?0\.11\.0)\s*$/m.test(pubspec)) fail('pubspec must keep a locked camera package compatible with the active Q244 successor');
if (!/^\s*shared_preferences\s*:\s*\^2\.5\.5\s*$/m.test(pubspec)) fail('pubspec must keep shared_preferences: ^2.5.5');
for (const regex of [
  /^\s*google_mlkit_text_recognition\s*:/m,
  /^\s*google_mlkit_commons\s*:/m,
  /^\s*paddle/m,
  /^\s*onnxruntime/m,
  /^\s*pix2text/m,
  /^\s*workmanager\s*:/m,
  /^\s*flutter_downloader\s*:/m,
  /^\s*http\s*:/m,
]) if (regex.test(pubspec)) fail(`Q242 must not add OCR/download/runtime dependency matching ${regex}`);

if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission from Q239B missing');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE', 'INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q242 must not add manifest permission marker: ${forbidden}`);
}

for (const ext of ['.onnx', '.tflite', '.pt', '.pth', '.pdmodel', '.pdiparams', '.bin']) {
  const matches = [];
  const walk = (dir) => {
    for (const name of fs.readdirSync(dir)) {
      const p = `${dir}/${name}`;
      const st = fs.statSync(p);
      if (st.isDirectory()) walk(p);
      else if (p.toLowerCase().endsWith(ext)) matches.push(path.relative(root, p));
    }
  };
  for (const dir of ['assets', 'lib', 'android', 'docs']) if (exists(dir)) walk(path.join(root, dir));
  if (matches.length) fail(`Q242 must not bundle model/runtime files ${ext}: ${matches.join(', ')}`);
}

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/template_tray.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/history/history_controller.dart',
  'lib/app/app_shell.dart',
  'lib/main.dart',
  'android/app/src/main/AndroidManifest.xml',
];
for (const file of protectedFiles) if (!exists(file)) fail(`protected file missing: ${file}`);

console.log('ADVANCED_MATH_OCR_OFFLINE_MODE_GUARD_Q242_STATIC_READY_BUT_REAL_ENGINE_RUNTIME_FLUTTER_AND_ANDROID_RETEST_REQUIRED');
