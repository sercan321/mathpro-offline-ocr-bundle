import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_critical_points.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';

void main() {
  test('Q389R6B detects roots and extremum for a simple quadratic without a bottom analysis card', () {
    const expression = GraphExpression(
      originalExpression: 'x^2 - 4',
      normalizedExpression: 'x^2-4',
      type: GraphType.explicit,
      xMin: -5,
      xMax: 5,
      yMin: -6,
      yMax: 8,
    );

    final points = GraphCriticalPointDetector.detect(expression);
    expect(points.any((point) => point.hasType(GraphCriticalPointType.root) && (point.x + 2).abs() < 0.08), isTrue);
    expect(points.any((point) => point.hasType(GraphCriticalPointType.root) && (point.x - 2).abs() < 0.08), isTrue);
    expect(points.any((point) => point.hasType(GraphCriticalPointType.localMinimum) && point.x.abs() < 0.08 && (point.y + 4).abs() < 0.10), isTrue);
  });

  test('Q389R6B graph source uses graph-overlaid marker tooltip interaction, not a permanent important-points card', () {
    final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
    final fullscreen = File('lib/features/graph/graph_fullscreen_page.dart').readAsStringSync();
    final overlay = File('lib/features/graph/graph_interaction_overlay.dart').readAsStringSync();
    final settings = File('lib/features/graph/graph_settings_sheet.dart').readAsStringSync();

    expect(graphCard, contains('GraphInteractiveSurface'));
    expect(fullscreen, contains('GraphInteractiveSurface'));
    expect(overlay, contains('mathpro-graph-critical-point-marker-layer-q389r6b'));
    expect(overlay, contains('mathpro-graph-critical-point-tooltip-q389r6b'));
    expect(overlay, contains('mathpro-graph-coordinate-tooltip-q389r6b'));
    expect(settings, contains('mathpro-graph-critical-point-toggles-q389r6b'));
    expect(graphCard, isNot(contains('Önemli Noktalar Kartı')));
    expect(graphCard, isNot(contains('Important Points Card')));
  });
}
