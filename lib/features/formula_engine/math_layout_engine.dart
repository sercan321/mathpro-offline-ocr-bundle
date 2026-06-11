import 'dart:ui';

import '../editor/slot_registry.dart';
import 'slot_interaction_calibration_policy.dart';
import 'renderer_sync_geometry_policy.dart';

class MathLayoutBox {
  const MathLayoutBox({required this.size, required this.slotRects});

  final Size size;
  final Map<SlotEntry, Rect> slotRects;
}

class MathLayoutEngine {
  const MathLayoutEngine._();

  static const version = 'mathpro-core-editor-phase-c-visual-slot-layout-v2-larger-visual-targets';

  /// Approximate visual slot rects over the visible formula surface.
  ///
  /// Phase C intentionally keeps these rects as visual/caret geometry only.
  /// Mobile finger targets are expanded later by [SlotHitTesting], so the user
  /// sees a premium small highlight while tapping a larger invisible hit area.
  /// The later renderer-sync phase can replace these deterministic profiles
  /// with renderer-extracted glyph bounds without changing the public registry.
  static MathLayoutBox deriveSlotRects({required Size canvasSize, required SlotRegistry registry}) {
    if (registry.entries.isEmpty || canvasSize.isEmpty) {
      return MathLayoutBox(size: canvasSize, slotRects: const <SlotEntry, Rect>{});
    }

    final expressionBand = _centerBand(canvasSize);
    final byNode = <String, List<SlotEntry>>{};
    for (final entry in registry.entries) {
      byNode.putIfAbsent(entry.nodeId, () => <SlotEntry>[]).add(entry);
    }

    final nodeIds = byNode.keys.toList(growable: false);
    final nodeWidth = (expressionBand.width / nodeIds.length).clamp(74.0, 152.0).toDouble();
    final totalWidth = nodeWidth * nodeIds.length;
    final startX = expressionBand.center.dx - totalWidth / 2;
    final rects = <SlotEntry, Rect>{};

    for (var nodeIndex = 0; nodeIndex < nodeIds.length; nodeIndex += 1) {
      final nodeRect = Rect.fromLTWH(startX + nodeIndex * nodeWidth, expressionBand.top, nodeWidth, expressionBand.height);
      for (final entry in byNode[nodeIds[nodeIndex]]!) {
        rects[entry] = SlotInteractionCalibrationPolicy.clampVisualRectToCanvas(
          _visualRectFromNormalized(nodeRect, entry.normalizedBounds),
          canvasSize,
        );
      }
    }

    return MathLayoutBox(size: canvasSize, slotRects: rects);
  }

  static Rect _centerBand(Size size) {
    final rendererContent = RendererSyncGeometryPolicy.rendererContentRectForCanvas(size);
    if (rendererContent != null && rendererContent.width > 8 && rendererContent.height > 8) {
      // V172-Q80R5 real-device repair: the old deterministic band used most
      // of the editor canvas, while the visible MathJax formula often occupies
      // a much smaller centered SVG.  That made empty-slot carets appear far
      // away from the actual white □ on device.  When MathJax provides a fresh
      // SVG content envelope, make the native SlotBox layout live inside that
      // visible envelope instead of the whole canvas.
      final horizontalPad = (rendererContent.width * 0.08).clamp(4.0, 18.0).toDouble();
      final verticalPad = (rendererContent.height * 0.10).clamp(4.0, 14.0).toDouble();
      return SlotInteractionCalibrationPolicy.clampVisualRectToCanvas(
        rendererContent.inflate(horizontalPad).inflate(verticalPad),
        size,
      );
    }

    final width = size.width <= 140 ? size.width : (size.width * 0.82).clamp(140.0, size.width).toDouble();
    final height = size.height <= 64 ? size.height : (size.height * 0.74).clamp(64.0, size.height).toDouble();
    return Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: width, height: height);
  }

  static Rect _visualRectFromNormalized(Rect parent, NormalizedSlotBounds bounds) {
    final raw = Rect.fromLTWH(
      parent.left + parent.width * bounds.left,
      parent.top + parent.height * bounds.top,
      parent.width * bounds.width,
      parent.height * bounds.height,
    );
    const minVisualWidth = 26.0;
    const minVisualHeight = 24.0;
    final width = raw.width < minVisualWidth ? minVisualWidth : raw.width;
    final height = raw.height < minVisualHeight ? minVisualHeight : raw.height;
    return Rect.fromCenter(center: raw.center, width: width, height: height);
  }
}
