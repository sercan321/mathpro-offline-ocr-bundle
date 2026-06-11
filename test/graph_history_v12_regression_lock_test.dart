import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mathpro_flutter_phase17/features/graph/graph_eligibility.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_painter.dart';
import 'package:mathpro_flutter_phase17/features/history/history_controller.dart';
import 'package:mathpro_flutter_phase17/features/history/history_models.dart';
import 'package:mathpro_flutter_phase17/features/history/history_storage.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/key_config.dart';

void main() {
  group('Graph + History V12 final regression lock', () {
    test('locks frozen keyboard topology and critical long-press contracts', () {
      expect(
        KeyConfig.tabs,
        equals(<String>['Temel', 'Cebir', 'Kalkülüs', 'Kompleks', 'Lineer Cebir']),
      );
      expect(
        KeyConfig.basicCoreKeyboard,
        equals(<List<String?>>[
          <String?>['C', '⌫', '%', '÷'],
          <String?>['7', '8', '9', '×'],
          <String?>['4', '5', '6', '−'],
          <String?>['1', '2', '3', '+'],
          <String?>['MORE', '0', '.', 'Ans'],
        ]),
      );

      for (final tab in KeyConfig.tabs.where((tab) => tab != 'Temel')) {
        final sections = KeyConfig.buildKeyboardSections(tab);
        final grid = sections.expandedGridRows!;
        expect(grid.length, 8, reason: '$tab expanded grid row count changed');
        expect(grid.every((row) => row.length == 5), isTrue, reason: '$tab expanded grid column count changed');
      }

      final cebirGrid = KeyConfig.buildKeyboardSections('Cebir').expandedGridRows!;
      expect(cebirGrid.last.map((cell) => cell.label).toList(growable: false), equals(<String?>['MORE', '0', '.', '=', '↵']));
      expect(KeyConfig.getKeyBehavior('='), KeyBehaviorType.textInsert);
      expect(KeyConfig.getKeyBehavior('↵'), KeyBehaviorType.command);
      expect(KeyConfig.getLongPressOptions('∫□dx', 'Kalkülüs'), equals(<String>['∫□dx', '∫ₐᵇ', '∬', '∭', '∮']));
      expect(KeyConfig.getLongPressOptions('□^□', 'Cebir'), containsAll(<String>['□²', '□³', '□ⁿ', '□⁻¹']));
    });

    test('locks graph eligibility matrix and graph sampling safety', () {
      final explicit = GraphEligibility.classify(expression: 'sin(x)', result: '—');
      expect(explicit.kind, GraphEligibilityKind.graphableExplicit);
      expect(explicit.normalizedExpression, 'sin(x)');

      final yEquals = GraphEligibility.classify(expression: 'y = x² - 4', result: '—');
      expect(yEquals.kind, GraphEligibilityKind.graphableExplicit);
      expect(yEquals.normalizedExpression, 'x^2 - 4');

      final constant = GraphEligibility.classify(expression: '3 + 5', result: '8');
      expect(constant.kind, GraphEligibilityKind.constantSuggestion);
      expect(GraphEligibility.expressionFromEligibility(originalExpression: '3 + 5', result: constant).type, GraphType.constant);

      expect(GraphEligibility.classify(expression: '3 + 5', result: '—').kind, GraphEligibilityKind.notGraphable);
      expect(GraphEligibility.classify(expression: 'x² + y² = 1', result: '—').kind, GraphEligibilityKind.implicitPending);

      final sqrtSegments = GraphCurveSampler.sample(
        const GraphExpression(
          originalExpression: '√x',
          normalizedExpression: 'sqrt(x)',
          type: GraphType.explicit,
          xMin: -4,
          xMax: 9,
          yMin: -2,
          yMax: 4,
        ),
        samples: 180,
      );
      expect(sqrtSegments.expand((segment) => segment).every((point) => point.x >= 0), isTrue);

      final tanSegments = GraphCurveSampler.sample(
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
      expect(tanSegments.length, greaterThan(1));
    });

    test('locks graph settings viewport policy against invalid values', () {
      expect(GraphViewportPolicy.validateRange(xMin: -10, xMax: 10, yMin: -5, yMax: 5), isNull);
      expect(GraphViewportPolicy.validateRange(xMin: 10, xMax: -10, yMin: -5, yMax: 5), isNotNull);
      expect(GraphViewportPolicy.validateRange(xMin: -1, xMax: 1, yMin: 3, yMax: 3), isNotNull);
      expect(GraphViewportPolicy.validateRange(xMin: double.nan, xMax: 1, yMin: -1, yMax: 1), isNotNull);
      expect(GraphViewportPolicy.validateRange(xMin: -1e8, xMax: 1e8, yMin: -1, yMax: 1), isNotNull);
    });

    test('locks history persistence schema, metadata, duplicate safety and pinned preservation', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final writer = HistoryController();
      await writer.restoreCompleted;

      final first = writer.addGraph(
        graphExpression: const GraphExpression(
          originalExpression: 'sin(x)',
          normalizedExpression: 'sin(x)',
          type: GraphType.explicit,
        ),
        result: '—',
        tabName: 'Cebir',
      );
      writer.togglePinned(first.id);

      final reopened = writer.addGraph(
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
      writer.addCalculation(expression: '3+5', result: '8', tabName: 'Temel');
      writer.addCalculation(expression: '√(□)', result: '—', tabName: 'Kalkülüs', errorState: 'Açık slotları doldurmadan değerlendirme yapılmadı.');
      await writer.persistCompleted;
      writer.dispose();

      expect(reopened.id, first.id);

      final encoded = HistoryStorage.encode(<HistoryEntry>[
        HistoryEntry(
          id: 'graph',
          expression: 'y = sin(x)',
          result: '—',
          tabName: 'Cebir',
          timestamp: DateTime(2026, 5, 10, 17),
          pinned: true,
          graphExpression: const GraphExpression(
            originalExpression: 'sin(x)',
            normalizedExpression: 'sin(x)',
            type: GraphType.explicit,
            traceEnabled: false,
          ),
        ),
      ]);
      expect(encoded, contains('"schemaVersion":2'));
      expect(encoded, contains('"graphExpression"'));

      final reader = HistoryController();
      await reader.restoreCompleted;
      expect(reader.entries.length, 3);
      expect(reader.entries.where((entry) => entry.hasGraph).length, 1);
      final restoredGraphEntry = reader.entries.singleWhere((entry) => entry.hasGraph);
      expect(restoredGraphEntry.pinned, isTrue);
      expect(restoredGraphEntry.graphExpression?.xMin, closeTo(-6.28, 0.00001));
      expect(restoredGraphEntry.graphExpression?.traceEnabled, isFalse);
      expect(reader.entries.any((entry) => entry.hasError), isTrue);
      reader.dispose();
    });

    test('locks runtime source against stale/dead UI contract drift', () {
      final runtimeFiles = Directory('lib')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .toList(growable: false);

      for (final file in runtimeFiles) {
        final source = file.readAsStringSync();
        expect(source.contains('mathpro-history-handle'), isFalse, reason: file.path);
        expect(source.contains('onPressed: null'), isFalse, reason: file.path);
        expect(source.contains('onTap: null'), isFalse, reason: file.path);
      }

      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec.contains('shared_preferences: ^2.5.5'), isTrue);

      final readme = File('README.md').readAsStringSync().toLowerCase();
      expect(readme.contains('history remains removed'), isFalse);
      expect(readme.contains('history kaldırıldı'), isFalse);
    });
  });
}
