#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (message) => { console.error(`FAIL verify_result_solution_idle_pipeline_v172_q382r31: ${message}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} must not contain ${needle}`); };

const required = [
  'lib/features/solution/result_solution_idle_pipeline_q382r31.dart',
  'lib/app/app_shell.dart',
  'test/v172_q382r31_result_solution_idle_pipeline_test.dart',
  'tool/verify_result_solution_idle_pipeline_v172_q382r31.mjs',
  'docs/audit/V172_Q382R31_RESULT_SOLUTION_IDLE_PIPELINE.md',
  'docs/audit/V172_Q382R31_CHANGED_FILES.md',
];
for (const rel of required) if (!exists(rel)) fail(`missing required file ${rel}`);

must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', "static const String phase = 'V172-Q382R31'");
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'q382r31-result-solution-idle-pipeline-active');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'expressionFrameUpdatesImmediately = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'resultAndStatusFrameIdleDebounced = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'solutionComposerUsesIdleSnapshot = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'evaluateFlushesIdlePipelineImmediately = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'graphHistoryExplicitActionsFlushIdlePipeline = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'preserveKeyboardLayoutOrderLabels = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'preserveMoreAndLongPressInventory = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'preserveMathLiveNativeCaretAuthority = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'preserveOptimisticEchoScope = true');
must('lib/features/solution/result_solution_idle_pipeline_q382r31.dart', 'idleDelay = Duration(milliseconds: 140)');

must('lib/app/app_shell.dart', "import '../features/solution/result_solution_idle_pipeline_q382r31.dart';");
must('lib/app/app_shell.dart', 'Timer? _q382r31ResultSolutionIdleTimer');
must('lib/app/app_shell.dart', 'CalculatorState? _q382r31PendingResultSolutionState');
must('lib/app/app_shell.dart', 'late CalculatorState _q382r31ResultSolutionIdleState');
must('lib/app/app_shell.dart', '_q382r31ResultSolutionIdleTimer?.cancel();');
must('lib/app/app_shell.dart', '_scheduleQ382R31ResultSolutionIdlePipeline(state)');
must('lib/app/app_shell.dart', 'ResultSolutionIdlePipelineQ382R31Policy.idleDelay');
must('lib/app/app_shell.dart', 'solutionCalculatorState = ResultSolutionIdlePipelineQ382R31Policy.solutionComposerUsesIdleSnapshot');
must('lib/app/app_shell.dart', 'resultState: _q382r31ResultSolutionIdleState');
must('lib/app/app_shell.dart', 'expressionState: _calculator.state');
must('lib/app/app_shell.dart', '_flushQ382R31ResultSolutionIdlePipelineForExplicitAction');
must('lib/app/app_shell.dart', "_calculator.handleKey('↵');\n    _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();");
must('lib/app/app_shell.dart', 'if (ResultSolutionIdlePipelineQ382R31Policy.graphHistoryExplicitActionsFlushIdlePipeline)');
must('lib/app/app_shell.dart', 'if (willOpen) {\n      _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();\n    }');

for (const rel of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/logic/action_utils.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
]) {
  mustNot(rel, 'V172-Q382R31');
  mustNot(rel, 'q382r31-result-solution-idle-pipeline-active');
}

for (const rel of ['assets/mathlive/mathlive_prod_bridge.js', 'lib/features/mathlive/mathlive_production_editor_surface.dart']) {
  mustNot(rel, 'document.addEventListener(\'touchmove\'');
  mustNot(rel, 'direct-pan');
  mustNot(rel, 'host-scrollport-force');
  mustNot(rel, 'document-capture');
}

console.log('PASS verify_result_solution_idle_pipeline_v172_q382r31');
