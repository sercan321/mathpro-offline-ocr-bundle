import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/logic/math_key_inventory.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/logic/premium_math_surface_policy.dart';
import 'package:mathpro_flutter_phase17/logic/real_device_ux_readiness_gate.dart';

void main() {
  group('V154 real-device key surface QA closure', () {
    test('active metadata remains current while V154 phone-QA gate stays locked', () {
      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
      expect(MathProPackageContract.auditTitle, contains('Closure'));
      expect(MathProPackageContract.staleVersionMarkers, contains('version: 0.154.0+154'));
    });

    test('critical phone QA labels are real public UI labels and math surfaces', () {
      final missing = RealDeviceUxReadinessGate.criticalKeySurfaceLabels.difference(MathKeyInventory.publicUiLabels);
      expect(missing, isEmpty, reason: 'Every V154 QA label must be present in keyboard, MORE or long-press inventory.');

      for (final label in RealDeviceUxReadinessGate.criticalKeySurfaceLabels) {
        expect(PremiumMathSurfacePolicy.isMathSurface(label), isTrue, reason: label);
        expect(PremiumMathSurfacePolicy.moreChipMinWidth(label, compact: true), greaterThan(0), reason: label);
        expect(PremiumMathSurfacePolicy.longPressChipWidth(label), greaterThanOrEqualTo(104), reason: label);
      }
    });

    test('real-device gate requires V154 keycap, long-press and editor sweep evidence', () {
      expect(RealDeviceUxReadinessGate.version, contains('v155'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V154 critical-key surface checklist'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V154 long-press chip sweep screenshots or video'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V154 editor insertion/delete/caret sweep screenshots or video'));
      expect(RealDeviceUxReadinessGate.requiredManualScenarioIds, contains('v154-critical-keycap-surface-scan'));
      expect(RealDeviceUxReadinessGate.requiredManualScenarioIds, contains('v154-longpress-chip-surface-scan'));
      expect(RealDeviceUxReadinessGate.requiredManualScenarioIds, contains('v154-editor-insertion-roundtrip-scan'));
    });

    test('static readiness never grants fake physical-device PASS', () {
      final verdict = RealDeviceUxReadinessGate.evaluateStaticReadiness();
      expect(verdict.passClaimAllowed, isFalse);
      expect(verdict.warnings.join('\n'), contains('Static readiness is not a real-device PASS'));
      expect(MathKeyInventory.publicUiProgrammerTokenLeaks, isEmpty);
    });
  });
}
