import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';
import 'slot_interaction_calibration_policy.dart';
import 'renderer_sync_upgrade_policy.dart';

/// V172-L deterministic renderer-sync geometry calibration.
///
/// MathPro's visible editor surface is still rendered by the MathJax/WebView
/// path, so this phase does not claim true renderer-extracted SVG bounds.
/// Instead it centralizes the calibrated slot geometry used by hit-test,
/// caret overlay, and long-expression visibility so they all consume the same
/// premium no-loupe coordinate contract.
class RendererSyncGeometryPolicy {
  const RendererSyncGeometryPolicy._();

  static const String version = 'mathpro-v172l-v172q44-v172q46-renderer-sync-geometry-calibration-slot-identity-prototype-v3';

  /// Honest capability flag.  Later phases may flip this only after real
  /// renderer/SVG bounds are extracted from the render surface.
  static const bool rendererExtractedBoundsAvailable = false;
  static const bool deterministicCalibrationEnabled = true;
  static const bool q44RendererSyncUpgradeAvailable = true;
  static const bool rendererExpressionEnvelopeTelemetryEnabled = RendererSyncUpgradePolicy.rendererExpressionEnvelopeTelemetryEnabled;
  static const bool rendererPerSlotSvgIdentityClaimed = RendererSyncUpgradePolicy.rendererPerSlotSvgIdentityClaimed;
  static const bool q46RendererSlotIdentityPrototypeAvailable = true;
  static const bool rendererElementRectTelemetryEnabled = true;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;

  static RendererGeometrySnapshot? _latestSnapshot;

  static RendererGeometrySnapshot? get latestSnapshot => _latestSnapshot;

  static bool get hasRecentRendererExpressionEnvelope {
    final snapshot = _latestSnapshot;
    if (snapshot == null) return false;
    return RendererSyncUpgradePolicy.snapshotIsUsable(
      nowMs: DateTime.now().millisecondsSinceEpoch,
      capturedAtMs: snapshot.capturedAtMs,
    );
  }

  static void recordRendererGeometryMessage(String message) {
    final snapshot = RendererGeometrySnapshot.tryParse(message);
    if (snapshot == null) return;
    _latestSnapshot = snapshot;
  }

  static void clearRendererGeometrySnapshot() {
    _latestSnapshot = null;
  }

  static Rect? rendererContentRectForCanvas(Size canvasSize) {
    final snapshot = _latestSnapshot;
    if (snapshot == null || canvasSize.isEmpty) return null;
    if (!RendererSyncUpgradePolicy.snapshotIsUsable(
      nowMs: DateTime.now().millisecondsSinceEpoch,
      capturedAtMs: snapshot.capturedAtMs,
    )) {
      return null;
    }
    return snapshot.contentRectForCanvas(canvasSize);
  }

  /// Q132R2 real-device repair: MathJax reports SVG bounds in the coordinate
  /// space of its centered WebView root, not the whole editor canvas. The old
  /// cursor motor consumed those normalized bounds as if root == canvas, which
  /// made the Flutter caret/slot hit-test line appear detached from the visible
  /// MathJax formula on phones.  This helper exposes the actual root box inside
  /// the editor canvas so hit-test, caret overlay and renderer-assisted glyph
  /// stops share the same visible math coordinate authority.
  static Rect? rendererRootRectForCanvas(Size canvasSize) {
    final snapshot = _latestSnapshot;
    if (snapshot == null || canvasSize.isEmpty) return null;
    if (!RendererSyncUpgradePolicy.snapshotIsUsable(
      nowMs: DateTime.now().millisecondsSinceEpoch,
      capturedAtMs: snapshot.capturedAtMs,
    )) {
      return null;
    }
    return snapshot.rootRectForCanvas(canvasSize);
  }
  static const bool editorLoupeEnabled = false;
  static const bool greenDebugOverlayEnabled = false;

