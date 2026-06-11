import 'dart:ui';

import '../editor/slot_registry.dart';
import 'math_layout_engine.dart';
import 'native_integral_slotbox_specialization_policy.dart';
import 'native_fraction_function_root_log_slotbox_specialization_policy.dart';
import 'native_nested_long_expression_pan_stability_policy.dart';
import 'native_slotbox_hit_test_policy.dart';
import 'native_slotbox_input_surface_policy.dart';
import 'render_mapped_slot_hit_test.dart';
import 'slot_geometry_bundle_authority.dart';
import 'slot_hit_testing.dart';

/// V172-Q76 — Native input surface integration.
///
/// Q71-Q75 added the native SlotBox authority in separate cursor/editor paths:
/// input-surface law, painter, hit-test, exclusive `|□` caret, and structural
/// edit transactions. Q76 wires those pieces through a single runtime frame for
/// the editor interaction surface so hit-test, fallback suppression, visual
/// slot overlay, and later caret paint integration all read the same immutable
/// SlotGeometryBundle map.
///
/// This remains cursor/editor-only. It does not mutate the keyboard, MORE tray,
/// long-press popup, app shell, MathLabel, TemplateTray, Solution, Graph, or
/// History surfaces.
class NativeSlotBoxInputSurfaceIntegrationPolicy {
  const NativeSlotBoxInputSurfaceIntegrationPolicy._();

  static const String version =
      'mathpro-v172q76-v172q79-native-input-surface-integration-integral-ffrl-nested-long-pan-frame-v1';

  static const bool nativeInputSurfaceIntegrationAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const bool singleRuntimeFrameOwnsEditorInteraction = true;
  static const bool hitTestPainterAndFallbackShareGeometryBundles = true;
  static const bool nativeSurfaceBlocksLegacyPlaceholderFallbackWithGeometry = true;
  static const bool nativeSurfaceUsesAuthoritativeSlotRects = true;
  static const bool visibleSlotOverlayRemainsOptIn = true;
  static const bool q77IntegralNativeSlotBoxesRideSameInputSurfaceFrame = true;
  static const bool q78FractionFunctionRootLogSlotBoxesRideSameInputSurfaceFrame = true;
  static const bool q79NestedLongExpressionPanStabilityRidesSameInputSurfaceFrame = true;

  static NativeSlotBoxInputSurfaceFrame buildFrame({
    required String expression,
    required Size canvasSize,
    required SlotRegistry registry,
    required bool structuralInteractionEnabled,
  }) {
    final layout = MathLayoutEngine.deriveSlotRects(
      canvasSize: canvasSize,
      registry: registry,
    );
    final mappedVisualRects = RenderMappedSlotHitTest.resolveSlotRects(
      expression: expression,
      canvasSize: canvasSize,
      registry: registry,
      baseLayout: layout,
    );
    final geometryBundles = SlotGeometryBundleAuthority.buildFromVisualRects(
      visualRects: mappedVisualRects,
      canvasSize: canvasSize,
    );
    final authorityVisualRects = SlotGeometryBundleAuthority.visualRectsFromBundles(geometryBundles);
    return NativeSlotBoxInputSurfaceFrame(
      expression: expression,
      canvasSize: canvasSize,
      structuralInteractionEnabled: structuralInteractionEnabled,
      layout: layout,
      mappedVisualRects: mappedVisualRects,
      geometryBundles: geometryBundles,
      authorityVisualRects: authorityVisualRects,
      source: 'v172q76-v172q79-native-input-surface-frame',
    );
  }

  static bool canRouteStructuralTap(NativeSlotBoxInputSurfaceFrame frame) {
    return frame.structuralInteractionEnabled &&
        frame.geometryBundles.isNotEmpty &&
        NativeSlotBoxInputSurfacePolicy.authoritativeHitRectRequired;
  }

  static bool allowLegacyLinearPlaceholderFallback(NativeSlotBoxInputSurfaceFrame frame) {
    return NativeSlotBoxInputSurfacePolicy.allowLegacyLinearPlaceholderFallback(
      structuralInteractionEnabled: frame.structuralInteractionEnabled,
      geometryBundleCount: frame.geometryBundles.length,
    );
  }

