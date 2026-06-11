import 'dart:ui';

/// Q44 renderer-sync upgrade contract for the P6-locked cursor track.
///
/// This policy is intentionally narrow: it allows the existing cursor geometry
/// engine to consume real MathJax/SVG expression-envelope telemetry when the
/// runtime WebView provides it, but it does not claim per-slot SVG identity.
/// Per-slot identity would require stable AST node ids embedded into rendered
/// MathJax output, which is outside this phase and must not be faked.
class RendererSyncUpgradePolicy {
  const RendererSyncUpgradePolicy._();

  static const String version = 'mathpro-v172q44-renderer-sync-upgrade-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool rendererExpressionEnvelopeTelemetryEnabled = true;
  static const bool rendererTelemetryCanRefineCursorGeometry = true;
  static const bool rendererPerSlotSvgIdentityClaimed = false;
  static const bool fakeRendererBoundsAllowed = false;
  static const bool fallbackMustBeExplicit = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;

  static const double maxSnapshotAgeMs = 900.0;
  static const double rendererContentClampPadding = 8.0;

  static bool snapshotIsUsable({required int nowMs, required int capturedAtMs}) {
    return nowMs - capturedAtMs <= maxSnapshotAgeMs;
  }

  static Rect inflateRendererContent(Rect rect) {
    return rect.inflate(rendererContentClampPadding);
  }
}
