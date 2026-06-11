import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/formula_engine/native_slotbox_input_surface_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_hit_testing.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_intent_resolver_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q71 Native SlotBox Input Surface Foundation', () {
    test('package identity advances to Q71 without claiming device PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q71'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.q71NativeSlotBoxInputSurfaceRule, contains('|□'));
      expect(NativeSlotBoxInputSurfacePolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeSlotBoxInputSurfacePolicy.fullNativeMathRendererClaimed, isFalse);
    });

    test('nearest structural guessing is disabled at the cursor policy level', () {
      expect(NativeSlotBoxInputSurfacePolicy.nativeSlotBoxInputSurfaceAvailable, isTrue);
      expect(NativeSlotBoxInputSurfacePolicy.nearestStructuralFallbackAllowed, isFalse);
      expect(SlotHitTesting.nativeSlotBoxExactHitOnly, isTrue);
      expect(SlotHitTesting.nearestFallbackSelectionEnabled, isFalse);
      expect(StructuralIntentResolverPolicy.structuralNearestHitEnabled, isFalse);
      expect(StructuralIntentResolverPolicy.templateRegionInflate, 0.0);
    });

    test('legacy linear placeholder fallback is blocked once geometry exists', () {
      expect(
        NativeSlotBoxInputSurfacePolicy.allowLegacyLinearPlaceholderFallback(
          structuralInteractionEnabled: true,
          geometryBundleCount: 1,
        ),
        isFalse,
      );
      expect(
        NativeSlotBoxInputSurfacePolicy.allowLegacyLinearPlaceholderFallback(
          structuralInteractionEnabled: true,
          geometryBundleCount: 0,
        ),
        isTrue,
      );
      expect(
        NativeSlotBoxInputSurfacePolicy.allowLegacyLinearPlaceholderFallback(
          structuralInteractionEnabled: false,
          geometryBundleCount: 0,
        ),
        isFalse,
      );
    });

    test('protected UI mutation gates stay closed', () {
      expect(NativeSlotBoxInputSurfacePolicy.cursorOnlyChange, isTrue);
      expect(NativeSlotBoxInputSurfacePolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfacePolicy.moreSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfacePolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfacePolicy.appShellMutationAllowed, isFalse);
      expect(NativeSlotBoxInputSurfacePolicy.graphHistorySolutionMutationAllowed, isFalse);
    });
  });
}
