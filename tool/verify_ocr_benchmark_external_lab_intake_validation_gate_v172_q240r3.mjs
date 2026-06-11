import fs from 'node:fs';
import crypto from 'node:crypto';

const errors = [];
const fail = (message) => errors.push(message);
const exists = (file) => fs.existsSync(file);
const read = (file) => fs.readFileSync(file, 'utf8');
const readJson = (file) => JSON.parse(read(file));
const sha = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');

for (const required of [
  'lib/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart',
  'lib/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate.dart',
  'lib/features/camera/gauss_ocr_benchmark_external_lab_result_schema.dart',
  'lib/features/camera/gauss_ocr_benchmark_external_lab_result_schema_policy.dart',
  'test/v172_q240r3_ocr_benchmark_external_lab_intake_validation_gate_test.dart',
  'tool/verify_ocr_benchmark_external_lab_intake_validation_gate_v172_q240r3.mjs',
  'tool/verify_ocr_benchmark_external_lab_result_schema_v172_q240r2.mjs',
  'docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_TEMPLATE.json',
  'docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_BLOCKED_SAMPLE.json',
  'docs/audit/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_VALIDATION_GATE_AUDIT.md',
  'docs/audit/V172_Q240R3_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml'
]) if (!exists(required)) fail(`missing Q240R3 required file: ${required}`);

