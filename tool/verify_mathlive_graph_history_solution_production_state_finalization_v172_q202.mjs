import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_graph_history_solution_production_state_finalization_v172_q202.mjs', preservedPhase: 'verify_mathlive_graph_history_solution_production_state_finalization_v172_q202' });

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const fail = (msg) => { console.error(`Q202_GRAPH_HISTORY_SOLUTION_PRODUCTION_STATE_FINALIZATION_FAIL: ${msg}`); process.exit(1); };
const must = (rel, token) => { if (!exists(rel) || !read(rel).includes(token)) fail(`${rel} missing ${token}`); };
const mustNot = (rel, token) => { if (exists(rel) && read(rel).includes(token)) fail(`${rel} contains forbidden ${token}`); };
const sha256 = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');

const phase = 'V172-Q202';
const fullPhase = 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION';
const files = {
  q202Policy: 'lib/features/mathlive/mathlive_production_graph_history_solution_state_finalization_policy.dart',
  q188Policy: 'lib/features/mathlive/mathlive_production_graph_history_solution_adapter_policy.dart',
  appShell: 'lib/app/app_shell.dart',
  runtimeSync: 'lib/features/mathlive/mathlive_runtime_sync_binding_policy.dart',
  stateAdapter: 'lib/features/mathlive/mathlive_state_adapter.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  pubspec: 'pubspec.yaml',
  test: 'test/v172_q202_graph_history_solution_production_state_finalization_test.dart',
  verifier: 'tool/verify_mathlive_graph_history_solution_production_state_finalization_v172_q202.mjs',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

for (const token of [
  "static const String phase = 'V172-Q202'",
  "static const String fullPhase = 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION'",
  "static const String baseline = 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION'",
  "snapshotSource = 'q202-production-state-finalized-mathlive-snapshot'",
  "evaluationSource = 'q202-production-state-finalized-evaluation'",
  "historySource = 'q202-production-state-finalized-history'",
  "graphSource = 'q202-production-state-finalized-graph'",
  'graphSourceMustBeMathLiveProductionState = true',
  'historySourceMustBeMathLiveProductionState = true',
  'solutionSourceMustBeMathLiveProductionState = true',
  'evaluationSourceMustBeMathLiveProductionState = true',
  'calculatorControllerSourceMustBeMathLiveProductionState = true',
  'fallbackExpressionMayFeedGraphHistorySolution = false',
  'visibleFallbackMirrorMayFeedGraphHistorySolution = false',
  'staleCalculatorShadowMayFeedGraphHistorySolution = false',
  'openPlaceholderMayGenerateFakeResult = false',
  'openPlaceholderMayOpenGraph = false',
  'openPlaceholderMayWriteRuntimeHistory = false',
  'fakeGraphAllowed = false',
  'fakeHistoryAllowed = false',
  'fakeSolutionAllowed = false',
  'graphUiMutationAllowed = false',
  'historyControllerMutationAllowed = false',
  'historyPanelMutationAllowed = false',
  'solutionStepsPanelMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'flutterRunPassClaimedByAssistant = false',
  'androidRealDevicePassClaimed = false',
  'finalReleasePassClaimed = false',
  'fallbackExpression: \'\'',
  'MathLiveProductionGraphHistorySolutionStateEnvelope.fromRuntime(runtime)',
  'sourceTruth: \'mathlive-production-state-only\'',
  'fallbackExpressionIgnored: true',
  'if (envelope.hasOpenSlots || envelope.fakeSolutionGenerated) return \'\';',
  'static bool canOpenGraphDirectly',
  'static bool canWriteRuntimeHistory',
  'static bool shouldBlockFakeSolution',
]) must(files.q202Policy, token);

must(files.appShell, "mathlive_production_graph_history_solution_state_finalization_policy.dart");
mustNot(files.appShell, "mathlive_production_graph_history_solution_adapter_policy.dart");
must(files.appShell, 'MathLiveProductionGraphHistorySolutionStateEnvelope? _lastMathLiveProductionStateEnvelope;');
must(files.appShell, 'buildFinalizedProductionEnvelope(snapshot)');
must(files.appShell, 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForController(envelope)');
must(files.appShell, 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForEvaluation(envelope)');
must(files.appShell, 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForHistory(envelope)');
must(files.appShell, 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForGraph(envelope)');
must(files.appShell, 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.canOpenGraphDirectly(envelope)');
must(files.appShell, "if (_useMathLiveMainEditor && envelope == null) return;");
must(files.appShell, "MathLive production state henüz hazır değil.");
must(files.appShell, "Açık slotlar doldurulmadan grafik üretilmedi.");
mustNot(files.appShell, '_lastMathLiveRuntimeEnvelope');
mustNot(files.appShell, 'MathLiveRuntimeSyncEnvelope?');
mustNot(files.appShell, 'fallbackExpression: _calculator.state.expressionText');
mustNot(files.appShell, 'MathLiveProductionGraphHistorySolutionAdapterPolicy.expressionForGraph');

must(files.q188Policy, "q202FinalizedProductionStateSuccessor = 'V172-Q202'");
must(files.q188Policy, 'q202FinalizesProductionStateTruth = true');
must(files.runtimeSync, 'fallbackExpression');
must(files.stateAdapter, 'MathLiveEditorStateSnapshot');

const manifest = JSON.parse(read(files.manifest));
if (![fullPhase, 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE', 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE'].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase expected ${fullPhase} or verified Q203 successor, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q202GraphHistorySolutionProductionStateFinalization;
if (!env) fail('missing manifest Q202 envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  baseline: 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION',
  policy: files.q202Policy,
  appShellUsesQ202ProductionStateEnvelope: true,
  graphSourceMustBeMathLiveProductionState: true,
  historySourceMustBeMathLiveProductionState: true,
  solutionSourceMustBeMathLiveProductionState: true,
  evaluationSourceMustBeMathLiveProductionState: true,
  calculatorControllerSourceMustBeMathLiveProductionState: true,
  fallbackExpressionMayFeedGraphHistorySolution: false,
  visibleFallbackMirrorMayFeedGraphHistorySolution: false,
  staleCalculatorShadowMayFeedGraphHistorySolution: false,
  openPlaceholderMayGenerateFakeResult: false,
  openPlaceholderMayOpenGraph: false,
  openPlaceholderMayWriteRuntimeHistory: false,
  fakeGraphAllowed: false,
  fakeHistoryAllowed: false,
  fakeSolutionAllowed: false,
  graphUiMutationAllowed: false,
  graphControllerMutationAllowed: false,
  historyControllerMutationAllowed: false,
  historyPanelMutationAllowed: false,
  solutionStepsPanelMutationAllowed: false,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressOrderMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q202 ${key} expected ${expected}, got ${env[key]}`);
}

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_controller.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/solution/solution_steps_panel.dart',
];
const hashManifest = read('docs/audit/V172_Q202_PROTECTED_FILE_HASH_MANIFEST.md');
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  const h = sha256(rel);
  if (!hashManifest.includes(`${rel}: UNCHANGED \`${h}\``)) fail(`protected hash manifest mismatch for ${rel}`);
  const text = read(rel);
  for (const marker of ['Q202', 'ProductionGraphHistorySolutionStateFinalizationPolicy', 'production-state-finalized']) {
    if (text.includes(marker)) fail(`protected file polluted by ${marker}: ${rel}`);
  }
}

// Static Dart import/part resolution without Dart SDK.
const dartFiles = [];
function walkDart(dir) {
  for (const entry of fs.readdirSync(p(dir), { withFileTypes: true })) {
    const rel = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      if (['build', '.dart_tool', '.gradle', '.idea', 'node_modules'].includes(entry.name)) continue;
      walkDart(rel);
    } else if (entry.isFile() && entry.name.endsWith('.dart')) dartFiles.push(rel);
  }
}
for (const dir of ['lib', 'test']) if (exists(dir)) walkDart(dir);
const importRe = /^\s*import\s+['"]([^'"]+)['"]/gm;
const partRe = /^\s*part\s+['"]([^'"]+)['"]/gm;
for (const file of dartFiles) {
  const src = read(file);
  let m;
  while ((m = importRe.exec(src)) !== null) {
    const spec = m[1];
    if (spec.startsWith('dart:') || spec.startsWith('package:flutter') || spec.startsWith('package:flutter_test') || spec.startsWith('package:webview_flutter') || spec.startsWith('package:provider') || spec.startsWith('package:shared_preferences')) continue;
    if (spec.startsWith('package:mathpro_flutter_phase17/')) {
      const target = spec.replace('package:mathpro_flutter_phase17/', 'lib/');
      if (!exists(target)) fail(`${file} imports missing package target ${spec}`);
      continue;
    }
    if (spec.startsWith('.')) {
      const target = path.normalize(path.join(path.dirname(file), spec));
      if (!exists(target)) fail(`${file} imports missing relative target ${spec} -> ${target}`);
    }
  }
  while ((m = partRe.exec(src)) !== null) {
    const target = path.normalize(path.join(path.dirname(file), m[1]));
    if (!exists(target)) fail(`${file} has missing part target ${m[1]} -> ${target}`);
  }
}

// Package hygiene.
const forbiddenDirs = ['build', '.dart_tool', '.gradle', '.idea', 'node_modules', '__pycache__', '.pytest_cache'];
function walk(rel) {
  for (const entry of fs.readdirSync(p(rel), { withFileTypes: true })) {
    const child = path.join(rel, entry.name);
    if (entry.isDirectory()) {
      if (forbiddenDirs.includes(entry.name)) fail(`forbidden directory present: ${child}`);
      walk(child);
    } else if (entry.isFile()) {
      if (entry.name.endsWith('.pyc')) fail(`forbidden pyc present: ${child}`);
      if (entry.name.endsWith('.zip') || entry.name.endsWith('.apk') || entry.name.endsWith('.aab')) fail(`forbidden nested artifact present: ${child}`);
    }
  }
}
walk('.');

must(files.readme, 'V172-Q202 — Graph / History / Solution Production State Finalization');
must(files.pubspec, 'V172-Q202 finalizes Graph/History/Solution production state truth');
must('docs/audit/V172_Q202_GRAPH_HISTORY_SOLUTION_PRODUCTION_STATE_FINALIZATION_AUDIT_REPORT.md', 'V172-Q202 — Graph / History / Solution Production State Finalization');
must('docs/audit/V172_Q202_GRAPH_HISTORY_SOLUTION_PRODUCTION_STATE_FINALIZATION_CHANGED_FILES_MANIFEST.md', 'V172-Q202 changed files');
must('docs/audit/V172_Q202_PROTECTED_FILE_HASH_MANIFEST.md', 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_GRAPH_HISTORY_SOLUTION_PRODUCTION_STATE_FINALIZATION_Q202_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
