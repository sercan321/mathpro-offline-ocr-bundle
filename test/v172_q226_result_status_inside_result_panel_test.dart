import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/result_status_message_inside_result_panel_policy.dart';
import 'package:mathpro_flutter_phase17/features/workspace/result_view.dart';
import 'package:mathpro_flutter_phase17/state/calculator_state.dart';

void main() {
  test('V172-Q226 policy records result status routing and protected surface constraints', () {
    expect(ResultStatusMessageInsideResultPanelPolicy.phase, 'V172-Q226');
    expect(ResultStatusMessageInsideResultPanelPolicy.resultStatusMessageStateAdded, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.resultStatusMessageRendersInsideResultPanel, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.resultValueHasPriorityOverStatusMessage, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.resultAndStatusNeverRenderTogether, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.independentWorkspaceKeyboardStatusStripRemoved, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.workspaceKeyboardGapBudgetReleased, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.statusMessageMaxTwoLinesWithEllipsis, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.statusMessageUsesMutedPremiumStyle, isTrue);
    expect(ResultStatusMessageInsideResultPanelPolicy.keyboardMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.moreMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.longPressMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.graphMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.historyMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.solutionMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.appShellMutationAllowed, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(ResultStatusMessageInsideResultPanelPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
  });

  testWidgets('V172-Q226 ResultView shows resultStatusMessage only when actual result is absent', (tester) async {
    const message = 'Açık slotları doldurmadan değerlendirme yapılmadı.';

    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 320,
            height: 72,
            child: ResultView(value: '—', resultStatusMessage: message),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('mathpro-result-status-message')), findsOneWidget);
    expect(find.text('Açık slotları doldurun'), findsOneWidget);
    expect(find.text(message), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsNothing);

    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 320,
            height: 72,
            child: ResultView(value: '1', resultStatusMessage: message),
          ),
        ),
      ),
    );

    expect(find.text(message), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-result-status-message')), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsOneWidget);
  });

  test('V172-Q226 source removes the independent workspace-keyboard status strip', () {
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final resultView = File('lib/features/workspace/result_view.dart').readAsStringSync();
    const calculatorState = CalculatorState(lastUnsupportedReason: 'Açık slotları doldurmadan değerlendirme yapılmadı.');

    expect(calculatorState.resultStatusMessage, 'Açık slotları doldurmadan değerlendirme yapılmadı.');
    expect(calculatorState.hasResultStatusMessage, isTrue);

    expect(workspace, contains('final resultStatusMessage = statusText?.trim() ??'));
    expect(workspace, contains('resultStatusMessage: resultStatusMessage'));
    expect(workspace, isNot(contains('class _StatusLine')));
    expect(workspace, isNot(contains('showStatus')));
    expect(workspace, isNot(contains('statusHeight')));
    expect(workspace, isNot(contains('statusGap')));

    expect(resultView, contains('final resultStatusMessage = widget.resultStatusMessage?.trim() ??'));
    expect(resultView, contains("key: const ValueKey('mathpro-result-status-message')"));
    expect(resultView, contains('maxLines: 1'));
    expect(resultView, contains('TextOverflow.fade'));
    expect(resultView, contains('ResultStatusCopyResolver.displayText'));
    expect(resultView, contains('if (!hasResultValue && resultStatusMessage.isNotEmpty)'));
    expect(resultView, contains('if (!hasResultValue)'));
  });
}
