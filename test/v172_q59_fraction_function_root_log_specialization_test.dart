import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/fraction_function_root_log_cursor_specialization_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q60 structural edit transaction engine', () {
    test('metadata advances to Q59 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q59 Fraction Function Root Log Specialization'));
      expect(MathProPackageContract.q59FractionFunctionRootLogSpecializationRule, contains('fraction'));
      expect(MathProPackageContract.q59FractionFunctionRootLogSpecializationRule, contains('Real-device +95 PASS remains unclaimed'));
    });

    test('policy specializes the non-integral core template families only', () {
      expect(FractionFunctionRootLogCursorSpecializationPolicy.fractionFunctionRootLogSpecializationAvailable, isTrue);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.coreTemplateLinearFallbackAllowed, isFalse);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole('fractionNumerator'), isTrue);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole('fractionDenominator'), isTrue);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole('functionArgument'), isTrue);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole('sqrtValue'), isTrue);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole('rootIndex'), isTrue);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole('logBase'), isTrue);
      expect(FractionFunctionRootLogCursorSpecializationPolicy.isSpecializedRole('integralDifferential'), isFalse);
    });

    test('active empty core-family leading rail keeps caret immediately before placeholder', () {
      const canvas = Size(360, 160);
      const placeholder = Rect.fromLTWH(110, 60, 22, 22);
      const candidate = Rect.fromLTWH(20, 20, 2, 18);
      final rect = FractionFunctionRootLogCursorSpecializationPolicy.refineLeadingRailRectForRole(
        role: 'fractionDenominator',
        candidate: candidate,
        placeholderRect: placeholder,
        canvasSize: canvas,
      );
      expect(FractionFunctionRootLogCursorSpecializationPolicy.provesPipeBoxLaw(caretRect: rect, placeholderRect: placeholder), isTrue);
    });

    test('core family hit and fallback guards make structural intent beat linear fallback', () {
      const visual = Rect.fromLTWH(80, 40, 56, 38);
      final baseHit = Rect.fromCenter(center: visual.center, width: 70, height: 70);
      final hit = FractionFunctionRootLogCursorSpecializationPolicy.refineHitRectForRole(
        role: 'functionArgument',
        visualRect: visual,
        baseHitRect: baseHit,
        canvasSize: const Size(360, 160),
      );
      expect(hit.width, greaterThan(baseHit.width));
      expect(FractionFunctionRootLogCursorSpecializationPolicy.shouldSuppressLinearFallbackForCoreRegion(
        point: visual.center,
        coreHitRects: <Rect>[hit],
      ), isTrue);
    });

    test('SlotGeometryBundle authority is wired to the Q59 core family specialization', () {
      expect(SlotGeometryBundleAuthority.version, contains('v172q59'));
      expect(SlotGeometryBundleAuthority.q59FractionFunctionRootLogSpecializationWired, isTrue);
    });
  });
}