  static Rect calibrateVisualRect({
    required SlotEntry entry,
    required Rect rawRect,
    required Size canvasSize,
  }) {
    if (canvasSize.isEmpty) return rawRect;

    final rendererContent = rendererContentRectForCanvas(canvasSize);
    final role = entry.role;
    final targetCenter = calibratedCenterForRole(
      role: role,
      rawRect: rawRect,
      canvasSize: canvasSize,
    );
    final targetWidth = calibratedWidthForRole(role, rawRect, canvasSize);
    final targetHeight = calibratedHeightForRole(role, rawRect, canvasSize);

    final rendererAwareCenter = _clampCenterToRendererContent(
      targetCenter,
      rendererContent,
      targetWidth,
      targetHeight,
    );
    final calibrated = Rect.fromCenter(
      center: rendererAwareCenter,
      width: targetWidth,
      height: targetHeight,
    );
    return SlotInteractionCalibrationPolicy.clampVisualRectToCanvas(calibrated, canvasSize);
  }

  static Offset calibratedCenterForRole({
    required String role,
    required Rect rawRect,
    required Size canvasSize,
  }) {
    final rawCenter = rawRect.center;
    final targetY = rendererLaneCenterY(role, canvasSize);
    final targetX = _roleBiasedCenterX(role, rawCenter.dx, canvasSize);
    final blend = verticalBlendForRole(role);
    return Offset(targetX, _blend(rawCenter.dy, targetY, blend));
  }

  static double rendererLaneCenterY(String role, Size canvasSize) {
    final rendererContent = rendererContentRectForCanvas(canvasSize);
    final center = rendererContent?.center.dy ?? canvasSize.height / 2;
    final band = math.max(46.0, canvasSize.height * 0.56);
    final farUp = center - band * 0.32;
    final mildDown = center + band * 0.20;
    final farDown = center + band * 0.32;

    final value = switch (role) {
      'fractionNumerator' ||
      'integralUpperLimit' ||
      'sumUpperLimit' ||
      'productUpperLimit' ||
      'powerExponent' ||
      'rootIndex' ||
      'derivativeOrder' => farUp,
      'fractionDenominator' ||
      'integralLowerLimit' ||
      'sumLowerLimit' ||
      'productLowerLimit' ||
      'subscript' ||
      'logBase' => farDown,
      'limitVariable' ||
      'limitTarget' ||
      'derivativeVariable' ||
      'integralDifferential' => mildDown,
      'integralBody' ||
      'derivativeBody' ||
      'limitBody' ||
      'sumBody' ||
      'productBody' ||
      'sqrtValue' ||
      'functionArgument' => center,
      'matrixCell' ||
      'systemLeft' ||
      'systemRight' ||
      'piecewiseExpression' ||
      'piecewiseCondition' => rawGridCenterY(role, canvasSize, fallback: center),
      _ => center,
    };
    return value.clamp(18.0, math.max(18.0, canvasSize.height - 18.0)).toDouble();
  }

  static double rawGridCenterY(String role, Size canvasSize, {required double fallback}) {
    // Grid entries already carry their row/column position from SlotRegistry.
    // Keeping the fallback lane stable here prevents matrix/system editors from
    // being flattened onto numerator/denominator style bands.
    if (role == 'matrixCell' || role == 'systemLeft' || role == 'systemRight') {
      return fallback;
    }
    return fallback;
  }

  static double verticalBlendForRole(String role) {
    return switch (role) {
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => 0.0,
      'functionArgument' || 'sqrtValue' || 'integralBody' || 'derivativeBody' || 'limitBody' || 'sumBody' || 'productBody' => 0.34,
      'fractionNumerator' || 'fractionDenominator' || 'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' => 0.52,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' || 'derivativeOrder' => 0.58,
      'limitVariable' || 'limitTarget' || 'derivativeVariable' || 'integralDifferential' => 0.44,
      _ => 0.40,
    };
  }