const policy = read('lib/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart');
const gate = read('lib/features/camera/gauss_ocr_benchmark_external_lab_intake_validation_gate.dart');
const test = read('test/v172_q240r3_ocr_benchmark_external_lab_intake_validation_gate_test.dart');
const intakeTemplate = readJson('docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_TEMPLATE.json');
const blockedSample = readJson('docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_BLOCKED_SAMPLE.json');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  "phase = 'V172-Q240R3'",
  "fullPhase = 'V172-Q240R3-OCR-BENCHMARK-EXTERNAL-LAB-INTAKE-VALIDATION-GATE'",
  'q240r2ExternalLabSchemaPreserved = true',
  'q240r1DatasetLabRunnerPreserved = true',
  'externalLabIntakeValidatorImplemented = true',
  'requiredKeyValidationImplemented = true',
  'forbiddenUnsafeActionValidationImplemented = true',
  'sampleCoverageValidationImplemented = true',
  'licenseValidationImplemented = true',
  'offlineInstallValidationImplemented = true',
  'mathLiveReviewGateValidationImplemented = true',
  'directSolveBlockValidationImplemented = true',
  'productionRuntimeBindingGateImplemented = true',
  'realOcrEngineAdded = false',
  'textOcrFallbackAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'realBenchmarkImageAssetsBundled = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'productionMathLiveBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'benchmarkWinnerSelected = false',
  'winnerEngineAdapterImplemented = false',
  'cameraShellRuntimeMutationAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'realEngineAccuracyPassClaimedByAssistant = false',
]) if (!policy.includes(marker)) fail(`Q240R3 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussOcrExternalLabIntakeDecision',
  'enum GaussOcrExternalLabIntakeIssueSeverity',
  'class GaussOcrExternalLabIntakeIssue',
  'class GaussOcrExternalLabIntakeValidationResult',
  'class GaussOcrBenchmarkExternalLabIntakeValidationGate',
  'eligibleForWinnerAdapterReview',
  'unsafeActionBlocked',
  'insufficientCoverage',
  'licenseBlocked',
  'offlineBlocked',
  'realEngineInvocationAllowed = false',
  'productionRuntimeBindingAllowed = false',
  'winnerSelectionAllowed = false',
  'directSolveAllowed = false',
  'mathLiveReviewRequired = true',
  'requiredTopLevelKeys',
  'requiredSafetyFlags',
  'blockingUnsafeKeys',
  'requiredPerSampleKeys',
  'validationStages',
  'validateReport(Map<String, Object?> report)',
  'sampleCount < GaussOcrBenchmarkExternalLabResultSchema.minimumSampleCount',
  "report['licenseClearedForDistribution'] != true",
  "report['offlineAfterInstall'] != true",
  "report['directSolveAllowed'] == true",
  "sample['directSolveAllowed'] == true",
  'productionRuntimeBindingAllowed: false',
  'hasRequiredSafetyFlags',
  'blocksUnsafeActions',
]) if (!gate.includes(marker)) fail(`Q240R3 gate missing marker: ${marker}`);

for (const marker of [
  'GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.phase',
  'externalLabIntakeValidatorImplemented',
  'forbiddenUnsafeActionValidationImplemented',
  'GaussOcrBenchmarkExternalLabIntakeValidationGate.validateReport',
  'eligibleForWinnerAdapterReview',
  'unsafeActionBlocked',
  'licenseBlocked',
  'offlineBlocked',
  'insufficientCoverage',
  'V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_TEMPLATE.json',
  'V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_BLOCKED_SAMPLE.json',
  'productionRuntimeBindingAllowed, isFalse',
  'directSolveAllowed, isFalse',
  'mathLiveReviewRequired, isTrue',
]) if (!test.includes(marker)) fail(`Q240R3 test missing marker: ${marker}`);

if (intakeTemplate.phase !== 'V172-Q240R3') fail('intake template phase must be V172-Q240R3');
if (intakeTemplate.sourceSchemaPhase !== 'V172-Q240R2') fail('intake template source schema phase must be V172-Q240R2');
if (intakeTemplate.productionRuntimeBindingAllowed !== false) fail('intake template must block production runtime binding');
if (intakeTemplate.winnerSelectionAllowed !== false) fail('intake template must block winner selection');
if (intakeTemplate.directSolveAllowed !== false) fail('intake template must block direct solve');
if (intakeTemplate.mathLiveReviewRequired !== true) fail('intake template must require MathLive review');
for (const key of ['schemaVersion', 'sampleResults', 'reportSha256', 'fixtureManifestSha256']) {
  if (!(intakeTemplate.requiredTopLevelKeys || []).includes(key)) fail(`intake template required top-level keys missing ${key}`);
}
for (const key of ['autoSolve', 'workspaceImportWithoutReview', 'cloudApiKey']) {
  if (!(intakeTemplate.forbiddenUnsafeKeys || []).includes(key)) fail(`intake template forbidden unsafe keys missing ${key}`);
}

if (blockedSample.phase !== 'V172-Q240R3') fail('blocked sample phase must be V172-Q240R3');
if (blockedSample.expectedDecision !== 'unsafeActionBlocked') fail('blocked sample must expect unsafeActionBlocked');
if (blockedSample.containsForbiddenUnsafeKeys !== true) fail('blocked sample must flag forbidden unsafe keys');
if (blockedSample.productionRuntimeBindingAllowed !== false) fail('blocked sample must block production runtime binding');
if (blockedSample.directSolveFromCameraAllowed !== false) fail('blocked sample must block direct solve from camera');

const env = manifest.v172Q240R3OcrBenchmarkExternalLabIntakeValidationGate;
if (!env) fail('manifest missing v172Q240R3OcrBenchmarkExternalLabIntakeValidationGate envelope');
else {
  for (const [key, expected] of Object.entries({
    phase: 'V172-Q240R3',
    fullPhase: 'V172-Q240R3-OCR-BENCHMARK-EXTERNAL-LAB-INTAKE-VALIDATION-GATE',
    q240r2ExternalLabSchemaPreserved: true,
    externalLabIntakeValidatorImplemented: true,
    requiredKeyValidationImplemented: true,
    forbiddenUnsafeActionValidationImplemented: true,
    sampleCoverageValidationImplemented: true,
    licenseValidationImplemented: true,
    offlineInstallValidationImplemented: true,
    mathLiveReviewGateValidationImplemented: true,
    directSolveBlockValidationImplemented: true,
    productionRuntimeBindingGateImplemented: true,
    schemaVersion: 'gauss-ocr-benchmark-external-lab-v1',
    minimumSampleCount: 30,
    realOcrEngineAdded: false,
    textOcrFallbackAdded: false,
    paddleRuntimeAdded: false,
    pix2TextRuntimeAdded: false,
    onnxRuntimeAdded: false,
    modelBinaryBundledInBaseApp: false,
    realBenchmarkImageAssetsBundled: false,
    productionModelUrlBound: false,
    backgroundDownloadWorkerImplemented: false,
    productionMathLiveBridgeCalled: false,
    directWorkspaceImportImplemented: false,
    directSolveFromCameraAllowed: false,
    benchmarkWinnerSelected: false,
    winnerEngineAdapterImplemented: false,
    cameraShellRuntimeMutationAllowed: false,
    keyboardMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    realEngineAccuracyPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q240R3 ${key} expected ${expected} got ${env[key]}`);
  for (const p of [
    'docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_TEMPLATE.json',
    'docs/evidence/V172_Q240R3_OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_BLOCKED_SAMPLE.json',
  ]) if (!(env.evidenceTemplatePaths || []).includes(p)) fail(`manifest Q240R3 evidence template path missing ${p}`);
  for (const stage of ['forbiddenUnsafeActionGate', 'mathLiveReviewGate', 'winnerAdapterReviewOnlyGate']) {
    if (!(env.validationStages || []).includes(stage)) fail(`manifest Q240R3 validation stage missing ${stage}`);
  }
}

