import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/workspace/result_status_compact_copy.dart';
import 'package:mathpro_flutter_phase17/features/workspace/result_status_compact_copy_policy.dart';
import 'package:mathpro_flutter_phase17/features/workspace/result_view.dart';

void main() {
  test('V172-Q232 policy records compact result-status copy constraints', () {
    expect(ResultStatusCompactCopyPolicy.phase, 'V172-Q232');
    expect(ResultStatusCompactCopyPolicy.centralStatusCopyResolverAdded, isTrue);
    expect(ResultStatusCompactCopyPolicy.fullAndCompactCopyVariantsAvailable, isTrue);
    expect(ResultStatusCompactCopyPolicy.graphOpenForcesCompactResultStatus, isTrue);
    expect(ResultStatusCompactCopyPolicy.compressedResultPanelForcesCompactResultStatus, isTrue);
    expect(ResultStatusCompactCopyPolicy.resultStatusSingleLine, isTrue);
    expect(ResultStatusCompactCopyPolicy.resultStatusSoftWrapDisabled, isTrue);
    expect(ResultStatusCompactCopyPolicy.resultStatusOverflowUsesFadeNotEllipsisDots, isTrue);
    expect(ResultStatusCompactCopyPolicy.resultValueHasPriorityOverStatusMessage, isTrue);
    expect(ResultStatusCompactCopyPolicy.keyboardMutationAllowed, isFalse);
    expect(ResultStatusCompactCopyPolicy.moreMutationAllowed, isFalse);
    expect(ResultStatusCompactCopyPolicy.longPressMutationAllowed, isFalse);
    expect(ResultStatusCompactCopyPolicy.mathLiveProductionMutationAllowed, isFalse);
    expect(ResultStatusCompactCopyPolicy.graphEngineMutationAllowed, isFalse);
    expect(ResultStatusCompactCopyPolicy.solutionPanelMutationAllowed, isFalse);
    expect(ResultStatusCompactCopyPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(ResultStatusCompactCopyPolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(ResultStatusCompactCopyPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
  });

  test('V172-Q232 resolver maps long raw reasons to premium full and compact copy', () {
    final openSlot = ResultStatusCopyResolver.resolve('Açık slotları doldurmadan değerlendirme yapılmadı.');
    expect(openSlot.full, 'Açık slotları doldurun');
    expect(openSlot.compact, 'Slot bekleniyor');

    final unsupported = ResultStatusCopyResolver.resolve('Bu ifade şu anda değerlendirilemiyor.');
    expect(unsupported.full, 'İfade değerlendirilemiyor');
    expect(unsupported.compact, 'Değerlendirilemedi');

    final graph = ResultStatusCopyResolver.resolve('Bu ifade grafik gösterimi için uygun değil.');
    expect(graph.full, 'Grafik için uygun değil');
    expect(graph.compact, 'Grafik uygun değil');

    final invalid = ResultStatusCopyResolver.resolve('Kapanış parantezi eksik.');
    expect(invalid.full, 'Geçersiz ifade');
    expect(invalid.compact, 'Geçersiz');

    final calcError = ResultStatusCopyResolver.resolve('Sayısal sonuç sonlu değil.');
    expect(calcError.full, 'Hesaplama hatası');
    expect(calcError.compact, 'Hata');
  });

  testWidgets('V172-Q232 graph-open ResultView renders compact slot copy as one line', (tester) async {
    const longOpenSlotMessage = 'Açık slotları doldurmadan değerlendirme yapılmadı.';

    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 188,
            height: 34,
            child: ResultView(
              value: '—',
              resultStatusMessage: longOpenSlotMessage,
              forceCompactStatus: true,
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('mathpro-result-status-message')), findsOneWidget);
    expect(find.text('Slot bekleniyor'), findsOneWidget);
    expect(find.text(longOpenSlotMessage), findsNothing);

    final text = tester.widget<Text>(find.byKey(const ValueKey('mathpro-result-status-message')));
    expect(text.maxLines, 1);
    expect(text.softWrap, isFalse);
    expect(text.overflow, TextOverflow.fade);
  });

  testWidgets('V172-Q232 actual result keeps priority over status copy', (tester) async {
    const longOpenSlotMessage = 'Açık slotları doldurmadan değerlendirme yapılmadı.';

    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 260,
            height: 56,
            child: ResultView(
              value: '42',
              resultStatusMessage: longOpenSlotMessage,
              forceCompactStatus: true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Slot bekleniyor'), findsNothing);
    expect(find.text(longOpenSlotMessage), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-result-status-message')), findsNothing);
    expect(find.byKey(const ValueKey('mathpro-result-math-render-surface')), findsOneWidget);
  });

  test('V172-Q232 source wires graph/compressed compact mode without protected route mutation', () {
    final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
    final resultView = File('lib/features/workspace/result_view.dart').readAsStringSync();
    final resolver = File('lib/features/workspace/result_status_compact_copy.dart').readAsStringSync();

    expect(workspace, contains('resultStatusMessage: resultStatusMessage'));
    expect(workspace, isNot(contains('resultStatusCompactMode')));
    expect(workspace, contains('GraphCard('));
    expect(resultView, contains('ResultStatusCopyResolver.displayText'));
    expect(resultView, contains('maxLines: 1'));
    expect(resultView, contains('softWrap: false'));
    expect(resultView, contains('TextOverflow.fade'));
    expect(resultView, isNot(contains('TextOverflow.ellipsis')));
    expect(resolver, contains("compact: 'Slot bekleniyor'"));
    expect(resolver, contains("full: 'Açık slotları doldurun'"));
  });
}
