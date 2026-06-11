#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';

const phase = 'V172-Q247R1-PP_FORMULANET_S_USER_SELECTION_LOCK';
const root = process.cwd();
const fail = (msg) => { console.error(`PP_FORMULANET_S_USER_SELECTION_Q247R1_BLOCKED: ${msg}`); process.exit(1); };
const exists = (p) => fs.existsSync(`${root}/${p}`);
const read = (p) => fs.readFileSync(`${root}/${p}`, 'utf8');

const required = [
  'lib/features/camera/gauss_pp_formulanet_s_user_selection_policy.dart',
  'lib/features/camera/gauss_pp_formulanet_s_user_selection.dart',
  'test/v172_q247r1_pp_formulanet_s_user_selection_test.dart',
  'tool/verify_pp_formulanet_s_user_selection_v172_q247r1.mjs',
  'assets/mathlive/manifest.json',
  'README.md',
];
for (const p of required) if (!exists(p)) fail(`missing required Q247R1 file: ${p}`);

const policy = read('lib/features/camera/gauss_pp_formulanet_s_user_selection_policy.dart');
const selection = read('lib/features/camera/gauss_pp_formulanet_s_user_selection.dart');
const test = read('test/v172_q247r1_pp_formulanet_s_user_selection_test.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const readme = read('README.md');

for (const marker of [
  phase,
  'selectedEngineLabel = \'PP-FormulaNet-S\'',
  'selectedFallbackEngineLabel = \'PP-FormulaNet_plus-L\'',
  'selectionIsUserPreferenceNotBenchmarkWinner = true',
  'benchmarkWinnerSelected = false',
  'realBenchmarkPassClaimedByAssistant = false',
  'realOcrRuntimeAdded = false',
  'paddleRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionRuntimeBindingAllowed = false',
  'mathLiveEditableReviewRequired = true',
  'directSolveFromCameraAllowed = false',
  'nextPlannedPhase',
]) if (!policy.includes(marker)) fail(`policy missing marker: ${marker}`);

for (const marker of [
  'class GaussPpFormulaNetSUserSelection',
  'requiredBeforeRuntimeAdapter',
  'licenseClearanceForDistribution',
  'sha256VerifiedModelArtifact',
  'blockedUntilEvidence',
  'cameraImageToLatexInference',
  'directSolveFromCamera',
  'canProceedToQ248DeferredDownloadPlanning => true',
  'canProceedToQ249RuntimeAdapterWithoutEvidence => false',
  'bundlesModelInBaseApk => false',
]) if (!selection.includes(marker)) fail(`selection missing marker: ${marker}`);

for (const marker of [
  phase,
  'PP-FormulaNet-S',
  'PP-FormulaNet_plus-L',
  'selectionIsUserPreferenceNotBenchmarkWinner',
  'benchmarkWinnerSelected, isFalse',
  'realOcrRuntimeAdded, isFalse',
  'canProceedToQ249RuntimeAdapterWithoutEvidence, isFalse',
]) if (!test.includes(marker)) fail(`test missing marker: ${marker}`);

if (manifest.ppFormulaNetSUserSelectionLatestPhase !== phase) fail('manifest latest Q247R1 phase missing');
const env = manifest.v172Q247R1PpFormulaNetSUserSelection;
if (!env || env.phase !== phase) fail('manifest Q247R1 envelope missing');
for (const [key, expected] of Object.entries({
  closesOverPhase: 'V172-Q247-WINNER-ENGINE-SELECTION',
  selectedEngineLabel: 'PP-FormulaNet-S',
  selectedFallbackEngineLabel: 'PP-FormulaNet_plus-L',
  selectionSource: 'explicit-user-choice',
  selectionIsUserPreferenceNotBenchmarkWinner: true,
  benchmarkWinnerSelected: false,
  realBenchmarkPassClaimedByAssistant: false,
  realOcrRuntimeAdded: false,
  paddleRuntimeAdded: false,
  paddleOcrDependencyAdded: false,
  modelBinaryBundledInBaseApp: false,
  productionModelUrlBound: false,
  backgroundDownloadWorkerImplemented: false,
  productionInferenceAllowed: false,
  productionRuntimeBindingAllowed: false,
  mathLiveEditableReviewRequired: true,
  directWorkspaceImportAllowed: false,
  directSolveFromCameraAllowed: false,
  directGraphFromCameraAllowed: false,
  directSolutionFromCameraAllowed: false,
  directHistoryFromCameraAllowed: false,
  q248DeferredModelDownloadMayUseSelectedEngine: true,
  q249RuntimeAdapterRequiresEvidence: true,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  nextPlannedPhase: 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME',
})) if (env[key] !== expected) fail(`manifest Q247R1 ${key} expected ${expected} got ${env[key]}`);

if (!readme.includes('## V172-Q247R1 PP-FormulaNet-S User Selection Lock')) fail('README missing Q247R1 section');
if (!readme.includes('PP-FormulaNet-S is now the user-selected preferred primary math OCR candidate')) fail('README missing Q247R1 PP selection wording');

console.log(JSON.stringify({
  phase,
  status: 'PP_FORMULANET_S_USER_SELECTION_Q247R1_STATIC_READY_BUT_RUNTIME_BENCHMARK_AND_FLUTTER_RETEST_REQUIRED',
  selectedEngineLabel: env.selectedEngineLabel,
  benchmarkWinnerSelected: env.benchmarkWinnerSelected,
  realOcrRuntimeAdded: env.realOcrRuntimeAdded,
  modelBinaryBundledInBaseApp: env.modelBinaryBundledInBaseApp,
}, null, 2));
