import 'dart:math' as math;
import 'dart:ui';

import '../editor/selection_controller.dart';
import '../editor/slot_registry.dart';
import 'deterministic_slot_geometry_registry.dart';
import 'math_layout_engine.dart';
import 'renderer_sync_geometry_policy.dart';
import 'role_geometry_visual_alignment_policy.dart';
import 'template_slot_navigation_policy.dart';

/// V62 editor interaction authority.
///
/// This class bridges the visual formula string and the structural slot registry.
/// Earlier phases had large generic hitboxes, but the visible □ targets could
/// still drift away from the tap engine on real phones. V62 makes every visible
/// placeholder produce a deterministic render-mapped rect on the same optical
/// line as the math renderer. The rect remains visually small, while the hit
/// layer expands it later for comfortable mobile input.
class RenderMappedSlotHitTest {
  const RenderMappedSlotHitTest._();

  static const String version = 'mathpro-v172l-v84-v172q34-v172q35-v172q53-render-mapped-slot-hit-test-placeholder-safe-role-geometry';

  static Map<SlotEntry, Rect> resolveSlotRects({
    required String expression,
    required Size canvasSize,
    required SlotRegistry registry,
    required MathLayoutBox baseLayout,
  }) {
    if (registry.entries.isEmpty || canvasSize.isEmpty) {
      return const <SlotEntry, Rect>{};
    }

    final resolved = Map<SlotEntry, Rect>.from(baseLayout.slotRects);
    final placeholderIndexes = MathProCaretController.placeholderCaretIndexes(expression);
    if (placeholderIndexes.isEmpty) {
      return _normalizeResolvedRects(resolved, canvasSize);
    }

    final caretPositions = MathProCaretController.linearCaretPositionsForExpression(
      expression: expression,
      canvasSize: canvasSize,
    );
    if (caretPositions.length < 2) {
      return _normalizeResolvedRects(resolved, canvasSize);
    }

    final orderedSlots = TemplateSlotNavigationPolicy.orderedSlots(registry.entries);
    final count = math.min(placeholderIndexes.length, orderedSlots.length);
    for (var index = 0; index < count; index += 1) {
      final entry = orderedSlots[index];
      if (_mustKeepNativeSlotBoxLayout(entry)) {
        // V172-Q80R5 real-device repair: native 2D templates such as □/□,
        // ∫_□^□ □ d□, x^□, x_□, √□ and log_□(□) must not be remapped back
        // onto a linear placeholder string.  The screenshots showed exactly
        // this failure mode: the caret was rendered at a detached linear lane
        // or inside the □ instead of at the visible SlotBox edge.  Preserve the
        // structural SlotBox rect from MathLayoutEngine/renderer content.
        continue;
      }
      final placeholderIndex = placeholderIndexes[index].clamp(0, caretPositions.length - 2).toInt();
      final left = caretPositions[placeholderIndex];
      final right = caretPositions[placeholderIndex + 1];
      final centerX = (left + right) / 2;
      final centerY = _roleAlignedCenterY(entry.role, canvasSize);
      final rect = Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: _visualWidthFor(entry.role),
        height: _visualHeightFor(entry.role, canvasSize),
      );
      resolved[entry] = RendererSyncGeometryPolicy.calibrateVisualRect(entry: entry, rawRect: rect, canvasSize: canvasSize);
    }

