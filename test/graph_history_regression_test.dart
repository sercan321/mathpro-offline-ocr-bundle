import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_card.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_eligibility.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_fullscreen_page.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_painter.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_settings_sheet.dart';
import 'package:mathpro_flutter_phase17/features/history/history_controller.dart';
import 'package:mathpro_flutter_phase17/features/history/history_models.dart';
import 'package:mathpro_flutter_phase17/features/history/history_panel.dart';
import 'package:mathpro_flutter_phase17/features/history/history_storage.dart';

void main() {
  group('Graph eligibility contract', () {
    test('classifies explicit x expressions and y=f(x)', () {
      final direct = GraphEligibility.classify(expression: 'sin(x)', result: '—');
      expect(direct.kind, GraphEligibilityKind.graphableExplicit);
      expect(direct.normalizedExpression, 'sin(x)');

      final yEquals = GraphEligibility.classify(expression: 'y = x² - 4', result: '—');
      expect(yEquals.kind, GraphEligibilityKind.graphableExplicit);
      expect(yEquals.normalizedExpression, 'x^2 - 4');
    });

    test('classifies numeric results as constant suggestions only after evaluation', () {
      final numeric = GraphEligibility.classify(expression: '3 + 5', result: '8');
      expect(numeric.kind, GraphEligibilityKind.constantSuggestion);
      expect(numeric.normalizedExpression, '8');

      final noResult = GraphEligibility.classify(expression: '3 + 5', result: '—');
      expect(noResult.kind, GraphEligibilityKind.notGraphable);
    });

    test('classifies implicit x/y equality as future mode', () {
      final implicit = GraphEligibility.classify(expression: 'x² + y² = 1', result: '—');
      expect(implicit.kind, GraphEligibilityKind.implicitPending);
    });
  });

  group('Graph evaluator contract', () {
    test('evaluates supported premium graph primitives', () {
      expect(GraphExpressionEvaluator('x^2 + 3x - 1').evaluate(2), closeTo(9, 0.00001));
      expect(GraphExpressionEvaluator('sin(x)').evaluate(0), closeTo(0, 0.00001));
      expect(GraphExpressionEvaluator('sqrt(x)').evaluate(9), closeTo(3, 0.00001));
      expect(GraphExpressionEvaluator('log10(x)').evaluate(100), closeTo(2, 0.00001));
    });


    test('keeps graph domains honest for sqrt/log and accepts compact function input', () {
      expect(GraphExpressionEvaluator('√x').evaluate(9), closeTo(3, 0.00001));
      expect(GraphExpressionEvaluator('sqrtx').evaluate(9), closeTo(3, 0.00001));
      expect(GraphExpressionEvaluator('ln(x)').evaluate(1), closeTo(0, 0.00001));
      expect(GraphExpressionEvaluator('log(x)').evaluate(1), closeTo(0, 0.00001));
      expect(GraphExpressionEvaluator('sqrt(x)').evaluate(-1), isNull);
      expect(GraphExpressionEvaluator('ln(x)').evaluate(-1), isNull);
    });

    test('splits tan around vertical discontinuities instead of drawing a false bridge', () {
      final segments = GraphCurveSampler.sample(
        const GraphExpression(
          originalExpression: 'tan(x)',
          normalizedExpression: 'tan(x)',
          type: GraphType.explicit,
          xMin: -4,
          xMax: 4,
          yMin: -5,
          yMax: 5,
        ),
        samples: 420,
      );
      expect(segments.length, greaterThan(1));
      expect(segments.every((segment) => segment.length >= 2), isTrue);
    });

    test('draws constant functions as one continuous horizontal segment', () {
      final segments = GraphCurveSampler.sample(
        const GraphExpression(
          originalExpression: '3 + 5',
          normalizedExpression: '8',
          type: GraphType.constant,
          yMin: 3,
          yMax: 13,
        ),
        samples: 80,
      );
      expect(segments.length, 1);
      expect(segments.single.every((point) => (point.y - 8).abs() < 0.00001), isTrue);
    });
  });


  group('Fullscreen graph contract', () {
    testWidgets('exposes premium controls without touching keyboard contract', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: GraphFullscreenPage(
            expression: GraphExpression(
              originalExpression: 'sin(x)',
              normalizedExpression: 'sin(x)',
              type: GraphType.explicit,
            ),
          ),
        ),
      );

      expect(find.text('Tam Ekran Grafik'), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-fullscreen-graph-motion')), findsOneWidget);
      expect(find.text('Trace Off'), findsOneWidget);
      expect(find.text('Zoom +'), findsOneWidget);
      expect(find.text('Zoom −'), findsOneWidget);
      expect(find.text('Pan'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
      expect(find.text('Ayarlar'), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-graph-surface')), findsOneWidget);

      await tester.tap(find.text('Zoom +'));
      await tester.pump();
      await tester.tap(find.text('Zoom −'));
      await tester.pump();
      await tester.tap(find.text('Trace Off'));
      await tester.pump();

      expect(find.text('Trace On'), findsOneWidget);
    });
  });


  group('Graph settings contract', () {
    test('validates graph viewport ranges before applying settings', () {
      expect(
        GraphViewportPolicy.validateRange(xMin: -10, xMax: 10, yMin: -5, yMax: 5),
        isNull,
      );
      expect(
        GraphViewportPolicy.validateRange(xMin: 10, xMax: -10, yMin: -5, yMax: 5),
        isNotNull,
      );
      expect(
        GraphViewportPolicy.validateRange(xMin: 0, xMax: 0.00000001, yMin: -5, yMax: 5),
        isNotNull,
      );
      expect(
        GraphViewportPolicy.validateRange(xMin: -1e8, xMax: 1e8, yMin: -5, yMax: 5),
        isNotNull,
      );
      expect(
        GraphViewportPolicy.validateRange(xMin: double.nan, xMax: 10, yMin: -5, yMax: 5),
        isNotNull,
      );
    });

    testWidgets('rejects invalid settings and applies valid settings through the sheet', (tester) async {
      GraphExpression? applied;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GraphSettingsSheet(
              expression: const GraphExpression(
                originalExpression: 'sin(x)',
                normalizedExpression: 'sin(x)',
                type: GraphType.explicit,
              ),
              onApply: (value) => applied = value,
            ),
          ),
        ),
      );

      expect(find.text('Graph Settings'), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-graph-settings-window-fields')), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), '10');
      await tester.enterText(find.byType(TextField).at(1), '0');
      final applyButton = find.widgetWithText(ElevatedButton, 'Apply');
      tester.widget<ElevatedButton>(applyButton).onPressed?.call();
      await tester.pump();

      expect(applied, isNull);
      expect(find.text('Minimum değer maksimum değerden küçük olmalı.'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), '-6.28');
      await tester.enterText(find.byType(TextField).at(1), '6.28');
      await tester.enterText(find.byType(TextField).at(2), '-2');
      await tester.enterText(find.byType(TextField).at(3), '2');
      tester.widget<ElevatedButton>(applyButton).onPressed?.call();
      await tester.pump();

      expect(applied, isNotNull);
      expect(applied!.xMin, closeTo(-6.28, 0.00001));
      expect(applied!.xMax, closeTo(6.28, 0.00001));
      expect(applied!.yMin, closeTo(-2, 0.00001));
      expect(applied!.yMax, closeTo(2, 0.00001));
    });
  });


  group('Premium motion contract', () {
    testWidgets('graph preview uses simplified premium mini panel without text action clutter', (tester) async {
      var zoomedIn = false;
      var zoomedOut = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 320,
              width: 420,
              child: GraphCard(
                expression: const GraphExpression(
                  originalExpression: 'sin(x)',
                  normalizedExpression: 'sin(x)',
                  type: GraphType.explicit,
                ),
                onClose: () {},
                onFullscreen: () {},
                onSettings: () {},
                onTraceToggle: () {},
                onReset: () {},
                onZoomIn: () => zoomedIn = true,
                onZoomOut: () => zoomedOut = true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('mathpro-premium-graph-card')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-graph-canvas-preview')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-graph-compact-info-row')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-graph-floating-zoom-in')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-graph-floating-zoom-out')), findsOneWidget);
      expect(find.text('Trace On'), findsNothing);
      expect(find.text('Reset'), findsNothing);
      expect(find.text('Zoom +'), findsNothing);
      expect(find.text('Zoom −'), findsNothing);
      expect(find.text('Domain'), findsNothing);
      expect(find.text('Range'), findsNothing);

      await tester.tap(find.byKey(const ValueKey('mathpro-graph-floating-zoom-in')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('mathpro-graph-floating-zoom-out')));
      await tester.pump();
      expect(zoomedIn, isTrue);
      expect(zoomedOut, isTrue);
    });
  });

  group('History drawer contract', () {
    testWidgets('renders as a hidden-by-default premium panel surface when opened', (tester) async {
      final controller = HistoryController(enablePersistence: false);
      controller.addCalculation(expression: '3+5', result: '8', tabName: 'Temel');

      var closed = false;
      HistoryEntry? selected;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 620,
              child: HistoryPanel(
                controller: controller,
                onClose: () => closed = true,
                onEntrySelected: (entry) => selected = entry,
                onGraphSelected: (_) {},
                onResultSelected: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('mathpro-premium-history-panel')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-premium-history-list')), findsOneWidget);
      expect(find.text('Geçmiş'), findsOneWidget);
      expect(find.textContaining('1 kayıt'), findsOneWidget);
      expect(find.text('Bugün'), findsOneWidget);

      await tester.tap(find.byTooltip('Ara'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('mathpro-history-search-field')), findsOneWidget);

      await tester.enterText(find.byType(TextField), '3+5');
      await tester.pump();
      expect(find.text('3+5'), findsWidgets);

      await tester.tap(find.byKey(ValueKey('mathpro-history-entry-${controller.entries.first.id}')));
      await tester.pump();
      expect(selected?.expression, '3+5');

      await tester.tap(find.byTooltip('Kapat'));
      await tester.pump();
      expect(closed, isTrue);
    });

    testWidgets('supports upward swipe close without exposing the old crude handle', (tester) async {
      final controller = HistoryController(enablePersistence: false);
      var closed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HistoryPanel(
              controller: controller,
              onClose: () => closed = true,
              onEntrySelected: (_) {},
              onGraphSelected: (_) {},
              onResultSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('mathpro-premium-history-panel')), findsOneWidget);
      expect(find.byKey(const ValueKey('mathpro-history-handle')), findsNothing);

      await tester.drag(find.byKey(const ValueKey('mathpro-premium-history-panel')), const Offset(0, -80));
      await tester.pump();
      expect(closed, isTrue);
    });

    testWidgets('renders typed calculation, graph and error item cards with actionable metadata', (tester) async {
      final controller = HistoryController(enablePersistence: false);
      controller.addCalculation(expression: '3+5', result: '8', tabName: 'Temel');
      controller.addGraph(
        graphExpression: const GraphExpression(originalExpression: 'sin(x)', normalizedExpression: 'sin(x)', type: GraphType.explicit),
        result: '—',
        tabName: 'Cebir',
      );
      controller.addCalculation(
        expression: '√(□)',
        result: '—',
        tabName: 'Kalkülüs',
        errorState: 'Açık slotları doldurmadan değerlendirme yapılmadı.',
      );

      HistoryEntry? resultSelected;
      HistoryEntry? graphSelected;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 760,
              child: HistoryPanel(
                controller: controller,
                onClose: () {},
                onEntrySelected: (_) {},
                onGraphSelected: (entry) => graphSelected = entry,
                onResultSelected: (entry) => resultSelected = entry,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Hesap'), findsOneWidget);
      expect(find.text('Grafik'), findsOneWidget);
      expect(find.text('Hata'), findsOneWidget);
      expect(find.text('Grafiği Aç'), findsOneWidget);
      expect(find.text('Sonucu kullan'), findsOneWidget);
      expect(find.textContaining('Açık slotları'), findsOneWidget);
      expect(find.textContaining('x:'), findsOneWidget);

      await tester.ensureVisible(find.text('Sonucu kullan'));
      await tester.pump();
      await tester.tap(find.text('Sonucu kullan'));
      await tester.pump();
      expect(resultSelected?.result, '8');

      await tester.ensureVisible(find.text('Grafiği Aç'));
      await tester.pump();
      await tester.tap(find.text('Grafiği Aç'));
      await tester.pump();
      expect(graphSelected?.graphExpression?.normalizedExpression, 'sin(x)');

      graphSelected = null;
      final graphEntry = controller.entries.firstWhere((entry) => entry.hasGraph);
      await tester.ensureVisible(find.byKey(ValueKey('mathpro-history-entry-${graphEntry.id}')));
      await tester.tap(find.byKey(ValueKey('mathpro-history-entry-${graphEntry.id}')));
      await tester.pump();
      expect(graphSelected?.graphExpression?.normalizedExpression, 'sin(x)');
    });

    testWidgets('supports delete with undo from item long press actions', (tester) async {
      final controller = HistoryController(enablePersistence: false);
      controller.addCalculation(expression: '3+5', result: '8', tabName: 'Temel');
      final entryId = controller.entries.single.id;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 620,
              child: HistoryPanel(
                controller: controller,
                onClose: () {},
                onEntrySelected: (_) {},
                onGraphSelected: (_) {},
                onResultSelected: (_) {},
              ),
            ),
          ),
        ),
      );

      await tester.longPress(find.byKey(ValueKey('mathpro-history-entry-$entryId')));
      await tester.pumpAndSettle();
      expect(find.text('Sil'), findsOneWidget);

      await tester.tap(find.text('Sil'));
      await tester.pumpAndSettle();
      expect(controller.entries, isEmpty);
      expect(find.text('Geri al'), findsOneWidget);

      await tester.tap(find.text('Geri al'));
      await tester.pumpAndSettle();
      expect(controller.entries.single.id, entryId);
    });

    testWidgets('confirms clear all and supports undo restore', (tester) async {
      final controller = HistoryController(enablePersistence: false);
      controller.addCalculation(expression: '3+5', result: '8', tabName: 'Temel');
      controller.addCalculation(expression: '4+4', result: '8', tabName: 'Temel');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 620,
              child: HistoryPanel(
                controller: controller,
                onClose: () {},
                onEntrySelected: (_) {},
                onGraphSelected: (_) {},
                onResultSelected: (_) {},
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Temizle'));
      await tester.pumpAndSettle();
      expect(find.text('Geçmiş temizlensin mi?'), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Temizle'));
      await tester.pumpAndSettle();
      expect(controller.entries, isEmpty);

      await tester.tap(find.text('Geri al'));
      await tester.pumpAndSettle();
      expect(controller.entries.length, 2);
    });
  });

  group('History contract', () {
    test('classifies history item kinds and search metadata', () {
      final calculation = HistoryEntry(
        id: 'calc',
        expression: '3+5',
        result: '8',
        tabName: 'Temel',
        timestamp: DateTime(2026, 5, 10, 17, 0),
      );
      final graph = HistoryEntry(
        id: 'graph',
        expression: 'y = sin(x)',
        result: '—',
        tabName: 'Cebir',
        timestamp: DateTime(2026, 5, 10, 17, 1),
        graphExpression: const GraphExpression(originalExpression: 'sin(x)', normalizedExpression: 'sin(x)', type: GraphType.explicit),
      );
      final error = HistoryEntry(
        id: 'error',
        expression: '√(□)',
        result: '—',
        tabName: 'Kalkülüs',
        timestamp: DateTime(2026, 5, 10, 17, 2),
        errorState: 'Açık slotları doldurmadan değerlendirme yapılmadı.',
      );

      expect(calculation.kind, HistoryEntryKind.calculation);
      expect(calculation.canUseResult, isTrue);
      expect(graph.kind, HistoryEntryKind.graph);
      expect(graph.searchText, contains('sin(x)'));
      expect(error.kind, HistoryEntryKind.error);
      expect(error.resultLabel, contains('Açık slotları'));
    });

    test('keeps sectioning, pinning and graph metadata in memory', () {
      final controller = HistoryController(enablePersistence: false);
      controller.addCalculation(expression: '3+5', result: '8', tabName: 'Temel');
      controller.addGraph(
        graphExpression: const GraphExpression(originalExpression: 'sin(x)', normalizedExpression: 'sin(x)', type: GraphType.explicit),
        result: '—',
        tabName: 'Cebir',
      );

      expect(controller.entries.length, 2);
      expect(controller.sections().first.title, 'Bugün');
      expect(controller.entries.first.hasGraph, isTrue);

      controller.togglePinned(controller.entries.first.id);
      expect(controller.sections().first.title, 'Sabitlenenler');
      expect(controller.sections(query: 'sin').expand((section) => section.entries).length, 1);

      final deleted = controller.delete(controller.entries.first.id);
      expect(deleted, isNotNull);
      expect(controller.entries.length, 1);
      controller.restoreDeleted(deleted!);
      expect(controller.entries.length, 2);

      final removed = controller.clearAndReturn();
      expect(removed.length, 2);
      expect(controller.entries, isEmpty);
      controller.restoreBatch(removed);
      expect(controller.entries.length, 2);
    });



    test('persists and restores calculation, graph metadata, pinned state and errors', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final writer = HistoryController();
      await writer.restoreCompleted;
      writer.addCalculation(expression: '3+5', result: '8', tabName: 'Temel');
      writer.addGraph(
        graphExpression: const GraphExpression(
          originalExpression: 'sin(x)',
          normalizedExpression: 'sin(x)',
          type: GraphType.explicit,
          xMin: -6.28,
          xMax: 6.28,
          yMin: -2,
          yMax: 2,
          traceEnabled: false,
        ),
        result: '—',
        tabName: 'Cebir',
      );
      writer.addCalculation(
        expression: '√(□)',
        result: '—',
        tabName: 'Kalkülüs',
        errorState: 'Açık slotları doldurmadan değerlendirme yapılmadı.',
      );
      writer.togglePinned(writer.entries.first.id);
      await writer.persistCompleted;
      writer.dispose();

      final reader = HistoryController();
      await reader.restoreCompleted;
      expect(reader.restored, isTrue);
      expect(reader.entries.length, 3);
      expect(reader.entries.any((entry) => entry.pinned), isTrue);
      expect(reader.entries.any((entry) => entry.hasError), isTrue);
      final graph = reader.entries.singleWhere((entry) => entry.hasGraph).graphExpression!;
      expect(graph.normalizedExpression, 'sin(x)');
      expect(graph.xMin, closeTo(-6.28, 0.00001));
      expect(graph.xMax, closeTo(6.28, 0.00001));
      expect(graph.traceEnabled, isFalse);
      reader.dispose();
    });

    test('history storage uses a bounded schema envelope and rejects corrupted payloads', () {
      final entries = List<HistoryEntry>.generate(
        90,
        (index) => HistoryEntry(
          id: 'entry-$index',
          expression: '$index+1',
          result: '${index + 1}',
          tabName: 'Temel',
          timestamp: DateTime(2026, 5, 10, 17, index % 60),
        ),
      );

      final encoded = HistoryStorage.encode(entries);
      final decoded = HistoryStorage.decodeForTest(encoded);
      expect(decoded.length, HistoryStorage.maxStoredEntries);
      expect(decoded.first.id, 'entry-0');
      expect(HistoryStorage.decodeForTest('{broken-json'), isEmpty);
      expect(HistoryStorage.decodeForTest('{"schemaVersion":1,"entries":[]}'), isEmpty);
    });

    test('keeps graph history entries linked while viewport metadata changes', () {
      final controller = HistoryController(enablePersistence: false);
      final first = controller.addGraph(
        graphExpression: const GraphExpression(
          originalExpression: 'sin(x)',
          normalizedExpression: 'sin(x)',
          type: GraphType.explicit,
        ),
        result: '—',
        tabName: 'Cebir',
      );
      controller.togglePinned(first.id);

      final reopened = controller.addGraph(
        graphExpression: const GraphExpression(
          originalExpression: 'sin(x)',
          normalizedExpression: 'sin(x)',
          type: GraphType.explicit,
          xMin: -6.28,
          xMax: 6.28,
          yMin: -2,
          yMax: 2,
          traceEnabled: false,
        ),
        result: '—',
        tabName: 'Cebir',
      );

      expect(reopened.id, first.id);
      expect(controller.entries.length, 1);
      expect(controller.entries.single.pinned, isTrue);
      expect(controller.entries.single.graphExpression?.xMin, closeTo(-6.28, 0.00001));
      expect(controller.entries.single.graphExpression?.traceEnabled, isFalse);

      final updated = controller.updateGraphEntry(
        id: reopened.id,
        graphExpression: reopened.graphExpression!.copyWith(
          xMin: -2,
          xMax: 2,
          yMin: -1,
          yMax: 1,
          traceEnabled: true,
        ),
        result: '—',
        tabName: 'Cebir',
      );

      expect(updated, isNotNull);
      expect(controller.entries.length, 1);
      expect(controller.entries.single.id, first.id);
      expect(controller.entries.single.graphExpression?.xMin, closeTo(-2, 0.00001));
      expect(controller.entries.single.graphExpression?.traceEnabled, isTrue);
      expect(controller.updateGraphEntry(id: 'missing', graphExpression: updated!.graphExpression!), isNull);
    });

    test('serializes graph history entries without losing metadata', () {
      final entry = HistoryEntry(
        id: '1',
        expression: 'y = sin(x)',
        result: '—',
        tabName: 'Cebir',
        timestamp: DateTime(2026, 5, 10, 17, 0),
        graphExpression: const GraphExpression(originalExpression: 'sin(x)', normalizedExpression: 'sin(x)', type: GraphType.explicit),
        pinned: true,
      );

      final restored = HistoryEntry.fromJson(entry.toJson());
      expect(restored, isNotNull);
      expect(restored!.pinned, isTrue);
      expect(restored.graphExpression?.normalizedExpression, 'sin(x)');
    });
  });
}