  static double calibratedWidthForRole(String role, Rect rawRect, Size canvasSize) {
    final preferred = switch (role) {
      'functionArgument' => 64.0,
      'sqrtValue' => 64.0,
      'integralBody' || 'derivativeBody' || 'limitBody' || 'sumBody' || 'productBody' => 62.0,
      'fractionNumerator' || 'fractionDenominator' => 60.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => 52.0,
      'subscript' || 'logBase' || 'limitVariable' || 'limitTarget' || 'derivativeVariable' || 'integralDifferential' => 54.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 58.0,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => math.max(rawRect.width, 54.0),
      _ => 58.0,
    };
    return math.max(rawRect.width, preferred).clamp(32.0, math.max(32.0, canvasSize.width * 0.34)).toDouble();
  }

  static double calibratedHeightForRole(String role, Rect rawRect, Size canvasSize) {
    final preferred = switch (role) {
      'functionArgument' => 58.0,
      'sqrtValue' => 56.0,
      'integralBody' || 'derivativeBody' || 'limitBody' || 'sumBody' || 'productBody' => 54.0,
      'fractionNumerator' || 'fractionDenominator' => 50.0,
      'powerExponent' || 'rootIndex' || 'derivativeOrder' => 48.0,
      'subscript' || 'logBase' || 'limitVariable' || 'limitTarget' || 'derivativeVariable' || 'integralDifferential' => 48.0,
      'integralUpperLimit' || 'integralLowerLimit' || 'sumUpperLimit' || 'sumLowerLimit' || 'productUpperLimit' || 'productLowerLimit' => 48.0,
      'matrixCell' || 'systemLeft' || 'systemRight' || 'piecewiseExpression' || 'piecewiseCondition' => math.max(rawRect.height, 46.0),
      _ => 54.0,
    };
    return math.max(rawRect.height, preferred).clamp(30.0, math.max(30.0, canvasSize.height * 0.48)).toDouble();
  }

  static Rect caretRailForSlot({
    required Rect slotRect,
    required int caretIndex,
    required int childCount,
    required String role,
  }) {
    final safeChildren = math.max(1, childCount);
    final safeIndex = caretIndex.clamp(0, safeChildren).toInt();
    final localX = safeChildren == 0 ? 0.0 : slotRect.width * (safeIndex / safeChildren);
    final railX = (slotRect.left + localX).clamp(slotRect.left, slotRect.right).toDouble();
    final width = switch (role) {
      'integralUpperLimit' ||
      'integralLowerLimit' ||
      'integralDifferential' ||
      'limitVariable' ||
      'limitTarget' ||
      'sumUpperLimit' ||
      'sumLowerLimit' ||
      'productUpperLimit' ||
      'productLowerLimit' => 44.0,
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' || 'derivativeOrder' => 30.0,
      'fractionNumerator' || 'fractionDenominator' => 34.0,
      _ => 36.0,
    };
    return Rect.fromCenter(
      center: Offset(railX, slotRect.center.dy),
      width: width,
      height: math.max(36.0, slotRect.height),
    );
  }

  static Offset _clampCenterToRendererContent(
    Offset center,
    Rect? rendererContent,
    double width,
    double height,
  ) {
    if (rendererContent == null || rendererContent.isEmpty) return center;
    final safe = RendererSyncUpgradePolicy.inflateRendererContent(rendererContent);
    final halfWidth = width / 2;
    final halfHeight = height / 2;
    final minX = safe.left + halfWidth;
    final maxX = safe.right - halfWidth;
    final minY = safe.top + halfHeight;
    final maxY = safe.bottom - halfHeight;
    final x = maxX >= minX ? center.dx.clamp(minX, maxX).toDouble() : safe.center.dx;
    final y = maxY >= minY ? center.dy.clamp(minY, maxY).toDouble() : safe.center.dy;
    return Offset(x, y);
  }

  static double _roleBiasedCenterX(String role, double x, Size canvasSize) {
    // Keep tiny super/subscript targets inside the visible canvas even after
    // calibration.  Matrix/system cells keep their raw grid X.
    final edgePadding = switch (role) {
      'powerExponent' || 'rootIndex' || 'subscript' || 'logBase' || 'derivativeOrder' => 18.0,
      _ => 12.0,
    };
    return x.clamp(edgePadding, math.max(edgePadding, canvasSize.width - edgePadding)).toDouble();
  }