  static bool shouldBlockDetachedLinearFallbackAt({
    required NativeSlotBoxInputSurfaceFrame frame,
    required Offset point,
  }) {
    if (!frame.structuralInteractionEnabled || frame.geometryBundles.isEmpty) {
      return false;
    }
    return NativeSlotBoxHitTestPolicy.shouldBlockLinearFallbackInsideMeasuredStructuralHit(
      point: point,
      bundles: frame.geometryBundles,
      structuralInteractionEnabled: frame.structuralInteractionEnabled,
    );
  }

  static bool hasCompleteNativeIntegralSlotSet(NativeSlotBoxInputSurfaceFrame frame) {
    return NativeIntegralSlotBoxSpecializationPolicy.hasCompleteIntegralSlotSet(frame.geometryBundles.values);
  }

  static bool hasNativeFractionFunctionRootLogSlotSet(NativeSlotBoxInputSurfaceFrame frame) {
    return frame.geometryBundles.values.any(
      (bundle) => NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.isNativeRole(bundle.role),
    );
  }

  static bool frameIsAuthoritative(NativeSlotBoxInputSurfaceFrame frame) {
    return frame.authorityVisualRects.length == frame.geometryBundles.length &&
        frame.mappedVisualRects.length == frame.geometryBundles.length &&
        frame.geometryBundles.values.every((bundle) => bundle.hitRect.contains(bundle.visualRect.center));
  }

  static bool hasNativeNestedLongExpressionPanStableSurface(NativeSlotBoxInputSurfaceFrame frame) {
    return NativeNestedLongExpressionPanStabilityPolicy.isNativeLongSurfaceCandidate(
      expression: frame.expression,
      bundles: frame.geometryBundles.values,
    );
  }

  static bool frameIsPanStable(NativeSlotBoxInputSurfaceFrame frame) {
    return frameIsAuthoritative(frame) &&
        NativeNestedLongExpressionPanStabilityPolicy.frameGeometryLooksStable(
          canvasSize: frame.canvasSize,
          bundles: frame.geometryBundles.values,
        );
  }
}

class NativeSlotBoxInputSurfaceFrame {
  const NativeSlotBoxInputSurfaceFrame({
    required this.expression,
    required this.canvasSize,
    required this.structuralInteractionEnabled,
    required this.layout,
    required this.mappedVisualRects,
    required this.geometryBundles,
    required this.authorityVisualRects,
    required this.source,
  });

  final String expression;
  final Size canvasSize;
  final bool structuralInteractionEnabled;
  final MathLayoutBox layout;
  final Map<SlotEntry, Rect> mappedVisualRects;
  final Map<SlotEntry, SlotGeometryBundle> geometryBundles;
  final Map<SlotEntry, Rect> authorityVisualRects;
  final String source;

  bool get hasAuthoritativeGeometry => geometryBundles.isNotEmpty;
  int get slotCount => geometryBundles.length;

  SlotHitTestResult? hitTest(Offset point) {
    if (!NativeSlotBoxInputSurfaceIntegrationPolicy.canRouteStructuralTap(this)) {
      return null;
    }
    return NativeSlotBoxHitTestPolicy.hitTest(
      point: point,
      bundles: geometryBundles,
    );
  }

  bool get legacyPlaceholderFallbackAllowed =>
      NativeSlotBoxInputSurfaceIntegrationPolicy.allowLegacyLinearPlaceholderFallback(this);

  bool shouldBlockDetachedLinearFallbackAt(Offset point) {
    return NativeSlotBoxInputSurfaceIntegrationPolicy.shouldBlockDetachedLinearFallbackAt(
      frame: this,
      point: point,
    );
  }

  bool shouldSuppressPointerSourceForPan(String source) {
    return NativeNestedLongExpressionPanStabilityPolicy.shouldSuppressPointerSourceForPan(
      source: source,
      expression: expression,
      bundles: geometryBundles.values,
    );
  }

  bool get isPanStable => NativeSlotBoxInputSurfaceIntegrationPolicy.frameIsPanStable(this);
}
