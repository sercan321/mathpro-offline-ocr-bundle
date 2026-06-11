import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/legacy_cursor_freeze_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q81 legacy cursor freeze architecture lock', () {
    test('freezes the Flutter SlotBox cursor stack as fallback instead of deleting it', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q81LegacyCursorFreezeRule, contains('LegacyFlutterSlotEditor'));
      expect(LegacyCursorFreezePolicy.legacyEngineName, 'LegacyFlutterSlotEditor');
      expect(LegacyCursorFreezePolicy.legacyCursorEngineDeleted, isFalse);
      expect(LegacyCursorFreezePolicy.legacyCursorEngineFrozenAsFallback, isTrue);
      expect(LegacyCursorFreezePolicy.legacyCursorEnginePrimaryFutureDirection, isFalse);
      expect(LegacyCursorFreezePolicy.newLargeFlutterCursorPatchAllowed, isFalse);
    });

    test('protects keyboard and premium app surfaces during the engine transition', () {
      expect(LegacyCursorFreezePolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(LegacyCursorFreezePolicy.moreSurfaceMutationAllowed, isFalse);
      expect(LegacyCursorFreezePolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(LegacyCursorFreezePolicy.appShellMutationAllowed, isFalse);
      expect(LegacyCursorFreezePolicy.graphHistorySolutionMutationAllowed, isFalse);
      expect(LegacyCursorFreezePolicy.solutionPanelMutationAllowed, isFalse);
      expect(LegacyCursorFreezePolicy.mathLiveVirtualKeyboardMayReplaceMathProKeyboard, isFalse);
      expect(LegacyCursorFreezePolicy.cdnDependencyAllowedForMathLive, isFalse);
    });

    test('requires adapter plus offline lab plus real-device court before any MathLive switch', () {
      expect(
        LegacyCursorFreezePolicy.maySwitchMainEditorToMathLive(
          adapterContractExists: false,
          offlineLabPasses: true,
          realDeviceCourtPasses: true,
          protectedSurfacesUnchanged: true,
        ),
        isFalse,
      );
      expect(
        LegacyCursorFreezePolicy.maySwitchMainEditorToMathLive(
          adapterContractExists: true,
          offlineLabPasses: true,
          realDeviceCourtPasses: false,
          protectedSurfacesUnchanged: true,
        ),
        isFalse,
      );
      expect(
        LegacyCursorFreezePolicy.maySwitchMainEditorToMathLive(
          adapterContractExists: true,
          offlineLabPasses: true,
          realDeviceCourtPasses: true,
          protectedSurfacesUnchanged: false,
        ),
        isFalse,
      );
      expect(
        LegacyCursorFreezePolicy.maySwitchMainEditorToMathLive(
          adapterContractExists: true,
          offlineLabPasses: true,
          realDeviceCourtPasses: true,
          protectedSurfacesUnchanged: true,
        ),
        isTrue,
      );
    });

    test('does not claim Flutter, MathLive, Photomath, or real-device PASS', () {
      expect(LegacyCursorFreezePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(LegacyCursorFreezePolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(LegacyCursorFreezePolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(LegacyCursorFreezePolicy.realDeviceMathLivePassClaimed, isFalse);
      expect(LegacyCursorFreezePolicy.photomathLevelClaimAllowedWithoutEvidence, isFalse);
    });
  });
}