  static double _blend(double a, double b, double amount) => a + (b - a) * amount;
}


class RendererElementRect {
  const RendererElementRect({
    required this.rect,
    required this.domIndex,
    required this.tagName,
    required this.className,
    required this.text,
  });

  final Rect rect;
  final int domIndex;
  final String tagName;
  final String className;
  final String text;

  RendererElementRect toCanvas(Size canvasSize) {
    return toRootCanvas(Rect.fromLTWH(0, 0, canvasSize.width, canvasSize.height));
  }

  RendererElementRect toRootCanvas(Rect rootRect) {
    return RendererElementRect(
      rect: Rect.fromLTWH(
        rootRect.left + rect.left * rootRect.width,
        rootRect.top + rect.top * rootRect.height,
        rect.width * rootRect.width,
        rect.height * rootRect.height,
      ),
      domIndex: domIndex,
      tagName: tagName,
      className: className,
      text: text,
    );
  }
}

class RendererGeometrySnapshot {
  const RendererGeometrySnapshot({
    required this.epoch,
    required this.tex,
    required this.normalizedContentRect,
    required this.capturedAtMs,
    required this.devicePixelRatio,
    required this.rootWidth,
    required this.rootHeight,
    this.normalizedElementRects = const <RendererElementRect>[],
  });

  final int epoch;
  final String tex;
  final Rect normalizedContentRect;
  final int capturedAtMs;
  final double devicePixelRatio;
  final double rootWidth;
  final double rootHeight;
  final List<RendererElementRect> normalizedElementRects;

  List<RendererElementRect> elementRectsForCanvas(Size canvasSize) {
    if (canvasSize.isEmpty || normalizedElementRects.isEmpty) {
      return const <RendererElementRect>[];
    }
    final rootRect = rootRectForCanvas(canvasSize);
    if (rootRect.isEmpty) return const <RendererElementRect>[];
    return List<RendererElementRect>.unmodifiable(
      normalizedElementRects.map((item) => item.toRootCanvas(rootRect)),
    );
  }

  Rect rootRectForCanvas(Size canvasSize) {
    if (canvasSize.isEmpty || rootWidth <= 0 || rootHeight <= 0) {
      return Rect.zero;
    }
    // This mirrors EditorViewport + MathJaxRenderSurface placement without
    // importing the editor controller and creating a formula_engine cycle:
    // EditorViewport positions the renderer inside the inline render band and
    // MathJaxRenderSurface uses a centered SizedBox root.
    final bandHeight = _inlineRenderBandHeight(canvasSize);
    final centerY = _inlineExpressionCenterY(canvasSize);
    final bandTop = (centerY - bandHeight / 2)
        .clamp(0.0, math.max(0.0, canvasSize.height - bandHeight))
        .toDouble();
    final width = math.min(rootWidth, math.max(rootWidth, canvasSize.width));
    final height = math.min(rootHeight, math.max(rootHeight, bandHeight));
    final left = (canvasSize.width - width) / 2;
    final top = bandTop + (bandHeight - height) / 2;
    return Rect.fromLTWH(left, top, width, height);
  }

  Rect contentRectForCanvas(Size canvasSize) {
    final rootRect = rootRectForCanvas(canvasSize);
    if (rootRect.isEmpty) return Rect.zero;
    return Rect.fromLTWH(
      rootRect.left + normalizedContentRect.left * rootRect.width,
      rootRect.top + normalizedContentRect.top * rootRect.height,
      normalizedContentRect.width * rootRect.width,
      normalizedContentRect.height * rootRect.height,
    );
  }

  static double _inlineExpressionCenterY(Size canvasSize) {
    if (canvasSize.height >= 160) return canvasSize.height * 0.39;
    if (canvasSize.height >= 132) return canvasSize.height * 0.42;
    if (canvasSize.height >= 96) return canvasSize.height * 0.45;
    return canvasSize.height * 0.47;
  }

