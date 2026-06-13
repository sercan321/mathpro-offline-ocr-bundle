import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_models.dart';
import 'package:mathpro_flutter_phase17/features/graph/graph_surface_3d.dart';

void main() {
  test('Q389R6C focuses periodic 3D ribbon to a controlled one-period viewport', () {
    const expression = GraphExpression(
      originalExpression: 'sin(x)',
      normalizedExpression: 'sin(x)',
      type: GraphType.explicit,
      xMin: -10,
      xMax: 10,
      yMin: -10,
      yMax: 10,
    );

    final focused = Graph3DViewportPolicy.focusedExpressionFor3D(expression);
    expect(focused.xMin, closeTo(-math.pi, 0.001));
    expect(focused.xMax, closeTo(math.pi, 0.001));
    expect(focused.yMin, closeTo(-1.35, 0.001));
    expect(focused.yMax, closeTo(1.35, 0.001));
  });

  test('Q389R6C source keeps 3D interaction local to the graph surface and adds ridge/tooltip features', () {
    final surface3d = File('lib/features/graph/graph_surface_3d.dart').readAsStringSync();
    final fullscreen = File('lib/features/graph/graph_fullscreen_page.dart').readAsStringSync();
    final keyboard = File('lib/features/keyboard/math_keyboard.dart').readAsStringSync();

    expect(surface3d, contains('mathpro-graph-3d-gesture-surface-q389r6c'));
    expect(surface3d, contains('onPanUpdate'));
    expect(surface3d, contains('_wrapRadians'));
    expect(surface3d, contains('Tepe hattı'));
    expect(surface3d, contains('Dip hattı'));
    expect(surface3d, contains('Kök hattı'));
    expect(surface3d, contains('mathpro-graph-3d-critical-feature-tooltip-q389r6c'));
    expect(surface3d, contains('GraphCriticalPointDetector.detect'));
    expect(fullscreen, contains('Sürükle: 360° döndür'));
    expect(fullscreen, contains('if (_renderMode == GraphRenderMode.threeD)'));
    expect(keyboard, isNot(contains('q389r6c')));
  });
}
