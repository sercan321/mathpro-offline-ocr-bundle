/// V172-Q71 Native SlotBox input surface foundation.
///
/// This policy is deliberately cursor/editor-only. It does not modify keyboard,
/// MORE, long-press, app shell, Graph, History, Solution, or visible key faces.
///
/// Product law for Q71:
/// - Structural cursor selection must be driven by the authoritative SlotBox /
///   SlotGeometryBundle hitRect.
/// - Nearest-distance structural fallback is not allowed.
/// - Legacy linear placeholder fallback is not allowed while real geometry
///   bundles exist, because that path guesses by placeholder order and X
///   distance instead of selecting a measured slotId.
/// - Empty structural slots still render from the leading rail as |□.
class NativeSlotBoxInputSurfacePolicy {
  const NativeSlotBoxInputSurfacePolicy._();

  static const String version =
      'mathpro-v172q71-native-slotbox-input-surface-foundation-exact-slotid-routing';

  static const bool nativeSlotBoxInputSurfaceAvailable = true;
  static const bool cursorOnlyChange = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const bool nearestStructuralFallbackAllowed = false;
  static const bool legacyLinearPlaceholderFallbackAllowedWithGeometry = false;
  static const bool authoritativeHitRectRequired = true;
  static const bool emptySlotExclusiveLeadingCaret = true;
  static const String emptySlotCaretLaw = '|□';

  static bool allowLegacyLinearPlaceholderFallback({
    required bool structuralInteractionEnabled,
    required int geometryBundleCount,
  }) {
    if (!structuralInteractionEnabled) return false;
    // Legacy fallback is allowed only for truly legacy/no-geometry surfaces.
    // Once a SlotGeometryBundle exists, routing must be exact SlotBox routing.
    return geometryBundleCount <= 0;
  }
}