if (manifest.ocrBenchmarkExternalLabIntakeValidationGateLatestPhase !== 'V172-Q240R3') {
  fail('manifest latest Q240R3 marker missing or incorrect');
}

if (!readme.includes('# V172-Q240R3 — OCR Benchmark External Lab Intake / Validation Gate')) fail('README missing Q240R3 section');
if (!readme.includes('Q240R3 still does not run real OCR engines')) fail('README must state no real OCR engine run in Q240R3');

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
]) if (regex.test(pubspec)) fail(`Q240R3 must not add OCR/download/runtime dependency matching ${regex}`);

if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission from Q239B missing');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE', 'INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q240R3 must not add manifest permission marker: ${forbidden}`);
}

for (const ext of ['.onnx', '.tflite', '.pt', '.pth', '.pdmodel', '.pdiparams', '.bin']) {
  const matches = [];
  const walk = (dir) => {
    for (const name of fs.readdirSync(dir)) {
      const p = `${dir}/${name}`;
      const st = fs.statSync(p);
      if (st.isDirectory()) walk(p);
      else if (p.toLowerCase().endsWith(ext)) matches.push(p);
    }
  };
  walk('.');
  if (matches.length) fail(`Q240R3 must not bundle model/binary asset extension ${ext}: ${matches.join(', ')}`);
}

const runtimeFiles = [
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'lib/features/camera/gauss_mathlive_ocr_review_surface.dart',
  'lib/features/workspace/workspace_panel.dart',
].filter(exists).map(read).join('\n');
for (const forbidden of [
  'evaluateFromCamera',
  'solveFromCamera',
  'graphFromCamera',
  'historyFromCamera',
  'setLatex',
  'recognizeWithPaddle',
  'recognizeWithOnnx',
  'downloadModel',
  'productionModelUrl',
  'Mathpix',
]) if (runtimeFiles.includes(forbidden)) fail(`Q240R3 must not bind runtime/OCR/network/solver marker in production camera files: ${forbidden}`);

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c',
  'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354',
  'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369',
  'lib/features/keyboard/premium_key.dart': '4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/features/solution/solution_steps_panel.dart': '558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b',
  'lib/features/solution/solution_step_models.dart': 'faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/AndroidManifest.xml': '4fe91898ddf5ff94af1527314c8977806f23b051b7de078f25604dfa4731c1a6',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt': 'c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1',
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  else if (sha(file) !== expected) fail(`protected hash changed for ${file}: ${sha(file)} expected ${expected}`);
}

if (errors.length) {
  console.error('OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_VALIDATION_GATE_Q240R3_BLOCKED');
  for (const e of errors) console.error(`- ${e}`);
  process.exit(1);
}

console.log(JSON.stringify({
  phase: 'V172-Q240R3',
  status: 'OCR_BENCHMARK_EXTERNAL_LAB_INTAKE_VALIDATION_GATE_Q240R3_STATIC_READY_BUT_REAL_ENGINE_BENCHMARK_AND_FLUTTER_RETEST_REQUIRED',
  intakeValidationGateReady: true,
  externalLabSchemaPreserved: true,
  realOcrEngineAdded: false,
  modelBinaryBundledInBaseApp: false,
  benchmarkWinnerSelected: false,
  directSolveFromCameraAllowed: false,
  productionRuntimeBindingAllowed: false,
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  flutterRunPassClaimed: false
}, null, 2));
