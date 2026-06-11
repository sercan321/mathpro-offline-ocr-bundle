import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_surface_file_separation_policy.dart';

void main() {
  test('V172-Q197 production surface implementation is physically separated', () {
    expect(MathLiveProductionSurfaceFileSeparationPolicy.phase, 'V172-Q197');
    expect(MathLiveProductionSurfaceFileSeparationPolicy.productionImplementationPhysicallySeparated, isTrue);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.productionSurfacePartPath, 'lib/features/mathlive/mathlive_production_editor_surface.dart');
    expect(MathLiveProductionSurfaceFileSeparationPolicy.compatibilityShimMustForwardToProductionSurface, isTrue);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.legacyStateImplementationMayReturn, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.fallbackOverlayMayReturn, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.diagnosticOverlayMayReturn, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.moreInventoryMutationAllowed, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.longPressMutationAllowed, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.graphUiMutationAllowed, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.historyPanelMutationAllowed, isFalse);
    expect(MathLiveProductionSurfaceFileSeparationPolicy.solutionStepsPanelMutationAllowed, isFalse);
  });
}
