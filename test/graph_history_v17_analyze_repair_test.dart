import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('V17 analyze/test log repair lock', () {
    test('inline history actions must not use StatefulWidget widget getter', () {
      final source = File('lib/features/history/history_item_card.dart').readAsStringSync();
      expect(source.contains('if (entry.graphExpression != null && onGraphTap != null)'), isTrue);
      expect(source.contains('if (widget.entry.graphExpression != null && widget.onGraphTap != null) _PillAction'), isFalse);
    });

    test('graph settings trace control avoids deprecated active color API', () {
      final source = File('lib/features/graph/graph_settings_sheet.dart').readAsStringSync();
      expect(source.contains('activeColor:'), isFalse);
      expect(source.contains('class _TraceOption'), isTrue);
      expect(source.contains('GraphStyle.accent.withValues'), isTrue);
    });
  });
}
