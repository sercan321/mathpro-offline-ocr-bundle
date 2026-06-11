/// V172-Q197 — Production Surface File Separation.
///
/// The production MathLive editor implementation must live in the dedicated
/// production surface part file. The historical main editor file may keep the
/// public runtime controller and compatibility shim only; it must not contain
/// the production state implementation body.
class MathLiveProductionSurfaceFileSeparationPolicy {
  const MathLiveProductionSurfaceFileSeparationPolicy._();

  static const String phase = 'V172-Q197';
  static const String phaseName = 'Production Surface File Separation';
  static const String productionSurfacePartPath = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
  static const String compatibilityShimPath = 'lib/features/mathlive/mathlive_main_editor_surface.dart';
  static const bool productionImplementationPhysicallySeparated = true;
  static const bool compatibilityShimMayRemain = true;
  static const bool compatibilityShimMustForwardToProductionSurface = true;
  static const bool legacyStateImplementationMayReturn = false;
  static const bool fallbackOverlayMayReturn = false;
  static const bool diagnosticOverlayMayReturn = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
}
