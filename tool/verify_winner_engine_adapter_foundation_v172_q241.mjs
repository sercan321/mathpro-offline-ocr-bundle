#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const readJson = (p) => JSON.parse(read(p));
const fail = (message) => {
  console.error(`WINNER_ENGINE_ADAPTER_Q241_VERIFICATION_FAILED: ${message}`);
  process.exit(1);
};

for (const required of [
  'lib/features/camera/gauss_winner_engine_adapter_policy.dart',
  'lib/features/camera/gauss_winner_engine_adapter.dart',
  'test/v172_q241_winner_engine_adapter_foundation_test.dart',
  'tool/verify_winner_engine_adapter_foundation_v172_q241.mjs',
  'docs/audit/V172_Q241_WINNER_ENGINE_ADAPTER_FOUNDATION_AUDIT.md',
  'docs/audit/V172_Q241_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml',
]) if (!exists(required)) fail(`missing Q241 required file: ${required}`);

const policy = read('lib/features/camera/gauss_winner_engine_adapter_policy.dart');
const adapter = read('lib/features/camera/gauss_winner_engine_adapter.dart');
const test = read('test/v172_q241_winner_engine_adapter_foundation_test.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  "phase = 'V172-Q241'",
  "fullPhase = 'V172-Q241-WINNER-ENGINE-ADAPTER-FOUNDATION'",
  'q240r3ExternalLabIntakeGatePreserved = true',
  'q240r2ExternalLabSchemaPreserved = true',
  'q239eMathLiveReviewSurfacePreserved = true',
  'winnerEngineAdapterContractImplemented = true',
  'adapterInputContractImplemented = true',
  'adapterCandidateContractImplemented = true',
  'adapterEnvelopeContractImplemented = true',
  'q240r3IntakeDecisionRequired = true',
  'mathLiveReviewOnlyRoutingImplemented = true',
  'adapterBlocksDirectSolve = true',
  'adapterBlocksDirectWorkspaceImport = true',
  'adapterBlocksGraphHistorySolutionWrites = true',
  'unsafeCandidateValidationImplemented = true',
  'benchmarkWinnerSelected = false',
  'realOcrEngineAdded = false',
  'textOcrFallbackAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'productionMathLiveBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'graphFromCameraAllowed = false',
  'historyWriteFromCameraAllowed = false',
  'solutionFromCameraAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'realEngineAccuracyPassClaimedByAssistant = false',
]) if (!policy.includes(marker)) fail(`Q241 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussWinnerEngineAdapterStatus',
  'enum GaussWinnerEngineAdapterIssueSeverity',
  'class GaussWinnerEngineAdapterIssue',
  'class GaussWinnerEngineAdapterInput',
  'class GaussWinnerEngineAdapterCandidate',
  'class GaussWinnerEngineAdapterEnvelope',
  'class GaussWinnerEngineAdapterFoundation',
  'blockedByIntakeGate',
  'blockedUnsafeCandidate',
  'realEngineInvocationAllowed = false',
  'productionRuntimeBindingAllowed = false',
  'benchmarkWinnerSelected = false',
  'directSolveAllowed = false',
  'directWorkspaceImportAllowed = false',
  'mathLiveReviewRequired = true',
  'adapterSafetyStages',
  'forbiddenRuntimeBindings',
  'q240r3IntakeDecisionGate',
  'mathLiveReviewOnlyGate',
  'workspaceImportBlockGate',
  'graphHistorySolutionBlockGate',
  'productionRuntimeBindingBlockGate',
  'createReviewOnlyEnvelope',
  'intakeResult.mayEnterWinnerAdapterReview',
  'candidate.directSolveAllowed',
  'candidate.directWorkspaceImportAllowed',
  'blocksUnsafeRuntimeBindings',
  'exposesReviewOnlyContract',
]) if (!adapter.includes(marker)) fail(`Q241 adapter missing marker: ${marker}`);

for (const marker of [
  'GaussWinnerEngineAdapterPolicy.phase',
  'winnerEngineAdapterContractImplemented',
  'adapterBlocksDirectSolve',
  'adapterBlocksDirectWorkspaceImport',
  'GaussWinnerEngineAdapterFoundation.createReviewOnlyEnvelope',
  'GaussWinnerEngineAdapterStatus.contractReady',
  'GaussWinnerEngineAdapterStatus.blockedByIntakeGate',
  'GaussWinnerEngineAdapterStatus.blockedUnsafeCandidate',
  'mayOpenMathLiveReviewOnly, isTrue',
  'directSolveAllowed, isFalse',
  'directWorkspaceImportAllowed, isFalse',
  'productionRuntimeBindingAllowed, isFalse',
  'benchmarkWinnerSelected, isFalse',
  'blocksUnsafeRuntimeBindings, isTrue',
  'exposesReviewOnlyContract, isTrue',
]) if (!test.includes(marker)) fail(`Q241 test missing marker: ${marker}`);

const env = manifest.v172Q241WinnerEngineAdapterFoundation;
if (!env) fail('manifest missing v172Q241WinnerEngineAdapterFoundation envelope');
else {
  for (const [key, expected] of Object.entries({
    phase: 'V172-Q241',
    fullPhase: 'V172-Q241-WINNER-ENGINE-ADAPTER-FOUNDATION',
    q240r3ExternalLabIntakeGatePreserved: true,
    q239eMathLiveReviewSurfacePreserved: true,
    winnerEngineAdapterContractImplemented: true,
    adapterInputContractImplemented: true,
    adapterCandidateContractImplemented: true,
    adapterEnvelopeContractImplemented: true,
    q240r3IntakeDecisionRequired: true,
    mathLiveReviewOnlyRoutingImplemented: true,
    adapterBlocksDirectSolve: true,
    adapterBlocksDirectWorkspaceImport: true,
    adapterBlocksGraphHistorySolutionWrites: true,
    unsafeCandidateValidationImplemented: true,
    benchmarkWinnerSelected: false,
    realOcrEngineAdded: false,
    textOcrFallbackAdded: false,
    paddleRuntimeAdded: false,
    pix2TextRuntimeAdded: false,
    onnxRuntimeAdded: false,
    modelBinaryBundledInBaseApp: false,
    productionModelUrlBound: false,
    backgroundDownloadWorkerImplemented: false,
    productionMathLiveBridgeCalled: false,
    directWorkspaceImportImplemented: false,
    directSolveFromCameraAllowed: false,
    graphFromCameraAllowed: false,
    historyWriteFromCameraAllowed: false,
    solutionFromCameraAllowed: false,
    keyboardMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    realEngineAccuracyPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q241 ${key} expected ${expected} got ${env[key]}`);
  for (const stage of ['q240r3IntakeDecisionGate', 'mathLiveReviewOnlyGate', 'workspaceImportBlockGate']) {
    if (!(env.adapterSafetyStages || []).includes(stage)) fail(`manifest Q241 adapter stage missing ${stage}`);
  }
  for (const binding of ['runOcrEngine', 'setWorkspaceLatexWithoutReview', 'evaluateFromCamera']) {
    if (!(env.forbiddenRuntimeBindings || []).includes(binding)) fail(`manifest Q241 forbidden runtime binding missing ${binding}`);
  }
}

if (manifest.winnerEngineAdapterFoundationLatestPhase !== 'V172-Q241') {
  fail('manifest latest Q241 marker missing or incorrect');
}

if (!readme.includes('# V172-Q241 — Winner Engine Adapter Foundation')) fail('README missing Q241 section');
if (!readme.includes('Q241 still does not select a benchmark winner')) fail('README must state no benchmark winner is selected in Q241');
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
]) if (regex.test(pubspec)) fail(`Q241 must not add OCR/download/runtime dependency matching ${regex}`);

if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission from Q239B missing');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE', 'INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q241 must not add manifest permission marker: ${forbidden}`);
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
  walk(root);
  if (matches.length) fail(`Q241 must not bundle model/runtime files matching ${ext}: ${matches.join(', ')}`);
}

console.log('WINNER_ENGINE_ADAPTER_Q241_STATIC_READY_BUT_REAL_ENGINE_ADAPTER_AND_FLUTTER_RETEST_REQUIRED');