  static double _inlineRenderBandHeight(Size canvasSize) {
    final preferred = canvasSize.height * 0.66;
    return preferred.clamp(86.0, math.max(86.0, canvasSize.height * 0.82)).toDouble();
  }

  static RendererGeometrySnapshot? tryParse(String message) {
    try {
      final data = _decodeGeometryMessage(message);
      if (data == null) return null;
      final epoch = (data['epoch'] as num?)?.toInt() ?? -1;
      final tex = data['tex'] as String? ?? '';
      final capturedAtMs = (data['capturedAtMs'] as num?)?.toInt() ?? DateTime.now().millisecondsSinceEpoch;
      final dpr = ((data['devicePixelRatio'] as num?)?.toDouble() ?? 1.0).clamp(0.5, 8.0).toDouble();
      final root = data['root'] as Map<String, dynamic>?;
      final svg = data['svg'] as Map<String, dynamic>?;
      if (root == null || svg == null) return null;
      final rootWidth = (root['width'] as num?)?.toDouble() ?? 0.0;
      final rootHeight = (root['height'] as num?)?.toDouble() ?? 0.0;
      if (rootWidth <= 0 || rootHeight <= 0) return null;
      final left = ((svg['left'] as num?)?.toDouble() ?? 0.0) / rootWidth;
      final top = ((svg['top'] as num?)?.toDouble() ?? 0.0) / rootHeight;
      final width = ((svg['width'] as num?)?.toDouble() ?? 0.0) / rootWidth;
      final height = ((svg['height'] as num?)?.toDouble() ?? 0.0) / rootHeight;
      if (width <= 0 || height <= 0) return null;
      final rect = Rect.fromLTWH(
        left.clamp(0.0, 1.0).toDouble(),
        top.clamp(0.0, 1.0).toDouble(),
        width.clamp(0.0, 1.0).toDouble(),
        height.clamp(0.0, 1.0).toDouble(),
      );
      final elementRects = _parseElementRects(data, rootWidth: rootWidth, rootHeight: rootHeight);
      return RendererGeometrySnapshot(
        epoch: epoch,
        tex: tex,
        normalizedContentRect: rect,
        capturedAtMs: capturedAtMs,
        devicePixelRatio: dpr,
        rootWidth: rootWidth,
        rootHeight: rootHeight,
        normalizedElementRects: elementRects,
      );
    } catch (_) {
      return null;
    }
  }

  static List<RendererElementRect> _parseElementRects(
    Map<String, dynamic> data, {
    required double rootWidth,
    required double rootHeight,
  }) {
    final raw = data['elementRects'];
    if (raw is! List || rootWidth <= 0 || rootHeight <= 0) {
      return const <RendererElementRect>[];
    }
    final output = <RendererElementRect>[];
    for (final item in raw) {
      if (item is! Map) continue;
      final left = ((item['left'] as num?)?.toDouble() ?? 0.0) / rootWidth;
      final top = ((item['top'] as num?)?.toDouble() ?? 0.0) / rootHeight;
      final width = ((item['width'] as num?)?.toDouble() ?? 0.0) / rootWidth;
      final height = ((item['height'] as num?)?.toDouble() ?? 0.0) / rootHeight;
      if (width <= 0 || height <= 0) continue;
      output.add(RendererElementRect(
        rect: Rect.fromLTWH(
          left.clamp(0.0, 1.0).toDouble(),
          top.clamp(0.0, 1.0).toDouble(),
          width.clamp(0.0, 1.0).toDouble(),
          height.clamp(0.0, 1.0).toDouble(),
        ),
        domIndex: (item['domIndex'] as num?)?.toInt() ?? output.length,
        tagName: item['tagName'] as String? ?? '',
        className: item['className'] as String? ?? '',
        text: item['text'] as String? ?? '',
      ));
    }
    return List<RendererElementRect>.unmodifiable(output);
  }

  static Map<String, dynamic>? _decodeGeometryMessage(String message) {
    final decoded = jsonDecode(message);
    if (decoded is Map<String, dynamic>) return decoded;
    return null;
  }
}

