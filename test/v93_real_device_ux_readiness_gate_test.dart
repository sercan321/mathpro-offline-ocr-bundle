import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/features/formula_engine/real_device_slot_test_protocol.dart';
import 'package:mathpro_flutter_phase17/logic/real_device_ux_readiness_gate.dart';

void main() {
  group('MathPro V93 real-device UX readiness gate', () {
    test('defines real-device evidence requirements without claiming PASS', () {
      expect(RealDeviceUxReadinessGate.version, contains('real-device-ux-readiness-gate'));
      expect(RealDeviceUxReadinessGate.targetDeviceId, '23106RN0DA');
      expect(RealDeviceUxReadinessGate.requiredAttemptsPerScenario, 10);
      expect(RealDeviceUxReadinessGate.requiredCorrectPerScenario, 9);
      expect(RealDeviceUxReadinessGate.requiredOverallSuccessRate, 0.90);
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('flutter run -d 23106RN0DA launch evidence'));

      final staticVerdict = RealDeviceUxReadinessGate.evaluateStaticReadiness();
      expect(staticVerdict.passClaimAllowed, isFalse);
      expect(staticVerdict.warnings.join(' '), contains('not a real-device PASS'));
    });

    test('extends the older slot protocol with premium UX scenarios', () {
      final legacyIds = RealDeviceSlotTestProtocol.scenarios.map((scenario) => scenario.id).toSet();
      final allIds = RealDeviceUxReadinessGate.requiredManualScenarioIds;

      expect(allIds.containsAll(legacyIds), isTrue);
      expect(allIds, contains('log-longpress-premium-visual'));
      expect(allIds, contains('trig-inverse-display-no-raw-token'));
      expect(allIds, contains('subscript-slot-real-editing'));
      expect(allIds, contains('more-full-surface-premium-scan'));
      expect(allIds, contains('android-navbar-keyboard-clearance'));
      expect(allIds, contains('long-expression-pan-caret-follow-device'));
    });

    test('blocks manual PASS when screenshots, logs or scenario evidence are missing', () {
      final report = RealDeviceSlotTestReport(
        flutterCommandsPassed: false,
        evidenceAttached: false,
        results: <ManualSlotScenarioResult>[
          for (final scenario in RealDeviceSlotTestProtocol.scenarios)
            ManualSlotScenarioResult(scenarioId: scenario.id, correctAttempts: 10),
        ],
      );

      final verdict = RealDeviceUxReadinessGate.evaluateManualEvidence(
        slotReport: report,
        completedAdditionalScenarioIds: const <String>{},
        attachedEvidenceItems: const <String>{},
        noDebugLeakConfirmed: false,
        keyboardTopologyConfirmed: false,
        moreSurfaceScanConfirmed: false,
      );

      expect(verdict.passClaimAllowed, isFalse);
      expect(verdict.blockers.join('\n'), contains('Flutter command evidence'));
      expect(verdict.blockers.join('\n'), contains('Missing V93 manual UX scenarios'));
      expect(verdict.blockers.join('\n'), contains('Missing required real-device evidence'));
      expect(verdict.blockers.join('\n'), contains('No-debug-leak'));
    });

    test('allows PASS claim only when static preflight and manual evidence are complete', () {
      final report = RealDeviceSlotTestReport(
        flutterCommandsPassed: true,
        evidenceAttached: true,
        results: <ManualSlotScenarioResult>[
          for (final scenario in RealDeviceSlotTestProtocol.scenarios)
            ManualSlotScenarioResult(scenarioId: scenario.id, correctAttempts: 10),
        ],
      );

      final verdict = RealDeviceUxReadinessGate.evaluateManualEvidence(
        slotReport: report,
        completedAdditionalScenarioIds: <String>{
          for (final scenario in RealDeviceUxReadinessGate.additionalManualScenarios) scenario.id,
        },
        attachedEvidenceItems: RealDeviceUxReadinessGate.requiredEvidenceItems.toSet(),
        noDebugLeakConfirmed: true,
        keyboardTopologyConfirmed: true,
        moreSurfaceScanConfirmed: true,
      );

      if (RealDeviceUxReadinessGate.staticPreflightBlockers().isEmpty) {
        expect(verdict.passClaimAllowed, isTrue);
      } else {
        expect(verdict.passClaimAllowed, isFalse);
        expect(verdict.blockers, isNotEmpty);
      }
    });
  });
}
