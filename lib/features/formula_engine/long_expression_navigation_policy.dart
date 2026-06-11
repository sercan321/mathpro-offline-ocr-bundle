import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/widgets.dart' show EdgeInsets, Matrix4;

import 'viewport_coordinate_transform.dart';
import 'renderer_sync_geometry_policy.dart';
import 'premium_editor_performance_policy.dart';

/// Central policy for long-expression navigation, caret follow and safe canvas
/// bounds.
///
/// This is intentionally UI/editor-only. It does not claim solver/CAS support.
/// The goal is to make long and nested expressions inspectable on phones while
/// preserving the frozen keyboard and existing workspace shell.
class LongExpressionNavigationPolicy {
  const LongExpressionNavigationPolicy._();

  static const String version = 'mathpro-v172l-long-expression-navigation-renderer-sync-caret-rail-v1';

  static const double minScale = 0.55;
  static const double maxScale = 1.9;
  static const double maxCanvasWidth = PremiumEditorPerformancePolicy.maxMeasuredExpressionWidth;
  static const double minimumLongCanvasMultiplier = 2.35;

  static bool shouldEnableNavigation({
    required String expression,
    required double viewportWidth,
    required double measuredExpressionWidth,
    required bool hasInteractiveSlots,
  }) {
    final clean = expression.trim();
    if (clean.isEmpty) return false;
    final isWide = measuredExpressionWidth > viewportWidth * 1.10;
    final hasSlotsNearEdge = hasInteractiveSlots && measuredExpressionWidth > viewportWidth * 0.92;
    return isWide || hasSlotsNearEdge || isDeeplyNested(clean) || hasWideStructuralSurface(clean);
  }

  static bool shouldEnableScale({
    required String expression,
    required double viewportWidth,
    required double measuredExpressionWidth,
  }) {
    final clean = expression.trim();
    if (clean.isEmpty) return false;
    return measuredExpressionWidth > viewportWidth * 1.55 || maxParenthesisDepth(clean) >= 4 || hasLargeMatrix(clean);
  }

  static double canvasWidthFor({
    required double viewportWidth,
    required double measuredExpressionWidth,
  }) {
    final preferred = math.max(viewportWidth * minimumLongCanvasMultiplier, viewportWidth + measuredExpressionWidth);
    return preferred.clamp(viewportWidth, math.max(viewportWidth * minimumLongCanvasMultiplier, maxCanvasWidth)).toDouble();
  }

  static EdgeInsets boundaryMarginFor({
    required bool navigationEnabled,
    required double viewportWidth,
    required double viewportHeight,
  }) {
    if (!navigationEnabled) {
      return const EdgeInsets.symmetric(horizontal: 96, vertical: 48);
    }
    return EdgeInsets.symmetric(
      horizontal: math.max(220.0, viewportWidth * 0.42),
      vertical: math.max(96.0, viewportHeight * 0.42),
    );
  }



  /// V172-F: when the active selection is inside a filled structural slot of a
  /// long expression, keep the *caret rail* visible rather than only the coarse
  /// slot rectangle. A whole denominator/exponent/log-base rect can already be
  /// partially visible while the actual local caret is off-screen near the edge;
  /// this helper produces a small deterministic canvas target for auto-scroll.
  static Rect slotCaretVisibilityTarget({
    required Rect slotRect,
    required int caretIndex,
    required int childCount,
    required String role,
  }) {
    return RendererSyncGeometryPolicy.caretRailForSlot(
      slotRect: slotRect,
      caretIndex: caretIndex,
      childCount: childCount,
      role: role,
    );
  }

  static double activeTargetInflationForRole(String role) {
    return switch (role) {
      'functionArgument' || 'derivativeBody' || 'limitBody' || 'sumBody' || 'productBody' => 46.0,
      'subscript' || 'logBase' || 'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'derivativeVariable' => 40.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'integralDifferential' || 'limitVariable' || 'limitTarget' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 40.0,
      'fractionNumerator' || 'fractionDenominator' => 38.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 30.0,
      _ => 34.0,
    };
  }

