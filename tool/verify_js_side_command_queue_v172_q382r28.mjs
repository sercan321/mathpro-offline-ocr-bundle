#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (message) => { console.error(`FAIL verify_js_side_command_queue_v172_q382r28: ${message}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} must not contain ${needle}`); };

const required = [
  'lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'test/v172_q382r28_js_side_command_queue_test.dart',
  'tool/verify_js_side_command_queue_v172_q382r28.mjs',
  'docs/audit/V172_Q382R28_JS_SIDE_COMMAND_QUEUE.md',
  'docs/audit/V172_Q382R28_CHANGED_FILES.md',
];
for (const rel of required) if (!exists(rel)) fail(`missing required file ${rel}`);

must('lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart', "static const String phase = 'V172-Q382R28'");
must('lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart', 'q382r28-js-side-command-queue-active');
must('lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart', 'useJsSideQueueForInsertLatex = true');
must('lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart', 'useJsSideQueueForDeleteBackward = true');
must('lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart', 'useJsSideQueueForClear = false');
must('lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart', 'optimisticEchoScopeExpanded = false');
must('lib/features/mathlive/mathlive_js_side_command_queue_q382r28_policy.dart', 'panDragScrollReintroduced = false');

must('lib/features/mathlive/mathlive_main_editor_surface.dart', "import 'mathlive_js_side_command_queue_q382r28_policy.dart';");
must('lib/features/mathlive/mathlive_production_editor_surface.dart', 'MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction(command.action)');
must('lib/features/mathlive/mathlive_production_editor_surface.dart', 'window.MathProProductionMathLiveBridge.enqueueKeyboardCommand($payload)');
must('lib/features/mathlive/mathlive_production_editor_surface.dart', 'q382r28-dart-to-js-side-queue-dispatch-$label-$sequence');
must('lib/features/mathlive/mathlive_production_editor_surface.dart', '_productionCommandTail');
must('lib/features/mathlive/mathlive_production_editor_surface.dart', "'clear' => 'window.MathProProductionMathLiveBridge.clear($payload)'");

must('assets/mathlive/mathlive_prod_bridge.js', "const JS_SIDE_COMMAND_QUEUE_PHASE = 'V172-Q382R28'");
must('assets/mathlive/mathlive_prod_bridge.js', 'const q382r28JsSideCommandQueue = []');
must('assets/mathlive/mathlive_prod_bridge.js', 'function enqueueKeyboardCommand(payload)');
must('assets/mathlive/mathlive_prod_bridge.js', 'function q382r28DrainKeyboardCommandQueue()');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r28-js-side-command-queued-sequence-safe');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r28-js-side-command-processing-sequence-safe');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r28-js-side-command-drain-complete');
must('assets/mathlive/mathlive_prod_bridge.js', 'enqueueKeyboardCommand,');
must('assets/mathlive/mathlive_prod_bridge.js', "if (action === 'insertLatex') insertLatex(payload);");
must('assets/mathlive/mathlive_prod_bridge.js', "else if (action === 'deleteBackward') deleteBackward(payload);");
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r28JsSideCommandQueueDepth');
must('assets/mathlive/mathlive_prod_bridge.js', 'pendingCommands.length + q382r28JsSideCommandQueue.length');

for (const rel of ['assets/mathlive/mathlive_prod_bridge.js', 'lib/features/mathlive/mathlive_production_editor_surface.dart']) {
  mustNot(rel, 'document.addEventListener(\'touchmove\'');
  mustNot(rel, 'direct-pan');
  mustNot(rel, 'host-scrollport-force');
  mustNot(rel, 'document-capture');
}

console.log('PASS verify_js_side_command_queue_v172_q382r28');