    // When complex templates expose more registry slots than the compact visible
    // string contains □ glyphs, keep the rest available through the deterministic
    // structural layout, but pull them toward the same editor band. This prevents
    // invisible/highlight targets from appearing in a different vertical layer.
    return _normalizeResolvedRects(resolved, canvasSize);
  }

  static Map<SlotEntry, Rect> _normalizeResolvedRects(Map<SlotEntry, Rect> rects, Size canvasSize) {
    final output = <SlotEntry, Rect>{};
    final centerY = MathProCaretController.inlineExpressionCenterY(canvasSize);
    for (final item in rects.entries) {
      final rect = item.value;
      final role = item.key.role;
      final blendAmount = _centerBlendAmountFor(role);
      final targetY = _roleAlignedCenterY(role, canvasSize);
      final preferredWidth = math.max(rect.width, _minimumVisibleWidth(role));
      final preferredHeight = math.max(rect.height, _minimumVisibleHeight(role, canvasSize));
      final normalized = Rect.fromCenter(
        center: Offset(rect.center.dx, _blend(rect.center.dy, _blend(centerY, targetY, 0.88), blendAmount)),
        width: math.min(preferredWidth, _maximumVisibleWidth(role, canvasSize)),
        height: math.min(preferredHeight, _maximumVisibleHeight(role, canvasSize)),
      );
      final calibrated = RendererSyncGeometryPolicy.calibrateVisualRect(
        entry: item.key,
        rawRect: normalized,
        canvasSize: canvasSize,
      );
      final deterministic = DeterministicSlotGeometryRegistry.visualRectFor(
        entry: item.key,
        rawRect: calibrated,
        canvasSize: canvasSize,
      );
      output[item.key] = RoleGeometryVisualAlignmentPolicy.refineVisualRect(
        entry: item.key,
        calibratedRect: calibrated,
        deterministicRect: deterministic,
        canvasSize: canvasSize,
      );
    }
    return output;
  }

  static double _blend(double a, double b, double amount) => a + (b - a) * amount;

  static bool _mustKeepNativeSlotBoxLayout(SlotEntry entry) {
    return switch (entry.role) {
      'fractionNumerator' ||
      'fractionDenominator' ||
      'integralUpperLimit' ||
      'integralLowerLimit' ||
      'integralBody' ||
      'integralDifferential' ||
      'sqrtValue' ||
      'rootIndex' ||
      'powerExponent' ||
      'powerBase' ||
      'subscript' ||
      'subscriptBase' ||
      'logBase' ||
      'functionArgument' ||
      'functionArgument2' ||
      'functionArgument3' ||
      'limitVariable' ||
      'limitTarget' ||
      'limitBody' ||
      'sumUpperLimit' ||
      'sumLowerLimit' ||
      'sumBody' ||
      'productUpperLimit' ||
      'productLowerLimit' ||
      'productBody' ||
      'matrixCell' ||
      'systemLeft' ||
      'systemRight' ||
      'piecewiseExpression' ||
      'piecewiseCondition' => true,
      _ => false,
    };
  }

  static double _roleAlignedCenterY(String role, Size canvasSize) {
    final center = MathProCaretController.inlineExpressionCenterY(canvasSize);
    final band = math.max(42.0, canvasSize.height * 0.58);
    final down = center + band * 0.26;
    final farUp = center - band * 0.34;
    final farDown = center + band * 0.34;
    final value = switch (role) {
      'fractionNumerator' || 'integralUpperLimit' || 'sumUpperLimit' || 'productUpperLimit' || 'powerExponent' || 'rootIndex' || 'derivativeOrder' => farUp,
      'fractionDenominator' || 'integralLowerLimit' || 'sumLowerLimit' || 'productLowerLimit' || 'subscript' || 'logBase' => farDown,
      'integralDifferential' || 'powerBase' || 'subscriptBase' || 'limitVariable' || 'limitTarget' || 'derivativeVariable' => down,
      'derivativeBody' => center,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => center,
      _ => center,
    };
    return value.clamp(18.0, math.max(18.0, canvasSize.height - 18.0)).toDouble();
  }

  static double _centerBlendAmountFor(String role) {
    return switch (role) {
      'fractionNumerator' || 'fractionDenominator' || 'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' || 'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' || 'derivativeOrder' || 'derivativeVariable' => 0.12,
      'integralDifferential' || 'limitVariable' || 'limitTarget' || 'derivativeBody' => 0.25,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 0.0,
      _ => 0.55,
    };
  }

  static double _visualWidthFor(String role) {
    return switch (role) {
      'functionArgument' => 64.0,
      'derivativeBody' => 62.0,
      'placeholder' => 58.0,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 58.0,
      'fractionNumerator' || 'fractionDenominator' => 58.0,
      'sqrtValue' => 62.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'derivativeVariable' => 50.0,
      'subscript' || 'logBase' => 54.0,
      'integralBody' => 58.0,
      'integralDifferential' => 48.0,
      _ => 56.0,
    };
  }

  static double _visualHeightFor(String role, Size canvasSize) {
    final base = switch (role) {
      'functionArgument' => 66.0,
      'derivativeBody' => 64.0,
      'placeholder' => 62.0,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 58.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'derivativeVariable' => 50.0,
      'subscript' || 'logBase' => 52.0,
      _ => 58.0,
    };
    return base.clamp(38.0, math.max(38.0, canvasSize.height * 0.74)).toDouble();
  }

  static double _minimumVisibleWidth(String role) => switch (role) {
        'functionArgument' => 58.0,
        'derivativeBody' => 58.0,
        'placeholder' => 52.0,
        'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 54.0,
        'subscript' || 'logBase' => 50.0,
        _ => 46.0,
      };

  static double _maximumVisibleWidth(String role, Size canvasSize) {
    final preferred = switch (role) {
      'functionArgument' => 64.0,
      'derivativeBody' => 64.0,
      'limitBody' => 64.0,
      'placeholder' => 58.0,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 56.0,
      'fractionNumerator' || 'fractionDenominator' => 60.0,
      'sumBody' || 'productBody' => 62.0,
      'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 58.0,
      'integralBody' => 62.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'derivativeVariable' => 52.0,
      'subscript' || 'logBase' || 'limitVariable' || 'limitTarget' => 54.0,
      _ => 60.0,
    };
    return preferred.clamp(34.0, math.max(34.0, canvasSize.width * 0.34)).toDouble();
  }

  static double _maximumVisibleHeight(String role, Size canvasSize) {
    final preferred = switch (role) {
      'functionArgument' => 58.0,
      'derivativeBody' => 58.0,
      'limitBody' => 54.0,
      'placeholder' => 54.0,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 50.0,
      'fractionNumerator' || 'fractionDenominator' => 50.0,
      'sumBody' || 'productBody' => 54.0,
      'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 48.0,
      'integralBody' => 54.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' || 'derivativeVariable' => 48.0,
      'subscript' || 'logBase' || 'limitVariable' || 'limitTarget' => 48.0,
      _ => 54.0,
    };
    return preferred.clamp(30.0, math.max(30.0, canvasSize.height * 0.46)).toDouble();
  }

  static double _minimumVisibleHeight(String role, Size canvasSize) {
    final preferred = switch (role) {
      'functionArgument' => 58.0,
        'derivativeBody' => 58.0,
      'placeholder' => 54.0,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 46.0,
      'subscript' || 'logBase' || 'derivativeOrder' || 'derivativeVariable' => 48.0,
      _ => 48.0,
    };
    return preferred.clamp(34.0, math.max(34.0, canvasSize.height * 0.70)).toDouble();
  }
}
