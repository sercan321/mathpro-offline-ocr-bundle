#!/usr/bin/env node
// Successor-aware through V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const phase = 'V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const sourcePhase = 'V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK';
const q280SuccessorPhase = 'V172-Q280-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-BEHIND-FLAG';
const q281SuccessorPhase = 'V172-Q281-PRIVATE-ARTIFACT-LOAD-REAL-SMOKE';
const q282SuccessorPhase = 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE';
const q283SuccessorPhase = 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT';
const q284SuccessorPhase = 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING';
const q285SuccessorPhase = 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT';

function fail(message) {
  console.error(`SELECTED_RUNTIME_DEPENDENCY_TRIAL_Q279_BLOCKED: ${message}`);
  process.exit(1);
}
function read(filePath) {
  if (!fs.existsSync(filePath)) fail(`missing file: ${filePath}`);
  return fs.readFileSync(filePath, 'utf8');
}
function sha(filePath) {
  return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}
function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full, out);
    else out.push(full.replaceAll('\\', '/'));
  }
  return out;
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const policy = read('lib/features/camera/gauss_selected_runtime_dependency_trial_policy.dart');
const gate = read('lib/features/camera/gauss_selected_runtime_dependency_trial.dart');
const test = read('test/v172_q279_selected_runtime_dependency_trial_test.dart');
const audit = read('docs/audit/V172_Q279_SELECTED_RUNTIME_DEPENDENCY_TRIAL_AUDIT.md');
const changed = read('docs/audit/V172_Q279_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const settings = read('android/settings.gradle');
const appBuild = read('android/app/build.gradle');
const gradleWrapper = read('android/gradle/wrapper/gradle-wrapper.properties');
const q278Verifier = read('tool/verify_real_runtime_integration_evidence_lock_v172_q278.mjs');

if (![phase, q280SuccessorPhase, q281SuccessorPhase, q282SuccessorPhase, q283SuccessorPhase, q284SuccessorPhase, q285SuccessorPhase, 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT', 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR', 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR', 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE', 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING', 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME', 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE', 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE', 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q279 or Q280 successor through Q287R1');
if (manifest.selectedRuntimeDependencyTrialLatestPhase !== phase) fail('manifest Q279 latest marker missing');
if (manifest.realRuntimeIntegrationEvidenceLockLatestPhase !== sourcePhase) fail('Q278 evidence lock marker must remain source phase');
const q278 = manifest.v172Q278RealRuntimeIntegrationEvidenceLock;
if (!q278 || q278.phase !== sourcePhase) fail('Q278 source envelope missing');
const q279 = manifest.v172Q279SelectedRuntimeDependencyTrialBehindDefaultOffFlag;
if (!q279 || q279.phase !== phase) fail('Q279 manifest envelope missing');
if (q279.sourcePhase !== sourcePhase) fail('Q279 source phase mismatch');
if (q279.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q279 selected engine changed');
if (q279.fallbackEngineLabel !== 'PP-FormulaNet_plus-L only') fail('Q279 fallback label mismatch');
if (q279.dependencyTrialMode !== 'selected-runtime-dependency-trial-default-off-gate-only-no-runtime-no-inference') fail('Q279 dependency trial mode mismatch');

for (const key of [
  'selectedRuntimeDependencyTrialImplemented',
  'requiresQ278EvidenceLock',
  'requiresOfficialDependencyCoordinates',
  'requiresPinnedRuntimeDependencyVersion',
  'requiresDependencyLicenseCompatibility',
  'requiresTransitiveDependencyAudit',
  'requiresGradleCompatibilityEvidence',
  'requiresAbiPackagingImpactEvidence',
  'requiresApkSizeImpactBudget',
  'requiresDefaultOffFeatureFlag',
  'requiresRuntimeInstantiationBlockedWhenFlagOff',
  'requiresRollbackPlan',
  'editableMathLiveReviewRequired',
  'explicitUserApprovalRequiredBeforeWorkspaceImport',
  'directSolveGraphSolutionHistoryBlocked',
]) {
  if (q279[key] !== true) fail(`Q279 ${key} must be true`);
}
for (const key of [
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'mathLiveProductionRouteChanged',
  'legacyFlutterCursorRouteReintroduced',
  'graphSolutionHistoryRuntimeChanged',
  'cameraShellRuntimeChanged',
  'solverEvaluatorChanged',
  'splashIconChanged',
  'runtimeDependencyAddedToPubspec',
  'gradleNativeRuntimeDependencyAdded',
  'featureFlagEnabledByDefault',
  'productionRuntimeInstantiationAllowed',
  'realOcrRuntimeAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'nativeBridgeImplementationAdded',
  'jniBindingAdded',
  'methodChannelRuntimeBindingAdded',
  'modelBinaryBundledInBaseApp',
  'productionModelUrlBound',
  'productionDownloadEnabled',
  'realNetworkDownloadWorkerImplemented',
  'realImageToLatexInferenceExecuted',
  'runtimeDependencyTrialPassClaimed',
  'runtimeIntegrationPassClaimed',
  'imageToLatexPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'premiumFinalPassClaimed',
  'releasePassClaimed',
]) {
  if (q279[key] !== false) fail(`Q279 ${key} must be false`);
}

if (!Array.isArray(q279.requiredDependencyTrialGates) || q279.requiredDependencyTrialGates.length < 18) fail('Q279 dependency gate list too small');
if (!q279.requiredDependencyTrialGates.includes('officialDependencyCoordinatesEvidence')) fail('Q279 missing dependency coordinates gate');
if (!q279.requiredDependencyTrialGates.includes('defaultOffFeatureFlagRequired')) fail('Q279 missing default-off flag gate');
if (!q279.requiredDependencyTrialGates.includes('editableMathLiveReviewRequired')) fail('Q279 missing MathLive review gate');
if (!Array.isArray(q279.blockedUntilRealEvidence) || q279.blockedUntilRealEvidence.length < 12) fail('Q279 blocked evidence list too small');
if (!q279.blockedUntilRealEvidence.includes('runtimeInstantiationBlockedWhenFlagOffEvidence')) fail('Q279 must require flag-off runtime block evidence');
if (!Array.isArray(q279.forbiddenActions) || q279.forbiddenActions.length < 15) fail('Q279 forbidden action list too small');
if (!q279.forbiddenActions.includes('enableRuntimeFeatureFlagByDefaultInQ279')) fail('Q279 must forbid default-on runtime flag');
if (!q279.forbiddenActions.includes('runImageToLatexInferenceInQ279')) fail('Q279 must forbid inference');

for (const file of [
  'lib/features/camera/gauss_selected_runtime_dependency_trial_policy.dart',
  'lib/features/camera/gauss_selected_runtime_dependency_trial.dart',
  'test/v172_q279_selected_runtime_dependency_trial_test.dart',
  'tool/verify_selected_runtime_dependency_trial_v172_q279.mjs',
  'docs/audit/V172_Q279_SELECTED_RUNTIME_DEPENDENCY_TRIAL_AUDIT.md',
  'docs/audit/V172_Q279_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q279 file missing: ${file}`);
}
if (!policy.includes(phase) || !policy.includes('requiresDefaultOffFeatureFlag = true')) fail('Q279 policy markers missing');
if (!gate.includes('readyForQ280BridgeImplementationGateOnly') || !gate.includes('featureFlagEnabledByDefault')) fail('Q279 gate markers missing');
if (!test.includes('blockedMissingDefaultOffFlagOrRollback') || !test.includes('runtimeDependencyTrialPassClaimed, isFalse')) fail('Q279 test markers missing');
if (!audit.includes('no Paddle runtime') || !changed.includes('gauss_selected_runtime_dependency_trial.dart') || !readme.includes('V172-Q279')) fail('Q279 docs/readme markers missing');
if (!q278Verifier.includes(phase)) fail('Q278 verifier must be Q279 successor through Q287R1-aware');

for (const forbidden of [
  'paddleocr',
  'paddle_ocr',
  'paddle_flutter',
  'paddle_lite',
  'google_mlkit_text_recognition',
  'onnxruntime',
  'tesseract',
  'pix2text',
  'flutter_downloader',
  'background_downloader',
  'dio',
]) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q279');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
if (!gradleWrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7');
if (!appBuild.includes('JavaVersion.VERSION_17') || !appBuild.includes("jvmTarget = '17'")) fail('Java/Kotlin target must remain 17');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors'];
for (const file of walk('.')) {
  const base = path.basename(file).toLowerCase();
  if (file.includes('/.git/') || file.includes('/.dart_tool/') || file.includes('/build/') || file.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/runtime binary must not be bundled in Q279: ${file}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q279: ${file}`);
}

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c',
  'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354',
  'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369',
  'lib/features/keyboard/premium_key.dart': '4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'd9110c8d0018758216b1e9967bbd422cd97559d923cfc090e6677514da0d1c99',
  'lib/features/solution/solution_steps_panel.dart': '558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b',
  'lib/features/solution/solution_step_models.dart': 'faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
  'lib/features/graph/graph_card.dart': '124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/AndroidManifest.xml': '4fe91898ddf5ff94af1527314c8977806f23b051b7de078f25604dfa4731c1a6',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt': 'c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1',
  'lib/app/gauss_splash_screen.dart': '465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81',
  'lib/features/workspace/workspace_panel.dart': '7e3c32f710b07b8fba3bd4223de650c71f334747644a41cfd0079ff7d49812b1',
  'android/settings.gradle': 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30',
  'android/gradle/wrapper/gradle-wrapper.properties': '797ea7d637b36ce5ccff6559a427ae97077073c7992883469e6ecb523fea2b97',
  'android/app/build.gradle': '5533186d6120cb1c8d5c976e2f13f2505d395721d03f6025138fdf96ac3c3ecb',
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51',
};
for (const [filePath, expected] of Object.entries(protectedHashes)) {
  if (!fs.existsSync(filePath)) fail(`protected path missing: ${filePath}`);
  const actual = sha(filePath);
  if (actual !== expected) {
    const q325AllowsMainActivitySuccessorChange =
      filePath === 'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt' &&
      manifest.v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate;
    if (!q325AllowsMainActivitySuccessorChange) fail(`protected hash changed unexpectedly for ${filePath}`);
  }
}

console.log(JSON.stringify({
  phase,
  status: 'SELECTED_RUNTIME_DEPENDENCY_TRIAL_Q279_STATIC_READY_BUT_REAL_DEPENDENCY_COORDINATES_FLAGGED_BUILD_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q279.selectedEngineLabel,
  dependencyTrialMode: q279.dependencyTrialMode,
  requiredDependencyTrialGates: q279.requiredDependencyTrialGates.length,
  blockedUntilRealEvidence: q279.blockedUntilRealEvidence.length,
  forbiddenActions: q279.forbiddenActions.length,
  runtimeDependencyAddedToPubspec: q279.runtimeDependencyAddedToPubspec,
  gradleNativeRuntimeDependencyAdded: q279.gradleNativeRuntimeDependencyAdded,
  featureFlagEnabledByDefault: q279.featureFlagEnabledByDefault,
  realOcrRuntimeAdded: q279.realOcrRuntimeAdded,
  paddleRuntimeAdded: q279.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q279.paddleOcrDependencyAdded,
  nativeBridgeImplementationAdded: q279.nativeBridgeImplementationAdded,
  methodChannelRuntimeBindingAdded: q279.methodChannelRuntimeBindingAdded,
  modelBinaryBundledInBaseApp: q279.modelBinaryBundledInBaseApp,
  productionModelUrlBound: q279.productionModelUrlBound,
  productionDownloadEnabled: q279.productionDownloadEnabled,
  realImageToLatexInferenceExecuted: q279.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q279.ocrPassClaimed,
  protectedHashComparison: 'PASS',
  requiresUserSideRetest: q279.requiresUserSideRetest,
}, null, 2));

// Successor-aware through V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG
