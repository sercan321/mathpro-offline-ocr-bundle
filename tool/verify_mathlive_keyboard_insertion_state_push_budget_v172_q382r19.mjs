#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (msg) => { console.error(`[FAIL] ${msg}`); process.exit(1); };
const must = (text, needle, label) => { if (!text.includes(needle)) fail(`missing ${label}: ${needle}`); };
const mustNot = (text, needle, label) => { if (text.includes(needle)) fail(`forbidden ${label}: ${needle}`); };

const bridge = read('assets/mathlive/mathlive_prod_bridge.js');
const surface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const policy = read('lib/features/mathlive/mathlive_keyboard_insertion_state_push_budget_q382r19_policy.dart');
const q382r24PolicyExists = exists('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart');

must(policy, "static const String phase = 'V172-Q382R19'", 'Q382R19 policy phase');
must(policy, 'serialProductionCommandQueuePreserved = true', 'serial queue preservation policy');
must(policy, 'androidBridgeCommandTimeoutPreserved = true', 'timeout preservation policy');
must(policy, 'keyboardInsertionCanonicalStatePushBudget = 1', 'canonical state budget policy');
must(policy, 'keyboardInsertionSettleStatePushBudget = 1', 'settle state budget policy');

must(bridge, "const KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE = 'V172-Q382R19'", 'JS phase marker');
if (q382r24PolicyExists) {
  must(bridge, 'KEYBOARD_INSERTION_NATIVE_EVENT_SUPPRESSION_MS = 64', 'Q382R24 native event suppression window supersedes Q382R19 24ms window');
  must(bridge, 'Q382R24_KEYBOARD_SETTLE_PUSH_AFTER_CANONICAL_ALLOWED = false', 'Q382R24 settle push suppression flag');
} else {
  must(bridge, 'KEYBOARD_INSERTION_NATIVE_EVENT_SUPPRESSION_MS = 24', 'native event suppression window');
}
must(bridge, 'function beginKeyboardInsertionBudget(reason)', 'keyboard insertion begin helper');
must(bridge, 'function finishKeyboardInsertionBudget(reason)', 'keyboard insertion finish helper');
must(bridge, 'function keyboardInsertionBudgetActive()', 'keyboard insertion active guard');
must(bridge, 'function scheduleKeyboardInsertionSettlePush(reason)', 'single settle push scheduler');
must(bridge, 'state.q382r19KeyboardInsertionCanonicalPushCount += 1', 'canonical push counter');
must(bridge, 'state.q382r19NativeEventCaretPushSuppressedCount += 1', 'suppressed native event counter');
must(bridge, 'q382r19-native-caret-event-push-coalesced-during-keyboard-insertion', 'native event coalescing trace');
must(bridge, "pushCaretState(tag + '-16ms-single-settle')", 'single short settle push helper retained');
must(bridge, "beginKeyboardInsertionBudget('q382r19-insert-latex-keyboard-insertion-budget')", 'insert latex insertion mode');
must(bridge, "beginKeyboardInsertionBudget('q382r19-delete-backward-keyboard-insertion-budget')", 'delete insertion mode');
must(bridge, "beginKeyboardInsertionBudget('q382r19-clear-keyboard-insertion-budget')", 'clear insertion mode');
must(bridge, "completeCommand(state.lastInsertCommitted ? 'q190-production-insert-ok' : 'q190-production-insert-fail', { keyboardInsertion: true })", 'insert complete budget path');
must(bridge, "completeCommand('q190-production-delete-backward', { keyboardInsertion: true })", 'delete complete budget path');
must(bridge, "completeCommand('q190-production-clear', { keyboardInsertion: true })", 'clear complete budget path');

// The old 80ms command caret push must remain only in the non-keyboard branch for
// pointer/focus/setLatex/mount compatibility. The keyboard branch must not call it.
const keyboardBranchStart = bridge.indexOf('if (keyboardInsertion) {');
const keyboardBranchEnd = bridge.indexOf('} else if (!options || options.deferred !== false)', keyboardBranchStart);
if (keyboardBranchStart < 0 || keyboardBranchEnd < 0) fail('completeCommand keyboard branch not found');
const keyboardBranch = bridge.slice(keyboardBranchStart, keyboardBranchEnd);
mustNot(keyboardBranch, 'q201-native-caret-80ms', '80ms command caret push inside keyboard insertion branch');
if (q382r24PolicyExists) {
  must(keyboardBranch, 'q382r24KeyboardSettlePushSuppressedCount += 1', 'Q382R24 keyboard settle push suppressed in keyboard branch');
} else {
  must(keyboardBranch, 'scheduleKeyboardInsertionSettlePush', 'Q382R19 keyboard branch schedules single settle push');
}
must(bridge.slice(keyboardBranchEnd), "pushCaretState(tag + '-q201-native-caret-80ms')", 'non-keyboard 80ms caret compatibility branch');

// Do not reintroduce Q382 pan experiments or global document capture.
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

must(surface, 'MathLiveProductionTapLatencyCadencePolicy.redundantDartStateRefreshAfterEveryKeyDispatch', 'Dart post-dispatch refresh gate still present');
must(surface, 'MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout', 'Android bridge command timeout still preserved');
mustNot(surface, 'runJavaScriptReturningResult', 'returning-result dispatch must not be reintroduced');
mustNot(surface, 'await _refreshProductionStateDeferred(reason: \'q277r3-production-command-refresh', 'direct awaited deferred refresh in command tail');

console.log('PASS verify_mathlive_keyboard_insertion_state_push_budget_v172_q382r19');
