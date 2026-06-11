#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (msg) => { console.error(`[FAIL] ${msg}`); process.exit(1); };
const must = (text, needle, label) => { if (!text.includes(needle)) fail(`missing ${label}: ${needle}`); };
const mustNot = (text, needle, label) => { if (text.includes(needle)) fail(`forbidden ${label}: ${needle}`); };

const appShell = read('lib/app/app_shell.dart');
const policy = read('lib/app/appshell_rebuild_granularity_q382r21_policy.dart');
const bridge = read('assets/mathlive/mathlive_prod_bridge.js');
const premiumKey = read('lib/features/keyboard/premium_key.dart');

must(policy, "static const String phase = 'V172-Q382R21'", 'Q382R21 policy phase');
must(policy, 'appshell-rebuild-granularity-keyboard-dock-out-of-calculator-hot-path', 'Q382R21 contract marker');
must(policy, 'calculatorAnimatedBuilderScopedToWorkspace = true', 'workspace scoped calculator builder policy');
must(policy, 'keyboardDockOutsideCalculatorAnimatedBuilder = true', 'keyboard dock outside calculator hot path policy');
must(policy, 'historyRemovedFromAppShellHotPathMerge = true', 'history removed from hot path merge policy');

must(appShell, 'V172-Q382R21: keep the keyboard dock out of CalculatorController', 'Q382R21 AppShell marker');
must(appShell, 'Widget _buildCalculatorWorkspace()', 'calculator workspace helper');
must(appShell, 'animation: _calculator', 'calculator scoped AnimatedBuilder');
must(appShell, "key: const ValueKey('mathpro-normal-workspace')", 'normal workspace key preserved');
must(appShell, "key: const ValueKey('mathpro-history-visible-panel')", 'history key preserved');
must(appShell, "key: const ValueKey('mathpro-keyboard-dock-visible')", 'keyboard dock key preserved');
must(appShell, 'child: BottomDock(', 'BottomDock preserved');
must(appShell, 'onKeyPressed: _handleKeyPressed', 'keyboard dispatch preserved');
must(appShell, 'solutionStepsSnapshot: solutionStepsSnapshot', 'solution snapshot still passed to workspace');
must(appShell, '_solutionStepsSnapshotFor(', 'Q382R18 memoized solution helper preserved');

mustNot(appShell, 'Listenable.merge(<Listenable>[_calculator, _history])', 'calculator/history merged hot path');
mustNot(appShell, 'animation: Listenable.merge(<Listenable>[_calculator, _history])', 'merged AppShell AnimatedBuilder');

const helperStart = appShell.indexOf('Widget _buildCalculatorWorkspace()');
const helperEnd = appShell.indexOf('SolutionStepsSnapshot _solutionStepsSnapshotFor', helperStart);
if (helperStart < 0 || helperEnd < 0) fail('could not locate _buildCalculatorWorkspace helper boundaries');
const helper = appShell.slice(helperStart, helperEnd);
must(helper, 'AnimatedBuilder(', 'calculator helper AnimatedBuilder');
must(helper, 'animation: _calculator', 'calculator helper listens only to calculator');
must(helper, 'WorkspacePanel(', 'workspace preserved inside calculator helper');
mustNot(helper, 'BottomDock(', 'BottomDock inside calculator hot path');
mustNot(helper, 'HistoryPanel(', 'HistoryPanel inside calculator hot path');
mustNot(helper, '_history', 'history controller inside calculator hot path');

const buildStart = appShell.indexOf('Widget build(BuildContext context)');
const buildHelperStart = appShell.indexOf('Widget _buildCalculatorWorkspace()', buildStart);
if (buildStart < 0 || buildHelperStart < 0) fail('could not locate build/helper split');
const buildOnly = appShell.slice(buildStart, buildHelperStart);
must(buildOnly, 'return Scaffold(', 'Scaffold outside calculator AnimatedBuilder');
must(buildOnly, 'HistoryPanel(', 'history still rendered by shell');
must(buildOnly, 'BottomDock(', 'keyboard dock rendered by shell');
mustNot(buildOnly, 'AnimatedBuilder(\n      animation: Listenable.merge', 'top-level merged AnimatedBuilder');

// Prior latency optimizations and pan rollback must remain intact.
must(bridge, "const KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE = 'V172-Q382R19'", 'Q382R19 MathLive state budget preserved');
must(premiumKey, "import 'premium_key_feedback_safety_q382r20_policy.dart';", 'Q382R20 PremiumKey policy preserved');
mustNot(premiumKey, 'child: AnimatedContainer(', 'PremiumKey AnimatedContainer regression');
for (const forbidden of ['q382R13', 'q382R14', 'q382R16', 'direct-pan', 'host-scrollport-force', 'document-capture']) {
  mustNot(bridge, forbidden, `old pan marker ${forbidden}`);
}
for (const rel of [
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r13_policy.dart',
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r14_policy.dart',
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r16_policy.dart',
]) {
  if (exists(rel)) fail(`pan experiment policy must not exist: ${rel}`);
}

console.log('PASS verify_appshell_rebuild_granularity_v172_q382r21');
