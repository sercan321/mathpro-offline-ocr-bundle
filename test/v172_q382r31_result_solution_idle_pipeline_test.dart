import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/solution/result_solution_idle_pipeline_q382r31.dart';

void main() {
  group('V172-Q382R31 Result/Solution Idle Pipeline', () {
    test('policy is narrow and preserves protected input surfaces', () {
      expect(ResultSolutionIdlePipelineQ382R31Policy.phase, 'V172-Q382R31');
      expect(ResultSolutionIdlePipelineQ382R31Policy.marker, 'q382r31-result-solution-idle-pipeline-active');
      expect(ResultSolutionIdlePipelineQ382R31Policy.expressionFrameUpdatesImmediately, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.resultAndStatusFrameIdleDebounced, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.solutionComposerUsesIdleSnapshot, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.evaluateFlushesIdlePipelineImmediately, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.graphHistoryExplicitActionsFlushIdlePipeline, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.preserveKeyboardLayoutOrderLabels, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.preserveMoreAndLongPressInventory, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.preserveMathLiveNativeCaretAuthority, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.preserveOptimisticEchoScope, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.preserveOcrGraphHistorySemantics, isTrue);
      expect(ResultSolutionIdlePipelineQ382R31Policy.idleDelay.inMilliseconds, 140);
    });

    test('AppShell debounces result/status and SolutionSteps off the key hot path', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      expect(appShell, contains("import '../features/solution/result_solution_idle_pipeline_q382r31.dart';"));
      expect(appShell, contains('Timer? _q382r31ResultSolutionIdleTimer'));
      expect(appShell, contains('CalculatorState? _q382r31PendingResultSolutionState'));
      expect(appShell, contains('late CalculatorState _q382r31ResultSolutionIdleState'));
      expect(appShell, contains('_scheduleQ382R31ResultSolutionIdlePipeline(state)'));
      expect(appShell, contains('ResultSolutionIdlePipelineQ382R31Policy.idleDelay'));
      expect(appShell, contains('_flushQ382R31ResultSolutionIdlePipelineForExplicitAction'));
      expect(appShell, contains('solutionCalculatorState = ResultSolutionIdlePipelineQ382R31Policy.solutionComposerUsesIdleSnapshot'));
      expect(appShell, contains('resultState: _q382r31ResultSolutionIdleState'));
    });

    test('explicit actions flush the idle pipeline before evaluate, graph, and Solution open', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      expect(appShell, contains("_calculator.handleKey('↵');\n    _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();"));
      expect(appShell, contains('if (ResultSolutionIdlePipelineQ382R31Policy.graphHistoryExplicitActionsFlushIdlePipeline)'));
      expect(appShell, contains('if (willOpen) {\n      _flushQ382R31ResultSolutionIdlePipelineForExplicitAction();\n    }'));
      expect(appShell, contains("source: 'q378-approved-ocr-workspace-import',"));
      expect(appShell, contains('_flushQ382R31ResultSolutionIdlePipelineForExplicitAction();\n    await _mathLiveMainEditor.setLatexFromApprovedOcrImport(trimmed);'));
    });

    test('protected keyboard, MORE, MathLive JS, and Android files are untouched by Q382R31', () {
      for (final path in <String>[
        'lib/features/keyboard/key_config.dart',
        'lib/features/keyboard/bottom_dock.dart',
        'lib/features/keyboard/long_press_popup.dart',
        'lib/logic/action_utils.dart',
        'assets/mathlive/mathlive_prod_bridge.js',
        'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
      ]) {
        final source = File(path).readAsStringSync();
        expect(source, isNot(contains('V172-Q382R31')));
        expect(source, isNot(contains('q382r31-result-solution-idle-pipeline-active')));
      }
    });
  });
}