  static EdgeInsets visibilityMarginForRole(String role) {
    final horizontal = switch (role) {
      'matrixCell' || 'systemLeft' || 'systemRight' => 52.0,
      'functionArgument' || 'derivativeBody' || 'limitBody' || 'sumBody' || 'productBody' => 46.0,
      'subscript' || 'logBase' || 'powerExponent' || 'rootIndex' || 'derivativeVariable' => 42.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'integralDifferential' || 'limitVariable' || 'limitTarget' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 40.0,
      _ => 34.0,
    };
    final vertical = switch (role) {
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 24.0,
      'matrixCell' || 'systemLeft' || 'systemRight' => 22.0,
      'subscript' || 'logBase' || 'powerExponent' || 'rootIndex' => 20.0,
      _ => 16.0,
    };
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static Matrix4 clampTransformToSafeBounds({
    required Matrix4 transform,
    required double viewportWidth,
    required double viewportHeight,
    required double canvasWidth,
    required double canvasHeight,
    required EdgeInsets boundaryMargin,
  }) {
    final next = Matrix4.copy(transform);
    final storage = next.storage;
    final scale = MathViewportCoordinateTransform.approximateScale(next).clamp(minScale, maxScale).toDouble();
    storage[0] = scale;
    storage[5] = scale;
    storage[10] = 1.0;

    final scaledWidth = canvasWidth * scale;
    final scaledHeight = canvasHeight * scale;
    final minX = viewportWidth - scaledWidth - boundaryMargin.right;
    final maxX = boundaryMargin.left;
    final minY = viewportHeight - scaledHeight - boundaryMargin.bottom;
    final maxY = boundaryMargin.top;

    if (scaledWidth <= viewportWidth) {
      storage[12] = (viewportWidth - scaledWidth) / 2;
    } else {
      storage[12] = storage[12].clamp(minX, maxX).toDouble();
    }

    if (scaledHeight <= viewportHeight) {
      storage[13] = (viewportHeight - scaledHeight) / 2;
    } else {
      storage[13] = storage[13].clamp(minY, maxY).toDouble();
    }
    return next;
  }

  static Matrix4 transformThatKeepsCanvasTargetVisible({
    required Matrix4 current,
    required Rect targetCanvasRect,
    required double viewportWidth,
    required double viewportHeight,
    required double canvasWidth,
    required double canvasHeight,
    required String role,
    required EdgeInsets boundaryMargin,
  }) {
    final margin = visibilityMarginForRole(role);
    final targetViewportRect = MathViewportCoordinateTransform.canvasRectToViewport(
      canvasRect: targetCanvasRect,
      transform: current,
    );
    var dx = 0.0;
    var dy = 0.0;

    if (targetViewportRect.left < margin.left) {
      dx = margin.left - targetViewportRect.left;
    } else if (targetViewportRect.right > viewportWidth - margin.right) {
      dx = (viewportWidth - margin.right) - targetViewportRect.right;
    }

    if (targetViewportRect.top < margin.top) {
      dy = margin.top - targetViewportRect.top;
    } else if (targetViewportRect.bottom > viewportHeight - margin.bottom) {
      dy = (viewportHeight - margin.bottom) - targetViewportRect.bottom;
    }

    if (dx.abs() < 0.5 && dy.abs() < 0.5) {
      return clampTransformToSafeBounds(
        transform: current,
        viewportWidth: viewportWidth,
        viewportHeight: viewportHeight,
        canvasWidth: canvasWidth,
        canvasHeight: canvasHeight,
        boundaryMargin: boundaryMargin,
      );
    }

    final next = Matrix4.copy(current);
    next.storage[12] += dx;
    next.storage[13] += dy;
    return clampTransformToSafeBounds(
      transform: next,
      viewportWidth: viewportWidth,
      viewportHeight: viewportHeight,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      boundaryMargin: boundaryMargin,
    );
  }

  static bool isDeeplyNested(String expression) {
    return maxParenthesisDepth(expression) >= 3 ||
        RegExp(r'(ln|log|sin|cos|tan|sqrt)\((ln|log|sin|cos|tan|sqrt)\(').hasMatch(expression) ||
        expression.contains('√(√') ||
        expression.contains('□^(□^(□)') ||
        expression.contains('(((');
  }

  static bool hasWideStructuralSurface(String expression) {
    final slotCount = '□'.allMatches(expression).length;
    return slotCount >= 4 || hasLargeMatrix(expression) || expression.contains('∫') || expression.contains('Σ') || expression.contains('Π');
  }

  static bool hasLargeMatrix(String expression) {
    return RegExp(r'\[[^\]]*;[^\]]*;[^\]]*\]').hasMatch(expression) || RegExp(r'\[[^\]]* [^\]]* [^\]]* [^\]]*\]').hasMatch(expression);
  }

  static int maxParenthesisDepth(String expression) {
    return PremiumEditorPerformancePolicy.maxParenthesisDepth(expression);
  }
}
