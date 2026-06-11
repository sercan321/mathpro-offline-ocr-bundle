import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/workspace_frame_isolation_q382r30.dart';

void main() {
  group('V172-Q382R30 Workspace Frame Isolation', () {
    test('policy is narrow and preserves protected surfaces', () {
      expect(WorkspaceFrameIsolationQ382R30Policy.phase, 'V172-Q382R30');
      expect(WorkspaceFrameIsolationQ382R30Policy.marker, 'q382r30-workspace-frame-isolation-active');
      expect(WorkspaceFrameIsolationQ382R30Policy.isolateExpressionAndResultFrame, isTrue);
      expect(WorkspaceFrameIsolationQ382R30Policy.cacheStructuralWorkspaceShell, isTrue);
      expect(WorkspaceFrameIsolationQ382R30Policy.preserveKeyboardLayoutOrderLabels, isTrue);
      expect(WorkspaceFrameIsolationQ382R30Policy.preserveMoreAndLongPressInventory, isTrue);
      expect(WorkspaceFrameIsolationQ382R30Policy.preserveMathLiveNativeCaretAuthority, isTrue);
      expect(WorkspaceFrameIsolationQ382R30Policy.optimisticEchoScopeUnchanged, isTrue);
      expect(WorkspaceFrameIsolationQ382R30Policy.graphSolutionHistorySemanticsUnchanged, isTrue);
    });

    test('hot snapshot equality prevents redundant notifier churn', () {
      const a = WorkspaceFrameHotSnapshotQ382R30(
        expressionText: '123',
        resultText: '123',
        statusText: '',
      );
      const b = WorkspaceFrameHotSnapshotQ382R30(
        expressionText: '123',
        resultText: '123',
        statusText: '',
      );
      const c = WorkspaceFrameHotSnapshotQ382R30(
        expressionText: '1234',
        resultText: '123',
        statusText: '',
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a == c, isFalse);
    });

    test('AppShell caches structural workspace shell and updates hot frame through a ValueNotifier', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      expect(appShell, contains('_WorkspaceStructuralKeyQ382R30'));
      expect(appShell, contains('ValueNotifier<WorkspaceFrameHotSnapshotQ382R30> _q382r30WorkspaceHotFrame'));
      expect(appShell, contains('_calculator.addListener(_handleQ382R30CalculatorFrameChanged)'));
      expect(appShell, contains('_calculator.removeListener(_handleQ382R30CalculatorFrameChanged)'));
      expect(appShell, contains('_q382r30CachedWorkspaceKey'));
      expect(appShell, contains('_q382r30CachedWorkspace'));
      expect(appShell, contains('WorkspaceFrameIsolationQ382R30Policy.cacheStructuralWorkspaceShell'));
      expect(appShell, contains('q382r30HotFrameListenable: _q382r30WorkspaceHotFrame'));
      expect(appShell, contains('solutionExpression: _stepsPanelState.isOpen'));
      expect(appShell, contains('if (next == _q382r30WorkspaceHotFrame.value) return;'));
    });

    test('WorkspacePanel confines expression/result rebuilds to ValueListenable frame sections', () {
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
      expect(workspace, contains('q382r30HotFrameListenable'));
      expect(workspace, contains('_Q382R30ExpressionFrameSection'));
      expect(workspace, contains('_Q382R30ResultFrameSection'));
      expect(workspace, contains('ValueListenableBuilder<WorkspaceFrameHotSnapshotQ382R30>'));
      expect(workspace, contains('MathLiveProductionEditorSurface('));
      expect(workspace, contains('expressionText: frame.expressionText'));
      expect(workspace, contains('lastAnswer: frame.resultText'));
      expect(workspace, contains('ResultView('));
      expect(workspace, contains('value: resultText'));
    });

    test('protected input and runtime surfaces are not mutated by Q382R30', () {
      for (final path in <String>[
        'lib/features/keyboard/key_config.dart',
        'lib/features/keyboard/bottom_dock.dart',
        'lib/features/keyboard/long_press_popup.dart',
        'lib/logic/action_utils.dart',
        'assets/mathlive/mathlive_prod_bridge.js',
      ]) {
        expect(File(path).readAsStringSync(), isNot(contains('V172-Q382R30')));
      }
    });
  });
}
