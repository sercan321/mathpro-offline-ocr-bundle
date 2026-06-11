import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Graph / History V14 static safety lock', () {
    test('keeps graph trace math and history drag math typed as double', () {
      final graphPainter = File('lib/features/graph/graph_painter.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();

      expect(graphPainter.contains('math.max(0.0, expression.xMin)'), isTrue);
      expect(graphPainter.contains('math.max(0, ' 'expression.xMin)'), isFalse);
      expect(historyPanel.contains('math.min(0.0, math.max(-88.0,'), isTrue);
      expect(historyPanel.contains('math.min(0, ' 'math.max(-88,'), isFalse);
    });

    test('does not contain fake Flutter PASS wording in current audit docs', () {
      final files = <File>[
        File('README.md'),
        ...Directory('docs/audit')
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('.md') || file.path.endsWith('.txt')),
      ];

      for (final file in files) {
        final source = file.readAsStringSync();
        expect(source.contains('flutter analyze ' 'PASS'), isFalse, reason: file.path);
        expect(source.contains('flutter test ' 'PASS'), isFalse, reason: file.path);
        expect(source.contains('flutter run ' 'PASS'), isFalse, reason: file.path);
      }
    });
  });
}
