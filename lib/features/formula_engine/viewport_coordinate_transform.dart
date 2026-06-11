import 'dart:math' as math;
import 'package:flutter/widgets.dart';

import '../editor/slot_registry.dart';
import 'slot_hit_testing.dart';

class MathViewportCoordinateTransform {
  const MathViewportCoordinateTransform._();

  static const String version = 'mathpro-core-editor-phase-f-viewport-transform-v1';
  static const double matrixEpsilon = 0.0001;

  static Offset viewportToCanvas({required Offset viewportPoint, required Matrix4 transform}) {
    final inverse = Matrix4.copy(transform);
    final determinant = inverse.invert();
    if (determinant.abs() <= matrixEpsilon) return viewportPoint;
    return MatrixUtils.transformPoint(inverse, viewportPoint);
  }

  static Offset canvasToViewport({required Offset canvasPoint, required Matrix4 transform}) {
    return MatrixUtils.transformPoint(transform, canvasPoint);
  }

  static Rect canvasRectToViewport({required Rect canvasRect, required Matrix4 transform}) {
    return _boundingRectForTransformedCorners(canvasRect, transform);
  }

  static Rect viewportRectToCanvas({required Rect viewportRect, required Matrix4 transform}) {
    final inverse = Matrix4.copy(transform);
    final determinant = inverse.invert();
    if (determinant.abs() <= matrixEpsilon) return viewportRect;
    return _boundingRectForTransformedCorners(viewportRect, inverse);
  }

  static bool hasMeaningfulDelta(Matrix4 before, Matrix4 after, {double epsilon = matrixEpsilon}) {
    final beforeStorage = before.storage;
    final afterStorage = after.storage;
    for (var i = 0; i < 16; i += 1) {
      if ((beforeStorage[i] - afterStorage[i]).abs() > epsilon) return true;
    }
    return false;
  }

  static double approximateScale(Matrix4 transform) {
    final storage = transform.storage;
    final scaleX = math.sqrt(storage[0] * storage[0] + storage[1] * storage[1]);
    final scaleY = math.sqrt(storage[4] * storage[4] + storage[5] * storage[5]);
    if (scaleX == 0 && scaleY == 0) return 1;
    if (scaleX == 0) return scaleY;
    if (scaleY == 0) return scaleX;
    return (scaleX + scaleY) / 2;
  }

  static Rect _boundingRectForTransformedCorners(Rect rect, Matrix4 transform) {
    final points = <Offset>[
      MatrixUtils.transformPoint(transform, rect.topLeft),
      MatrixUtils.transformPoint(transform, rect.topRight),
      MatrixUtils.transformPoint(transform, rect.bottomLeft),
      MatrixUtils.transformPoint(transform, rect.bottomRight),
    ];
    final left = points.map((point) => point.dx).reduce(math.min);
    final right = points.map((point) => point.dx).reduce(math.max);
    final top = points.map((point) => point.dy).reduce(math.min);
    final bottom = points.map((point) => point.dy).reduce(math.max);
    return Rect.fromLTRB(left, top, right, bottom);
  }
}

class MathViewportSlotHitTesting {
  const MathViewportSlotHitTesting._();

  static SlotHitTestResult? hitTestViewportPoint({
    required Offset viewportPoint,
    required Matrix4 canvasToViewportTransform,
    required Map<SlotEntry, Rect> visualRects,
  }) {
    final canvasPoint = MathViewportCoordinateTransform.viewportToCanvas(
      viewportPoint: viewportPoint,
      transform: canvasToViewportTransform,
    );
    return SlotHitTesting.hitTest(canvasPoint, visualRects);
  }
}
