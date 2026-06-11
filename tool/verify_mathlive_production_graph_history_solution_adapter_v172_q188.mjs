#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_graph_history_solution_adapter_v172_q188.mjs', preservedPhase: 'verify_mathlive_production_graph_history_solution_adapter_v172_q188' });

const files = {
  policy: 'lib/features/mathlive/mathlive_production_graph_history_solution_adapter_policy.dart',
  appShell: 'lib/app/app_shell.dart',
  runtimeSync: 'lib/features/mathlive/mathlive_runtime_sync_binding_policy.dart',
  graphAdapter: 'lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart',
  historyAdapter: 'lib/features/mathlive/mathlive_history_adapter_policy.dart',
  solutionAdapter: 'lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart',
  q188Test: 'test/v172_q188_production_graph_history_solution_adapter_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  graphCard: 'lib/features/graph/graph_card.dart',
  graphController: 'lib/features/graph/graph_controller.dart',
  historyController: 'lib/features/history/history_controller.dart',
  historyPanel: 'lib/features/history/history_panel.dart',
  solutionPanel: 'lib/features/solution/solution_steps_panel.dart',
  keyConfig: 'lib/features/keyboard/key_config.dart',
  mathKeyboard: 'lib/features/keyboard/math_keyboard.dart',
  longPressPopup: 'lib/features/keyboard/long_press_popup.dart',
  templateTray: 'lib/features/workspace/template_tray.dart',
};

const failures = [];
const text = {};
for (const [name, path] of Object.entries(files)) {
  if (!fs.existsSync(path)) failures.push(`missing required file: ${path}`);
  else text[name] = fs.readFileSync(path, 'utf8');
}
const has = (name, needle) => {
  if (!text[name]?.includes(needle)) failures.push(`${files[name]} missing ${needle}`);
};
const lacks = (name, needle) => {
  if (text[name]?.includes(needle)) failures.push(`${files[name]} must not contain ${needle}`);
};

has('policy', "phase = 'V172-Q188'");
has('policy', "snapshotSource = 'q188-production-mathlive-adapter-snapshot'");
has('policy', "evaluationSource = 'q188-production-mathlive-adapter-evaluation'");
has('policy', 'productionAdapterBindingFrozen = true');
has('policy', 'consumesMathLiveLatexState = true');
has('policy', 'feedsCalculatorController = true');
has('policy', 'feedsGraphEligibility = true');
has('policy', 'feedsHistoryPayload = true');
has('policy', 'feedsSolutionEvaluatorCandidate = true');
has('policy', 'graphCardMutationAllowed = false');
has('policy', 'historyPanelMutationAllowed = false');
has('policy', 'solutionStepsPanelMutationAllowed = false');
has('policy', 'keyboardLayoutMutationAllowed = false');
has('policy', 'productionBridgePublicApiMutationAllowed = false');
has('policy', 'fakeGraphAllowed = false');
has('policy', 'fakeHistoryAllowed = false');
has('policy', 'fakeSolutionAllowed = false');
has('policy', 'MathLiveRuntimeSyncBindingPolicy.buildEnvelope');
has('policy', '_promoteToQ188');
has('policy', 'phase: phase');
has('policy', 'protectedUiMutationAllowed: false');
has('policy', 'fakeSolutionGenerated: false');
has('policy', 'photomathLevelClaimed: false');

if (text.appShell.includes('mathlive_production_graph_history_solution_state_finalization_policy.dart')) {
  has('appShell', 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.buildFinalizedProductionEnvelope');
  has('appShell', 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForController');
  has('appShell', 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForEvaluation');
  has('appShell', 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.expressionForHistory');
  has('appShell', 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.snapshotSource');
  has('appShell', 'MathLiveProductionGraphHistorySolutionStateFinalizationPolicy.evaluationSource');
} else {
  has('appShell', "mathlive_production_graph_history_solution_adapter_policy.dart");
  has('appShell', 'MathLiveProductionGraphHistorySolutionAdapterPolicy.buildProductionEnvelope');
  has('appShell', 'MathLiveProductionGraphHistorySolutionAdapterPolicy.expressionForController');
  has('appShell', 'MathLiveProductionGraphHistorySolutionAdapterPolicy.expressionForEvaluation');
  has('appShell', 'MathLiveProductionGraphHistorySolutionAdapterPolicy.expressionForHistory');
  has('appShell', 'MathLiveProductionGraphHistorySolutionAdapterPolicy.snapshotSource');
  has('appShell', 'MathLiveProductionGraphHistorySolutionAdapterPolicy.evaluationSource');
}
lacks('appShell', "import '../features/mathlive/mathlive_runtime_sync_binding_policy.dart';");
lacks('appShell', 'MathLiveRuntimeSyncBindingPolicy.buildEnvelope');
lacks('appShell', 'MathLiveRuntimeSyncBindingPolicy.expressionForController');
lacks('appShell', 'MathLiveRuntimeSyncBindingPolicy.expressionForEvaluation');
lacks('appShell', 'MathLiveRuntimeSyncBindingPolicy.expressionForHistory');

has('runtimeSync', 'MathLiveGraphEligibilityAdapterPolicy.classifyNormalized');
has('runtimeSync', 'MathLiveHistoryAdapterPolicy.buildEntryEnvelope');
has('runtimeSync', 'MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope');
has('graphAdapter', 'GraphEligibility.classify');
has('historyAdapter', 'inputEngine = \'mathlive\'');
has('solutionAdapter', 'fakeSolutionGenerated: false');
has('solutionAdapter', 'runtimeSolutionWriteAllowed: false');

has('q188Test', 'MathLiveProductionGraphHistorySolutionAdapterPolicy.phase');
has('q188Test', 'buildProductionEnvelope');
has('q188Test', "MathLiveEditorStateSnapshot.fromLatex(r'y=x^{2}')");
has('q188Test', 'shouldBlockFakeSolution');
has('q188Test', 'canWriteRuntimeHistory');
has('manifest', 'v172Q188ProductionGraphHistorySolutionAdapter');
has('manifest', 'V172-Q188-MATHLIVE-PRODUCTION-GRAPH-HISTORY-SOLUTION-ADAPTER');
has('readme', 'V172-Q188 — Production Graph / History / Solution Adapter');

// Q188 must not mutate protected UI files with Q188 logic/markers.
for (const protectedName of ['graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel', 'keyConfig', 'mathKeyboard', 'longPressPopup', 'templateTray']) {
  if (text[protectedName]?.includes('V172-Q188') || text[protectedName]?.includes('q188-production')) {
    failures.push(`${files[protectedName]} contains Q188 marker; protected UI/keyboard surface was touched`);
  }
}

// Q188 must keep the Q186 minimal production bridge public API frozen.
for (const forbidden of ['executeMathProCommand', 'getState:', 'scheduleMount:', 'flushQueuedCommands']) {
  lacks('prodBridge', forbidden);
}
for (const required of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) {
  has('prodBridge', required);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER_Q188_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER_Q188_PACKAGE_READY_BUT_FLUTTER_DEVICE_EVIDENCE_REQUIRED');
