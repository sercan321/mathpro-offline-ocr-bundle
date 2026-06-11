import 'dart:convert';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/renderer_sync_geometry_policy.dart';

void main() {
  test('Q132R2 maps MathJax SVG geometry from centered WebView root into editor canvas', () {
    RendererSyncGeometryPolicy.clearRendererGeometrySnapshot();
    final capturedAtMs = DateTime.now().millisecondsSinceEpoch;
    final message = jsonEncode({
      'status': 'geometry',
      'epoch': 7,
      'tex': r'\displaystyle x^{\Box}',
      'capturedAtMs': capturedAtMs,
      'devicePixelRatio': 3,
      'root': {'width': 180.0, 'height': 96.0},
      'svg': {'left': 45.0, 'top': 9.6, 'width': 90.0, 'height': 48.0},
      'elementRects': [
        {'domIndex': 0, 'tagName': 'rect', 'className': '', 'text': '□', 'left': 90.0, 'top': 24.0, 'width': 18.0, 'height': 20.0},
      ],
    });

    RendererSyncGeometryPolicy.recordRendererGeometryMessage(message);

    const canvas = Size(400, 160);
    final root = RendererSyncGeometryPolicy.rendererRootRectForCanvas(canvas)!;
    expect(root.left, closeTo(110.0, 0.01));
    expect(root.top, closeTo(14.4, 0.01));
    expect(root.width, closeTo(180.0, 0.01));
    expect(root.height, closeTo(96.0, 0.01));

    final content = RendererSyncGeometryPolicy.rendererContentRectForCanvas(canvas)!;
    expect(content.left, closeTo(155.0, 0.01));
    expect(content.top, closeTo(24.0, 0.01));
    expect(content.width, closeTo(90.0, 0.01));
    expect(content.height, closeTo(48.0, 0.01));

    final elements = RendererSyncGeometryPolicy.latestSnapshot!.elementRectsForCanvas(canvas);
    expect(elements.single.rect.left, closeTo(200.0, 0.01));
    expect(elements.single.rect.top, closeTo(38.4, 0.01));
    expect(elements.single.rect.width, closeTo(18.0, 0.01));
    expect(elements.single.rect.height, closeTo(20.0, 0.01));
  });
}
